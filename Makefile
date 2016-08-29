src_dir:=src/
tpl_dir:=tpl/
-include $(src_dir)config.mk
src_files:=$(addprefix $(src_dir),authorized_keys config.mk)
build_dir:=build/
bastion_build_dir:=build/bastion/
bastion_image_name:=shepherd_bastion
database_build_dir:=build/database/
database_image_name:=shepherd_database
app_build_dir:=build/app/
app_image_name:=shepherd_app
docker_repo_prefix?=localhost/
package_download_url:=https://github.com/OWASP/SecurityShepherd/releases/download/v3.0/owaspSecurityShepherd_V3.0.Manual.Pack.zip
package_name:=owaspSecurityShepherd_V3.0.Manual.Pack.zip


.PHONY: clean containers distclean nuke init bastion database app
.PRECIOUS: $(bastion_build_dir) $(database_build_dir) $(app_build_dir)

containers: bastion database app

init: $(src_files)

$(src_dir):
	mkdir -p $(src_dir)

$(src_dir)%: $(tpl_dir)% | $(src_dir)
	cp $< $@

$(build_dir):
	mkdir -p $(build_dir)

$(build_dir)%/:
	mkdir -p $@

$(build_dir)%/Dockerfile: %.Dockerfile $(build_dir)%/
	cp $< $@

$(bastion_build_dir)authorized_keys: $(src_dir)authorized_keys
	cp $< $@

bastion: $(bastion_build_dir)Dockerfile $(bastion_build_dir)authorized_keys
	docker build -t $(bastion_image_name) $(bastion_build_dir)
	docker tag $(bastion_image_name):latest $(docker_repo_prefix)$(bastion_image_name):latest

$(build_dir)$(package_name):
	wget -O $@ $(package_download_url)

$(database_build_dir)coreSchema.sql: $(build_dir)$(package_name)
	unzip -B -d $(database_build_dir) $< coreSchema.sql

$(database_build_dir)moduleSchemas.sql: $(build_dir)$(package_name)
	unzip -B -d $(database_build_dir) $< moduleSchemas.sql

$(database_build_dir)moduleSchemas.patched.sql: $(database_build_dir)moduleSchemas.sql
	cat $< | sed "s/@'localhost'/@'%'/g" > $@

database: $(database_build_dir)Dockerfile $(database_build_dir)coreSchema.sql $(database_build_dir)moduleSchemas.patched.sql
	docker build -t $(database_image_name) $(database_build_dir)
	docker tag $(database_image_name):latest $(docker_repo_prefix)$(database_image_name):latest

$(app_build_dir)ROOT.war: $(build_dir)$(package_name)
	unzip -B -d $(app_build_dir) $< ROOT.war

$(app_build_dir)database.properties: database.properties
	cp $< $@

$(app_build_dir)server.xml: server.xml
	cp $< $@

app: $(app_build_dir)Dockerfile $(app_build_dir)ROOT.war $(app_build_dir)database.properties $(app_build_dir)server.xml
	docker build -t $(app_image_name) $(app_build_dir)
	docker tag $(app_image_name):latest $(docker_repo_prefix)$(app_image_name):latest

clean:
	rm -rf $(bastion_build_dir)

distclean:
	rm -rf $(build_dir)

nuke:
	rm -rf $(build_dir) $(src_dir)
