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

CREATE TABLE IF NOT EXISTS schema.price_list
(
    id bigint NOT NULL DEFAULT nextval('schema.treatments_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    price numeric NOT NULL,
    CONSTRAINT treatments_pkey PRIMARY KEY (id)
)

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS schema.price_list
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS schema.people
(
    id bigint NOT NULL DEFAULT nextval('schema.people_id_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    surname character varying COLLATE pg_catalog."default" NOT NULL,
    role integer NOT NULL,
    phone_number character varying COLLATE pg_catalog."default",
    CONSTRAINT people_pkey PRIMARY KEY (id),
    CONSTRAINT role FOREIGN KEY (role)
        REFERENCES schema.roles (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS schema.people
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS schema.pets
(
    id bigint NOT NULL DEFAULT nextval('schema.pets_id_seq'::regclass),
    name character varying COLLATE pg_catalog."default",
    type character varying COLLATE pg_catalog."default" NOT NULL,
    breed character varying COLLATE pg_catalog."default",
    owner_id integer,
    CONSTRAINT pets_pkey PRIMARY KEY (id),
    CONSTRAINT owner FOREIGN KEY (owner_id)
        REFERENCES schema.people (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS schema.pets
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS schema.treatments_story
(
    id bigint NOT NULL DEFAULT nextval('schema.treatments_story_id_seq'::regclass),
    treatment_id integer NOT NULL,
    pet_id integer NOT NULL,
    treatment_time timestamp(0) without time zone NOT NULL,
    CONSTRAINT treatments_story_pkey PRIMARY KEY (id),
    CONSTRAINT pet_id FOREIGN KEY (pet_id)
        REFERENCES schema.pets (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT treatment_id FOREIGN KEY (treatment_id)
        REFERENCES schema.price_list (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS schema.treatments_story
    OWNER to postgres;