\set dbName "classroom"
\set dbUser "u-classroom"
\set dbPwd "p-classroom"

CREATE DATABASE :dbName WITH OWNER postgres;
\connect :dbName

CREATE extension "uuid-ossp" WITH SCHEMA public;

DROP TABLE IF EXISTS public.classroom;

CREATE TABLE IF NOT EXISTS public.classroom
(
    id uuid NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    created_date timestamp without time zone,
    last_modified_date timestamp without time zone,
    CONSTRAINT classroom_pkey PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.student;

CREATE TABLE IF NOT EXISTS public.student
(
    id uuid NOT NULL,
    classroom_id uuid NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    created_date timestamp without time zone NOT NULL,
    last_modified_date timestamp without time zone NOT NULL,
    CONSTRAINT student_pkey PRIMARY KEY (id),
    CONSTRAINT classroom_id FOREIGN KEY (classroom_id)
        REFERENCES public.classroom (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

DROP TABLE IF EXISTS public.teacher;

CREATE TABLE IF NOT EXISTS public.teacher
(
    id uuid NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    classroom_id uuid,
    created_date timestamp without time zone NOT NULL,
    last_modified_date timestamp without time zone NOT NULL,
    CONSTRAINT teacher_pkey PRIMARY KEY (id),
    CONSTRAINT classroom_id FOREIGN KEY (classroom_id)
        REFERENCES public.classroom (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);