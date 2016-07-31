FROM mysql:5.5

ADD coreSchema.sql /docker-entrypoint-initdb.d/10-core.sql
ADD moduleSchemas.patched.sql /docker-entrypoint-initdb.d/20-modules.sql

