--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.5

-- Started on 2018-12-11 11:53:20

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12393)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 181 (class 1259 OID 26740)
-- Name: admin_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_config (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255) NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    category character varying(255) DEFAULT 'General'::character varying
);


--
-- TOC entry 182 (class 1259 OID 26747)
-- Name: admin_config_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 182
-- Name: admin_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_config_id_seq OWNED BY admin_config.id;


--
-- TOC entry 183 (class 1259 OID 26749)
-- Name: admin_menu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_menu (
    id integer NOT NULL,
    parent_id integer DEFAULT 0 NOT NULL,
    "order" integer DEFAULT 0 NOT NULL,
    title character varying(50) NOT NULL,
    icon character varying(50) NOT NULL,
    uri character varying(50),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    icon_color character varying(7) DEFAULT '#FFFFFF'::character varying
);


--
-- TOC entry 184 (class 1259 OID 26755)
-- Name: admin_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2473 (class 0 OID 0)
-- Dependencies: 184
-- Name: admin_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_menu_id_seq OWNED BY admin_menu.id;


--
-- TOC entry 185 (class 1259 OID 26757)
-- Name: admin_operation_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_operation_log (
    id integer NOT NULL,
    user_id integer NOT NULL,
    path character varying(255) NOT NULL,
    method character varying(10) NOT NULL,
    ip character varying(15) NOT NULL,
    input text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 186 (class 1259 OID 26763)
-- Name: admin_operation_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_operation_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 186
-- Name: admin_operation_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_operation_log_id_seq OWNED BY admin_operation_log.id;


--
-- TOC entry 187 (class 1259 OID 26765)
-- Name: admin_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_permissions (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    http_method character varying(255),
    http_path text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    cat_id integer DEFAULT 1 NOT NULL
);


--
-- TOC entry 188 (class 1259 OID 26772)
-- Name: admin_permissions_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_permissions_categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- TOC entry 189 (class 1259 OID 26775)
-- Name: admin_permissions_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_permissions_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2475 (class 0 OID 0)
-- Dependencies: 189
-- Name: admin_permissions_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_permissions_categories_id_seq OWNED BY admin_permissions_categories.id;


--
-- TOC entry 190 (class 1259 OID 26777)
-- Name: admin_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2476 (class 0 OID 0)
-- Dependencies: 190
-- Name: admin_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_permissions_id_seq OWNED BY admin_permissions.id;


--
-- TOC entry 191 (class 1259 OID 26779)
-- Name: admin_role_menu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_role_menu (
    role_id integer NOT NULL,
    menu_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 192 (class 1259 OID 26782)
-- Name: admin_role_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_role_permissions (
    role_id integer NOT NULL,
    permission_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 193 (class 1259 OID 26785)
-- Name: admin_role_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_role_users (
    role_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 194 (class 1259 OID 26788)
-- Name: admin_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_roles (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 195 (class 1259 OID 26791)
-- Name: admin_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2477 (class 0 OID 0)
-- Dependencies: 195
-- Name: admin_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_roles_id_seq OWNED BY admin_roles.id;


--
-- TOC entry 196 (class 1259 OID 26793)
-- Name: admin_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_user_permissions (
    user_id integer NOT NULL,
    permission_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 197 (class 1259 OID 26796)
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_users (
    id integer NOT NULL,
    username character varying(190) NOT NULL,
    password character varying(60) NOT NULL,
    name character varying(255) NOT NULL,
    avatar character varying(255),
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 198 (class 1259 OID 26802)
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2478 (class 0 OID 0)
-- Dependencies: 198
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_users_id_seq OWNED BY admin_users.id;


--
-- TOC entry 199 (class 1259 OID 26804)
-- Name: label_cats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE label_cats (
    id integer NOT NULL,
    parent_id integer DEFAULT 0 NOT NULL,
    alias character varying(50),
    name character varying(250),
    ord integer DEFAULT 0 NOT NULL,
    state integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 200 (class 1259 OID 26810)
-- Name: label_cats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE label_cats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2479 (class 0 OID 0)
-- Dependencies: 200
-- Name: label_cats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE label_cats_id_seq OWNED BY label_cats.id;


--
-- TOC entry 201 (class 1259 OID 26812)
-- Name: label_langs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE label_langs (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    alias character varying(50),
    ord integer DEFAULT 0 NOT NULL,
    state integer DEFAULT 0 NOT NULL,
    "default" integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 202 (class 1259 OID 26818)
-- Name: label_langs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE label_langs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2480 (class 0 OID 0)
-- Dependencies: 202
-- Name: label_langs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE label_langs_id_seq OWNED BY label_langs.id;


--
-- TOC entry 203 (class 1259 OID 26820)
-- Name: labels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE labels (
    id integer NOT NULL,
    parent_id integer DEFAULT 0 NOT NULL,
    label character varying(150),
    value_1 text,
    value_2 text,
    value_13 text,
    value_14 text
);


--
-- TOC entry 204 (class 1259 OID 26827)
-- Name: labels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2481 (class 0 OID 0)
-- Dependencies: 204
-- Name: labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE labels_id_seq OWNED BY labels.id;


--
-- TOC entry 205 (class 1259 OID 26829)
-- Name: laravel_exceptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE laravel_exceptions (
    id integer NOT NULL,
    type character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    message character varying(255) NOT NULL,
    file character varying(255) NOT NULL,
    line integer NOT NULL,
    trace text NOT NULL,
    method character varying(255) NOT NULL,
    path character varying(255) NOT NULL,
    query text NOT NULL,
    body text NOT NULL,
    cookies text NOT NULL,
    headers text NOT NULL,
    ip character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 206 (class 1259 OID 26835)
-- Name: laravel_exceptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE laravel_exceptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2482 (class 0 OID 0)
-- Dependencies: 206
-- Name: laravel_exceptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE laravel_exceptions_id_seq OWNED BY laravel_exceptions.id;


--
-- TOC entry 207 (class 1259 OID 26837)
-- Name: ltm_translations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ltm_translations (
    id integer NOT NULL,
    status smallint DEFAULT '0'::smallint NOT NULL,
    locale character varying(32) NOT NULL,
    "group" character varying(128) NOT NULL,
    key character varying(128) NOT NULL,
    value text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    saved_value text,
    is_deleted smallint DEFAULT '0'::smallint NOT NULL,
    was_used smallint DEFAULT '0'::smallint NOT NULL,
    source text,
    is_auto_added boolean DEFAULT false NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 26847)
-- Name: ltm_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ltm_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2483 (class 0 OID 0)
-- Dependencies: 208
-- Name: ltm_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ltm_translations_id_seq OWNED BY ltm_translations.id;


--
-- TOC entry 209 (class 1259 OID 26849)
-- Name: ltm_user_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ltm_user_locales (
    id integer NOT NULL,
    user_id integer NOT NULL,
    locales text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 210 (class 1259 OID 26855)
-- Name: ltm_user_locales_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ltm_user_locales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2484 (class 0 OID 0)
-- Dependencies: 210
-- Name: ltm_user_locales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ltm_user_locales_id_seq OWNED BY ltm_user_locales.id;


--
-- TOC entry 211 (class 1259 OID 26857)
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- TOC entry 212 (class 1259 OID 26860)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2485 (class 0 OID 0)
-- Dependencies: 212
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE migrations_id_seq OWNED BY migrations.id;


--
-- TOC entry 213 (class 1259 OID 26862)
-- Name: mod_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mod_images (
    id integer NOT NULL,
    item_id integer DEFAULT 0,
    module character varying(100),
    main integer DEFAULT 0,
    path character varying(255),
    filename character varying(255),
    alt character varying(100),
    disk character varying(100)
);


--
-- TOC entry 214 (class 1259 OID 26870)
-- Name: mod_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mod_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2486 (class 0 OID 0)
-- Dependencies: 214
-- Name: mod_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mod_images_id_seq OWNED BY mod_images.id;


--
-- TOC entry 215 (class 1259 OID 26872)
-- Name: mod_news; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mod_news (
    id integer NOT NULL,
    log_name character varying(255) NOT NULL,
    alias character varying(255) NOT NULL,
    comments_enabled smallint DEFAULT '0'::smallint NOT NULL,
    state smallint DEFAULT '0'::smallint NOT NULL,
    lock_alias smallint DEFAULT '0'::smallint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 216 (class 1259 OID 26881)
-- Name: mod_news_i18n; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mod_news_i18n (
    id integer NOT NULL,
    row_id integer NOT NULL,
    locale character varying(255) NOT NULL,
    name character varying(550),
    introtext character varying(550),
    text text,
    seo_h1 character varying(255),
    seo_title text,
    seo_keywords text,
    seo_description text
);


--
-- TOC entry 217 (class 1259 OID 26887)
-- Name: mod_news_i18n_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mod_news_i18n_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2487 (class 0 OID 0)
-- Dependencies: 217
-- Name: mod_news_i18n_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mod_news_i18n_id_seq OWNED BY mod_news_i18n.id;


--
-- TOC entry 218 (class 1259 OID 26889)
-- Name: mod_news_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mod_news_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2488 (class 0 OID 0)
-- Dependencies: 218
-- Name: mod_news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mod_news_id_seq OWNED BY mod_news.id;


--
-- TOC entry 219 (class 1259 OID 26891)
-- Name: mod_seo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mod_seo (
    id integer NOT NULL,
    log_name character varying(255) NOT NULL,
    alias character varying(255) NOT NULL,
    link character varying(1000) NOT NULL,
    state smallint DEFAULT '0'::smallint NOT NULL,
    lock_alias smallint DEFAULT '0'::smallint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 220 (class 1259 OID 26899)
-- Name: mod_seo_i18n; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mod_seo_i18n (
    id integer NOT NULL,
    row_id integer NOT NULL,
    locale character varying(255) NOT NULL,
    introtext character varying(550),
    text text,
    seo_h1 character varying(255),
    seo_title text,
    seo_keywords text,
    seo_description text
);


--
-- TOC entry 221 (class 1259 OID 26905)
-- Name: mod_seo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mod_seo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2489 (class 0 OID 0)
-- Dependencies: 221
-- Name: mod_seo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mod_seo_id_seq OWNED BY mod_seo.id;


--
-- TOC entry 222 (class 1259 OID 26907)
-- Name: mod_seo_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mod_seo_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2490 (class 0 OID 0)
-- Dependencies: 222
-- Name: mod_seo_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mod_seo_translations_id_seq OWNED BY mod_seo_i18n.id;


--
-- TOC entry 223 (class 1259 OID 26909)
-- Name: password_resets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


--
-- TOC entry 224 (class 1259 OID 26915)
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sessions (
    id character varying(255) NOT NULL,
    user_id integer,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 26921)
-- Name: system_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE system_modules (
    id integer NOT NULL,
    parent_id integer DEFAULT 0 NOT NULL,
    key character varying(100) NOT NULL,
    path character varying(100) NOT NULL,
    name character varying(250) NOT NULL,
    icon character varying(50),
    icon_color character varying(10) DEFAULT '#FFFFFF'::character varying,
    description character varying(255),
    state smallint DEFAULT '1'::smallint NOT NULL,
    module_order integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 26931)
-- Name: system_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE system_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2491 (class 0 OID 0)
-- Dependencies: 226
-- Name: system_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE system_modules_id_seq OWNED BY system_modules.id;


--
-- TOC entry 227 (class 1259 OID 26933)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 228 (class 1259 OID 26939)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2492 (class 0 OID 0)
-- Dependencies: 228
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 2179 (class 2604 OID 26941)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_config ALTER COLUMN id SET DEFAULT nextval('admin_config_id_seq'::regclass);


--
-- TOC entry 2183 (class 2604 OID 26942)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_menu ALTER COLUMN id SET DEFAULT nextval('admin_menu_id_seq'::regclass);


--
-- TOC entry 2184 (class 2604 OID 26943)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_operation_log ALTER COLUMN id SET DEFAULT nextval('admin_operation_log_id_seq'::regclass);


--
-- TOC entry 2186 (class 2604 OID 26944)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_permissions ALTER COLUMN id SET DEFAULT nextval('admin_permissions_id_seq'::regclass);


--
-- TOC entry 2187 (class 2604 OID 26945)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_permissions_categories ALTER COLUMN id SET DEFAULT nextval('admin_permissions_categories_id_seq'::regclass);


--
-- TOC entry 2188 (class 2604 OID 26946)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_roles ALTER COLUMN id SET DEFAULT nextval('admin_roles_id_seq'::regclass);


--
-- TOC entry 2189 (class 2604 OID 26947)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_users ALTER COLUMN id SET DEFAULT nextval('admin_users_id_seq'::regclass);


--
-- TOC entry 2193 (class 2604 OID 26948)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY label_cats ALTER COLUMN id SET DEFAULT nextval('label_cats_id_seq'::regclass);


--
-- TOC entry 2197 (class 2604 OID 26949)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY label_langs ALTER COLUMN id SET DEFAULT nextval('label_langs_id_seq'::regclass);


--
-- TOC entry 2199 (class 2604 OID 26950)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY labels ALTER COLUMN id SET DEFAULT nextval('labels_id_seq'::regclass);


--
-- TOC entry 2200 (class 2604 OID 26951)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY laravel_exceptions ALTER COLUMN id SET DEFAULT nextval('laravel_exceptions_id_seq'::regclass);


--
-- TOC entry 2205 (class 2604 OID 26952)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ltm_translations ALTER COLUMN id SET DEFAULT nextval('ltm_translations_id_seq'::regclass);


--
-- TOC entry 2206 (class 2604 OID 26953)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ltm_user_locales ALTER COLUMN id SET DEFAULT nextval('ltm_user_locales_id_seq'::regclass);


--
-- TOC entry 2207 (class 2604 OID 26954)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY migrations ALTER COLUMN id SET DEFAULT nextval('migrations_id_seq'::regclass);


--
-- TOC entry 2210 (class 2604 OID 26955)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_images ALTER COLUMN id SET DEFAULT nextval('mod_images_id_seq'::regclass);


--
-- TOC entry 2214 (class 2604 OID 26956)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_news ALTER COLUMN id SET DEFAULT nextval('mod_news_id_seq'::regclass);


--
-- TOC entry 2215 (class 2604 OID 26957)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_news_i18n ALTER COLUMN id SET DEFAULT nextval('mod_news_i18n_id_seq'::regclass);


--
-- TOC entry 2218 (class 2604 OID 26958)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_seo ALTER COLUMN id SET DEFAULT nextval('mod_seo_id_seq'::regclass);


--
-- TOC entry 2219 (class 2604 OID 26959)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_seo_i18n ALTER COLUMN id SET DEFAULT nextval('mod_seo_translations_id_seq'::regclass);


--
-- TOC entry 2224 (class 2604 OID 26960)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY system_modules ALTER COLUMN id SET DEFAULT nextval('system_modules_id_seq'::regclass);


--
-- TOC entry 2225 (class 2604 OID 26961)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 2417 (class 0 OID 26740)
-- Dependencies: 181
-- Data for Name: admin_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY admin_config (id, name, value, description, created_at, updated_at, category) FROM stdin;
3	enable_debug	0	Включает дебаг	2018-01-05 07:28:58	2018-10-08 07:47:23	general
2	enable_log	1	Включает логирование	2018-01-05 07:28:09	2018-11-30 12:00:30	system
\.


--
-- TOC entry 2493 (class 0 OID 0)
-- Dependencies: 182
-- Name: admin_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('admin_config_id_seq', 3, true);


--
-- TOC entry 2419 (class 0 OID 26749)
-- Dependencies: 183
-- Data for Name: admin_menu; Type: TABLE DATA; Schema: public; Owner: -
--

COPY admin_menu (id, parent_id, "order", title, icon, uri, created_at, updated_at, icon_color) FROM stdin;
1	0	1	Index	fa-bar-chart	/	\N	\N	\N
4	2	16	Roles	fa-user	auth/roles	\N	2018-10-01 09:06:49	\N
42	41	3	SEO	fa-compass	/seo	2018-10-01 08:59:44	2018-10-01 09:06:49	#FFFFFF
40	39	5	Новости	fa-navicon	/news	2018-05-18 14:17:41	2018-10-01 09:06:49	#FFFFFF
34	0	6	Модули	fa-cubes	\N	2018-01-19 12:48:15	2018-10-01 09:06:49	#FFFFFF
35	34	7	Модули	fa-cubes	/modules	2018-01-19 12:48:15	2018-10-01 09:06:49	#FFFFFF
24	0	8	Настройки	fa-anchor	\N	2018-01-05 08:57:15	2018-10-01 09:06:49	\N
21	0	9	Мультиязычность	fa-amazon	\N	2017-12-14 17:41:48	2018-10-01 09:06:49	#ffb600
36	21	10	Языки	fa-amazon	/langs	2018-01-19 12:55:34	2018-10-01 09:06:49	
37	21	11	Метки	fa-bookmark	/langs_labels	2018-01-19 12:55:34	2018-10-01 09:06:49	
38	21	12	Категории меток	fa-copy	/langs_cats	2018-01-19 12:55:35	2018-10-01 09:06:49	
41	0	2	SEO	fa-compass	\N	2018-10-01 08:59:44	2018-10-01 09:07:30	#FFFFFF
17	0	13	Опции	fa-toggle-on	config	2017-11-30 10:35:51	2018-10-01 09:06:49	\N
2	0	14	Админ	fa-tasks	\N	\N	2018-10-01 09:06:49	\N
3	2	15	Users	fa-users	auth/users	\N	2018-10-01 09:06:49	\N
47	46	20	Permission Categories	fa-clone	/auth/permissions-cat	2018-11-30 11:20:24	2018-11-30 11:22:21	#FFFFFF
6	2	17	Menu	fa-bars	auth/menu	\N	2018-11-30 11:18:50	\N
7	2	18	Operation log	fa-history	auth/logs	\N	2018-11-30 11:18:50	\N
46	2	19	Permission	fa-ban	\N	2018-10-03 10:19:29	2018-11-30 11:18:50	#FFFFFF
39	0	4	Новости	fa-newspaper-o	\N	2018-05-18 14:17:41	2018-12-03 11:13:13	#a83122
48	0	37	EnvManager	fa-gears	env-manager	2018-12-03 11:20:44	2018-12-03 11:20:44	#FFFFFF
51	0	40	ComposerViewer	fa-gears	composer-viewer	2018-12-03 11:23:12	2018-12-03 11:23:12	#FFFFFF
5	46	21	Permission	fa-ban	auth/permissions	\N	2018-11-30 11:21:51	\N
25	0	22	Инструменты	fa-anchor	\N	2018-01-05 10:29:41	2018-11-30 11:21:51	\N
19	0	23	Scheduling	fa-clock-o	scheduling	2017-11-30 10:38:38	2018-11-30 11:21:51	\N
18	0	24	Api tester	fa-sliders	api-tester	2017-11-30 10:37:24	2018-11-30 11:21:51	\N
16	0	25	Backup	fa-copy	backup	2017-11-30 10:30:04	2018-11-30 11:21:51	\N
9	0	26	Helpers	fa-gears	\N	2017-11-30 10:23:07	2018-11-30 11:21:51	\N
10	9	27	Scaffold	fa-keyboard-o	helpers/scaffold	2017-11-30 10:23:07	2018-11-30 11:21:51	\N
11	9	28	Database terminal	fa-database	helpers/terminal/database	2017-11-30 10:23:07	2018-11-30 11:21:51	\N
12	9	29	Laravel artisan	fa-terminal	helpers/terminal/artisan	2017-11-30 10:23:07	2018-11-30 11:21:51	\N
13	9	30	Routes	fa-list-alt	helpers/routes	2017-11-30 10:23:07	2018-11-30 11:21:51	\N
8	0	31	Log viwer	fa-database	logs	2017-11-30 10:21:22	2018-11-30 11:21:51	\N
14	0	32	Exception Reporter	fa-bug	exceptions	2017-11-30 10:24:43	2018-11-30 11:21:51	\N
15	0	35	Media manager	fa-file	media	2017-11-30 10:28:30	2018-11-30 11:21:51	\N
45	0	36	PHP info	fa-exclamation	phpinfo	2018-10-03 10:19:29	2018-11-30 11:21:51	#FFFFFF
\.


--
-- TOC entry 2494 (class 0 OID 0)
-- Dependencies: 184
-- Name: admin_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('admin_menu_id_seq', 51, true);


--
-- TOC entry 2421 (class 0 OID 26757)
-- Dependencies: 185
-- Data for Name: admin_operation_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY admin_operation_log (id, user_id, path, method, ip, input, created_at, updated_at) FROM stdin;
1200	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 10:12:04	2018-10-02 10:12:04
1201	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 10:12:32	2018-10-02 10:12:32
1202	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 10:14:35	2018-10-02 10:14:35
1203	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 10:15:42	2018-10-02 10:15:42
1204	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 10:50:44	2018-10-02 10:50:44
1205	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 10:53:01	2018-10-02 10:53:01
1206	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 10:53:42	2018-10-02 10:53:42
1207	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 10:54:30	2018-10-02 10:54:30
1208	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 10:55:14	2018-10-02 10:55:14
1209	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 10:56:25	2018-10-02 10:56:25
1210	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-02 10:58:26	2018-10-02 10:58:26
1211	1	admin/modules/install	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"5"}	2018-10-02 10:59:51	2018-10-02 10:59:51
1212	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-02 10:59:53	2018-10-02 10:59:53
1213	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-02 11:00:03	2018-10-02 11:00:03
1214	1	admin/seo/1/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-02 11:00:07	2018-10-02 11:00:07
1215	1	admin/images/upload	GET	192.168.10.1	[]	2018-10-02 11:01:40	2018-10-02 11:01:40
1216	1	admin/images/upload	GET	192.168.10.1	[]	2018-10-02 11:02:13	2018-10-02 11:02:13
1217	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:02:22	2018-10-02 11:02:22
1218	1	admin/images/upload	GET	192.168.10.1	[]	2018-10-02 11:02:43	2018-10-02 11:02:43
1219	1	admin/images/upload	GET	192.168.10.1	[]	2018-10-02 11:02:48	2018-10-02 11:02:48
1220	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:11:06	2018-10-02 11:11:06
1221	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:13:24	2018-10-02 11:13:24
1222	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:16:18	2018-10-02 11:16:18
1223	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:17:22	2018-10-02 11:17:22
1224	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:18:49	2018-10-02 11:18:49
1225	1	admin/images/upload	POST	192.168.10.1	{"name":"Koala.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:19:02	2018-10-02 11:19:02
1226	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:19:44	2018-10-02 11:19:44
1227	1	admin/images/upload	POST	192.168.10.1	{"name":"Koala.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:19:51	2018-10-02 11:19:51
1228	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:21:22	2018-10-02 11:21:22
1229	1	admin/images/upload	POST	192.168.10.1	{"name":"Koala.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:21:29	2018-10-02 11:21:29
1230	1	admin/images/upload	POST	192.168.10.1	{"name":"Jellyfish.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:22:12	2018-10-02 11:22:12
1231	1	admin/images/upload	POST	192.168.10.1	{"name":"Lighthouse.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:22:32	2018-10-02 11:22:32
1232	1	admin/images/upload	POST	192.168.10.1	{"name":"Koala.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:23:26	2018-10-02 11:23:26
1233	1	admin/images/upload	POST	192.168.10.1	{"name":"Lighthouse.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:24:20	2018-10-02 11:24:20
1234	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:29:40	2018-10-02 11:29:40
1235	1	admin/images/upload	POST	192.168.10.1	{"name":"Lighthouse.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:29:47	2018-10-02 11:29:47
1236	1	admin/images/upload	POST	192.168.10.1	{"name":"Koala.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:32:58	2018-10-02 11:32:58
1237	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:34:54	2018-10-02 11:34:54
1238	1	admin/images/upload	POST	192.168.10.1	{"name":"Lighthouse.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:35:01	2018-10-02 11:35:01
1239	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:40:03	2018-10-02 11:40:03
1240	1	admin/images/upload	POST	192.168.10.1	{"name":"Koala.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:40:24	2018-10-02 11:40:24
1241	1	admin/images/upload	POST	192.168.10.1	{"name":"Jellyfish.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:41:07	2018-10-02 11:41:07
1242	1	admin/images/upload	POST	192.168.10.1	{"name":"Hydrangeas.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:41:09	2018-10-02 11:41:09
1243	1	admin/images/upload	POST	192.168.10.1	{"name":"Desert.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:41:10	2018-10-02 11:41:10
1244	1	admin/images/upload	POST	192.168.10.1	{"name":"Jellyfish.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:45:27	2018-10-02 11:45:27
1245	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:48:42	2018-10-02 11:48:42
1246	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:49:17	2018-10-02 11:49:17
1247	1	admin/images/upload	POST	192.168.10.1	{"name":"Lighthouse.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:49:29	2018-10-02 11:49:29
1248	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 11:50:50	2018-10-02 11:50:50
1249	1	admin/images/upload	POST	192.168.10.1	{"name":"Lighthouse.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 11:50:58	2018-10-02 11:50:58
1250	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 12:09:26	2018-10-02 12:09:26
1251	1	admin/images/upload	POST	192.168.10.1	{"name":"Koala.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 12:09:35	2018-10-02 12:09:35
1252	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 12:09:36	2018-10-02 12:09:36
1253	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 12:10:14	2018-10-02 12:10:14
1254	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 12:10:41	2018-10-02 12:10:41
1318	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:39	2018-10-02 14:11:39
1255	1	admin/images/upload	POST	192.168.10.1	{"name":"Koala.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 12:10:51	2018-10-02 12:10:51
1256	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 12:10:52	2018-10-02 12:10:52
1257	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 12:11:37	2018-10-02 12:11:37
1258	1	admin/images/upload	POST	192.168.10.1	{"name":"Jellyfish.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 12:11:45	2018-10-02 12:11:45
1259	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 12:11:47	2018-10-02 12:11:47
1260	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 12:15:33	2018-10-02 12:15:33
1261	1	admin/images/upload	POST	192.168.10.1	{"name":"Koala.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 12:15:41	2018-10-02 12:15:41
1262	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 12:15:58	2018-10-02 12:15:58
1263	1	admin/images/upload	POST	192.168.10.1	{"name":"Lighthouse.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 12:16:06	2018-10-02 12:16:06
1264	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 12:17:59	2018-10-02 12:17:59
1265	1	admin/images/upload	POST	192.168.10.1	{"name":"Lighthouse.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 12:18:06	2018-10-02 12:18:06
1266	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 12:18:44	2018-10-02 12:18:44
1267	1	admin/images/upload	POST	192.168.10.1	{"name":"Koala.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 12:18:52	2018-10-02 12:18:52
1268	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 12:18:53	2018-10-02 12:18:53
1269	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 12:22:21	2018-10-02 12:22:21
1270	1	admin/images/upload	POST	192.168.10.1	{"name":"Jellyfish.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 12:22:29	2018-10-02 12:22:29
1271	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 12:22:30	2018-10-02 12:22:30
1272	1	admin/images/upload	POST	192.168.10.1	{"name":"Lighthouse.jpg","chunk":"0","chunks":"1","alias":"seo","alias_img":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 12:22:37	2018-10-02 12:22:37
1273	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 12:22:38	2018-10-02 12:22:38
1274	1	admin	GET	192.168.10.1	[]	2018-10-02 13:48:33	2018-10-02 13:48:33
1275	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-02 13:48:41	2018-10-02 13:48:41
1276	1	admin/seo/1/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-02 13:48:45	2018-10-02 13:48:45
1277	1	admin/images/upload	POST	192.168.10.1	{"name":"Jellyfish.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 13:49:03	2018-10-02 13:49:03
1278	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 13:49:04	2018-10-02 13:49:04
1279	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:08:12	2018-10-02 14:08:12
1280	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:09:25	2018-10-02 14:09:25
1281	1	admin/images/seo/1/100/58-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:28	2018-10-02 14:09:28
1282	1	admin/images/seo/1/100/bR-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:28	2018-10-02 14:09:28
1283	1	admin/images/seo/1/100/9F-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:29	2018-10-02 14:09:29
1284	1	admin/images/seo/1/100/RB-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:29	2018-10-02 14:09:29
1285	1	admin/images/seo/1/100/ct-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:29	2018-10-02 14:09:29
1286	1	admin/images/seo/1/100/uK-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:30	2018-10-02 14:09:30
1287	1	admin/images/seo/1/100/0v-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:31	2018-10-02 14:09:31
1288	1	admin/images/seo/1/100/Kb-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:32	2018-10-02 14:09:32
1289	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:32	2018-10-02 14:09:32
1290	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:32	2018-10-02 14:09:32
1291	1	admin/images/seo/1/100/oM-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:32	2018-10-02 14:09:32
1292	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:33	2018-10-02 14:09:33
1293	1	admin/images/seo/1/100/Gt-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:33	2018-10-02 14:09:33
1294	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:34	2018-10-02 14:09:34
1295	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:34	2018-10-02 14:09:34
1296	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:34	2018-10-02 14:09:34
1297	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:35	2018-10-02 14:09:35
1298	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:35	2018-10-02 14:09:35
1299	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:35	2018-10-02 14:09:35
1300	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:09:35	2018-10-02 14:09:35
1301	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:11:29	2018-10-02 14:11:29
1302	1	admin/images/seo/1/100/bR-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:32	2018-10-02 14:11:32
1303	1	admin/images/seo/1/100/uK-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:32	2018-10-02 14:11:32
1304	1	admin/images/seo/1/100/RB-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:32	2018-10-02 14:11:32
1305	1	admin/images/seo/1/100/ct-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:33	2018-10-02 14:11:33
1306	1	admin/images/seo/1/100/9F-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:33	2018-10-02 14:11:33
1307	1	admin/images/seo/1/100/58-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:34	2018-10-02 14:11:34
1308	1	admin/images/seo/1/100/Kb-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:34	2018-10-02 14:11:34
1309	1	admin/images/seo/1/100/0v-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:35	2018-10-02 14:11:35
1310	1	admin/images/seo/1/100/oM-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:36	2018-10-02 14:11:36
1311	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:37	2018-10-02 14:11:37
1312	1	admin/images/seo/1/100/Gt-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:37	2018-10-02 14:11:37
1313	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:37	2018-10-02 14:11:37
1314	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:37	2018-10-02 14:11:37
1315	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:37	2018-10-02 14:11:37
1316	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:38	2018-10-02 14:11:38
1317	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:39	2018-10-02 14:11:39
1319	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:39	2018-10-02 14:11:39
1320	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:39	2018-10-02 14:11:39
1321	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:11:39	2018-10-02 14:11:39
1322	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:12:15	2018-10-02 14:12:15
1323	1	admin/images/seo/1/100/bR-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:17	2018-10-02 14:12:17
1324	1	admin/images/seo/1/100/58-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:17	2018-10-02 14:12:17
1325	1	admin/images/seo/1/100/ct-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:18	2018-10-02 14:12:18
1326	1	admin/images/seo/1/100/uK-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:18	2018-10-02 14:12:18
1327	1	admin/images/seo/1/100/9F-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:18	2018-10-02 14:12:18
1328	1	admin/images/seo/1/100/RB-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:18	2018-10-02 14:12:18
1329	1	admin/images/seo/1/100/0v-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:19	2018-10-02 14:12:19
1330	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:19	2018-10-02 14:12:19
1331	1	admin/images/seo/1/100/Kb-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:19	2018-10-02 14:12:19
1332	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:20	2018-10-02 14:12:20
1333	1	admin/images/seo/1/100/Gt-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:20	2018-10-02 14:12:20
1334	1	admin/images/seo/1/100/oM-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:20	2018-10-02 14:12:20
1335	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:21	2018-10-02 14:12:21
1336	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:22	2018-10-02 14:12:22
1337	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:22	2018-10-02 14:12:22
1338	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:22	2018-10-02 14:12:22
1339	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:22	2018-10-02 14:12:22
1340	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:23	2018-10-02 14:12:23
1341	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:23	2018-10-02 14:12:23
1342	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:23	2018-10-02 14:12:23
1343	1	admin/images/seo/1/100/9F-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:29	2018-10-02 14:12:29
1344	1	admin/images/seo/1/100/uK-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:29	2018-10-02 14:12:29
1345	1	admin/images/seo/1/100/RB-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:29	2018-10-02 14:12:29
1346	1	admin/images/seo/1/100/58-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:29	2018-10-02 14:12:29
1347	1	admin/seo/1	PUT	192.168.10.1	{"log_name":"\\u0442\\u0435\\u0441\\u0442","alias":"alias","lock_alias":"on","link":"uri","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","_method":"PUT"}	2018-10-02 14:12:29	2018-10-02 14:12:29
1348	1	admin/images/seo/1/100/0v-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:29	2018-10-02 14:12:29
1349	1	admin/images/seo/1/100/bR-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:29	2018-10-02 14:12:29
1350	1	admin/images/seo/1/100/ct-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:29	2018-10-02 14:12:29
1351	1	admin/images/seo/1/100/Kb-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:31	2018-10-02 14:12:31
1352	1	admin/images/seo/1/100/oM-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:31	2018-10-02 14:12:31
1353	1	admin/images/seo/1/100/Gt-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:31	2018-10-02 14:12:31
1354	1	admin/seo	GET	192.168.10.1	[]	2018-10-02 14:12:31	2018-10-02 14:12:31
1355	1	admin/seo/1/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-02 14:12:37	2018-10-02 14:12:37
1356	1	admin/images/seo/1/100/ct-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:39	2018-10-02 14:12:39
1357	1	admin/images/seo/1/100/uK-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:39	2018-10-02 14:12:39
1358	1	admin/images/seo/1/100/bR-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:39	2018-10-02 14:12:39
1359	1	admin/images/seo/1/100/58-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:39	2018-10-02 14:12:39
1360	1	admin/images/seo/1/100/9F-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:39	2018-10-02 14:12:39
1361	1	admin/images/seo/1/100/RB-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:39	2018-10-02 14:12:39
1362	1	admin/images/seo/1/100/0v-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:41	2018-10-02 14:12:41
1363	1	admin/images/seo/1/100/Kb-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:41	2018-10-02 14:12:41
1364	1	admin/images/seo/1/100/oM-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:41	2018-10-02 14:12:41
1365	1	admin/images/seo/1/100/Gt-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:12:41	2018-10-02 14:12:41
1366	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:15:45	2018-10-02 14:15:45
1367	1	admin/images/seo/1/100/bR-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:49	2018-10-02 14:15:49
1368	1	admin/images/seo/1/100/RB-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:49	2018-10-02 14:15:49
1369	1	admin/images/seo/1/100/9F-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:50	2018-10-02 14:15:50
1370	1	admin/images/seo/1/100/ct-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:50	2018-10-02 14:15:50
1371	1	admin/images/seo/1/100/58-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:50	2018-10-02 14:15:50
1372	1	admin/images/seo/1/100/uK-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:50	2018-10-02 14:15:50
1373	1	admin/images/seo/1/100/0v-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:51	2018-10-02 14:15:51
1374	1	admin/images/seo/1/100/Kb-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:52	2018-10-02 14:15:52
1375	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:52	2018-10-02 14:15:52
1376	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:53	2018-10-02 14:15:53
1377	1	admin/images/seo/1/100/oM-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:53	2018-10-02 14:15:53
1378	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:53	2018-10-02 14:15:53
1379	1	admin/images/seo/1/100/Gt-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:54	2018-10-02 14:15:54
1380	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:54	2018-10-02 14:15:54
1381	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:55	2018-10-02 14:15:55
1382	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:55	2018-10-02 14:15:55
1383	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:56	2018-10-02 14:15:56
1384	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:56	2018-10-02 14:15:56
1385	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:56	2018-10-02 14:15:56
1386	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:15:56	2018-10-02 14:15:56
1387	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:16:56	2018-10-02 14:16:56
1388	1	admin/images/seo/1/100/58-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:16:58	2018-10-02 14:16:58
1389	1	admin/images/seo/1/100/RB-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:16:58	2018-10-02 14:16:58
1390	1	admin/images/seo/1/100/uK-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:16:58	2018-10-02 14:16:58
1391	1	admin/images/seo/1/100/9F-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:16:58	2018-10-02 14:16:58
1392	1	admin/images/seo/1/100/bR-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:16:58	2018-10-02 14:16:58
1393	1	admin/images/seo/1/100/ct-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:16:59	2018-10-02 14:16:59
1394	1	admin/images/seo/1/100/0v-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:00	2018-10-02 14:17:00
1395	1	admin/images/seo/1/100/Kb-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:00	2018-10-02 14:17:00
1396	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:01	2018-10-02 14:17:01
1397	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:01	2018-10-02 14:17:01
1398	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:02	2018-10-02 14:17:02
1399	1	admin/images/seo/1/100/oM-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:02	2018-10-02 14:17:02
1400	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:02	2018-10-02 14:17:02
1401	1	admin/images/seo/1/100/Gt-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:02	2018-10-02 14:17:02
1402	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:02	2018-10-02 14:17:02
1403	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:03	2018-10-02 14:17:03
1404	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:03	2018-10-02 14:17:03
1405	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:03	2018-10-02 14:17:03
1406	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:04	2018-10-02 14:17:04
1407	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:04	2018-10-02 14:17:04
1408	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:17:27	2018-10-02 14:17:27
1409	1	admin/images/seo/1/100/uK-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:30	2018-10-02 14:17:30
1410	1	admin/images/seo/1/100/ct-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:30	2018-10-02 14:17:30
1411	1	admin/images/seo/1/100/9F-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:30	2018-10-02 14:17:30
1412	1	admin/images/seo/1/100/58-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:30	2018-10-02 14:17:30
1413	1	admin/images/seo/1/100/bR-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:30	2018-10-02 14:17:30
1414	1	admin/images/seo/1/100/RB-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:30	2018-10-02 14:17:30
1415	1	admin/images/seo/1/100/Kb-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:32	2018-10-02 14:17:32
1416	1	admin/images/seo/1/100/0v-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:32	2018-10-02 14:17:32
1417	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:32	2018-10-02 14:17:32
1418	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:32	2018-10-02 14:17:32
1419	1	admin/images/seo/1/100/oM-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:33	2018-10-02 14:17:33
1420	1	admin/images/seo/1/100/Gt-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:33	2018-10-02 14:17:33
1421	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:34	2018-10-02 14:17:34
1422	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:34	2018-10-02 14:17:34
1423	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:35	2018-10-02 14:17:35
1424	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:35	2018-10-02 14:17:35
1425	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:35	2018-10-02 14:17:35
1426	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:36	2018-10-02 14:17:36
1427	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:36	2018-10-02 14:17:36
1428	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:17:36	2018-10-02 14:17:36
1429	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"2"}	2018-10-02 14:17:53	2018-10-02 14:17:53
1430	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:18:26	2018-10-02 14:18:26
1431	1	admin/images/seo/1/100/9F-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:29	2018-10-02 14:18:29
1432	1	admin/images/seo/1/100/bR-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:29	2018-10-02 14:18:29
1433	1	admin/images/seo/1/100/RB-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:29	2018-10-02 14:18:29
1434	1	admin/images/seo/1/100/ct-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:29	2018-10-02 14:18:29
1435	1	admin/images/seo/1/100/0v-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:29	2018-10-02 14:18:29
1436	1	admin/images/seo/1/100/58-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:30	2018-10-02 14:18:30
1437	1	admin/images/seo/1/100/oM-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:31	2018-10-02 14:18:31
1438	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:31	2018-10-02 14:18:31
1439	1	admin/images/seo/1/100/Kb-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:31	2018-10-02 14:18:31
1440	1	admin/images/seo/1/100/Gt-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:32	2018-10-02 14:18:32
1441	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:32	2018-10-02 14:18:32
1442	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:33	2018-10-02 14:18:33
1443	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"3"}	2018-10-02 14:18:33	2018-10-02 14:18:33
1444	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:33	2018-10-02 14:18:33
1445	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:33	2018-10-02 14:18:33
1446	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:34	2018-10-02 14:18:34
1447	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:34	2018-10-02 14:18:34
1448	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:35	2018-10-02 14:18:35
1449	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:35	2018-10-02 14:18:35
1450	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:18:35	2018-10-02 14:18:35
1451	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"3"}	2018-10-02 14:18:49	2018-10-02 14:18:49
1452	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:19:44	2018-10-02 14:19:44
1453	1	admin/images/seo/1/100/0v-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:47	2018-10-02 14:19:47
1454	1	admin/images/seo/1/100/RB-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:47	2018-10-02 14:19:47
1455	1	admin/images/seo/1/100/Kb-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:47	2018-10-02 14:19:47
1456	1	admin/images/seo/1/100/58-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:48	2018-10-02 14:19:48
1457	1	admin/images/seo/1/100/ct-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:48	2018-10-02 14:19:48
1458	1	admin/images/seo/1/100/9F-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:48	2018-10-02 14:19:48
1459	1	admin/images/seo/1/100/oM-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:49	2018-10-02 14:19:49
1460	1	admin/images/seo/1/100/Gt-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:49	2018-10-02 14:19:49
1461	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:50	2018-10-02 14:19:50
1462	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:50	2018-10-02 14:19:50
1463	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:50	2018-10-02 14:19:50
1464	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:51	2018-10-02 14:19:51
1465	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:51	2018-10-02 14:19:51
1466	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:52	2018-10-02 14:19:52
1467	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:52	2018-10-02 14:19:52
1468	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:52	2018-10-02 14:19:52
1469	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:52	2018-10-02 14:19:52
1470	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:19:53	2018-10-02 14:19:53
1471	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"4"}	2018-10-02 14:19:55	2018-10-02 14:19:55
1472	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"5"}	2018-10-02 14:20:07	2018-10-02 14:20:07
1473	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"6"}	2018-10-02 14:20:17	2018-10-02 14:20:17
1474	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"7"}	2018-10-02 14:20:19	2018-10-02 14:20:19
1475	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"8"}	2018-10-02 14:20:21	2018-10-02 14:20:21
1476	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"9"}	2018-10-02 14:20:23	2018-10-02 14:20:23
1477	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"10"}	2018-10-02 14:20:25	2018-10-02 14:20:25
1478	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"11"}	2018-10-02 14:20:27	2018-10-02 14:20:27
1479	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:28:42	2018-10-02 14:28:42
1480	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:28:45	2018-10-02 14:28:45
1481	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:28:46	2018-10-02 14:28:46
1482	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:28:46	2018-10-02 14:28:46
1483	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:28:46	2018-10-02 14:28:46
1484	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:28:46	2018-10-02 14:28:46
1485	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:28:47	2018-10-02 14:28:47
1486	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:28:48	2018-10-02 14:28:48
1487	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:28:48	2018-10-02 14:28:48
1488	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:28:49	2018-10-02 14:28:49
1489	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:28:49	2018-10-02 14:28:49
1490	1	admin/images/setmain	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"14"}	2018-10-02 14:28:54	2018-10-02 14:28:54
1491	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:32:26	2018-10-02 14:32:26
1492	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:32:30	2018-10-02 14:32:30
1493	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:32:31	2018-10-02 14:32:31
1494	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:32:31	2018-10-02 14:32:31
1495	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:32:31	2018-10-02 14:32:31
1496	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:32:31	2018-10-02 14:32:31
1497	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:32:31	2018-10-02 14:32:31
1498	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:32:31	2018-10-02 14:32:31
1499	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:32:32	2018-10-02 14:32:32
1500	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:32:33	2018-10-02 14:32:33
1501	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:32:33	2018-10-02 14:32:33
1502	1	admin/images/setmain	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"12","item_id":"1","module":"seo"}	2018-10-02 14:32:38	2018-10-02 14:32:38
1503	1	admin/images/setmain	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"14","item_id":"1","module":"seo"}	2018-10-02 14:32:53	2018-10-02 14:32:53
1504	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:34:24	2018-10-02 14:34:24
1505	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:34:27	2018-10-02 14:34:27
1506	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:34:27	2018-10-02 14:34:27
1507	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:34:27	2018-10-02 14:34:27
1508	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:34:27	2018-10-02 14:34:27
1509	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:34:27	2018-10-02 14:34:27
1510	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:34:27	2018-10-02 14:34:27
1511	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:34:28	2018-10-02 14:34:28
1512	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:34:28	2018-10-02 14:34:28
1513	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:34:29	2018-10-02 14:34:29
1514	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:34:29	2018-10-02 14:34:29
1515	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:39:37	2018-10-02 14:39:37
1516	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:40:10	2018-10-02 14:40:10
1517	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:40:13	2018-10-02 14:40:13
1518	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:40:13	2018-10-02 14:40:13
1519	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:40:13	2018-10-02 14:40:13
1520	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:40:13	2018-10-02 14:40:13
1521	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:40:14	2018-10-02 14:40:14
1522	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:40:14	2018-10-02 14:40:14
1523	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:40:15	2018-10-02 14:40:15
1524	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:40:15	2018-10-02 14:40:15
1525	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:40:15	2018-10-02 14:40:15
1526	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:40:16	2018-10-02 14:40:16
1527	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:42:11	2018-10-02 14:42:11
1528	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:42:14	2018-10-02 14:42:14
1529	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:42:14	2018-10-02 14:42:14
1530	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:42:14	2018-10-02 14:42:14
1531	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:42:15	2018-10-02 14:42:15
1532	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:42:15	2018-10-02 14:42:15
1533	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:42:15	2018-10-02 14:42:15
1534	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:42:16	2018-10-02 14:42:16
1535	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:42:16	2018-10-02 14:42:16
1536	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:42:17	2018-10-02 14:42:17
1537	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:42:17	2018-10-02 14:42:17
1538	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:45:44	2018-10-02 14:45:44
1539	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:45:48	2018-10-02 14:45:48
1540	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:45:48	2018-10-02 14:45:48
1541	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:45:48	2018-10-02 14:45:48
1542	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:45:49	2018-10-02 14:45:49
1543	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:45:49	2018-10-02 14:45:49
1544	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:45:49	2018-10-02 14:45:49
1545	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:45:50	2018-10-02 14:45:50
1546	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:45:50	2018-10-02 14:45:50
1547	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:45:51	2018-10-02 14:45:51
1548	1	admin/images/seo/1/100/LY-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:45:51	2018-10-02 14:45:51
1549	1	admin/images/setmain	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"15","item_id":"1","module":"seo"}	2018-10-02 14:46:16	2018-10-02 14:46:16
1550	1	admin/images/setmain	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"17","item_id":"1","module":"seo"}	2018-10-02 14:46:18	2018-10-02 14:46:18
1551	1	admin/images/setmain	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"12","item_id":"1","module":"seo"}	2018-10-02 14:46:22	2018-10-02 14:46:22
1552	1	admin/images/setmain	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"20","item_id":"1","module":"seo"}	2018-10-02 14:46:23	2018-10-02 14:46:23
1553	1	admin/images/setmain	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"18","item_id":"1","module":"seo"}	2018-10-02 14:46:27	2018-10-02 14:46:27
1554	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"14"}	2018-10-02 14:48:11	2018-10-02 14:48:11
1555	1	admin/images/upload	POST	192.168.10.1	{"name":"Desert.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 14:48:18	2018-10-02 14:48:18
1556	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:48:19	2018-10-02 14:48:19
1557	1	admin/images/setmain	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"22","item_id":"'+response.result.data.item_id+'","module":"'+response.result.data.module+'"}	2018-10-02 14:48:25	2018-10-02 14:48:25
1558	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:48:58	2018-10-02 14:48:58
1559	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:01	2018-10-02 14:49:01
1560	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:01	2018-10-02 14:49:01
1561	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:01	2018-10-02 14:49:01
1562	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:01	2018-10-02 14:49:01
1563	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:01	2018-10-02 14:49:01
1564	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:02	2018-10-02 14:49:02
1565	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:03	2018-10-02 14:49:03
1566	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:03	2018-10-02 14:49:03
1567	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:03	2018-10-02 14:49:03
1568	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:04	2018-10-02 14:49:04
1569	1	admin/images/upload	POST	192.168.10.1	{"name":"Hydrangeas.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 14:49:13	2018-10-02 14:49:13
1570	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:14	2018-10-02 14:49:14
1571	1	admin/images/setmain	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"23","item_id":"1","module":"seo"}	2018-10-02 14:49:20	2018-10-02 14:49:20
1572	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:49:53	2018-10-02 14:49:53
1573	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:55	2018-10-02 14:49:55
1574	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:55	2018-10-02 14:49:55
1575	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:55	2018-10-02 14:49:55
1576	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:56	2018-10-02 14:49:56
1577	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:56	2018-10-02 14:49:56
1578	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:56	2018-10-02 14:49:56
1579	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:57	2018-10-02 14:49:57
1580	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:57	2018-10-02 14:49:57
1581	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:57	2018-10-02 14:49:57
1582	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:58	2018-10-02 14:49:58
1583	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:49:58	2018-10-02 14:49:58
1584	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:50:19	2018-10-02 14:50:19
1585	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:50:22	2018-10-02 14:50:22
1586	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:50:22	2018-10-02 14:50:22
1587	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:50:22	2018-10-02 14:50:22
1588	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:50:22	2018-10-02 14:50:22
1589	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:50:22	2018-10-02 14:50:22
1590	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:50:22	2018-10-02 14:50:22
1591	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:50:23	2018-10-02 14:50:23
1592	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:50:24	2018-10-02 14:50:24
1593	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:50:24	2018-10-02 14:50:24
1594	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:50:24	2018-10-02 14:50:24
1595	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:50:24	2018-10-02 14:50:24
1596	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:56:33	2018-10-02 14:56:33
1597	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:56:36	2018-10-02 14:56:36
1598	1	admin/images/seo/1/100/a5-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:56:37	2018-10-02 14:56:37
1599	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:56:37	2018-10-02 14:56:37
1600	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 14:56:37	2018-10-02 14:56:37
1601	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:56:37	2018-10-02 14:56:37
1602	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:56:37	2018-10-02 14:56:37
1603	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:56:37	2018-10-02 14:56:37
1604	1	admin/images/seo/1/100/Yg-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 14:56:39	2018-10-02 14:56:39
1605	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 14:56:39	2018-10-02 14:56:39
1606	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 14:56:39	2018-10-02 14:56:39
1607	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 14:56:40	2018-10-02 14:56:40
1608	1	admin/images/setmain	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"12","item_id":"1","module":"seo"}	2018-10-02 14:56:42	2018-10-02 14:56:42
1609	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"12"}	2018-10-02 14:56:43	2018-10-02 14:56:43
1610	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"20"}	2018-10-02 14:56:54	2018-10-02 14:56:54
1611	1	admin/images/setmain	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"18","item_id":"1","module":"seo"}	2018-10-02 14:56:58	2018-10-02 14:56:58
1612	1	admin/images/upload	POST	192.168.10.1	{"name":"Chrysanthemum.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 14:57:05	2018-10-02 14:57:05
1613	1	admin/images/seo/1/100/Yg-Chrysanthemum.jpg	GET	192.168.10.1	[]	2018-10-02 14:57:06	2018-10-02 14:57:06
1614	1	admin/images/delete	POST	192.168.10.1	{"_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O","id":"24"}	2018-10-02 14:57:14	2018-10-02 14:57:14
1615	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 14:57:19	2018-10-02 14:57:19
1616	1	admin/images/upload	POST	192.168.10.1	{"name":"generated_8825.pdf","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 15:04:34	2018-10-02 15:04:34
1617	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 15:06:33	2018-10-02 15:06:33
1618	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 15:06:37	2018-10-02 15:06:37
1619	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 15:06:38	2018-10-02 15:06:38
1620	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:06:38	2018-10-02 15:06:38
1621	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 15:06:38	2018-10-02 15:06:38
1622	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:06:38	2018-10-02 15:06:38
1623	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 15:06:38	2018-10-02 15:06:38
1624	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 15:06:39	2018-10-02 15:06:39
1625	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 15:06:39	2018-10-02 15:06:39
1626	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:06:40	2018-10-02 15:06:40
1627	1	admin/images/upload	POST	192.168.10.1	{"name":"generated_10418.pdf","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 15:06:44	2018-10-02 15:06:44
1628	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 15:07:34	2018-10-02 15:07:34
1629	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:07:36	2018-10-02 15:07:36
1630	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 15:07:36	2018-10-02 15:07:36
1631	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 15:07:36	2018-10-02 15:07:36
1632	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 15:07:37	2018-10-02 15:07:37
1633	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:07:38	2018-10-02 15:07:38
1634	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 15:07:38	2018-10-02 15:07:38
1635	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 15:07:38	2018-10-02 15:07:38
1636	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 15:07:38	2018-10-02 15:07:38
1637	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:07:39	2018-10-02 15:07:39
1638	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 15:08:09	2018-10-02 15:08:09
1639	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 15:08:11	2018-10-02 15:08:11
1640	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 15:08:11	2018-10-02 15:08:11
1641	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:08:11	2018-10-02 15:08:11
1642	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 15:08:11	2018-10-02 15:08:11
1643	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 15:08:12	2018-10-02 15:08:12
1644	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:08:13	2018-10-02 15:08:13
1645	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 15:08:13	2018-10-02 15:08:13
1646	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 15:08:13	2018-10-02 15:08:13
1647	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:08:13	2018-10-02 15:08:13
1648	1	admin/images/upload	POST	192.168.10.1	{"name":"generated_8882.pdf","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 15:08:18	2018-10-02 15:08:18
1649	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 15:13:09	2018-10-02 15:13:09
1650	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 15:13:13	2018-10-02 15:13:13
1651	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 15:13:14	2018-10-02 15:13:14
1652	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 15:13:14	2018-10-02 15:13:14
1653	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 15:13:14	2018-10-02 15:13:14
1654	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:13:14	2018-10-02 15:13:14
1655	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:13:14	2018-10-02 15:13:14
1656	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 15:13:15	2018-10-02 15:13:15
1657	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 15:13:15	2018-10-02 15:13:15
1658	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:13:16	2018-10-02 15:13:16
1659	1	admin/images/upload	POST	192.168.10.1	{"name":"generated_10418.pdf","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 15:13:20	2018-10-02 15:13:20
1660	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 15:14:12	2018-10-02 15:14:12
1661	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:14	2018-10-02 15:14:14
1662	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:14	2018-10-02 15:14:14
1663	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:14	2018-10-02 15:14:14
1664	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:14	2018-10-02 15:14:14
1665	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:14	2018-10-02 15:14:14
1666	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:15	2018-10-02 15:14:15
1667	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:15	2018-10-02 15:14:15
1668	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:15	2018-10-02 15:14:15
1669	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:16	2018-10-02 15:14:16
1670	1	admin/images/upload	POST	192.168.10.1	{"name":"generated_10418.pdf","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 15:14:18	2018-10-02 15:14:18
1671	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-02 15:14:46	2018-10-02 15:14:46
1672	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:48	2018-10-02 15:14:48
1673	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:48	2018-10-02 15:14:48
1674	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:48	2018-10-02 15:14:48
1675	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:48	2018-10-02 15:14:48
1676	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:49	2018-10-02 15:14:49
1677	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:49	2018-10-02 15:14:49
1678	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:50	2018-10-02 15:14:50
1679	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:50	2018-10-02 15:14:50
1680	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-02 15:14:50	2018-10-02 15:14:50
1681	1	admin/images/upload	POST	192.168.10.1	{"name":"generated_8825.pdf","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"4X7SeVTaFaa0d0nDRNvN9rlJ88rr5GixBAZ2ZV9O"}	2018-10-02 15:14:58	2018-10-02 15:14:58
1682	1	admin	GET	192.168.10.1	[]	2018-10-03 07:08:03	2018-10-03 07:08:03
1683	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-03 07:08:10	2018-10-03 07:08:10
1684	1	admin/seo/1/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-03 07:17:33	2018-10-03 07:17:33
1685	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:37	2018-10-03 07:17:37
1686	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:37	2018-10-03 07:17:37
1687	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:37	2018-10-03 07:17:37
1688	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:38	2018-10-03 07:17:38
1689	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:38	2018-10-03 07:17:38
1690	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:40	2018-10-03 07:17:40
1691	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:40	2018-10-03 07:17:40
1692	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:40	2018-10-03 07:17:40
1693	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:40	2018-10-03 07:17:40
1694	1	admin/images/upload	POST	192.168.10.1	{"name":"generated_8882.pdf","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 07:17:45	2018-10-03 07:17:45
1695	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 07:17:53	2018-10-03 07:17:53
1696	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:56	2018-10-03 07:17:56
1697	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:56	2018-10-03 07:17:56
1698	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:56	2018-10-03 07:17:56
1699	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:56	2018-10-03 07:17:56
1700	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:56	2018-10-03 07:17:56
1701	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:57	2018-10-03 07:17:57
1702	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:57	2018-10-03 07:17:57
1703	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:57	2018-10-03 07:17:57
1704	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:17:58	2018-10-03 07:17:58
1705	1	admin/images/upload	POST	192.168.10.1	{"name":"generated_8882.pdf","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 07:18:01	2018-10-03 07:18:01
1706	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 07:30:45	2018-10-03 07:30:45
1707	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 07:31:19	2018-10-03 07:31:19
1708	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 07:36:10	2018-10-03 07:36:10
1709	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 07:36:42	2018-10-03 07:36:42
1710	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:36:45	2018-10-03 07:36:45
1711	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:36:45	2018-10-03 07:36:45
1712	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:36:46	2018-10-03 07:36:46
1713	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:36:46	2018-10-03 07:36:46
1714	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:36:47	2018-10-03 07:36:47
1715	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:36:47	2018-10-03 07:36:47
1716	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-03 07:36:47	2018-10-03 07:36:47
1717	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-03 07:36:47	2018-10-03 07:36:47
1718	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:36:48	2018-10-03 07:36:48
1719	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 07:38:11	2018-10-03 07:38:11
1720	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:38:13	2018-10-03 07:38:13
1721	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:38:13	2018-10-03 07:38:13
1722	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:38:13	2018-10-03 07:38:13
1723	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:38:14	2018-10-03 07:38:14
1724	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:38:14	2018-10-03 07:38:14
1725	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:38:14	2018-10-03 07:38:14
1726	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-03 07:38:15	2018-10-03 07:38:15
1727	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:38:15	2018-10-03 07:38:15
1728	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-03 07:38:15	2018-10-03 07:38:15
1729	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 07:44:11	2018-10-03 07:44:11
1730	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:44:14	2018-10-03 07:44:14
1731	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:44:15	2018-10-03 07:44:15
1732	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:44:15	2018-10-03 07:44:15
1733	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:44:15	2018-10-03 07:44:15
1734	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:44:15	2018-10-03 07:44:15
1735	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:44:15	2018-10-03 07:44:15
1736	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-03 07:44:16	2018-10-03 07:44:16
1737	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-03 07:44:16	2018-10-03 07:44:16
1738	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:44:17	2018-10-03 07:44:17
1739	1	admin/images/upload	POST	192.168.10.1	{"name":"Image from million-wallpapers.ru 1920x1200.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 07:49:29	2018-10-03 07:49:29
1740	1	admin/images/seo/1/100/Mt-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-03 07:49:31	2018-10-03 07:49:31
1741	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 07:52:33	2018-10-03 07:52:33
1742	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 07:53:50	2018-10-03 07:53:50
1743	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:53:53	2018-10-03 07:53:53
1744	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:53:53	2018-10-03 07:53:53
1745	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:53:53	2018-10-03 07:53:53
1746	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:53:53	2018-10-03 07:53:53
1747	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:53:54	2018-10-03 07:53:54
1748	1	admin/images/seo/1/100/Mt-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-03 07:53:54	2018-10-03 07:53:54
1749	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:53:55	2018-10-03 07:53:55
1750	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-03 07:53:55	2018-10-03 07:53:55
1751	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-03 07:53:56	2018-10-03 07:53:56
1752	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:53:56	2018-10-03 07:53:56
1753	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 07:54:10	2018-10-03 07:54:10
1754	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:54:13	2018-10-03 07:54:13
1755	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:54:13	2018-10-03 07:54:13
1756	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:54:13	2018-10-03 07:54:13
1757	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:54:13	2018-10-03 07:54:13
1758	1	admin/images/seo/1/100/Mt-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-03 07:54:13	2018-10-03 07:54:13
1759	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 07:54:13	2018-10-03 07:54:13
1760	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 07:54:14	2018-10-03 07:54:14
1761	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-03 07:54:14	2018-10-03 07:54:14
1762	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 07:54:15	2018-10-03 07:54:15
1763	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-03 07:54:15	2018-10-03 07:54:15
1764	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 08:42:26	2018-10-03 08:42:26
1765	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 08:42:29	2018-10-03 08:42:29
1766	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 08:42:30	2018-10-03 08:42:30
1767	1	admin/images/seo/1/100/Mt-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-03 08:42:30	2018-10-03 08:42:30
1768	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 08:42:30	2018-10-03 08:42:30
1769	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 08:42:30	2018-10-03 08:42:30
1770	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 08:42:31	2018-10-03 08:42:31
1771	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 08:42:31	2018-10-03 08:42:31
1772	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-03 08:42:32	2018-10-03 08:42:32
1773	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 08:42:33	2018-10-03 08:42:33
1774	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 08:42:33	2018-10-03 08:42:33
1775	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-03 08:42:33	2018-10-03 08:42:33
1776	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 09:23:11	2018-10-03 09:23:11
1777	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 09:23:14	2018-10-03 09:23:14
1778	1	admin/images/seo/1/100/Mt-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-03 09:23:15	2018-10-03 09:23:15
1779	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 09:23:15	2018-10-03 09:23:15
1780	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 09:23:15	2018-10-03 09:23:15
1781	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 09:23:16	2018-10-03 09:23:16
1782	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 09:23:16	2018-10-03 09:23:16
1783	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-03 09:23:17	2018-10-03 09:23:17
1784	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 09:23:17	2018-10-03 09:23:17
1785	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-03 09:23:18	2018-10-03 09:23:18
1786	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 09:23:18	2018-10-03 09:23:18
1787	1	admin/images/upload	POST	192.168.10.1	{"name":"FireShot Capture 018 - \\u0414\\u043e\\u0431\\u0430\\u0432\\u0438\\u0442\\u044c \\u0443\\u0441\\u0442\\u0440\\u043e\\u0439\\u0441\\u0442\\u0432\\u043e_ - http___smart-system.aide.dev_md_se.png","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:23:40	2018-10-03 09:23:40
1788	1	admin/images/upload	POST	192.168.10.1	{"name":"14616kstwExQLKlbCfnRdr.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:25:38	2018-10-03 09:25:38
1789	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 09:35:10	2018-10-03 09:35:10
1790	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 09:35:13	2018-10-03 09:35:13
1791	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 09:35:15	2018-10-03 09:35:15
1792	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 09:35:15	2018-10-03 09:35:15
1896	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 12:16:03	2018-10-03 12:16:03
1793	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 09:35:15	2018-10-03 09:35:15
1794	1	admin/images/seo/1/100/Mt-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-03 09:35:15	2018-10-03 09:35:15
1795	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 09:35:15	2018-10-03 09:35:15
1796	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 09:35:17	2018-10-03 09:35:17
1797	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-03 09:35:17	2018-10-03 09:35:17
1798	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 09:35:17	2018-10-03 09:35:17
1799	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-03 09:35:18	2018-10-03 09:35:18
1800	1	admin/images/upload	POST	192.168.10.1	{"name":"FireShot Capture 018 - \\u0414\\u043e\\u0431\\u0430\\u0432\\u0438\\u0442\\u044c \\u0443\\u0441\\u0442\\u0440\\u043e\\u0439\\u0441\\u0442\\u0432\\u043e_ - http___smart-system.aide.dev_md_se.png","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:35:20	2018-10-03 09:35:20
1801	1	admin/images/seo/1/100/cs-FireShot%20Capture%20018%20-%20%D0%94%D0%BE%D0%B1%D0%B0%D0%B2%D0%B8%D1%82%D1%8C%20%D1%83%D1%81%D1%82%D1%80%D0%BE%D0%B9%D1%81%D1%82%D0%B2%D0%BE_%20-%20http___smart-system.aide.dev_md_se.png	GET	192.168.10.1	[]	2018-10-03 09:35:21	2018-10-03 09:35:21
1802	1	admin/images/delete	POST	192.168.10.1	{"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","id":"26"}	2018-10-03 09:36:55	2018-10-03 09:36:55
1803	1	admin/images/setmain	POST	192.168.10.1	{"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","id":"15","item_id":"1","module":"seo"}	2018-10-03 09:39:56	2018-10-03 09:39:56
1804	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 09:40:00	2018-10-03 09:40:00
1805	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:03	2018-10-03 09:40:03
1806	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:03	2018-10-03 09:40:03
1807	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:04	2018-10-03 09:40:04
1808	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:04	2018-10-03 09:40:04
1809	1	admin/images/seo/1/100/Mt-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:05	2018-10-03 09:40:05
1810	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:05	2018-10-03 09:40:05
1811	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:05	2018-10-03 09:40:05
1812	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:06	2018-10-03 09:40:06
1813	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:06	2018-10-03 09:40:06
1814	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:06	2018-10-03 09:40:06
1815	1	admin/images/setmain	POST	192.168.10.1	{"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","id":"17","item_id":"1","module":"seo"}	2018-10-03 09:40:09	2018-10-03 09:40:09
1816	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 09:40:11	2018-10-03 09:40:11
1817	1	admin/images/seo/1/100/ld-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:13	2018-10-03 09:40:13
1818	1	admin/images/seo/1/100/OE-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:13	2018-10-03 09:40:13
1819	1	admin/images/seo/1/100/Sg-Jellyfish.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:13	2018-10-03 09:40:13
1820	1	admin/images/seo/1/100/qp-Desert.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:13	2018-10-03 09:40:13
1821	1	admin/images/seo/1/100/Mt-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:13	2018-10-03 09:40:13
1822	1	admin/images/seo/1/100/Xx-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:13	2018-10-03 09:40:13
1823	1	admin/images/seo/1/100/s3-Hydrangeas.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:15	2018-10-03 09:40:15
1824	1	admin/images/seo/1/100/Fw-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:15	2018-10-03 09:40:15
1825	1	admin/images/seo/1/100/Pu-Lighthouse.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:15	2018-10-03 09:40:15
1826	1	admin/images/seo/1/100/7j-Koala.jpg	GET	192.168.10.1	[]	2018-10-03 09:40:15	2018-10-03 09:40:15
1827	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 09:43:47	2018-10-03 09:43:47
1828	1	admin/images/upload	POST	192.168.10.1	{"name":"Image from million-wallpapers.ru 1920x1200.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:43:57	2018-10-03 09:43:57
1829	1	admin/images/seo/1/100/nQ-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-03 09:43:58	2018-10-03 09:43:58
1830	1	admin/images/upload	POST	192.168.10.1	{"name":"rozy_butony_rozovyj_123260_1600x1200.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:44:09	2018-10-03 09:44:09
1831	1	admin/images/seo/1/100/Hp-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-03 09:44:11	2018-10-03 09:44:11
1832	1	admin/images/upload	POST	192.168.10.1	{"name":"FireShot Capture 018 - \\u0414\\u043e\\u0431\\u0430\\u0432\\u0438\\u0442\\u044c \\u0443\\u0441\\u0442\\u0440\\u043e\\u0439\\u0441\\u0442\\u0432\\u043e_ - http___smart-system.aide.dev_md_se.png","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:44:16	2018-10-03 09:44:16
1833	1	admin/images/seo/1/100/q7-FireShot%20Capture%20018%20-%20%D0%94%D0%BE%D0%B1%D0%B0%D0%B2%D0%B8%D1%82%D1%8C%20%D1%83%D1%81%D1%82%D1%80%D0%BE%D0%B9%D1%81%D1%82%D0%B2%D0%BE_%20-%20http___smart-system.aide.dev_md_se.png	GET	192.168.10.1	[]	2018-10-03 09:44:17	2018-10-03 09:44:17
1834	1	admin/images/upload	POST	192.168.10.1	{"name":"SPCQJAdT2pg.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:44:17	2018-10-03 09:44:17
1835	1	admin/images/seo/1/100/tH-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-10-03 09:44:18	2018-10-03 09:44:18
1836	1	admin/images/delete	POST	192.168.10.1	{"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","id":"30"}	2018-10-03 09:44:24	2018-10-03 09:44:24
1837	1	admin/images/delete	POST	192.168.10.1	{"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","id":"29"}	2018-10-03 09:44:33	2018-10-03 09:44:33
1838	1	admin/images/delete-all	POST	192.168.10.1	{"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","item_id":"1","module":"seo"}	2018-10-03 09:44:49	2018-10-03 09:44:49
1839	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 09:46:27	2018-10-03 09:46:27
1840	1	admin/images/upload	POST	192.168.10.1	{"name":"14616kstwExQLKlbCfnRdr.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:46:54	2018-10-03 09:46:54
1841	1	admin/images/seo/1/100/Ba-14616kstwExQLKlbCfnRdr.jpg	GET	192.168.10.1	[]	2018-10-03 09:46:56	2018-10-03 09:46:56
1842	1	admin/images/upload	POST	192.168.10.1	{"name":"Firefox_Screenshot_2018-08-22T10-11-13.322Z.png","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:46:56	2018-10-03 09:46:56
1843	1	admin/images/upload	POST	192.168.10.1	{"name":"FireShot Capture 018 - \\u0414\\u043e\\u0431\\u0430\\u0432\\u0438\\u0442\\u044c \\u0443\\u0441\\u0442\\u0440\\u043e\\u0439\\u0441\\u0442\\u0432\\u043e_ - http___smart-system.aide.dev_md_se.png","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:46:58	2018-10-03 09:46:58
1844	1	admin/images/seo/1/100/Ml-Firefox_Screenshot_2018-08-22T10-11-13.322Z.png	GET	192.168.10.1	[]	2018-10-03 09:46:58	2018-10-03 09:46:58
1845	1	admin/images/seo/1/100/bg-FireShot%20Capture%20018%20-%20%D0%94%D0%BE%D0%B1%D0%B0%D0%B2%D0%B8%D1%82%D1%8C%20%D1%83%D1%81%D1%82%D1%80%D0%BE%D0%B9%D1%81%D1%82%D0%B2%D0%BE_%20-%20http___smart-system.aide.dev_md_se.png	GET	192.168.10.1	[]	2018-10-03 09:46:59	2018-10-03 09:46:59
1846	1	admin/images/upload	POST	192.168.10.1	{"name":"Image from million-wallpapers.ru 1920x1200.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:46:59	2018-10-03 09:46:59
1847	1	admin/images/seo/1/100/IH-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-03 09:47:00	2018-10-03 09:47:00
1848	1	admin/images/upload	POST	192.168.10.1	{"name":"rozy_butony_rozovyj_123260_1600x1200.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:47:00	2018-10-03 09:47:00
1849	1	admin/images/seo/1/100/xx-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-03 09:47:01	2018-10-03 09:47:01
1850	1	admin/images/upload	POST	192.168.10.1	{"name":"SPCQJAdT2pg.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 09:47:02	2018-10-03 09:47:02
1851	1	admin/images/seo/1/100/uC-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-10-03 09:47:03	2018-10-03 09:47:03
1852	1	admin/images/delete-all	POST	192.168.10.1	{"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","item_id":"1","module":"seo"}	2018-10-03 09:48:39	2018-10-03 09:48:39
1853	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 10:03:42	2018-10-03 10:03:42
1854	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 10:05:40	2018-10-03 10:05:40
1855	1	admin/images/upload	POST	192.168.10.1	{"name":"14616kstwExQLKlbCfnRdr.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 10:05:49	2018-10-03 10:05:49
1856	1	admin/images/seo/1/100/3n-14616kstwExQLKlbCfnRdr.jpg	GET	192.168.10.1	[]	2018-10-03 10:05:51	2018-10-03 10:05:51
1857	1	admin/images/upload	POST	192.168.10.1	{"name":"Firefox_Screenshot_2018-08-22T10-11-13.322Z.png","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 10:05:51	2018-10-03 10:05:51
1858	1	admin/images/seo/1/100/zr-Firefox_Screenshot_2018-08-22T10-11-13.322Z.png	GET	192.168.10.1	[]	2018-10-03 10:05:52	2018-10-03 10:05:52
1859	1	admin/images/upload	POST	192.168.10.1	{"name":"FireShot Capture 018 - \\u0414\\u043e\\u0431\\u0430\\u0432\\u0438\\u0442\\u044c \\u0443\\u0441\\u0442\\u0440\\u043e\\u0439\\u0441\\u0442\\u0432\\u043e_ - http___smart-system.aide.dev_md_se.png","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 10:05:52	2018-10-03 10:05:52
1860	1	admin/images/seo/1/100/Yh-FireShot%20Capture%20018%20-%20%D0%94%D0%BE%D0%B1%D0%B0%D0%B2%D0%B8%D1%82%D1%8C%20%D1%83%D1%81%D1%82%D1%80%D0%BE%D0%B9%D1%81%D1%82%D0%B2%D0%BE_%20-%20http___smart-system.aide.dev_md_se.png	GET	192.168.10.1	[]	2018-10-03 10:05:54	2018-10-03 10:05:54
1861	1	admin/images/upload	POST	192.168.10.1	{"name":"Image from million-wallpapers.ru 1920x1200.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 10:05:54	2018-10-03 10:05:54
1862	1	admin/images/seo/1/100/mD-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-03 10:05:55	2018-10-03 10:05:55
1863	1	admin/images/upload	POST	192.168.10.1	{"name":"rozy_butony_rozovyj_123260_1600x1200.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 10:05:56	2018-10-03 10:05:56
1864	1	admin/images/seo/1/100/6h-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-03 10:05:57	2018-10-03 10:05:57
1865	1	admin/images/upload	POST	192.168.10.1	{"name":"SPCQJAdT2pg.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"1","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 10:05:57	2018-10-03 10:05:57
1866	1	admin/images/seo/1/100/Dd-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-10-03 10:05:58	2018-10-03 10:05:58
1867	1	admin/images/setmain	POST	192.168.10.1	{"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","id":"39","item_id":"1","module":"seo"}	2018-10-03 10:06:03	2018-10-03 10:06:03
1868	1	admin/images/setmain	POST	192.168.10.1	{"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","id":"37","item_id":"1","module":"seo"}	2018-10-03 10:06:09	2018-10-03 10:06:09
1869	1	admin/images/delete	POST	192.168.10.1	{"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","id":"37"}	2018-10-03 10:06:14	2018-10-03 10:06:14
1870	1	admin/images/delete	POST	192.168.10.1	{"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","id":"39"}	2018-10-03 10:06:19	2018-10-03 10:06:19
1871	1	admin/images/delete-all	POST	192.168.10.1	{"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","item_id":"1","module":"seo"}	2018-10-03 10:06:28	2018-10-03 10:06:28
1872	1	admin/seo/1/edit	GET	192.168.10.1	[]	2018-10-03 10:08:11	2018-10-03 10:08:11
1873	1	admin/langs_cats	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-03 10:08:19	2018-10-03 10:08:19
1874	1	admin/langs_labels	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-03 10:08:23	2018-10-03 10:08:23
1875	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-03 10:09:52	2018-10-03 10:09:52
1876	1	admin/seo	GET	192.168.10.1	[]	2018-10-03 10:20:11	2018-10-03 10:20:11
1877	1	admin/phpinfo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-03 10:20:17	2018-10-03 10:20:17
1878	1	admin	GET	192.168.10.1	[]	2018-10-03 11:35:52	2018-10-03 11:35:52
1879	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-03 11:35:59	2018-10-03 11:35:59
1880	1	admin/seo/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-03 11:36:05	2018-10-03 11:36:05
1881	1	admin/seo	POST	192.168.10.1	{"log_name":"dddd","alias":"sdsd","lock_alias":"on","link":"sds","state":"on","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/seo"}	2018-10-03 11:36:15	2018-10-03 11:36:15
1882	1	admin/seo/create	GET	192.168.10.1	[]	2018-10-03 11:36:17	2018-10-03 11:36:17
1883	1	admin/seo/create	GET	192.168.10.1	[]	2018-10-03 11:43:29	2018-10-03 11:43:29
1884	1	admin/seo	POST	192.168.10.1	{"log_name":"sds","alias":"sds","lock_alias":"on","link":"sdsd","state":"on","_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz"}	2018-10-03 11:43:41	2018-10-03 11:43:41
1885	1	admin/seo	GET	192.168.10.1	[]	2018-10-03 11:43:42	2018-10-03 11:43:42
1886	1	admin/seo/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-03 11:47:04	2018-10-03 11:47:04
1887	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 12:07:34	2018-10-03 12:07:34
1888	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 12:08:21	2018-10-03 12:08:21
1889	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 12:09:08	2018-10-03 12:09:08
1890	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 12:10:02	2018-10-03 12:10:02
1891	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 12:10:26	2018-10-03 12:10:26
1892	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 12:13:17	2018-10-03 12:13:17
1893	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 12:14:14	2018-10-03 12:14:14
1894	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 12:14:55	2018-10-03 12:14:55
1895	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 12:15:45	2018-10-03 12:15:45
1897	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 12:44:28	2018-10-03 12:44:28
1898	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 12:50:07	2018-10-03 12:50:07
1899	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 13:04:59	2018-10-03 13:04:59
1900	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 13:06:06	2018-10-03 13:06:06
1901	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1","alias":"sds1","lock_alias":"on","link":"sdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"introtext":"intro ru","text":"<p>text ru<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435 en<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","_method":"PUT"}	2018-10-03 13:33:51	2018-10-03 13:33:51
1902	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 13:33:55	2018-10-03 13:33:55
1903	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1","alias":"sds1","lock_alias":"on","link":"sdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"introtext":"ru shoert","text":"<p>text ru<\\/p>","seo_h1":"h1 ru","seo_title":"neta ru","seo_keywords":"kkey ru","seo_description":"descr ru"},"en":{"introtext":"o en","text":"<p>op en b<\\/p>","seo_h1":"h1 b","seo_title":"meta b","seo_keywords":"key b","seo_description":"descr b"}},"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","_method":"PUT"}	2018-10-03 13:42:49	2018-10-03 13:42:49
1904	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 13:44:26	2018-10-03 13:44:26
1905	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1hhh","alias":"sds1","lock_alias":"on","link":"sdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"introtext":"intro ru","text":"<p>text ru<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435 en<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","_method":"PUT"}	2018-10-03 13:44:44	2018-10-03 13:44:44
1906	1	admin/seo/2	GET	192.168.10.1	[]	2018-10-03 13:49:12	2018-10-03 13:49:12
1907	1	admin/seo/2	GET	192.168.10.1	[]	2018-10-03 13:50:02	2018-10-03 13:50:02
1908	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 13:50:13	2018-10-03 13:50:13
1909	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1hhh","alias":"sds1","lock_alias":"on","link":"sdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"introtext":"intro ru","text":"<p>text ru<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435 en<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/seo\\/2"}	2018-10-03 13:50:39	2018-10-03 13:50:39
1910	1	admin/seo/2	GET	192.168.10.1	[]	2018-10-03 13:50:40	2018-10-03 13:50:40
1911	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 13:50:41	2018-10-03 13:50:41
1912	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1hhh","alias":"sds1","lock_alias":"on","link":"sdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"introtext":null,"text":"<p>text ru<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435 en<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","_method":"PUT"}	2018-10-03 13:52:49	2018-10-03 13:52:49
1913	1	admin/seo	GET	192.168.10.1	[]	2018-10-03 13:52:52	2018-10-03 13:52:52
1914	1	admin/seo/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-03 13:53:00	2018-10-03 13:53:00
1915	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1hhh","alias":"sds1","lock_alias":"on","link":"sdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fghf","text":"<p>text ru<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"locale":"en","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435 en<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/seo"}	2018-10-03 13:53:10	2018-10-03 13:53:10
1916	1	admin/seo	GET	192.168.10.1	[]	2018-10-03 13:53:12	2018-10-03 13:53:12
1917	1	admin/seo/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-03 13:53:16	2018-10-03 13:53:16
1918	1	admin/seo/create	GET	192.168.10.1	[]	2018-10-03 13:54:07	2018-10-03 13:54:07
1919	1	admin/seo	POST	192.168.10.1	{"log_name":"sds1hhh","alias":"sds1","lock_alias":"on","link":"asdsd","state":"on","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"m54Q3IeQu5kuC6a4XRU4QuHKHWlNB4h365S9n6Qz","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/seo\\/2\\/edit"}	2018-10-03 13:54:38	2018-10-03 13:54:38
1920	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-03 13:54:39	2018-10-03 13:54:39
1921	1	admin	GET	192.168.10.1	[]	2018-10-05 10:12:53	2018-10-05 10:12:53
1922	1	admin/auth/users	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-05 10:13:02	2018-10-05 10:13:02
1923	1	admin/auth/users/1/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-05 10:13:05	2018-10-05 10:13:05
1924	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-05 10:13:50	2018-10-05 10:13:50
1925	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-05 10:13:55	2018-10-05 10:13:55
1926	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 10:42:53	2018-10-05 10:42:53
1927	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 10:43:57	2018-10-05 10:43:57
1928	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 10:58:31	2018-10-05 10:58:31
1929	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 10:59:45	2018-10-05 10:59:45
1930	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:09:57	2018-10-05 11:09:57
1931	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:10:11	2018-10-05 11:10:11
1932	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:25:46	2018-10-05 11:25:46
1933	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:26:50	2018-10-05 11:26:50
1934	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:27:17	2018-10-05 11:27:17
1935	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:28:46	2018-10-05 11:28:46
1936	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:32:31	2018-10-05 11:32:31
1937	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:33:26	2018-10-05 11:33:26
1938	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:34:51	2018-10-05 11:34:51
1939	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:35:39	2018-10-05 11:35:39
1940	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:37:17	2018-10-05 11:37:17
1941	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:38:24	2018-10-05 11:38:24
1942	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:42:50	2018-10-05 11:42:50
1943	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:43:38	2018-10-05 11:43:38
1944	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:44:17	2018-10-05 11:44:17
1945	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:46:03	2018-10-05 11:46:03
1946	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:47:19	2018-10-05 11:47:19
1947	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:48:59	2018-10-05 11:48:59
1948	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:50:44	2018-10-05 11:50:44
1949	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:50:59	2018-10-05 11:50:59
1950	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:51:54	2018-10-05 11:51:54
1951	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:52:05	2018-10-05 11:52:05
1952	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:52:44	2018-10-05 11:52:44
1953	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:54:21	2018-10-05 11:54:21
1954	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:54:47	2018-10-05 11:54:47
1955	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:54:56	2018-10-05 11:54:56
1956	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:58:34	2018-10-05 11:58:34
1957	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 11:58:42	2018-10-05 11:58:42
1958	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheee","lock_alias":"0","alias":"sds1hhheee","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 11:59:17	2018-10-05 11:59:17
1959	1	admin/seo	GET	192.168.10.1	[]	2018-10-05 11:59:18	2018-10-05 11:59:18
1960	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-05 11:59:24	2018-10-05 11:59:24
1961	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:05:29	2018-10-05 12:05:29
1962	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:27:55	2018-10-05 12:27:55
1963	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:34:22	2018-10-05 12:34:22
1964	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:34:49	2018-10-05 12:34:49
1965	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:35:12	2018-10-05 12:35:12
1966	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheee","lock_alias":"1","alias":"sds1hhheee","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:35:27	2018-10-05 12:35:27
1967	1	admin/seo/3	GET	192.168.10.1	[]	2018-10-05 12:35:29	2018-10-05 12:35:29
1968	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:35:44	2018-10-05 12:35:44
1969	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:35:48	2018-10-05 12:35:48
1970	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:35:57	2018-10-05 12:35:57
1971	1	admin/seo	GET	192.168.10.1	[]	2018-10-05 12:35:58	2018-10-05 12:35:58
1972	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-05 12:36:02	2018-10-05 12:36:02
1973	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:36:12	2018-10-05 12:36:12
1974	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"0","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:36:21	2018-10-05 12:36:21
1975	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:36:22	2018-10-05 12:36:22
1976	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:37:46	2018-10-05 12:37:46
1977	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:37:47	2018-10-05 12:37:47
1978	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:37:56	2018-10-05 12:37:56
1979	1	admin/seo/3	GET	192.168.10.1	[]	2018-10-05 12:37:57	2018-10-05 12:37:57
1980	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:38:07	2018-10-05 12:38:07
2079	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:21:19	2018-10-05 14:21:19
2083	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:25:56	2018-10-05 14:25:56
2086	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:33:07	2018-10-05 14:33:07
2090	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:35:52	2018-10-05 14:35:52
1981	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"0","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/seo\\/3"}	2018-10-05 12:38:15	2018-10-05 12:38:15
1982	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:38:16	2018-10-05 12:38:16
1983	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:38:21	2018-10-05 12:38:21
1984	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:39:17	2018-10-05 12:39:17
1985	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:39:25	2018-10-05 12:39:25
1986	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:39:26	2018-10-05 12:39:26
1987	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:39:50	2018-10-05 12:39:50
1988	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:41:52	2018-10-05 12:41:52
1989	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:41:58	2018-10-05 12:41:58
1990	1	admin/seo/3	GET	192.168.10.1	[]	2018-10-05 12:42:00	2018-10-05 12:42:00
1991	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:42:05	2018-10-05 12:42:05
1992	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:42:10	2018-10-05 12:42:10
1993	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:42:15	2018-10-05 12:42:15
1994	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:42:16	2018-10-05 12:42:16
1995	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:42:35	2018-10-05 12:42:35
1996	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:42:36	2018-10-05 12:42:36
1997	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:43:57	2018-10-05 12:43:57
1998	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:44:04	2018-10-05 12:44:04
1999	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:44:06	2018-10-05 12:44:06
2000	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:45:23	2018-10-05 12:45:23
2001	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:45:25	2018-10-05 12:45:25
2002	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:46:14	2018-10-05 12:46:14
2003	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","id":"3","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:46:36	2018-10-05 12:46:36
2004	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:46:37	2018-10-05 12:46:37
2005	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:47:09	2018-10-05 12:47:09
2006	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","id":"3","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:47:14	2018-10-05 12:47:14
2007	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:47:15	2018-10-05 12:47:15
2008	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:50:16	2018-10-05 12:50:16
2080	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:21:19	2018-10-05 14:21:19
2084	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:33:03	2018-10-05 14:33:03
2087	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:35:25	2018-10-05 14:35:25
2009	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","id":"3","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:50:23	2018-10-05 12:50:23
2010	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:50:24	2018-10-05 12:50:24
2011	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","id":"3","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:51:09	2018-10-05 12:51:09
2012	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:51:10	2018-10-05 12:51:10
2013	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:51:25	2018-10-05 12:51:25
2014	1	admin/seo	GET	192.168.10.1	[]	2018-10-05 12:51:26	2018-10-05 12:51:26
2015	1	admin/seo/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-05 12:51:30	2018-10-05 12:51:30
2016	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-05 12:52:01	2018-10-05 12:52:01
2017	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"0","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fghf","text":"<p>dfg<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"locale":"en","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>222222222222<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/seo\\/3\\/edit"}	2018-10-05 12:52:55	2018-10-05 12:52:55
2018	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-05 12:52:56	2018-10-05 12:52:56
2019	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd1","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fghf","text":"<p>text ru<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"locale":"en","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435 en<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:53:07	2018-10-05 12:53:07
2020	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-05 12:53:09	2018-10-05 12:53:09
2021	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgytddd","link":"asdsd1","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fghf","text":"<p>text ru<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"locale":"en","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435 en<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:53:33	2018-10-05 12:53:33
2022	1	admin/seo	GET	192.168.10.1	[]	2018-10-05 12:53:34	2018-10-05 12:53:34
2023	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-05 12:53:39	2018-10-05 12:53:39
2024	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:57:13	2018-10-05 12:57:13
2025	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 12:58:26	2018-10-05 12:58:26
2026	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"0","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 12:58:33	2018-10-05 12:58:33
2027	1	admin/seo	GET	192.168.10.1	[]	2018-10-05 12:58:35	2018-10-05 12:58:35
2028	1	admin/seo/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-05 12:58:40	2018-10-05 12:58:40
2029	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-05 13:07:30	2018-10-05 13:07:30
2030	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"0","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fghf","text":"<p>dfg<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"locale":"en","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>222222222222<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/seo\\/3\\/edit"}	2018-10-05 13:07:44	2018-10-05 13:07:44
2031	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-05 13:07:46	2018-10-05 13:07:46
2032	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-05 13:08:08	2018-10-05 13:08:08
2033	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 13:08:12	2018-10-05 13:08:12
2082	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:25:56	2018-10-05 14:25:56
2085	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:33:07	2018-10-05 14:33:07
2088	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:35:28	2018-10-05 14:35:28
2089	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:35:28	2018-10-05 14:35:28
2251	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:23:15	2018-10-08 11:23:15
2034	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fghf","text":"<p>dfg<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"locale":"en","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>222222222222<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 13:08:35	2018-10-05 13:08:35
2035	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-05 13:08:36	2018-10-05 13:08:36
2036	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-05 13:10:21	2018-10-05 13:10:21
2037	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"1","alias":"sds1hhheeetgyt","link":"asdsd","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fghf","text":"<p>dfg<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"locale":"en","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>222222222222<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/seo\\/3\\/edit"}	2018-10-05 13:10:34	2018-10-05 13:10:34
2038	1	admin/seo/2/edit	GET	192.168.10.1	[]	2018-10-05 13:10:35	2018-10-05 13:10:35
2039	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1hhheeetgytrr","lock_alias":"0","alias":"sds1hhheeetgytrr","link":"asdsdhh","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fghf","text":"<p>text ru<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"locale":"en","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435 en<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT"}	2018-10-05 13:10:59	2018-10-05 13:10:59
2040	1	admin/seo	GET	192.168.10.1	[]	2018-10-05 13:11:00	2018-10-05 13:11:00
2041	1	admin/seo/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-05 13:11:04	2018-10-05 13:11:04
2042	1	admin/seo/2	PUT	192.168.10.1	{"log_name":"sds1hhheeetgytrr","lock_alias":"0","alias":"sds1hhheeetgytrr","link":"asdsdhh","state":"on","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fghf","text":"<p>text ru<\\/p>","seo_h1":"h1 ru","seo_title":"meta ru","seo_keywords":"key ru","seo_description":"deskr ru"},"en":{"locale":"en","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 en","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435 en<\\/p>","seo_h1":"\\u04401en","seo_title":"title en","seo_keywords":"keywords en","seo_description":"description en"}},"_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/seo"}	2018-10-05 13:11:11	2018-10-05 13:11:11
2043	1	admin/seo	GET	192.168.10.1	[]	2018-10-05 13:11:11	2018-10-05 13:11:11
2044	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-05 13:11:30	2018-10-05 13:11:30
2045	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 13:34:06	2018-10-05 13:34:06
2046	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 13:39:27	2018-10-05 13:39:27
2047	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 13:44:52	2018-10-05 13:44:52
2048	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 13:45:13	2018-10-05 13:45:13
2049	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 13:50:19	2018-10-05 13:50:19
2050	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 13:50:35	2018-10-05 13:50:35
2051	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 13:50:36	2018-10-05 13:50:36
2052	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 13:51:07	2018-10-05 13:51:07
2053	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 13:52:15	2018-10-05 13:52:15
2054	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 13:52:47	2018-10-05 13:52:47
2055	1	admin/images/upload	POST	192.168.10.1	{"name":"Image from million-wallpapers.ru 1920x1200.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"3","_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl"}	2018-10-05 13:53:09	2018-10-05 13:53:09
2056	1	admin/images/upload	POST	192.168.10.1	{"name":"rozy_butony_rozovyj_123260_1600x1200.jpg","chunk":"0","chunks":"1","alias":"seo","item_id":"3","_token":"Vyr0NnyTJ7o3gE6NA1RsKSEwew3KxtusEgzeoawl"}	2018-10-05 13:53:11	2018-10-05 13:53:11
2057	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 13:53:11	2018-10-05 13:53:11
2058	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 13:53:13	2018-10-05 13:53:13
2059	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 13:58:20	2018-10-05 13:58:20
2060	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 13:58:23	2018-10-05 13:58:23
2061	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 13:58:23	2018-10-05 13:58:23
2062	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:01:15	2018-10-05 14:01:15
2063	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:01:18	2018-10-05 14:01:18
2064	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:01:19	2018-10-05 14:01:19
2065	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:05:20	2018-10-05 14:05:20
2066	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:05:23	2018-10-05 14:05:23
2067	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:05:23	2018-10-05 14:05:23
2068	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:05:35	2018-10-05 14:05:35
2069	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:05:38	2018-10-05 14:05:38
2070	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:05:38	2018-10-05 14:05:38
2071	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:07:00	2018-10-05 14:07:00
2072	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:10:12	2018-10-05 14:10:12
2073	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:10:15	2018-10-05 14:10:15
2074	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:10:15	2018-10-05 14:10:15
2075	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:11:52	2018-10-05 14:11:52
2076	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:11:54	2018-10-05 14:11:54
2077	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:11:54	2018-10-05 14:11:54
2078	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:21:16	2018-10-05 14:21:16
2081	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:25:52	2018-10-05 14:25:52
2091	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:35:55	2018-10-05 14:35:55
2092	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:35:55	2018-10-05 14:35:55
2093	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:36:20	2018-10-05 14:36:20
2094	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:36:22	2018-10-05 14:36:22
2095	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:36:23	2018-10-05 14:36:23
2096	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:38:07	2018-10-05 14:38:07
2097	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:38:10	2018-10-05 14:38:10
2098	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:38:10	2018-10-05 14:38:10
2099	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:41:00	2018-10-05 14:41:00
2100	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:41:03	2018-10-05 14:41:03
2101	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:41:03	2018-10-05 14:41:03
2102	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:41:38	2018-10-05 14:41:38
2103	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:41:41	2018-10-05 14:41:41
2104	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:41:41	2018-10-05 14:41:41
2105	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:44:07	2018-10-05 14:44:07
2106	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:44:07	2018-10-05 14:44:07
2107	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:44:10	2018-10-05 14:44:10
2108	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:44:10	2018-10-05 14:44:10
2109	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:52:13	2018-10-05 14:52:13
2110	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:52:17	2018-10-05 14:52:17
2111	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:52:17	2018-10-05 14:52:17
2112	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:52:23	2018-10-05 14:52:23
2113	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:52:26	2018-10-05 14:52:26
2114	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:52:26	2018-10-05 14:52:26
2115	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:57:35	2018-10-05 14:57:35
2116	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:57:37	2018-10-05 14:57:37
2117	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 14:57:37	2018-10-05 14:57:37
2118	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:58:15	2018-10-05 14:58:15
2119	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:59:09	2018-10-05 14:59:09
2120	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 14:59:27	2018-10-05 14:59:27
2121	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 15:00:18	2018-10-05 15:00:18
2122	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 15:00:21	2018-10-05 15:00:21
2123	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 15:00:21	2018-10-05 15:00:21
2124	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 15:01:19	2018-10-05 15:01:19
2125	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-05 15:01:22	2018-10-05 15:01:22
2126	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-05 15:01:22	2018-10-05 15:01:22
2127	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-05 15:02:17	2018-10-05 15:02:17
2157	1	admin	GET	192.168.10.1	[]	2018-10-08 07:29:41	2018-10-08 07:29:41
2158	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:31:20	2018-10-08 07:31:20
2159	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:31:28	2018-10-08 07:31:28
2160	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-08 07:31:29	2018-10-08 07:31:29
2161	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 07:31:29	2018-10-08 07:31:29
2162	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:35:53	2018-10-08 07:35:53
2163	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:36:00	2018-10-08 07:36:00
2164	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:37:08	2018-10-08 07:37:08
2165	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:37:31	2018-10-08 07:37:31
2166	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 07:37:59	2018-10-08 07:37:59
2167	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-08 07:37:59	2018-10-08 07:37:59
2168	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-08 07:44:27	2018-10-08 07:44:27
2169	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 07:44:27	2018-10-08 07:44:27
2170	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:44:56	2018-10-08 07:44:56
2171	1	admin/config/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:45:03	2018-10-08 07:45:03
2172	1	admin/config/3/edit	GET	192.168.10.1	[]	2018-10-08 07:46:38	2018-10-08 07:46:38
2173	1	admin/config/3/edit	GET	192.168.10.1	[]	2018-10-08 07:47:02	2018-10-08 07:47:02
2174	1	admin/config/3	PUT	192.168.10.1	{"name":"enable_debug","value":"0","description":"\\u0412\\u043a\\u043b\\u044e\\u0447\\u0430\\u0435\\u0442 \\u0434\\u0435\\u0431\\u0430\\u0433","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT"}	2018-10-08 07:47:23	2018-10-08 07:47:23
2175	1	admin/config	GET	192.168.10.1	[]	2018-10-08 07:47:24	2018-10-08 07:47:24
2176	1	admin/config	GET	192.168.10.1	[]	2018-10-08 07:47:28	2018-10-08 07:47:28
2177	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:47:33	2018-10-08 07:47:33
2178	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:47:37	2018-10-08 07:47:37
2179	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 07:47:38	2018-10-08 07:47:38
2180	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-08 07:47:38	2018-10-08 07:47:38
2181	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-08 07:47:46	2018-10-08 07:47:46
2182	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 07:47:46	2018-10-08 07:47:46
2183	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:52:38	2018-10-08 07:52:38
2184	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:52:50	2018-10-08 07:52:50
2185	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:53:23	2018-10-08 07:53:23
2186	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:53:31	2018-10-08 07:53:31
2187	1	admin/config/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:53:36	2018-10-08 07:53:36
2188	1	admin/auth/users	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:53:44	2018-10-08 07:53:44
2189	1	admin/auth/users/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:53:48	2018-10-08 07:53:48
2190	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:58:58	2018-10-08 07:58:58
2191	1	admin/auth/users	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:59:03	2018-10-08 07:59:03
2192	1	admin/auth/users/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 07:59:12	2018-10-08 07:59:12
2193	1	admin/auth/users	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:01:12	2018-10-08 08:01:12
2194	1	admin/auth/users/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:01:20	2018-10-08 08:01:20
2195	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:01:31	2018-10-08 08:01:31
2196	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:01:35	2018-10-08 08:01:35
2197	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:02:34	2018-10-08 08:02:34
2198	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:03:06	2018-10-08 08:03:06
2199	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:08:10	2018-10-08 08:08:10
2200	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:08:13	2018-10-08 08:08:13
2201	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 08:08:21	2018-10-08 08:08:21
2202	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-08 08:08:21	2018-10-08 08:08:21
2203	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-08 08:08:55	2018-10-08 08:08:55
2204	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 08:08:55	2018-10-08 08:08:55
2205	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:15:39	2018-10-08 08:15:39
2206	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:15:46	2018-10-08 08:15:46
2207	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-08 08:16:46	2018-10-08 08:16:46
2208	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-08 08:16:48	2018-10-08 08:16:48
2209	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 08:16:48	2018-10-08 08:16:48
2210	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:16:57	2018-10-08 08:16:57
2211	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:17:02	2018-10-08 08:17:02
2212	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:18:56	2018-10-08 08:18:56
2213	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:19:00	2018-10-08 08:19:00
2214	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:20:31	2018-10-08 08:20:31
2215	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:20:34	2018-10-08 08:20:34
2216	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:21:27	2018-10-08 08:21:27
2217	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:21:31	2018-10-08 08:21:31
2218	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:23:00	2018-10-08 08:23:00
2219	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:23:03	2018-10-08 08:23:03
2220	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:23:42	2018-10-08 08:23:42
2221	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:23:46	2018-10-08 08:23:46
2222	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:23:51	2018-10-08 08:23:51
2223	1	admin/seo	GET	192.168.10.1	[]	2018-10-08 08:23:53	2018-10-08 08:23:53
2224	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:23:58	2018-10-08 08:23:58
2225	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-08 08:23:59	2018-10-08 08:23:59
2226	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 08:24:00	2018-10-08 08:24:00
2227	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"0","alias":"sds1hhheeetgyt","link":"asdsd","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"state":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/seo"}	2018-10-08 08:24:14	2018-10-08 08:24:14
2228	1	admin/seo	GET	192.168.10.1	[]	2018-10-08 08:24:15	2018-10-08 08:24:15
2229	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:24:18	2018-10-08 08:24:18
2230	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 08:33:04	2018-10-08 08:33:04
2231	1	admin/seo	GET	192.168.10.1	[]	2018-10-08 09:31:00	2018-10-08 09:31:00
2232	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 10:33:40	2018-10-08 10:33:40
2233	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 10:33:41	2018-10-08 10:33:41
2234	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-08 10:33:41	2018-10-08 10:33:41
2235	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 10:43:00	2018-10-08 10:43:00
2236	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-10-08 10:43:30	2018-10-08 10:43:30
2237	1	admin/auth/permissions	GET	192.168.10.1	{"page":"3","_pjax":"#pjax-container"}	2018-10-08 10:43:42	2018-10-08 10:43:42
2238	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container","page":"2"}	2018-10-08 10:44:06	2018-10-08 10:44:06
2239	1	admin/seo	GET	192.168.10.1	[]	2018-10-08 10:45:08	2018-10-08 10:45:08
2240	1	admin/seo	GET	192.168.10.1	[]	2018-10-08 10:55:00	2018-10-08 10:55:00
2241	1	admin/seo	GET	192.168.10.1	[]	2018-10-08 10:57:11	2018-10-08 10:57:11
2242	1	admin/seo	GET	192.168.10.1	[]	2018-10-08 10:57:49	2018-10-08 10:57:49
2243	1	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:04:49	2018-10-08 11:04:49
2244	1	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:11:41	2018-10-08 11:11:41
2245	2	admin	GET	192.168.10.1	[]	2018-10-08 11:20:48	2018-10-08 11:20:48
2246	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:20:58	2018-10-08 11:20:58
2247	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:21:08	2018-10-08 11:21:08
2248	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:22:18	2018-10-08 11:22:18
2249	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:22:36	2018-10-08 11:22:36
2250	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:22:58	2018-10-08 11:22:58
2252	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:23:21	2018-10-08 11:23:21
2253	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:24:45	2018-10-08 11:24:45
2254	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:25:24	2018-10-08 11:25:24
2255	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:25:33	2018-10-08 11:25:33
2256	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:26:06	2018-10-08 11:26:06
2257	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:26:15	2018-10-08 11:26:15
2258	1	admin/auth/users	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:28:24	2018-10-08 11:28:24
2259	1	admin/auth/users/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:28:28	2018-10-08 11:28:28
2260	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:28:34	2018-10-08 11:28:34
2261	1	admin/auth/roles	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:28:41	2018-10-08 11:28:41
2262	1	admin/auth/roles/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:28:45	2018-10-08 11:28:45
2263	1	admin/auth/roles/2	PUT	192.168.10.1	{"slug":"moderator","name":"moderator","permissions":["2","3","38","39","40","41","53",null],"_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/roles"}	2018-10-08 11:29:07	2018-10-08 11:29:07
2264	1	admin/auth/roles	GET	192.168.10.1	[]	2018-10-08 11:29:08	2018-10-08 11:29:08
2265	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:29:09	2018-10-08 11:29:09
2266	1	admin/auth/menu	GET	192.168.10.1	[]	2018-10-08 11:29:34	2018-10-08 11:29:34
2267	1	admin/auth/menu/42/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:29:40	2018-10-08 11:29:40
2268	1	admin/auth/menu/42	PUT	192.168.10.1	{"parent_id":"41","title":"SEO","icon":"fa-compass","uri":"\\/seo","roles":["1","2",null],"_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/menu"}	2018-10-08 11:29:47	2018-10-08 11:29:47
2269	1	admin/auth/menu	GET	192.168.10.1	[]	2018-10-08 11:29:48	2018-10-08 11:29:48
2270	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:29:50	2018-10-08 11:29:50
2271	1	admin/auth/menu/41/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:29:57	2018-10-08 11:29:57
2272	1	admin/auth/menu/41	PUT	192.168.10.1	{"parent_id":"0","title":"SEO","icon":"fa-compass","uri":null,"roles":["1","2",null],"_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/menu"}	2018-10-08 11:30:03	2018-10-08 11:30:03
2273	1	admin/auth/menu	GET	192.168.10.1	[]	2018-10-08 11:30:03	2018-10-08 11:30:03
2274	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:30:08	2018-10-08 11:30:08
2275	2	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:30:11	2018-10-08 11:30:11
2276	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:30:30	2018-10-08 11:30:30
2277	1	admin/auth/roles	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:30:34	2018-10-08 11:30:34
2278	1	admin/auth/roles/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:30:40	2018-10-08 11:30:40
2279	1	admin/auth/roles/2	PUT	192.168.10.1	{"slug":"moderator","name":"moderator","permissions":["2","3","38","39","40","41",null],"_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/roles"}	2018-10-08 11:30:47	2018-10-08 11:30:47
2280	1	admin/auth/roles	GET	192.168.10.1	[]	2018-10-08 11:30:48	2018-10-08 11:30:48
2281	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:30:49	2018-10-08 11:30:49
2282	2	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:30:54	2018-10-08 11:30:54
2283	1	admin/auth/roles/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:30:57	2018-10-08 11:30:57
2284	1	admin/auth/roles/2	PUT	192.168.10.1	{"slug":"moderator","name":"moderator","permissions":["2","3","38","39","40","41","53",null],"_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/roles"}	2018-10-08 11:31:10	2018-10-08 11:31:10
2285	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:31:11	2018-10-08 11:31:11
2286	1	admin/auth/roles	GET	192.168.10.1	[]	2018-10-08 11:31:11	2018-10-08 11:31:11
2287	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:31:45	2018-10-08 11:31:45
2288	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:32:19	2018-10-08 11:32:19
2289	1	admin/auth/roles/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:32:40	2018-10-08 11:32:40
2290	1	admin/auth/roles/2	PUT	192.168.10.1	{"slug":"moderator","name":"moderator","permissions":["2","3","38","39","40","41","53","55",null],"_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/roles"}	2018-10-08 11:32:48	2018-10-08 11:32:48
2291	1	admin/auth/roles	GET	192.168.10.1	[]	2018-10-08 11:32:48	2018-10-08 11:32:48
2292	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:32:49	2018-10-08 11:32:49
2293	1	admin/auth/roles/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:32:55	2018-10-08 11:32:55
2294	1	admin/auth/roles/2	PUT	192.168.10.1	{"slug":"moderator","name":"moderator","permissions":["2","3","38","39","40","41","52","53","55",null],"_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/roles"}	2018-10-08 11:33:05	2018-10-08 11:33:05
2295	1	admin/auth/roles	GET	192.168.10.1	[]	2018-10-08 11:33:06	2018-10-08 11:33:06
2296	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:33:09	2018-10-08 11:33:09
2297	1	admin/auth/roles/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:33:15	2018-10-08 11:33:15
2298	1	admin/auth/roles/2	PUT	192.168.10.1	{"slug":"moderator","name":"moderator","permissions":["2","3","38","39","40","41","52","53","54","55",null],"_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/roles"}	2018-10-08 11:33:22	2018-10-08 11:33:22
2299	1	admin/auth/roles	GET	192.168.10.1	[]	2018-10-08 11:33:23	2018-10-08 11:33:23
2300	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:33:25	2018-10-08 11:33:25
2301	2	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:33:27	2018-10-08 11:33:27
2302	2	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 11:33:28	2018-10-08 11:33:28
2303	2	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-08 11:33:28	2018-10-08 11:33:28
2304	2	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 11:33:31	2018-10-08 11:33:31
2305	2	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-08 11:33:31	2018-10-08 11:33:31
2306	2	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"0","alias":"sds1hhheeetgyt","link":"asdsd","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"state":"on","_token":"8luOjkTvjpaVmXaHr7bgdTyxLn9nYBiW83BdTnVy","_method":"PUT","_previous_":"https:\\/\\/laravel-admin.dev\\/admin\\/seo"}	2018-10-08 11:33:32	2018-10-08 11:33:32
2307	2	admin/seo	GET	192.168.10.1	[]	2018-10-08 11:33:32	2018-10-08 11:33:32
2308	2	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:49:54	2018-10-08 11:49:54
2309	1	admin/auth/roles	GET	192.168.10.1	[]	2018-10-08 11:56:28	2018-10-08 11:56:28
2310	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:56:56	2018-10-08 11:56:56
2311	1	admin/modules/install	POST	192.168.10.1	{"_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","id":"3"}	2018-10-08 11:57:25	2018-10-08 11:57:25
2312	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 11:57:26	2018-10-08 11:57:26
2313	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 12:51:45	2018-10-08 12:51:45
2314	1	admin/seo/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 12:51:48	2018-10-08 12:51:48
2315	1	admin/seo	POST	192.168.10.1	{"log_name":null,"lock_alias":null,"alias":null,"link":null,"translate":{"ru":{"locale":"ru","introtext":null,"text":null,"seo_h1":null,"seo_title":null,"seo_keywords":null,"seo_description":null},"en":{"locale":"en","introtext":null,"text":null,"seo_h1":null,"seo_title":null,"seo_keywords":null,"seo_description":null}},"state":"off","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/seo"}	2018-10-08 12:51:52	2018-10-08 12:51:52
2316	1	admin/seo/create	GET	192.168.10.1	[]	2018-10-08 12:51:53	2018-10-08 12:51:53
2317	1	admin/seo	POST	192.168.10.1	{"log_name":null,"lock_alias":null,"alias":null,"link":null,"translate":{"ru":{"locale":"ru","introtext":null,"text":null,"seo_h1":null,"seo_title":null,"seo_keywords":null,"seo_description":null},"en":{"locale":"en","introtext":null,"text":null,"seo_h1":null,"seo_title":null,"seo_keywords":null,"seo_description":null}},"state":"off","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY"}	2018-10-08 12:53:59	2018-10-08 12:53:59
2318	1	admin/seo/create	GET	192.168.10.1	[]	2018-10-08 12:54:00	2018-10-08 12:54:00
2319	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:20:18	2018-10-08 13:20:18
2320	1	admin/seo/create	GET	192.168.10.1	[]	2018-10-08 13:20:19	2018-10-08 13:20:19
2321	1	admin/seo/create	GET	192.168.10.1	[]	2018-10-08 13:23:51	2018-10-08 13:23:51
2322	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:23:55	2018-10-08 13:23:55
2323	1	admin/news/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:24:03	2018-10-08 13:24:03
2324	1	admin/news	GET	192.168.10.1	[]	2018-10-08 13:24:04	2018-10-08 13:24:04
2325	1	admin/news	GET	192.168.10.1	[]	2018-10-08 13:34:53	2018-10-08 13:34:53
2326	1	admin/news/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:34:56	2018-10-08 13:34:56
2327	1	admin/news	GET	192.168.10.1	[]	2018-10-08 13:34:58	2018-10-08 13:34:58
2328	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:35:18	2018-10-08 13:35:18
2329	1	admin/seo/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:35:21	2018-10-08 13:35:21
2330	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:35:29	2018-10-08 13:35:29
2331	1	admin/news/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:35:31	2018-10-08 13:35:31
2332	1	admin/news	GET	192.168.10.1	[]	2018-10-08 13:35:32	2018-10-08 13:35:32
2333	1	admin/news/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:38:27	2018-10-08 13:38:27
2334	1	admin/news	POST	192.168.10.1	{"log_name":"\\u041d\\u043e\\u0432\\u043e\\u0441\\u0442\\u044c \\u043f\\u0440\\u0438\\u043c\\u0435\\u0440","lock_alias":null,"alias":"novosti-primer","translate":{"ru":{"locale":"ru","name":"\\u0420\\u0443 \\u0437\\u0430\\u0433\\u043e\\u043b\\u043e\\u0432\\u043e\\u043a","introtext":"\\u0418\\u043d\\u0442\\u0440\\u043e \\u0440\\u0443","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435 \\u043d\\u0430 \\u0440\\u0443\\u0441\\u0441\\u043a\\u043e\\u043c<\\/p>","seo_h1":"\\u0421\\u0435\\u043e \\u04451","seo_title":"\\u043c\\u0435\\u0442\\u0430 \\u0442\\u0430\\u0438\\u0442\\u043b \\u0440\\u0443","seo_keywords":"\\u043c\\u0435\\u0442\\u0430 \\u043a\\u0435\\u0439 \\u0440\\u0443","seo_description":null},"en":{"locale":"en","name":"News 1","introtext":"short description","text":"<p>description long<\\/p>","seo_h1":"seo h1","seo_title":"meta title","seo_keywords":"keywords","seo_description":"meta description"}},"state":"on","comments_enabled":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/news"}	2018-10-08 13:40:07	2018-10-08 13:40:07
2335	1	admin/news/create	GET	192.168.10.1	[]	2018-10-08 13:40:09	2018-10-08 13:40:09
2336	1	admin/news	POST	192.168.10.1	{"log_name":"\\u041d\\u043e\\u0432\\u043e\\u0441\\u0442\\u044c \\u043f\\u0440\\u0438\\u043c\\u0435\\u0440","lock_alias":"0","alias":"novosti-primer","translate":{"ru":{"locale":"ru","name":null,"introtext":null,"text":null,"seo_h1":null,"seo_title":null,"seo_keywords":null,"seo_description":null},"en":{"locale":"en","name":null,"introtext":null,"text":null,"seo_h1":null,"seo_title":null,"seo_keywords":null,"seo_description":null}},"state":"on","comments_enabled":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY"}	2018-10-08 13:42:13	2018-10-08 13:42:13
2337	1	admin/news	GET	192.168.10.1	[]	2018-10-08 13:42:13	2018-10-08 13:42:13
2338	1	admin/news	GET	192.168.10.1	[]	2018-10-08 13:44:37	2018-10-08 13:44:37
2339	1	admin/news/2	PUT	192.168.10.1	{"status":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT"}	2018-10-08 13:44:41	2018-10-08 13:44:41
2340	1	admin/news/2	PUT	192.168.10.1	{"status":"off","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT"}	2018-10-08 13:44:42	2018-10-08 13:44:42
2341	1	admin/news/2	PUT	192.168.10.1	{"status":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT"}	2018-10-08 13:44:43	2018-10-08 13:44:43
2342	1	admin/news/2	PUT	192.168.10.1	{"status":"off","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT"}	2018-10-08 13:44:45	2018-10-08 13:44:45
2343	1	admin/news	GET	192.168.10.1	[]	2018-10-08 13:45:33	2018-10-08 13:45:33
2344	1	admin/news/2	PUT	192.168.10.1	{"status":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT"}	2018-10-08 13:45:36	2018-10-08 13:45:36
2345	1	admin/news/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:45:38	2018-10-08 13:45:38
2346	1	admin/news/2	PUT	192.168.10.1	{"log_name":"\\u041d\\u043e\\u0432\\u043e\\u0441\\u0442\\u044c \\u043f\\u0440\\u0438\\u043c\\u0435\\u0440","lock_alias":"0","alias":"novosti-primer","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","name":null,"introtext":null,"text":null,"seo_h1":null,"seo_title":null,"seo_keywords":null,"seo_description":null},"en":{"locale":"en","name":null,"introtext":null,"text":null,"seo_h1":null,"seo_title":null,"seo_keywords":null,"seo_description":null}},"state":"on","comments_enabled":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","after-save":"2","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/news"}	2018-10-08 13:45:42	2018-10-08 13:45:42
2347	1	admin/news/2	GET	192.168.10.1	[]	2018-10-08 13:45:42	2018-10-08 13:45:42
2348	1	admin/news/2	GET	192.168.10.1	[]	2018-10-08 13:46:48	2018-10-08 13:46:48
2349	1	admin/news/2	GET	192.168.10.1	[]	2018-10-08 13:48:11	2018-10-08 13:48:11
2350	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:48:21	2018-10-08 13:48:21
2351	1	admin/news	GET	192.168.10.1	[]	2018-10-08 13:49:01	2018-10-08 13:49:01
2352	1	admin/news	GET	192.168.10.1	[]	2018-10-08 13:51:00	2018-10-08 13:51:00
2353	1	admin/news	GET	192.168.10.1	[]	2018-10-08 13:52:34	2018-10-08 13:52:34
2509	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:12:12	2018-10-10 11:12:12
2354	1	admin/news	GET	192.168.10.1	{"id":null,"log_name":null,"state":"0","_pjax":"#pjax-container"}	2018-10-08 13:52:52	2018-10-08 13:52:52
2355	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container","id":null,"log_name":null,"state":"1"}	2018-10-08 13:52:56	2018-10-08 13:52:56
2356	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container","id":null,"log_name":null,"state":null}	2018-10-08 13:53:03	2018-10-08 13:53:03
2357	1	admin/news/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:53:14	2018-10-08 13:53:14
2358	1	admin/news/2	PUT	192.168.10.1	{"log_name":"\\u041d\\u043e\\u0432\\u043e\\u0441\\u0442\\u044c \\u043f\\u0440\\u0438\\u043c\\u0435\\u0440","lock_alias":"0","alias":"novosti-primer","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","name":"\\u0420\\u0443 \\u0437\\u0430\\u0433\\u043e\\u043b\\u043e\\u0432\\u043e\\u043a","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 \\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435<\\/p>","seo_h1":"\\u0421\\u0435\\u043e \\u04451","seo_title":"\\u043c\\u0435\\u0442\\u0430 \\u0442\\u0430\\u0438\\u0442\\u043b \\u0440\\u0443","seo_keywords":"\\u043a\\u043b\\u044e\\u0447","seo_description":"\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435"},"en":{"locale":"en","name":"News 1","introtext":"short","text":"<p>fdfdf<\\/p>","seo_h1":"seo h1","seo_title":"title en","seo_keywords":"dsdfs","seo_description":"adfd"}},"state":"on","comments_enabled":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/news?&id=&log_name=&state="}	2018-10-08 13:54:31	2018-10-08 13:54:31
2359	1	admin/news	GET	192.168.10.1	{"id":null,"log_name":null,"state":null}	2018-10-08 13:54:33	2018-10-08 13:54:33
2360	1	admin/news/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:56:31	2018-10-08 13:56:31
2361	1	admin/news	POST	192.168.10.1	{"log_name":"sdfdfs","lock_alias":"1","alias":"sdfdfs","translate":{"ru":{"locale":"ru","name":"sdfsa","introtext":"asdfsdf","text":"<p>gfdgdsf<\\/p>","seo_h1":"sdfhg","seo_title":"fdg","seo_keywords":"hdfgh","seo_description":"dfgh"},"en":{"locale":"en","name":"jjjjjjjjj","introtext":"jggggggggggggg","text":"<p>gggggggggg<\\/p>","seo_h1":"jjjjjjjj","seo_title":"hhhhhhhhh","seo_keywords":"ggggggggggggg","seo_description":null}},"state":"on","comments_enabled":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/news?&id=&log_name=&state="}	2018-10-08 13:57:03	2018-10-08 13:57:03
2362	1	admin/news/create	GET	192.168.10.1	[]	2018-10-08 13:57:04	2018-10-08 13:57:04
2363	1	admin/news	POST	192.168.10.1	{"log_name":"sdfdfs","lock_alias":"1","alias":"sdfdfsfgfghgfhfgh","translate":{"ru":{"locale":"ru","name":"fghdfghdfg","introtext":"hdfghdfg","text":"<p>hfdghdfg<\\/p>","seo_h1":"dfghdfg","seo_title":"dfghdfgh","seo_keywords":"dfghdfg","seo_description":"dfghdfgh"},"en":{"locale":"en","name":"dfghdfgh","introtext":"dfghdfgh","text":"<p>dfghdfgh<\\/p>","seo_h1":"dfghdfgh","seo_title":"dfghdf","seo_keywords":"dfghdfgh","seo_description":"fdghdfghfdgh"}},"state":"on","comments_enabled":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY"}	2018-10-08 13:58:49	2018-10-08 13:58:49
2364	1	admin/news	GET	192.168.10.1	[]	2018-10-08 13:58:51	2018-10-08 13:58:51
2365	1	admin/news/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:59:04	2018-10-08 13:59:04
2366	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:59:10	2018-10-08 13:59:10
2367	1	admin/news/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 13:59:16	2018-10-08 13:59:16
2368	1	admin/images/upload	POST	192.168.10.1	{"name":"Image from million-wallpapers.ru 1920x1200.jpg","chunk":"0","chunks":"1","alias":"news","item_id":"2","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY"}	2018-10-08 13:59:29	2018-10-08 13:59:29
2369	1	admin/images/news/2/100/hl-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 13:59:30	2018-10-08 13:59:30
2370	1	admin/news/2/edit	GET	192.168.10.1	[]	2018-10-08 13:59:46	2018-10-08 13:59:46
2371	1	admin/images/news/2/100/hl-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 13:59:48	2018-10-08 13:59:48
2372	1	admin/news/2	PUT	192.168.10.1	{"log_name":"\\u041d\\u043e\\u0432\\u043e\\u0441\\u0442\\u044c \\u043f\\u0440\\u0438\\u043c\\u0435\\u0440","lock_alias":"0","alias":null,"view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","name":"ssss","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 \\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435<\\/p>","seo_h1":"\\u0421\\u0435\\u043e \\u04451","seo_title":"\\u043c\\u0435\\u0442\\u0430 \\u0442\\u0430\\u0438\\u0442\\u043b \\u0440\\u0443","seo_keywords":"\\u043a\\u043b\\u044e\\u0447","seo_description":"\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435"},"en":{"locale":"en","name":null,"introtext":"short","text":"<p>fdfdf<\\/p>","seo_h1":"seo h1","seo_title":"title en","seo_keywords":"dsdfs","seo_description":"adfd"}},"state":"on","comments_enabled":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT"}	2018-10-08 14:01:09	2018-10-08 14:01:09
2373	1	admin/news/2	GET	192.168.10.1	[]	2018-10-08 14:01:10	2018-10-08 14:01:10
2374	1	admin/news/2/edit	GET	192.168.10.1	[]	2018-10-08 14:01:37	2018-10-08 14:01:37
2375	1	admin/images/news/2/100/hl-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 14:01:39	2018-10-08 14:01:39
2376	1	admin/news/2	PUT	192.168.10.1	{"log_name":null,"lock_alias":"0","alias":null,"view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","name":null,"introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 \\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435<\\/p>","seo_h1":"\\u0421\\u0435\\u043e \\u04451","seo_title":"\\u043c\\u0435\\u0442\\u0430 \\u0442\\u0430\\u0438\\u0442\\u043b \\u0440\\u0443","seo_keywords":"\\u043a\\u043b\\u044e\\u0447","seo_description":"\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435"},"en":{"locale":"en","name":"News 1","introtext":"short","text":"<p>fdfdf<\\/p>","seo_h1":"seo h1","seo_title":"title en","seo_keywords":"dsdfs","seo_description":"adfd"}},"state":"on","comments_enabled":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/news\\/2"}	2018-10-08 14:01:55	2018-10-08 14:01:55
2377	1	admin/news/2	GET	192.168.10.1	[]	2018-10-08 14:01:56	2018-10-08 14:01:56
2378	1	admin/news/2/edit	GET	192.168.10.1	[]	2018-10-08 14:02:24	2018-10-08 14:02:24
2379	1	admin/images/news/2/100/hl-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-08 14:02:26	2018-10-08 14:02:26
2458	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"0","alias":"news","link":"\\/news","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"state":"on","_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/seo"}	2018-10-10 10:06:34	2018-10-10 10:06:34
2510	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:12:12	2018-10-10 11:12:12
2512	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:13:18	2018-10-10 11:13:18
2380	1	admin/news/2	PUT	192.168.10.1	{"log_name":null,"lock_alias":"0","alias":null,"view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","name":"hgjgjghj","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 \\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435<\\/p>","seo_h1":"\\u0421\\u0435\\u043e \\u04451","seo_title":"\\u043c\\u0435\\u0442\\u0430 \\u0442\\u0430\\u0438\\u0442\\u043b \\u0440\\u0443","seo_keywords":"\\u043a\\u043b\\u044e\\u0447","seo_description":"\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435"},"en":{"locale":"en","name":"News 1","introtext":"short","text":"<p>fdfdf<\\/p>","seo_h1":"seo h1","seo_title":"title en","seo_keywords":"dsdfs","seo_description":"adfd"}},"state":"on","comments_enabled":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/news\\/2"}	2018-10-08 14:02:36	2018-10-08 14:02:36
2381	1	admin/news/2/edit	GET	192.168.10.1	[]	2018-10-08 14:02:37	2018-10-08 14:02:37
2382	1	admin/news/2	PUT	192.168.10.1	{"log_name":null,"lock_alias":"0","alias":null,"view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","name":"\\u0420\\u0443 \\u0437\\u0430\\u0433\\u043e\\u043b\\u043e\\u0432\\u043e\\u043a","introtext":"\\u043a\\u043e\\u0440\\u043e\\u0442\\u043a\\u043e\\u0435 \\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435","text":"<p>\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435<\\/p>","seo_h1":"\\u0421\\u0435\\u043e \\u04451","seo_title":"\\u043c\\u0435\\u0442\\u0430 \\u0442\\u0430\\u0438\\u0442\\u043b \\u0440\\u0443","seo_keywords":"\\u043a\\u043b\\u044e\\u0447","seo_description":"\\u043e\\u043f\\u0438\\u0441\\u0430\\u043d\\u0438\\u0435"},"en":{"locale":"en","name":"News 1","introtext":"short","text":"<p>fdfdf<\\/p>","seo_h1":"seo h1","seo_title":"title en","seo_keywords":"dsdfs","seo_description":"adfd"}},"state":"on","comments_enabled":"on","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT"}	2018-10-08 14:03:41	2018-10-08 14:03:41
2383	1	admin/news/2/edit	GET	192.168.10.1	[]	2018-10-08 14:03:41	2018-10-08 14:03:41
2384	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:07:32	2018-10-08 14:07:32
2385	1	admin/news/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:07:35	2018-10-08 14:07:35
2386	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:07:38	2018-10-08 14:07:38
2387	1	admin/news/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:07:41	2018-10-08 14:07:41
2388	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:07:50	2018-10-08 14:07:50
2389	1	admin/news/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:07:53	2018-10-08 14:07:53
2390	1	admin/news	POST	192.168.10.1	{"log_name":null,"lock_alias":null,"alias":null,"translate":{"ru":{"locale":"ru","name":"dfg","introtext":"dfg","text":null,"seo_h1":null,"seo_title":null,"seo_keywords":null,"seo_description":null},"en":{"locale":"en","name":null,"introtext":null,"text":null,"seo_h1":null,"seo_title":null,"seo_keywords":null,"seo_description":null}},"state":"off","comments_enabled":"off","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/news"}	2018-10-08 14:08:02	2018-10-08 14:08:02
2391	1	admin/news/create	GET	192.168.10.1	[]	2018-10-08 14:08:02	2018-10-08 14:08:02
2392	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:08:33	2018-10-08 14:08:33
2393	1	admin/news/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:08:35	2018-10-08 14:08:35
2394	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:10:20	2018-10-08 14:10:20
2395	1	admin/news/3	PUT	192.168.10.1	{"comments_enabled":"off","_token":"Qh4Iu7EWQtmTxs6qxreit5isXFJS2sq8yfOtinGY","_method":"PUT"}	2018-10-08 14:10:25	2018-10-08 14:10:25
2396	1	admin/news/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:10:26	2018-10-08 14:10:26
2397	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:10:30	2018-10-08 14:10:30
2398	1	admin/news	GET	192.168.10.1	[]	2018-10-08 14:10:56	2018-10-08 14:10:56
2399	1	admin/news/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:11:42	2018-10-08 14:11:42
2400	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:17:04	2018-10-08 14:17:04
2401	1	admin/langs	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:17:24	2018-10-08 14:17:24
2402	1	admin/langs/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:17:40	2018-10-08 14:17:40
2403	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:30:06	2018-10-08 14:30:06
2404	1	admin/seo/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:30:09	2018-10-08 14:30:09
2405	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:49:14	2018-10-08 14:49:14
2406	1	admin/news/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:49:18	2018-10-08 14:49:18
2407	2	admin/news	GET	192.168.10.1	[]	2018-10-08 14:59:45	2018-10-08 14:59:45
2408	2	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-08 14:59:49	2018-10-08 14:59:49
2440	1	admin	GET	192.168.10.1	[]	2018-10-09 06:52:50	2018-10-09 06:52:50
2441	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-09 06:53:15	2018-10-09 06:53:15
2442	1	admin/news/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-09 06:53:21	2018-10-09 06:53:21
2443	1	admin/images/upload	POST	192.168.10.1	{"name":"SPCQJAdT2pg.jpg","chunk":"0","chunks":"1","alias":"news","item_id":"3","_token":"Oa29sP9LRspOV1a1fcESnAawAhAEGNxWlxHB3M3r"}	2018-10-09 06:53:54	2018-10-09 06:53:54
2444	1	admin/images/news/3/100/CI-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-10-09 06:53:57	2018-10-09 06:53:57
2445	1	admin	GET	192.168.10.1	[]	2018-10-10 07:11:21	2018-10-10 07:11:21
2446	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 07:11:31	2018-10-10 07:11:31
2447	1	admin/news/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 07:11:37	2018-10-10 07:11:37
2448	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 07:12:52	2018-10-10 07:12:52
2449	1	admin/news/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 09:32:09	2018-10-10 09:32:09
2450	1	admin/images/news/3/100/CI-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-10-10 09:32:10	2018-10-10 09:32:10
2451	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 09:32:17	2018-10-10 09:32:17
2452	1	admin/news/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 09:32:19	2018-10-10 09:32:19
2453	1	admin/images/news/2/100/hl-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-10 09:32:20	2018-10-10 09:32:20
2454	1	admin/seo	GET	192.168.10.1	[]	2018-10-10 10:06:09	2018-10-10 10:06:09
2455	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 10:06:18	2018-10-10 10:06:18
2456	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-10 10:06:19	2018-10-10 10:06:19
2457	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-10 10:06:19	2018-10-10 10:06:19
2459	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-10 10:06:36	2018-10-10 10:06:36
2508	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:11:55	2018-10-10 11:11:55
2511	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:13:18	2018-10-10 11:13:18
2513	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:13:37	2018-10-10 11:13:37
2514	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:13:37	2018-10-10 11:13:37
2460	1	admin/seo/3	PUT	192.168.10.1	{"log_name":"sds1hhheeetgyt","lock_alias":"0","alias":"news-seo","link":"\\/news","view_mode_uploader-my_uploader_images":"on","uploader-my_uploader_images_count":"0","translate":{"ru":{"locale":"ru","introtext":"fgdf","text":"<p>dfg<\\/p>","seo_h1":"df","seo_title":"df","seo_keywords":"gdf","seo_description":"dfg"},"en":{"locale":"en","introtext":"2222222","text":"<p>222222222222<\\/p>","seo_h1":"222222222","seo_title":"222222222","seo_keywords":"222222","seo_description":"22222222"}},"state":"on","_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j","_method":"PUT"}	2018-10-10 10:07:20	2018-10-10 10:07:20
2461	1	admin/seo/3	GET	192.168.10.1	[]	2018-10-10 10:07:21	2018-10-10 10:07:21
2462	1	admin/seo/3	GET	192.168.10.1	[]	2018-10-10 10:07:54	2018-10-10 10:07:54
2463	1	admin/seo/3/edit	GET	192.168.10.1	[]	2018-10-10 10:08:45	2018-10-10 10:08:45
2464	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-10 10:08:46	2018-10-10 10:08:46
2465	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-10-10 10:08:46	2018-10-10 10:08:46
2466	1	admin/langs_labels	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 10:08:51	2018-10-10 10:08:51
2467	1	admin/langs_labels/9	DELETE	192.168.10.1	{"_method":"delete","_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j"}	2018-10-10 10:08:59	2018-10-10 10:08:59
2468	1	admin/langs_labels	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 10:09:00	2018-10-10 10:09:00
2469	1	admin/langs_labels/10,11	DELETE	192.168.10.1	{"_method":"delete","_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j"}	2018-10-10 10:09:09	2018-10-10 10:09:09
2470	1	admin/langs_labels	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 10:09:10	2018-10-10 10:09:10
2471	1	admin/langs_cats	GET	192.168.10.1	[]	2018-10-10 10:09:37	2018-10-10 10:09:37
2472	1	admin/langs_cats/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 10:09:41	2018-10-10 10:09:41
2473	1	admin/langs_cats	POST	192.168.10.1	{"name":"\\u0421\\u0430\\u0439\\u0442","alias":"site","parent_id":"0","state":"on","_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/langs_cats"}	2018-10-10 10:10:56	2018-10-10 10:10:56
2474	1	admin/langs_cats	GET	192.168.10.1	[]	2018-10-10 10:10:56	2018-10-10 10:10:56
2475	1	admin/langs_labels	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 10:11:03	2018-10-10 10:11:03
2476	1	admin/langs_labels	GET	192.168.10.1	{"_pjax":"#pjax-container","amp;labels_tree":"5"}	2018-10-10 10:11:07	2018-10-10 10:11:07
2477	1	admin/langs_labels	POST	192.168.10.1	{"_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j","label":"label__Vfuq4bYCK5","parent_id":"0"}	2018-10-10 10:11:10	2018-10-10 10:11:10
2478	1	admin/langs_labels	GET	192.168.10.1	{"amp;labels_tree":"5","_pjax":"#pjax-container"}	2018-10-10 10:11:11	2018-10-10 10:11:11
2479	1	admin/langs_labels/12	DELETE	192.168.10.1	{"_method":"delete","_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j"}	2018-10-10 10:11:20	2018-10-10 10:11:20
2480	1	admin/langs_labels	GET	192.168.10.1	{"amp;labels_tree":"5","_pjax":"#pjax-container"}	2018-10-10 10:11:21	2018-10-10 10:11:21
2481	1	admin/langs_labels	GET	192.168.10.1	{"amp;labels_tree":"5","amp;_pjax":"#pjax-container","_pjax":"#pjax-container"}	2018-10-10 10:11:24	2018-10-10 10:11:24
2482	1	admin/langs_labels	GET	192.168.10.1	{"amp;labels_tree":"5","amp;amp;_pjax":"#pjax-container","amp;_pjax":"#pjax-container","_pjax":"#pjax-container"}	2018-10-10 10:11:26	2018-10-10 10:11:26
2483	1	admin/langs_labels	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-10-10 10:11:29	2018-10-10 10:11:29
2484	1	admin/langs_labels	GET	192.168.10.1	{"_pjax":"#pjax-container","amp;labels_tree":"5"}	2018-10-10 10:11:32	2018-10-10 10:11:32
2485	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"5"}	2018-10-10 10:11:42	2018-10-10 10:11:42
2486	1	admin/langs_labels	POST	192.168.10.1	{"_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j","label":"label__rYwN06QNL4","parent_id":"0"}	2018-10-10 10:11:48	2018-10-10 10:11:48
2487	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"5","_pjax":"#pjax-container"}	2018-10-10 10:11:48	2018-10-10 10:11:48
2488	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"5","_pjax":"#pjax-container"}	2018-10-10 10:11:54	2018-10-10 10:11:54
2489	1	admin/langs_labels	POST	192.168.10.1	{"_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j","label":"label__4ogfo2Cy57","parent_id":"0"}	2018-10-10 10:12:01	2018-10-10 10:12:01
2490	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"5","_pjax":"#pjax-container"}	2018-10-10 10:12:02	2018-10-10 10:12:02
2491	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"0","amp;_pjax":"#pjax-container","_pjax":"#pjax-container"}	2018-10-10 10:12:33	2018-10-10 10:12:33
2492	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"5","amp;amp;_pjax":"#pjax-container","amp;_pjax":"#pjax-container","_pjax":"#pjax-container"}	2018-10-10 10:13:12	2018-10-10 10:13:12
2493	1	admin/langs_labels/13	PUT	192.168.10.1	{"name":"label","value":"defaultMetaDescription","pk":"13","_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j","_editable":"1","_method":"PUT"}	2018-10-10 10:13:23	2018-10-10 10:13:23
2494	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"5","amp;amp;_pjax":"#pjax-container","amp;_pjax":"#pjax-container","_pjax":"#pjax-container"}	2018-10-10 10:13:28	2018-10-10 10:13:28
2495	1	admin/langs_labels/13	PUT	192.168.10.1	{"name":"value_1","value":"\\u0414\\u0435\\u0441\\u043a\\u0440\\u0438\\u043f\\u0448\\u043d \\u043f\\u043e \\u0443\\u043c\\u043e\\u043b\\u0447\\u0430\\u043d\\u0438\\u044e","pk":"13","_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j","_editable":"1","_method":"PUT"}	2018-10-10 10:13:45	2018-10-10 10:13:45
2496	1	admin/langs_labels/13	PUT	192.168.10.1	{"name":"value_2","value":"DEfault Description","pk":"13","_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j","_editable":"1","_method":"PUT"}	2018-10-10 10:14:00	2018-10-10 10:14:00
2497	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"5","amp;amp;_pjax":"#pjax-container","amp;_pjax":"#pjax-container","_pjax":"#pjax-container"}	2018-10-10 10:14:13	2018-10-10 10:14:13
2498	1	admin/langs_labels/14	PUT	192.168.10.1	{"name":"label","value":"defaultMetaTitle","pk":"14","_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j","_editable":"1","_method":"PUT"}	2018-10-10 10:14:25	2018-10-10 10:14:25
2499	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"5","amp;amp;_pjax":"#pjax-container","amp;_pjax":"#pjax-container"}	2018-10-10 10:14:31	2018-10-10 10:14:31
2500	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"5","amp;amp;_pjax":"#pjax-container","amp;_pjax":"#pjax-container","_pjax":"#pjax-container"}	2018-10-10 10:15:19	2018-10-10 10:15:19
2501	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"0","amp;amp;amp;_pjax":"#pjax-container","amp;amp;_pjax":"#pjax-container","amp;_pjax":"#pjax-container"}	2018-10-10 11:06:22	2018-10-10 11:06:22
2502	1	admin/langs_labels/2	PUT	192.168.10.1	{"name":"value_1","value":"ttr","pk":"2","_token":"X5w6A4fy1yKfwGOcBvqWBpscmjLkpE5cJqEJ1W2j","_editable":"1","_method":"PUT"}	2018-10-10 11:06:35	2018-10-10 11:06:35
2503	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:09:06	2018-10-10 11:09:06
2504	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:09:06	2018-10-10 11:09:06
2505	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:10:21	2018-10-10 11:10:21
2506	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:10:21	2018-10-10 11:10:21
2507	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:11:54	2018-10-10 11:11:54
2515	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:16:47	2018-10-10 11:16:47
2516	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:16:47	2018-10-10 11:16:47
2517	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:36:42	2018-10-10 11:36:42
2518	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:36:42	2018-10-10 11:36:42
2519	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:39:10	2018-10-10 11:39:10
2520	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:39:10	2018-10-10 11:39:10
2521	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:39:35	2018-10-10 11:39:35
2522	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:39:35	2018-10-10 11:39:35
2523	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:55:23	2018-10-10 11:55:23
2524	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:55:23	2018-10-10 11:55:23
2525	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:55:43	2018-10-10 11:55:43
2526	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:55:43	2018-10-10 11:55:43
2527	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:55:53	2018-10-10 11:55:53
2528	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:55:53	2018-10-10 11:55:53
2529	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:57:28	2018-10-10 11:57:28
2530	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:57:28	2018-10-10 11:57:28
2531	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 11:59:11	2018-10-10 11:59:11
2532	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 11:59:11	2018-10-10 11:59:11
2533	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 12:20:14	2018-10-10 12:20:14
2534	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 12:20:14	2018-10-10 12:20:14
2535	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 12:29:09	2018-10-10 12:29:09
2536	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 12:29:09	2018-10-10 12:29:09
2537	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 12:31:57	2018-10-10 12:31:57
2538	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 12:31:57	2018-10-10 12:31:57
2539	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 12:43:37	2018-10-10 12:43:37
2540	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 12:43:37	2018-10-10 12:43:37
2541	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 12:43:41	2018-10-10 12:43:41
2542	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 12:43:42	2018-10-10 12:43:42
2543	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 12:43:45	2018-10-10 12:43:45
2544	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 12:43:45	2018-10-10 12:43:45
2545	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 12:49:15	2018-10-10 12:49:15
2546	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 12:49:15	2018-10-10 12:49:15
2547	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 12:55:13	2018-10-10 12:55:13
2548	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 12:55:13	2018-10-10 12:55:13
2549	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 12:58:14	2018-10-10 12:58:14
2550	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 12:58:14	2018-10-10 12:58:14
2551	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 12:58:18	2018-10-10 12:58:18
2552	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 12:58:18	2018-10-10 12:58:18
2553	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 12:58:20	2018-10-10 12:58:20
2554	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 12:58:20	2018-10-10 12:58:20
2555	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 13:07:14	2018-10-10 13:07:14
2556	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 13:07:14	2018-10-10 13:07:14
2557	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 13:07:16	2018-10-10 13:07:16
2558	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 13:07:17	2018-10-10 13:07:17
2559	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 13:07:19	2018-10-10 13:07:19
2560	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 13:07:19	2018-10-10 13:07:19
2561	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 13:07:21	2018-10-10 13:07:21
2562	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 13:07:21	2018-10-10 13:07:21
2563	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 13:07:24	2018-10-10 13:07:24
2564	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 13:07:24	2018-10-10 13:07:24
2565	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 13:07:26	2018-10-10 13:07:26
2566	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 13:07:26	2018-10-10 13:07:26
2567	1	admin/images/news/3/401/0	GET	192.168.10.1	[]	2018-10-10 13:31:15	2018-10-10 13:31:15
2568	1	admin/images/news/2/401/0	GET	192.168.10.1	[]	2018-10-10 13:31:15	2018-10-10 13:31:15
2569	1	admin/images/news/0/401/0	GET	192.168.10.1	[]	2018-10-10 13:32:19	2018-10-10 13:32:19
2570	1	admin/images/news/4/401/CI-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-10-10 13:33:03	2018-10-10 13:33:03
2571	1	admin/images/news/3/401/hl-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-10 13:33:04	2018-10-10 13:33:04
2572	1	admin/images/news/3/401/CI-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-10-10 13:39:08	2018-10-10 13:39:08
2573	1	admin/images/news/2/401/hl-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-10 13:39:08	2018-10-10 13:39:08
2574	1	admin/images/news/2/401/hl-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-10 13:45:18	2018-10-10 13:45:18
2575	1	admin/images/news/3/401/CI-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-10-10 13:45:18	2018-10-10 13:45:18
2576	1	admin/images/news/3/401/CI-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-10-10 13:50:47	2018-10-10 13:50:47
2577	1	admin/images/news/2/401/hl-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-10-10 13:50:47	2018-10-10 13:50:47
2578	1	admin/images/news/2/1280/0	GET	192.168.10.1	[]	2018-10-10 13:51:36	2018-10-10 13:51:36
2579	1	admin/images/news/2/1280/0	GET	192.168.10.1	[]	2018-10-10 13:51:58	2018-10-10 13:51:58
2580	1	admin	GET	192.168.10.1	[]	2018-11-30 07:44:08	2018-11-30 07:44:08
2581	1	admin/langs	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 07:44:17	2018-11-30 07:44:17
2582	1	admin/langs_cats	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 07:44:23	2018-11-30 07:44:23
2583	1	admin/langs_cats	GET	192.168.10.1	[]	2018-11-30 07:46:57	2018-11-30 07:46:57
2584	1	admin/langs_cats	GET	192.168.10.1	[]	2018-11-30 07:48:41	2018-11-30 07:48:41
2585	1	admin/langs_cats/5/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 07:48:45	2018-11-30 07:48:45
2586	1	admin/langs_cats/5/edit	GET	192.168.10.1	[]	2018-11-30 07:52:16	2018-11-30 07:52:16
2587	1	admin/langs_cats/5/edit	GET	192.168.10.1	[]	2018-11-30 07:53:42	2018-11-30 07:53:42
2588	1	admin/langs_cats/5	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 07:56:07	2018-11-30 07:56:07
2589	1	admin/langs_cats/5/edit	GET	192.168.10.1	[]	2018-11-30 07:56:08	2018-11-30 07:56:08
2590	1	admin/langs_cats/5/edit	GET	192.168.10.1	[]	2018-11-30 07:56:52	2018-11-30 07:56:52
2591	1	admin/langs_cats/5/edit	GET	192.168.10.1	[]	2018-11-30 07:57:37	2018-11-30 07:57:37
2592	1	admin/langs_cats/5/edit	GET	192.168.10.1	[]	2018-11-30 08:01:26	2018-11-30 08:01:26
2593	1	admin/langs_cats/5	PUT	192.168.10.1	{"name":"\\u0421\\u0430\\u0439\\u0442","alias":"site","parent_id":"0","state":"on","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_method":"PUT"}	2018-11-30 08:01:47	2018-11-30 08:01:47
2594	1	admin/langs_cats	GET	192.168.10.1	[]	2018-11-30 08:01:48	2018-11-30 08:01:48
2595	1	admin/langs	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:06:46	2018-11-30 08:06:46
2596	1	admin/langs	GET	192.168.10.1	[]	2018-11-30 08:06:56	2018-11-30 08:06:56
2597	1	admin/langs	GET	192.168.10.1	[]	2018-11-30 08:07:49	2018-11-30 08:07:49
2598	1	admin/langs	GET	192.168.10.1	[]	2018-11-30 08:08:04	2018-11-30 08:08:04
2599	1	admin/langs/create	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:10:20	2018-11-30 08:10:20
2600	1	admin/langs	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:10:35	2018-11-30 08:10:35
2601	1	admin/langs/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:10:38	2018-11-30 08:10:38
2602	1	admin/langs/2	PUT	192.168.10.1	{"name":"English","alias":"en","default":"off","state":"on","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/langs"}	2018-11-30 08:10:45	2018-11-30 08:10:45
2603	1	admin/langs	GET	192.168.10.1	[]	2018-11-30 08:10:45	2018-11-30 08:10:45
2604	1	admin/langs/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:10:49	2018-11-30 08:10:49
2605	1	admin/langs/2/edit	GET	192.168.10.1	[]	2018-11-30 08:11:09	2018-11-30 08:11:09
2606	1	admin/langs	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:11:19	2018-11-30 08:11:19
2607	1	admin/langs_labels	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:13:15	2018-11-30 08:13:15
2608	1	admin/langs_labels	GET	192.168.10.1	[]	2018-11-30 08:17:33	2018-11-30 08:17:33
2609	1	admin/langs_labels/2	PUT	192.168.10.1	{"name":"value_1","value":"ewew","pk":"2","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_editable":"1","_method":"PUT"}	2018-11-30 08:17:46	2018-11-30 08:17:46
2610	1	admin/langs_labels/1	PUT	192.168.10.1	{"name":"label","value":null,"pk":"1","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_editable":"1","_method":"PUT"}	2018-11-30 08:17:53	2018-11-30 08:17:53
2611	1	admin/langs_labels	GET	192.168.10.1	[]	2018-11-30 08:25:33	2018-11-30 08:25:33
2612	1	admin/langs_labels/5	PUT	192.168.10.1	{"name":"value_1","value":"dsfsdf","pk":"5","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_editable":"1","_method":"PUT"}	2018-11-30 08:25:40	2018-11-30 08:25:40
2613	1	admin/langs_labels	GET	192.168.10.1	[]	2018-11-30 08:25:42	2018-11-30 08:25:42
2614	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"5","_pjax":"#pjax-container"}	2018-11-30 08:25:49	2018-11-30 08:25:49
2615	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"1","_pjax":"#pjax-container"}	2018-11-30 08:25:51	2018-11-30 08:25:51
2616	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"1","_pjax":"#pjax-container"}	2018-11-30 08:25:51	2018-11-30 08:25:51
2617	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"2","_pjax":"#pjax-container"}	2018-11-30 08:25:53	2018-11-30 08:25:53
2618	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"2","_pjax":"#pjax-container"}	2018-11-30 08:25:53	2018-11-30 08:25:53
2619	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"3","_pjax":"#pjax-container"}	2018-11-30 08:25:55	2018-11-30 08:25:55
2620	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"3","_pjax":"#pjax-container"}	2018-11-30 08:25:55	2018-11-30 08:25:55
2621	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"2","_pjax":"#pjax-container"}	2018-11-30 08:25:56	2018-11-30 08:25:56
2622	1	admin/langs_labels	GET	192.168.10.1	{"labels_tree":"2","_pjax":"#pjax-container"}	2018-11-30 08:25:56	2018-11-30 08:25:56
2623	1	admin/langs_labels/5	PUT	192.168.10.1	{"name":"value_2","value":"hgh","pk":"5","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_editable":"1","_method":"PUT"}	2018-11-30 08:26:01	2018-11-30 08:26:01
2624	1	admin/langs_cats	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:26:05	2018-11-30 08:26:05
2625	1	admin/langs_cats/1/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:26:08	2018-11-30 08:26:08
2626	1	admin/langs	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:26:11	2018-11-30 08:26:11
2627	1	admin/langs/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:26:16	2018-11-30 08:26:16
2628	1	admin/langs	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:26:18	2018-11-30 08:26:18
2629	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:28:06	2018-11-30 08:28:06
2630	1	admin/modules	GET	192.168.10.1	[]	2018-11-30 08:28:14	2018-11-30 08:28:14
2631	1	admin/modules	GET	192.168.10.1	[]	2018-11-30 08:28:57	2018-11-30 08:28:57
2632	1	admin/modules	GET	192.168.10.1	[]	2018-11-30 08:29:46	2018-11-30 08:29:46
2633	1	admin/modules	GET	192.168.10.1	[]	2018-11-30 08:31:27	2018-11-30 08:31:27
2634	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:36:48	2018-11-30 08:36:48
2635	1	admin/news/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:37:48	2018-11-30 08:37:48
2636	1	admin/news/3/edit	GET	192.168.10.1	[]	2018-11-30 08:38:28	2018-11-30 08:38:28
2637	1	admin/news/3/edit	GET	192.168.10.1	[]	2018-11-30 08:38:49	2018-11-30 08:38:49
2638	1	admin/langs_labels	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:39:59	2018-11-30 08:39:59
2639	1	admin/langs	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:40:02	2018-11-30 08:40:02
2640	1	admin/langs/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:40:06	2018-11-30 08:40:06
2641	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:40:18	2018-11-30 08:40:18
2642	1	admin/news/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:40:27	2018-11-30 08:40:27
2643	1	admin/news/3/edit	GET	192.168.10.1	[]	2018-11-30 08:41:31	2018-11-30 08:41:31
2644	1	admin/news/3/edit	GET	192.168.10.1	[]	2018-11-30 08:45:53	2018-11-30 08:45:53
2645	1	admin/images/news/3/100/CI-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-11-30 08:45:54	2018-11-30 08:45:54
2646	1	admin/images/upload	POST	192.168.10.1	{"name":"rozy_butony_rozovyj_123260_1600x1200.jpg","chunk":"0","chunks":"1","alias":"news","item_id":"3","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77"}	2018-11-30 08:46:12	2018-11-30 08:46:12
2647	1	admin/images/news/3/100/tJ-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-11-30 08:46:13	2018-11-30 08:46:13
2648	1	admin/images/setmain	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"5","item_id":"3","module":"news"}	2018-11-30 08:46:20	2018-11-30 08:46:20
2649	1	admin/news/3/edit	GET	192.168.10.1	[]	2018-11-30 08:46:26	2018-11-30 08:46:26
2650	1	admin/images/news/3/100/CI-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-11-30 08:46:28	2018-11-30 08:46:28
2651	1	admin/images/news/3/100/tJ-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-11-30 08:46:28	2018-11-30 08:46:28
2652	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:49:39	2018-11-30 08:49:39
2653	1	admin/news/3/edit	GET	192.168.10.1	[]	2018-11-30 08:49:40	2018-11-30 08:49:40
2654	1	admin/news/3/edit	GET	192.168.10.1	[]	2018-11-30 08:51:04	2018-11-30 08:51:04
2655	1	admin/images/news/3/100/tJ-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-11-30 08:51:05	2018-11-30 08:51:05
2656	1	admin/images/news/3/100/CI-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-11-30 08:51:05	2018-11-30 08:51:05
2657	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:51:16	2018-11-30 08:51:16
2658	1	admin/seo/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 08:51:20	2018-11-30 08:51:20
2659	1	admin/images/seo/3/100/yg-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-11-30 08:51:22	2018-11-30 08:51:22
2660	1	admin/images/seo/3/100/BA-Image%20from%20million-wallpapers.ru%201920x1200.jpg	GET	192.168.10.1	[]	2018-11-30 08:51:22	2018-11-30 08:51:22
2661	1	admin/images/setmain	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"1","item_id":"3","module":"seo"}	2018-11-30 08:51:34	2018-11-30 08:51:34
2662	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 09:09:18	2018-11-30 09:09:18
2663	1	admin/auth/roles	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 09:09:37	2018-11-30 09:09:37
2664	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 09:09:50	2018-11-30 09:09:50
2665	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 09:23:36	2018-11-30 09:23:36
2666	1	admin/auth/permissions/5/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 09:37:10	2018-11-30 09:37:10
2667	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 09:38:02	2018-11-30 09:38:02
2668	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 09:43:57	2018-11-30 09:43:57
2669	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 09:44:01	2018-11-30 09:44:01
2670	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 09:44:47	2018-11-30 09:44:47
2671	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 10:29:54	2018-11-30 10:29:54
2672	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 10:30:39	2018-11-30 10:30:39
2673	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 10:31:40	2018-11-30 10:31:40
2674	1	admin/auth/permissions/1	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:32:46	2018-11-30 10:32:46
2675	1	admin/auth/permissions/1	GET	192.168.10.1	[]	2018-11-30 10:33:28	2018-11-30 10:33:28
2676	1	admin/auth/permissions/1/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:33:35	2018-11-30 10:33:35
2677	1	admin/auth/permissions/1/edit	GET	192.168.10.1	[]	2018-11-30 10:35:39	2018-11-30 10:35:39
2678	1	admin/auth/permissions/1	PUT	192.168.10.1	{"cat_id":null,"slug":"*","name":"All permission","http_method":[null],"http_path":"*","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/permissions\\/1"}	2018-11-30 10:36:51	2018-11-30 10:36:51
2679	1	admin/auth/permissions/1/edit	GET	192.168.10.1	[]	2018-11-30 10:36:52	2018-11-30 10:36:52
2680	1	admin/auth/permissions/1	PUT	192.168.10.1	{"cat_id":null,"slug":"*","name":"All permission","http_method":[null],"http_path":"*","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_method":"PUT"}	2018-11-30 10:38:03	2018-11-30 10:38:03
2681	1	admin/auth/permissions/1/edit	GET	192.168.10.1	[]	2018-11-30 10:38:03	2018-11-30 10:38:03
2682	1	admin/auth/permissions/1	PUT	192.168.10.1	{"cat_id":"1","slug":"*","name":"All permission","http_method":[null],"http_path":"*","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_method":"PUT"}	2018-11-30 10:38:09	2018-11-30 10:38:09
2683	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 10:38:10	2018-11-30 10:38:10
2684	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 10:42:08	2018-11-30 10:42:08
2685	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 10:48:01	2018-11-30 10:48:01
2686	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:48:05	2018-11-30 10:48:05
2687	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"5"}	2018-11-30 10:48:15	2018-11-30 10:48:15
2688	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"5"}	2018-11-30 10:48:19	2018-11-30 10:48:19
2689	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"5"}	2018-11-30 10:48:31	2018-11-30 10:48:31
2690	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"5"}	2018-11-30 10:49:18	2018-11-30 10:49:18
2691	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:49:18	2018-11-30 10:49:18
2692	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"4"}	2018-11-30 10:49:20	2018-11-30 10:49:20
2693	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:49:21	2018-11-30 10:49:21
2694	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"3"}	2018-11-30 10:49:22	2018-11-30 10:49:22
2695	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:49:23	2018-11-30 10:49:23
2696	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"1"}	2018-11-30 10:49:26	2018-11-30 10:49:26
2697	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:49:26	2018-11-30 10:49:26
2698	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 10:49:31	2018-11-30 10:49:31
2699	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"5"}	2018-11-30 10:51:33	2018-11-30 10:51:33
2700	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:51:34	2018-11-30 10:51:34
2701	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"4"}	2018-11-30 10:51:35	2018-11-30 10:51:35
2702	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:51:35	2018-11-30 10:51:35
2703	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"3"}	2018-11-30 10:51:36	2018-11-30 10:51:36
2704	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:51:36	2018-11-30 10:51:36
2705	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"2"}	2018-11-30 10:51:37	2018-11-30 10:51:37
2706	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"1"}	2018-11-30 10:51:39	2018-11-30 10:51:39
2707	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:51:39	2018-11-30 10:51:39
2708	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"2"}	2018-11-30 10:51:41	2018-11-30 10:51:41
2709	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 10:51:44	2018-11-30 10:51:44
2710	1	admin/auth/permissions	GET	192.168.10.1	{"page":"2","_pjax":"#pjax-container"}	2018-11-30 10:51:57	2018-11-30 10:51:57
2711	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"5"}	2018-11-30 10:54:54	2018-11-30 10:54:54
2712	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:54:54	2018-11-30 10:54:54
2713	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"4"}	2018-11-30 10:54:55	2018-11-30 10:54:55
2714	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:54:55	2018-11-30 10:54:55
2715	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"3"}	2018-11-30 10:54:56	2018-11-30 10:54:56
2716	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:54:56	2018-11-30 10:54:56
2717	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"1"}	2018-11-30 10:55:01	2018-11-30 10:55:01
2718	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:55:01	2018-11-30 10:55:01
2719	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"2"}	2018-11-30 10:55:02	2018-11-30 10:55:02
2720	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"2"}	2018-11-30 10:55:06	2018-11-30 10:55:06
2721	1	admin/modules	GET	192.168.10.1	[]	2018-11-30 10:57:13	2018-11-30 10:57:13
2722	1	admin/modules/install	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","id":"2"}	2018-11-30 10:57:55	2018-11-30 10:57:55
2723	1	admin/modules	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 10:57:56	2018-11-30 10:57:56
2724	1	admin/auth/permissions	GET	192.168.10.1	{"page":"2"}	2018-11-30 10:57:59	2018-11-30 10:57:59
2725	1	admin/auth/permissions	GET	192.168.10.1	{"page":"2"}	2018-11-30 10:58:32	2018-11-30 10:58:32
2726	1	admin/auth/permissions	GET	192.168.10.1	{"page":"2"}	2018-11-30 10:59:08	2018-11-30 10:59:08
2727	1	admin/auth/permissions	GET	192.168.10.1	{"id":null,"cat_id":"32","_pjax":"#pjax-container"}	2018-11-30 10:59:16	2018-11-30 10:59:16
2728	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container","id":null,"cat_id":"33"}	2018-11-30 10:59:23	2018-11-30 10:59:23
2729	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container","id":null,"cat_id":"34"}	2018-11-30 10:59:27	2018-11-30 10:59:27
2730	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container","id":null,"cat_id":"35"}	2018-11-30 10:59:34	2018-11-30 10:59:34
2731	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container","id":null,"cat_id":"1"}	2018-11-30 10:59:38	2018-11-30 10:59:38
2732	1	admin/auth/permissions	GET	192.168.10.1	{"id":null,"cat_id":"1"}	2018-11-30 11:00:29	2018-11-30 11:00:29
2733	1	admin/auth/permissions	GET	192.168.10.1	{"id":null,"cat_id":"1"}	2018-11-30 11:00:56	2018-11-30 11:00:56
2734	1	admin/auth/permissions	GET	192.168.10.1	{"id":null,"cat_id":"0","_pjax":"#pjax-container"}	2018-11-30 11:01:00	2018-11-30 11:01:00
2735	1	admin/auth/permissions	GET	192.168.10.1	{"id":null,"cat_id":"0"}	2018-11-30 11:01:08	2018-11-30 11:01:08
2736	1	admin/auth/permissions	GET	192.168.10.1	{"id":null,"cat_id":null,"_pjax":"#pjax-container"}	2018-11-30 11:01:21	2018-11-30 11:01:21
2737	1	admin/auth/permissions	GET	192.168.10.1	{"id":null,"cat_id":null}	2018-11-30 11:05:42	2018-11-30 11:05:42
2738	1	admin/auth/permissions	GET	192.168.10.1	{"id":null,"cat_id":null}	2018-11-30 11:05:55	2018-11-30 11:05:55
2739	1	admin/auth/permissions	GET	192.168.10.1	{"id":null,"cat_id":"0","_pjax":"#pjax-container"}	2018-11-30 11:06:01	2018-11-30 11:06:01
2740	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container","id":null,"cat_id":"1"}	2018-11-30 11:06:04	2018-11-30 11:06:04
2741	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container","id":null,"cat_id":"31"}	2018-11-30 11:06:07	2018-11-30 11:06:07
2742	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container","id":null,"cat_id":"0"}	2018-11-30 11:06:10	2018-11-30 11:06:10
2743	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:13:29	2018-11-30 11:13:29
2744	1	admin/auth/menu	GET	192.168.10.1	[]	2018-11-30 11:16:31	2018-11-30 11:16:31
2745	1	admin/auth/menu	GET	192.168.10.1	[]	2018-11-30 11:18:05	2018-11-30 11:18:05
2746	1	admin/auth/menu	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_order":"[{\\"id\\":1},{\\"id\\":41,\\"children\\":[{\\"id\\":42}]},{\\"id\\":39,\\"children\\":[{\\"id\\":40}]},{\\"id\\":34,\\"children\\":[{\\"id\\":35}]},{\\"id\\":24},{\\"id\\":21,\\"children\\":[{\\"id\\":36},{\\"id\\":37},{\\"id\\":38}]},{\\"id\\":17},{\\"id\\":2,\\"children\\":[{\\"id\\":3},{\\"id\\":4},{\\"id\\":6},{\\"id\\":7},{\\"id\\":46,\\"children\\":[{\\"id\\":5}]}]},{\\"id\\":25},{\\"id\\":19},{\\"id\\":18},{\\"id\\":16},{\\"id\\":9,\\"children\\":[{\\"id\\":10},{\\"id\\":11},{\\"id\\":12},{\\"id\\":13}]},{\\"id\\":8},{\\"id\\":14},{\\"id\\":43,\\"children\\":[{\\"id\\":44}]},{\\"id\\":15},{\\"id\\":45}]"}	2018-11-30 11:18:49	2018-11-30 11:18:49
2747	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:18:50	2018-11-30 11:18:50
2748	1	admin/auth/menu/34/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:18:54	2018-11-30 11:18:54
2749	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:18:58	2018-11-30 11:18:58
2750	1	admin/auth/menu/46/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:19:04	2018-11-30 11:19:04
2751	1	admin/auth/menu/46	PUT	192.168.10.1	{"parent_id":"2","title":"Permission","icon":"fa-ban","uri":null,"roles":["1",null],"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/menu"}	2018-11-30 11:19:12	2018-11-30 11:19:12
2752	1	admin/auth/menu	GET	192.168.10.1	[]	2018-11-30 11:19:13	2018-11-30 11:19:13
2753	1	admin/auth/menu	GET	192.168.10.1	[]	2018-11-30 11:19:19	2018-11-30 11:19:19
2754	1	admin/auth/menu	POST	192.168.10.1	{"parent_id":"46","title":"Permission Categories","icon":"fa-clone","uri":null,"roles":["1",null],"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77"}	2018-11-30 11:20:23	2018-11-30 11:20:23
2755	1	admin/auth/menu	GET	192.168.10.1	[]	2018-11-30 11:20:24	2018-11-30 11:20:24
2756	1	admin/auth/menu	GET	192.168.10.1	[]	2018-11-30 11:20:35	2018-11-30 11:20:35
2757	1	admin/auth/menu/47/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:20:45	2018-11-30 11:20:45
2758	1	admin/auth/menu/47	PUT	192.168.10.1	{"parent_id":"46","title":"Permission Categories","icon":"fa-clone","uri":"\\/admin\\/auth\\/permissions-cat","roles":["1",null],"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/menu"}	2018-11-30 11:21:27	2018-11-30 11:21:27
2759	1	admin/auth/menu	GET	192.168.10.1	[]	2018-11-30 11:21:29	2018-11-30 11:21:29
2760	1	admin/auth/menu	GET	192.168.10.1	[]	2018-11-30 11:21:33	2018-11-30 11:21:33
2761	1	admin/auth/menu	POST	192.168.10.1	{"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_order":"[{\\"id\\":1},{\\"id\\":41,\\"children\\":[{\\"id\\":42}]},{\\"id\\":39,\\"children\\":[{\\"id\\":40}]},{\\"id\\":34,\\"children\\":[{\\"id\\":35}]},{\\"id\\":24},{\\"id\\":21,\\"children\\":[{\\"id\\":36},{\\"id\\":37},{\\"id\\":38}]},{\\"id\\":17},{\\"id\\":2,\\"children\\":[{\\"id\\":3},{\\"id\\":4},{\\"id\\":6},{\\"id\\":7},{\\"id\\":46,\\"children\\":[{\\"id\\":47},{\\"id\\":5}]}]},{\\"id\\":25},{\\"id\\":19},{\\"id\\":18},{\\"id\\":16},{\\"id\\":9,\\"children\\":[{\\"id\\":10},{\\"id\\":11},{\\"id\\":12},{\\"id\\":13}]},{\\"id\\":8},{\\"id\\":14},{\\"id\\":43,\\"children\\":[{\\"id\\":44}]},{\\"id\\":15},{\\"id\\":45}]"}	2018-11-30 11:21:51	2018-11-30 11:21:51
2762	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:21:51	2018-11-30 11:21:51
2763	1	admin/auth/menu	GET	192.168.10.1	[]	2018-11-30 11:21:54	2018-11-30 11:21:54
2764	1	admin/auth/menu	GET	192.168.10.1	[]	2018-11-30 11:22:08	2018-11-30 11:22:08
2765	1	admin/auth/menu/47/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:22:14	2018-11-30 11:22:14
2766	1	admin/auth/menu/47	PUT	192.168.10.1	{"parent_id":"46","title":"Permission Categories","icon":"fa-clone","uri":"\\/auth\\/permissions-cat","roles":["1",null],"_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/menu"}	2018-11-30 11:22:21	2018-11-30 11:22:21
2767	1	admin/auth/menu	GET	192.168.10.1	[]	2018-11-30 11:22:22	2018-11-30 11:22:22
2768	1	admin/auth/menu	GET	192.168.10.1	[]	2018-11-30 11:22:29	2018-11-30 11:22:29
2769	1	admin/auth/permissions-cat	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:22:36	2018-11-30 11:22:36
2770	1	admin/auth/permissions-cat/35	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:22:43	2018-11-30 11:22:43
2771	1	admin/auth/permissions-cat	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:22:46	2018-11-30 11:22:46
2772	1	admin/auth/permissions-cat	GET	192.168.10.1	[]	2018-11-30 11:23:37	2018-11-30 11:23:37
2773	1	admin/auth/permissions-cat	GET	192.168.10.1	[]	2018-11-30 11:23:50	2018-11-30 11:23:50
2774	1	admin/auth/permissions-cat	GET	192.168.10.1	[]	2018-11-30 11:24:18	2018-11-30 11:24:18
2775	1	admin/auth/permissions-cat/1/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:24:27	2018-11-30 11:24:27
2776	1	admin/auth/permissions-cat/1	PUT	192.168.10.1	{"name":"General","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/permissions-cat"}	2018-11-30 11:24:31	2018-11-30 11:24:31
2777	1	admin/auth/permissions-cat	GET	192.168.10.1	[]	2018-11-30 11:24:32	2018-11-30 11:24:32
2778	1	admin/auth/permissions-cat	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:24:43	2018-11-30 11:24:43
2779	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:24:48	2018-11-30 11:24:48
2780	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:25:02	2018-11-30 11:25:02
2781	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:48:19	2018-11-30 11:48:19
2782	1	admin/config	GET	192.168.10.1	[]	2018-11-30 11:48:58	2018-11-30 11:48:58
2783	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:49:10	2018-11-30 11:49:10
2784	1	admin/config	GET	192.168.10.1	[]	2018-11-30 11:49:13	2018-11-30 11:49:13
2785	1	admin/config	GET	192.168.10.1	[]	2018-11-30 11:49:55	2018-11-30 11:49:55
2786	1	admin/config	GET	192.168.10.1	[]	2018-11-30 11:50:31	2018-11-30 11:50:31
2787	1	admin/config	GET	192.168.10.1	[]	2018-11-30 11:50:45	2018-11-30 11:50:45
2788	1	admin/config/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:50:55	2018-11-30 11:50:55
2789	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:51:30	2018-11-30 11:51:30
2790	1	admin/config/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:51:52	2018-11-30 11:51:52
2791	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:52:00	2018-11-30 11:52:00
2792	1	admin/config/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 11:54:53	2018-11-30 11:54:53
2793	1	admin/config/2/edit	GET	192.168.10.1	[]	2018-11-30 12:00:01	2018-11-30 12:00:01
2794	1	admin/config/2	PUT	192.168.10.1	{"category":null,"name":"enable_log","value":"1","description":"\\u0412\\u043a\\u043b\\u044e\\u0447\\u0430\\u0435\\u0442 \\u043b\\u043e\\u0433\\u0438\\u0440\\u043e\\u0432\\u0430\\u043d\\u0438\\u0435","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/config"}	2018-11-30 12:00:15	2018-11-30 12:00:15
2795	1	admin/config/2/edit	GET	192.168.10.1	[]	2018-11-30 12:00:16	2018-11-30 12:00:16
2796	1	admin/config/2	PUT	192.168.10.1	{"category":"general","name":"enable_log","value":"1","description":"\\u0412\\u043a\\u043b\\u044e\\u0447\\u0430\\u0435\\u0442 \\u043b\\u043e\\u0433\\u0438\\u0440\\u043e\\u0432\\u0430\\u043d\\u0438\\u0435","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_method":"PUT"}	2018-11-30 12:00:21	2018-11-30 12:00:21
2797	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:00:22	2018-11-30 12:00:22
2798	1	admin/config/2/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 12:00:25	2018-11-30 12:00:25
2799	1	admin/config/2	PUT	192.168.10.1	{"category":"system","name":"enable_log","value":"1","description":"\\u0412\\u043a\\u043b\\u044e\\u0447\\u0430\\u0435\\u0442 \\u043b\\u043e\\u0433\\u0438\\u0440\\u043e\\u0432\\u0430\\u043d\\u0438\\u0435","_token":"pwzlByjXZ4CFJzKMOR1XZrba9UY1GBy4K8cvCz77","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/config"}	2018-11-30 12:00:30	2018-11-30 12:00:30
2800	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:00:30	2018-11-30 12:00:30
2801	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:01:18	2018-11-30 12:01:18
2802	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:01:52	2018-11-30 12:01:52
2803	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:02:07	2018-11-30 12:02:07
2804	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:03:44	2018-11-30 12:03:44
2805	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general","_pjax":"#pjax-container"}	2018-11-30 12:03:50	2018-11-30 12:03:50
2806	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container","name":null,"value":null,"category":"system"}	2018-11-30 12:03:53	2018-11-30 12:03:53
2807	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container","name":null,"value":null,"category":"0"}	2018-11-30 12:03:56	2018-11-30 12:03:56
2808	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"0"}	2018-11-30 12:04:12	2018-11-30 12:04:12
2809	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general","_pjax":"#pjax-container"}	2018-11-30 12:04:15	2018-11-30 12:04:15
2810	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container","name":null,"value":null,"category":"general"}	2018-11-30 12:04:19	2018-11-30 12:04:19
2811	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container","name":null,"value":null,"category":"0"}	2018-11-30 12:04:21	2018-11-30 12:04:21
2812	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container","name":null,"value":null,"category":"general"}	2018-11-30 12:04:47	2018-11-30 12:04:47
2813	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container","name":null,"value":null,"category":"system"}	2018-11-30 12:04:50	2018-11-30 12:04:50
2814	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container","name":null,"value":null,"category":"0"}	2018-11-30 12:04:53	2018-11-30 12:04:53
2815	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 12:05:35	2018-11-30 12:05:35
2816	1	admin/auth/permissions-cat	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 12:06:06	2018-11-30 12:06:06
2817	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 12:06:10	2018-11-30 12:06:10
2818	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 12:06:58	2018-11-30 12:06:58
2819	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 12:07:07	2018-11-30 12:07:07
2820	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container","page":"2"}	2018-11-30 12:08:14	2018-11-30 12:08:14
2821	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container","id":null,"cat_id":"1"}	2018-11-30 12:13:52	2018-11-30 12:13:52
2822	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 12:34:17	2018-11-30 12:34:17
2823	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 12:34:18	2018-11-30 12:34:18
2824	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 12:34:34	2018-11-30 12:34:34
2825	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 12:34:37	2018-11-30 12:34:37
2826	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:36:46	2018-11-30 12:36:46
2827	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:52:56	2018-11-30 12:52:56
2828	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:53:20	2018-11-30 12:53:20
2829	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:54:29	2018-11-30 12:54:29
2830	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:57:20	2018-11-30 12:57:20
2831	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:57:33	2018-11-30 12:57:33
2832	1	admin/config	GET	192.168.10.1	[]	2018-11-30 12:58:26	2018-11-30 12:58:26
2833	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general","_pjax":"#pjax-container"}	2018-11-30 12:59:01	2018-11-30 12:59:01
2834	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general"}	2018-11-30 13:00:27	2018-11-30 13:00:27
2835	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general"}	2018-11-30 13:43:54	2018-11-30 13:43:54
2836	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general"}	2018-11-30 13:45:22	2018-11-30 13:45:22
2837	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general"}	2018-11-30 13:45:35	2018-11-30 13:45:35
2838	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general"}	2018-11-30 13:50:47	2018-11-30 13:50:47
2839	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general"}	2018-11-30 13:50:57	2018-11-30 13:50:57
2840	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general"}	2018-11-30 13:51:14	2018-11-30 13:51:14
2841	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general"}	2018-11-30 13:51:27	2018-11-30 13:51:27
2842	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general"}	2018-11-30 13:53:55	2018-11-30 13:53:55
2843	1	admin/config	GET	192.168.10.1	{"name":null,"value":null,"category":"general"}	2018-11-30 13:54:29	2018-11-30 13:54:29
2844	1	admin/config	GET	192.168.10.1	{"category":"0","_pjax":"#pjax-container"}	2018-11-30 13:54:33	2018-11-30 13:54:33
2845	1	admin/config	GET	192.168.10.1	{"category":"0"}	2018-11-30 13:58:56	2018-11-30 13:58:56
2846	1	admin/config	GET	192.168.10.1	{"category":"0"}	2018-11-30 14:00:17	2018-11-30 14:00:17
2847	1	admin/config	GET	192.168.10.1	{"category":"0"}	2018-11-30 14:00:44	2018-11-30 14:00:44
2848	1	admin/config	GET	192.168.10.1	{"category":"0"}	2018-11-30 14:01:26	2018-11-30 14:01:26
2849	1	admin/config	GET	192.168.10.1	{"category":"general","_pjax":"#pjax-container"}	2018-11-30 14:01:29	2018-11-30 14:01:29
2850	1	admin/config	GET	192.168.10.1	{"category":"general"}	2018-11-30 14:01:41	2018-11-30 14:01:41
2851	1	admin/config	GET	192.168.10.1	{"category":"system","_pjax":"#pjax-container"}	2018-11-30 14:01:43	2018-11-30 14:01:43
2852	1	admin/config	GET	192.168.10.1	{"category":"0","_pjax":"#pjax-container"}	2018-11-30 14:01:45	2018-11-30 14:01:45
2853	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:01:56	2018-11-30 14:01:56
2854	1	admin/config	GET	192.168.10.1	{"category":"0"}	2018-11-30 14:01:57	2018-11-30 14:01:57
2855	1	admin/config	GET	192.168.10.1	{"category":"0"}	2018-11-30 14:02:56	2018-11-30 14:02:56
2856	1	admin/config	GET	192.168.10.1	{"category":"0"}	2018-11-30 14:03:19	2018-11-30 14:03:19
2857	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:03:30	2018-11-30 14:03:30
2858	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 14:04:19	2018-11-30 14:04:19
2859	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 14:04:46	2018-11-30 14:04:46
2860	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 14:05:32	2018-11-30 14:05:32
2861	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"31","_pjax":"#pjax-container"}	2018-11-30 14:05:40	2018-11-30 14:05:40
2862	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"32","_pjax":"#pjax-container"}	2018-11-30 14:05:43	2018-11-30 14:05:43
2863	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"33","_pjax":"#pjax-container"}	2018-11-30 14:05:44	2018-11-30 14:05:44
2864	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"0","_pjax":"#pjax-container"}	2018-11-30 14:05:46	2018-11-30 14:05:46
2865	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"1","_pjax":"#pjax-container"}	2018-11-30 14:05:53	2018-11-30 14:05:53
2866	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"31","_pjax":"#pjax-container"}	2018-11-30 14:05:55	2018-11-30 14:05:55
2867	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"32","_pjax":"#pjax-container"}	2018-11-30 14:05:56	2018-11-30 14:05:56
2868	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"33","_pjax":"#pjax-container"}	2018-11-30 14:05:58	2018-11-30 14:05:58
2869	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"34","_pjax":"#pjax-container"}	2018-11-30 14:05:59	2018-11-30 14:05:59
2870	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"0","_pjax":"#pjax-container"}	2018-11-30 14:06:00	2018-11-30 14:06:00
2871	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"1","_pjax":"#pjax-container"}	2018-11-30 14:06:09	2018-11-30 14:06:09
2872	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"31","_pjax":"#pjax-container"}	2018-11-30 14:06:11	2018-11-30 14:06:11
2873	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"32","_pjax":"#pjax-container"}	2018-11-30 14:06:12	2018-11-30 14:06:12
2874	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"33","_pjax":"#pjax-container"}	2018-11-30 14:06:13	2018-11-30 14:06:13
2875	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"33"}	2018-11-30 14:06:31	2018-11-30 14:06:31
2876	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"33"}	2018-11-30 14:06:34	2018-11-30 14:06:34
2877	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"0","_pjax":"#pjax-container"}	2018-11-30 14:06:35	2018-11-30 14:06:35
2878	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"0","_pjax":"#pjax-container"}	2018-11-30 14:07:00	2018-11-30 14:07:00
2879	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:07:02	2018-11-30 14:07:02
2880	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 14:08:15	2018-11-30 14:08:15
2881	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 14:08:34	2018-11-30 14:08:34
2882	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"31","_pjax":"#pjax-container"}	2018-11-30 14:08:39	2018-11-30 14:08:39
2883	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"31"}	2018-11-30 14:09:06	2018-11-30 14:09:06
2884	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:09:09	2018-11-30 14:09:09
2885	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:09:16	2018-11-30 14:09:16
2886	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:09:28	2018-11-30 14:09:28
2887	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:09:46	2018-11-30 14:09:46
2888	1	admin/auth/permissions	GET	192.168.10.1	[]	2018-11-30 14:10:54	2018-11-30 14:10:54
2889	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:11:05	2018-11-30 14:11:05
2890	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:11:50	2018-11-30 14:11:50
2891	1	admin/config	GET	192.168.10.1	[]	2018-11-30 14:12:46	2018-11-30 14:12:46
2892	1	admin/config	GET	192.168.10.1	{"category":"general","_pjax":"#pjax-container"}	2018-11-30 14:12:48	2018-11-30 14:12:48
2893	1	admin/config	GET	192.168.10.1	{"category":"system","_pjax":"#pjax-container"}	2018-11-30 14:12:51	2018-11-30 14:12:51
2894	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:12:53	2018-11-30 14:12:53
2895	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:12:59	2018-11-30 14:12:59
2896	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"1","_pjax":"#pjax-container"}	2018-11-30 14:13:02	2018-11-30 14:13:02
2897	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"1","_pjax":"#pjax-container"}	2018-11-30 14:13:11	2018-11-30 14:13:11
2898	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"1"}	2018-11-30 14:14:16	2018-11-30 14:14:16
2899	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"1","_pjax":"#pjax-container"}	2018-11-30 14:14:20	2018-11-30 14:14:20
2900	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"1"}	2018-11-30 14:15:44	2018-11-30 14:15:44
2901	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"1","_pjax":"#pjax-container"}	2018-11-30 14:15:46	2018-11-30 14:15:46
2902	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"31","_pjax":"#pjax-container"}	2018-11-30 14:15:51	2018-11-30 14:15:51
2903	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"1","_pjax":"#pjax-container"}	2018-11-30 14:15:52	2018-11-30 14:15:52
2904	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:15:55	2018-11-30 14:15:55
2905	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"1","_pjax":"#pjax-container"}	2018-11-30 14:15:57	2018-11-30 14:15:57
2906	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"1"}	2018-11-30 14:17:02	2018-11-30 14:17:02
2907	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"31","_pjax":"#pjax-container"}	2018-11-30 14:17:05	2018-11-30 14:17:05
2908	1	admin/auth/permissions	GET	192.168.10.1	{"cat_id":"32","_pjax":"#pjax-container"}	2018-11-30 14:17:06	2018-11-30 14:17:06
2909	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:17:08	2018-11-30 14:17:08
2910	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:17:15	2018-11-30 14:17:15
2911	1	admin/config	GET	192.168.10.1	{"category":"general","_pjax":"#pjax-container"}	2018-11-30 14:17:17	2018-11-30 14:17:17
2912	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:17:19	2018-11-30 14:17:19
2913	1	admin/config	GET	192.168.10.1	[]	2018-11-30 14:26:25	2018-11-30 14:26:25
2914	1	admin/auth/permissions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:26:35	2018-11-30 14:26:35
2915	1	admin	GET	192.168.10.1	[]	2018-11-30 14:40:49	2018-11-30 14:40:49
2916	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:40:57	2018-11-30 14:40:57
2917	1	admin/auth/menu/41/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-11-30 14:41:04	2018-11-30 14:41:04
2918	1	admin	GET	192.168.10.1	[]	2018-12-03 07:32:23	2018-12-03 07:32:23
2919	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 07:32:32	2018-12-03 07:32:32
2920	1	admin/auth/menu	GET	192.168.10.1	[]	2018-12-03 07:33:52	2018-12-03 07:33:52
2921	1	admin/auth/menu	GET	192.168.10.1	[]	2018-12-03 07:43:54	2018-12-03 07:43:54
2922	1	admin/auth/menu	GET	192.168.10.1	[]	2018-12-03 07:44:54	2018-12-03 07:44:54
2923	1	admin/auth/menu	GET	192.168.10.1	[]	2018-12-03 07:45:46	2018-12-03 07:45:46
2924	1	admin/auth/menu/41/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 07:45:53	2018-12-03 07:45:53
2925	1	admin/auth/menu/41/edit	GET	192.168.10.1	[]	2018-12-03 07:46:21	2018-12-03 07:46:21
2926	1	admin/news	GET	192.168.10.1	[]	2018-12-03 07:46:56	2018-12-03 07:46:56
2927	1	admin/news	GET	192.168.10.1	[]	2018-12-03 07:54:19	2018-12-03 07:54:19
2928	1	admin/news	GET	192.168.10.1	[]	2018-12-03 07:54:39	2018-12-03 07:54:39
2929	1	admin/news	GET	192.168.10.1	[]	2018-12-03 07:54:52	2018-12-03 07:54:52
2930	1	admin/news	GET	192.168.10.1	[]	2018-12-03 07:54:55	2018-12-03 07:54:55
2931	1	admin/news	GET	192.168.10.1	[]	2018-12-03 07:55:20	2018-12-03 07:55:20
2932	1	admin/news	GET	192.168.10.1	[]	2018-12-03 07:55:29	2018-12-03 07:55:29
2933	1	admin/news	GET	192.168.10.1	[]	2018-12-03 10:58:33	2018-12-03 10:58:33
2934	1	admin/news	GET	192.168.10.1	[]	2018-12-03 11:00:39	2018-12-03 11:00:39
2935	1	admin/news	GET	192.168.10.1	[]	2018-12-03 11:01:17	2018-12-03 11:01:17
2936	1	admin/news	GET	192.168.10.1	[]	2018-12-03 11:04:05	2018-12-03 11:04:05
2937	1	admin/news	GET	192.168.10.1	[]	2018-12-03 11:04:51	2018-12-03 11:04:51
2938	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:05:03	2018-12-03 11:05:03
2939	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:05:07	2018-12-03 11:05:07
2940	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:05:17	2018-12-03 11:05:17
2941	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:05:19	2018-12-03 11:05:19
2942	1	admin/news/3/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:05:22	2018-12-03 11:05:22
2943	1	admin/images/news/3/100/tJ-rozy_butony_rozovyj_123260_1600x1200.jpg	GET	192.168.10.1	[]	2018-12-03 11:05:24	2018-12-03 11:05:24
2944	1	admin/images/news/3/100/CI-SPCQJAdT2pg.jpg	GET	192.168.10.1	[]	2018-12-03 11:05:24	2018-12-03 11:05:24
2945	1	admin/auth/menu/41/edit	GET	192.168.10.1	[]	2018-12-03 11:11:09	2018-12-03 11:11:09
2946	1	admin/auth/menu/41/edit	GET	192.168.10.1	[]	2018-12-03 11:12:15	2018-12-03 11:12:15
2947	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:12:42	2018-12-03 11:12:42
2948	1	admin/auth/menu/21/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:12:48	2018-12-03 11:12:48
2949	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:12:55	2018-12-03 11:12:55
2950	1	admin/auth/menu/39/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:13:00	2018-12-03 11:13:00
2951	1	admin/auth/menu/39	PUT	192.168.10.1	{"parent_id":"0","title":"\\u041d\\u043e\\u0432\\u043e\\u0441\\u0442\\u0438","icon":"fa-newspaper-o","icon_color":"#a83122","uri":null,"roles":[null],"_token":"xmS8pHjZ66o90pTR4dwHN3fsE13jPzZ8xnPfqGCN","_method":"PUT","_previous_":"http:\\/\\/laravel-admin.dev\\/admin\\/auth\\/menu"}	2018-12-03 11:13:13	2018-12-03 11:13:13
2952	1	admin/auth/menu	GET	192.168.10.1	[]	2018-12-03 11:13:13	2018-12-03 11:13:13
2953	1	admin/auth/menu/39/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:13:19	2018-12-03 11:13:19
2954	1	admin/auth/menu/39/edit	GET	192.168.10.1	[]	2018-12-03 11:13:21	2018-12-03 11:13:21
2955	1	admin	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:13:37	2018-12-03 11:13:37
2956	1	admin/media	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:14:01	2018-12-03 11:14:01
2957	1	admin/media	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:14:07	2018-12-03 11:14:07
2958	1	admin	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:14:11	2018-12-03 11:14:11
2959	1	admin/auth/users	GET	192.168.10.1	[]	2018-12-03 11:24:09	2018-12-03 11:24:09
2960	1	admin/auth/users/1	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:24:13	2018-12-03 11:24:13
2961	1	admin/auth/users/1/edit	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:24:21	2018-12-03 11:24:21
2962	1	admin/auth/users/1/edit	GET	192.168.10.1	[]	2018-12-03 11:24:38	2018-12-03 11:24:38
2963	1	admin	GET	192.168.10.1	[]	2018-12-03 11:26:25	2018-12-03 11:26:25
2964	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:26:38	2018-12-03 11:26:38
2965	1	admin/auth/menu/50	DELETE	192.168.10.1	{"_method":"delete","_token":"xmS8pHjZ66o90pTR4dwHN3fsE13jPzZ8xnPfqGCN"}	2018-12-03 11:26:46	2018-12-03 11:26:46
2966	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:26:47	2018-12-03 11:26:47
2967	1	admin/auth/menu/49	DELETE	192.168.10.1	{"_method":"delete","_token":"xmS8pHjZ66o90pTR4dwHN3fsE13jPzZ8xnPfqGCN"}	2018-12-03 11:26:50	2018-12-03 11:26:50
2968	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:26:51	2018-12-03 11:26:51
2969	1	admin/composer-viewer	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:26:58	2018-12-03 11:26:58
2970	1	admin/composer-viewer	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:27:00	2018-12-03 11:27:00
2971	1	admin/env-manager	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:27:20	2018-12-03 11:27:20
2972	1	admin/env-manager	GET	192.168.10.1	[]	2018-12-03 11:27:23	2018-12-03 11:27:23
2973	1	admin/news	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:27:36	2018-12-03 11:27:36
2974	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:28:06	2018-12-03 11:28:06
2975	1	admin/auth/menu/44	DELETE	192.168.10.1	{"_method":"delete","_token":"xmS8pHjZ66o90pTR4dwHN3fsE13jPzZ8xnPfqGCN"}	2018-12-03 11:28:15	2018-12-03 11:28:15
2976	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:28:16	2018-12-03 11:28:16
2977	1	admin/auth/menu/43	DELETE	192.168.10.1	{"_method":"delete","_token":"xmS8pHjZ66o90pTR4dwHN3fsE13jPzZ8xnPfqGCN"}	2018-12-03 11:28:21	2018-12-03 11:28:21
2978	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:28:21	2018-12-03 11:28:21
2979	1	admin/auth/menu	GET	192.168.10.1	[]	2018-12-03 11:28:24	2018-12-03 11:28:24
2980	1	admin/exceptions	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:29:25	2018-12-03 11:29:25
2981	1	admin/scheduling	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:29:38	2018-12-03 11:29:38
2982	1	admin/seo	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:29:47	2018-12-03 11:29:47
2983	1	admin/auth/menu	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:29:50	2018-12-03 11:29:50
2984	1	admin	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:30:00	2018-12-03 11:30:00
2985	1	admin	GET	192.168.10.1	[]	2018-12-03 11:30:15	2018-12-03 11:30:15
2986	1	admin	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:30:29	2018-12-03 11:30:29
2987	1	admin/config	GET	192.168.10.1	{"_pjax":"#pjax-container"}	2018-12-03 11:30:39	2018-12-03 11:30:39
\.


