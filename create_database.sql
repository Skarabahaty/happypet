CREATE DATABASE happypet
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE SCHEMA IF NOT EXISTS schema
    AUTHORIZATION postgres;

GRANT ALL ON SCHEMA schema TO PUBLIC;
GRANT ALL ON SCHEMA schema TO postgres;


CREATE TABLE IF NOT EXISTS schema.roles
(
    id bigint NOT NULL DEFAULT nextval('roles_id_seq'::regclass),
    role character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT roles_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS schema.roles
    OWNER to postgres;
	
CREATE TABLE IF NOT EXISTS schema.treatments
(
    id bigint NOT NULL DEFAULT nextval('treatments_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    price numeric NOT NULL,
    CONSTRAINT treatments_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS schema.treatments
    OWNER to postgres;