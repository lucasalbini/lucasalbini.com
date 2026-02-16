--
-- PostgreSQL database dump
--

\restrict pARsZdHYu9w13haUAsNTC9wF3fneU439sMJv1HyS9TakKdpeLfJWP7l6gSJ3IY9

-- Dumped from database version 16.12
-- Dumped by pg_dump version 16.12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    action_parameters jsonb,
    subject character varying(255),
    properties jsonb,
    conditions jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.admin_permissions OWNER TO strapi;

--
-- Name: admin_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_permissions_id_seq OWNER TO strapi;

--
-- Name: admin_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_permissions_id_seq OWNED BY public.admin_permissions.id;


--
-- Name: admin_permissions_role_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_permissions_role_lnk (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_ord double precision
);


ALTER TABLE public.admin_permissions_role_lnk OWNER TO strapi;

--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_permissions_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_permissions_role_lnk_id_seq OWNER TO strapi;

--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_permissions_role_lnk_id_seq OWNED BY public.admin_permissions_role_lnk.id;


--
-- Name: admin_roles; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_roles (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    code character varying(255),
    description character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.admin_roles OWNER TO strapi;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_roles_id_seq OWNER TO strapi;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    document_id character varying(255),
    firstname character varying(255),
    lastname character varying(255),
    username character varying(255),
    email character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    registration_token character varying(255),
    is_active boolean,
    blocked boolean,
    prefered_language character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.admin_users OWNER TO strapi;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_users_id_seq OWNER TO strapi;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: admin_users_roles_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_users_roles_lnk (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    role_ord double precision,
    user_ord double precision
);


ALTER TABLE public.admin_users_roles_lnk OWNER TO strapi;

--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_users_roles_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_users_roles_lnk_id_seq OWNER TO strapi;

--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_users_roles_lnk_id_seq OWNED BY public.admin_users_roles_lnk.id;


--
-- Name: certifications; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.certifications (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    issuer character varying(255),
    issue_date date,
    credential_url character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.certifications OWNER TO strapi;

--
-- Name: certifications_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.certifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.certifications_id_seq OWNER TO strapi;

--
-- Name: certifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.certifications_id_seq OWNED BY public.certifications.id;


--
-- Name: components_shared_positions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_shared_positions (
    id integer NOT NULL,
    designation character varying(255),
    start_date date,
    end_date date,
    is_current boolean
);


ALTER TABLE public.components_shared_positions OWNER TO strapi;

--
-- Name: components_shared_positions_cmps; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_shared_positions_cmps (
    id integer NOT NULL,
    entity_id integer,
    cmp_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.components_shared_positions_cmps OWNER TO strapi;

--
-- Name: components_shared_positions_cmps_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_shared_positions_cmps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.components_shared_positions_cmps_id_seq OWNER TO strapi;

--
-- Name: components_shared_positions_cmps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_shared_positions_cmps_id_seq OWNED BY public.components_shared_positions_cmps.id;


--
-- Name: components_shared_positions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_shared_positions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.components_shared_positions_id_seq OWNER TO strapi;

--
-- Name: components_shared_positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_shared_positions_id_seq OWNED BY public.components_shared_positions.id;


--
-- Name: components_shared_responsibilities; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_shared_responsibilities (
    id integer NOT NULL,
    description text
);


ALTER TABLE public.components_shared_responsibilities OWNER TO strapi;

--
-- Name: components_shared_responsibilities_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_shared_responsibilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.components_shared_responsibilities_id_seq OWNER TO strapi;

--
-- Name: components_shared_responsibilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_shared_responsibilities_id_seq OWNED BY public.components_shared_responsibilities.id;


--
-- Name: components_shared_social_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_shared_social_links (
    id integer NOT NULL,
    platform character varying(255),
    url character varying(255),
    icon_name character varying(255)
);


ALTER TABLE public.components_shared_social_links OWNER TO strapi;

--
-- Name: components_shared_social_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_shared_social_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.components_shared_social_links_id_seq OWNER TO strapi;

--
-- Name: components_shared_social_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_shared_social_links_id_seq OWNED BY public.components_shared_social_links.id;


--
-- Name: components_shared_soft_skills; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_shared_soft_skills (
    id integer NOT NULL,
    name character varying(255),
    level integer
);


ALTER TABLE public.components_shared_soft_skills OWNER TO strapi;

--
-- Name: components_shared_soft_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_shared_soft_skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.components_shared_soft_skills_id_seq OWNER TO strapi;

--
-- Name: components_shared_soft_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_shared_soft_skills_id_seq OWNED BY public.components_shared_soft_skills.id;


--
-- Name: educations; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.educations (
    id integer NOT NULL,
    document_id character varying(255),
    institution character varying(255),
    degree character varying(255),
    field_of_study character varying(255),
    start_date date,
    end_date date,
    description text,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.educations OWNER TO strapi;

--
-- Name: educations_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.educations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.educations_id_seq OWNER TO strapi;

--
-- Name: educations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.educations_id_seq OWNED BY public.educations.id;


--
-- Name: experiences; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.experiences (
    id integer NOT NULL,
    document_id character varying(255),
    company_name character varying(255),
    company_url character varying(255),
    company_location character varying(255),
    "order" integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.experiences OWNER TO strapi;

--
-- Name: experiences_cmps; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.experiences_cmps (
    id integer NOT NULL,
    entity_id integer,
    cmp_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.experiences_cmps OWNER TO strapi;

--
-- Name: experiences_cmps_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.experiences_cmps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.experiences_cmps_id_seq OWNER TO strapi;

--
-- Name: experiences_cmps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.experiences_cmps_id_seq OWNED BY public.experiences_cmps.id;


--
-- Name: experiences_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.experiences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.experiences_id_seq OWNER TO strapi;

--
-- Name: experiences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.experiences_id_seq OWNED BY public.experiences.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.files (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    alternative_text text,
    caption text,
    focal_point jsonb,
    width integer,
    height integer,
    formats jsonb,
    hash character varying(255),
    ext character varying(255),
    mime character varying(255),
    size numeric(10,2),
    url text,
    preview_url text,
    provider character varying(255),
    provider_metadata jsonb,
    folder_path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.files OWNER TO strapi;

--
-- Name: files_folder_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.files_folder_lnk (
    id integer NOT NULL,
    file_id integer,
    folder_id integer,
    file_ord double precision
);


ALTER TABLE public.files_folder_lnk OWNER TO strapi;

--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.files_folder_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.files_folder_lnk_id_seq OWNER TO strapi;

--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.files_folder_lnk_id_seq OWNED BY public.files_folder_lnk.id;


--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.files_id_seq OWNER TO strapi;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: files_related_mph; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.files_related_mph (
    id integer NOT NULL,
    file_id integer,
    related_id integer,
    related_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.files_related_mph OWNER TO strapi;

--
-- Name: files_related_mph_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.files_related_mph_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.files_related_mph_id_seq OWNER TO strapi;

--
-- Name: files_related_mph_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.files_related_mph_id_seq OWNED BY public.files_related_mph.id;


--
-- Name: i18n_locale; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.i18n_locale (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.i18n_locale OWNER TO strapi;

--
-- Name: i18n_locale_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.i18n_locale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.i18n_locale_id_seq OWNER TO strapi;

--
-- Name: i18n_locale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    document_id character varying(255),
    title character varying(255),
    slug character varying(255),
    content text,
    excerpt text,
    author character varying(255),
    categories jsonb,
    tags jsonb,
    featured boolean,
    reading_time integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.posts OWNER TO strapi;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO strapi;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.profiles (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    designation character varying(255),
    company character varying(255),
    location character varying(255),
    summary text,
    typing_titles jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.profiles OWNER TO strapi;

--
-- Name: profiles_cmps; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.profiles_cmps (
    id integer NOT NULL,
    entity_id integer,
    cmp_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.profiles_cmps OWNER TO strapi;

--
-- Name: profiles_cmps_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.profiles_cmps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profiles_cmps_id_seq OWNER TO strapi;

--
-- Name: profiles_cmps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.profiles_cmps_id_seq OWNED BY public.profiles_cmps.id;


--
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profiles_id_seq OWNER TO strapi;

--
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.profiles_id_seq OWNED BY public.profiles.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    slug character varying(255),
    description text,
    role character varying(255),
    timeline character varying(255),
    repo_url character varying(255),
    demo_url character varying(255),
    tags jsonb,
    category character varying(255),
    featured boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.projects OWNER TO strapi;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_id_seq OWNER TO strapi;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: publications; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.publications (
    id integer NOT NULL,
    document_id character varying(255),
    title character varying(255),
    journal character varying(255),
    authors text,
    date date,
    url character varying(255),
    doi character varying(255),
    abstract text,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.publications OWNER TO strapi;

--
-- Name: publications_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.publications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publications_id_seq OWNER TO strapi;

--
-- Name: publications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.publications_id_seq OWNED BY public.publications.id;


--
-- Name: skills; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.skills (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    icon_name character varying(255),
    summary text,
    category character varying(255),
    url character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.skills OWNER TO strapi;

--
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skills_id_seq OWNER TO strapi;

--
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;


--
-- Name: strapi_ai_localization_jobs; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_ai_localization_jobs (
    id integer NOT NULL,
    content_type character varying(255) NOT NULL,
    related_document_id character varying(255) NOT NULL,
    source_locale character varying(255) NOT NULL,
    target_locales jsonb NOT NULL,
    status character varying(255) NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone
);


ALTER TABLE public.strapi_ai_localization_jobs OWNER TO strapi;

--
-- Name: strapi_ai_localization_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_ai_localization_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_ai_localization_jobs_id_seq OWNER TO strapi;

--
-- Name: strapi_ai_localization_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_ai_localization_jobs_id_seq OWNED BY public.strapi_ai_localization_jobs.id;


--
-- Name: strapi_ai_metadata_jobs; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_ai_metadata_jobs (
    id integer NOT NULL,
    status character varying(255) NOT NULL,
    created_at timestamp(6) without time zone,
    completed_at timestamp(6) without time zone
);


ALTER TABLE public.strapi_ai_metadata_jobs OWNER TO strapi;

--
-- Name: strapi_ai_metadata_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_ai_metadata_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_ai_metadata_jobs_id_seq OWNER TO strapi;

--
-- Name: strapi_ai_metadata_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_ai_metadata_jobs_id_seq OWNED BY public.strapi_ai_metadata_jobs.id;


--
-- Name: strapi_api_token_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_api_token_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_api_token_permissions OWNER TO strapi;

--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_api_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNER TO strapi;

--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;


--
-- Name: strapi_api_token_permissions_token_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_api_token_permissions_token_lnk (
    id integer NOT NULL,
    api_token_permission_id integer,
    api_token_id integer,
    api_token_permission_ord double precision
);


ALTER TABLE public.strapi_api_token_permissions_token_lnk OWNER TO strapi;

--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_api_token_permissions_token_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_api_token_permissions_token_lnk_id_seq OWNER TO strapi;

--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_api_token_permissions_token_lnk_id_seq OWNED BY public.strapi_api_token_permissions_token_lnk.id;


--
-- Name: strapi_api_tokens; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_api_tokens (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    type character varying(255),
    access_key character varying(255),
    encrypted_key text,
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_api_tokens OWNER TO strapi;

--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNER TO strapi;

--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;


--
-- Name: strapi_core_store_settings; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_core_store_settings (
    id integer NOT NULL,
    key character varying(255),
    value text,
    type character varying(255),
    environment character varying(255),
    tag character varying(255)
);


ALTER TABLE public.strapi_core_store_settings OWNER TO strapi;

--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_core_store_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNER TO strapi;

--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;


--
-- Name: strapi_database_schema; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_database_schema (
    id integer NOT NULL,
    schema json,
    "time" timestamp without time zone,
    hash character varying(255)
);


ALTER TABLE public.strapi_database_schema OWNER TO strapi;

--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_database_schema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_database_schema_id_seq OWNER TO strapi;

--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;


--
-- Name: strapi_history_versions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_history_versions (
    id integer NOT NULL,
    content_type character varying(255) NOT NULL,
    related_document_id character varying(255),
    locale character varying(255),
    status character varying(255),
    data jsonb,
    schema jsonb,
    created_at timestamp(6) without time zone,
    created_by_id integer
);


ALTER TABLE public.strapi_history_versions OWNER TO strapi;

--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_history_versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_history_versions_id_seq OWNER TO strapi;

--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_history_versions_id_seq OWNED BY public.strapi_history_versions.id;


--
-- Name: strapi_migrations; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_migrations (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


ALTER TABLE public.strapi_migrations OWNER TO strapi;

--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_migrations_id_seq OWNER TO strapi;

--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;


--
-- Name: strapi_migrations_internal; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_migrations_internal (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


ALTER TABLE public.strapi_migrations_internal OWNER TO strapi;

--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_migrations_internal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_migrations_internal_id_seq OWNER TO strapi;

--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_migrations_internal_id_seq OWNED BY public.strapi_migrations_internal.id;


--
-- Name: strapi_release_actions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_release_actions (
    id integer NOT NULL,
    document_id character varying(255),
    type character varying(255),
    content_type character varying(255),
    entry_document_id character varying(255),
    locale character varying(255),
    is_entry_valid boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_release_actions OWNER TO strapi;

--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_release_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_release_actions_id_seq OWNER TO strapi;

--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_release_actions_id_seq OWNED BY public.strapi_release_actions.id;


--
-- Name: strapi_release_actions_release_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_release_actions_release_lnk (
    id integer NOT NULL,
    release_action_id integer,
    release_id integer,
    release_action_ord double precision
);


ALTER TABLE public.strapi_release_actions_release_lnk OWNER TO strapi;

--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_release_actions_release_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_release_actions_release_lnk_id_seq OWNER TO strapi;

--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_release_actions_release_lnk_id_seq OWNED BY public.strapi_release_actions_release_lnk.id;


--
-- Name: strapi_releases; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_releases (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    released_at timestamp(6) without time zone,
    scheduled_at timestamp(6) without time zone,
    timezone character varying(255),
    status character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_releases OWNER TO strapi;

--
-- Name: strapi_releases_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_releases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_releases_id_seq OWNER TO strapi;

--
-- Name: strapi_releases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_releases_id_seq OWNED BY public.strapi_releases.id;


--
-- Name: strapi_sessions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_sessions (
    id integer NOT NULL,
    document_id character varying(255),
    user_id character varying(255),
    session_id character varying(255),
    child_id character varying(255),
    device_id character varying(255),
    origin character varying(255),
    expires_at timestamp(6) without time zone,
    absolute_expires_at timestamp(6) without time zone,
    status character varying(255),
    type character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_sessions OWNER TO strapi;

--
-- Name: strapi_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_sessions_id_seq OWNER TO strapi;

--
-- Name: strapi_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_sessions_id_seq OWNED BY public.strapi_sessions.id;


--
-- Name: strapi_transfer_token_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_transfer_token_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_transfer_token_permissions OWNER TO strapi;

--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNER TO strapi;

--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;


--
-- Name: strapi_transfer_token_permissions_token_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_transfer_token_permissions_token_lnk (
    id integer NOT NULL,
    transfer_token_permission_id integer,
    transfer_token_id integer,
    transfer_token_permission_ord double precision
);


ALTER TABLE public.strapi_transfer_token_permissions_token_lnk OWNER TO strapi;

--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_token_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_transfer_token_permissions_token_lnk_id_seq OWNER TO strapi;

--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_token_lnk_id_seq OWNED BY public.strapi_transfer_token_permissions_token_lnk.id;


--
-- Name: strapi_transfer_tokens; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_transfer_tokens (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_transfer_tokens OWNER TO strapi;

--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_transfer_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNER TO strapi;

--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;


--
-- Name: strapi_webhooks; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_webhooks (
    id integer NOT NULL,
    name character varying(255),
    url text,
    headers jsonb,
    events jsonb,
    enabled boolean
);


ALTER TABLE public.strapi_webhooks OWNER TO strapi;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_webhooks_id_seq OWNER TO strapi;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;


--
-- Name: strapi_workflows; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_workflows (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    content_types jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_workflows OWNER TO strapi;

--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_workflows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_workflows_id_seq OWNER TO strapi;

--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_workflows_id_seq OWNED BY public.strapi_workflows.id;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_workflows_stage_required_to_publish_lnk (
    id integer NOT NULL,
    workflow_id integer,
    workflow_stage_id integer
);


ALTER TABLE public.strapi_workflows_stage_required_to_publish_lnk OWNER TO strapi;

--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_workflows_stage_required_to_publish_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_workflows_stage_required_to_publish_lnk_id_seq OWNER TO strapi;

--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_workflows_stage_required_to_publish_lnk_id_seq OWNED BY public.strapi_workflows_stage_required_to_publish_lnk.id;


--
-- Name: strapi_workflows_stages; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_workflows_stages (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    color character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_workflows_stages OWNER TO strapi;

--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_workflows_stages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_workflows_stages_id_seq OWNER TO strapi;

--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_workflows_stages_id_seq OWNED BY public.strapi_workflows_stages.id;


--
-- Name: strapi_workflows_stages_permissions_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_workflows_stages_permissions_lnk (
    id integer NOT NULL,
    workflow_stage_id integer,
    permission_id integer,
    permission_ord double precision
);


ALTER TABLE public.strapi_workflows_stages_permissions_lnk OWNER TO strapi;

--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_workflows_stages_permissions_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_workflows_stages_permissions_lnk_id_seq OWNER TO strapi;

--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_workflows_stages_permissions_lnk_id_seq OWNED BY public.strapi_workflows_stages_permissions_lnk.id;


--
-- Name: strapi_workflows_stages_workflow_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_workflows_stages_workflow_lnk (
    id integer NOT NULL,
    workflow_stage_id integer,
    workflow_id integer,
    workflow_stage_ord double precision
);


ALTER TABLE public.strapi_workflows_stages_workflow_lnk OWNER TO strapi;

--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_workflows_stages_workflow_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.strapi_workflows_stages_workflow_lnk_id_seq OWNER TO strapi;

--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_workflows_stages_workflow_lnk_id_seq OWNED BY public.strapi_workflows_stages_workflow_lnk.id;


--
-- Name: up_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.up_permissions OWNER TO strapi;

--
-- Name: up_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.up_permissions_id_seq OWNER TO strapi;

--
-- Name: up_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;


--
-- Name: up_permissions_role_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_permissions_role_lnk (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_ord double precision
);


ALTER TABLE public.up_permissions_role_lnk OWNER TO strapi;

--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_permissions_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.up_permissions_role_lnk_id_seq OWNER TO strapi;

--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_permissions_role_lnk_id_seq OWNED BY public.up_permissions_role_lnk.id;


--
-- Name: up_roles; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_roles (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    type character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.up_roles OWNER TO strapi;

--
-- Name: up_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.up_roles_id_seq OWNER TO strapi;

--
-- Name: up_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;


--
-- Name: up_users; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_users (
    id integer NOT NULL,
    document_id character varying(255),
    username character varying(255),
    email character varying(255),
    provider character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    confirmation_token character varying(255),
    confirmed boolean,
    blocked boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.up_users OWNER TO strapi;

--
-- Name: up_users_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.up_users_id_seq OWNER TO strapi;

--
-- Name: up_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;


--
-- Name: up_users_role_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_users_role_lnk (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    user_ord double precision
);


ALTER TABLE public.up_users_role_lnk OWNER TO strapi;

--
-- Name: up_users_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_users_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.up_users_role_lnk_id_seq OWNER TO strapi;

--
-- Name: up_users_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_users_role_lnk_id_seq OWNED BY public.up_users_role_lnk.id;


--
-- Name: upload_folders; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.upload_folders (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    path_id integer,
    path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.upload_folders OWNER TO strapi;

--
-- Name: upload_folders_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.upload_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.upload_folders_id_seq OWNER TO strapi;

--
-- Name: upload_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;


--
-- Name: upload_folders_parent_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.upload_folders_parent_lnk (
    id integer NOT NULL,
    folder_id integer,
    inv_folder_id integer,
    folder_ord double precision
);


ALTER TABLE public.upload_folders_parent_lnk OWNER TO strapi;

--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.upload_folders_parent_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.upload_folders_parent_lnk_id_seq OWNER TO strapi;

--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.upload_folders_parent_lnk_id_seq OWNED BY public.upload_folders_parent_lnk.id;


--
-- Name: admin_permissions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);


--
-- Name: admin_permissions_role_lnk id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_lnk_id_seq'::regclass);


--
-- Name: admin_roles id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: admin_users_roles_lnk id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_lnk ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_lnk_id_seq'::regclass);


--
-- Name: certifications id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.certifications ALTER COLUMN id SET DEFAULT nextval('public.certifications_id_seq'::regclass);


--
-- Name: components_shared_positions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_shared_positions ALTER COLUMN id SET DEFAULT nextval('public.components_shared_positions_id_seq'::regclass);


--
-- Name: components_shared_positions_cmps id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_shared_positions_cmps ALTER COLUMN id SET DEFAULT nextval('public.components_shared_positions_cmps_id_seq'::regclass);


--
-- Name: components_shared_responsibilities id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_shared_responsibilities ALTER COLUMN id SET DEFAULT nextval('public.components_shared_responsibilities_id_seq'::regclass);


--
-- Name: components_shared_social_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_shared_social_links ALTER COLUMN id SET DEFAULT nextval('public.components_shared_social_links_id_seq'::regclass);


--
-- Name: components_shared_soft_skills id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_shared_soft_skills ALTER COLUMN id SET DEFAULT nextval('public.components_shared_soft_skills_id_seq'::regclass);


--
-- Name: educations id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.educations ALTER COLUMN id SET DEFAULT nextval('public.educations_id_seq'::regclass);


--
-- Name: experiences id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.experiences ALTER COLUMN id SET DEFAULT nextval('public.experiences_id_seq'::regclass);


--
-- Name: experiences_cmps id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.experiences_cmps ALTER COLUMN id SET DEFAULT nextval('public.experiences_cmps_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: files_folder_lnk id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_lnk ALTER COLUMN id SET DEFAULT nextval('public.files_folder_lnk_id_seq'::regclass);


--
-- Name: files_related_mph id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_related_mph ALTER COLUMN id SET DEFAULT nextval('public.files_related_mph_id_seq'::regclass);


--
-- Name: i18n_locale id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: profiles id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.profiles ALTER COLUMN id SET DEFAULT nextval('public.profiles_id_seq'::regclass);


--
-- Name: profiles_cmps id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.profiles_cmps ALTER COLUMN id SET DEFAULT nextval('public.profiles_cmps_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: publications id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.publications ALTER COLUMN id SET DEFAULT nextval('public.publications_id_seq'::regclass);


--
-- Name: skills id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);


--
-- Name: strapi_ai_localization_jobs id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_ai_localization_jobs ALTER COLUMN id SET DEFAULT nextval('public.strapi_ai_localization_jobs_id_seq'::regclass);


--
-- Name: strapi_ai_metadata_jobs id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_ai_metadata_jobs ALTER COLUMN id SET DEFAULT nextval('public.strapi_ai_metadata_jobs_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions_token_lnk id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_lnk_id_seq'::regclass);


--
-- Name: strapi_api_tokens id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);


--
-- Name: strapi_core_store_settings id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);


--
-- Name: strapi_database_schema id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);


--
-- Name: strapi_history_versions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_history_versions ALTER COLUMN id SET DEFAULT nextval('public.strapi_history_versions_id_seq'::regclass);


--
-- Name: strapi_migrations id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);


--
-- Name: strapi_migrations_internal id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_migrations_internal ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_internal_id_seq'::regclass);


--
-- Name: strapi_release_actions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_release_actions ALTER COLUMN id SET DEFAULT nextval('public.strapi_release_actions_id_seq'::regclass);


--
-- Name: strapi_release_actions_release_lnk id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_release_actions_release_lnk_id_seq'::regclass);


--
-- Name: strapi_releases id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_releases ALTER COLUMN id SET DEFAULT nextval('public.strapi_releases_id_seq'::regclass);


--
-- Name: strapi_sessions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_sessions ALTER COLUMN id SET DEFAULT nextval('public.strapi_sessions_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions_token_lnk id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_lnk_id_seq'::regclass);


--
-- Name: strapi_transfer_tokens id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);


--
-- Name: strapi_webhooks id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);


--
-- Name: strapi_workflows id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_id_seq'::regclass);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stage_required_to_publish_lnk_id_seq'::regclass);


--
-- Name: strapi_workflows_stages id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_id_seq'::regclass);


--
-- Name: strapi_workflows_stages_permissions_lnk id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_permissions_lnk_id_seq'::regclass);


--
-- Name: strapi_workflows_stages_workflow_lnk id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_workflow_lnk_id_seq'::regclass);


--
-- Name: up_permissions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);


--
-- Name: up_permissions_role_lnk id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_lnk_id_seq'::regclass);


--
-- Name: up_roles id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);


--
-- Name: up_users id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);


--
-- Name: up_users_role_lnk id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.up_users_role_lnk_id_seq'::regclass);


--
-- Name: upload_folders id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);


--
-- Name: upload_folders_parent_lnk id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_lnk ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_parent_lnk_id_seq'::regclass);


--
-- Data for Name: admin_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_permissions (id, document_id, action, action_parameters, subject, properties, conditions, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	w5jqn3s2b4zmky1llf8pzkz3	plugin::content-manager.explorer.create	{}	api::certification.certification	{"fields": ["name", "issuer", "issue_date", "credential_url", "badge_image"]}	[]	2026-02-15 05:36:41.612	2026-02-15 05:36:41.612	2026-02-15 05:36:41.613	\N	\N	\N
2	n5l4mp095onrj33vnh6bpxy3	plugin::content-manager.explorer.create	{}	api::education.education	{"fields": ["institution", "degree", "field_of_study", "start_date", "end_date", "description", "logo"]}	[]	2026-02-15 05:36:41.629	2026-02-15 05:36:41.629	2026-02-15 05:36:41.629	\N	\N	\N
3	d9e09wzykilsx48nta80rfaj	plugin::content-manager.explorer.create	{}	api::experience.experience	{"fields": ["company_name", "company_url", "company_location", "company_logo", "order", "positions.designation", "positions.start_date", "positions.end_date", "positions.is_current", "positions.responsibilities.description"]}	[]	2026-02-15 05:36:41.638	2026-02-15 05:36:41.638	2026-02-15 05:36:41.638	\N	\N	\N
4	yiekxmayfw6hfya1j8w46vob	plugin::content-manager.explorer.create	{}	api::post.post	{"fields": ["title", "slug", "content", "excerpt", "featured_image", "author", "categories", "tags", "featured", "reading_time"]}	[]	2026-02-15 05:36:41.646	2026-02-15 05:36:41.646	2026-02-15 05:36:41.646	\N	\N	\N
5	f21887b302abbrw33fnkp3pk	plugin::content-manager.explorer.create	{}	api::profile.profile	{"fields": ["name", "designation", "company", "location", "summary", "typing_titles", "photo", "background", "resume", "social_links.platform", "social_links.url", "social_links.icon_name", "soft_skills.name", "soft_skills.level"]}	[]	2026-02-15 05:36:41.655	2026-02-15 05:36:41.655	2026-02-15 05:36:41.655	\N	\N	\N
6	e00rhxjz3xmlcqavrlwo1feo	plugin::content-manager.explorer.create	{}	api::project.project	{"fields": ["name", "slug", "description", "role", "timeline", "repo_url", "demo_url", "logo", "tags", "category", "featured"]}	[]	2026-02-15 05:36:41.664	2026-02-15 05:36:41.664	2026-02-15 05:36:41.664	\N	\N	\N
7	vpciawmra7o1ptv30o7z115g	plugin::content-manager.explorer.create	{}	api::publication.publication	{"fields": ["title", "journal", "authors", "date", "url", "doi", "abstract"]}	[]	2026-02-15 05:36:41.673	2026-02-15 05:36:41.673	2026-02-15 05:36:41.674	\N	\N	\N
8	q88qniwnykj6bdd6oyqmlllp	plugin::content-manager.explorer.create	{}	api::skill.skill	{"fields": ["name", "icon_name", "summary", "category", "url", "icon"]}	[]	2026-02-15 05:36:41.682	2026-02-15 05:36:41.682	2026-02-15 05:36:41.682	\N	\N	\N
9	amsil6tcw94ejk58175fzxkh	plugin::content-manager.explorer.read	{}	api::certification.certification	{"fields": ["name", "issuer", "issue_date", "credential_url", "badge_image"]}	[]	2026-02-15 05:36:41.691	2026-02-15 05:36:41.691	2026-02-15 05:36:41.691	\N	\N	\N
10	bow58fh5z0u2i17e1dqpjyti	plugin::content-manager.explorer.read	{}	api::education.education	{"fields": ["institution", "degree", "field_of_study", "start_date", "end_date", "description", "logo"]}	[]	2026-02-15 05:36:41.7	2026-02-15 05:36:41.7	2026-02-15 05:36:41.7	\N	\N	\N
11	mec39bh2egns97wfbnr5j8gi	plugin::content-manager.explorer.read	{}	api::experience.experience	{"fields": ["company_name", "company_url", "company_location", "company_logo", "order", "positions.designation", "positions.start_date", "positions.end_date", "positions.is_current", "positions.responsibilities.description"]}	[]	2026-02-15 05:36:41.709	2026-02-15 05:36:41.709	2026-02-15 05:36:41.709	\N	\N	\N
12	hwc4fxf3zapq1wvypbdixeli	plugin::content-manager.explorer.read	{}	api::post.post	{"fields": ["title", "slug", "content", "excerpt", "featured_image", "author", "categories", "tags", "featured", "reading_time"]}	[]	2026-02-15 05:36:41.718	2026-02-15 05:36:41.718	2026-02-15 05:36:41.718	\N	\N	\N
13	ok9h3nxwozm5pm6zr5p13nie	plugin::content-manager.explorer.read	{}	api::profile.profile	{"fields": ["name", "designation", "company", "location", "summary", "typing_titles", "photo", "background", "resume", "social_links.platform", "social_links.url", "social_links.icon_name", "soft_skills.name", "soft_skills.level"]}	[]	2026-02-15 05:36:41.726	2026-02-15 05:36:41.726	2026-02-15 05:36:41.727	\N	\N	\N
14	t3l3tn1x00neoo9f6hs9zj27	plugin::content-manager.explorer.read	{}	api::project.project	{"fields": ["name", "slug", "description", "role", "timeline", "repo_url", "demo_url", "logo", "tags", "category", "featured"]}	[]	2026-02-15 05:36:41.735	2026-02-15 05:36:41.735	2026-02-15 05:36:41.735	\N	\N	\N
15	fz4xlbau2lmtjcao6wbl6sz8	plugin::content-manager.explorer.read	{}	api::publication.publication	{"fields": ["title", "journal", "authors", "date", "url", "doi", "abstract"]}	[]	2026-02-15 05:36:41.744	2026-02-15 05:36:41.744	2026-02-15 05:36:41.744	\N	\N	\N
16	qvn5dhqzbst2c0dpuvwo7116	plugin::content-manager.explorer.read	{}	api::skill.skill	{"fields": ["name", "icon_name", "summary", "category", "url", "icon"]}	[]	2026-02-15 05:36:41.753	2026-02-15 05:36:41.753	2026-02-15 05:36:41.753	\N	\N	\N
17	l1cwpgvv8pg50w3tte0ydakx	plugin::content-manager.explorer.update	{}	api::certification.certification	{"fields": ["name", "issuer", "issue_date", "credential_url", "badge_image"]}	[]	2026-02-15 05:36:41.762	2026-02-15 05:36:41.762	2026-02-15 05:36:41.762	\N	\N	\N
18	rphfx9tvb3a0uj6ypmvlku0f	plugin::content-manager.explorer.update	{}	api::education.education	{"fields": ["institution", "degree", "field_of_study", "start_date", "end_date", "description", "logo"]}	[]	2026-02-15 05:36:41.771	2026-02-15 05:36:41.771	2026-02-15 05:36:41.771	\N	\N	\N
19	kchr8n82l9bxskiydoxxz0d0	plugin::content-manager.explorer.update	{}	api::experience.experience	{"fields": ["company_name", "company_url", "company_location", "company_logo", "order", "positions.designation", "positions.start_date", "positions.end_date", "positions.is_current", "positions.responsibilities.description"]}	[]	2026-02-15 05:36:41.783	2026-02-15 05:36:41.783	2026-02-15 05:36:41.783	\N	\N	\N
20	p4md8wdk4d1oo9df808f2py4	plugin::content-manager.explorer.update	{}	api::post.post	{"fields": ["title", "slug", "content", "excerpt", "featured_image", "author", "categories", "tags", "featured", "reading_time"]}	[]	2026-02-15 05:36:41.794	2026-02-15 05:36:41.794	2026-02-15 05:36:41.794	\N	\N	\N
21	jne5aaf8c8r194nc2yvkl94n	plugin::content-manager.explorer.update	{}	api::profile.profile	{"fields": ["name", "designation", "company", "location", "summary", "typing_titles", "photo", "background", "resume", "social_links.platform", "social_links.url", "social_links.icon_name", "soft_skills.name", "soft_skills.level"]}	[]	2026-02-15 05:36:41.804	2026-02-15 05:36:41.804	2026-02-15 05:36:41.804	\N	\N	\N
22	zd04zde28pu4lxmcwfa8g58u	plugin::content-manager.explorer.update	{}	api::project.project	{"fields": ["name", "slug", "description", "role", "timeline", "repo_url", "demo_url", "logo", "tags", "category", "featured"]}	[]	2026-02-15 05:36:41.812	2026-02-15 05:36:41.812	2026-02-15 05:36:41.812	\N	\N	\N
23	u2hin0w4tl6rwb1nkjbs2qll	plugin::content-manager.explorer.update	{}	api::publication.publication	{"fields": ["title", "journal", "authors", "date", "url", "doi", "abstract"]}	[]	2026-02-15 05:36:41.82	2026-02-15 05:36:41.82	2026-02-15 05:36:41.821	\N	\N	\N
24	pdp5523rvx28ghanr3ipfauc	plugin::content-manager.explorer.update	{}	api::skill.skill	{"fields": ["name", "icon_name", "summary", "category", "url", "icon"]}	[]	2026-02-15 05:36:41.828	2026-02-15 05:36:41.828	2026-02-15 05:36:41.828	\N	\N	\N
25	u9tyqzt8onvvni69im41wkie	plugin::content-manager.explorer.delete	{}	api::certification.certification	{}	[]	2026-02-15 05:36:41.837	2026-02-15 05:36:41.837	2026-02-15 05:36:41.837	\N	\N	\N
33	vt01eczegmnaxcqlpvzhzq2s	plugin::content-manager.explorer.publish	{}	api::certification.certification	{}	[]	2026-02-15 05:36:41.905	2026-02-15 05:36:41.905	2026-02-15 05:36:41.905	\N	\N	\N
41	z48k6e9pkdf8l3uu137kesif	plugin::upload.read	{}	\N	{}	[]	2026-02-15 05:36:41.972	2026-02-15 05:36:41.972	2026-02-15 05:36:41.972	\N	\N	\N
42	q212gxajiwawlzy9bx6rlc22	plugin::upload.configure-view	{}	\N	{}	[]	2026-02-15 05:36:41.982	2026-02-15 05:36:41.982	2026-02-15 05:36:41.982	\N	\N	\N
43	k1ju7y3ye8fb8h25f6h5huhf	plugin::upload.assets.create	{}	\N	{}	[]	2026-02-15 05:36:41.99	2026-02-15 05:36:41.99	2026-02-15 05:36:41.99	\N	\N	\N
44	mrq8yfyat4h1c1l668aad7el	plugin::upload.assets.update	{}	\N	{}	[]	2026-02-15 05:36:41.997	2026-02-15 05:36:41.997	2026-02-15 05:36:41.997	\N	\N	\N
45	deyjpzftvnhu2p9sfqafr43p	plugin::upload.assets.download	{}	\N	{}	[]	2026-02-15 05:36:42.005	2026-02-15 05:36:42.005	2026-02-15 05:36:42.006	\N	\N	\N
46	a10g7dyjpjtlt5sol5ipkh2m	plugin::upload.assets.copy-link	{}	\N	{}	[]	2026-02-15 05:36:42.015	2026-02-15 05:36:42.015	2026-02-15 05:36:42.015	\N	\N	\N
47	ka05xqq4ed1vgps91znh2wdm	plugin::content-manager.explorer.create	{}	api::certification.certification	{"fields": ["name", "issuer", "issue_date", "credential_url", "badge_image"]}	["admin::is-creator"]	2026-02-15 05:36:42.037	2026-02-15 05:36:42.037	2026-02-15 05:36:42.038	\N	\N	\N
48	ucxedtyrjzvojgszjjm8s2m7	plugin::content-manager.explorer.create	{}	api::education.education	{"fields": ["institution", "degree", "field_of_study", "start_date", "end_date", "description", "logo"]}	["admin::is-creator"]	2026-02-15 05:36:42.048	2026-02-15 05:36:42.048	2026-02-15 05:36:42.048	\N	\N	\N
49	hoidsxj8ls8wevoewf50smdv	plugin::content-manager.explorer.create	{}	api::experience.experience	{"fields": ["company_name", "company_url", "company_location", "company_logo", "order", "positions.designation", "positions.start_date", "positions.end_date", "positions.is_current", "positions.responsibilities.description"]}	["admin::is-creator"]	2026-02-15 05:36:42.056	2026-02-15 05:36:42.056	2026-02-15 05:36:42.056	\N	\N	\N
50	kpskdcr0e5ecdl9af180ny7v	plugin::content-manager.explorer.create	{}	api::post.post	{"fields": ["title", "slug", "content", "excerpt", "featured_image", "author", "categories", "tags", "featured", "reading_time"]}	["admin::is-creator"]	2026-02-15 05:36:42.064	2026-02-15 05:36:42.064	2026-02-15 05:36:42.065	\N	\N	\N
51	k76qih8d5go9ysbu2pujbdsw	plugin::content-manager.explorer.create	{}	api::profile.profile	{"fields": ["name", "designation", "company", "location", "summary", "typing_titles", "photo", "background", "resume", "social_links.platform", "social_links.url", "social_links.icon_name", "soft_skills.name", "soft_skills.level"]}	["admin::is-creator"]	2026-02-15 05:36:42.073	2026-02-15 05:36:42.073	2026-02-15 05:36:42.073	\N	\N	\N
52	oc20k5pl1i47i4uburtsoe31	plugin::content-manager.explorer.create	{}	api::project.project	{"fields": ["name", "slug", "description", "role", "timeline", "repo_url", "demo_url", "logo", "tags", "category", "featured"]}	["admin::is-creator"]	2026-02-15 05:36:42.082	2026-02-15 05:36:42.082	2026-02-15 05:36:42.083	\N	\N	\N
53	ww22t7sxps2k5c9wm5pq5lol	plugin::content-manager.explorer.create	{}	api::publication.publication	{"fields": ["title", "journal", "authors", "date", "url", "doi", "abstract"]}	["admin::is-creator"]	2026-02-15 05:36:42.091	2026-02-15 05:36:42.091	2026-02-15 05:36:42.091	\N	\N	\N
54	ofkeryy8213dkesub4djkxzv	plugin::content-manager.explorer.create	{}	api::skill.skill	{"fields": ["name", "icon_name", "summary", "category", "url", "icon"]}	["admin::is-creator"]	2026-02-15 05:36:42.1	2026-02-15 05:36:42.1	2026-02-15 05:36:42.1	\N	\N	\N
55	oanpc6p3689cr9pn33mz7yap	plugin::content-manager.explorer.read	{}	api::certification.certification	{"fields": ["name", "issuer", "issue_date", "credential_url", "badge_image"]}	["admin::is-creator"]	2026-02-15 05:36:42.108	2026-02-15 05:36:42.108	2026-02-15 05:36:42.108	\N	\N	\N
56	zzl2ecdpzu97poxg1h9buxnf	plugin::content-manager.explorer.read	{}	api::education.education	{"fields": ["institution", "degree", "field_of_study", "start_date", "end_date", "description", "logo"]}	["admin::is-creator"]	2026-02-15 05:36:42.116	2026-02-15 05:36:42.116	2026-02-15 05:36:42.116	\N	\N	\N
57	k9jnqlpf5pljt5kxzxyyeexl	plugin::content-manager.explorer.read	{}	api::experience.experience	{"fields": ["company_name", "company_url", "company_location", "company_logo", "order", "positions.designation", "positions.start_date", "positions.end_date", "positions.is_current", "positions.responsibilities.description"]}	["admin::is-creator"]	2026-02-15 05:36:42.125	2026-02-15 05:36:42.125	2026-02-15 05:36:42.125	\N	\N	\N
58	x4johroo0laop4u87kiuvdee	plugin::content-manager.explorer.read	{}	api::post.post	{"fields": ["title", "slug", "content", "excerpt", "featured_image", "author", "categories", "tags", "featured", "reading_time"]}	["admin::is-creator"]	2026-02-15 05:36:42.133	2026-02-15 05:36:42.133	2026-02-15 05:36:42.133	\N	\N	\N
59	r3rjw7s22ur8uuadf0bcw9np	plugin::content-manager.explorer.read	{}	api::profile.profile	{"fields": ["name", "designation", "company", "location", "summary", "typing_titles", "photo", "background", "resume", "social_links.platform", "social_links.url", "social_links.icon_name", "soft_skills.name", "soft_skills.level"]}	["admin::is-creator"]	2026-02-15 05:36:42.142	2026-02-15 05:36:42.142	2026-02-15 05:36:42.142	\N	\N	\N
60	pp4tp2b3ocm1gzlb0ie6cn7u	plugin::content-manager.explorer.read	{}	api::project.project	{"fields": ["name", "slug", "description", "role", "timeline", "repo_url", "demo_url", "logo", "tags", "category", "featured"]}	["admin::is-creator"]	2026-02-15 05:36:42.15	2026-02-15 05:36:42.15	2026-02-15 05:36:42.151	\N	\N	\N
61	quy3rab6dvhylyvnhc9k5iqh	plugin::content-manager.explorer.read	{}	api::publication.publication	{"fields": ["title", "journal", "authors", "date", "url", "doi", "abstract"]}	["admin::is-creator"]	2026-02-15 05:36:42.158	2026-02-15 05:36:42.158	2026-02-15 05:36:42.158	\N	\N	\N
121	m9222s0cu42s1bs7c9ammfmh	plugin::content-manager.explorer.publish	{}	plugin::users-permissions.user	{}	[]	2026-02-15 05:36:42.746	2026-02-15 05:36:42.746	2026-02-15 05:36:42.746	\N	\N	\N
62	yqlx0z2w5mxw75ukjc4xxwiy	plugin::content-manager.explorer.read	{}	api::skill.skill	{"fields": ["name", "icon_name", "summary", "category", "url", "icon"]}	["admin::is-creator"]	2026-02-15 05:36:42.168	2026-02-15 05:36:42.168	2026-02-15 05:36:42.168	\N	\N	\N
63	rgkm6uxdrhbdkigjrmsxya92	plugin::content-manager.explorer.update	{}	api::certification.certification	{"fields": ["name", "issuer", "issue_date", "credential_url", "badge_image"]}	["admin::is-creator"]	2026-02-15 05:36:42.176	2026-02-15 05:36:42.176	2026-02-15 05:36:42.176	\N	\N	\N
64	ff5nib9567czhevtulr4wuns	plugin::content-manager.explorer.update	{}	api::education.education	{"fields": ["institution", "degree", "field_of_study", "start_date", "end_date", "description", "logo"]}	["admin::is-creator"]	2026-02-15 05:36:42.184	2026-02-15 05:36:42.184	2026-02-15 05:36:42.184	\N	\N	\N
65	afvf8fbyjx8huj5zp7fhr35t	plugin::content-manager.explorer.update	{}	api::experience.experience	{"fields": ["company_name", "company_url", "company_location", "company_logo", "order", "positions.designation", "positions.start_date", "positions.end_date", "positions.is_current", "positions.responsibilities.description"]}	["admin::is-creator"]	2026-02-15 05:36:42.192	2026-02-15 05:36:42.192	2026-02-15 05:36:42.192	\N	\N	\N
66	z4ku1o45325hzu3an9qmjcvx	plugin::content-manager.explorer.update	{}	api::post.post	{"fields": ["title", "slug", "content", "excerpt", "featured_image", "author", "categories", "tags", "featured", "reading_time"]}	["admin::is-creator"]	2026-02-15 05:36:42.199	2026-02-15 05:36:42.199	2026-02-15 05:36:42.199	\N	\N	\N
67	flgn8rdea1pcf2t8arlfmibu	plugin::content-manager.explorer.update	{}	api::profile.profile	{"fields": ["name", "designation", "company", "location", "summary", "typing_titles", "photo", "background", "resume", "social_links.platform", "social_links.url", "social_links.icon_name", "soft_skills.name", "soft_skills.level"]}	["admin::is-creator"]	2026-02-15 05:36:42.208	2026-02-15 05:36:42.208	2026-02-15 05:36:42.208	\N	\N	\N
68	e22a1flfsqk1hr15wz4vhlym	plugin::content-manager.explorer.update	{}	api::project.project	{"fields": ["name", "slug", "description", "role", "timeline", "repo_url", "demo_url", "logo", "tags", "category", "featured"]}	["admin::is-creator"]	2026-02-15 05:36:42.216	2026-02-15 05:36:42.216	2026-02-15 05:36:42.216	\N	\N	\N
69	owjnhv765rjqtx7z6i0z7ywh	plugin::content-manager.explorer.update	{}	api::publication.publication	{"fields": ["title", "journal", "authors", "date", "url", "doi", "abstract"]}	["admin::is-creator"]	2026-02-15 05:36:42.226	2026-02-15 05:36:42.226	2026-02-15 05:36:42.226	\N	\N	\N
70	w3xfjyuyi7gsy1lq7o8bx68p	plugin::content-manager.explorer.update	{}	api::skill.skill	{"fields": ["name", "icon_name", "summary", "category", "url", "icon"]}	["admin::is-creator"]	2026-02-15 05:36:42.235	2026-02-15 05:36:42.235	2026-02-15 05:36:42.235	\N	\N	\N
71	rvr3faehubmw8qzqmieaho0o	plugin::content-manager.explorer.delete	{}	api::certification.certification	{}	["admin::is-creator"]	2026-02-15 05:36:42.244	2026-02-15 05:36:42.244	2026-02-15 05:36:42.244	\N	\N	\N
79	aaj0lh1y4o9gs1a6hiryiw0q	plugin::upload.read	{}	\N	{}	["admin::is-creator"]	2026-02-15 05:36:42.311	2026-02-15 05:36:42.311	2026-02-15 05:36:42.311	\N	\N	\N
80	bj6z82tdrcsamgg7t3sy57vz	plugin::upload.configure-view	{}	\N	{}	[]	2026-02-15 05:36:42.319	2026-02-15 05:36:42.319	2026-02-15 05:36:42.32	\N	\N	\N
81	n2z66jnmrmibpntmmqey79z5	plugin::upload.assets.create	{}	\N	{}	[]	2026-02-15 05:36:42.328	2026-02-15 05:36:42.328	2026-02-15 05:36:42.328	\N	\N	\N
82	zwezfrqrwufkgrjibiwb6jrj	plugin::upload.assets.update	{}	\N	{}	["admin::is-creator"]	2026-02-15 05:36:42.336	2026-02-15 05:36:42.336	2026-02-15 05:36:42.336	\N	\N	\N
83	nk7g9k0rc25wbwjpwj0wqt5i	plugin::upload.assets.download	{}	\N	{}	[]	2026-02-15 05:36:42.344	2026-02-15 05:36:42.344	2026-02-15 05:36:42.344	\N	\N	\N
84	zyibt6g6ipmjzpi2y67pm0cu	plugin::upload.assets.copy-link	{}	\N	{}	[]	2026-02-15 05:36:42.351	2026-02-15 05:36:42.351	2026-02-15 05:36:42.352	\N	\N	\N
85	lb5a61v22od4uymaca7xivxt	plugin::content-manager.explorer.create	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2026-02-15 05:36:42.424	2026-02-15 05:36:42.424	2026-02-15 05:36:42.424	\N	\N	\N
86	yqj7burryfqqslrhpas2z3is	plugin::content-manager.explorer.create	{}	api::certification.certification	{"fields": ["name", "issuer", "issue_date", "credential_url", "badge_image"]}	[]	2026-02-15 05:36:42.434	2026-02-15 05:36:42.434	2026-02-15 05:36:42.434	\N	\N	\N
94	giw8r9dtgv92xmbf50eomojd	plugin::content-manager.explorer.read	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2026-02-15 05:36:42.503	2026-02-15 05:36:42.503	2026-02-15 05:36:42.503	\N	\N	\N
95	amlbfjarzjarfucmi0sbso12	plugin::content-manager.explorer.read	{}	api::certification.certification	{"fields": ["name", "issuer", "issue_date", "credential_url", "badge_image"]}	[]	2026-02-15 05:36:42.512	2026-02-15 05:36:42.512	2026-02-15 05:36:42.512	\N	\N	\N
103	qwkp75kbvsg7gcxk9p2xi4op	plugin::content-manager.explorer.update	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	2026-02-15 05:36:42.576	2026-02-15 05:36:42.576	2026-02-15 05:36:42.576	\N	\N	\N
104	qtt7wvz83rpnkx1dviqezl0l	plugin::content-manager.explorer.update	{}	api::certification.certification	{"fields": ["name", "issuer", "issue_date", "credential_url", "badge_image"]}	[]	2026-02-15 05:36:42.585	2026-02-15 05:36:42.585	2026-02-15 05:36:42.585	\N	\N	\N
112	tyoqr3slgqv4nnnw3fj3e4ny	plugin::content-manager.explorer.delete	{}	plugin::users-permissions.user	{}	[]	2026-02-15 05:36:42.663	2026-02-15 05:36:42.663	2026-02-15 05:36:42.663	\N	\N	\N
113	rctorqaaq4n4ctazv3rah0fw	plugin::content-manager.explorer.delete	{}	api::certification.certification	{}	[]	2026-02-15 05:36:42.672	2026-02-15 05:36:42.672	2026-02-15 05:36:42.672	\N	\N	\N
122	f2ekrljemmgg1lqok8620tt1	plugin::content-manager.explorer.publish	{}	api::certification.certification	{}	[]	2026-02-15 05:36:42.757	2026-02-15 05:36:42.757	2026-02-15 05:36:42.757	\N	\N	\N
130	v1zj1pef4xmzokg961652g3r	plugin::content-manager.single-types.configure-view	{}	\N	{}	[]	2026-02-15 05:36:42.831	2026-02-15 05:36:42.831	2026-02-15 05:36:42.831	\N	\N	\N
131	bzzazs41q9ks1gyvy0m9n9b1	plugin::content-manager.collection-types.configure-view	{}	\N	{}	[]	2026-02-15 05:36:42.839	2026-02-15 05:36:42.839	2026-02-15 05:36:42.839	\N	\N	\N
132	kwcg0o0o1dzwplzfob6k0goz	plugin::content-manager.components.configure-layout	{}	\N	{}	[]	2026-02-15 05:36:42.848	2026-02-15 05:36:42.848	2026-02-15 05:36:42.848	\N	\N	\N
133	oek0j5pb3wlfvy7x97spjznn	plugin::content-type-builder.read	{}	\N	{}	[]	2026-02-15 05:36:42.856	2026-02-15 05:36:42.856	2026-02-15 05:36:42.856	\N	\N	\N
134	rfxvnpqny6ny38e7od4g7ntq	plugin::email.settings.read	{}	\N	{}	[]	2026-02-15 05:36:42.863	2026-02-15 05:36:42.863	2026-02-15 05:36:42.864	\N	\N	\N
135	yo73s7j4jxdzg7mkgq1io8jv	plugin::upload.read	{}	\N	{}	[]	2026-02-15 05:36:42.872	2026-02-15 05:36:42.872	2026-02-15 05:36:42.872	\N	\N	\N
136	kbdbbl1aby7xayz2cnbuh7s2	plugin::upload.assets.create	{}	\N	{}	[]	2026-02-15 05:36:42.881	2026-02-15 05:36:42.881	2026-02-15 05:36:42.881	\N	\N	\N
137	njbhmdc7ltegbqr5bn1va868	plugin::upload.assets.update	{}	\N	{}	[]	2026-02-15 05:36:42.888	2026-02-15 05:36:42.888	2026-02-15 05:36:42.889	\N	\N	\N
138	a8gbp5q3a2yx2xrdk8flfgxa	plugin::upload.assets.download	{}	\N	{}	[]	2026-02-15 05:36:42.897	2026-02-15 05:36:42.897	2026-02-15 05:36:42.897	\N	\N	\N
139	rvh7dn5po1u2r24du2hl71j6	plugin::upload.assets.copy-link	{}	\N	{}	[]	2026-02-15 05:36:42.906	2026-02-15 05:36:42.906	2026-02-15 05:36:42.906	\N	\N	\N
140	l34cgrsam1bguaxulokpyw9r	plugin::upload.configure-view	{}	\N	{}	[]	2026-02-15 05:36:42.914	2026-02-15 05:36:42.914	2026-02-15 05:36:42.914	\N	\N	\N
141	ifw0qyymh3lgxdn4qnuot4xz	plugin::upload.settings.read	{}	\N	{}	[]	2026-02-15 05:36:42.922	2026-02-15 05:36:42.922	2026-02-15 05:36:42.923	\N	\N	\N
142	wngv01ei2z4rlvn479lwj3bu	plugin::i18n.locale.create	{}	\N	{}	[]	2026-02-15 05:36:42.931	2026-02-15 05:36:42.931	2026-02-15 05:36:42.931	\N	\N	\N
143	nvbcf8bdjqpd3s29eyt8z15q	plugin::i18n.locale.read	{}	\N	{}	[]	2026-02-15 05:36:42.939	2026-02-15 05:36:42.939	2026-02-15 05:36:42.939	\N	\N	\N
144	w1d08oodlxzh343zos3dwzaz	plugin::i18n.locale.update	{}	\N	{}	[]	2026-02-15 05:36:42.947	2026-02-15 05:36:42.947	2026-02-15 05:36:42.947	\N	\N	\N
145	xvuou0dfdvnopsuprle7b9lx	plugin::i18n.locale.delete	{}	\N	{}	[]	2026-02-15 05:36:42.955	2026-02-15 05:36:42.955	2026-02-15 05:36:42.955	\N	\N	\N
146	bzhplapiodnaaz9gibhjavkr	plugin::users-permissions.roles.create	{}	\N	{}	[]	2026-02-15 05:36:42.965	2026-02-15 05:36:42.965	2026-02-15 05:36:42.965	\N	\N	\N
147	ez3gmc9ac5fyz5p6qub8iad7	plugin::users-permissions.roles.read	{}	\N	{}	[]	2026-02-15 05:36:42.974	2026-02-15 05:36:42.974	2026-02-15 05:36:42.975	\N	\N	\N
148	pd1v0dbzmb6v7j0nj7bevswd	plugin::users-permissions.roles.update	{}	\N	{}	[]	2026-02-15 05:36:42.984	2026-02-15 05:36:42.984	2026-02-15 05:36:42.984	\N	\N	\N
149	ne65p68p0rb311l8kwh8njc9	plugin::users-permissions.roles.delete	{}	\N	{}	[]	2026-02-15 05:36:42.991	2026-02-15 05:36:42.991	2026-02-15 05:36:42.991	\N	\N	\N
150	vltpjkxqkavnpfvfkiz72krj	plugin::users-permissions.providers.read	{}	\N	{}	[]	2026-02-15 05:36:42.999	2026-02-15 05:36:42.999	2026-02-15 05:36:42.999	\N	\N	\N
151	ozmvpitwabapqi9ytxe1td9v	plugin::users-permissions.providers.update	{}	\N	{}	[]	2026-02-15 05:36:43.008	2026-02-15 05:36:43.008	2026-02-15 05:36:43.008	\N	\N	\N
152	n2a6dg2a07qzrrsctypg4ovp	plugin::users-permissions.email-templates.read	{}	\N	{}	[]	2026-02-15 05:36:43.016	2026-02-15 05:36:43.016	2026-02-15 05:36:43.016	\N	\N	\N
153	ms7tklrsc84zmpqlbvqlszta	plugin::users-permissions.email-templates.update	{}	\N	{}	[]	2026-02-15 05:36:43.024	2026-02-15 05:36:43.024	2026-02-15 05:36:43.025	\N	\N	\N
154	l0u4s6b8su57dax47wykr2bt	plugin::users-permissions.advanced-settings.read	{}	\N	{}	[]	2026-02-15 05:36:43.033	2026-02-15 05:36:43.033	2026-02-15 05:36:43.033	\N	\N	\N
155	ock9ub245q40mb2ngfwus406	plugin::users-permissions.advanced-settings.update	{}	\N	{}	[]	2026-02-15 05:36:43.041	2026-02-15 05:36:43.041	2026-02-15 05:36:43.041	\N	\N	\N
156	w3f7jbutsrqafwn9d3phdfux	admin::marketplace.read	{}	\N	{}	[]	2026-02-15 05:36:43.049	2026-02-15 05:36:43.049	2026-02-15 05:36:43.049	\N	\N	\N
157	j9uonl4mbn8ug1hy1ad16fjt	admin::webhooks.create	{}	\N	{}	[]	2026-02-15 05:36:43.057	2026-02-15 05:36:43.057	2026-02-15 05:36:43.057	\N	\N	\N
158	fuhqeoldf6xg83zri7k35h5r	admin::webhooks.read	{}	\N	{}	[]	2026-02-15 05:36:43.069	2026-02-15 05:36:43.069	2026-02-15 05:36:43.069	\N	\N	\N
159	h6qfgo3zy3cf7sczrmaq2gh7	admin::webhooks.update	{}	\N	{}	[]	2026-02-15 05:36:43.077	2026-02-15 05:36:43.077	2026-02-15 05:36:43.077	\N	\N	\N
160	uk2j0klgtij56zhoc7cy6ila	admin::webhooks.delete	{}	\N	{}	[]	2026-02-15 05:36:43.084	2026-02-15 05:36:43.084	2026-02-15 05:36:43.084	\N	\N	\N
161	p5nkqb24jvo63wo61ycxt19e	admin::users.create	{}	\N	{}	[]	2026-02-15 05:36:43.093	2026-02-15 05:36:43.093	2026-02-15 05:36:43.093	\N	\N	\N
162	su5mteeu0hiv5zfy01js9hmv	admin::users.read	{}	\N	{}	[]	2026-02-15 05:36:43.1	2026-02-15 05:36:43.1	2026-02-15 05:36:43.1	\N	\N	\N
163	p9rkr3s2uha4dzpn4krmh69x	admin::users.update	{}	\N	{}	[]	2026-02-15 05:36:43.109	2026-02-15 05:36:43.109	2026-02-15 05:36:43.109	\N	\N	\N
164	tsaighwy2aub5wb0a521aoh5	admin::users.delete	{}	\N	{}	[]	2026-02-15 05:36:43.117	2026-02-15 05:36:43.117	2026-02-15 05:36:43.117	\N	\N	\N
165	pkz34yvixgq94ocnxhh7pey0	admin::roles.create	{}	\N	{}	[]	2026-02-15 05:36:43.124	2026-02-15 05:36:43.124	2026-02-15 05:36:43.125	\N	\N	\N
166	fgrs9khxf0psa6lwb9eipflv	admin::roles.read	{}	\N	{}	[]	2026-02-15 05:36:43.132	2026-02-15 05:36:43.132	2026-02-15 05:36:43.132	\N	\N	\N
167	nncbhkz514cngzsycs8lkca2	admin::roles.update	{}	\N	{}	[]	2026-02-15 05:36:43.14	2026-02-15 05:36:43.14	2026-02-15 05:36:43.14	\N	\N	\N
168	c13fyqj83991lfhj6i954apo	admin::roles.delete	{}	\N	{}	[]	2026-02-15 05:36:43.147	2026-02-15 05:36:43.147	2026-02-15 05:36:43.147	\N	\N	\N
169	uigev6es2739ey14gm049ydj	admin::api-tokens.access	{}	\N	{}	[]	2026-02-15 05:36:43.156	2026-02-15 05:36:43.156	2026-02-15 05:36:43.156	\N	\N	\N
170	pwhs9ov3equ0p4rexgx1kq7y	admin::api-tokens.create	{}	\N	{}	[]	2026-02-15 05:36:43.165	2026-02-15 05:36:43.165	2026-02-15 05:36:43.165	\N	\N	\N
171	eiex4alizjbpr4c1e2eg2j76	admin::api-tokens.read	{}	\N	{}	[]	2026-02-15 05:36:43.173	2026-02-15 05:36:43.173	2026-02-15 05:36:43.173	\N	\N	\N
172	axpbb27h42pbwhudjaei8gep	admin::api-tokens.update	{}	\N	{}	[]	2026-02-15 05:36:43.181	2026-02-15 05:36:43.181	2026-02-15 05:36:43.181	\N	\N	\N
173	qstz69zddhofkwlkmp63tymc	admin::api-tokens.regenerate	{}	\N	{}	[]	2026-02-15 05:36:43.189	2026-02-15 05:36:43.189	2026-02-15 05:36:43.189	\N	\N	\N
174	n2kelh0hgnj1klt5q75wyihk	admin::api-tokens.delete	{}	\N	{}	[]	2026-02-15 05:36:43.196	2026-02-15 05:36:43.196	2026-02-15 05:36:43.196	\N	\N	\N
175	id7ooy0jgnx3iw0fqg43ueao	admin::project-settings.update	{}	\N	{}	[]	2026-02-15 05:36:43.205	2026-02-15 05:36:43.205	2026-02-15 05:36:43.205	\N	\N	\N
176	blggjt716ehzkh3ksfe8z5zz	admin::project-settings.read	{}	\N	{}	[]	2026-02-15 05:36:43.212	2026-02-15 05:36:43.212	2026-02-15 05:36:43.212	\N	\N	\N
177	mha04fiua24xxtomzzdr9bj5	admin::transfer.tokens.access	{}	\N	{}	[]	2026-02-15 05:36:43.22	2026-02-15 05:36:43.22	2026-02-15 05:36:43.22	\N	\N	\N
178	lyaekh9dottf05qw0srtis7q	admin::transfer.tokens.create	{}	\N	{}	[]	2026-02-15 05:36:43.228	2026-02-15 05:36:43.228	2026-02-15 05:36:43.228	\N	\N	\N
179	vcw194fhc7nqq5wsuwgv4jmi	admin::transfer.tokens.read	{}	\N	{}	[]	2026-02-15 05:36:43.236	2026-02-15 05:36:43.236	2026-02-15 05:36:43.236	\N	\N	\N
180	na8au7fgq3ritdu1b8h0xcb8	admin::transfer.tokens.update	{}	\N	{}	[]	2026-02-15 05:36:43.245	2026-02-15 05:36:43.245	2026-02-15 05:36:43.245	\N	\N	\N
181	hegk5byikonbebb1d74ahu8c	admin::transfer.tokens.regenerate	{}	\N	{}	[]	2026-02-15 05:36:43.255	2026-02-15 05:36:43.255	2026-02-15 05:36:43.255	\N	\N	\N
182	zao4ovury5rty8d8esi2gyo5	admin::transfer.tokens.delete	{}	\N	{}	[]	2026-02-15 05:36:43.265	2026-02-15 05:36:43.265	2026-02-15 05:36:43.265	\N	\N	\N
126	tz33exlypdsqxv5xess2fd5v	plugin::content-manager.explorer.publish	{}	api::profile.profile	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.236	2026-02-15 06:00:13.236	2026-02-15 06:00:13.236	\N	\N	\N
120	tg9mlh9dbz4x54r0l9x037by	plugin::content-manager.explorer.delete	{}	api::skill.skill	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.246	2026-02-15 06:00:13.246	2026-02-15 06:00:13.246	\N	\N	\N
116	vyjb10v4rsnks131p33vaca6	plugin::content-manager.explorer.delete	{}	api::post.post	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.254	2026-02-15 06:00:13.254	2026-02-15 06:00:13.254	\N	\N	\N
106	zfwmhb5mxj5gx01ugo98hivk	plugin::content-manager.explorer.update	{}	api::experience.experience	{"fields": ["company_name", "company_url", "company_location", "company_logo", "order", "positions.designation", "positions.start_date", "positions.end_date", "positions.is_current", "positions.responsibilities.description"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.263	2026-02-15 06:00:13.263	2026-02-15 06:00:13.263	\N	\N	\N
91	uq5rpjtlrc3f8ut2ifxp0bjs	plugin::content-manager.explorer.create	{}	api::project.project	{"fields": ["name", "slug", "description", "role", "timeline", "repo_url", "demo_url", "logo", "tags", "category", "featured"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.271	2026-02-15 06:00:13.271	2026-02-15 06:00:13.271	\N	\N	\N
107	xl418v4je1d775sdru1dfhh9	plugin::content-manager.explorer.update	{}	api::post.post	{"fields": ["title", "slug", "content", "excerpt", "featured_image", "author", "categories", "tags", "featured", "reading_time"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.279	2026-02-15 06:00:13.279	2026-02-15 06:00:13.28	\N	\N	\N
125	ka8jyshctl2g69asq6b85xw3	plugin::content-manager.explorer.publish	{}	api::post.post	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.289	2026-02-15 06:00:13.289	2026-02-15 06:00:13.289	\N	\N	\N
108	nedlqecr7q99ub35eaw4i6nn	plugin::content-manager.explorer.update	{}	api::profile.profile	{"fields": ["name", "designation", "company", "location", "summary", "typing_titles", "photo", "background", "resume", "social_links.platform", "social_links.url", "social_links.icon_name", "soft_skills.name", "soft_skills.level"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.297	2026-02-15 06:00:13.297	2026-02-15 06:00:13.298	\N	\N	\N
93	sy48bzpgxhy076vujkgzk0dd	plugin::content-manager.explorer.create	{}	api::skill.skill	{"fields": ["name", "icon_name", "summary", "category", "url", "icon"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.305	2026-02-15 06:00:13.305	2026-02-15 06:00:13.306	\N	\N	\N
98	ezr1970nayrwkr1hkk0eqgpg	plugin::content-manager.explorer.read	{}	api::post.post	{"fields": ["title", "slug", "content", "excerpt", "featured_image", "author", "categories", "tags", "featured", "reading_time"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.313	2026-02-15 06:00:13.313	2026-02-15 06:00:13.314	\N	\N	\N
127	qe33axj95u0mspcwvtelyimm	plugin::content-manager.explorer.publish	{}	api::project.project	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.321	2026-02-15 06:00:13.321	2026-02-15 06:00:13.322	\N	\N	\N
124	ddcqq0yhrt81o21d5gila41b	plugin::content-manager.explorer.publish	{}	api::experience.experience	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.329	2026-02-15 06:00:13.329	2026-02-15 06:00:13.33	\N	\N	\N
119	wx3o35mo8868vho4qicae6ff	plugin::content-manager.explorer.delete	{}	api::publication.publication	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.338	2026-02-15 06:00:13.338	2026-02-15 06:00:13.338	\N	\N	\N
110	izwbsd0xzeojajtj0y19r1w2	plugin::content-manager.explorer.update	{}	api::publication.publication	{"fields": ["title", "journal", "authors", "date", "url", "doi", "abstract"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.346	2026-02-15 06:00:13.346	2026-02-15 06:00:13.346	\N	\N	\N
87	ym5kj42iri6lmpqahcir5ppg	plugin::content-manager.explorer.create	{}	api::education.education	{"fields": ["institution", "degree", "field_of_study", "start_date", "end_date", "description", "logo"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.354	2026-02-15 06:00:13.354	2026-02-15 06:00:13.354	\N	\N	\N
92	jf0j0auxmcqpgt63f93ysgv7	plugin::content-manager.explorer.create	{}	api::publication.publication	{"fields": ["title", "journal", "authors", "date", "url", "doi", "abstract"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.364	2026-02-15 06:00:13.364	2026-02-15 06:00:13.364	\N	\N	\N
99	p8bwnnqjxjunzl5jcwj25vb8	plugin::content-manager.explorer.read	{}	api::profile.profile	{"fields": ["name", "designation", "company", "location", "summary", "typing_titles", "photo", "background", "resume", "social_links.platform", "social_links.url", "social_links.icon_name", "soft_skills.name", "soft_skills.level"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.372	2026-02-15 06:00:13.372	2026-02-15 06:00:13.372	\N	\N	\N
115	a455ato0at777whexztv9z9k	plugin::content-manager.explorer.delete	{}	api::experience.experience	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.38	2026-02-15 06:00:13.38	2026-02-15 06:00:13.38	\N	\N	\N
118	i4tijwq6iupcg6g2cmy6b1lc	plugin::content-manager.explorer.delete	{}	api::project.project	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.389	2026-02-15 06:00:13.389	2026-02-15 06:00:13.389	\N	\N	\N
111	lkp623jk59bajef6vhu65tck	plugin::content-manager.explorer.update	{}	api::skill.skill	{"fields": ["name", "icon_name", "summary", "category", "url", "icon"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.397	2026-02-15 06:00:13.397	2026-02-15 06:00:13.397	\N	\N	\N
88	ybd17d9g0nfgxjnluvqwglm9	plugin::content-manager.explorer.create	{}	api::experience.experience	{"fields": ["company_name", "company_url", "company_location", "company_logo", "order", "positions.designation", "positions.start_date", "positions.end_date", "positions.is_current", "positions.responsibilities.description"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.406	2026-02-15 06:00:13.406	2026-02-15 06:00:13.406	\N	\N	\N
102	pazfzq7a82ogzxkuug9sfwur	plugin::content-manager.explorer.read	{}	api::skill.skill	{"fields": ["name", "icon_name", "summary", "category", "url", "icon"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.414	2026-02-15 06:00:13.414	2026-02-15 06:00:13.415	\N	\N	\N
89	m6v52i563qo7z4qz1k6qzrn8	plugin::content-manager.explorer.create	{}	api::post.post	{"fields": ["title", "slug", "content", "excerpt", "featured_image", "author", "categories", "tags", "featured", "reading_time"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.424	2026-02-15 06:00:13.424	2026-02-15 06:00:13.424	\N	\N	\N
114	dwo8bsia3459jtu9dx1vwns2	plugin::content-manager.explorer.delete	{}	api::education.education	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.433	2026-02-15 06:00:13.433	2026-02-15 06:00:13.433	\N	\N	\N
97	b30nxoug1e88b2hilzxgx3g1	plugin::content-manager.explorer.read	{}	api::experience.experience	{"fields": ["company_name", "company_url", "company_location", "company_logo", "order", "positions.designation", "positions.start_date", "positions.end_date", "positions.is_current", "positions.responsibilities.description"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.442	2026-02-15 06:00:13.442	2026-02-15 06:00:13.442	\N	\N	\N
96	dvctv0yra654wll7is741wt0	plugin::content-manager.explorer.read	{}	api::education.education	{"fields": ["institution", "degree", "field_of_study", "start_date", "end_date", "description", "logo"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.45	2026-02-15 06:00:13.45	2026-02-15 06:00:13.45	\N	\N	\N
100	zdl9ws7sogzj1q0wdzemwtq5	plugin::content-manager.explorer.read	{}	api::project.project	{"fields": ["name", "slug", "description", "role", "timeline", "repo_url", "demo_url", "logo", "tags", "category", "featured"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.458	2026-02-15 06:00:13.458	2026-02-15 06:00:13.458	\N	\N	\N
101	c77su4d9nmeh5570y8v3v07y	plugin::content-manager.explorer.read	{}	api::publication.publication	{"fields": ["title", "journal", "authors", "date", "url", "doi", "abstract"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.467	2026-02-15 06:00:13.467	2026-02-15 06:00:13.467	\N	\N	\N
90	eh921srkhzcce5u774d62ksw	plugin::content-manager.explorer.create	{}	api::profile.profile	{"fields": ["name", "designation", "company", "location", "summary", "typing_titles", "photo", "background", "resume", "social_links.platform", "social_links.url", "social_links.icon_name", "soft_skills.name", "soft_skills.level"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.478	2026-02-15 06:00:13.478	2026-02-15 06:00:13.478	\N	\N	\N
117	lddnr85oycpqz1g92efvb7b0	plugin::content-manager.explorer.delete	{}	api::profile.profile	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.486	2026-02-15 06:00:13.486	2026-02-15 06:00:13.486	\N	\N	\N
105	r7ftoz7cgk1k0thrx7f2f5ad	plugin::content-manager.explorer.update	{}	api::education.education	{"fields": ["institution", "degree", "field_of_study", "start_date", "end_date", "description", "logo"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.494	2026-02-15 06:00:13.494	2026-02-15 06:00:13.494	\N	\N	\N
129	holzsok77xwky85dgcty99yq	plugin::content-manager.explorer.publish	{}	api::skill.skill	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.502	2026-02-15 06:00:13.502	2026-02-15 06:00:13.502	\N	\N	\N
128	jh1vf6ds3jvnbl96zsrlwol1	plugin::content-manager.explorer.publish	{}	api::publication.publication	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.51	2026-02-15 06:00:13.51	2026-02-15 06:00:13.51	\N	\N	\N
123	y8a78ej0kl67vybpq776gl4z	plugin::content-manager.explorer.publish	{}	api::education.education	{"locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.519	2026-02-15 06:00:13.519	2026-02-15 06:00:13.519	\N	\N	\N
109	kaihlacati6n44yse6l61tr5	plugin::content-manager.explorer.update	{}	api::project.project	{"fields": ["name", "slug", "description", "role", "timeline", "repo_url", "demo_url", "logo", "tags", "category", "featured"], "locales": ["en", "pt-BR"]}	[]	2026-02-15 06:00:13.527	2026-02-15 06:00:13.527	2026-02-15 06:00:13.527	\N	\N	\N
\.


--
-- Data for Name: admin_permissions_role_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_permissions_role_lnk (id, permission_id, role_id, permission_ord) FROM stdin;
1	1	2	1
2	2	2	2
3	3	2	3
4	4	2	4
5	5	2	5
6	6	2	6
7	7	2	7
8	8	2	8
9	9	2	9
10	10	2	10
11	11	2	11
12	12	2	12
13	13	2	13
14	14	2	14
15	15	2	15
16	16	2	16
17	17	2	17
18	18	2	18
19	19	2	19
20	20	2	20
21	21	2	21
22	22	2	22
23	23	2	23
24	24	2	24
25	25	2	25
33	33	2	33
41	41	2	41
42	42	2	42
43	43	2	43
44	44	2	44
45	45	2	45
46	46	2	46
47	47	3	1
48	48	3	2
49	49	3	3
50	50	3	4
51	51	3	5
52	52	3	6
53	53	3	7
54	54	3	8
55	55	3	9
56	56	3	10
57	57	3	11
58	58	3	12
59	59	3	13
60	60	3	14
61	61	3	15
62	62	3	16
63	63	3	17
64	64	3	18
65	65	3	19
66	66	3	20
67	67	3	21
68	68	3	22
69	69	3	23
70	70	3	24
71	71	3	25
79	79	3	33
80	80	3	34
81	81	3	35
82	82	3	36
83	83	3	37
84	84	3	38
85	85	1	1
86	86	1	2
94	94	1	10
95	95	1	11
103	103	1	19
104	104	1	20
112	112	1	28
113	113	1	29
121	121	1	37
122	122	1	38
130	130	1	46
131	131	1	47
132	132	1	48
133	133	1	49
134	134	1	50
135	135	1	51
136	136	1	52
137	137	1	53
138	138	1	54
139	139	1	55
140	140	1	56
141	141	1	57
142	142	1	58
143	143	1	59
144	144	1	60
145	145	1	61
146	146	1	62
147	147	1	63
148	148	1	64
149	149	1	65
150	150	1	66
151	151	1	67
152	152	1	68
153	153	1	69
154	154	1	70
155	155	1	71
156	156	1	72
157	157	1	73
158	158	1	74
159	159	1	75
160	160	1	76
161	161	1	77
162	162	1	78
163	163	1	79
164	164	1	80
165	165	1	81
166	166	1	82
167	167	1	83
168	168	1	84
169	169	1	85
170	170	1	86
171	171	1	87
172	172	1	88
173	173	1	89
174	174	1	90
175	175	1	91
176	176	1	92
177	177	1	93
178	178	1	94
179	179	1	95
180	180	1	96
181	181	1	97
182	182	1	98
183	126	1	99
184	120	1	100
185	116	1	101
186	106	1	102
187	91	1	103
188	107	1	104
189	125	1	105
190	108	1	106
191	93	1	107
192	98	1	108
193	127	1	109
194	124	1	110
195	119	1	111
196	110	1	112
197	87	1	113
198	92	1	114
199	99	1	115
200	115	1	116
201	118	1	117
202	111	1	118
203	88	1	119
204	102	1	120
205	89	1	121
206	114	1	122
207	97	1	123
208	96	1	124
209	100	1	125
210	101	1	126
211	90	1	127
212	117	1	128
213	105	1	129
214	129	1	130
215	128	1	131
216	123	1	132
217	109	1	133
\.


--
-- Data for Name: admin_roles; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_roles (id, document_id, name, code, description, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	etaeoignp10r27u9b7gxgq9m	Super Admin	strapi-super-admin	Super Admins can access and manage all features and settings.	2026-02-15 05:36:41.557	2026-02-15 05:36:41.557	2026-02-15 05:36:41.557	\N	\N	\N
2	elwa73r8z97c51nwpz3xoz6e	Editor	strapi-editor	Editors can manage and publish contents including those of other users.	2026-02-15 05:36:41.571	2026-02-15 05:36:41.571	2026-02-15 05:36:41.571	\N	\N	\N
3	b6cubb19ynjm9hxzlfrwgngo	Author	strapi-author	Authors can manage the content they have created.	2026-02-15 05:36:41.577	2026-02-15 05:36:41.577	2026-02-15 05:36:41.577	\N	\N	\N
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_users (id, document_id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	mv7ygrmk8dx964san995rrgv	Lucas	Albini	\N	lucasalbini@gmail.com	$2a$10$oEZs5t0QECRyic5Shxy33.WTnFJuhOoJdv1fUUVkq9RFSvgu1H/uq	\N	\N	t	f	\N	2026-02-15 05:43:41.27	2026-02-15 05:50:04.405	2026-02-15 05:43:41.271	\N	\N	\N
\.


--
-- Data for Name: admin_users_roles_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_users_roles_lnk (id, user_id, role_id, role_ord, user_ord) FROM stdin;
1	1	1	1	1
\.


--
-- Data for Name: certifications; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.certifications (id, document_id, name, issuer, issue_date, credential_url, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
11	aih8rjoud8ej2qlm3sw2ujaz	Machine Learning and Data Science with Python	\N	\N	https://www.udemy.com/certificate/UC-d4f30bf5-d42a-4235-b887-d688617d604a/	2026-02-15 05:54:59.261	2026-02-15 07:11:28.916	\N	\N	1	pt-BR
29	aih8rjoud8ej2qlm3sw2ujaz	Machine Learning and Data Science with Python	\N	\N	https://www.udemy.com/certificate/UC-d4f30bf5-d42a-4235-b887-d688617d604a/	2026-02-15 05:54:59.261	2026-02-15 07:11:28.916	2026-02-15 07:11:28.939	\N	1	pt-BR
9	xf0bmgomfa8fhjswxyztisyy	Microsoft Azure - Introduction to Artificial Intelligence	Microsoft	\N	\N	2026-02-15 05:54:59.234	2026-02-15 06:07:01.255	\N	\N	\N	pt-BR
23	xf0bmgomfa8fhjswxyztisyy	Microsoft Azure - Introduction to Artificial Intelligence	Microsoft	\N	\N	2026-02-15 05:54:59.234	2026-02-15 06:07:01.255	2026-02-15 06:07:01.266	\N	\N	pt-BR
1	m2lg6jtzqi9sp2ulj7he5mt1	AWS Certified Machine Learning - Specialty	Amazon Web Services	\N	https://cp.certmetrics.com/amazon/en/public/verify/credential/da8fdb82f40645e981589be7450b2510	2026-02-15 05:54:59.121	2026-02-15 07:09:11.591	\N	\N	1	pt-BR
25	m2lg6jtzqi9sp2ulj7he5mt1	AWS Certified Machine Learning - Specialty	Amazon Web Services	\N	https://cp.certmetrics.com/amazon/en/public/verify/credential/da8fdb82f40645e981589be7450b2510	2026-02-15 05:54:59.121	2026-02-15 07:09:11.591	2026-02-15 07:09:11.616	\N	1	pt-BR
5	bbytgfb9fv5y3h8eu8wurtwu	AWS Certified Developer - Associate	Amazon Web Services	\N	https://cp.certmetrics.com/amazon/en/public/verify/credential/VJ9WV6QB51RQ1JS8	2026-02-15 05:54:59.181	2026-02-15 07:10:01.946	\N	\N	1	pt-BR
26	bbytgfb9fv5y3h8eu8wurtwu	AWS Certified Developer - Associate	Amazon Web Services	\N	https://cp.certmetrics.com/amazon/en/public/verify/credential/VJ9WV6QB51RQ1JS8	2026-02-15 05:54:59.181	2026-02-15 07:10:01.946	2026-02-15 07:10:01.966	\N	1	pt-BR
3	imnbwtdu8hbsogfrouy4g0xd	AWS Certified Solutions Architect - Associate	Amazon Web Services	\N	https://cp.certmetrics.com/amazon/en/public/verify/credential/SNBQWL9C0NE11ZCW	2026-02-15 05:54:59.151	2026-02-15 07:10:33.007	\N	\N	1	pt-BR
27	imnbwtdu8hbsogfrouy4g0xd	AWS Certified Solutions Architect - Associate	Amazon Web Services	\N	https://cp.certmetrics.com/amazon/en/public/verify/credential/SNBQWL9C0NE11ZCW	2026-02-15 05:54:59.151	2026-02-15 07:10:33.007	2026-02-15 07:10:33.024	\N	1	pt-BR
7	bpvb6nrbyoon1ye7zvef146b	AWS Certified Cloud Practitioner	Amazon Web Services	\N	https://cp.certmetrics.com/amazon/en/public/verify/credential/CX01JJDCW2F4QW9B	2026-02-15 05:54:59.206	2026-02-15 07:11:01.908	\N	\N	1	pt-BR
28	bpvb6nrbyoon1ye7zvef146b	AWS Certified Cloud Practitioner	Amazon Web Services	\N	https://cp.certmetrics.com/amazon/en/public/verify/credential/CX01JJDCW2F4QW9B	2026-02-15 05:54:59.206	2026-02-15 07:11:01.908	2026-02-15 07:11:01.928	\N	1	pt-BR
\.


--
-- Data for Name: components_shared_positions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_shared_positions (id, designation, start_date, end_date, is_current) FROM stdin;
1	Líder Técnico de IA	2025-11-01	\N	t
2	Engenheiro de Machine Learning Senior	2024-10-01	2025-11-01	f
3	Engenheiro de Machine Learning Pleno	2023-07-01	2024-10-01	f
4	Engenheiro de Visão Computacional Pleno	2021-05-01	2023-07-01	f
9	Computer Vision Developer	2019-10-01	2021-06-01	f
11	Undergraduate Research Assistant	2017-08-01	2020-05-01	f
12	Estagiário	2017-04-01	2017-08-01	f
15	Estagiário	2018-02-01	2018-03-01	f
49	Líder Técnico de IA	2025-11-01	\N	t
50	Engenheiro de Machine Learning Senior	2024-10-01	2025-11-01	f
51	Engenheiro de Machine Learning Pleno	2023-07-01	2024-10-01	f
52	Engenheiro de Visão Computacional Pleno	2021-05-01	2023-07-01	f
53	Líder Técnico de IA	2025-11-01	\N	t
54	Engenheiro de Machine Learning Senior	2024-10-01	2025-11-01	f
55	Engenheiro de Machine Learning Pleno	2023-07-01	2024-10-01	f
56	Engenheiro de Visão Computacional Pleno	2021-05-01	2023-07-01	f
57	Engenheiro de Machine Learning Senior	2024-10-01	2025-11-01	f
58	Líder Técnico de IA	2025-11-01	\N	t
59	Engenheiro de Machine Learning Pleno	2023-07-01	2024-10-01	f
60	Engenheiro de Visão Computacional Pleno	2021-05-01	2023-07-01	f
61	Computer Vision Developer	2019-10-01	2021-06-01	f
62	Computer Vision Developer	2019-10-01	2021-06-01	f
63	Computer Vision Developer	2019-10-01	2021-06-01	f
64	Undergraduate Research Assistant	2017-08-01	2020-05-01	f
65	Estagiário	2017-04-01	2017-08-01	f
66	Undergraduate Research Assistant	2017-08-01	2020-05-01	f
67	Estagiário	2017-04-01	2017-08-01	f
68	Undergraduate Research Assistant	2017-08-01	2020-05-01	f
69	Estagiário	2017-04-01	2017-08-01	f
70	Estagiário	2018-02-01	2018-03-01	f
71	Estagiário	2018-02-01	2018-03-01	f
72	Estagiário	2018-02-01	2018-03-01	f
\.


--
-- Data for Name: components_shared_positions_cmps; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_shared_positions_cmps (id, entity_id, cmp_id, component_type, field, "order") FROM stdin;
1	1	1	shared.responsibility	responsibilities	1
2	1	2	shared.responsibility	responsibilities	2
3	1	3	shared.responsibility	responsibilities	3
4	1	4	shared.responsibility	responsibilities	4
5	1	5	shared.responsibility	responsibilities	5
6	1	6	shared.responsibility	responsibilities	6
7	2	7	shared.responsibility	responsibilities	1
8	2	8	shared.responsibility	responsibilities	2
9	2	9	shared.responsibility	responsibilities	3
10	2	10	shared.responsibility	responsibilities	4
11	2	11	shared.responsibility	responsibilities	5
12	3	12	shared.responsibility	responsibilities	1
13	3	13	shared.responsibility	responsibilities	2
14	3	14	shared.responsibility	responsibilities	3
15	3	15	shared.responsibility	responsibilities	4
16	3	16	shared.responsibility	responsibilities	5
17	4	17	shared.responsibility	responsibilities	1
18	4	18	shared.responsibility	responsibilities	2
19	4	19	shared.responsibility	responsibilities	3
20	4	20	shared.responsibility	responsibilities	4
21	4	21	shared.responsibility	responsibilities	5
97	49	97	shared.responsibility	responsibilities	1
98	49	98	shared.responsibility	responsibilities	2
99	49	99	shared.responsibility	responsibilities	3
100	49	100	shared.responsibility	responsibilities	4
101	49	101	shared.responsibility	responsibilities	5
102	49	102	shared.responsibility	responsibilities	6
103	49	103	shared.responsibility	responsibilities	7
104	49	104	shared.responsibility	responsibilities	8
105	49	105	shared.responsibility	responsibilities	9
106	49	106	shared.responsibility	responsibilities	10
107	49	107	shared.responsibility	responsibilities	11
108	50	108	shared.responsibility	responsibilities	1
109	50	109	shared.responsibility	responsibilities	2
110	50	110	shared.responsibility	responsibilities	3
111	50	111	shared.responsibility	responsibilities	4
112	50	112	shared.responsibility	responsibilities	5
113	50	113	shared.responsibility	responsibilities	6
114	50	114	shared.responsibility	responsibilities	7
115	51	115	shared.responsibility	responsibilities	1
116	51	116	shared.responsibility	responsibilities	2
117	51	117	shared.responsibility	responsibilities	3
43	9	43	shared.responsibility	responsibilities	1
44	9	44	shared.responsibility	responsibilities	2
45	9	45	shared.responsibility	responsibilities	3
118	51	118	shared.responsibility	responsibilities	4
119	51	119	shared.responsibility	responsibilities	5
120	51	120	shared.responsibility	responsibilities	6
49	11	49	shared.responsibility	responsibilities	1
50	11	50	shared.responsibility	responsibilities	2
51	11	51	shared.responsibility	responsibilities	3
52	11	52	shared.responsibility	responsibilities	4
53	12	53	shared.responsibility	responsibilities	1
54	12	54	shared.responsibility	responsibilities	2
121	51	121	shared.responsibility	responsibilities	7
122	52	122	shared.responsibility	responsibilities	1
123	52	123	shared.responsibility	responsibilities	2
124	52	124	shared.responsibility	responsibilities	3
125	52	125	shared.responsibility	responsibilities	4
126	52	126	shared.responsibility	responsibilities	5
61	15	61	shared.responsibility	responsibilities	1
62	15	62	shared.responsibility	responsibilities	2
127	52	127	shared.responsibility	responsibilities	6
128	53	128	shared.responsibility	responsibilities	1
129	53	129	shared.responsibility	responsibilities	2
130	53	130	shared.responsibility	responsibilities	3
131	53	131	shared.responsibility	responsibilities	4
132	53	132	shared.responsibility	responsibilities	5
133	53	133	shared.responsibility	responsibilities	6
134	53	134	shared.responsibility	responsibilities	7
135	53	135	shared.responsibility	responsibilities	8
136	53	136	shared.responsibility	responsibilities	9
137	53	137	shared.responsibility	responsibilities	10
138	53	138	shared.responsibility	responsibilities	11
139	54	139	shared.responsibility	responsibilities	1
140	54	140	shared.responsibility	responsibilities	2
141	54	141	shared.responsibility	responsibilities	3
142	54	142	shared.responsibility	responsibilities	4
143	54	143	shared.responsibility	responsibilities	5
144	54	144	shared.responsibility	responsibilities	6
145	54	145	shared.responsibility	responsibilities	7
146	55	146	shared.responsibility	responsibilities	1
147	55	147	shared.responsibility	responsibilities	2
148	55	148	shared.responsibility	responsibilities	3
149	55	149	shared.responsibility	responsibilities	4
150	55	150	shared.responsibility	responsibilities	5
151	55	151	shared.responsibility	responsibilities	6
152	55	152	shared.responsibility	responsibilities	7
153	56	153	shared.responsibility	responsibilities	1
154	56	154	shared.responsibility	responsibilities	2
155	56	155	shared.responsibility	responsibilities	3
156	56	156	shared.responsibility	responsibilities	4
157	56	157	shared.responsibility	responsibilities	5
158	56	158	shared.responsibility	responsibilities	6
159	57	170	shared.responsibility	responsibilities	1
160	57	171	shared.responsibility	responsibilities	2
161	57	172	shared.responsibility	responsibilities	3
162	57	173	shared.responsibility	responsibilities	4
163	57	174	shared.responsibility	responsibilities	5
164	57	175	shared.responsibility	responsibilities	6
165	57	176	shared.responsibility	responsibilities	7
166	58	160	shared.responsibility	responsibilities	1
167	58	161	shared.responsibility	responsibilities	2
168	58	159	shared.responsibility	responsibilities	3
169	58	162	shared.responsibility	responsibilities	4
170	58	163	shared.responsibility	responsibilities	5
171	58	164	shared.responsibility	responsibilities	6
172	58	165	shared.responsibility	responsibilities	7
173	58	166	shared.responsibility	responsibilities	8
174	58	167	shared.responsibility	responsibilities	9
175	58	168	shared.responsibility	responsibilities	10
176	58	169	shared.responsibility	responsibilities	11
177	59	177	shared.responsibility	responsibilities	1
178	59	178	shared.responsibility	responsibilities	2
179	59	179	shared.responsibility	responsibilities	3
180	59	180	shared.responsibility	responsibilities	4
181	59	181	shared.responsibility	responsibilities	5
182	59	182	shared.responsibility	responsibilities	6
183	59	183	shared.responsibility	responsibilities	7
184	60	186	shared.responsibility	responsibilities	1
185	60	184	shared.responsibility	responsibilities	2
186	60	185	shared.responsibility	responsibilities	3
187	60	187	shared.responsibility	responsibilities	4
188	60	188	shared.responsibility	responsibilities	5
189	60	189	shared.responsibility	responsibilities	6
190	61	190	shared.responsibility	responsibilities	1
191	61	191	shared.responsibility	responsibilities	2
192	61	192	shared.responsibility	responsibilities	3
193	62	193	shared.responsibility	responsibilities	1
194	62	194	shared.responsibility	responsibilities	2
195	62	195	shared.responsibility	responsibilities	3
196	63	196	shared.responsibility	responsibilities	1
197	63	197	shared.responsibility	responsibilities	2
198	63	198	shared.responsibility	responsibilities	3
199	64	199	shared.responsibility	responsibilities	1
200	64	200	shared.responsibility	responsibilities	2
201	64	201	shared.responsibility	responsibilities	3
202	64	202	shared.responsibility	responsibilities	4
203	64	203	shared.responsibility	responsibilities	5
204	64	204	shared.responsibility	responsibilities	6
205	65	205	shared.responsibility	responsibilities	1
206	65	206	shared.responsibility	responsibilities	2
207	66	207	shared.responsibility	responsibilities	1
208	66	208	shared.responsibility	responsibilities	2
209	66	209	shared.responsibility	responsibilities	3
210	66	210	shared.responsibility	responsibilities	4
211	66	211	shared.responsibility	responsibilities	5
212	66	212	shared.responsibility	responsibilities	6
213	67	213	shared.responsibility	responsibilities	1
214	67	214	shared.responsibility	responsibilities	2
215	68	215	shared.responsibility	responsibilities	1
216	68	216	shared.responsibility	responsibilities	2
217	68	217	shared.responsibility	responsibilities	3
218	68	218	shared.responsibility	responsibilities	4
219	68	219	shared.responsibility	responsibilities	5
220	68	222	shared.responsibility	responsibilities	6
221	69	220	shared.responsibility	responsibilities	1
222	69	221	shared.responsibility	responsibilities	2
223	70	223	shared.responsibility	responsibilities	1
224	70	224	shared.responsibility	responsibilities	2
225	71	225	shared.responsibility	responsibilities	1
226	71	226	shared.responsibility	responsibilities	2
227	72	227	shared.responsibility	responsibilities	1
228	72	228	shared.responsibility	responsibilities	2
\.


--
-- Data for Name: components_shared_responsibilities; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_shared_responsibilities (id, description) FROM stdin;
1	Definição da arquitetura das soluções desde as primeiras discussões do projeto
2	Conversas diretas com clientes e equipes internas para entender necessidades e traduzir em requisitos claros
3	Implantação de pipelines de CI/CD, padrões de código, testes automatizados e boas práticas no GitHub
4	Gerenciamento dos repositórios dos projetos, workflows e versionamento
5	Revisão de código e acompanhamento da qualidade das entregas
6	Integração e colaboração com times internacionais (principalmente Argentina)
7	Desenvolvimento de soluções end-to-end de IA em cloud (AWS, Azure, GCP) para clientes corporativos
8	Plataformas de Análise Documental com classificação, extração e resumo automatizado com LLMs
9	Aplicações de Análise de Atendimento com Azure Speech + Azure OpenAI
10	Soluções RAG e Chatbots Corporativos com arquitetura híbrida Neo4j + busca vetorial
11	Visão Computacional para Vistorias com detecção e extração de informações em imagens
12	Desenvolvimento de soluções cloud-native focadas em LLMs, NLP, RAG e processamento de documentos
13	Chatbots jurídicos com RAG para verificação de conformidade normativa
14	Plataformas de extração de cláusulas críticas e análise de contratos com LLMs
15	Clusterização de tickets com lemmatização, embeddings e extração de tópicos
16	Sistemas de detecção de ocorrências e alertas automatizados
17	Desenvolvimento e deploy de soluções completas de visão computacional para setores alimentício, energia, varejo, saúde e logística
18	Detecção e classificação de produtos em linhas de produção e controle de qualidade
19	Detecção de EPIs, monitoramento de segurança e compliance no setor de energia
20	Sistema completo de reconhecimento facial com reidentificação em tempo real
21	Extração automática de dados via OCR para saúde e setor financeiro
97	Definição da arquitetura das soluções desde as primeiras discussões do projeto
98	Conversas diretas com clientes e equipes internas para entender necessidades e traduzir em requisitos claros
99	Implantação de pipelines de CI/CD, padrões de código, testes automatizados e boas práticas no GitHub
100	Gerenciamento dos repositórios dos projetos, workflows e versionamento
101	Revisão de código e acompanhamento da qualidade das entregas
102	Integração e colaboração com times internacionais (principalmente Argentina)
103	Desenvolvimento de aplicativo de vistoria com visão computacional para análises automáticas em campo
104	Criação de Hub de IA com test cases multimodais e chatbots usando RAG
105	Desenvolvimento de aplicação jurídica para análise automática de documentos, com OCR e classificação inteligente
106	Sistemas de detecção de anomalias e automação de compliance
107	Soluções de Text2SQL e consultas em linguagem natural utilizando LLMs
108	Desenvolvimento de soluções end-to-end de IA em cloud (AWS, Azure, GCP) para clientes corporativos
109	Sistemas de classificação, extração e resumo automatizado de documentos com LLMs, OCR avançado e busca vetorial (FAISS)
110	Transcrição e análise de áudios/chamadas com Azure Speech + Azure OpenAI, análise de sentimento e detecção de linguagem inadequada
111	Arquitetura híbrida Neo4j (grafos) + busca vetorial para soluções RAG e chatbots corporativos
112	Assistentes conversacionais com contexto multi-turno e plataforma de deploy automático de chatbots
113	Integração LLM + NLP + Speech-to-Text para análise multimodal unificada e validação de autenticidade documental
114	Detecção e extração de informações em imagens de vistoria com pipeline de processamento em tempo real
115	Chatbots jurídicos com RAG para verificação de conformidade normativa e criação automática de normativos
116	Sistema RAG com interface de chat, login, sessões e histórico em banco de dados
117	Plataformas de extração de cláusulas críticas, análise de contratos e detecção de adulterações em documentos
43	Navegação autônoma de robôs com odometria visual e reconhecimento de objetos usando câmeras de profundidade e lidars
44	Desenvolvimento de produto para reciclagem automática de resíduos residenciais com redes neurais convolucionais
45	Projeto de auxílio ao COVID-19: totem de medição de temperatura, classificação de uso de máscara e contagem de pessoas
118	Transcrição de áudios de baixa qualidade com extração estruturada e análise de conformidade
119	Clusterização de tickets com lemmatização, embeddings, extração de tópicos e análise de sentimento
120	Sistemas de detecção de ocorrências (furtos, golpes, filas, abandono de objetos) com alertas automatizados
49	Pesquisa em interpretação semântica de imagens e vídeos com deep learning no LABIC
50	Classificação de marca e modelo de veículos com redes neurais convolucionais
51	Segmentação de carroceria de veículos com Gene Expression Programming
52	Classificação de aves de rapina brasileiras com Deep Neural Networks
53	Configuração e manutenção de microcomputadores, redes e servidores web no LABIC
54	Rotulagem de bancos de dados para projetos de pesquisa
121	PoCs integrando Vertex AI, NLP e Speech-to-Text para análise multimodal
122	Detecção e classificação de produtos em linhas de produção, contagem e rastreamento de itens com dashboard em Grafana
123	Detecção de EPIs, monitoramento de segurança, identificação de placas e detecção de vazamentos no setor de energia
124	Contagem de pessoas, cálculo de tempo de permanência e detecção de abandono de objetos no varejo
125	Sistema completo de reconhecimento facial com captura, armazenamento e reidentificação em tempo real
126	Extração automática de informações de cartões de vacina e classificação de documentos financeiros com OCR
61	Vencedor do desafio MB University Award - desenvolvimento de business case para ferramenta de gestão logística
62	Ferramenta para controle de temperatura, frota de caminhões, roteirização e otimização de pallets
221	Desenvolvimento de servidores web e rotulagem de bases de dados
127	Contagem e rastreamento de veículos por câmeras para controle de pátio logístico
128	Definição da arquitetura das soluções desde as primeiras discussões do projeto
129	Conversas diretas com clientes e equipes internas para entender necessidades e traduzir em requisitos claros
130	Implantação de pipelines de CI/CD, padrões de código, testes automatizados e boas práticas no GitHub
131	Gerenciamento dos repositórios dos projetos, workflows e versionamento
132	Revisão de código e acompanhamento da qualidade das entregas
133	Integração e colaboração com times internacionais (principalmente Argentina)
134	Desenvolvimento de aplicativo de vistoria com visão computacional para análises automáticas em campo
135	Criação de Hub de IA com test cases multimodais e chatbots usando RAG
136	Desenvolvimento de aplicação jurídica para análise automática de documentos, com OCR e classificação inteligente
137	Sistemas de detecção de anomalias e automação de compliance
138	Soluções de Text2SQL e consultas em linguagem natural utilizando LLMs
139	Desenvolvimento de soluções end-to-end de IA em cloud (AWS, Azure, GCP) para clientes corporativos
140	Sistemas de classificação, extração e resumo automatizado de documentos com LLMs, OCR avançado e busca vetorial (FAISS)
141	Transcrição e análise de áudios/chamadas com Azure Speech + Azure OpenAI, análise de sentimento e detecção de linguagem inadequada
142	Arquitetura híbrida Neo4j (grafos) + busca vetorial para soluções RAG e chatbots corporativos
143	Assistentes conversacionais com contexto multi-turno e plataforma de deploy automático de chatbots
144	Integração LLM + NLP + Speech-to-Text para análise multimodal unificada e validação de autenticidade documental
145	Detecção e extração de informações em imagens de vistoria com pipeline de processamento em tempo real
146	Chatbots jurídicos com RAG para verificação de conformidade normativa e criação automática de normativos
147	Sistema RAG com interface de chat, login, sessões e histórico em banco de dados
148	Plataformas de extração de cláusulas críticas, análise de contratos e detecção de adulterações em documentos
149	Transcrição de áudios de baixa qualidade com extração estruturada e análise de conformidade
150	Clusterização de tickets com lemmatização, embeddings, extração de tópicos e análise de sentimento
151	Sistemas de detecção de ocorrências (furtos, golpes, filas, abandono de objetos) com alertas automatizados
152	PoCs integrando Vertex AI, NLP e Speech-to-Text para análise multimodal
153	Detecção e classificação de produtos em linhas de produção, contagem e rastreamento de itens com dashboard em Grafana
154	Detecção de EPIs, monitoramento de segurança, identificação de placas e detecção de vazamentos no setor de energia
155	Contagem de pessoas, cálculo de tempo de permanência e detecção de abandono de objetos no varejo
156	Sistema completo de reconhecimento facial com captura, armazenamento e reidentificação em tempo real
157	Extração automática de informações de cartões de vacina e classificação de documentos financeiros com OCR
158	Contagem e rastreamento de veículos por câmeras para controle de pátio logístico
159	Implantação de pipelines de CI/CD, padrões de código, testes automatizados e boas práticas no GitHub
160	Definição da arquitetura das soluções desde as primeiras discussões do projeto
161	Conversas diretas com clientes e equipes internas para entender necessidades e traduzir em requisitos claros
162	Gerenciamento dos repositórios dos projetos, workflows e versionamento
163	Revisão de código e acompanhamento da qualidade das entregas
164	Integração e colaboração com times internacionais (principalmente Argentina)
165	Desenvolvimento de aplicativo de vistoria com visão computacional para análises automáticas em campo
166	Criação de Hub de IA com test cases multimodais e chatbots usando RAG
167	Desenvolvimento de aplicação jurídica para análise automática de documentos, com OCR e classificação inteligente
168	Sistemas de detecção de anomalias e automação de compliance
169	Soluções de Text2SQL e consultas em linguagem natural utilizando LLMs
170	Desenvolvimento de soluções end-to-end de IA em cloud (AWS, Azure, GCP) para clientes corporativos
171	Sistemas de classificação, extração e resumo automatizado de documentos com LLMs, OCR avançado e busca vetorial (FAISS)
172	Transcrição e análise de áudios/chamadas com Azure Speech + Azure OpenAI, análise de sentimento e detecção de linguagem inadequada
173	Arquitetura híbrida Neo4j (grafos) + busca vetorial para soluções RAG e chatbots corporativos
174	Assistentes conversacionais com contexto multi-turno e plataforma de deploy automático de chatbots
175	Integração LLM + NLP + Speech-to-Text para análise multimodal unificada e validação de autenticidade documental
176	Detecção e extração de informações em imagens de vistoria com pipeline de processamento em tempo real
177	Chatbots jurídicos com RAG para verificação de conformidade normativa e criação automática de normativos
178	Sistema RAG com interface de chat, login, sessões e histórico em banco de dados
179	Plataformas de extração de cláusulas críticas, análise de contratos e detecção de adulterações em documentos
180	Transcrição de áudios de baixa qualidade com extração estruturada e análise de conformidade
181	Clusterização de tickets com lemmatização, embeddings, extração de tópicos e análise de sentimento
182	Sistemas de detecção de ocorrências (furtos, golpes, filas, abandono de objetos) com alertas automatizados
183	PoCs integrando Vertex AI, NLP e Speech-to-Text para análise multimodal
184	Detecção de EPIs, monitoramento de segurança, identificação de placas e detecção de vazamentos no setor de energia
185	Contagem de pessoas, cálculo de tempo de permanência e detecção de abandono de objetos no varejo
186	Detecção e classificação de produtos em linhas de produção, contagem e rastreamento de itens com dashboard em Grafana
187	Sistema completo de reconhecimento facial com captura, armazenamento e reidentificação em tempo real
188	Extração automática de informações de cartões de vacina e classificação de documentos financeiros com OCR
189	Contagem e rastreamento de veículos por câmeras para controle de pátio logístico
190	Navegação autônoma de robôs com odometria visual e reconhecimento de objetos usando câmeras de profundidade e lidars
191	Desenvolvimento de produto para reciclagem automática de resíduos residenciais com redes neurais convolucionais e recorrentes
192	Projeto de auxílio ao COVID-19: totem de medição de temperatura, classificação de uso de máscara facial e contagem de pessoas
193	Navegação autônoma de robôs com odometria visual e reconhecimento de objetos usando câmeras de profundidade e lidars
194	Desenvolvimento de produto para reciclagem automática de resíduos residenciais com redes neurais convolucionais e recorrentes
195	Projeto de auxílio ao COVID-19: totem de medição de temperatura, classificação de uso de máscara facial e contagem de pessoas
196	Navegação autônoma de robôs com odometria visual e reconhecimento de objetos usando câmeras de profundidade e lidars
197	Desenvolvimento de produto para reciclagem automática de resíduos residenciais com redes neurais convolucionais e recorrentes
198	Projeto de auxílio ao COVID-19: totem de medição de temperatura, classificação de uso de máscara facial e contagem de pessoas
199	Sistema de classificação de marca e modelo de veículos usando redes neurais convolucionais em câmeras de segurança
200	Método de template matching de imagens usando algoritmos bioinspirados (PSO e Evolução Diferencial) para localização de marcas de veículos
201	Sistema hierárquico de classificação de imagens para classificação multilabel de marca, modelo e carroceria de veículos
202	Aplicação de Gene Expression Programming para segmentação de carroceria e reconhecimento de cor de veículos
203	Aves de rapina brasileiras - novo dataset e classificação com redes neurais profundas
204	Desenvolvimento e manutenção de data lakes e data warehouses para consumo interno do laboratório
205	Configuração e manutenção de microcomputadores, instalação e configuração de redes
206	Desenvolvimento de servidores web e rotulagem de bases de dados
207	Sistema de classificação de marca e modelo de veículos usando redes neurais convolucionais em câmeras de segurança
208	Método de template matching de imagens usando algoritmos bioinspirados (PSO e Evolução Diferencial) para localização de marcas de veículos
209	Sistema hierárquico de classificação de imagens para classificação multilabel de marca, modelo e carroceria de veículos
210	Aplicação de Gene Expression Programming para segmentação de carroceria e reconhecimento de cor de veículos
211	Aves de rapina brasileiras - novo dataset e classificação com redes neurais profundas
212	Desenvolvimento e manutenção de data lakes e data warehouses para consumo interno do laboratório
213	Configuração e manutenção de microcomputadores, instalação e configuração de redes
214	Desenvolvimento de servidores web e rotulagem de bases de dados
215	Sistema de classificação de marca e modelo de veículos usando redes neurais convolucionais em câmeras de segurança
216	Método de template matching de imagens usando algoritmos bioinspirados (PSO e Evolução Diferencial) para localização de marcas de veículos
217	Sistema hierárquico de classificação de imagens para classificação multilabel de marca, modelo e carroceria de veículos
218	Aplicação de Gene Expression Programming para segmentação de carroceria e reconhecimento de cor de veículos
219	Aves de rapina brasileiras - novo dataset e classificação com redes neurais profundas
220	Configuração e manutenção de microcomputadores, instalação e configuração de redes
222	Desenvolvimento e manutenção de data lakes e data warehouses para consumo interno do laboratório
227	Vencedor do desafio MB University Award, com oportunidade de desenvolver um business case
228	Desenvolvimento de ferramenta para gestão e controle de setores logísticos: controle de temperatura em caminhões e armazéns, controle de frota, roteirização e otimizador de pallets
223	Vencedor do desafio MB University Award, com oportunidade de desenvolver um business case
224	Desenvolvimento de ferramenta para gestão e controle de setores logísticos: controle de temperatura em caminhões e armazéns, controle de frota, roteirização e otimizador de pallets
225	Vencedor do desafio MB University Award, com oportunidade de desenvolver um business case
226	Desenvolvimento de ferramenta para gestão e controle de setores logísticos: controle de temperatura em caminhões e armazéns, controle de frota, roteirização e otimizador de pallets
\.


--
-- Data for Name: components_shared_social_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_shared_social_links (id, platform, url, icon_name) FROM stdin;
1	linkedin	https://www.linkedin.com/in/lucasalbini	\N
2	github	https://github.com/lucasalbini	\N
3	email	mailto:lucasalbini@outlook.com	\N
7	linkedin	https://www.linkedin.com/in/lucasalbini	\N
8	github	https://github.com/lucasalbini	\N
9	email	mailto:lucasalbini@outlook.com	\N
10	linkedin	https://www.linkedin.com/in/lucasalbini	\N
11	github	https://github.com/lucasalbini	\N
12	email	mailto:lucasalbini@outlook.com	\N
13	linkedin	https://www.linkedin.com/in/lucasalbini	\N
14	github	https://github.com/lucasalbini	\N
15	email	mailto:lucasalbini@outlook.com	\N
\.


--
-- Data for Name: components_shared_soft_skills; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_shared_soft_skills (id, name, level) FROM stdin;
1	Liderança Técnica	\N
2	Arquitetura de Soluções	\N
3	Gestão de Equipe	\N
4	Comunicação com Stakeholders	\N
5	Resolução de Problemas	\N
6	Colaboração Internacional	\N
13	Liderança Técnica	\N
14	Arquitetura de Soluções	\N
15	Gestão de Equipe	\N
16	Comunicação com Stakeholders	\N
17	Resolução de Problemas	\N
18	Colaboração Internacional	\N
19	Liderança Técnica	\N
20	Arquitetura de Soluções	\N
21	Gestão de Equipe	\N
22	Comunicação com Stakeholders	\N
23	Resolução de Problemas	\N
24	Colaboração Internacional	\N
25	Liderança Técnica	\N
26	Arquitetura de Soluções	\N
27	Gestão de Equipe	\N
28	Comunicação com Stakeholders	\N
29	Resolução de Problemas	\N
30	Colaboração Internacional	\N
\.


--
-- Data for Name: educations; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.educations (id, document_id, institution, degree, field_of_study, start_date, end_date, description, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	v3e0gghp86gygv5fjwgiwf5a	Federal University of Technology - Paraná (UTFPR)	Bacharelado	Engenharia Mecânica	2014-01-01	2021-12-01	Formação em Engenharia Mecânica com foco em pesquisa em Visão Computacional e Inteligência Artificial no Laboratório de Bioinformática e Inteligência Computacional (LABIC).	2026-02-15 05:54:58.416	2026-02-15 05:55:52.45	\N	\N	\N	en
3	v3e0gghp86gygv5fjwgiwf5a	Federal University of Technology - Paraná (UTFPR)	Bacharelado	Engenharia Mecânica	2014-01-01	2021-12-01	Formação em Engenharia Mecânica com foco em pesquisa em Visão Computacional e Inteligência Artificial no Laboratório de Bioinformática e Inteligência Computacional (LABIC).	2026-02-15 05:54:58.416	2026-02-15 05:55:52.45	2026-02-15 05:55:52.467	\N	\N	en
4	v3e0gghp86gygv5fjwgiwf5a	Federal University of Technology - Paraná (UTFPR)	Bacharelado	Engenharia Mecânica	2014-01-01	2021-12-01	Formação em Engenharia Mecânica com foco em pesquisa em Visão Computacional e Inteligência Artificial no Laboratório de Bioinformática e Inteligência Computacional (LABIC).	2026-02-15 06:07:00.098	2026-02-15 06:07:00.098	\N	\N	\N	pt-BR
5	v3e0gghp86gygv5fjwgiwf5a	Federal University of Technology - Paraná (UTFPR)	Bacharelado	Engenharia Mecânica	2014-01-01	2021-12-01	Formação em Engenharia Mecânica com foco em pesquisa em Visão Computacional e Inteligência Artificial no Laboratório de Bioinformática e Inteligência Computacional (LABIC).	2026-02-15 06:07:00.098	2026-02-15 06:07:00.098	2026-02-15 06:07:00.105	\N	\N	pt-BR
6	wkg5y5xox79omjmnmz3s8o5l	Federal University of Technology - Paraná (UTFPR)	Tecnólogo	Mecatrônica	2014-01-01	2014-12-01		2026-02-15 07:33:53.873	2026-02-15 07:35:16.638	\N	1	1	pt-BR
7	wkg5y5xox79omjmnmz3s8o5l	Federal University of Technology - Paraná (UTFPR)	Tecnólogo	Mecatrônica	2014-01-01	2014-12-01		2026-02-15 07:33:53.873	2026-02-15 07:35:16.638	2026-02-15 07:35:16.66	1	1	pt-BR
\.


--
-- Data for Name: experiences; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.experiences (id, document_id, company_name, company_url, company_location, "order", created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	je6l7fnpzywunrj6pq9hi311	Atos	https://atos.net	São Paulo, Brasil	1	2026-02-15 05:54:58.101	2026-02-15 05:55:51.694	\N	\N	\N	en
3	msd6ok2xxlgdewnfidry4psz	33Robotics	\N	Curitiba, Brasil	2	2026-02-15 05:54:58.225	2026-02-15 05:55:51.881	\N	\N	\N	en
5	acoq5707z6f4l3eb00ov2hzn	Federal University of Technology - Paraná (UTFPR)	https://www.utfpr.edu.br	Curitiba, Brasil	3	2026-02-15 05:54:58.291	2026-02-15 05:55:52.045	\N	\N	\N	en
7	bm7iff33s3scv9sz6n72uk57	Martin Brower	\N	São Paulo, Brasil	4	2026-02-15 05:54:58.364	2026-02-15 05:55:52.241	\N	\N	\N	en
13	je6l7fnpzywunrj6pq9hi311	Atos	https://atos.net	São Paulo, Brasil	1	2026-02-15 06:06:59.392	2026-02-15 07:28:11.703	\N	\N	\N	pt-BR
21	je6l7fnpzywunrj6pq9hi311	Atos	https://atos.net	São Paulo, Brasil	1	2026-02-15 06:06:59.392	2026-02-15 07:28:11.703	2026-02-15 07:28:11.753	\N	\N	pt-BR
9	je6l7fnpzywunrj6pq9hi311	Atos	https://atos.net	São Paulo, Brasil	1	2026-02-15 05:54:58.101	2026-02-15 07:28:12.032	2026-02-15 05:55:51.751	\N	\N	en
15	msd6ok2xxlgdewnfidry4psz	33Robotics	\N	Curitiba, Brasil	2	2026-02-15 06:06:59.673	2026-02-15 07:28:40.092	\N	\N	\N	pt-BR
22	msd6ok2xxlgdewnfidry4psz	33Robotics	\N	Curitiba, Brasil	2	2026-02-15 06:06:59.673	2026-02-15 07:28:40.092	2026-02-15 07:28:40.114	\N	\N	pt-BR
10	msd6ok2xxlgdewnfidry4psz	33Robotics	\N	Curitiba, Brasil	2	2026-02-15 05:54:58.225	2026-02-15 07:28:40.194	2026-02-15 05:55:51.929	\N	\N	en
17	acoq5707z6f4l3eb00ov2hzn	Federal University of Technology - Paraná (UTFPR)	https://www.utfpr.edu.br	Curitiba, Brasil	3	2026-02-15 06:06:59.813	2026-02-15 07:28:40.28	\N	\N	\N	pt-BR
23	acoq5707z6f4l3eb00ov2hzn	Federal University of Technology - Paraná (UTFPR)	https://www.utfpr.edu.br	Curitiba, Brasil	3	2026-02-15 06:06:59.813	2026-02-15 07:28:40.28	2026-02-15 07:28:40.298	\N	\N	pt-BR
11	acoq5707z6f4l3eb00ov2hzn	Federal University of Technology - Paraná (UTFPR)	https://www.utfpr.edu.br	Curitiba, Brasil	3	2026-02-15 05:54:58.291	2026-02-15 07:28:40.384	2026-02-15 05:55:52.111	\N	\N	en
19	bm7iff33s3scv9sz6n72uk57	Martin Brower	\N	São Paulo, Brasil	4	2026-02-15 06:06:59.975	2026-02-15 07:28:40.501	\N	\N	\N	pt-BR
24	bm7iff33s3scv9sz6n72uk57	Martin Brower	\N	São Paulo, Brasil	4	2026-02-15 06:06:59.975	2026-02-15 07:28:40.501	2026-02-15 07:28:40.559	\N	\N	pt-BR
12	bm7iff33s3scv9sz6n72uk57	Martin Brower	\N	São Paulo, Brasil	4	2026-02-15 05:54:58.364	2026-02-15 07:28:40.659	2026-02-15 05:55:52.288	\N	\N	en
\.


--
-- Data for Name: experiences_cmps; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.experiences_cmps (id, entity_id, cmp_id, component_type, field, "order") FROM stdin;
1	1	1	shared.position	positions	1
2	1	2	shared.position	positions	2
3	1	3	shared.position	positions	3
4	1	4	shared.position	positions	4
9	3	9	shared.position	positions	1
11	5	11	shared.position	positions	1
12	5	12	shared.position	positions	2
15	7	15	shared.position	positions	1
49	13	49	shared.position	positions	1
50	13	50	shared.position	positions	2
51	13	51	shared.position	positions	3
52	13	52	shared.position	positions	4
53	21	53	shared.position	positions	1
54	21	54	shared.position	positions	2
55	21	55	shared.position	positions	3
56	21	56	shared.position	positions	4
57	9	58	shared.position	positions	1
58	9	57	shared.position	positions	2
59	9	59	shared.position	positions	3
60	9	60	shared.position	positions	4
61	15	61	shared.position	positions	1
62	22	62	shared.position	positions	1
63	10	63	shared.position	positions	1
64	17	64	shared.position	positions	1
65	17	65	shared.position	positions	2
66	23	66	shared.position	positions	1
67	23	67	shared.position	positions	2
68	11	68	shared.position	positions	1
69	11	69	shared.position	positions	2
70	19	70	shared.position	positions	1
71	24	71	shared.position	positions	1
72	12	72	shared.position	positions	1
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.files (id, document_id, name, alternative_text, caption, focal_point, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
3	dvibboryyjczsl3b5bd9xrpe	rag-post.jpg	\N	\N	\N	800	450	{"small": {"ext": ".jpg", "url": "/uploads/small_rag_post_cc302d3b0a.jpg", "hash": "small_rag_post_cc302d3b0a", "mime": "image/jpeg", "name": "small_rag-post.jpg", "path": null, "size": 38.77, "width": 500, "height": 281, "sizeInBytes": 38773}, "medium": {"ext": ".jpg", "url": "/uploads/medium_rag_post_cc302d3b0a.jpg", "hash": "medium_rag_post_cc302d3b0a", "mime": "image/jpeg", "name": "medium_rag-post.jpg", "path": null, "size": 79.75, "width": 750, "height": 422, "sizeInBytes": 79749}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_rag_post_cc302d3b0a.jpg", "hash": "thumbnail_rag_post_cc302d3b0a", "mime": "image/jpeg", "name": "thumbnail_rag-post.jpg", "path": null, "size": 10.41, "width": 245, "height": 138, "sizeInBytes": 10411}}	rag_post_cc302d3b0a	.jpg	image/jpeg	89.95	/uploads/rag_post_cc302d3b0a.jpg	\N	local	\N	/1	2026-02-15 07:58:06.983	2026-02-15 07:58:06.983	2026-02-15 07:58:06.984	\N	\N	\N
4	wjich2vvo62syymc2627t3t2	deploy-post.jpg	\N	\N	\N	800	523	{"small": {"ext": ".jpg", "url": "/uploads/small_deploy_post_dad8cdcf6d.jpg", "hash": "small_deploy_post_dad8cdcf6d", "mime": "image/jpeg", "name": "small_deploy-post.jpg", "path": null, "size": 16.15, "width": 500, "height": 327, "sizeInBytes": 16154}, "medium": {"ext": ".jpg", "url": "/uploads/medium_deploy_post_dad8cdcf6d.jpg", "hash": "medium_deploy_post_dad8cdcf6d", "mime": "image/jpeg", "name": "medium_deploy-post.jpg", "path": null, "size": 28.85, "width": 750, "height": 490, "sizeInBytes": 28845}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_deploy_post_dad8cdcf6d.jpg", "hash": "thumbnail_deploy_post_dad8cdcf6d", "mime": "image/jpeg", "name": "thumbnail_deploy-post.jpg", "path": null, "size": 5.82, "width": 239, "height": 156, "sizeInBytes": 5820}}	deploy_post_dad8cdcf6d	.jpg	image/jpeg	31.07	/uploads/deploy_post_dad8cdcf6d.jpg	\N	local	\N	/1	2026-02-15 07:58:07.183	2026-02-15 07:58:07.183	2026-02-15 07:58:07.183	\N	\N	\N
5	ok1hrdxjksjb6zstzkq08tki	kubernetes-post.jpg	\N	\N	\N	800	450	{"small": {"ext": ".jpg", "url": "/uploads/small_kubernetes_post_be484693ae.jpg", "hash": "small_kubernetes_post_be484693ae", "mime": "image/jpeg", "name": "small_kubernetes-post.jpg", "path": null, "size": 23.17, "width": 500, "height": 281, "sizeInBytes": 23167}, "medium": {"ext": ".jpg", "url": "/uploads/medium_kubernetes_post_be484693ae.jpg", "hash": "medium_kubernetes_post_be484693ae", "mime": "image/jpeg", "name": "medium_kubernetes-post.jpg", "path": null, "size": 39.66, "width": 750, "height": 422, "sizeInBytes": 39659}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_kubernetes_post_be484693ae.jpg", "hash": "thumbnail_kubernetes_post_be484693ae", "mime": "image/jpeg", "name": "thumbnail_kubernetes-post.jpg", "path": null, "size": 8.69, "width": 245, "height": 138, "sizeInBytes": 8687}}	kubernetes_post_be484693ae	.jpg	image/jpeg	43.13	/uploads/kubernetes_post_be484693ae.jpg	\N	local	\N	/1	2026-02-15 08:14:10.4	2026-02-15 08:14:10.4	2026-02-15 08:14:10.401	\N	\N	\N
6	a9j1m88vnkd9mrnv2fx87403	langchain-post.jpg	\N	\N	\N	800	450	{"small": {"ext": ".jpg", "url": "/uploads/small_langchain_post_75d2464704.jpg", "hash": "small_langchain_post_75d2464704", "mime": "image/jpeg", "name": "small_langchain-post.jpg", "path": null, "size": 38.7, "width": 500, "height": 281, "sizeInBytes": 38695}, "medium": {"ext": ".jpg", "url": "/uploads/medium_langchain_post_75d2464704.jpg", "hash": "medium_langchain_post_75d2464704", "mime": "image/jpeg", "name": "medium_langchain-post.jpg", "path": null, "size": 80.26, "width": 750, "height": 422, "sizeInBytes": 80259}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_langchain_post_75d2464704.jpg", "hash": "thumbnail_langchain_post_75d2464704", "mime": "image/jpeg", "name": "thumbnail_langchain-post.jpg", "path": null, "size": 10.42, "width": 245, "height": 138, "sizeInBytes": 10416}}	langchain_post_75d2464704	.jpg	image/jpeg	91.14	/uploads/langchain_post_75d2464704.jpg	\N	local	\N	/1	2026-02-15 08:14:10.605	2026-02-15 08:14:10.605	2026-02-15 08:14:10.606	\N	\N	\N
7	o97u8ykwe41k4qwup49pcorr	cicd-post.jpg	\N	\N	\N	800	450	{"small": {"ext": ".jpg", "url": "/uploads/small_cicd_post_8a9796d2ba.jpg", "hash": "small_cicd_post_8a9796d2ba", "mime": "image/jpeg", "name": "small_cicd-post.jpg", "path": null, "size": 28.52, "width": 500, "height": 281, "sizeInBytes": 28522}, "medium": {"ext": ".jpg", "url": "/uploads/medium_cicd_post_8a9796d2ba.jpg", "hash": "medium_cicd_post_8a9796d2ba", "mime": "image/jpeg", "name": "medium_cicd-post.jpg", "path": null, "size": 65.56, "width": 750, "height": 422, "sizeInBytes": 65559}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_cicd_post_8a9796d2ba.jpg", "hash": "thumbnail_cicd_post_8a9796d2ba", "mime": "image/jpeg", "name": "thumbnail_cicd-post.jpg", "path": null, "size": 7.12, "width": 245, "height": 138, "sizeInBytes": 7117}}	cicd_post_8a9796d2ba	.jpg	image/jpeg	74.12	/uploads/cicd_post_8a9796d2ba.jpg	\N	local	\N	/1	2026-02-15 08:14:10.809	2026-02-15 08:14:10.809	2026-02-15 08:14:10.81	\N	\N	\N
8	mzipusjm2lin7lyq8s3lt2nl	opencv-post.jpg	\N	\N	\N	800	450	{"small": {"ext": ".jpg", "url": "/uploads/small_opencv_post_ee6008d72b.jpg", "hash": "small_opencv_post_ee6008d72b", "mime": "image/jpeg", "name": "small_opencv-post.jpg", "path": null, "size": 29.65, "width": 500, "height": 281, "sizeInBytes": 29648}, "medium": {"ext": ".jpg", "url": "/uploads/medium_opencv_post_ee6008d72b.jpg", "hash": "medium_opencv_post_ee6008d72b", "mime": "image/jpeg", "name": "medium_opencv-post.jpg", "path": null, "size": 53.53, "width": 750, "height": 422, "sizeInBytes": 53525}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_opencv_post_ee6008d72b.jpg", "hash": "thumbnail_opencv_post_ee6008d72b", "mime": "image/jpeg", "name": "thumbnail_opencv-post.jpg", "path": null, "size": 9.77, "width": 245, "height": 138, "sizeInBytes": 9766}}	opencv_post_ee6008d72b	.jpg	image/jpeg	60.59	/uploads/opencv_post_ee6008d72b.jpg	\N	local	\N	/1	2026-02-15 08:14:11.009	2026-02-15 08:14:11.009	2026-02-15 08:14:11.009	\N	\N	\N
\.


--
-- Data for Name: files_folder_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.files_folder_lnk (id, file_id, folder_id, file_ord) FROM stdin;
1	3	1	1
2	4	1	2
3	5	1	3
4	6	1	4
5	7	1	5
6	8	1	6
\.


--
-- Data for Name: files_related_mph; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.files_related_mph (id, file_id, related_id, related_type, field, "order") FROM stdin;
1	3	1	api::post.post	featured_image	1
2	3	5	api::post.post	featured_image	1
3	4	3	api::post.post	featured_image	1
4	4	6	api::post.post	featured_image	1
5	5	7	api::post.post	featured_image	1
7	6	9	api::post.post	featured_image	1
9	7	11	api::post.post	featured_image	1
11	8	13	api::post.post	featured_image	1
13	5	15	api::post.post	featured_image	1
14	6	16	api::post.post	featured_image	1
15	7	17	api::post.post	featured_image	1
16	8	18	api::post.post	featured_image	1
\.


--
-- Data for Name: i18n_locale; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.i18n_locale (id, document_id, name, code, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	yxsz49xg48a6uu818kta7ui2	English (en)	en	2026-02-15 05:36:41.422	2026-02-15 05:36:41.422	2026-02-15 05:36:41.423	\N	\N	\N
2	w0m6qes3ylv0kolfuuk944ek	Portuguese (Brazil) (pt-BR)	pt-BR	2026-02-15 06:00:12.971	2026-02-15 06:00:12.971	2026-02-15 06:00:12.973	1	1	\N
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.posts (id, document_id, title, slug, content, excerpt, author, categories, tags, featured, reading_time, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
3	ukcsv0tgtospe2rshjtybi7i	Deploy de Modelos de ML com FastAPI e Docker	deploy-ml-fastapi-docker	## Introdução\n\nColocar modelos de machine learning em produção é um dos maiores desafios para equipes de dados. Neste artigo, vamos explorar como usar FastAPI e Docker para criar APIs robustas que servem modelos de ML.\n\n## Por que FastAPI?\n\nFastAPI se tornou o framework preferido para servir modelos de ML por vários motivos:\n\n- **Performance**: baseado em Starlette e uvicorn, é um dos frameworks Python mais rápidos\n- **Async nativo**: suporte a operações assíncronas out of the box\n- **Documentação automática**: Swagger UI gerado automaticamente\n- **Type hints**: validação de dados com Pydantic\n\n## Estrutura do Projeto\n\n```\nml-api/\n├── app/\n│   ├── main.py\n│   ├── model.py\n│   └── schemas.py\n├── models/\n│   └── model.pkl\n├── Dockerfile\n├── docker-compose.yml\n└── requirements.txt\n```\n\n## Criando a API\n\nO endpoint principal recebe os dados de entrada, faz o pré-processamento e retorna a predição do modelo.\n\n## Dockerizando\n\nCom Docker, garantimos que o ambiente de execução é idêntico em development e produção. O multi-stage build reduz o tamanho da imagem final.\n\n## Conclusão\n\nFastAPI + Docker é uma combinação poderosa para deploy de modelos de ML, oferecendo performance, facilidade de desenvolvimento e portabilidade.	Aprenda a servir modelos de machine learning em produção usando FastAPI para a API e Docker para containerização, com exemplos práticos.	Lucas Albini	["MLOps", "Backend"]	["FastAPI", "Docker", "Machine Learning", "Python", "Deploy"]	t	8	2026-02-15 07:56:12.095	2026-02-15 07:58:07.311	\N	\N	\N	pt-BR
9	kmy7xhh7ng20ih0ct1m6dwkw	Construindo Chatbots Inteligentes com LangChain e LLMs	chatbots-langchain-llms	## O Ecossistema LangChain\n\nLangChain é o framework mais popular para construir aplicações com LLMs. Ele fornece abstrações para chains, agents, memory e retrieval que simplificam enormemente o desenvolvimento.\n\n## Componentes Principais\n\n### Chains\nPermitem encadear chamadas de LLM com lógica de negócio. Uma chain típica pode:\n1. Receber input do usuário\n2. Buscar contexto relevante\n3. Formatar o prompt\n4. Chamar o LLM\n5. Processar a resposta\n\n### Agents\nAgentes são LLMs que podem usar ferramentas para completar tarefas. Eles decidem autonomamente quais ações tomar.\n\n### Memory\nSistemas de memória permitem conversas multi-turno com contexto persistente.\n\n## Integrações\n\n- **Bedrock**: Claude, Titan\n- **Azure OpenAI**: GPT-4, GPT-3.5\n- **Google AI**: Gemini Pro\n- **Hugging Face**: Modelos open-source\n\n## Padrão RAG com LangChain\n\nO padrão mais comum combina:\n- Document loaders para ingestão\n- Text splitters para chunking\n- Embeddings para vetorização\n- Vector stores (FAISS, Chroma, Pinecone)\n- Retrieval chains para Q&A\n\n## Conclusão\n\nLangChain democratizou o desenvolvimento com LLMs, tornando acessível a construção de chatbots sofisticados e sistemas RAG corporativos.	Guia prático para construir chatbots corporativos usando LangChain, integrando LLMs com ferramentas de busca e memória conversacional.	Lucas Albini	["IA", "Backend"]	["LangChain", "LLM", "Chatbot", "RAG", "Python"]	t	10	2026-02-15 08:15:05.834	2026-02-15 08:15:13.663	\N	\N	\N	pt-BR
1	y7oj9e74q369lkl5z6yqrrew	Introdução ao RAG: Retrieval Augmented Generation	introducao-ao-rag	## O que é RAG?\n\nRetrieval Augmented Generation (RAG) é uma técnica que combina modelos de linguagem com busca em bases de conhecimento externas. Em vez de depender apenas do conhecimento interno do modelo, o RAG permite que o LLM consulte documentos relevantes antes de gerar uma resposta.\n\n## Por que usar RAG?\n\nOs LLMs tradicionais têm limitações:\n\n- **Conhecimento desatualizado**: o modelo só conhece dados até a data de treinamento\n- **Alucinações**: pode gerar informações incorretas com confiança\n- **Sem dados proprietários**: não tem acesso a documentos internos da empresa\n\nO RAG resolve esses problemas ao conectar o modelo a fontes de dados atualizadas e confiáveis.\n\n## Arquitetura Básica\n\n1. **Indexação**: documentos são divididos em chunks e convertidos em embeddings vetoriais\n2. **Recuperação**: quando o usuário faz uma pergunta, os chunks mais relevantes são recuperados via busca semântica\n3. **Geração**: os chunks recuperados são incluídos no prompt do LLM como contexto\n\n## Ferramentas Populares\n\n- **LangChain**: framework mais popular para construir pipelines RAG\n- **LlamaIndex**: especializado em conectar LLMs a dados\n- **FAISS**: biblioteca de busca vetorial eficiente da Meta\n- **ChromaDB**: banco de dados vetorial open-source\n\n## Conclusão\n\nRAG é uma das técnicas mais práticas e eficientes para aplicar LLMs em cenários corporativos, onde precisão e atualidade dos dados são fundamentais.	Entenda como a técnica de Retrieval Augmented Generation combina LLMs com busca em bases de conhecimento para gerar respostas mais precisas e atualizadas.	Lucas Albini	["IA", "LLMs"]	["RAG", "LLM", "LangChain", "FAISS", "NLP"]	t	5	2026-02-15 07:56:12.023	2026-02-15 07:58:07.23	\N	\N	\N	pt-BR
5	y7oj9e74q369lkl5z6yqrrew	Introdução ao RAG: Retrieval Augmented Generation	introducao-ao-rag	## O que é RAG?\n\nRetrieval Augmented Generation (RAG) é uma técnica que combina modelos de linguagem com busca em bases de conhecimento externas. Em vez de depender apenas do conhecimento interno do modelo, o RAG permite que o LLM consulte documentos relevantes antes de gerar uma resposta.\n\n## Por que usar RAG?\n\nOs LLMs tradicionais têm limitações:\n\n- **Conhecimento desatualizado**: o modelo só conhece dados até a data de treinamento\n- **Alucinações**: pode gerar informações incorretas com confiança\n- **Sem dados proprietários**: não tem acesso a documentos internos da empresa\n\nO RAG resolve esses problemas ao conectar o modelo a fontes de dados atualizadas e confiáveis.\n\n## Arquitetura Básica\n\n1. **Indexação**: documentos são divididos em chunks e convertidos em embeddings vetoriais\n2. **Recuperação**: quando o usuário faz uma pergunta, os chunks mais relevantes são recuperados via busca semântica\n3. **Geração**: os chunks recuperados são incluídos no prompt do LLM como contexto\n\n## Ferramentas Populares\n\n- **LangChain**: framework mais popular para construir pipelines RAG\n- **LlamaIndex**: especializado em conectar LLMs a dados\n- **FAISS**: biblioteca de busca vetorial eficiente da Meta\n- **ChromaDB**: banco de dados vetorial open-source\n\n## Conclusão\n\nRAG é uma das técnicas mais práticas e eficientes para aplicar LLMs em cenários corporativos, onde precisão e atualidade dos dados são fundamentais.	Entenda como a técnica de Retrieval Augmented Generation combina LLMs com busca em bases de conhecimento para gerar respostas mais precisas e atualizadas.	Lucas Albini	["IA", "LLMs"]	["RAG", "LLM", "LangChain", "FAISS", "NLP"]	t	5	2026-02-15 07:56:12.023	2026-02-15 07:58:07.23	2026-02-15 07:58:07.241	\N	\N	pt-BR
6	ukcsv0tgtospe2rshjtybi7i	Deploy de Modelos de ML com FastAPI e Docker	deploy-ml-fastapi-docker	## Introdução\n\nColocar modelos de machine learning em produção é um dos maiores desafios para equipes de dados. Neste artigo, vamos explorar como usar FastAPI e Docker para criar APIs robustas que servem modelos de ML.\n\n## Por que FastAPI?\n\nFastAPI se tornou o framework preferido para servir modelos de ML por vários motivos:\n\n- **Performance**: baseado em Starlette e uvicorn, é um dos frameworks Python mais rápidos\n- **Async nativo**: suporte a operações assíncronas out of the box\n- **Documentação automática**: Swagger UI gerado automaticamente\n- **Type hints**: validação de dados com Pydantic\n\n## Estrutura do Projeto\n\n```\nml-api/\n├── app/\n│   ├── main.py\n│   ├── model.py\n│   └── schemas.py\n├── models/\n│   └── model.pkl\n├── Dockerfile\n├── docker-compose.yml\n└── requirements.txt\n```\n\n## Criando a API\n\nO endpoint principal recebe os dados de entrada, faz o pré-processamento e retorna a predição do modelo.\n\n## Dockerizando\n\nCom Docker, garantimos que o ambiente de execução é idêntico em development e produção. O multi-stage build reduz o tamanho da imagem final.\n\n## Conclusão\n\nFastAPI + Docker é uma combinação poderosa para deploy de modelos de ML, oferecendo performance, facilidade de desenvolvimento e portabilidade.	Aprenda a servir modelos de machine learning em produção usando FastAPI para a API e Docker para containerização, com exemplos práticos.	Lucas Albini	["MLOps", "Backend"]	["FastAPI", "Docker", "Machine Learning", "Python", "Deploy"]	t	8	2026-02-15 07:56:12.095	2026-02-15 07:58:07.311	2026-02-15 07:58:07.322	\N	\N	pt-BR
11	uxhobzi7vl41wi4f1u0enqea	CI/CD para Projetos de Inteligência Artificial	cicd-projetos-ia	## O Desafio do CI/CD em IA\n\nProjetos de IA têm desafios únicos de CI/CD: modelos precisam ser treinados, avaliados e versionados, além do código tradicional.\n\n## Pipeline Ideal\n\n### 1. Code Quality\n- Linting com Ruff/Black\n- Type checking com MyPy\n- Testes unitários com pytest\n- SonarQube para análise estática\n\n### 2. Data Validation\n- Great Expectations para validação de dados\n- Schema checks automáticos\n- Data drift detection\n\n### 3. Model Training & Evaluation\n- Training automatizado em GPU instances\n- Métricas de avaliação como gates\n- A/B testing de modelos\n- Model registry (MLflow, Weights & Biases)\n\n### 4. Deploy\n- Container build otimizado\n- Canary/Blue-Green deployments\n- Rollback automático por métricas\n\n## GitHub Actions para ML\n\nGitHub Actions é excelente para pipelines de ML:\n- Self-hosted runners com GPU\n- Matrix builds para múltiplos modelos\n- Artifact storage para modelos treinados\n- Integration com cloud providers\n\n## Monitoramento Pós-Deploy\n\n- Model performance monitoring\n- Data drift detection em produção\n- Alertas automáticos de degradação\n\n## Conclusão\n\nUm pipeline de CI/CD bem estruturado é essencial para manter a qualidade e confiabilidade de projetos de IA em produção.	Como implementar pipelines de CI/CD robustos para projetos de IA, incluindo validação de dados, treinamento automatizado e deploy seguro.	Lucas Albini	["DevOps", "MLOps"]	["CI/CD", "GitHub Actions", "MLOps", "DevOps", "Docker"]	f	6	2026-02-15 08:15:05.898	2026-02-15 08:15:13.72	\N	\N	\N	pt-BR
7	tpwr6bhb316b0id39a4b8027	Kubernetes para Deploy de Modelos de Machine Learning	kubernetes-ml-deploy	## Por que Kubernetes para ML?\n\nKubernetes se tornou a plataforma padrão para orquestração de containers e, consequentemente, para deploy de modelos de ML em produção. A escalabilidade automática e o gerenciamento declarativo de infraestrutura são fundamentais para workloads de IA.\n\n## Arquitetura\n\nUm pipeline típico de ML no Kubernetes inclui:\n\n- **Serving**: Triton Inference Server ou TensorFlow Serving\n- **Scaling**: HPA (Horizontal Pod Autoscaler) baseado em métricas custom\n- **GPU Support**: NVIDIA device plugin para aceleração\n- **Monitoring**: Prometheus + Grafana para métricas de inferência\n\n## Ferramentas Essenciais\n\n- **KServe**: Plataforma serverless para inferência\n- **Seldon Core**: Deploy e monitoramento de modelos\n- **MLflow**: Tracking de experimentos e model registry\n- **Kubeflow**: Pipeline completo de ML no K8s\n\n## Boas Práticas\n\n1. Use namespaces separados para staging e produção\n2. Implemente health checks customizados para seus modelos\n3. Configure resource limits adequados (especialmente para GPU)\n4. Use init containers para download de modelos do registry\n5. Implemente canary deployments para novos modelos\n\n## Conclusão\n\nKubernetes oferece a infraestrutura ideal para servir modelos de ML em escala, com ferramentas maduras e uma comunidade ativa.	Como usar Kubernetes para deploy escalável de modelos de ML em produção, com ferramentas como KServe, Triton e Kubeflow.	Lucas Albini	["Cloud", "MLOps"]	["Kubernetes", "MLOps", "Docker", "Deploy", "Cloud"]	f	7	2026-02-15 08:15:05.751	2026-02-15 08:15:13.605	\N	\N	\N	pt-BR
15	tpwr6bhb316b0id39a4b8027	Kubernetes para Deploy de Modelos de Machine Learning	kubernetes-ml-deploy	## Por que Kubernetes para ML?\n\nKubernetes se tornou a plataforma padrão para orquestração de containers e, consequentemente, para deploy de modelos de ML em produção. A escalabilidade automática e o gerenciamento declarativo de infraestrutura são fundamentais para workloads de IA.\n\n## Arquitetura\n\nUm pipeline típico de ML no Kubernetes inclui:\n\n- **Serving**: Triton Inference Server ou TensorFlow Serving\n- **Scaling**: HPA (Horizontal Pod Autoscaler) baseado em métricas custom\n- **GPU Support**: NVIDIA device plugin para aceleração\n- **Monitoring**: Prometheus + Grafana para métricas de inferência\n\n## Ferramentas Essenciais\n\n- **KServe**: Plataforma serverless para inferência\n- **Seldon Core**: Deploy e monitoramento de modelos\n- **MLflow**: Tracking de experimentos e model registry\n- **Kubeflow**: Pipeline completo de ML no K8s\n\n## Boas Práticas\n\n1. Use namespaces separados para staging e produção\n2. Implemente health checks customizados para seus modelos\n3. Configure resource limits adequados (especialmente para GPU)\n4. Use init containers para download de modelos do registry\n5. Implemente canary deployments para novos modelos\n\n## Conclusão\n\nKubernetes oferece a infraestrutura ideal para servir modelos de ML em escala, com ferramentas maduras e uma comunidade ativa.	Como usar Kubernetes para deploy escalável de modelos de ML em produção, com ferramentas como KServe, Triton e Kubeflow.	Lucas Albini	["Cloud", "MLOps"]	["Kubernetes", "MLOps", "Docker", "Deploy", "Cloud"]	f	7	2026-02-15 08:15:05.751	2026-02-15 08:15:13.605	2026-02-15 08:15:13.616	\N	\N	pt-BR
17	uxhobzi7vl41wi4f1u0enqea	CI/CD para Projetos de Inteligência Artificial	cicd-projetos-ia	## O Desafio do CI/CD em IA\n\nProjetos de IA têm desafios únicos de CI/CD: modelos precisam ser treinados, avaliados e versionados, além do código tradicional.\n\n## Pipeline Ideal\n\n### 1. Code Quality\n- Linting com Ruff/Black\n- Type checking com MyPy\n- Testes unitários com pytest\n- SonarQube para análise estática\n\n### 2. Data Validation\n- Great Expectations para validação de dados\n- Schema checks automáticos\n- Data drift detection\n\n### 3. Model Training & Evaluation\n- Training automatizado em GPU instances\n- Métricas de avaliação como gates\n- A/B testing de modelos\n- Model registry (MLflow, Weights & Biases)\n\n### 4. Deploy\n- Container build otimizado\n- Canary/Blue-Green deployments\n- Rollback automático por métricas\n\n## GitHub Actions para ML\n\nGitHub Actions é excelente para pipelines de ML:\n- Self-hosted runners com GPU\n- Matrix builds para múltiplos modelos\n- Artifact storage para modelos treinados\n- Integration com cloud providers\n\n## Monitoramento Pós-Deploy\n\n- Model performance monitoring\n- Data drift detection em produção\n- Alertas automáticos de degradação\n\n## Conclusão\n\nUm pipeline de CI/CD bem estruturado é essencial para manter a qualidade e confiabilidade de projetos de IA em produção.	Como implementar pipelines de CI/CD robustos para projetos de IA, incluindo validação de dados, treinamento automatizado e deploy seguro.	Lucas Albini	["DevOps", "MLOps"]	["CI/CD", "GitHub Actions", "MLOps", "DevOps", "Docker"]	f	6	2026-02-15 08:15:05.898	2026-02-15 08:15:13.72	2026-02-15 08:15:13.728	\N	\N	pt-BR
13	etfvard6abgpki0dkvhuyxjk	Visão Computacional na Indústria com OpenCV e Deep Learning	visao-computacional-industria-opencv	## Visão Computacional Industrial\n\nA visão computacional está revolucionando processos industriais, desde controle de qualidade até segurança do trabalho. Com OpenCV e modelos de deep learning, é possível automatizar inspeções que antes eram manuais.\n\n## Casos de Uso Reais\n\n### Controle de Qualidade\n- Detecção de defeitos em linhas de produção\n- Classificação automática de produtos\n- Contagem e rastreamento em tempo real\n\n### Segurança do Trabalho\n- Detecção de EPIs (capacetes, luvas, óculos)\n- Monitoramento de áreas restritas\n- Detecção de comportamentos de risco\n\n### Logística\n- Leitura automática de placas e etiquetas\n- Contagem de veículos e controle de pátio\n- Rastreamento de ativos\n\n## Stack Técnico\n\n### Modelos\n- **YOLO**: Detecção de objetos em tempo real\n- **Detectron2**: Segmentação de instâncias\n- **OpenPose**: Estimativa de pose humana\n\n### Otimização\n- **NVIDIA DeepStream**: Pipeline de vídeo otimizado\n- **Triton Inference Server**: Serving de modelos\n- **TensorRT**: Otimização para GPU\n\n### Infraestrutura\n- Edge computing com NVIDIA Jetson\n- Docker + Kubernetes para escalabilidade\n- RTSP/RTMP para streaming de câmeras\n\n## Desafios\n\n1. Qualidade e variabilidade das câmeras\n2. Iluminação inconsistente\n3. Latência em tempo real\n4. Custo de anotação de dados\n\n## Conclusão\n\nVisão computacional industrial é uma das aplicações mais impactantes de IA, com ROI mensurável e cases de sucesso em diversos setores.	Aplicações práticas de visão computacional na indústria usando OpenCV, YOLO e deep learning para controle de qualidade, segurança e logística.	Lucas Albini	["IA", "Visão Computacional"]	["OpenCV", "YOLO", "Deep Learning", "Computer Vision", "Python"]	t	8	2026-02-15 08:15:05.956	2026-02-15 08:15:13.77	\N	\N	\N	pt-BR
16	kmy7xhh7ng20ih0ct1m6dwkw	Construindo Chatbots Inteligentes com LangChain e LLMs	chatbots-langchain-llms	## O Ecossistema LangChain\n\nLangChain é o framework mais popular para construir aplicações com LLMs. Ele fornece abstrações para chains, agents, memory e retrieval que simplificam enormemente o desenvolvimento.\n\n## Componentes Principais\n\n### Chains\nPermitem encadear chamadas de LLM com lógica de negócio. Uma chain típica pode:\n1. Receber input do usuário\n2. Buscar contexto relevante\n3. Formatar o prompt\n4. Chamar o LLM\n5. Processar a resposta\n\n### Agents\nAgentes são LLMs que podem usar ferramentas para completar tarefas. Eles decidem autonomamente quais ações tomar.\n\n### Memory\nSistemas de memória permitem conversas multi-turno com contexto persistente.\n\n## Integrações\n\n- **Bedrock**: Claude, Titan\n- **Azure OpenAI**: GPT-4, GPT-3.5\n- **Google AI**: Gemini Pro\n- **Hugging Face**: Modelos open-source\n\n## Padrão RAG com LangChain\n\nO padrão mais comum combina:\n- Document loaders para ingestão\n- Text splitters para chunking\n- Embeddings para vetorização\n- Vector stores (FAISS, Chroma, Pinecone)\n- Retrieval chains para Q&A\n\n## Conclusão\n\nLangChain democratizou o desenvolvimento com LLMs, tornando acessível a construção de chatbots sofisticados e sistemas RAG corporativos.	Guia prático para construir chatbots corporativos usando LangChain, integrando LLMs com ferramentas de busca e memória conversacional.	Lucas Albini	["IA", "Backend"]	["LangChain", "LLM", "Chatbot", "RAG", "Python"]	t	10	2026-02-15 08:15:05.834	2026-02-15 08:15:13.663	2026-02-15 08:15:13.675	\N	\N	pt-BR
18	etfvard6abgpki0dkvhuyxjk	Visão Computacional na Indústria com OpenCV e Deep Learning	visao-computacional-industria-opencv	## Visão Computacional Industrial\n\nA visão computacional está revolucionando processos industriais, desde controle de qualidade até segurança do trabalho. Com OpenCV e modelos de deep learning, é possível automatizar inspeções que antes eram manuais.\n\n## Casos de Uso Reais\n\n### Controle de Qualidade\n- Detecção de defeitos em linhas de produção\n- Classificação automática de produtos\n- Contagem e rastreamento em tempo real\n\n### Segurança do Trabalho\n- Detecção de EPIs (capacetes, luvas, óculos)\n- Monitoramento de áreas restritas\n- Detecção de comportamentos de risco\n\n### Logística\n- Leitura automática de placas e etiquetas\n- Contagem de veículos e controle de pátio\n- Rastreamento de ativos\n\n## Stack Técnico\n\n### Modelos\n- **YOLO**: Detecção de objetos em tempo real\n- **Detectron2**: Segmentação de instâncias\n- **OpenPose**: Estimativa de pose humana\n\n### Otimização\n- **NVIDIA DeepStream**: Pipeline de vídeo otimizado\n- **Triton Inference Server**: Serving de modelos\n- **TensorRT**: Otimização para GPU\n\n### Infraestrutura\n- Edge computing com NVIDIA Jetson\n- Docker + Kubernetes para escalabilidade\n- RTSP/RTMP para streaming de câmeras\n\n## Desafios\n\n1. Qualidade e variabilidade das câmeras\n2. Iluminação inconsistente\n3. Latência em tempo real\n4. Custo de anotação de dados\n\n## Conclusão\n\nVisão computacional industrial é uma das aplicações mais impactantes de IA, com ROI mensurável e cases de sucesso em diversos setores.	Aplicações práticas de visão computacional na indústria usando OpenCV, YOLO e deep learning para controle de qualidade, segurança e logística.	Lucas Albini	["IA", "Visão Computacional"]	["OpenCV", "YOLO", "Deep Learning", "Computer Vision", "Python"]	t	8	2026-02-15 08:15:05.956	2026-02-15 08:15:13.77	2026-02-15 08:15:13.781	\N	\N	pt-BR
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.profiles (id, document_id, name, designation, company, location, summary, typing_titles, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	r9eomm5frmt1uup7poyp12lt	Lucas Albini	Tech Lead em IA	Atos	Curitiba, Paraná, Brasil	Tech Lead com sólida experiência em desenvolvimento e arquitetura de soluções de Inteligência Artificial end-to-end. Especialista em liderar times de forma estratégica para construção de aplicações complexas envolvendo IA Generativa, Large Language Models (LLMs), RAG, Visão Computacional e Machine Learning.\n\nApaixonado por tecnologia desde criança, busco constantemente aplicar IA de forma prática para resolver problemas reais de negócio, mantendo sempre o foco em qualidade, escalabilidade e melhores práticas de engenharia.	["Tech Lead em IA", "Especialista em GenAI", "4x AWS Certified", "Computer Vision Engineer", "Machine Learning Engineer"]	2026-02-15 05:54:57.916	2026-02-15 05:55:55.063	\N	\N	\N	en
3	r9eomm5frmt1uup7poyp12lt	Lucas Albini	Tech Lead em IA	Atos	Curitiba, Paraná, Brasil	Tech Lead com sólida experiência em desenvolvimento e arquitetura de soluções de Inteligência Artificial end-to-end. Especialista em liderar times de forma estratégica para construção de aplicações complexas envolvendo IA Generativa, Large Language Models (LLMs), RAG, Visão Computacional e Machine Learning.\n\nApaixonado por tecnologia desde criança, busco constantemente aplicar IA de forma prática para resolver problemas reais de negócio, mantendo sempre o foco em qualidade, escalabilidade e melhores práticas de engenharia.	["Tech Lead em IA", "Especialista em GenAI", "4x AWS Certified", "Computer Vision Engineer", "Machine Learning Engineer"]	2026-02-15 05:54:57.916	2026-02-15 05:55:55.063	2026-02-15 05:55:55.095	\N	\N	en
4	r9eomm5frmt1uup7poyp12lt	Lucas Albini	Tech Lead em IA	Atos	Curitiba, Paraná, Brasil	Tech Lead com sólida experiência em desenvolvimento e arquitetura de soluções de Inteligência Artificial end-to-end. Especialista em liderar times de forma estratégica para construção de aplicações complexas envolvendo IA Generativa, Large Language Models (LLMs), RAG, Visão Computacional e Machine Learning.\n\nApaixonado por tecnologia desde criança, busco constantemente aplicar IA de forma prática para resolver problemas reais de negócio, mantendo sempre o foco em qualidade, escalabilidade e melhores práticas de engenharia.	["Tech Lead em IA", "Especialista em GenAI", "4x AWS Certified", "Computer Vision Engineer", "Machine Learning Engineer"]	2026-02-15 06:06:59.226	2026-02-15 06:06:59.226	\N	\N	\N	pt-BR
5	r9eomm5frmt1uup7poyp12lt	Lucas Albini	Tech Lead em IA	Atos	Curitiba, Paraná, Brasil	Tech Lead com sólida experiência em desenvolvimento e arquitetura de soluções de Inteligência Artificial end-to-end. Especialista em liderar times de forma estratégica para construção de aplicações complexas envolvendo IA Generativa, Large Language Models (LLMs), RAG, Visão Computacional e Machine Learning.\n\nApaixonado por tecnologia desde criança, busco constantemente aplicar IA de forma prática para resolver problemas reais de negócio, mantendo sempre o foco em qualidade, escalabilidade e melhores práticas de engenharia.	["Tech Lead em IA", "Especialista em GenAI", "4x AWS Certified", "Computer Vision Engineer", "Machine Learning Engineer"]	2026-02-15 06:06:59.226	2026-02-15 06:06:59.226	2026-02-15 06:06:59.245	\N	\N	pt-BR
\.


--
-- Data for Name: profiles_cmps; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.profiles_cmps (id, entity_id, cmp_id, component_type, field, "order") FROM stdin;
1	1	1	shared.social-link	social_links	1
2	1	2	shared.social-link	social_links	2
3	1	3	shared.social-link	social_links	3
4	1	1	shared.soft-skill	soft_skills	1
5	1	2	shared.soft-skill	soft_skills	2
6	1	3	shared.soft-skill	soft_skills	3
7	1	4	shared.soft-skill	soft_skills	4
8	1	5	shared.soft-skill	soft_skills	5
9	1	6	shared.soft-skill	soft_skills	6
19	3	7	shared.social-link	social_links	1
20	3	8	shared.social-link	social_links	2
21	3	9	shared.social-link	social_links	3
22	3	13	shared.soft-skill	soft_skills	1
23	3	14	shared.soft-skill	soft_skills	2
24	3	15	shared.soft-skill	soft_skills	3
25	3	16	shared.soft-skill	soft_skills	4
26	3	17	shared.soft-skill	soft_skills	5
27	3	18	shared.soft-skill	soft_skills	6
28	4	10	shared.social-link	social_links	1
29	4	11	shared.social-link	social_links	2
30	4	12	shared.social-link	social_links	3
31	4	19	shared.soft-skill	soft_skills	1
32	4	20	shared.soft-skill	soft_skills	2
33	4	21	shared.soft-skill	soft_skills	3
34	4	22	shared.soft-skill	soft_skills	4
35	4	23	shared.soft-skill	soft_skills	5
36	4	24	shared.soft-skill	soft_skills	6
37	5	13	shared.social-link	social_links	1
38	5	14	shared.social-link	social_links	2
39	5	15	shared.social-link	social_links	3
40	5	25	shared.soft-skill	soft_skills	1
41	5	26	shared.soft-skill	soft_skills	2
42	5	27	shared.soft-skill	soft_skills	3
43	5	28	shared.soft-skill	soft_skills	4
44	5	29	shared.soft-skill	soft_skills	5
45	5	30	shared.soft-skill	soft_skills	6
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.projects (id, document_id, name, slug, description, role, timeline, repo_url, demo_url, tags, category, featured, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: publications; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.publications (id, document_id, title, journal, authors, date, url, doi, abstract, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	f3fr9i4qpghogco2ycrnyhtc	A Gene Expression Programming Approach for Vehicle Body Segmentation and Color Recognition	\N	Lucas Albini et al.	\N	\N	\N	Aplicação de Gene Expression Programming para segmentação de carroceria de veículos e reconhecimento de cores.	2026-02-15 05:54:59.285	2026-02-15 05:55:54.95	\N	\N	\N	en
7	f3fr9i4qpghogco2ycrnyhtc	A Gene Expression Programming Approach for Vehicle Body Segmentation and Color Recognition	\N	Lucas Albini et al.	\N	\N	\N	Aplicação de Gene Expression Programming para segmentação de carroceria de veículos e reconhecimento de cores.	2026-02-15 05:54:59.285	2026-02-15 05:55:54.95	2026-02-15 05:55:54.956	\N	\N	en
3	dxkr1sg4zgd5q8rj8mel0hg4	Deep Learning for Brazilian Car Make and Model Recognition	\N	Lucas Albini et al.	\N	\N	\N	Sistema de classificação de marca e modelo de carros brasileiros utilizando deep learning através de câmeras de segurança.	2026-02-15 05:54:59.316	2026-02-15 05:55:54.983	\N	\N	\N	en
8	dxkr1sg4zgd5q8rj8mel0hg4	Deep Learning for Brazilian Car Make and Model Recognition	\N	Lucas Albini et al.	\N	\N	\N	Sistema de classificação de marca e modelo de carros brasileiros utilizando deep learning através de câmeras de segurança.	2026-02-15 05:54:59.316	2026-02-15 05:55:54.983	2026-02-15 05:55:54.991	\N	\N	en
5	wk68kyy197y7ufyg4k9u7fbj	Brazilian Birds of Prey - A New Dataset and Classification with Deep Neural Networks	\N	Lucas Albini et al.	\N	\N	\N	Novo dataset e classificação de aves de rapina brasileiras utilizando redes neurais profundas.	2026-02-15 05:54:59.347	2026-02-15 05:55:55.016	\N	\N	\N	en
9	wk68kyy197y7ufyg4k9u7fbj	Brazilian Birds of Prey - A New Dataset and Classification with Deep Neural Networks	\N	Lucas Albini et al.	\N	\N	\N	Novo dataset e classificação de aves de rapina brasileiras utilizando redes neurais profundas.	2026-02-15 05:54:59.347	2026-02-15 05:55:55.016	2026-02-15 05:55:55.024	\N	\N	en
10	f3fr9i4qpghogco2ycrnyhtc	A Gene Expression Programming Approach for Vehicle Body Segmentation and Color Recognition	\N	Lucas Albini et al.	\N	\N	\N	Aplicação de Gene Expression Programming para segmentação de carroceria de veículos e reconhecimento de cores.	2026-02-15 06:07:01.332	2026-02-15 06:07:01.332	\N	\N	\N	pt-BR
11	f3fr9i4qpghogco2ycrnyhtc	A Gene Expression Programming Approach for Vehicle Body Segmentation and Color Recognition	\N	Lucas Albini et al.	\N	\N	\N	Aplicação de Gene Expression Programming para segmentação de carroceria de veículos e reconhecimento de cores.	2026-02-15 06:07:01.332	2026-02-15 06:07:01.332	2026-02-15 06:07:01.336	\N	\N	pt-BR
12	dxkr1sg4zgd5q8rj8mel0hg4	Deep Learning for Brazilian Car Make and Model Recognition	\N	Lucas Albini et al.	\N	\N	\N	Sistema de classificação de marca e modelo de carros brasileiros utilizando deep learning através de câmeras de segurança.	2026-02-15 06:07:01.363	2026-02-15 06:07:01.363	\N	\N	\N	pt-BR
13	dxkr1sg4zgd5q8rj8mel0hg4	Deep Learning for Brazilian Car Make and Model Recognition	\N	Lucas Albini et al.	\N	\N	\N	Sistema de classificação de marca e modelo de carros brasileiros utilizando deep learning através de câmeras de segurança.	2026-02-15 06:07:01.363	2026-02-15 06:07:01.363	2026-02-15 06:07:01.369	\N	\N	pt-BR
14	wk68kyy197y7ufyg4k9u7fbj	Brazilian Birds of Prey - A New Dataset and Classification with Deep Neural Networks	\N	Lucas Albini et al.	\N	\N	\N	Novo dataset e classificação de aves de rapina brasileiras utilizando redes neurais profundas.	2026-02-15 06:07:01.392	2026-02-15 06:07:01.392	\N	\N	\N	pt-BR
15	wk68kyy197y7ufyg4k9u7fbj	Brazilian Birds of Prey - A New Dataset and Classification with Deep Neural Networks	\N	Lucas Albini et al.	\N	\N	\N	Novo dataset e classificação de aves de rapina brasileiras utilizando redes neurais profundas.	2026-02-15 06:07:01.392	2026-02-15 06:07:01.392	2026-02-15 06:07:01.396	\N	\N	pt-BR
\.


--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.skills (id, document_id, name, icon_name, summary, category, url, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	zxc0eyp042g06x6a0pdocyij	Python	SiPython	\N	language	\N	2026-02-15 05:54:58.466	2026-02-15 05:55:52.586	\N	\N	\N	en
43	zxc0eyp042g06x6a0pdocyij	Python	SiPython	\N	language	\N	2026-02-15 05:54:58.466	2026-02-15 05:55:52.586	2026-02-15 05:55:52.62	\N	\N	en
3	thzz2uf64tclfnyddhyz1j5i	TypeScript	SiTypescript	\N	language	\N	2026-02-15 05:54:58.506	2026-02-15 05:55:52.695	\N	\N	\N	en
44	thzz2uf64tclfnyddhyz1j5i	TypeScript	SiTypescript	\N	language	\N	2026-02-15 05:54:58.506	2026-02-15 05:55:52.695	2026-02-15 05:55:52.727	\N	\N	en
5	v3ay3h6h1wicge0xtzoe98sw	Go	SiGo	\N	language	\N	2026-02-15 05:54:58.538	2026-02-15 05:55:52.793	\N	\N	\N	en
45	v3ay3h6h1wicge0xtzoe98sw	Go	SiGo	\N	language	\N	2026-02-15 05:54:58.538	2026-02-15 05:55:52.793	2026-02-15 05:55:52.817	\N	\N	en
7	zskjp6y6xbalfziwznmwdchw	FastAPI	SiFastapi	\N	framework	\N	2026-02-15 05:54:58.569	2026-02-15 05:55:52.884	\N	\N	\N	en
46	zskjp6y6xbalfziwznmwdchw	FastAPI	SiFastapi	\N	framework	\N	2026-02-15 05:54:58.569	2026-02-15 05:55:52.884	2026-02-15 05:55:52.913	\N	\N	en
9	tpey9n67cf7tk9ogc734a9b1	React	SiReact	\N	framework	\N	2026-02-15 05:54:58.608	2026-02-15 05:55:52.975	\N	\N	\N	en
47	tpey9n67cf7tk9ogc734a9b1	React	SiReact	\N	framework	\N	2026-02-15 05:54:58.608	2026-02-15 05:55:52.975	2026-02-15 05:55:52.998	\N	\N	en
11	wx8ese0th9jzgq7cehzlkdat	Next.js	SiNextdotjs	\N	framework	\N	2026-02-15 05:54:58.645	2026-02-15 05:55:53.049	\N	\N	\N	en
48	wx8ese0th9jzgq7cehzlkdat	Next.js	SiNextdotjs	\N	framework	\N	2026-02-15 05:54:58.645	2026-02-15 05:55:53.049	2026-02-15 05:55:53.062	\N	\N	en
13	icunppq91iqruk2dir4wziel	LangChain	\N	\N	framework	\N	2026-02-15 05:54:58.678	2026-02-15 05:55:53.116	\N	\N	\N	en
49	icunppq91iqruk2dir4wziel	LangChain	\N	\N	framework	\N	2026-02-15 05:54:58.678	2026-02-15 05:55:53.116	2026-02-15 05:55:53.134	\N	\N	en
15	awtu1zf1q3ggaes9l97z63n9	LlamaIndex	\N	\N	framework	\N	2026-02-15 05:54:58.712	2026-02-15 05:55:53.195	\N	\N	\N	en
50	awtu1zf1q3ggaes9l97z63n9	LlamaIndex	\N	\N	framework	\N	2026-02-15 05:54:58.712	2026-02-15 05:55:53.195	2026-02-15 05:55:53.207	\N	\N	en
17	fj0vl93dwof860ulajc1ssai	AWS	SiAmazonwebservices	\N	cloud	\N	2026-02-15 05:54:58.74	2026-02-15 05:55:53.234	\N	\N	\N	en
51	fj0vl93dwof860ulajc1ssai	AWS	SiAmazonwebservices	\N	cloud	\N	2026-02-15 05:54:58.74	2026-02-15 05:55:53.234	2026-02-15 05:55:53.243	\N	\N	en
19	xn2j6rzrvlzd8jhvnaar312z	Azure	SiMicrosoftazure	\N	cloud	\N	2026-02-15 05:54:58.766	2026-02-15 05:55:53.27	\N	\N	\N	en
52	xn2j6rzrvlzd8jhvnaar312z	Azure	SiMicrosoftazure	\N	cloud	\N	2026-02-15 05:54:58.766	2026-02-15 05:55:53.27	2026-02-15 05:55:53.28	\N	\N	en
21	y8lyizzdwqo8xrtwccf6rl4s	GCP	SiGooglecloud	\N	cloud	\N	2026-02-15 05:54:58.796	2026-02-15 05:55:53.305	\N	\N	\N	en
53	y8lyizzdwqo8xrtwccf6rl4s	GCP	SiGooglecloud	\N	cloud	\N	2026-02-15 05:54:58.796	2026-02-15 05:55:53.305	2026-02-15 05:55:41.075	\N	\N	en
23	vit1hn3rdmrvjtqzui1ro5t6	TensorFlow	SiTensorflow	\N	ai_ml	\N	2026-02-15 05:54:58.83	2026-02-15 05:55:41.106	\N	\N	\N	en
54	vit1hn3rdmrvjtqzui1ro5t6	TensorFlow	SiTensorflow	\N	ai_ml	\N	2026-02-15 05:54:58.83	2026-02-15 05:55:41.106	2026-02-15 05:55:41.119	\N	\N	en
25	js4mvlw9vvljo2hahbf2ttjv	PyTorch	SiPytorch	\N	ai_ml	\N	2026-02-15 05:54:58.859	2026-02-15 05:55:41.146	\N	\N	\N	en
55	js4mvlw9vvljo2hahbf2ttjv	PyTorch	SiPytorch	\N	ai_ml	\N	2026-02-15 05:54:58.859	2026-02-15 05:55:41.146	2026-02-15 05:55:41.157	\N	\N	en
27	co87qyov2vmgn8iqhyy3v7sj	OpenCV	SiOpencv	\N	ai_ml	\N	2026-02-15 05:54:58.884	2026-02-15 05:55:41.185	\N	\N	\N	en
56	co87qyov2vmgn8iqhyy3v7sj	OpenCV	SiOpencv	\N	ai_ml	\N	2026-02-15 05:54:58.884	2026-02-15 05:55:41.185	2026-02-15 05:55:41.197	\N	\N	en
29	i3hrhkwwwmqbk6xqlgm7skpj	YOLO	\N	\N	ai_ml	\N	2026-02-15 05:54:58.916	2026-02-15 05:55:41.229	\N	\N	\N	en
57	i3hrhkwwwmqbk6xqlgm7skpj	YOLO	\N	\N	ai_ml	\N	2026-02-15 05:54:58.916	2026-02-15 05:55:41.229	2026-02-15 05:55:41.241	\N	\N	en
31	t2kzqlm5snslcai517h7vzd1	OpenAI API	\N	\N	ai_ml	\N	2026-02-15 05:54:58.944	2026-02-15 05:55:54.463	\N	\N	\N	en
58	t2kzqlm5snslcai517h7vzd1	OpenAI API	\N	\N	ai_ml	\N	2026-02-15 05:54:58.944	2026-02-15 05:55:54.463	2026-02-15 05:55:54.474	\N	\N	en
33	g43gbdqrz8698i9lw9hw3az4	Anthropic Claude	\N	\N	ai_ml	\N	2026-02-15 05:54:58.976	2026-02-15 05:55:54.502	\N	\N	\N	en
59	g43gbdqrz8698i9lw9hw3az4	Anthropic Claude	\N	\N	ai_ml	\N	2026-02-15 05:54:58.976	2026-02-15 05:55:54.502	2026-02-15 05:55:54.51	\N	\N	en
35	j1hcsjh01hckpxphswbqlaef	Docker	SiDocker	\N	devops	\N	2026-02-15 05:54:59.002	2026-02-15 05:55:54.539	\N	\N	\N	en
60	j1hcsjh01hckpxphswbqlaef	Docker	SiDocker	\N	devops	\N	2026-02-15 05:54:59.002	2026-02-15 05:55:54.539	2026-02-15 05:55:54.555	\N	\N	en
37	wmvt92dojtwjrfkdowxkunrv	Kubernetes	SiKubernetes	\N	devops	\N	2026-02-15 05:54:59.031	2026-02-15 05:55:54.59	\N	\N	\N	en
61	wmvt92dojtwjrfkdowxkunrv	Kubernetes	SiKubernetes	\N	devops	\N	2026-02-15 05:54:59.031	2026-02-15 05:55:54.59	2026-02-15 05:55:54.602	\N	\N	en
39	csfmznvdj2zleu5qz9oaw3gg	GitHub Actions	\N	\N	devops	\N	2026-02-15 05:54:59.062	2026-02-15 05:55:54.63	\N	\N	\N	en
62	csfmznvdj2zleu5qz9oaw3gg	GitHub Actions	\N	\N	devops	\N	2026-02-15 05:54:59.062	2026-02-15 05:55:54.63	2026-02-15 05:55:54.644	\N	\N	en
41	arngnnnzn6esrpgxws6j2f7e	SonarQube	\N	\N	devops	\N	2026-02-15 05:54:59.093	2026-02-15 05:55:54.681	\N	\N	\N	en
63	arngnnnzn6esrpgxws6j2f7e	SonarQube	\N	\N	devops	\N	2026-02-15 05:54:59.093	2026-02-15 05:55:54.681	2026-02-15 05:55:54.694	\N	\N	en
64	zxc0eyp042g06x6a0pdocyij	Python	SiPython	\N	language	\N	2026-02-15 06:07:00.169	2026-02-15 06:07:00.169	\N	\N	\N	pt-BR
65	zxc0eyp042g06x6a0pdocyij	Python	SiPython	\N	language	\N	2026-02-15 06:07:00.169	2026-02-15 06:07:00.169	2026-02-15 06:07:00.177	\N	\N	pt-BR
66	thzz2uf64tclfnyddhyz1j5i	TypeScript	SiTypescript	\N	language	\N	2026-02-15 06:07:00.211	2026-02-15 06:07:00.211	\N	\N	\N	pt-BR
67	thzz2uf64tclfnyddhyz1j5i	TypeScript	SiTypescript	\N	language	\N	2026-02-15 06:07:00.211	2026-02-15 06:07:00.211	2026-02-15 06:07:00.22	\N	\N	pt-BR
68	v3ay3h6h1wicge0xtzoe98sw	Go	SiGo	\N	language	\N	2026-02-15 06:07:00.25	2026-02-15 06:07:00.25	\N	\N	\N	pt-BR
69	v3ay3h6h1wicge0xtzoe98sw	Go	SiGo	\N	language	\N	2026-02-15 06:07:00.25	2026-02-15 06:07:00.25	2026-02-15 06:07:00.256	\N	\N	pt-BR
70	zskjp6y6xbalfziwznmwdchw	FastAPI	SiFastapi	\N	framework	\N	2026-02-15 06:07:00.291	2026-02-15 06:07:00.291	\N	\N	\N	pt-BR
71	zskjp6y6xbalfziwznmwdchw	FastAPI	SiFastapi	\N	framework	\N	2026-02-15 06:07:00.291	2026-02-15 06:07:00.291	2026-02-15 06:07:00.296	\N	\N	pt-BR
72	tpey9n67cf7tk9ogc734a9b1	React	SiReact	\N	framework	\N	2026-02-15 06:07:00.332	2026-02-15 06:07:00.332	\N	\N	\N	pt-BR
73	tpey9n67cf7tk9ogc734a9b1	React	SiReact	\N	framework	\N	2026-02-15 06:07:00.332	2026-02-15 06:07:00.332	2026-02-15 06:07:00.339	\N	\N	pt-BR
74	wx8ese0th9jzgq7cehzlkdat	Next.js	SiNextdotjs	\N	framework	\N	2026-02-15 06:07:00.376	2026-02-15 06:07:00.376	\N	\N	\N	pt-BR
75	wx8ese0th9jzgq7cehzlkdat	Next.js	SiNextdotjs	\N	framework	\N	2026-02-15 06:07:00.376	2026-02-15 06:07:00.376	2026-02-15 06:07:00.384	\N	\N	pt-BR
76	icunppq91iqruk2dir4wziel	LangChain	\N	\N	framework	\N	2026-02-15 06:07:00.438	2026-02-15 06:07:00.438	\N	\N	\N	pt-BR
77	icunppq91iqruk2dir4wziel	LangChain	\N	\N	framework	\N	2026-02-15 06:07:00.438	2026-02-15 06:07:00.438	2026-02-15 06:07:00.448	\N	\N	pt-BR
78	awtu1zf1q3ggaes9l97z63n9	LlamaIndex	\N	\N	framework	\N	2026-02-15 06:07:00.5	2026-02-15 06:07:00.5	\N	\N	\N	pt-BR
79	awtu1zf1q3ggaes9l97z63n9	LlamaIndex	\N	\N	framework	\N	2026-02-15 06:07:00.5	2026-02-15 06:07:00.5	2026-02-15 06:07:00.509	\N	\N	pt-BR
80	fj0vl93dwof860ulajc1ssai	AWS	SiAmazonwebservices	\N	cloud	\N	2026-02-15 06:07:00.55	2026-02-15 06:07:00.55	\N	\N	\N	pt-BR
81	fj0vl93dwof860ulajc1ssai	AWS	SiAmazonwebservices	\N	cloud	\N	2026-02-15 06:07:00.55	2026-02-15 06:07:00.55	2026-02-15 06:07:00.556	\N	\N	pt-BR
82	xn2j6rzrvlzd8jhvnaar312z	Azure	SiMicrosoftazure	\N	cloud	\N	2026-02-15 06:07:00.585	2026-02-15 06:07:00.585	\N	\N	\N	pt-BR
83	xn2j6rzrvlzd8jhvnaar312z	Azure	SiMicrosoftazure	\N	cloud	\N	2026-02-15 06:07:00.585	2026-02-15 06:07:00.585	2026-02-15 06:07:00.59	\N	\N	pt-BR
84	y8lyizzdwqo8xrtwccf6rl4s	GCP	SiGooglecloud	\N	cloud	\N	2026-02-15 06:07:00.636	2026-02-15 06:07:00.636	\N	\N	\N	pt-BR
85	y8lyizzdwqo8xrtwccf6rl4s	GCP	SiGooglecloud	\N	cloud	\N	2026-02-15 06:07:00.636	2026-02-15 06:07:00.636	2026-02-15 06:07:00.647	\N	\N	pt-BR
86	vit1hn3rdmrvjtqzui1ro5t6	TensorFlow	SiTensorflow	\N	ai_ml	\N	2026-02-15 06:07:00.703	2026-02-15 06:07:00.703	\N	\N	\N	pt-BR
92	i3hrhkwwwmqbk6xqlgm7skpj	YOLO	\N	\N	ai_ml	\N	2026-02-15 06:07:00.819	2026-02-15 06:07:00.819	\N	\N	\N	pt-BR
87	vit1hn3rdmrvjtqzui1ro5t6	TensorFlow	SiTensorflow	\N	ai_ml	\N	2026-02-15 06:07:00.703	2026-02-15 06:07:00.703	2026-02-15 06:07:00.709	\N	\N	pt-BR
90	co87qyov2vmgn8iqhyy3v7sj	OpenCV	SiOpencv	\N	ai_ml	\N	2026-02-15 06:07:00.777	2026-02-15 06:07:00.777	\N	\N	\N	pt-BR
91	co87qyov2vmgn8iqhyy3v7sj	OpenCV	SiOpencv	\N	ai_ml	\N	2026-02-15 06:07:00.777	2026-02-15 06:07:00.777	2026-02-15 06:07:00.786	\N	\N	pt-BR
94	t2kzqlm5snslcai517h7vzd1	OpenAI API	\N	\N	ai_ml	\N	2026-02-15 06:07:00.858	2026-02-15 06:07:00.858	\N	\N	\N	pt-BR
95	t2kzqlm5snslcai517h7vzd1	OpenAI API	\N	\N	ai_ml	\N	2026-02-15 06:07:00.858	2026-02-15 06:07:00.858	2026-02-15 06:07:00.866	\N	\N	pt-BR
98	j1hcsjh01hckpxphswbqlaef	Docker	SiDocker	\N	devops	\N	2026-02-15 06:07:00.941	2026-02-15 06:07:00.941	\N	\N	\N	pt-BR
99	j1hcsjh01hckpxphswbqlaef	Docker	SiDocker	\N	devops	\N	2026-02-15 06:07:00.941	2026-02-15 06:07:00.941	2026-02-15 06:07:00.948	\N	\N	pt-BR
102	csfmznvdj2zleu5qz9oaw3gg	GitHub Actions	\N	\N	devops	\N	2026-02-15 06:07:01.023	2026-02-15 06:07:01.023	\N	\N	\N	pt-BR
103	csfmznvdj2zleu5qz9oaw3gg	GitHub Actions	\N	\N	devops	\N	2026-02-15 06:07:01.023	2026-02-15 06:07:01.023	2026-02-15 06:07:01.028	\N	\N	pt-BR
88	js4mvlw9vvljo2hahbf2ttjv	PyTorch	SiPytorch	\N	ai_ml	\N	2026-02-15 06:07:00.736	2026-02-15 06:07:00.736	\N	\N	\N	pt-BR
89	js4mvlw9vvljo2hahbf2ttjv	PyTorch	SiPytorch	\N	ai_ml	\N	2026-02-15 06:07:00.736	2026-02-15 06:07:00.736	2026-02-15 06:07:00.744	\N	\N	pt-BR
93	i3hrhkwwwmqbk6xqlgm7skpj	YOLO	\N	\N	ai_ml	\N	2026-02-15 06:07:00.819	2026-02-15 06:07:00.819	2026-02-15 06:07:00.825	\N	\N	pt-BR
96	g43gbdqrz8698i9lw9hw3az4	Anthropic Claude	\N	\N	ai_ml	\N	2026-02-15 06:07:00.903	2026-02-15 06:07:00.903	\N	\N	\N	pt-BR
97	g43gbdqrz8698i9lw9hw3az4	Anthropic Claude	\N	\N	ai_ml	\N	2026-02-15 06:07:00.903	2026-02-15 06:07:00.903	2026-02-15 06:07:00.908	\N	\N	pt-BR
100	wmvt92dojtwjrfkdowxkunrv	Kubernetes	SiKubernetes	\N	devops	\N	2026-02-15 06:07:00.984	2026-02-15 06:07:00.984	\N	\N	\N	pt-BR
101	wmvt92dojtwjrfkdowxkunrv	Kubernetes	SiKubernetes	\N	devops	\N	2026-02-15 06:07:00.984	2026-02-15 06:07:00.984	2026-02-15 06:07:00.989	\N	\N	pt-BR
104	arngnnnzn6esrpgxws6j2f7e	SonarQube	\N	\N	devops	\N	2026-02-15 06:07:01.062	2026-02-15 06:07:01.062	\N	\N	\N	pt-BR
105	arngnnnzn6esrpgxws6j2f7e	SonarQube	\N	\N	devops	\N	2026-02-15 06:07:01.062	2026-02-15 06:07:01.062	2026-02-15 06:07:01.069	\N	\N	pt-BR
\.


--
-- Data for Name: strapi_ai_localization_jobs; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_ai_localization_jobs (id, content_type, related_document_id, source_locale, target_locales, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: strapi_ai_metadata_jobs; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_ai_metadata_jobs (id, status, created_at, completed_at) FROM stdin;
\.


--
-- Data for Name: strapi_api_token_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_api_token_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_api_token_permissions_token_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_api_token_permissions_token_lnk (id, api_token_permission_id, api_token_id, api_token_permission_ord) FROM stdin;
\.


--
-- Data for Name: strapi_api_tokens; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_api_tokens (id, document_id, name, description, type, access_key, encrypted_key, last_used_at, expires_at, lifespan, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	u1xv7fmubfbd1l9l3svds86g	Read Only	A default API token with read-only permissions, only used for accessing resources	read-only	428ebec06440075e408e9a5313734c2c8ca8b5c5b9bbc2f991c612d3a1573a1f592e19d67413b7d1fc7858e461aee256ade1f3404711d5dd8c1d1e408d5d6958	\N	\N	\N	\N	2026-02-15 05:36:43.462	2026-02-15 05:36:43.462	2026-02-15 05:36:43.462	\N	\N	\N
2	aej8h2p1tzy29n49viczwfd4	Full Access	A default API token with full access permissions, used for accessing or modifying resources	full-access	aaf094c61cfcd94db7c7a4df281ecab3e98b971158fdefb343a9913fdcd31506c3a5bbdd576be675656ac0fce36cf41f105ad33a92ed726e6b7ac9b001e1fedd	\N	\N	\N	\N	2026-02-15 05:36:43.473	2026-02-15 05:36:43.473	2026-02-15 05:36:43.473	\N	\N	\N
3	zqw26rpr3gitpat5o9lfgleu	StrapiFullAccess		full-access	53dc6b26e65e5d96df9789b80accb0983a89600ce27ffb0beb644cf8d59f3c5ac0d813c254ab4ce7446e380c3f7ba5804efa5330973a574696083cb8219d90fe	\N	2026-02-16 05:16:49.978	\N	\N	2026-02-15 05:50:54.977	2026-02-16 05:16:49.978	2026-02-15 05:50:54.977	\N	\N	\N
\.


--
-- Data for Name: strapi_core_store_settings; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
1	strapi_unidirectional-join-table-repair-ran	true	boolean	\N	\N
7	plugin_content_manager_configuration_content_types::plugin::upload.folder	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"pathId":{"edit":{"label":"pathId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pathId","searchable":true,"sortable":true}},"parent":{"edit":{"label":"parent","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"parent","searchable":true,"sortable":true}},"children":{"edit":{"label":"children","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"children","searchable":false,"sortable":false}},"files":{"edit":{"label":"files","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"files","searchable":false,"sortable":false}},"path":{"edit":{"label":"path","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"path","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","pathId","parent"],"edit":[[{"name":"name","size":6},{"name":"pathId","size":4}],[{"name":"parent","size":6},{"name":"children","size":6}],[{"name":"files","size":6},{"name":"path","size":6}]]},"uid":"plugin::upload.folder"}	object	\N	\N
8	plugin_content_manager_configuration_content_types::plugin::i18n.locale	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","createdAt"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}]]},"uid":"plugin::i18n.locale"}	object	\N	\N
9	plugin_content_manager_configuration_content_types::plugin::content-releases.release	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"releasedAt":{"edit":{"label":"releasedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"releasedAt","searchable":true,"sortable":true}},"scheduledAt":{"edit":{"label":"scheduledAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"scheduledAt","searchable":true,"sortable":true}},"timezone":{"edit":{"label":"timezone","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"timezone","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"actions":{"edit":{"label":"actions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"contentType"},"list":{"label":"actions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","releasedAt","scheduledAt"],"edit":[[{"name":"name","size":6},{"name":"releasedAt","size":6}],[{"name":"scheduledAt","size":6},{"name":"timezone","size":6}],[{"name":"status","size":6},{"name":"actions","size":6}]]},"uid":"plugin::content-releases.release"}	object	\N	\N
2	strapi_content_types_schema	{"plugin::upload.file":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"text","configurable":false},"caption":{"type":"text","configurable":false},"focalPoint":{"type":"json","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"text","configurable":false,"required":true},"previewUrl":{"type":"text","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","minLength":1,"required":true,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"files"}}},"indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null}],"plugin":"upload","globalId":"UploadFile","uid":"plugin::upload.file","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"text","configurable":false},"caption":{"type":"text","configurable":false},"focalPoint":{"type":"json","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"text","configurable":false,"required":true},"previewUrl":{"type":"text","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","minLength":1,"required":true,"private":true,"searchable":false}},"kind":"collectionType"},"modelName":"file"},"plugin::upload.folder":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","minLength":1,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"upload_folders"}}},"indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"}],"plugin":"upload","globalId":"UploadFolder","uid":"plugin::upload.folder","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","minLength":1,"required":true}},"kind":"collectionType"},"modelName":"folder"},"plugin::i18n.locale":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::i18n.locale","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"i18n_locale"}}},"plugin":"i18n","collectionName":"i18n_locale","globalId":"I18NLocale","uid":"plugin::i18n.locale","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"i18n_locale","info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false}},"kind":"collectionType"},"modelName":"locale"},"plugin::content-releases.release":{"collectionName":"strapi_releases","info":{"singularName":"release","pluralName":"releases","displayName":"Release"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true},"releasedAt":{"type":"datetime"},"scheduledAt":{"type":"datetime"},"timezone":{"type":"string"},"status":{"type":"enumeration","enum":["ready","blocked","failed","done","empty"],"required":true},"actions":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","mappedBy":"release"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_releases"}}},"plugin":"content-releases","globalId":"ContentReleasesRelease","uid":"plugin::content-releases.release","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_releases","info":{"singularName":"release","pluralName":"releases","displayName":"Release"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true},"releasedAt":{"type":"datetime"},"scheduledAt":{"type":"datetime"},"timezone":{"type":"string"},"status":{"type":"enumeration","enum":["ready","blocked","failed","done","empty"],"required":true},"actions":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","mappedBy":"release"}},"kind":"collectionType"},"modelName":"release"},"plugin::content-releases.release-action":{"collectionName":"strapi_release_actions","info":{"singularName":"release-action","pluralName":"release-actions","displayName":"Release Action"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"type":{"type":"enumeration","enum":["publish","unpublish"],"required":true},"contentType":{"type":"string","required":true},"entryDocumentId":{"type":"string"},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"release":{"type":"relation","relation":"manyToOne","target":"plugin::content-releases.release","inversedBy":"actions"},"isEntryValid":{"type":"boolean"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_release_actions"}}},"plugin":"content-releases","globalId":"ContentReleasesReleaseAction","uid":"plugin::content-releases.release-action","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_release_actions","info":{"singularName":"release-action","pluralName":"release-actions","displayName":"Release Action"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"type":{"type":"enumeration","enum":["publish","unpublish"],"required":true},"contentType":{"type":"string","required":true},"entryDocumentId":{"type":"string"},"locale":{"type":"string"},"release":{"type":"relation","relation":"manyToOne","target":"plugin::content-releases.release","inversedBy":"actions"},"isEntryValid":{"type":"boolean"}},"kind":"collectionType"},"modelName":"release-action"},"plugin::review-workflows.workflow":{"collectionName":"strapi_workflows","info":{"name":"Workflow","description":"","singularName":"workflow","pluralName":"workflows","displayName":"Workflow"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true,"unique":true},"stages":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToMany","mappedBy":"workflow"},"stageRequiredToPublish":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToOne","required":false},"contentTypes":{"type":"json","required":true,"default":"[]"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::review-workflows.workflow","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_workflows"}}},"plugin":"review-workflows","globalId":"ReviewWorkflowsWorkflow","uid":"plugin::review-workflows.workflow","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_workflows","info":{"name":"Workflow","description":"","singularName":"workflow","pluralName":"workflows","displayName":"Workflow"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true,"unique":true},"stages":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToMany","mappedBy":"workflow"},"stageRequiredToPublish":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToOne","required":false},"contentTypes":{"type":"json","required":true,"default":"[]"}},"kind":"collectionType"},"modelName":"workflow"},"plugin::review-workflows.workflow-stage":{"collectionName":"strapi_workflows_stages","info":{"name":"Workflow Stage","description":"","singularName":"workflow-stage","pluralName":"workflow-stages","displayName":"Stages"},"options":{"version":"1.1.0","draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false},"color":{"type":"string","configurable":false,"default":"#4945FF"},"workflow":{"type":"relation","target":"plugin::review-workflows.workflow","relation":"manyToOne","inversedBy":"stages","configurable":false},"permissions":{"type":"relation","target":"admin::permission","relation":"manyToMany","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::review-workflows.workflow-stage","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_workflows_stages"}}},"plugin":"review-workflows","globalId":"ReviewWorkflowsWorkflowStage","uid":"plugin::review-workflows.workflow-stage","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_workflows_stages","info":{"name":"Workflow Stage","description":"","singularName":"workflow-stage","pluralName":"workflow-stages","displayName":"Stages"},"options":{"version":"1.1.0"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false},"color":{"type":"string","configurable":false,"default":"#4945FF"},"workflow":{"type":"relation","target":"plugin::review-workflows.workflow","relation":"manyToOne","inversedBy":"stages","configurable":false},"permissions":{"type":"relation","target":"admin::permission","relation":"manyToMany","configurable":false}},"kind":"collectionType"},"modelName":"workflow-stage"},"plugin::users-permissions.permission":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_permissions"}}},"plugin":"users-permissions","globalId":"UsersPermissionsPermission","uid":"plugin::users-permissions.permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false}},"kind":"collectionType"},"modelName":"permission","options":{"draftAndPublish":false}},"plugin::users-permissions.role":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.role","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_roles"}}},"plugin":"users-permissions","globalId":"UsersPermissionsRole","uid":"plugin::users-permissions.role","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false}},"kind":"collectionType"},"modelName":"role","options":{"draftAndPublish":false}},"plugin::users-permissions.user":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"timestamps":true,"draftAndPublish":false},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_users"}}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"confirmationToken":{"hidden":true},"provider":{"hidden":true}}},"plugin":"users-permissions","globalId":"UsersPermissionsUser","uid":"plugin::users-permissions.user","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"timestamps":true},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false}},"kind":"collectionType"},"modelName":"user"},"api::certification.certification":{"kind":"collectionType","collectionName":"certifications","info":{"singularName":"certification","pluralName":"certifications","displayName":"Certification"},"options":{"draftAndPublish":true},"attributes":{"name":{"type":"string","required":true},"issuer":{"type":"string"},"issue_date":{"type":"date"},"credential_url":{"type":"string"},"badge_image":{"type":"media","multiple":false,"allowedTypes":["images"]},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::certification.certification","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"certifications"}}},"apiName":"certification","globalId":"Certification","uid":"api::certification.certification","modelType":"contentType","__schema__":{"collectionName":"certifications","info":{"singularName":"certification","pluralName":"certifications","displayName":"Certification"},"options":{"draftAndPublish":true},"attributes":{"name":{"type":"string","required":true},"issuer":{"type":"string"},"issue_date":{"type":"date"},"credential_url":{"type":"string"},"badge_image":{"type":"media","multiple":false,"allowedTypes":["images"]}},"kind":"collectionType"},"modelName":"certification","actions":{},"lifecycles":{}},"api::education.education":{"kind":"collectionType","collectionName":"educations","info":{"singularName":"education","pluralName":"educations","displayName":"Education"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"institution":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":false}}},"degree":{"type":"string","pluginOptions":{"i18n":{"localized":true}}},"field_of_study":{"type":"string","pluginOptions":{"i18n":{"localized":true}}},"start_date":{"type":"date"},"end_date":{"type":"date"},"description":{"type":"richtext","pluginOptions":{"i18n":{"localized":true}}},"logo":{"type":"media","multiple":false,"allowedTypes":["images"]},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::education.education","writable":false,"private":false,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"educations"}}},"apiName":"education","globalId":"Education","uid":"api::education.education","modelType":"contentType","__schema__":{"collectionName":"educations","info":{"singularName":"education","pluralName":"educations","displayName":"Education"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"institution":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":false}}},"degree":{"type":"string","pluginOptions":{"i18n":{"localized":true}}},"field_of_study":{"type":"string","pluginOptions":{"i18n":{"localized":true}}},"start_date":{"type":"date"},"end_date":{"type":"date"},"description":{"type":"richtext","pluginOptions":{"i18n":{"localized":true}}},"logo":{"type":"media","multiple":false,"allowedTypes":["images"]}},"kind":"collectionType"},"modelName":"education","actions":{},"lifecycles":{}},"api::experience.experience":{"kind":"collectionType","collectionName":"experiences","info":{"singularName":"experience","pluralName":"experiences","displayName":"Experience"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"company_name":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":false}}},"company_url":{"type":"string","pluginOptions":{"i18n":{"localized":false}}},"company_location":{"type":"string","pluginOptions":{"i18n":{"localized":true}}},"company_logo":{"type":"media","multiple":false,"allowedTypes":["images"]},"order":{"type":"integer","pluginOptions":{"i18n":{"localized":false}}},"positions":{"type":"component","repeatable":true,"component":"shared.position"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::experience.experience","writable":false,"private":false,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"experiences"}}},"apiName":"experience","globalId":"Experience","uid":"api::experience.experience","modelType":"contentType","__schema__":{"collectionName":"experiences","info":{"singularName":"experience","pluralName":"experiences","displayName":"Experience"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"company_name":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":false}}},"company_url":{"type":"string","pluginOptions":{"i18n":{"localized":false}}},"company_location":{"type":"string","pluginOptions":{"i18n":{"localized":true}}},"company_logo":{"type":"media","multiple":false,"allowedTypes":["images"]},"order":{"type":"integer","pluginOptions":{"i18n":{"localized":false}}},"positions":{"type":"component","repeatable":true,"component":"shared.position"}},"kind":"collectionType"},"modelName":"experience","actions":{},"lifecycles":{}},"api::post.post":{"kind":"collectionType","collectionName":"posts","info":{"singularName":"post","pluralName":"posts","displayName":"Post"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"title":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":true}}},"slug":{"type":"uid","targetField":"title"},"content":{"type":"richtext","pluginOptions":{"i18n":{"localized":true}}},"excerpt":{"type":"text","pluginOptions":{"i18n":{"localized":true}}},"featured_image":{"type":"media","multiple":false,"allowedTypes":["images"]},"author":{"type":"string"},"categories":{"type":"json"},"tags":{"type":"json"},"featured":{"type":"boolean","default":false},"reading_time":{"type":"integer"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::post.post","writable":false,"private":false,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"posts"}}},"apiName":"post","globalId":"Post","uid":"api::post.post","modelType":"contentType","__schema__":{"collectionName":"posts","info":{"singularName":"post","pluralName":"posts","displayName":"Post"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"title":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":true}}},"slug":{"type":"uid","targetField":"title"},"content":{"type":"richtext","pluginOptions":{"i18n":{"localized":true}}},"excerpt":{"type":"text","pluginOptions":{"i18n":{"localized":true}}},"featured_image":{"type":"media","multiple":false,"allowedTypes":["images"]},"author":{"type":"string"},"categories":{"type":"json"},"tags":{"type":"json"},"featured":{"type":"boolean","default":false},"reading_time":{"type":"integer"}},"kind":"collectionType"},"modelName":"post","actions":{},"lifecycles":{}},"api::profile.profile":{"kind":"singleType","collectionName":"profiles","info":{"singularName":"profile","pluralName":"profiles","displayName":"Profile"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"name":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":false}}},"designation":{"type":"string","pluginOptions":{"i18n":{"localized":true}}},"company":{"type":"string","pluginOptions":{"i18n":{"localized":false}}},"location":{"type":"string","pluginOptions":{"i18n":{"localized":true}}},"summary":{"type":"richtext","pluginOptions":{"i18n":{"localized":true}}},"typing_titles":{"type":"json","pluginOptions":{"i18n":{"localized":true}}},"photo":{"type":"media","multiple":false,"allowedTypes":["images"]},"background":{"type":"media","multiple":false,"allowedTypes":["images","files"]},"resume":{"type":"media","multiple":false,"allowedTypes":["files"]},"social_links":{"type":"component","repeatable":true,"component":"shared.social-link"},"soft_skills":{"type":"component","repeatable":true,"component":"shared.soft-skill"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::profile.profile","writable":false,"private":false,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"profiles"}}},"apiName":"profile","globalId":"Profile","uid":"api::profile.profile","modelType":"contentType","__schema__":{"collectionName":"profiles","info":{"singularName":"profile","pluralName":"profiles","displayName":"Profile"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"name":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":false}}},"designation":{"type":"string","pluginOptions":{"i18n":{"localized":true}}},"company":{"type":"string","pluginOptions":{"i18n":{"localized":false}}},"location":{"type":"string","pluginOptions":{"i18n":{"localized":true}}},"summary":{"type":"richtext","pluginOptions":{"i18n":{"localized":true}}},"typing_titles":{"type":"json","pluginOptions":{"i18n":{"localized":true}}},"photo":{"type":"media","multiple":false,"allowedTypes":["images"]},"background":{"type":"media","multiple":false,"allowedTypes":["images","files"]},"resume":{"type":"media","multiple":false,"allowedTypes":["files"]},"social_links":{"type":"component","repeatable":true,"component":"shared.social-link"},"soft_skills":{"type":"component","repeatable":true,"component":"shared.soft-skill"}},"kind":"singleType"},"modelName":"profile","actions":{},"lifecycles":{}},"api::project.project":{"kind":"collectionType","collectionName":"projects","info":{"singularName":"project","pluralName":"projects","displayName":"Project"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"name":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":false}}},"slug":{"type":"uid","targetField":"name"},"description":{"type":"richtext","pluginOptions":{"i18n":{"localized":true}}},"role":{"type":"string","pluginOptions":{"i18n":{"localized":true}}},"timeline":{"type":"string","pluginOptions":{"i18n":{"localized":false}}},"repo_url":{"type":"string"},"demo_url":{"type":"string"},"logo":{"type":"media","multiple":false,"allowedTypes":["images"]},"tags":{"type":"json"},"category":{"type":"enumeration","enum":["professional","academic","hobby"],"required":true},"featured":{"type":"boolean","default":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::project.project","writable":false,"private":false,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"projects"}}},"apiName":"project","globalId":"Project","uid":"api::project.project","modelType":"contentType","__schema__":{"collectionName":"projects","info":{"singularName":"project","pluralName":"projects","displayName":"Project"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"name":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":false}}},"slug":{"type":"uid","targetField":"name"},"description":{"type":"richtext","pluginOptions":{"i18n":{"localized":true}}},"role":{"type":"string","pluginOptions":{"i18n":{"localized":true}}},"timeline":{"type":"string","pluginOptions":{"i18n":{"localized":false}}},"repo_url":{"type":"string"},"demo_url":{"type":"string"},"logo":{"type":"media","multiple":false,"allowedTypes":["images"]},"tags":{"type":"json"},"category":{"type":"enumeration","enum":["professional","academic","hobby"],"required":true},"featured":{"type":"boolean","default":false}},"kind":"collectionType"},"modelName":"project","actions":{},"lifecycles":{}},"api::publication.publication":{"kind":"collectionType","collectionName":"publications","info":{"singularName":"publication","pluralName":"publications","displayName":"Publication"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"title":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":true}}},"journal":{"type":"string","pluginOptions":{"i18n":{"localized":false}}},"authors":{"type":"text","pluginOptions":{"i18n":{"localized":false}}},"date":{"type":"date"},"url":{"type":"string"},"doi":{"type":"string"},"abstract":{"type":"richtext","pluginOptions":{"i18n":{"localized":true}}},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::publication.publication","writable":false,"private":false,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"publications"}}},"apiName":"publication","globalId":"Publication","uid":"api::publication.publication","modelType":"contentType","__schema__":{"collectionName":"publications","info":{"singularName":"publication","pluralName":"publications","displayName":"Publication"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"title":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":true}}},"journal":{"type":"string","pluginOptions":{"i18n":{"localized":false}}},"authors":{"type":"text","pluginOptions":{"i18n":{"localized":false}}},"date":{"type":"date"},"url":{"type":"string"},"doi":{"type":"string"},"abstract":{"type":"richtext","pluginOptions":{"i18n":{"localized":true}}}},"kind":"collectionType"},"modelName":"publication","actions":{},"lifecycles":{}},"api::skill.skill":{"kind":"collectionType","collectionName":"skills","info":{"singularName":"skill","pluralName":"skills","displayName":"Skill"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"name":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":false}}},"icon_name":{"type":"string","pluginOptions":{"i18n":{"localized":false}}},"summary":{"type":"text","pluginOptions":{"i18n":{"localized":true}}},"category":{"type":"enumeration","enum":["language","framework","cloud","ai_ml","devops","tools"],"required":true},"url":{"type":"string","pluginOptions":{"i18n":{"localized":false}}},"icon":{"type":"media","multiple":false,"allowedTypes":["images"]},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::skill.skill","writable":false,"private":false,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"skills"}}},"apiName":"skill","globalId":"Skill","uid":"api::skill.skill","modelType":"contentType","__schema__":{"collectionName":"skills","info":{"singularName":"skill","pluralName":"skills","displayName":"Skill"},"options":{"draftAndPublish":true},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"name":{"type":"string","required":true,"pluginOptions":{"i18n":{"localized":false}}},"icon_name":{"type":"string","pluginOptions":{"i18n":{"localized":false}}},"summary":{"type":"text","pluginOptions":{"i18n":{"localized":true}}},"category":{"type":"enumeration","enum":["language","framework","cloud","ai_ml","devops","tools"],"required":true},"url":{"type":"string","pluginOptions":{"i18n":{"localized":false}}},"icon":{"type":"media","multiple":false,"allowedTypes":["images"]}},"kind":"collectionType"},"modelName":"skill","actions":{},"lifecycles":{}},"admin::permission":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_permissions"}}},"plugin":"admin","globalId":"AdminPermission","uid":"admin::permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"}},"kind":"collectionType"},"modelName":"permission"},"admin::user":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_users"}}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"registrationToken":{"hidden":true}}},"plugin":"admin","globalId":"AdminUser","uid":"admin::user","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false}},"kind":"collectionType"},"modelName":"user","options":{"draftAndPublish":false}},"admin::role":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::role","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_roles"}}},"plugin":"admin","globalId":"AdminRole","uid":"admin::role","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"}},"kind":"collectionType"},"modelName":"role"},"admin::api-token":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"encryptedKey":{"type":"text","minLength":1,"configurable":false,"required":false,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::api-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_api_tokens"}}},"plugin":"admin","globalId":"AdminApiToken","uid":"admin::api-token","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"encryptedKey":{"type":"text","minLength":1,"configurable":false,"required":false,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelName":"api-token"},"admin::api-token-permission":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::api-token-permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_api_token_permissions"}}},"plugin":"admin","globalId":"AdminApiTokenPermission","uid":"admin::api-token-permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"}},"kind":"collectionType"},"modelName":"api-token-permission"},"admin::transfer-token":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::transfer-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_transfer_tokens"}}},"plugin":"admin","globalId":"AdminTransferToken","uid":"admin::transfer-token","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelName":"transfer-token"},"admin::transfer-token-permission":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::transfer-token-permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_transfer_token_permissions"}}},"plugin":"admin","globalId":"AdminTransferTokenPermission","uid":"admin::transfer-token-permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"}},"kind":"collectionType"},"modelName":"transfer-token-permission"},"admin::session":{"collectionName":"strapi_sessions","info":{"name":"Session","description":"Session Manager storage","singularName":"session","pluralName":"sessions","displayName":"Session"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false},"i18n":{"localized":false}},"attributes":{"userId":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"sessionId":{"type":"string","unique":true,"required":true,"configurable":false,"private":true,"searchable":false},"childId":{"type":"string","configurable":false,"private":true,"searchable":false},"deviceId":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"origin":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"expiresAt":{"type":"datetime","required":true,"configurable":false,"private":true,"searchable":false},"absoluteExpiresAt":{"type":"datetime","configurable":false,"private":true,"searchable":false},"status":{"type":"string","configurable":false,"private":true,"searchable":false},"type":{"type":"string","configurable":false,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::session","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_sessions"}}},"plugin":"admin","globalId":"AdminSession","uid":"admin::session","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_sessions","info":{"name":"Session","description":"Session Manager storage","singularName":"session","pluralName":"sessions","displayName":"Session"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false},"i18n":{"localized":false}},"attributes":{"userId":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"sessionId":{"type":"string","unique":true,"required":true,"configurable":false,"private":true,"searchable":false},"childId":{"type":"string","configurable":false,"private":true,"searchable":false},"deviceId":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"origin":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"expiresAt":{"type":"datetime","required":true,"configurable":false,"private":true,"searchable":false},"absoluteExpiresAt":{"type":"datetime","configurable":false,"private":true,"searchable":false},"status":{"type":"string","configurable":false,"private":true,"searchable":false},"type":{"type":"string","configurable":false,"private":true,"searchable":false}},"kind":"collectionType"},"modelName":"session"}}	object	\N	\N
10	plugin_content_manager_configuration_content_types::plugin::content-releases.release-action	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"contentType","defaultSortBy":"contentType","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"contentType":{"edit":{"label":"contentType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"contentType","searchable":true,"sortable":true}},"entryDocumentId":{"edit":{"label":"entryDocumentId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"entryDocumentId","searchable":true,"sortable":true}},"release":{"edit":{"label":"release","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"release","searchable":true,"sortable":true}},"isEntryValid":{"edit":{"label":"isEntryValid","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isEntryValid","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","type","contentType","entryDocumentId"],"edit":[[{"name":"type","size":6},{"name":"contentType","size":6}],[{"name":"entryDocumentId","size":6},{"name":"release","size":6}],[{"name":"isEntryValid","size":4}]]},"uid":"plugin::content-releases.release-action"}	object	\N	\N
21	plugin_content_manager_configuration_content_types::plugin::users-permissions.role	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"permissions","size":6}],[{"name":"users","size":6}]]},"uid":"plugin::users-permissions.role"}	object	\N	\N
29	plugin_content_manager_configuration_content_types::admin::transfer-token-permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]},"uid":"admin::transfer-token-permission"}	object	\N	\N
11	plugin_content_manager_configuration_content_types::plugin::review-workflows.workflow	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"stages":{"edit":{"label":"stages","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"stages","searchable":false,"sortable":false}},"stageRequiredToPublish":{"edit":{"label":"stageRequiredToPublish","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"stageRequiredToPublish","searchable":true,"sortable":true}},"contentTypes":{"edit":{"label":"contentTypes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"contentTypes","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","stages","stageRequiredToPublish"],"edit":[[{"name":"name","size":6},{"name":"stages","size":6}],[{"name":"stageRequiredToPublish","size":6}],[{"name":"contentTypes","size":12}]]},"uid":"plugin::review-workflows.workflow"}	object	\N	\N
22	plugin_content_manager_configuration_content_types::plugin::users-permissions.user	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"username","defaultSortBy":"username","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"confirmationToken":{"edit":{"label":"confirmationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"confirmationToken","searchable":true,"sortable":true}},"confirmed":{"edit":{"label":"confirmed","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"confirmed","searchable":true,"sortable":true}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","username","email","confirmed"],"edit":[[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"confirmed","size":4}],[{"name":"blocked","size":4},{"name":"role","size":6}]]},"uid":"plugin::users-permissions.user"}	object	\N	\N
32	plugin_content_manager_configuration_content_types::admin::user	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"firstname","defaultSortBy":"firstname","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"firstname":{"edit":{"label":"firstname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"firstname","searchable":true,"sortable":true}},"lastname":{"edit":{"label":"lastname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastname","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"registrationToken":{"edit":{"label":"registrationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"registrationToken","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"roles":{"edit":{"label":"roles","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"roles","searchable":false,"sortable":false}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"preferedLanguage":{"edit":{"label":"preferedLanguage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"preferedLanguage","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","firstname","lastname","username"],"edit":[[{"name":"firstname","size":6},{"name":"lastname","size":6}],[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"isActive","size":4}],[{"name":"roles","size":6},{"name":"blocked","size":4}],[{"name":"preferedLanguage","size":6}]]},"uid":"admin::user"}	object	\N	\N
12	plugin_content_manager_configuration_content_types::plugin::users-permissions.permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","role","createdAt"],"edit":[[{"name":"action","size":6},{"name":"role","size":6}]]},"uid":"plugin::users-permissions.permission"}	object	\N	\N
13	plugin_content_manager_configuration_content_types::plugin::review-workflows.workflow-stage	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"color":{"edit":{"label":"color","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"color","searchable":true,"sortable":true}},"workflow":{"edit":{"label":"workflow","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"workflow","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","color","workflow"],"edit":[[{"name":"name","size":6},{"name":"color","size":6}],[{"name":"workflow","size":6},{"name":"permissions","size":6}]]},"uid":"plugin::review-workflows.workflow-stage"}	object	\N	\N
14	plugin_content_manager_configuration_content_types::api::certification.certification	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"issuer":{"edit":{"label":"issuer","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"issuer","searchable":true,"sortable":true}},"issue_date":{"edit":{"label":"issue_date","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"issue_date","searchable":true,"sortable":true}},"credential_url":{"edit":{"label":"credential_url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"credential_url","searchable":true,"sortable":true}},"badge_image":{"edit":{"label":"badge_image","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"badge_image","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","issuer","issue_date"],"edit":[[{"name":"name","size":6},{"name":"issuer","size":6}],[{"name":"issue_date","size":4},{"name":"credential_url","size":6}],[{"name":"badge_image","size":6}]]},"uid":"api::certification.certification"}	object	\N	\N
15	plugin_content_manager_configuration_content_types::plugin::upload.file	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"alternativeText":{"edit":{"label":"alternativeText","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"alternativeText","searchable":true,"sortable":true}},"caption":{"edit":{"label":"caption","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"caption","searchable":true,"sortable":true}},"focalPoint":{"edit":{"label":"focalPoint","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"focalPoint","searchable":false,"sortable":false}},"width":{"edit":{"label":"width","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"width","searchable":true,"sortable":true}},"height":{"edit":{"label":"height","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"height","searchable":true,"sortable":true}},"formats":{"edit":{"label":"formats","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"formats","searchable":false,"sortable":false}},"hash":{"edit":{"label":"hash","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"hash","searchable":true,"sortable":true}},"ext":{"edit":{"label":"ext","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ext","searchable":true,"sortable":true}},"mime":{"edit":{"label":"mime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"mime","searchable":true,"sortable":true}},"size":{"edit":{"label":"size","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"size","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"previewUrl":{"edit":{"label":"previewUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"previewUrl","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"provider_metadata":{"edit":{"label":"provider_metadata","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider_metadata","searchable":false,"sortable":false}},"folder":{"edit":{"label":"folder","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"folder","searchable":true,"sortable":true}},"folderPath":{"edit":{"label":"folderPath","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"folderPath","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","alternativeText","caption"],"edit":[[{"name":"name","size":6},{"name":"alternativeText","size":6}],[{"name":"caption","size":6}],[{"name":"focalPoint","size":12}],[{"name":"width","size":4},{"name":"height","size":4}],[{"name":"formats","size":12}],[{"name":"hash","size":6},{"name":"ext","size":6}],[{"name":"mime","size":6},{"name":"size","size":4}],[{"name":"url","size":6},{"name":"previewUrl","size":6}],[{"name":"provider","size":6}],[{"name":"provider_metadata","size":12}],[{"name":"folder","size":6},{"name":"folderPath","size":6}]]},"uid":"plugin::upload.file"}	object	\N	\N
16	plugin_content_manager_configuration_content_types::api::experience.experience	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"company_name","defaultSortBy":"company_name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"company_name":{"edit":{"label":"company_name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"company_name","searchable":true,"sortable":true}},"company_url":{"edit":{"label":"company_url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"company_url","searchable":true,"sortable":true}},"company_location":{"edit":{"label":"company_location","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"company_location","searchable":true,"sortable":true}},"company_logo":{"edit":{"label":"company_logo","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"company_logo","searchable":false,"sortable":false}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"order","searchable":true,"sortable":true}},"positions":{"edit":{"label":"positions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"positions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","company_name","company_url","company_location"],"edit":[[{"name":"company_name","size":6},{"name":"company_url","size":6}],[{"name":"company_location","size":6},{"name":"company_logo","size":6}],[{"name":"order","size":4}],[{"name":"positions","size":12}]]},"uid":"api::experience.experience"}	object	\N	\N
20	plugin_content_manager_configuration_content_types::api::publication.publication	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"journal":{"edit":{"label":"journal","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"journal","searchable":true,"sortable":true}},"authors":{"edit":{"label":"authors","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"authors","searchable":true,"sortable":true}},"date":{"edit":{"label":"date","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"date","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"doi":{"edit":{"label":"doi","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"doi","searchable":true,"sortable":true}},"abstract":{"edit":{"label":"abstract","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"abstract","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","journal","authors"],"edit":[[{"name":"title","size":6},{"name":"journal","size":6}],[{"name":"authors","size":6},{"name":"date","size":4}],[{"name":"url","size":6},{"name":"doi","size":6}],[{"name":"abstract","size":12}]]},"uid":"api::publication.publication"}	object	\N	\N
23	plugin_content_manager_configuration_content_types::admin::permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"actionParameters":{"edit":{"label":"actionParameters","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"actionParameters","searchable":false,"sortable":false}},"subject":{"edit":{"label":"subject","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subject","searchable":true,"sortable":true}},"properties":{"edit":{"label":"properties","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"properties","searchable":false,"sortable":false}},"conditions":{"edit":{"label":"conditions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"conditions","searchable":false,"sortable":false}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","subject","role"],"edit":[[{"name":"action","size":6}],[{"name":"actionParameters","size":12}],[{"name":"subject","size":6}],[{"name":"properties","size":12}],[{"name":"conditions","size":12}],[{"name":"role","size":6}]]},"uid":"admin::permission"}	object	\N	\N
24	plugin_content_manager_configuration_content_types::api::education.education	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"institution","defaultSortBy":"institution","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"institution":{"edit":{"label":"institution","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"institution","searchable":true,"sortable":true}},"degree":{"edit":{"label":"degree","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"degree","searchable":true,"sortable":true}},"field_of_study":{"edit":{"label":"field_of_study","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"field_of_study","searchable":true,"sortable":true}},"start_date":{"edit":{"label":"start_date","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"start_date","searchable":true,"sortable":true}},"end_date":{"edit":{"label":"end_date","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"end_date","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":false,"sortable":false}},"logo":{"edit":{"label":"logo","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"logo","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","institution","degree","field_of_study"],"edit":[[{"name":"institution","size":6},{"name":"degree","size":6}],[{"name":"field_of_study","size":6},{"name":"start_date","size":4}],[{"name":"end_date","size":4}],[{"name":"description","size":12}],[{"name":"logo","size":6}]]},"uid":"api::education.education"}	object	\N	\N
25	plugin_content_manager_configuration_content_types::admin::role	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"firstname"},"list":{"label":"users","searchable":false,"sortable":false}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","description"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}],[{"name":"description","size":6},{"name":"users","size":6}],[{"name":"permissions","size":6}]]},"uid":"admin::role"}	object	\N	\N
41	plugin_upload_api-folder	{"id":1}	object	\N	\N
40	core_admin_auth	{"providers":{"autoRegister":false,"defaultRole":null,"ssoLockedRoles":null}}	object	\N	\N
17	plugin_content_manager_configuration_content_types::api::post.post	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"content":{"edit":{"label":"content","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"content","searchable":false,"sortable":false}},"excerpt":{"edit":{"label":"excerpt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"excerpt","searchable":true,"sortable":true}},"featured_image":{"edit":{"label":"featured_image","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"featured_image","searchable":false,"sortable":false}},"author":{"edit":{"label":"author","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"author","searchable":true,"sortable":true}},"categories":{"edit":{"label":"categories","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"categories","searchable":false,"sortable":false}},"tags":{"edit":{"label":"tags","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"tags","searchable":false,"sortable":false}},"featured":{"edit":{"label":"featured","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"featured","searchable":true,"sortable":true}},"reading_time":{"edit":{"label":"reading_time","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"reading_time","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","slug","excerpt"],"edit":[[{"name":"title","size":6},{"name":"slug","size":6}],[{"name":"content","size":12}],[{"name":"excerpt","size":6},{"name":"featured_image","size":6}],[{"name":"author","size":6}],[{"name":"categories","size":12}],[{"name":"tags","size":12}],[{"name":"featured","size":4},{"name":"reading_time","size":4}]]},"uid":"api::post.post"}	object	\N	\N
27	plugin_content_manager_configuration_content_types::admin::api-token-permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]},"uid":"admin::api-token-permission"}	object	\N	\N
18	plugin_content_manager_configuration_content_types::api::profile.profile	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"designation":{"edit":{"label":"designation","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"designation","searchable":true,"sortable":true}},"company":{"edit":{"label":"company","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"company","searchable":true,"sortable":true}},"location":{"edit":{"label":"location","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"location","searchable":true,"sortable":true}},"summary":{"edit":{"label":"summary","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"summary","searchable":false,"sortable":false}},"typing_titles":{"edit":{"label":"typing_titles","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"typing_titles","searchable":false,"sortable":false}},"photo":{"edit":{"label":"photo","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"photo","searchable":false,"sortable":false}},"background":{"edit":{"label":"background","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"background","searchable":false,"sortable":false}},"resume":{"edit":{"label":"resume","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"resume","searchable":false,"sortable":false}},"social_links":{"edit":{"label":"social_links","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"social_links","searchable":false,"sortable":false}},"soft_skills":{"edit":{"label":"soft_skills","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"soft_skills","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","designation","company"],"edit":[[{"name":"name","size":6},{"name":"designation","size":6}],[{"name":"company","size":6},{"name":"location","size":6}],[{"name":"summary","size":12}],[{"name":"typing_titles","size":12}],[{"name":"photo","size":6},{"name":"background","size":6}],[{"name":"resume","size":6}],[{"name":"social_links","size":12}],[{"name":"soft_skills","size":12}]]},"uid":"api::profile.profile"}	object	\N	\N
28	plugin_content_manager_configuration_content_types::admin::transfer-token	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","accessKey"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"accessKey","size":6},{"name":"lastUsedAt","size":6}],[{"name":"permissions","size":6},{"name":"expiresAt","size":6}],[{"name":"lifespan","size":4}]]},"uid":"admin::transfer-token"}	object	\N	\N
19	plugin_content_manager_configuration_content_types::api::project.project	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":false,"sortable":false}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"role","searchable":true,"sortable":true}},"timeline":{"edit":{"label":"timeline","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"timeline","searchable":true,"sortable":true}},"repo_url":{"edit":{"label":"repo_url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"repo_url","searchable":true,"sortable":true}},"demo_url":{"edit":{"label":"demo_url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"demo_url","searchable":true,"sortable":true}},"logo":{"edit":{"label":"logo","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"logo","searchable":false,"sortable":false}},"tags":{"edit":{"label":"tags","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"tags","searchable":false,"sortable":false}},"category":{"edit":{"label":"category","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"category","searchable":true,"sortable":true}},"featured":{"edit":{"label":"featured","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"featured","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","slug","role"],"edit":[[{"name":"name","size":6},{"name":"slug","size":6}],[{"name":"description","size":12}],[{"name":"role","size":6},{"name":"timeline","size":6}],[{"name":"repo_url","size":6},{"name":"demo_url","size":6}],[{"name":"logo","size":6}],[{"name":"tags","size":12}],[{"name":"category","size":6},{"name":"featured","size":4}]]},"uid":"api::project.project"}	object	\N	\N
31	plugin_content_manager_configuration_content_types::api::skill.skill	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"icon_name":{"edit":{"label":"icon_name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"icon_name","searchable":true,"sortable":true}},"summary":{"edit":{"label":"summary","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"summary","searchable":true,"sortable":true}},"category":{"edit":{"label":"category","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"category","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"icon":{"edit":{"label":"icon","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"icon","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","icon_name","summary"],"edit":[[{"name":"name","size":6},{"name":"icon_name","size":6}],[{"name":"summary","size":6},{"name":"category","size":6}],[{"name":"url","size":6},{"name":"icon","size":6}]]},"uid":"api::skill.skill"}	object	\N	\N
26	plugin_content_manager_configuration_content_types::admin::api-token	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"encryptedKey":{"edit":{"label":"encryptedKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"encryptedKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"accessKey","size":6}],[{"name":"encryptedKey","size":6},{"name":"lastUsedAt","size":6}],[{"name":"permissions","size":6},{"name":"expiresAt","size":6}],[{"name":"lifespan","size":4}]]},"uid":"admin::api-token"}	object	\N	\N
30	plugin_content_manager_configuration_content_types::admin::session	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"userId","defaultSortBy":"userId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"userId":{"edit":{"label":"userId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"userId","searchable":true,"sortable":true}},"sessionId":{"edit":{"label":"sessionId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"sessionId","searchable":true,"sortable":true}},"childId":{"edit":{"label":"childId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"childId","searchable":true,"sortable":true}},"deviceId":{"edit":{"label":"deviceId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"deviceId","searchable":true,"sortable":true}},"origin":{"edit":{"label":"origin","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"origin","searchable":true,"sortable":true}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"absoluteExpiresAt":{"edit":{"label":"absoluteExpiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"absoluteExpiresAt","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","userId","sessionId","childId"],"edit":[[{"name":"userId","size":6},{"name":"sessionId","size":6}],[{"name":"childId","size":6},{"name":"deviceId","size":6}],[{"name":"origin","size":6},{"name":"expiresAt","size":6}],[{"name":"absoluteExpiresAt","size":6},{"name":"status","size":6}],[{"name":"type","size":6}]]},"uid":"admin::session"}	object	\N	\N
33	plugin_upload_settings	{"sizeOptimization":true,"responsiveDimensions":true,"autoOrientation":false,"aiMetadata":true}	object	\N	\N
34	plugin_upload_view_configuration	{"pageSize":10,"sort":"createdAt:DESC"}	object	\N	\N
37	plugin_users-permissions_grant	{"email":{"icon":"envelope","enabled":true},"discord":{"icon":"discord","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/discord/callback","scope":["identify","email"]},"facebook":{"icon":"facebook-square","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/facebook/callback","scope":["email"]},"google":{"icon":"google","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/google/callback","scope":["email"]},"github":{"icon":"github","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/github/callback","scope":["user","user:email"]},"microsoft":{"icon":"windows","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/microsoft/callback","scope":["user.read"]},"twitter":{"icon":"twitter","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/twitter/callback"},"instagram":{"icon":"instagram","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/instagram/callback","scope":["user_profile"]},"vk":{"icon":"vk","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/vk/callback","scope":["email"]},"twitch":{"icon":"twitch","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/twitch/callback","scope":["user:read:email"]},"linkedin":{"icon":"linkedin","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/linkedin/callback","scope":["r_liteprofile","r_emailaddress"]},"cognito":{"icon":"aws","enabled":false,"key":"","secret":"","subdomain":"my.subdomain.com","callback":"api/auth/cognito/callback","scope":["email","openid","profile"]},"reddit":{"icon":"reddit","enabled":false,"key":"","secret":"","callback":"api/auth/reddit/callback","scope":["identity"]},"auth0":{"icon":"","enabled":false,"key":"","secret":"","subdomain":"my-tenant.eu","callback":"api/auth/auth0/callback","scope":["openid","email","profile"]},"cas":{"icon":"book","enabled":false,"key":"","secret":"","callback":"api/auth/cas/callback","scope":["openid email"],"subdomain":"my.subdomain.com/cas"},"patreon":{"icon":"","enabled":false,"key":"","secret":"","callback":"api/auth/patreon/callback","scope":["identity","identity[email]"]},"keycloak":{"icon":"","enabled":false,"key":"","secret":"","subdomain":"myKeycloakProvider.com/realms/myrealm","callback":"api/auth/keycloak/callback","scope":["openid","email","profile"]}}	object	\N	\N
38	plugin_users-permissions_email	{"reset_password":{"display":"Email.template.reset_password","icon":"sync","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Reset password","message":"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But don’t worry! You can use the following link to reset your password:</p>\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>"}},"email_confirmation":{"display":"Email.template.email_confirmation","icon":"check-square","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Account confirmation","message":"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>"}}}	object	\N	\N
39	plugin_users-permissions_advanced	{"unique_email":true,"allow_register":true,"email_confirmation":false,"email_reset_password":null,"email_confirmation_redirection":null,"default_role":"authenticated"}	object	\N	\N
35	plugin_upload_metrics	{"weeklySchedule":"56 36 5 * * 0","lastWeeklyUpdate":1771133816921}	object	\N	\N
5	plugin_content_manager_configuration_components::shared.soft-skill	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"level":{"edit":{"label":"level","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"level","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","level"],"edit":[[{"name":"name","size":6},{"name":"level","size":4}]]},"uid":"shared.soft-skill","isComponent":true}	object	\N	\N
3	plugin_content_manager_configuration_components::shared.social-link	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"platform","defaultSortBy":"platform","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"platform":{"edit":{"label":"platform","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"platform","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"icon_name":{"edit":{"label":"icon_name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"icon_name","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","platform","url","icon_name"],"edit":[[{"name":"platform","size":6},{"name":"url","size":6}],[{"name":"icon_name","size":6}]]},"uid":"shared.social-link","isComponent":true}	object	\N	\N
4	plugin_content_manager_configuration_components::shared.responsibility	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"documentId","defaultSortBy":"documentId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","description"],"edit":[[{"name":"description","size":6}]]},"uid":"shared.responsibility","isComponent":true}	object	\N	\N
6	plugin_content_manager_configuration_components::shared.position	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"designation","defaultSortBy":"designation","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"designation":{"edit":{"label":"designation","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"designation","searchable":true,"sortable":true}},"start_date":{"edit":{"label":"start_date","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"start_date","searchable":true,"sortable":true}},"end_date":{"edit":{"label":"end_date","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"end_date","searchable":true,"sortable":true}},"is_current":{"edit":{"label":"is_current","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"is_current","searchable":true,"sortable":true}},"responsibilities":{"edit":{"label":"responsibilities","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"responsibilities","searchable":false,"sortable":false}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","designation","start_date","end_date"],"edit":[[{"name":"designation","size":6},{"name":"start_date","size":4}],[{"name":"end_date","size":4},{"name":"is_current","size":4}],[{"name":"responsibilities","size":12}]]},"uid":"shared.position","isComponent":true}	object	\N	\N
36	plugin_i18n_default_locale	"pt-BR"	string	\N	\N
\.


--
-- Data for Name: strapi_database_schema; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
2	{"tables":[{"name":"files","indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null},{"name":"files_documents_idx","columns":["document_id","locale","published_at"]},{"name":"files_created_by_id_fk","columns":["created_by_id"]},{"name":"files_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"files_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"files_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"alternative_text","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"caption","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"focal_point","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"width","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"height","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"formats","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"hash","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"ext","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"mime","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"size","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"preview_url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider_metadata","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"folder_path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"upload_folders","indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"},{"name":"upload_folders_documents_idx","columns":["document_id","locale","published_at"]},{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"]},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"i18n_locale","indexes":[{"name":"i18n_locale_documents_idx","columns":["document_id","locale","published_at"]},{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"]},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_releases","indexes":[{"name":"strapi_releases_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_releases_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_releases_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_releases_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_releases_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"released_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"scheduled_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"timezone","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_release_actions","indexes":[{"name":"strapi_release_actions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_release_actions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_release_actions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_release_actions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_release_actions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"entry_document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_entry_valid","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows","indexes":[{"name":"strapi_workflows_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_workflows_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_workflows_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_workflows_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_workflows_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content_types","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_workflows_stages","indexes":[{"name":"strapi_workflows_stages_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_workflows_stages_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_workflows_stages_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_workflows_stages_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_workflows_stages_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"color","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_permissions","indexes":[{"name":"up_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_roles","indexes":[{"name":"up_roles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_users","indexes":[{"name":"up_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_users_created_by_id_fk","columns":["created_by_id"]},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmation_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmed","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"certifications","indexes":[{"name":"certifications_documents_idx","columns":["document_id","locale","published_at"]},{"name":"certifications_created_by_id_fk","columns":["created_by_id"]},{"name":"certifications_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"certifications_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"certifications_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"issuer","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"issue_date","type":"date","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"credential_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"educations","indexes":[{"name":"educations_documents_idx","columns":["document_id","locale","published_at"]},{"name":"educations_created_by_id_fk","columns":["created_by_id"]},{"name":"educations_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"educations_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"educations_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"institution","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"degree","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field_of_study","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"start_date","type":"date","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"end_date","type":"date","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"experiences_cmps","indexes":[{"name":"experiences_field_idx","columns":["field"]},{"name":"experiences_component_type_idx","columns":["component_type"]},{"name":"experiences_entity_fk","columns":["entity_id"]},{"name":"experiences_uq","columns":["entity_id","cmp_id","field","component_type"],"type":"unique"}],"foreignKeys":[{"name":"experiences_entity_fk","columns":["entity_id"],"referencedColumns":["id"],"referencedTable":"experiences","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"entity_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"cmp_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"experiences","indexes":[{"name":"experiences_documents_idx","columns":["document_id","locale","published_at"]},{"name":"experiences_created_by_id_fk","columns":["created_by_id"]},{"name":"experiences_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"experiences_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"experiences_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"company_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"company_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"company_location","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"posts","indexes":[{"name":"posts_documents_idx","columns":["document_id","locale","published_at"]},{"name":"posts_created_by_id_fk","columns":["created_by_id"]},{"name":"posts_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"posts_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"posts_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"excerpt","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"author","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"categories","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tags","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"featured","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reading_time","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"profiles_cmps","indexes":[{"name":"profiles_field_idx","columns":["field"]},{"name":"profiles_component_type_idx","columns":["component_type"]},{"name":"profiles_entity_fk","columns":["entity_id"]},{"name":"profiles_uq","columns":["entity_id","cmp_id","field","component_type"],"type":"unique"}],"foreignKeys":[{"name":"profiles_entity_fk","columns":["entity_id"],"referencedColumns":["id"],"referencedTable":"profiles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"entity_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"cmp_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"profiles","indexes":[{"name":"profiles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"profiles_created_by_id_fk","columns":["created_by_id"]},{"name":"profiles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"profiles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"profiles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"designation","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"company","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"location","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"summary","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"typing_titles","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"projects","indexes":[{"name":"projects_documents_idx","columns":["document_id","locale","published_at"]},{"name":"projects_created_by_id_fk","columns":["created_by_id"]},{"name":"projects_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"projects_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"projects_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"role","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"timeline","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"repo_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"demo_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tags","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"category","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"featured","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"publications","indexes":[{"name":"publications_documents_idx","columns":["document_id","locale","published_at"]},{"name":"publications_created_by_id_fk","columns":["created_by_id"]},{"name":"publications_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"publications_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"publications_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"journal","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"authors","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"date","type":"date","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"doi","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"abstract","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"skills","indexes":[{"name":"skills_documents_idx","columns":["document_id","locale","published_at"]},{"name":"skills_created_by_id_fk","columns":["created_by_id"]},{"name":"skills_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"skills_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"skills_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"icon_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"summary","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"category","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_permissions","indexes":[{"name":"admin_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action_parameters","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subject","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"properties","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"conditions","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_users","indexes":[{"name":"admin_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_users_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"firstname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lastname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"registration_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"prefered_language","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_roles","indexes":[{"name":"admin_roles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_api_tokens","indexes":[{"name":"strapi_api_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"encrypted_key","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_api_token_permissions","indexes":[{"name":"strapi_api_token_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_transfer_tokens","indexes":[{"name":"strapi_transfer_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_transfer_token_permissions","indexes":[{"name":"strapi_transfer_token_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_sessions","indexes":[{"name":"strapi_sessions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_sessions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_sessions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_sessions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_sessions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"user_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"session_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"child_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"device_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"origin","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"absolute_expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"components_shared_soft_skills","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"level","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"components_shared_social_links","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"platform","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"icon_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"components_shared_responsibilities","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"description","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"components_shared_positions_cmps","indexes":[{"name":"components_shared_positions_field_idx","columns":["field"]},{"name":"components_shared_positions_component_type_idx","columns":["component_type"]},{"name":"components_shared_positions_entity_fk","columns":["entity_id"]},{"name":"components_shared_positions_uq","columns":["entity_id","cmp_id","field","component_type"],"type":"unique"}],"foreignKeys":[{"name":"components_shared_positions_entity_fk","columns":["entity_id"],"referencedColumns":["id"],"referencedTable":"components_shared_positions","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"entity_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"cmp_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"components_shared_positions","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"designation","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"start_date","type":"date","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"end_date","type":"date","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_current","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_core_store_settings","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"value","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"environment","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tag","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_webhooks","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"headers","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"events","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_history_versions","indexes":[{"name":"strapi_history_versions_created_by_id_fk","columns":["created_by_id"]}],"foreignKeys":[{"name":"strapi_history_versions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"related_document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"data","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"schema","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_ai_metadata_jobs","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"completed_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_ai_localization_jobs","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"related_document_id","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"source_locale","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"target_locales","type":"jsonb","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"files_related_mph","indexes":[{"name":"files_related_mph_fk","columns":["file_id"]},{"name":"files_related_mph_oidx","columns":["order"]},{"name":"files_related_mph_idix","columns":["related_id"]}],"foreignKeys":[{"name":"files_related_mph_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_folder_lnk","indexes":[{"name":"files_folder_lnk_fk","columns":["file_id"]},{"name":"files_folder_lnk_ifk","columns":["folder_id"]},{"name":"files_folder_lnk_uq","columns":["file_id","folder_id"],"type":"unique"},{"name":"files_folder_lnk_oifk","columns":["file_ord"]}],"foreignKeys":[{"name":"files_folder_lnk_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"},{"name":"files_folder_lnk_ifk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"file_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders_parent_lnk","indexes":[{"name":"upload_folders_parent_lnk_fk","columns":["folder_id"]},{"name":"upload_folders_parent_lnk_ifk","columns":["inv_folder_id"]},{"name":"upload_folders_parent_lnk_uq","columns":["folder_id","inv_folder_id"],"type":"unique"},{"name":"upload_folders_parent_lnk_oifk","columns":["folder_ord"]}],"foreignKeys":[{"name":"upload_folders_parent_lnk_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"},{"name":"upload_folders_parent_lnk_ifk","columns":["inv_folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_release_actions_release_lnk","indexes":[{"name":"strapi_release_actions_release_lnk_fk","columns":["release_action_id"]},{"name":"strapi_release_actions_release_lnk_ifk","columns":["release_id"]},{"name":"strapi_release_actions_release_lnk_uq","columns":["release_action_id","release_id"],"type":"unique"},{"name":"strapi_release_actions_release_lnk_oifk","columns":["release_action_ord"]}],"foreignKeys":[{"name":"strapi_release_actions_release_lnk_fk","columns":["release_action_id"],"referencedColumns":["id"],"referencedTable":"strapi_release_actions","onDelete":"CASCADE"},{"name":"strapi_release_actions_release_lnk_ifk","columns":["release_id"],"referencedColumns":["id"],"referencedTable":"strapi_releases","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"release_action_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"release_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"release_action_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stage_required_to_publish_lnk","indexes":[{"name":"strapi_workflows_stage_required_to_publish_lnk_fk","columns":["workflow_id"]},{"name":"strapi_workflows_stage_required_to_publish_lnk_ifk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stage_required_to_publish_lnk_uq","columns":["workflow_id","workflow_stage_id"],"type":"unique"}],"foreignKeys":[{"name":"strapi_workflows_stage_required_to_publish_lnk_fk","columns":["workflow_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows","onDelete":"CASCADE"},{"name":"strapi_workflows_stage_required_to_publish_lnk_ifk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stages_workflow_lnk","indexes":[{"name":"strapi_workflows_stages_workflow_lnk_fk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stages_workflow_lnk_ifk","columns":["workflow_id"]},{"name":"strapi_workflows_stages_workflow_lnk_uq","columns":["workflow_stage_id","workflow_id"],"type":"unique"},{"name":"strapi_workflows_stages_workflow_lnk_oifk","columns":["workflow_stage_ord"]}],"foreignKeys":[{"name":"strapi_workflows_stages_workflow_lnk_fk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"},{"name":"strapi_workflows_stages_workflow_lnk_ifk","columns":["workflow_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_stage_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stages_permissions_lnk","indexes":[{"name":"strapi_workflows_stages_permissions_lnk_fk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stages_permissions_lnk_ifk","columns":["permission_id"]},{"name":"strapi_workflows_stages_permissions_lnk_uq","columns":["workflow_stage_id","permission_id"],"type":"unique"},{"name":"strapi_workflows_stages_permissions_lnk_ofk","columns":["permission_ord"]}],"foreignKeys":[{"name":"strapi_workflows_stages_permissions_lnk_fk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"},{"name":"strapi_workflows_stages_permissions_lnk_ifk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions_role_lnk","indexes":[{"name":"up_permissions_role_lnk_fk","columns":["permission_id"]},{"name":"up_permissions_role_lnk_ifk","columns":["role_id"]},{"name":"up_permissions_role_lnk_uq","columns":["permission_id","role_id"],"type":"unique"},{"name":"up_permissions_role_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"up_permissions_role_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"up_permissions","onDelete":"CASCADE"},{"name":"up_permissions_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users_role_lnk","indexes":[{"name":"up_users_role_lnk_fk","columns":["user_id"]},{"name":"up_users_role_lnk_ifk","columns":["role_id"]},{"name":"up_users_role_lnk_uq","columns":["user_id","role_id"],"type":"unique"},{"name":"up_users_role_lnk_oifk","columns":["user_ord"]}],"foreignKeys":[{"name":"up_users_role_lnk_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"},{"name":"up_users_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_permissions_role_lnk","indexes":[{"name":"admin_permissions_role_lnk_fk","columns":["permission_id"]},{"name":"admin_permissions_role_lnk_ifk","columns":["role_id"]},{"name":"admin_permissions_role_lnk_uq","columns":["permission_id","role_id"],"type":"unique"},{"name":"admin_permissions_role_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"admin_permissions_role_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"},{"name":"admin_permissions_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users_roles_lnk","indexes":[{"name":"admin_users_roles_lnk_fk","columns":["user_id"]},{"name":"admin_users_roles_lnk_ifk","columns":["role_id"]},{"name":"admin_users_roles_lnk_uq","columns":["user_id","role_id"],"type":"unique"},{"name":"admin_users_roles_lnk_ofk","columns":["role_ord"]},{"name":"admin_users_roles_lnk_oifk","columns":["user_ord"]}],"foreignKeys":[{"name":"admin_users_roles_lnk_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"admin_users","onDelete":"CASCADE"},{"name":"admin_users_roles_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions_token_lnk","indexes":[{"name":"strapi_api_token_permissions_token_lnk_fk","columns":["api_token_permission_id"]},{"name":"strapi_api_token_permissions_token_lnk_ifk","columns":["api_token_id"]},{"name":"strapi_api_token_permissions_token_lnk_uq","columns":["api_token_permission_id","api_token_id"],"type":"unique"},{"name":"strapi_api_token_permissions_token_lnk_oifk","columns":["api_token_permission_ord"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_token_lnk_fk","columns":["api_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_token_permissions","onDelete":"CASCADE"},{"name":"strapi_api_token_permissions_token_lnk_ifk","columns":["api_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"api_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions_token_lnk","indexes":[{"name":"strapi_transfer_token_permissions_token_lnk_fk","columns":["transfer_token_permission_id"]},{"name":"strapi_transfer_token_permissions_token_lnk_ifk","columns":["transfer_token_id"]},{"name":"strapi_transfer_token_permissions_token_lnk_uq","columns":["transfer_token_permission_id","transfer_token_id"],"type":"unique"},{"name":"strapi_transfer_token_permissions_token_lnk_oifk","columns":["transfer_token_permission_ord"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_token_lnk_fk","columns":["transfer_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_token_permissions","onDelete":"CASCADE"},{"name":"strapi_transfer_token_permissions_token_lnk_ifk","columns":["transfer_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"transfer_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]}]}	2026-02-15 05:36:40.585	6a2ede4d74cdcb36408b19052b3bb92eb552595492ba85cd80769f87c5dbe5d7
\.


--
-- Data for Name: strapi_history_versions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_history_versions (id, content_type, related_document_id, locale, status, data, schema, created_at, created_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_migrations; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_migrations (id, name, "time") FROM stdin;
\.


--
-- Data for Name: strapi_migrations_internal; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_migrations_internal (id, name, "time") FROM stdin;
1	5.0.0-rename-identifiers-longer-than-max-length	2026-02-15 04:59:17.718
2	5.0.0-02-created-document-id	2026-02-15 04:59:17.787
3	5.0.0-03-created-locale	2026-02-15 04:59:17.842
4	5.0.0-04-created-published-at	2026-02-15 04:59:17.898
5	5.0.0-05-drop-slug-fields-index	2026-02-15 04:59:17.955
6	5.0.0-06-add-document-id-indexes	2026-02-15 04:59:18.013
7	core::5.0.0-discard-drafts	2026-02-15 04:59:18.064
\.


--
-- Data for Name: strapi_release_actions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_release_actions (id, document_id, type, content_type, entry_document_id, locale, is_entry_valid, created_at, updated_at, published_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_release_actions_release_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_release_actions_release_lnk (id, release_action_id, release_id, release_action_ord) FROM stdin;
\.


--
-- Data for Name: strapi_releases; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_releases (id, document_id, name, released_at, scheduled_at, timezone, status, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_sessions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_sessions (id, document_id, user_id, session_id, child_id, device_id, origin, expires_at, absolute_expires_at, status, type, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	kemjyrgftqd89uwjr6uqt30z	1	876fd4de977d58bdb82c023895322b5d	0bc0e10bf81cace0d0e7ada7eab12354	e47457c2-5337-43be-b6cf-de9f090f7241	admin	2026-02-15 07:43:41.3	2026-03-17 05:43:41.3	rotated	session	2026-02-15 05:43:41.3	2026-02-15 06:20:24.213	2026-02-15 05:43:41.3	\N	\N	\N
2	ncyn3k7gucs8pfgbrode1qw4	1	0bc0e10bf81cace0d0e7ada7eab12354	b4a818a8b45730b8a89d764a38fceb20	e47457c2-5337-43be-b6cf-de9f090f7241	admin	2026-02-15 08:20:24.197	2026-03-17 05:43:41.3	rotated	session	2026-02-15 06:20:24.198	2026-02-15 07:06:38.793	2026-02-15 06:20:24.2	\N	\N	\N
4	ybhnc8jatu0crcpepmcbwa3c	1	5921e2a24bc86f0c30898d883b6393fb	\N	e47457c2-5337-43be-b6cf-de9f090f7241	admin	2026-02-15 09:54:58.443	2026-03-17 05:43:41.3	active	session	2026-02-15 07:54:58.444	2026-02-15 07:54:58.444	2026-02-15 07:54:58.444	\N	\N	\N
3	wtvn21g0g80am76ps2f60j53	1	b4a818a8b45730b8a89d764a38fceb20	5921e2a24bc86f0c30898d883b6393fb	e47457c2-5337-43be-b6cf-de9f090f7241	admin	2026-02-15 09:06:38.777	2026-03-17 05:43:41.3	rotated	session	2026-02-15 07:06:38.777	2026-02-15 07:54:58.455	2026-02-15 07:06:38.78	\N	\N	\N
5	f3svii12coel6z7c7k8vso05	1	92a6ed722a338e2b7019dd34c1b1be62	\N	e47457c2-5337-43be-b6cf-de9f090f7241	admin	2026-02-16 10:08:35.442	2026-03-18 08:08:35.442	active	session	2026-02-16 08:08:35.442	2026-02-16 08:08:35.442	2026-02-16 08:08:35.445	\N	\N	\N
\.


--
-- Data for Name: strapi_transfer_token_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_transfer_token_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_token_permissions_token_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_transfer_token_permissions_token_lnk (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_ord) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_tokens; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_transfer_tokens (id, document_id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_webhooks; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
\.


--
-- Data for Name: strapi_workflows; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_workflows (id, document_id, name, content_types, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stage_required_to_publish_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_workflows_stage_required_to_publish_lnk (id, workflow_id, workflow_stage_id) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stages; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_workflows_stages (id, document_id, name, color, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stages_permissions_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_workflows_stages_permissions_lnk (id, workflow_stage_id, permission_id, permission_ord) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stages_workflow_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_workflows_stages_workflow_lnk (id, workflow_stage_id, workflow_id, workflow_stage_ord) FROM stdin;
\.


--
-- Data for Name: up_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	nby6uc27r8nwgipdalzjilyo	plugin::users-permissions.auth.logout	2026-02-15 05:36:41.489	2026-02-15 05:36:41.489	2026-02-15 05:36:41.49	\N	\N	\N
2	ffp4e16fm28kxzv014ibzi0c	plugin::users-permissions.user.me	2026-02-15 05:36:41.489	2026-02-15 05:36:41.489	2026-02-15 05:36:41.49	\N	\N	\N
3	zusjqx9teu8z29mx2cvazv8g	plugin::users-permissions.auth.changePassword	2026-02-15 05:36:41.489	2026-02-15 05:36:41.489	2026-02-15 05:36:41.49	\N	\N	\N
4	aptwhdjr7gkxpqhj541l9mkr	plugin::users-permissions.auth.callback	2026-02-15 05:36:41.508	2026-02-15 05:36:41.508	2026-02-15 05:36:41.508	\N	\N	\N
5	gpmrv0c5dd3owkoy907tigpc	plugin::users-permissions.auth.connect	2026-02-15 05:36:41.508	2026-02-15 05:36:41.508	2026-02-15 05:36:41.508	\N	\N	\N
6	qwugy4dnggw3dr9my4vtsmql	plugin::users-permissions.auth.forgotPassword	2026-02-15 05:36:41.508	2026-02-15 05:36:41.508	2026-02-15 05:36:41.509	\N	\N	\N
7	x8as3616h7fw1o5zh5cecqeq	plugin::users-permissions.auth.resetPassword	2026-02-15 05:36:41.508	2026-02-15 05:36:41.508	2026-02-15 05:36:41.509	\N	\N	\N
8	ddqwlx0eqtg9s5zi4uiwln18	plugin::users-permissions.auth.register	2026-02-15 05:36:41.508	2026-02-15 05:36:41.508	2026-02-15 05:36:41.509	\N	\N	\N
9	b0o6rcjhy4sv1nzvla794046	plugin::users-permissions.auth.emailConfirmation	2026-02-15 05:36:41.508	2026-02-15 05:36:41.508	2026-02-15 05:36:41.509	\N	\N	\N
11	dyyujqoekp6kvfdkqx903z5c	plugin::users-permissions.auth.refresh	2026-02-15 05:36:41.508	2026-02-15 05:36:41.508	2026-02-15 05:36:41.509	\N	\N	\N
10	vw8zvspeh3xrptjbpo1aslay	plugin::users-permissions.auth.sendEmailConfirmation	2026-02-15 05:36:41.508	2026-02-15 05:36:41.508	2026-02-15 05:36:41.509	\N	\N	\N
\.


--
-- Data for Name: up_permissions_role_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_permissions_role_lnk (id, permission_id, role_id, permission_ord) FROM stdin;
1	3	1	1
2	1	1	1
3	2	1	1
4	4	2	1
5	5	2	1
6	6	2	1
7	9	2	1
8	8	2	1
9	10	2	2
10	7	2	2
11	11	2	2
\.


--
-- Data for Name: up_roles; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_roles (id, document_id, name, description, type, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	aknxckhyk35bu2zqcqze7dar	Authenticated	Default role given to authenticated user.	authenticated	2026-02-15 05:36:41.472	2026-02-15 05:36:41.472	2026-02-15 05:36:41.472	\N	\N	\N
2	wn77kksnpbc2uftbtxsk9uwd	Public	Default role given to unauthenticated user.	public	2026-02-15 05:36:41.479	2026-02-15 05:36:41.479	2026-02-15 05:36:41.479	\N	\N	\N
\.


--
-- Data for Name: up_users; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_users (id, document_id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: up_users_role_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_users_role_lnk (id, user_id, role_id, user_ord) FROM stdin;
\.


--
-- Data for Name: upload_folders; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.upload_folders (id, document_id, name, path_id, path, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	m4ykw0c21t8c831u174jjts4	API Uploads	1	/1	2026-02-15 07:57:31.944	2026-02-15 07:57:31.944	2026-02-15 07:57:31.944	\N	\N	\N
\.


--
-- Data for Name: upload_folders_parent_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.upload_folders_parent_lnk (id, folder_id, inv_folder_id, folder_ord) FROM stdin;
\.


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_permissions_id_seq', 182, true);


--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_permissions_role_lnk_id_seq', 217, true);


--
-- Name: admin_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_roles_id_seq', 3, true);


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 1, true);


--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_users_roles_lnk_id_seq', 2, true);


--
-- Name: certifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.certifications_id_seq', 29, true);


--
-- Name: components_shared_positions_cmps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_shared_positions_cmps_id_seq', 228, true);


--
-- Name: components_shared_positions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_shared_positions_id_seq', 72, true);


--
-- Name: components_shared_responsibilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_shared_responsibilities_id_seq', 228, true);


--
-- Name: components_shared_social_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_shared_social_links_id_seq', 15, true);


--
-- Name: components_shared_soft_skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_shared_soft_skills_id_seq', 30, true);


--
-- Name: educations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.educations_id_seq', 7, true);


--
-- Name: experiences_cmps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.experiences_cmps_id_seq', 72, true);


--
-- Name: experiences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.experiences_id_seq', 24, true);


--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.files_folder_lnk_id_seq', 6, true);


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.files_id_seq', 8, true);


--
-- Name: files_related_mph_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.files_related_mph_id_seq', 16, true);


--
-- Name: i18n_locale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.i18n_locale_id_seq', 2, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.posts_id_seq', 18, true);


--
-- Name: profiles_cmps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.profiles_cmps_id_seq', 45, true);


--
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.profiles_id_seq', 5, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.projects_id_seq', 1, false);


--
-- Name: publications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.publications_id_seq', 15, true);


--
-- Name: skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.skills_id_seq', 105, true);


--
-- Name: strapi_ai_localization_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_ai_localization_jobs_id_seq', 1, false);


--
-- Name: strapi_ai_metadata_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_ai_metadata_jobs_id_seq', 1, false);


--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_id_seq', 1, false);


--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_token_lnk_id_seq', 1, false);


--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 3, true);


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 41, true);


--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 2, true);


--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_history_versions_id_seq', 1, false);


--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);


--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_migrations_internal_id_seq', 7, true);


--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_release_actions_id_seq', 1, false);


--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_release_actions_release_lnk_id_seq', 1, false);


--
-- Name: strapi_releases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_releases_id_seq', 1, false);


--
-- Name: strapi_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_sessions_id_seq', 5, true);


--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_id_seq', 1, false);


--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_token_lnk_id_seq', 1, false);


--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_transfer_tokens_id_seq', 1, false);


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);


--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_workflows_id_seq', 1, false);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_workflows_stage_required_to_publish_lnk_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_permissions_lnk_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_workflow_lnk_id_seq', 1, false);


--
-- Name: up_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_permissions_id_seq', 11, true);


--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_permissions_role_lnk_id_seq', 11, true);


--
-- Name: up_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);


--
-- Name: up_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_users_id_seq', 1, false);


--
-- Name: up_users_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_users_role_lnk_id_seq', 1, false);


--
-- Name: upload_folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.upload_folders_id_seq', 1, true);


--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.upload_folders_parent_lnk_id_seq', 1, false);


--
-- Name: admin_permissions admin_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_uq UNIQUE (permission_id, role_id);


--
-- Name: admin_roles admin_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_uq UNIQUE (user_id, role_id);


--
-- Name: certifications certifications_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.certifications
    ADD CONSTRAINT certifications_pkey PRIMARY KEY (id);


--
-- Name: components_shared_positions_cmps components_shared_positions_cmps_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_shared_positions_cmps
    ADD CONSTRAINT components_shared_positions_cmps_pkey PRIMARY KEY (id);


--
-- Name: components_shared_positions components_shared_positions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_shared_positions
    ADD CONSTRAINT components_shared_positions_pkey PRIMARY KEY (id);


--
-- Name: components_shared_positions_cmps components_shared_positions_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_shared_positions_cmps
    ADD CONSTRAINT components_shared_positions_uq UNIQUE (entity_id, cmp_id, field, component_type);


--
-- Name: components_shared_responsibilities components_shared_responsibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_shared_responsibilities
    ADD CONSTRAINT components_shared_responsibilities_pkey PRIMARY KEY (id);


--
-- Name: components_shared_social_links components_shared_social_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_shared_social_links
    ADD CONSTRAINT components_shared_social_links_pkey PRIMARY KEY (id);


--
-- Name: components_shared_soft_skills components_shared_soft_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_shared_soft_skills
    ADD CONSTRAINT components_shared_soft_skills_pkey PRIMARY KEY (id);


--
-- Name: educations educations_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_pkey PRIMARY KEY (id);


--
-- Name: experiences_cmps experiences_cmps_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.experiences_cmps
    ADD CONSTRAINT experiences_cmps_pkey PRIMARY KEY (id);


--
-- Name: experiences experiences_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.experiences
    ADD CONSTRAINT experiences_pkey PRIMARY KEY (id);


--
-- Name: experiences_cmps experiences_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.experiences_cmps
    ADD CONSTRAINT experiences_uq UNIQUE (entity_id, cmp_id, field, component_type);


--
-- Name: files_folder_lnk files_folder_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_pkey PRIMARY KEY (id);


--
-- Name: files_folder_lnk files_folder_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_uq UNIQUE (file_id, folder_id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: files_related_mph files_related_mph_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_related_mph
    ADD CONSTRAINT files_related_mph_pkey PRIMARY KEY (id);


--
-- Name: i18n_locale i18n_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: profiles_cmps profiles_cmps_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.profiles_cmps
    ADD CONSTRAINT profiles_cmps_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: profiles_cmps profiles_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.profiles_cmps
    ADD CONSTRAINT profiles_uq UNIQUE (entity_id, cmp_id, field, component_type);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: publications publications_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.publications
    ADD CONSTRAINT publications_pkey PRIMARY KEY (id);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- Name: strapi_ai_localization_jobs strapi_ai_localization_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_ai_localization_jobs
    ADD CONSTRAINT strapi_ai_localization_jobs_pkey PRIMARY KEY (id);


--
-- Name: strapi_ai_metadata_jobs strapi_ai_metadata_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_ai_metadata_jobs
    ADD CONSTRAINT strapi_ai_metadata_jobs_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_uq UNIQUE (api_token_permission_id, api_token_id);


--
-- Name: strapi_api_tokens strapi_api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_core_store_settings strapi_core_store_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_core_store_settings
    ADD CONSTRAINT strapi_core_store_settings_pkey PRIMARY KEY (id);


--
-- Name: strapi_database_schema strapi_database_schema_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_database_schema
    ADD CONSTRAINT strapi_database_schema_pkey PRIMARY KEY (id);


--
-- Name: strapi_history_versions strapi_history_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_history_versions
    ADD CONSTRAINT strapi_history_versions_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations_internal strapi_migrations_internal_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_migrations_internal
    ADD CONSTRAINT strapi_migrations_internal_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations strapi_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_migrations
    ADD CONSTRAINT strapi_migrations_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions strapi_release_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_uq UNIQUE (release_action_id, release_id);


--
-- Name: strapi_releases strapi_releases_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_pkey PRIMARY KEY (id);


--
-- Name: strapi_sessions strapi_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_sessions
    ADD CONSTRAINT strapi_sessions_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_uq UNIQUE (transfer_token_permission_id, transfer_token_id);


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_webhooks strapi_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_webhooks
    ADD CONSTRAINT strapi_webhooks_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows strapi_workflows_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_uq UNIQUE (workflow_id, workflow_stage_id);


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_uq UNIQUE (workflow_stage_id, permission_id);


--
-- Name: strapi_workflows_stages strapi_workflows_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_uq UNIQUE (workflow_stage_id, workflow_id);


--
-- Name: up_permissions up_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_uq UNIQUE (permission_id, role_id);


--
-- Name: up_roles up_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_pkey PRIMARY KEY (id);


--
-- Name: up_users up_users_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_lnk up_users_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_lnk up_users_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_uq UNIQUE (user_id, role_id);


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_pkey PRIMARY KEY (id);


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_uq UNIQUE (folder_id, inv_folder_id);


--
-- Name: upload_folders upload_folders_path_id_index; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_id_index UNIQUE (path_id);


--
-- Name: upload_folders upload_folders_path_index; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_index UNIQUE (path);


--
-- Name: upload_folders upload_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id);


--
-- Name: admin_permissions_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_documents_idx ON public.admin_permissions USING btree (document_id, locale, published_at);


--
-- Name: admin_permissions_role_lnk_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_role_lnk_fk ON public.admin_permissions_role_lnk USING btree (permission_id);


--
-- Name: admin_permissions_role_lnk_ifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_role_lnk_ifk ON public.admin_permissions_role_lnk USING btree (role_id);


--
-- Name: admin_permissions_role_lnk_oifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_role_lnk_oifk ON public.admin_permissions_role_lnk USING btree (permission_ord);


--
-- Name: admin_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_updated_by_id_fk ON public.admin_permissions USING btree (updated_by_id);


--
-- Name: admin_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_roles_created_by_id_fk ON public.admin_roles USING btree (created_by_id);


--
-- Name: admin_roles_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_roles_documents_idx ON public.admin_roles USING btree (document_id, locale, published_at);


--
-- Name: admin_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_roles_updated_by_id_fk ON public.admin_roles USING btree (updated_by_id);


--
-- Name: admin_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_created_by_id_fk ON public.admin_users USING btree (created_by_id);


--
-- Name: admin_users_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_documents_idx ON public.admin_users USING btree (document_id, locale, published_at);


--
-- Name: admin_users_roles_lnk_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_roles_lnk_fk ON public.admin_users_roles_lnk USING btree (user_id);


--
-- Name: admin_users_roles_lnk_ifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_roles_lnk_ifk ON public.admin_users_roles_lnk USING btree (role_id);


--
-- Name: admin_users_roles_lnk_ofk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_roles_lnk_ofk ON public.admin_users_roles_lnk USING btree (role_ord);


--
-- Name: admin_users_roles_lnk_oifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_roles_lnk_oifk ON public.admin_users_roles_lnk USING btree (user_ord);


--
-- Name: admin_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_updated_by_id_fk ON public.admin_users USING btree (updated_by_id);


--
-- Name: certifications_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX certifications_created_by_id_fk ON public.certifications USING btree (created_by_id);


--
-- Name: certifications_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX certifications_documents_idx ON public.certifications USING btree (document_id, locale, published_at);


--
-- Name: certifications_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX certifications_updated_by_id_fk ON public.certifications USING btree (updated_by_id);


--
-- Name: components_shared_positions_component_type_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX components_shared_positions_component_type_idx ON public.components_shared_positions_cmps USING btree (component_type);


--
-- Name: components_shared_positions_entity_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX components_shared_positions_entity_fk ON public.components_shared_positions_cmps USING btree (entity_id);


--
-- Name: components_shared_positions_field_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX components_shared_positions_field_idx ON public.components_shared_positions_cmps USING btree (field);


--
-- Name: educations_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX educations_created_by_id_fk ON public.educations USING btree (created_by_id);


--
-- Name: educations_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX educations_documents_idx ON public.educations USING btree (document_id, locale, published_at);


--
-- Name: educations_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX educations_updated_by_id_fk ON public.educations USING btree (updated_by_id);


--
-- Name: experiences_component_type_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX experiences_component_type_idx ON public.experiences_cmps USING btree (component_type);


--
-- Name: experiences_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX experiences_created_by_id_fk ON public.experiences USING btree (created_by_id);


--
-- Name: experiences_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX experiences_documents_idx ON public.experiences USING btree (document_id, locale, published_at);


--
-- Name: experiences_entity_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX experiences_entity_fk ON public.experiences_cmps USING btree (entity_id);


--
-- Name: experiences_field_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX experiences_field_idx ON public.experiences_cmps USING btree (field);


--
-- Name: experiences_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX experiences_updated_by_id_fk ON public.experiences USING btree (updated_by_id);


--
-- Name: files_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_created_by_id_fk ON public.files USING btree (created_by_id);


--
-- Name: files_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_documents_idx ON public.files USING btree (document_id, locale, published_at);


--
-- Name: files_folder_lnk_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_folder_lnk_fk ON public.files_folder_lnk USING btree (file_id);


--
-- Name: files_folder_lnk_ifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_folder_lnk_ifk ON public.files_folder_lnk USING btree (folder_id);


--
-- Name: files_folder_lnk_oifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_folder_lnk_oifk ON public.files_folder_lnk USING btree (file_ord);


--
-- Name: files_related_mph_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_related_mph_fk ON public.files_related_mph USING btree (file_id);


--
-- Name: files_related_mph_idix; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_related_mph_idix ON public.files_related_mph USING btree (related_id);


--
-- Name: files_related_mph_oidx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_related_mph_oidx ON public.files_related_mph USING btree ("order");


--
-- Name: files_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_updated_by_id_fk ON public.files USING btree (updated_by_id);


--
-- Name: i18n_locale_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);


--
-- Name: i18n_locale_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX i18n_locale_documents_idx ON public.i18n_locale USING btree (document_id, locale, published_at);


--
-- Name: i18n_locale_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);


--
-- Name: posts_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX posts_created_by_id_fk ON public.posts USING btree (created_by_id);


--
-- Name: posts_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX posts_documents_idx ON public.posts USING btree (document_id, locale, published_at);


--
-- Name: posts_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX posts_updated_by_id_fk ON public.posts USING btree (updated_by_id);


--
-- Name: profiles_component_type_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX profiles_component_type_idx ON public.profiles_cmps USING btree (component_type);


--
-- Name: profiles_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX profiles_created_by_id_fk ON public.profiles USING btree (created_by_id);


--
-- Name: profiles_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX profiles_documents_idx ON public.profiles USING btree (document_id, locale, published_at);


--
-- Name: profiles_entity_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX profiles_entity_fk ON public.profiles_cmps USING btree (entity_id);


--
-- Name: profiles_field_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX profiles_field_idx ON public.profiles_cmps USING btree (field);


--
-- Name: profiles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX profiles_updated_by_id_fk ON public.profiles USING btree (updated_by_id);


--
-- Name: projects_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX projects_created_by_id_fk ON public.projects USING btree (created_by_id);


--
-- Name: projects_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX projects_documents_idx ON public.projects USING btree (document_id, locale, published_at);


--
-- Name: projects_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX projects_updated_by_id_fk ON public.projects USING btree (updated_by_id);


--
-- Name: publications_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX publications_created_by_id_fk ON public.publications USING btree (created_by_id);


--
-- Name: publications_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX publications_documents_idx ON public.publications USING btree (document_id, locale, published_at);


--
-- Name: publications_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX publications_updated_by_id_fk ON public.publications USING btree (updated_by_id);


--
-- Name: skills_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX skills_created_by_id_fk ON public.skills USING btree (created_by_id);


--
-- Name: skills_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX skills_documents_idx ON public.skills USING btree (document_id, locale, published_at);


--
-- Name: skills_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX skills_updated_by_id_fk ON public.skills USING btree (updated_by_id);


--
-- Name: strapi_api_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);


--
-- Name: strapi_api_token_permissions_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_documents_idx ON public.strapi_api_token_permissions USING btree (document_id, locale, published_at);


--
-- Name: strapi_api_token_permissions_token_lnk_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_token_lnk_fk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_permission_id);


--
-- Name: strapi_api_token_permissions_token_lnk_ifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_token_lnk_ifk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_id);


--
-- Name: strapi_api_token_permissions_token_lnk_oifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_token_lnk_oifk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_permission_ord);


--
-- Name: strapi_api_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_api_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);


--
-- Name: strapi_api_tokens_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_tokens_documents_idx ON public.strapi_api_tokens USING btree (document_id, locale, published_at);


--
-- Name: strapi_api_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);


--
-- Name: strapi_history_versions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_history_versions_created_by_id_fk ON public.strapi_history_versions USING btree (created_by_id);


--
-- Name: strapi_release_actions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_release_actions_created_by_id_fk ON public.strapi_release_actions USING btree (created_by_id);


--
-- Name: strapi_release_actions_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_release_actions_documents_idx ON public.strapi_release_actions USING btree (document_id, locale, published_at);


--
-- Name: strapi_release_actions_release_lnk_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_release_actions_release_lnk_fk ON public.strapi_release_actions_release_lnk USING btree (release_action_id);


--
-- Name: strapi_release_actions_release_lnk_ifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_release_actions_release_lnk_ifk ON public.strapi_release_actions_release_lnk USING btree (release_id);


--
-- Name: strapi_release_actions_release_lnk_oifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_release_actions_release_lnk_oifk ON public.strapi_release_actions_release_lnk USING btree (release_action_ord);


--
-- Name: strapi_release_actions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_release_actions_updated_by_id_fk ON public.strapi_release_actions USING btree (updated_by_id);


--
-- Name: strapi_releases_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_releases_created_by_id_fk ON public.strapi_releases USING btree (created_by_id);


--
-- Name: strapi_releases_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_releases_documents_idx ON public.strapi_releases USING btree (document_id, locale, published_at);


--
-- Name: strapi_releases_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_releases_updated_by_id_fk ON public.strapi_releases USING btree (updated_by_id);


--
-- Name: strapi_sessions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_sessions_created_by_id_fk ON public.strapi_sessions USING btree (created_by_id);


--
-- Name: strapi_sessions_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_sessions_documents_idx ON public.strapi_sessions USING btree (document_id, locale, published_at);


--
-- Name: strapi_sessions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_sessions_updated_by_id_fk ON public.strapi_sessions USING btree (updated_by_id);


--
-- Name: strapi_transfer_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_created_by_id_fk ON public.strapi_transfer_token_permissions USING btree (created_by_id);


--
-- Name: strapi_transfer_token_permissions_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_documents_idx ON public.strapi_transfer_token_permissions USING btree (document_id, locale, published_at);


--
-- Name: strapi_transfer_token_permissions_token_lnk_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_fk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_permission_id);


--
-- Name: strapi_transfer_token_permissions_token_lnk_ifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_ifk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_id);


--
-- Name: strapi_transfer_token_permissions_token_lnk_oifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_oifk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_permission_ord);


--
-- Name: strapi_transfer_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_updated_by_id_fk ON public.strapi_transfer_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_transfer_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_tokens_created_by_id_fk ON public.strapi_transfer_tokens USING btree (created_by_id);


--
-- Name: strapi_transfer_tokens_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_tokens_documents_idx ON public.strapi_transfer_tokens USING btree (document_id, locale, published_at);


--
-- Name: strapi_transfer_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_tokens_updated_by_id_fk ON public.strapi_transfer_tokens USING btree (updated_by_id);


--
-- Name: strapi_workflows_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_created_by_id_fk ON public.strapi_workflows USING btree (created_by_id);


--
-- Name: strapi_workflows_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_documents_idx ON public.strapi_workflows USING btree (document_id, locale, published_at);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_stage_required_to_publish_lnk_fk ON public.strapi_workflows_stage_required_to_publish_lnk USING btree (workflow_id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_ifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_stage_required_to_publish_lnk_ifk ON public.strapi_workflows_stage_required_to_publish_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_stages_created_by_id_fk ON public.strapi_workflows_stages USING btree (created_by_id);


--
-- Name: strapi_workflows_stages_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_stages_documents_idx ON public.strapi_workflows_stages USING btree (document_id, locale, published_at);


--
-- Name: strapi_workflows_stages_permissions_lnk_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_fk ON public.strapi_workflows_stages_permissions_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_permissions_lnk_ifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_ifk ON public.strapi_workflows_stages_permissions_lnk USING btree (permission_id);


--
-- Name: strapi_workflows_stages_permissions_lnk_ofk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_ofk ON public.strapi_workflows_stages_permissions_lnk USING btree (permission_ord);


--
-- Name: strapi_workflows_stages_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_stages_updated_by_id_fk ON public.strapi_workflows_stages USING btree (updated_by_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_fk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_ifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_ifk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_oifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_oifk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_stage_ord);


--
-- Name: strapi_workflows_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_workflows_updated_by_id_fk ON public.strapi_workflows USING btree (updated_by_id);


--
-- Name: up_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_created_by_id_fk ON public.up_permissions USING btree (created_by_id);


--
-- Name: up_permissions_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_documents_idx ON public.up_permissions USING btree (document_id, locale, published_at);


--
-- Name: up_permissions_role_lnk_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_role_lnk_fk ON public.up_permissions_role_lnk USING btree (permission_id);


--
-- Name: up_permissions_role_lnk_ifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_role_lnk_ifk ON public.up_permissions_role_lnk USING btree (role_id);


--
-- Name: up_permissions_role_lnk_oifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_role_lnk_oifk ON public.up_permissions_role_lnk USING btree (permission_ord);


--
-- Name: up_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_updated_by_id_fk ON public.up_permissions USING btree (updated_by_id);


--
-- Name: up_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_roles_created_by_id_fk ON public.up_roles USING btree (created_by_id);


--
-- Name: up_roles_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_roles_documents_idx ON public.up_roles USING btree (document_id, locale, published_at);


--
-- Name: up_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_roles_updated_by_id_fk ON public.up_roles USING btree (updated_by_id);


--
-- Name: up_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_created_by_id_fk ON public.up_users USING btree (created_by_id);


--
-- Name: up_users_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_documents_idx ON public.up_users USING btree (document_id, locale, published_at);


--
-- Name: up_users_role_lnk_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_role_lnk_fk ON public.up_users_role_lnk USING btree (user_id);


--
-- Name: up_users_role_lnk_ifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_role_lnk_ifk ON public.up_users_role_lnk USING btree (role_id);


--
-- Name: up_users_role_lnk_oifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_role_lnk_oifk ON public.up_users_role_lnk USING btree (user_ord);


--
-- Name: up_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_updated_by_id_fk ON public.up_users USING btree (updated_by_id);


--
-- Name: upload_files_created_at_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_created_at_index ON public.files USING btree (created_at);


--
-- Name: upload_files_ext_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_ext_index ON public.files USING btree (ext);


--
-- Name: upload_files_folder_path_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_folder_path_index ON public.files USING btree (folder_path);


--
-- Name: upload_files_name_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_name_index ON public.files USING btree (name);


--
-- Name: upload_files_size_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_size_index ON public.files USING btree (size);


--
-- Name: upload_files_updated_at_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_updated_at_index ON public.files USING btree (updated_at);


--
-- Name: upload_folders_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_created_by_id_fk ON public.upload_folders USING btree (created_by_id);


--
-- Name: upload_folders_documents_idx; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_documents_idx ON public.upload_folders USING btree (document_id, locale, published_at);


--
-- Name: upload_folders_parent_lnk_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_parent_lnk_fk ON public.upload_folders_parent_lnk USING btree (folder_id);


--
-- Name: upload_folders_parent_lnk_ifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_parent_lnk_ifk ON public.upload_folders_parent_lnk USING btree (inv_folder_id);


--
-- Name: upload_folders_parent_lnk_oifk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_parent_lnk_oifk ON public.upload_folders_parent_lnk USING btree (folder_ord);


--
-- Name: upload_folders_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_updated_by_id_fk ON public.upload_folders USING btree (updated_by_id);


--
-- Name: admin_permissions admin_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_permissions admin_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users admin_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_users admin_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: certifications certifications_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.certifications
    ADD CONSTRAINT certifications_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: certifications certifications_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.certifications
    ADD CONSTRAINT certifications_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: components_shared_positions_cmps components_shared_positions_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_shared_positions_cmps
    ADD CONSTRAINT components_shared_positions_entity_fk FOREIGN KEY (entity_id) REFERENCES public.components_shared_positions(id) ON DELETE CASCADE;


--
-- Name: educations educations_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: educations educations_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: experiences experiences_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.experiences
    ADD CONSTRAINT experiences_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: experiences_cmps experiences_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.experiences_cmps
    ADD CONSTRAINT experiences_entity_fk FOREIGN KEY (entity_id) REFERENCES public.experiences(id) ON DELETE CASCADE;


--
-- Name: experiences experiences_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.experiences
    ADD CONSTRAINT experiences_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files files_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files_folder_lnk files_folder_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files_folder_lnk files_folder_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_ifk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: files_related_mph files_related_mph_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_related_mph
    ADD CONSTRAINT files_related_mph_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files files_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: posts posts_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: posts posts_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: profiles profiles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: profiles_cmps profiles_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.profiles_cmps
    ADD CONSTRAINT profiles_entity_fk FOREIGN KEY (entity_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: projects projects_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: projects projects_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: publications publications_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.publications
    ADD CONSTRAINT publications_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: publications publications_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.publications
    ADD CONSTRAINT publications_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: skills skills_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: skills skills_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_ifk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_history_versions strapi_history_versions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_history_versions
    ADD CONSTRAINT strapi_history_versions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_release_actions strapi_release_actions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_fk FOREIGN KEY (release_action_id) REFERENCES public.strapi_release_actions(id) ON DELETE CASCADE;


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_ifk FOREIGN KEY (release_id) REFERENCES public.strapi_releases(id) ON DELETE CASCADE;


--
-- Name: strapi_release_actions strapi_release_actions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_releases strapi_releases_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_releases strapi_releases_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_sessions strapi_sessions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_sessions
    ADD CONSTRAINT strapi_sessions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_sessions strapi_sessions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_sessions
    ADD CONSTRAINT strapi_sessions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_ifk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows strapi_workflows_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_fk FOREIGN KEY (workflow_id) REFERENCES public.strapi_workflows(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_ifk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages strapi_workflows_stages_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_fk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_ifk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages strapi_workflows_stages_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_fk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_ifk FOREIGN KEY (workflow_id) REFERENCES public.strapi_workflows(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows strapi_workflows_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions up_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_permissions up_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users up_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users_role_lnk up_users_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: up_users_role_lnk up_users_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_users up_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders upload_folders_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_ifk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders upload_folders_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict pARsZdHYu9w13haUAsNTC9wF3fneU439sMJv1HyS9TakKdpeLfJWP7l6gSJ3IY9