--
-- TOC entry 2495 (class 0 OID 0)
-- Dependencies: 186
-- Name: admin_operation_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('admin_operation_log_id_seq', 2987, true);


--
-- TOC entry 2423 (class 0 OID 26765)
-- Dependencies: 187
-- Data for Name: admin_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY admin_permissions (id, name, slug, http_method, http_path, created_at, updated_at, cat_id) FROM stdin;
1	All permission	*		*	\N	\N	1
2	Dashboard	dashboard	GET	/	\N	\N	1
3	Login	auth.login		/auth/login\r\n/auth/logout	\N	\N	1
4	User setting	auth.setting	GET,PUT	/auth/setting	\N	\N	1
5	Auth management	auth.management		/auth/roles\r\n/auth/permissions\r\n/auth/menu\r\n/auth/logs	\N	\N	1
6	Logs	ext.log-viewer	\N	/logs*	2017-11-30 10:21:22	2017-11-30 10:21:22	1
7	Admin helpers	ext.helpers	\N	/helpers/*	2017-11-30 10:23:07	2017-11-30 10:23:07	1
8	Exceptions reporter	ext.reporter	\N	/exceptions*	2017-11-30 10:24:43	2017-11-30 10:24:43	1
9	Media manager	ext.media-manager	\N	/media*	2017-11-30 10:28:30	2017-11-30 10:28:30	1
10	Backup	ext.backup	\N	/backup*	2017-11-30 10:30:04	2017-11-30 10:30:04	1
11	Admin Config	ext.config	\N	/config*	2017-11-30 10:35:51	2017-11-30 10:35:51	1
12	Api tester	ext.api-tester	\N	/api-tester*	2017-11-30 10:37:24	2017-11-30 10:37:24	1
13	Scheduling	ext.scheduling	\N	/scheduling*	2017-11-30 10:38:38	2017-11-30 10:38:38	1
60	Изображения-Изображения-delete	images.news.delete	\N	/news*	2018-10-02 10:59:52	2018-11-30 10:54:54	31
35	Мультиязычность-Языки-read	langs.langs.read	\N	/langs*	2018-01-19 12:55:34	2018-11-30 10:55:01	34
36	Мультиязычность-Языки-update	langs.langs.update	\N	/langs*	2018-01-19 12:55:34	2018-11-30 10:55:01	34
37	Мультиязычность-Языки-delete	langs.langs.delete	\N	/langs*	2018-01-19 12:55:34	2018-11-30 10:55:01	34
51	SEO	seo.index	\N	/seo*	2018-10-01 08:59:44	2018-11-30 10:54:55	32
52	SEO-SEO-create	seo.seo.create	\N	/seo*	2018-10-01 08:59:44	2018-11-30 10:54:55	32
53	SEO-SEO-read	seo.seo.read	\N	/seo*	2018-10-01 08:59:44	2018-11-30 10:54:55	32
38	Мультиязычность-Метки-create	langs.langs_labels.create	\N	/langs_labels*	2018-01-19 12:55:34	2018-11-30 10:55:01	34
39	Мультиязычность-Метки-read	langs.langs_labels.read	\N	/langs_labels*	2018-01-19 12:55:34	2018-11-30 10:55:01	34
40	Мультиязычность-Метки-update	langs.langs_labels.update	\N	/langs_labels*	2018-01-19 12:55:34	2018-11-30 10:55:01	34
41	Мультиязычность-Метки-delete	langs.langs_labels.delete	\N	/langs_labels*	2018-01-19 12:55:34	2018-11-30 10:55:01	34
42	Мультиязычность-Категории меток-create	langs.langs_cats.create	\N	/langs_cats*	2018-01-19 12:55:35	2018-11-30 10:55:01	34
43	Мультиязычность-Категории меток-read	langs.langs_cats.read	\N	/langs_cats*	2018-01-19 12:55:35	2018-11-30 10:55:01	34
44	Мультиязычность-Категории меток-update	langs.langs_cats.update	\N	/langs_cats*	2018-01-19 12:55:35	2018-11-30 10:55:01	34
45	Мультиязычность-Категории меток-delete	langs.langs_cats.delete	\N	/langs_cats*	2018-01-19 12:55:35	2018-11-30 10:55:01	34
28	Модули	modules.index	\N	/modules*	2018-01-19 12:48:15	2018-11-30 10:55:02	35
29	Модули-Модули-create	modules.modules.create	\N	/modules*	2018-01-19 12:48:15	2018-11-30 10:57:55	35
30	Модули-Модули-read	modules.modules.read	\N	/modules*	2018-01-19 12:48:15	2018-11-30 10:57:55	35
31	Модули-Модули-update	modules.modules.update	\N	/modules*	2018-01-19 12:48:15	2018-11-30 10:57:55	35
32	Модули-Модули-delete	modules.modules.delete	\N	/modules*	2018-01-19 12:48:15	2018-11-30 10:57:55	35
56	Изображения	images.index	\N	/images*	2018-10-02 10:59:52	2018-11-30 10:54:54	31
57	Изображения-Изображения-create	images.news.create	\N	/news*	2018-10-02 10:59:52	2018-11-30 10:54:54	31
58	Изображения-Изображения-read	images.news.read	\N	/news*	2018-10-02 10:59:52	2018-11-30 10:54:54	31
59	Изображения-Изображения-update	images.news.update	\N	/news*	2018-10-02 10:59:52	2018-11-30 10:54:54	31
54	SEO-SEO-update	seo.seo.update	\N	/seo*	2018-10-01 08:59:45	2018-11-30 10:54:55	32
55	SEO-SEO-delete	seo.seo.delete	\N	/seo*	2018-10-01 08:59:45	2018-11-30 10:54:55	32
46	Новости	news.index	\N	/news*	2018-05-18 14:17:41	2018-11-30 10:54:56	33
47	Новости-Новости-create	news.news.create	\N	/news*	2018-05-18 14:17:41	2018-11-30 10:54:56	33
48	Новости-Новости-read	news.news.read	\N	/news*	2018-05-18 14:17:41	2018-11-30 10:54:56	33
49	Новости-Новости-update	news.news.update	\N	/news*	2018-05-18 14:17:41	2018-11-30 10:54:56	33
50	Новости-Новости-delete	news.news.delete	\N	/news*	2018-05-18 14:17:41	2018-11-30 10:54:56	33
33	Мультиязычность	langs.index	\N	/langs*	2018-01-19 12:55:34	2018-11-30 10:55:01	34
34	Мультиязычность-Языки-create	langs.langs.create	\N	/langs*	2018-01-19 12:55:34	2018-11-30 10:55:01	34
\.


--
-- TOC entry 2424 (class 0 OID 26772)
-- Dependencies: 188
-- Data for Name: admin_permissions_categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY admin_permissions_categories (id, name) FROM stdin;
1	General
31	Изображения
32	SEO
33	Новости
34	Мультиязычность
35	Модули
\.


--
-- TOC entry 2496 (class 0 OID 0)
-- Dependencies: 189
-- Name: admin_permissions_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('admin_permissions_categories_id_seq', 35, true);


--
-- TOC entry 2497 (class 0 OID 0)
-- Dependencies: 190
-- Name: admin_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('admin_permissions_id_seq', 63, true);


--
-- TOC entry 2427 (class 0 OID 26779)
-- Dependencies: 191
-- Data for Name: admin_role_menu; Type: TABLE DATA; Schema: public; Owner: -
--

COPY admin_role_menu (role_id, menu_id, created_at, updated_at) FROM stdin;
1	2	\N	\N
1	8	\N	\N
1	9	\N	\N
1	14	\N	\N
1	15	\N	\N
1	16	\N	\N
1	17	\N	\N
1	18	\N	\N
1	19	\N	\N
1	20	\N	\N
1	21	\N	\N
1	22	\N	\N
1	23	\N	\N
2	23	\N	\N
1	24	\N	\N
1	25	\N	\N
1	26	\N	\N
1	27	\N	\N
1	34	\N	\N
1	37	\N	\N
2	37	\N	\N
2	21	\N	\N
1	36	\N	\N
1	38	\N	\N
2	24	\N	\N
1	42	\N	\N
1	41	\N	\N
2	42	\N	\N
2	41	\N	\N
1	46	\N	\N
1	47	\N	\N
\.


--
-- TOC entry 2428 (class 0 OID 26782)
-- Dependencies: 192
-- Data for Name: admin_role_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY admin_role_permissions (role_id, permission_id, created_at, updated_at) FROM stdin;
1	1	\N	\N
2	2	\N	\N
2	3	\N	\N
2	38	\N	\N
2	39	\N	\N
2	40	\N	\N
2	41	\N	\N
2	53	\N	\N
2	55	\N	\N
2	52	\N	\N
2	54	\N	\N
\.


--
-- TOC entry 2429 (class 0 OID 26785)
-- Dependencies: 193
-- Data for Name: admin_role_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY admin_role_users (role_id, user_id, created_at, updated_at) FROM stdin;
1	1	\N	\N
2	2	\N	\N
\.


--
-- TOC entry 2430 (class 0 OID 26788)
-- Dependencies: 194
-- Data for Name: admin_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY admin_roles (id, name, slug, created_at, updated_at) FROM stdin;
1	Administrator	administrator	2017-11-30 09:31:27	2017-11-30 09:31:27
2	moderator	moderator	2017-12-01 12:05:15	2017-12-01 12:05:15
\.


--
-- TOC entry 2498 (class 0 OID 0)
-- Dependencies: 195
-- Name: admin_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('admin_roles_id_seq', 2, true);


--
-- TOC entry 2432 (class 0 OID 26793)
-- Dependencies: 196
-- Data for Name: admin_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY admin_user_permissions (user_id, permission_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2433 (class 0 OID 26796)
-- Dependencies: 197
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY admin_users (id, username, password, name, avatar, remember_token, created_at, updated_at) FROM stdin;
2	moderator	$2y$10$AbkIELGdTblqxll.ZhvgOetgob28i4msfEYxwMOulvmAICfxH3cIS	moderator	\N	83z2Hl4YPWgMGWm8CYMA1CI5yMJ64p5R96p8av1RHN5OYe2isvB89V2p9Yfj	2017-12-01 12:04:35	2017-12-01 12:04:35
1	admin	$2y$10$UCTWqlV5egoJs.dZM41qyeBAHCpM955TAF.nR7ENW20USPjngL8/q	Administrator	images/6a10569ba9baabbb4cd3ab6b42194691.jpg	lCyzpvkSU5xLmaO1UW9VCMGdJTapY2PrUorUYo5KAtztJdQZO8VN84Y3VJ3A	2017-11-30 09:31:27	2018-10-01 08:23:50
\.


--
-- TOC entry 2499 (class 0 OID 0)
-- Dependencies: 198
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('admin_users_id_seq', 2, true);


--
-- TOC entry 2435 (class 0 OID 26804)
-- Dependencies: 199
-- Data for Name: label_cats; Type: TABLE DATA; Schema: public; Owner: -
--

COPY label_cats (id, parent_id, alias, name, ord, state) FROM stdin;
1	0	custom	Общее	1	1
2	1	labels	Надписи	1	1
3	1	subcat1	subcat1	2	1
5	0	site	Сайт	0	1
\.


--
-- TOC entry 2500 (class 0 OID 0)
-- Dependencies: 200
-- Name: label_cats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('label_cats_id_seq', 5, true);


--
-- TOC entry 2437 (class 0 OID 26812)
-- Dependencies: 201
-- Data for Name: label_langs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY label_langs (id, name, alias, ord, state, "default") FROM stdin;
2	English	en	1	1	0
1	Русский	ru	2	1	1
\.


--
-- TOC entry 2501 (class 0 OID 0)
-- Dependencies: 202
-- Name: label_langs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('label_langs_id_seq', 14, true);


--
-- TOC entry 2439 (class 0 OID 26820)
-- Dependencies: 203
-- Data for Name: labels; Type: TABLE DATA; Schema: public; Owner: -
--

COPY labels (id, parent_id, label, value_1, value_2, value_13, value_14) FROM stdin;
6	0	llll	s	\N	\N	\N
1	2	ddd	ddd	ss	\N	\N
13	5	defaultMetaDescription	Дескрипшн по умолчанию	ввв	\N	\N
14	5	defaultMetaTitle	Титул по умолчанию	выыфв	\N	\N
2	1	mn	ewew	\N	\N	\N
5	2	dsd	dsfsdf	hgh	\N	\N
\.


--
-- TOC entry 2502 (class 0 OID 0)
-- Dependencies: 204
-- Name: labels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('labels_id_seq', 14, true);


--
-- TOC entry 2441 (class 0 OID 26829)
-- Dependencies: 205
-- Data for Name: laravel_exceptions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY laravel_exceptions (id, type, code, message, file, line, trace, method, path, query, body, cookies, headers, ip, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2503 (class 0 OID 0)
-- Dependencies: 206
-- Name: laravel_exceptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('laravel_exceptions_id_seq', 340, true);


--
-- TOC entry 2443 (class 0 OID 26837)
-- Dependencies: 207
-- Data for Name: ltm_translations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ltm_translations (id, status, locale, "group", key, value, created_at, updated_at, saved_value, is_deleted, was_used, source, is_auto_added) FROM stdin;
\.


--
-- TOC entry 2504 (class 0 OID 0)
-- Dependencies: 208
-- Name: ltm_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ltm_translations_id_seq', 1, false);


--
-- TOC entry 2445 (class 0 OID 26849)
-- Dependencies: 209
-- Data for Name: ltm_user_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ltm_user_locales (id, user_id, locales, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2505 (class 0 OID 0)
-- Dependencies: 210
-- Name: ltm_user_locales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ltm_user_locales_id_seq', 1, false);


--
-- TOC entry 2447 (class 0 OID 26857)
-- Dependencies: 211
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY migrations (id, migration, batch) FROM stdin;
1	2014_10_12_000000_create_users_table	1
2	2014_10_12_100000_create_password_resets_table	1
3	2016_01_04_173148_create_admin_tables	1
4	2017_11_30_094118_create_sessions_table	2
5	2017_07_17_040159_create_exceptions_table	3
6	2017_07_17_040159_create_config_table	4
8	2017_12_04_075727_create_langs_table	5
11	2017_12_14_181815_create_langs_cats_table	6
12	2017_12_19_184754_create_labels_table	6
1649	2018_10_01_083728_create_seo_tables	9
1650	2018_10_02_084659_add_images_table	9
1651	2018_10_08_121917_create_news_table	10
17	2018_01_17_141901_create_modules_table	7
441	2014_04_02_193005_create_translations_table	8
442	2015_03_19_124805_add_src_reference_column_to_translations	8
443	2015_03_21_163127_add_original_column_to_ltr_translations	8
444	2015_07_17_172305_add_deleted_flag_to_translations	8
445	2015_09_23_220523_add_was_used_flag	8
446	2015_09_27_221759_add_group_index_to_translations	8
447	2016_04_11_00352701_create_user_locales_table	8
448	2016_05_18_124805_change_src_reference_column_in_translations	8
1653	2018_11_30_094715_add_category_name_to_permissions_table	11
1654	2018_11_30_114108_add_category_field_to_admin_config	12
\.


--
-- TOC entry 2506 (class 0 OID 0)
-- Dependencies: 212
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('migrations_id_seq', 1654, true);


--
-- TOC entry 2449 (class 0 OID 26862)
-- Dependencies: 213
-- Data for Name: mod_images; Type: TABLE DATA; Schema: public; Owner: -
--

COPY mod_images (id, item_id, module, main, path, filename, alt, disk) FROM stdin;
\.


--
-- TOC entry 2507 (class 0 OID 0)
-- Dependencies: 214
-- Name: mod_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('mod_images_id_seq', 5, true);


--
-- TOC entry 2451 (class 0 OID 26872)
-- Dependencies: 215
-- Data for Name: mod_news; Type: TABLE DATA; Schema: public; Owner: -
--

COPY mod_news (id, log_name, alias, comments_enabled, state, lock_alias, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2452 (class 0 OID 26881)
-- Dependencies: 216
-- Data for Name: mod_news_i18n; Type: TABLE DATA; Schema: public; Owner: -
--

COPY mod_news_i18n (id, row_id, locale, name, introtext, text, seo_h1, seo_title, seo_keywords, seo_description) FROM stdin;
\.


--
-- TOC entry 2508 (class 0 OID 0)
-- Dependencies: 217
-- Name: mod_news_i18n_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('mod_news_i18n_id_seq', 4, true);


--
-- TOC entry 2509 (class 0 OID 0)
-- Dependencies: 218
-- Name: mod_news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('mod_news_id_seq', 3, true);


--
-- TOC entry 2455 (class 0 OID 26891)
-- Dependencies: 219
-- Data for Name: mod_seo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY mod_seo (id, log_name, alias, link, state, lock_alias, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2456 (class 0 OID 26899)
-- Dependencies: 220
-- Data for Name: mod_seo_i18n; Type: TABLE DATA; Schema: public; Owner: -
--

COPY mod_seo_i18n (id, row_id, locale, introtext, text, seo_h1, seo_title, seo_keywords, seo_description) FROM stdin;
\.


--
-- TOC entry 2510 (class 0 OID 0)
-- Dependencies: 221
-- Name: mod_seo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('mod_seo_id_seq', 3, true);


--
-- TOC entry 2511 (class 0 OID 0)
-- Dependencies: 222
-- Name: mod_seo_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('mod_seo_translations_id_seq', 4, true);


--
-- TOC entry 2459 (class 0 OID 26909)
-- Dependencies: 223
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY password_resets (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 2460 (class 0 OID 26915)
-- Dependencies: 224
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- TOC entry 2461 (class 0 OID 26921)
-- Dependencies: 225
-- Data for Name: system_modules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY system_modules (id, parent_id, key, path, name, icon, icon_color, description, state, module_order) FROM stdin;
1	0	langs	langs	Мультиязычность	fa-amazon	#ffb600	Мультиязычность системы, языки метки.	1	2
2	0	modules	modules	Модули	fa-cubes	#ffb600	Модули системы	1	1
4	0	seo	seo	SEO	fa-compass	#ffb600	Модуль SEO настроек для страниц.	1	0
5	0	images	images	Изображения	fa-cubes		Модуль картинок	1	0
3	0	news	news	Новости	fa-cubes		Модуль новостей	1	0
\.


--
-- TOC entry 2512 (class 0 OID 0)
-- Dependencies: 226
-- Name: system_modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('system_modules_id_seq', 5, true);


--
-- TOC entry 2463 (class 0 OID 26933)
-- Dependencies: 227
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (id, name, email, password, remember_token, created_at, updated_at) FROM stdin;
1	test	vadimbirsan@gmail.com	$2y$10$wVhDx7eyIJXipZbMW6grL.KEybs9FbGDMe/DUtOxRsR/49rLuaW/K	\N	2017-11-30 10:17:27	2017-11-30 10:17:27
\.


--
-- TOC entry 2513 (class 0 OID 0)
-- Dependencies: 228
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- TOC entry 2227 (class 2606 OID 26963)
-- Name: admin_config_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_config
    ADD CONSTRAINT admin_config_name_unique UNIQUE (name);


--
-- TOC entry 2229 (class 2606 OID 26965)
-- Name: admin_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_config
    ADD CONSTRAINT admin_config_pkey PRIMARY KEY (id);


--
-- TOC entry 2231 (class 2606 OID 26967)
-- Name: admin_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_menu
    ADD CONSTRAINT admin_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 2233 (class 2606 OID 26969)
-- Name: admin_operation_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_operation_log
    ADD CONSTRAINT admin_operation_log_pkey PRIMARY KEY (id);


--
-- TOC entry 2240 (class 2606 OID 26971)
-- Name: admin_permissions_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_permissions_categories
    ADD CONSTRAINT admin_permissions_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2236 (class 2606 OID 26973)
-- Name: admin_permissions_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_permissions
    ADD CONSTRAINT admin_permissions_name_unique UNIQUE (name);


--
-- TOC entry 2238 (class 2606 OID 26975)
-- Name: admin_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_permissions
    ADD CONSTRAINT admin_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2245 (class 2606 OID 26977)
-- Name: admin_roles_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_roles
    ADD CONSTRAINT admin_roles_name_unique UNIQUE (name);


--
-- TOC entry 2247 (class 2606 OID 26979)
-- Name: admin_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);


--
-- TOC entry 2250 (class 2606 OID 26981)
-- Name: admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- TOC entry 2252 (class 2606 OID 26983)
-- Name: admin_users_username_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_username_unique UNIQUE (username);


--
-- TOC entry 2256 (class 2606 OID 26985)
-- Name: alias; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY label_langs
    ADD CONSTRAINT alias UNIQUE (alias);


--
-- TOC entry 2265 (class 2606 OID 26987)
-- Name: ixk_ltm_translations_locale_group_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ltm_translations
    ADD CONSTRAINT ixk_ltm_translations_locale_group_key UNIQUE (locale, "group", key);


--
-- TOC entry 2254 (class 2606 OID 26989)
-- Name: label_cats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY label_cats
    ADD CONSTRAINT label_cats_pkey PRIMARY KEY (id);


--
-- TOC entry 2258 (class 2606 OID 26991)
-- Name: label_langs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY label_langs
    ADD CONSTRAINT label_langs_pkey PRIMARY KEY (id);


--
-- TOC entry 2260 (class 2606 OID 26993)
-- Name: labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY labels
    ADD CONSTRAINT labels_pkey PRIMARY KEY (id);


--
-- TOC entry 2262 (class 2606 OID 26995)
-- Name: laravel_exceptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY laravel_exceptions
    ADD CONSTRAINT laravel_exceptions_pkey PRIMARY KEY (id);


--
-- TOC entry 2267 (class 2606 OID 26997)
-- Name: ltm_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ltm_translations
    ADD CONSTRAINT ltm_translations_pkey PRIMARY KEY (id);


--
-- TOC entry 2270 (class 2606 OID 26999)
-- Name: ltm_user_locales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ltm_user_locales
    ADD CONSTRAINT ltm_user_locales_pkey PRIMARY KEY (id);


--
-- TOC entry 2272 (class 2606 OID 27001)
-- Name: migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 2274 (class 2606 OID 27003)
-- Name: mod_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_images
    ADD CONSTRAINT mod_images_pkey PRIMARY KEY (id);


--
-- TOC entry 2279 (class 2606 OID 27005)
-- Name: mod_news_i18n_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_news_i18n
    ADD CONSTRAINT mod_news_i18n_pkey PRIMARY KEY (id);


--
-- TOC entry 2281 (class 2606 OID 27007)
-- Name: mod_news_i18n_row_id_locale_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_news_i18n
    ADD CONSTRAINT mod_news_i18n_row_id_locale_unique UNIQUE (row_id, locale);


--
-- TOC entry 2276 (class 2606 OID 27009)
-- Name: mod_news_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_news
    ADD CONSTRAINT mod_news_pkey PRIMARY KEY (id);


--
-- TOC entry 2283 (class 2606 OID 27011)
-- Name: mod_seo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_seo
    ADD CONSTRAINT mod_seo_pkey PRIMARY KEY (id);


--
-- TOC entry 2286 (class 2606 OID 27013)
-- Name: mod_seo_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_seo_i18n
    ADD CONSTRAINT mod_seo_translations_pkey PRIMARY KEY (id);


--
-- TOC entry 2288 (class 2606 OID 27015)
-- Name: mod_seo_translations_row_id_locale_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_seo_i18n
    ADD CONSTRAINT mod_seo_translations_row_id_locale_unique UNIQUE (row_id, locale);


--
-- TOC entry 2291 (class 2606 OID 27017)
-- Name: sessions_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_id_unique UNIQUE (id);


--
-- TOC entry 2293 (class 2606 OID 27019)
-- Name: system_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY system_modules
    ADD CONSTRAINT system_modules_pkey PRIMARY KEY (id);


--
-- TOC entry 2296 (class 2606 OID 27021)
-- Name: users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 2298 (class 2606 OID 27023)
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2234 (class 1259 OID 27024)
-- Name: admin_operation_log_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_operation_log_user_id_index ON admin_operation_log USING btree (user_id);


--
-- TOC entry 2241 (class 1259 OID 27025)
-- Name: admin_role_menu_role_id_menu_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_role_menu_role_id_menu_id_index ON admin_role_menu USING btree (role_id, menu_id);


--
-- TOC entry 2242 (class 1259 OID 27026)
-- Name: admin_role_permissions_role_id_permission_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_role_permissions_role_id_permission_id_index ON admin_role_permissions USING btree (role_id, permission_id);


--
-- TOC entry 2243 (class 1259 OID 27027)
-- Name: admin_role_users_role_id_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_role_users_role_id_user_id_index ON admin_role_users USING btree (role_id, user_id);


--
-- TOC entry 2248 (class 1259 OID 27028)
-- Name: admin_user_permissions_user_id_permission_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_user_permissions_user_id_permission_id_index ON admin_user_permissions USING btree (user_id, permission_id);


--
-- TOC entry 2263 (class 1259 OID 27029)
-- Name: ix_ltm_translations_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_ltm_translations_group ON ltm_translations USING btree ("group");


--
-- TOC entry 2268 (class 1259 OID 27030)
-- Name: ix_ltm_user_locales_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_ltm_user_locales_user_id ON ltm_user_locales USING btree (user_id);


--
-- TOC entry 2277 (class 1259 OID 27031)
-- Name: mod_news_i18n_locale_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX mod_news_i18n_locale_index ON mod_news_i18n USING btree (locale);


--
-- TOC entry 2284 (class 1259 OID 27032)
-- Name: mod_seo_translations_locale_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX mod_seo_translations_locale_index ON mod_seo_i18n USING btree (locale);


--
-- TOC entry 2289 (class 1259 OID 27033)
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX password_resets_email_index ON password_resets USING btree (email);


--
-- TOC entry 2294 (class 1259 OID 27034)
-- Name: system_modules_state_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX system_modules_state_index ON system_modules USING btree (state);


--
-- TOC entry 2299 (class 2606 OID 27035)
-- Name: mod_news_i18n_locale_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_news_i18n
    ADD CONSTRAINT mod_news_i18n_locale_foreign FOREIGN KEY (locale) REFERENCES label_langs(alias) ON UPDATE CASCADE;


--
-- TOC entry 2300 (class 2606 OID 27040)
-- Name: mod_news_i18n_row_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_news_i18n
    ADD CONSTRAINT mod_news_i18n_row_id_foreign FOREIGN KEY (row_id) REFERENCES mod_news(id) ON DELETE CASCADE;


--
-- TOC entry 2301 (class 2606 OID 27045)
-- Name: mod_seo_translations_locale_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_seo_i18n
    ADD CONSTRAINT mod_seo_translations_locale_foreign FOREIGN KEY (locale) REFERENCES label_langs(alias) ON UPDATE CASCADE;


--
-- TOC entry 2302 (class 2606 OID 27050)
-- Name: mod_seo_translations_row_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mod_seo_i18n
    ADD CONSTRAINT mod_seo_translations_row_id_foreign FOREIGN KEY (row_id) REFERENCES mod_seo(id) ON DELETE CASCADE;


-- Completed on 2018-12-11 11:53:21

--
-- PostgreSQL database dump complete
--

