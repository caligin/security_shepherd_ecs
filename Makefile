src_dir:=src/
tpl_dir:=tpl/
-include $(src_dir)config.mk
src_files:=$(addprefix $(src_dir),authorized_keys config.mk)
build_dir:=build/
bastion_build_dir:=build/bastion/
bastion_image_name:=shepherd_bastion
docker_repo_prefix?=localhost/

.PHONY: clean distclean nuke bastion init


init: $(src_files)

$(src_dir):
	mkdir -p $(src_dir)

$(src_dir)%: $(tpl_dir)% $(src_dir)
	cp $< $@

$(build_dir):
	mkdir -p $(build_dir)

$(build_dir)%/:
	mkdir -p $@

$(build_dir)%/Dockerfile: %.Dockerfile $(build_dir)%/
	cp $< $@

$(bastion_build_dir)authorized_keys:
	cp $(src_dir)authorized_keys $@

bastion: $(bastion_build_dir)Dockerfile $(bastion_build_dir)authorized_keys
	docker build -t $(bastion_image_name) $(bastion_build_dir)
	docker tag $(bastion_image_name):latest $(docker_repo_prefix)$(bastion_image_name):latest

clean:
	rm -rf $(bastion_build_dir)

distclean:
	rm -rf $(build_dir)

nuke:
	rm -rf $(build_dir) $(src_dir)
