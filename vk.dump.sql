--
-- PostgreSQL database dump
--

-- Dumped from database version 12.10 (Ubuntu 12.10-1.pgdg20.04+1+b1)
-- Dumped by pg_dump version 12.10 (Ubuntu 12.10-1.pgdg20.04+1+b1)

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

--
-- Name: contacts; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.contacts AS (
	phone character varying(15),
	email character varying(120)
);


ALTER TYPE public.contacts OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: communities; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.communities (
    id integer NOT NULL,
    name character varying(120),
    creator_id integer NOT NULL,
    created_at timestamp without time zone,
    members integer[]
);


ALTER TABLE public.communities OWNER TO gb_user;

--
-- Name: communities_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.communities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.communities_id_seq OWNER TO gb_user;

--
-- Name: communities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.communities_id_seq OWNED BY public.communities.id;


--
-- Name: communities_users; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.communities_users (
    community_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.communities_users OWNER TO gb_user;

--
-- Name: friendship; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.friendship (
    id integer NOT NULL,
    requested_by_user_id integer NOT NULL,
    requested_to_user_id integer NOT NULL,
    status_id integer NOT NULL,
    requested_at timestamp without time zone,
    confirmed_at timestamp without time zone
);


ALTER TABLE public.friendship OWNER TO gb_user;

--
-- Name: friendship_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.friendship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_id_seq OWNER TO gb_user;

--
-- Name: friendship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.friendship_id_seq OWNED BY public.friendship.id;


--
-- Name: friendship_statuses; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.friendship_statuses (
    id integer NOT NULL,
    name character varying(30)
);


ALTER TABLE public.friendship_statuses OWNER TO gb_user;

--
-- Name: friendship_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.friendship_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_statuses_id_seq OWNER TO gb_user;

--
-- Name: friendship_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.friendship_statuses_id_seq OWNED BY public.friendship_statuses.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL,
    body text,
    is_important boolean,
    is_delivered boolean,
    created_at timestamp without time zone
);


ALTER TABLE public.messages OWNER TO gb_user;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO gb_user;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: photo; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.photo (
    id integer NOT NULL,
    url character varying(250) NOT NULL,
    owner_id integer NOT NULL,
    description character varying(250) NOT NULL,
    uploaded_at timestamp without time zone NOT NULL,
    size integer NOT NULL,
    metadata json
);


ALTER TABLE public.photo OWNER TO gb_user;

--
-- Name: photo_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photo_id_seq OWNER TO gb_user;

--
-- Name: photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.photo_id_seq OWNED BY public.photo.id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.profiles (
    user_id integer,
    main_photo_id integer,
    created_at timestamp without time zone,
    user_contacts public.contacts
);


ALTER TABLE public.profiles OWNER TO gb_user;

--
-- Name: subscriptions_communities; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.subscriptions_communities (
    id integer NOT NULL,
    user_subscriber_id integer NOT NULL,
    subscription_communities_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.subscriptions_communities OWNER TO gb_user;

--
-- Name: subscriptions_communities_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.subscriptions_communities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscriptions_communities_id_seq OWNER TO gb_user;

--
-- Name: subscriptions_communities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.subscriptions_communities_id_seq OWNED BY public.subscriptions_communities.id;


--
-- Name: subscriptions_users; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.subscriptions_users (
    id integer NOT NULL,
    user_subscriber_id integer NOT NULL,
    subscription_user_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.subscriptions_users OWNER TO gb_user;

--
-- Name: subscriptions_users_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.subscriptions_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscriptions_users_id_seq OWNER TO gb_user;

--
-- Name: subscriptions_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.subscriptions_users_id_seq OWNED BY public.subscriptions_users.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(120) NOT NULL,
    phone character varying(15)
);


ALTER TABLE public.users OWNER TO gb_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO gb_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: video; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.video (
    id integer NOT NULL,
    url character varying(250) NOT NULL,
    owner_id integer NOT NULL,
    description character varying(250) NOT NULL,
    uploaded_at timestamp without time zone NOT NULL,
    size integer NOT NULL
);


ALTER TABLE public.video OWNER TO gb_user;

--
-- Name: video_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.video_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_id_seq OWNER TO gb_user;

--
-- Name: video_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.video_id_seq OWNED BY public.video.id;


--
-- Name: communities id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.communities ALTER COLUMN id SET DEFAULT nextval('public.communities_id_seq'::regclass);


--
-- Name: friendship id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship ALTER COLUMN id SET DEFAULT nextval('public.friendship_id_seq'::regclass);


--
-- Name: friendship_statuses id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship_statuses ALTER COLUMN id SET DEFAULT nextval('public.friendship_statuses_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: photo id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


--
-- Name: subscriptions_communities id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.subscriptions_communities ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_communities_id_seq'::regclass);


--
-- Name: subscriptions_users id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.subscriptions_users ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_users_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: video id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.video ALTER COLUMN id SET DEFAULT nextval('public.video_id_seq'::regclass);


--
-- Data for Name: communities; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.communities (id, name, creator_id, created_at, members) FROM stdin;
1	Aliquam	25	2021-12-30 06:53:28	\N
2	sollicitudin	96	2021-11-03 03:04:14	\N
4	ipsum	75	2021-06-28 18:13:57	\N
5	commodo	96	2021-12-04 08:42:09	\N
6	noon,	28	2021-09-07 04:26:35	\N
7	odio.	59	2021-09-13 08:12:15	\N
8	ovel,	56	2021-09-08 03:43:55	\N
9	feugiat	76	2021-12-04 13:31:54	\N
10	tepor	67	2021-07-17 05:16:45	\N
11	trices	75	2021-08-28 01:10:45	\N
12	seed	74	2021-11-17 13:36:40	\N
13	per	37	2021-08-29 00:04:02	\N
14	scelerisque	46	2021-09-02 22:12:44	\N
15	semper	36	2022-02-25 21:09:23	\N
16	nec,	8	2021-09-05 09:28:19	\N
17	Proin	81	2022-04-22 02:04:40	\N
18	Mauris	10	2021-08-14 11:08:21	\N
19	porta	90	2021-07-07 07:53:28	\N
20	Donec	73	2021-05-22 01:53:05	\N
21	a	57	2022-01-08 09:08:11	\N
22	sodales	43	2021-10-24 01:10:35	\N
23	Seoed	48	2021-11-11 22:48:13	\N
24	veol	31	2021-09-19 07:31:30	\N
25	neon	23	2022-04-08 18:47:15	\N
26	nascetur	4	2021-10-08 10:42:33	\N
27	tempor	34	2021-12-03 19:10:55	\N
28	ultricies	72	2021-12-21 23:30:01	\N
29	magna	61	2021-05-08 16:10:46	\N
30	convallis	29	2021-08-08 05:44:03	\N
31	cursus	3	2021-09-04 07:09:36	\N
32	dui,	87	2021-05-26 15:50:06	\N
33	aliquet,	66	2021-10-17 14:09:59	\N
34	feugiat.	48	2022-01-25 19:07:54	\N
35	Lorem	75	2022-02-01 20:30:38	\N
36	arcu.	39	2021-09-10 07:44:36	\N
37	vulputate,	36	2021-11-14 21:22:06	\N
38	sociosqu	6	2022-04-17 18:30:50	\N
39	ultric	1	2021-08-01 18:23:42	\N
40	velg,	3	2022-02-02 10:31:44	\N
41	lacus.	13	2021-11-20 01:16:55	\N
42	ipsum.	70	2021-05-31 12:04:44	\N
43	eros	19	2022-04-03 23:55:07	\N
44	ultrices	50	2021-11-23 06:48:16	\N
45	nibh.	66	2021-12-25 22:15:05	\N
46	et,	38	2022-03-01 12:52:24	\N
47	risus.	37	2021-10-11 03:53:53	\N
48	luctus	71	2022-04-11 10:05:18	\N
49	Aliqam	12	2022-03-09 14:53:17	\N
50	neque	90	2021-06-26 18:07:08	\N
51	iaculis	75	2021-12-28 04:32:26	\N
52	Loremo	74	2021-07-20 11:29:06	\N
53	euget	98	2021-08-20 18:17:40	\N
54	Phasellus	4	2021-12-02 16:45:27	\N
55	dolor.	18	2022-03-07 06:52:04	\N
56	diam.	28	2021-09-11 03:11:55	\N
57	venenatis	59	2021-11-22 08:44:41	\N
58	pede	87	2022-02-10 05:32:34	\N
59	Sied	32	2021-09-25 08:41:13	\N
60	nisi.	21	2021-08-25 18:20:00	\N
61	aliquet	21	2021-07-28 22:44:02	\N
62	at	23	2021-06-16 00:50:34	\N
63	Protin	77	2021-07-18 14:27:33	\N
64	Aenean	26	2021-07-19 04:41:14	\N
65	at,	99	2021-05-30 07:31:02	\N
66	pede.	64	2021-06-06 03:57:27	\N
67	arcu	94	2021-11-22 21:31:43	\N
68	metus	86	2021-07-10 17:15:49	\N
69	inceptos	56	2022-01-26 03:25:39	\N
70	mauris	94	2022-04-09 03:21:39	\N
71	Fusce	10	2021-05-05 23:54:50	\N
72	non,	33	2021-06-27 23:52:12	\N
73	Maecenas	83	2021-11-29 07:00:18	\N
74	vel,	32	2021-08-19 19:23:33	\N
75	siot	44	2021-08-21 22:12:45	\N
76	veler,	77	2021-06-18 13:50:31	\N
77	Fuscie	22	2022-03-08 12:29:37	\N
78	nono	86	2021-07-16 22:29:02	\N
79	nec	36	2022-03-27 22:21:43	\N
80	ligula.	32	2022-03-13 14:02:05	\N
81	ornare	22	2021-04-27 08:21:39	\N
82	Donuec	69	2021-08-29 09:04:12	\N
83	bibendum	77	2022-02-03 12:11:32	\N
84	utrices	46	2021-06-29 10:30:46	\N
85	eu,	31	2022-03-16 23:47:54	\N
86	orare	79	2022-01-25 14:40:37	\N
87	eu	26	2021-04-29 06:20:19	\N
88	egt	53	2022-03-27 05:48:51	\N
89	elit,	43	2021-09-23 07:34:43	\N
90	sit	11	2021-07-30 08:39:44	\N
91	sito	91	2021-06-16 22:07:18	\N
92	ac	80	2021-08-04 15:20:54	\N
93	tempr	31	2021-09-04 09:24:47	\N
94	tellus	9	2021-11-21 23:00:06	\N
95	sedo,	51	2021-04-25 11:39:24	\N
96	egestas.	65	2021-12-11 13:15:54	\N
97	lacus	6	2021-12-03 11:45:16	\N
98	vestibulum	51	2022-01-14 00:22:06	\N
99	auc	65	2021-08-23 02:56:56	\N
100	risuus.	90	2021-07-31 00:54:24	\N
3	et	17	2021-07-02 19:48:18	{55,13}
\.


--
-- Data for Name: communities_users; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.communities_users (community_id, user_id, created_at) FROM stdin;
99	29	2021-09-09 09:29:00
2	18	2021-09-14 11:31:19
42	62	2022-03-30 10:30:59
25	37	2021-04-28 15:57:22
11	95	2021-06-18 19:15:46
42	41	2022-01-03 19:02:15
48	53	2021-06-13 00:19:56
75	1	2021-05-24 09:43:43
71	74	2022-01-22 19:14:18
40	2	2021-05-01 06:13:24
49	56	2021-09-16 17:31:02
59	7	2021-08-17 21:25:13
42	71	2022-02-20 09:46:30
24	28	2022-04-22 11:42:43
95	79	2021-05-19 07:59:16
36	9	2022-01-08 09:27:11
55	68	2021-07-15 23:06:03
2	12	2021-05-02 08:18:28
28	61	2021-11-07 07:38:32
95	21	2021-12-25 03:49:59
73	26	2022-03-26 02:58:08
77	68	2021-10-30 03:32:55
41	65	2021-06-24 22:25:22
23	77	2021-06-04 14:52:42
10	96	2021-12-14 16:27:48
32	41	2021-12-14 11:58:57
20	5	2022-03-23 02:18:41
65	33	2022-04-19 13:07:25
99	28	2021-12-22 05:44:33
38	41	2021-09-21 10:42:41
45	23	2022-04-12 16:29:14
12	25	2021-10-01 14:18:08
8	48	2021-08-02 15:31:05
89	6	2021-07-21 09:55:38
86	32	2021-05-21 21:13:02
98	47	2021-11-19 15:22:45
95	55	2021-07-10 00:43:13
42	52	2022-03-28 12:23:15
29	99	2021-10-05 07:49:41
52	7	2021-10-24 12:23:14
7	91	2022-04-23 21:29:13
86	65	2021-08-20 09:19:00
79	47	2021-12-27 04:15:55
96	55	2022-02-05 00:56:10
26	13	2021-12-04 01:12:53
4	62	2021-06-03 04:56:38
3	55	2021-09-19 18:59:03
45	9	2021-05-08 04:38:49
32	90	2021-09-18 09:28:00
85	69	2021-07-19 05:42:50
38	49	2021-09-05 16:49:01
54	52	2022-01-26 08:23:23
90	53	2021-07-18 13:36:37
26	72	2021-09-10 00:00:47
72	48	2021-09-16 05:35:15
8	65	2021-08-01 19:54:44
9	15	2021-10-28 06:36:22
19	69	2022-03-27 17:34:22
75	89	2021-06-01 07:33:02
93	61	2022-04-23 04:08:29
30	87	2021-10-08 15:32:29
17	24	2021-08-06 18:27:59
10	75	2021-06-18 04:36:29
14	20	2021-08-23 17:54:47
46	68	2021-09-11 16:28:39
83	85	2021-06-13 20:38:37
39	69	2021-04-29 16:23:13
77	94	2021-12-10 05:36:23
60	98	2021-09-03 15:29:37
64	6	2021-07-22 10:13:41
38	84	2021-07-12 15:39:35
37	25	2021-12-31 01:30:00
24	53	2022-02-21 19:28:40
33	9	2021-11-29 10:00:32
72	85	2021-06-08 02:36:35
63	22	2021-05-13 20:08:08
6	38	2022-03-12 09:28:52
41	76	2021-09-03 04:13:02
62	84	2021-06-20 22:33:11
82	99	2021-05-25 06:00:33
26	84	2021-08-04 08:27:23
89	95	2022-04-19 00:42:19
81	43	2021-10-11 07:26:09
54	95	2021-10-12 04:46:08
95	16	2021-09-17 04:57:16
53	97	2022-04-21 19:08:40
81	63	2021-09-01 03:43:18
71	8	2021-07-24 00:05:54
23	15	2021-11-20 20:30:14
20	19	2022-01-17 02:14:14
44	41	2022-02-20 07:06:59
5	26	2021-05-09 13:35:08
88	46	2022-04-21 17:08:48
25	38	2022-04-21 04:09:24
27	86	2022-01-09 10:51:52
12	50	2021-12-17 16:56:43
20	10	2021-12-19 17:52:28
45	30	2021-06-16 00:33:15
33	38	2021-08-30 18:15:45
3	13	2021-04-30 18:59:06
\.


--
-- Data for Name: friendship; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.friendship (id, requested_by_user_id, requested_to_user_id, status_id, requested_at, confirmed_at) FROM stdin;
1	80	15	3	2021-07-12 22:15:24	2021-10-06 18:57:32
2	45	17	1	2022-02-03 21:41:50	2021-10-17 22:12:05
3	14	73	1	2021-09-17 06:36:49	2021-07-29 06:17:32
4	93	98	1	2022-01-30 03:21:20	2021-05-29 07:00:34
5	90	36	2	2022-02-03 16:09:57	2021-09-07 07:36:36
6	79	15	4	2021-07-30 17:21:01	2021-06-16 19:31:07
7	76	52	3	2022-01-10 09:35:39	2021-05-14 01:35:45
8	74	54	3	2022-04-05 13:52:57	2022-01-24 23:11:57
9	24	34	4	2022-03-17 22:57:09	2021-09-24 02:24:48
10	15	88	1	2022-04-11 10:46:47	2021-07-24 19:07:22
11	71	92	4	2021-09-29 09:50:15	2021-05-02 07:56:39
12	41	47	4	2021-10-14 07:22:28	2021-06-15 07:36:54
13	83	22	1	2021-12-21 03:08:26	2021-10-20 20:02:24
14	42	67	3	2021-07-11 12:52:25	2021-07-05 00:57:15
15	90	1	4	2022-01-14 19:45:20	2021-05-02 09:13:26
16	30	92	4	2021-08-21 22:06:14	2022-03-27 23:40:42
17	38	69	3	2021-12-26 07:38:53	2021-06-27 04:33:57
18	57	35	4	2022-04-13 04:55:50	2021-11-21 21:10:58
19	23	71	1	2021-07-20 23:43:11	2021-08-24 19:39:27
20	48	37	4	2021-11-26 09:28:15	2021-05-31 04:49:59
21	78	2	4	2021-10-26 01:13:59	2022-02-02 17:54:21
22	56	72	1	2021-08-09 15:03:16	2022-01-18 01:57:34
23	93	92	4	2022-03-02 02:02:10	2022-02-17 04:20:30
24	33	23	4	2021-07-12 11:09:18	2021-10-21 18:02:35
25	79	7	1	2022-03-16 23:59:49	2022-03-08 23:20:54
26	65	64	4	2022-04-18 21:28:33	2021-06-09 03:31:56
27	48	14	4	2021-11-30 17:02:57	2021-06-01 06:43:01
28	70	53	2	2021-12-30 22:20:11	2021-11-26 02:17:00
29	43	41	4	2022-04-16 07:29:21	2021-07-05 18:28:40
30	97	91	4	2021-08-22 01:15:50	2021-11-10 22:53:26
31	68	48	2	2021-07-07 11:37:34	2021-11-02 11:37:24
32	97	20	4	2021-06-20 02:07:14	2022-04-04 02:06:10
33	20	95	3	2021-10-18 12:45:13	2022-04-20 19:35:04
34	10	97	4	2021-09-30 20:42:17	2021-07-11 16:11:07
35	76	15	2	2021-05-07 21:15:36	2022-02-16 06:49:44
36	75	23	4	2021-04-30 11:27:46	2021-06-19 05:11:59
37	22	39	2	2022-02-26 10:57:55	2021-11-11 22:38:34
38	95	31	1	2022-01-03 09:43:05	2021-06-30 06:16:01
39	49	80	1	2021-06-14 15:11:42	2021-07-13 13:31:05
40	72	81	1	2021-10-09 20:51:50	2021-11-05 05:20:33
41	14	11	4	2021-05-24 04:22:29	2021-08-22 01:49:19
42	63	26	4	2021-10-31 14:21:52	2022-01-28 08:14:18
43	81	62	2	2021-11-23 02:27:25	2021-10-22 05:03:53
44	65	19	2	2021-05-09 06:05:48	2022-03-31 04:23:51
45	58	61	4	2021-05-20 22:06:18	2021-05-09 07:14:44
46	35	24	1	2021-08-14 06:00:06	2021-04-28 23:25:57
47	27	64	4	2022-01-07 04:35:37	2022-03-16 19:04:03
48	34	13	4	2022-01-23 15:55:18	2021-11-19 16:08:45
49	17	1	4	2021-10-08 21:48:00	2021-09-01 11:49:02
50	37	33	3	2021-12-08 07:09:37	2021-08-07 08:58:08
51	30	21	2	2022-02-13 03:48:15	2021-10-30 10:51:37
52	42	62	3	2022-02-21 21:09:28	2021-11-29 15:48:46
53	68	18	3	2022-03-06 15:36:54	2021-05-24 07:12:38
54	82	61	4	2021-10-31 15:33:21	2021-12-15 19:28:42
55	93	47	2	2022-04-06 13:03:58	2021-06-03 12:27:31
56	29	75	2	2022-04-18 20:07:32	2021-10-23 20:11:29
57	7	29	3	2021-06-26 04:21:47	2021-08-27 23:05:04
58	12	79	4	2022-01-01 01:39:12	2021-11-10 01:45:19
59	65	66	2	2022-04-19 14:29:40	2022-03-28 20:55:29
60	17	25	4	2021-12-07 08:17:02	2021-08-17 06:18:09
61	83	17	4	2021-11-21 12:16:33	2021-06-11 17:06:52
62	99	15	4	2021-05-07 10:26:03	2021-06-01 17:08:31
63	8	18	4	2021-10-12 00:15:15	2021-06-21 02:47:14
64	58	20	3	2021-09-29 04:46:24	2021-07-11 15:15:34
65	7	84	4	2022-02-26 03:42:56	2021-04-27 18:49:41
66	62	35	4	2021-12-03 03:29:44	2021-12-21 20:16:05
67	56	96	3	2021-12-02 12:00:07	2022-02-11 13:12:28
68	76	9	1	2021-07-11 00:26:54	2021-11-03 22:39:01
69	13	85	4	2021-05-30 02:29:02	2021-12-13 09:16:16
70	37	41	4	2021-08-23 23:58:30	2022-03-08 23:37:45
71	68	50	4	2021-10-07 07:56:14	2021-10-03 08:15:40
72	35	70	1	2021-09-28 04:45:35	2021-11-04 00:31:30
73	83	23	2	2022-03-14 21:17:26	2022-03-10 16:07:12
74	76	30	1	2021-06-25 16:12:09	2021-11-17 12:28:38
75	49	38	3	2022-04-06 02:20:30	2022-03-20 05:24:08
76	78	36	2	2021-09-29 10:11:13	2021-04-27 01:17:27
77	82	16	4	2021-12-12 09:07:43	2021-12-23 18:23:35
78	89	73	4	2021-10-14 12:59:08	2021-09-03 19:05:54
79	2	12	4	2022-03-28 21:08:28	2021-06-27 05:54:13
80	98	73	4	2022-02-03 01:06:03	2022-03-20 05:04:24
81	57	88	3	2022-01-02 13:56:49	2021-12-06 06:46:46
82	72	58	3	2022-01-26 14:00:07	2021-07-06 14:17:29
83	22	87	4	2021-05-13 03:44:13	2021-05-30 14:27:11
84	5	2	2	2021-09-22 01:27:29	2021-11-20 16:20:22
85	42	25	4	2021-10-18 01:26:01	2021-10-23 03:38:26
86	20	55	4	2022-03-02 09:17:32	2021-08-03 22:58:35
87	58	80	2	2021-06-18 02:03:32	2021-10-27 04:08:44
88	44	14	1	2021-09-29 20:37:45	2021-10-22 14:38:03
89	65	28	4	2022-02-12 15:15:18	2021-08-09 13:34:44
90	87	20	2	2021-07-31 11:03:46	2021-07-02 21:43:00
91	74	30	2	2021-11-18 08:12:10	2021-05-10 10:32:39
92	85	59	4	2022-01-15 08:32:17	2021-06-10 21:02:18
93	94	92	4	2021-11-23 14:27:57	2021-09-18 01:36:50
94	74	86	1	2021-06-22 10:43:30	2021-12-22 19:52:53
95	21	26	4	2021-08-13 01:42:07	2021-10-28 22:53:14
96	10	70	3	2022-04-14 18:00:36	2021-08-21 21:14:05
97	5	38	2	2022-02-12 02:55:50	2021-07-25 00:44:22
98	66	61	2	2021-11-03 05:18:52	2021-05-30 05:01:51
99	23	30	1	2022-04-24 00:20:47	2021-08-27 10:09:51
100	97	41	1	2021-07-15 14:18:06	2021-10-17 20:28:38
\.


--
-- Data for Name: friendship_statuses; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.friendship_statuses (id, name) FROM stdin;
1	parturient
2	adipiscing,
3	pellentesque
4	nisl
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.messages (id, from_user_id, to_user_id, body, is_important, is_delivered, created_at) FROM stdin;
1	9	49	amet massa. Quisque porttitor eros	f	t	2022-01-16 20:57:07
2	63	70	sagittis semper. Nam tempor diam dictum	t	f	2022-01-18 10:31:24
3	66	10	cubilia Curae	f	f	2022-01-14 00:03:00
4	34	4	ligula tortor, dictum eu, placerat	t	t	2021-05-03 08:22:22
5	58	87	primis in faucibus orci luctus et ultrices posuere	f	t	2021-09-18 04:39:23
6	96	37	euismod et, commodo at, libero. Morbi	t	t	2022-04-08 09:38:55
7	52	29	Nunc ac sem ut dolor dapibus gravida.	t	f	2021-06-26 15:07:46
8	92	16	diam eu dolor egestas	t	t	2021-12-28 04:49:00
9	46	52	varius	t	f	2022-03-12 21:22:03
10	93	99	sed, est. Nunc laoreet lectus quis massa. Mauris vestibulum,	t	t	2022-04-18 17:27:05
11	28	1	enim, condimentum eget, volutpat ornare, facilisis eget, ipsum. Donec	t	f	2022-04-02 17:58:16
12	28	23	sem semper erat,	f	f	2021-11-24 13:31:57
13	75	86	est mauris, rhoncus id, mollis nec, cursus	f	f	2022-02-22 06:20:21
14	67	4	ornare placerat, orci lacus vestibulum lorem, sit	t	f	2022-01-27 03:37:51
15	52	33	tortor, dictum eu, placerat eget, venenatis a, magna.	t	t	2022-02-19 19:29:25
16	66	61	lorem vitae odio sagittis	f	f	2021-09-07 19:56:29
17	84	48	id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut	f	f	2021-09-22 07:32:44
18	41	96	augue eu tellus. Phasellus elit pede,	t	f	2021-08-05 20:41:49
19	18	61	convallis, ante	t	f	2021-10-02 18:41:48
20	12	55	Proin sed turpis nec mauris blandit mattis. Cras	f	f	2021-09-01 08:38:36
21	85	19	ipsum dolor sit amet, consectetuer adipiscing elit. Aliquam auctor, velit	t	t	2021-11-24 07:00:02
22	51	52	eu enim. Etiam imperdiet dictum magna.	t	f	2022-03-24 14:46:02
23	16	36	urna. Ut tincidunt vehicula risus. Nulla	t	f	2022-04-01 10:51:43
24	40	31	rutrum eu, ultrices sit	f	f	2021-08-14 23:51:36
25	54	13	mus. Donec dignissim	t	f	2022-01-07 02:33:26
26	18	45	semper	t	t	2021-12-22 15:30:58
27	56	44	nascetur ridiculus mus. Proin vel	t	t	2021-12-19 23:21:05
28	64	75	at risus. Nunc ac sem ut dolor dapibus gravida.	t	t	2021-04-30 12:08:01
29	86	43	nonummy. Fusce	t	t	2022-03-28 00:54:48
30	97	36	cubilia Curae Donec tincidunt. Donec vitae erat	t	f	2021-11-25 20:34:33
31	9	52	enim. Etiam gravida molestie arcu. Sed eu nibh	f	f	2022-02-19 19:21:03
32	69	59	Aliquam rutrum lorem	t	f	2021-08-28 08:25:27
33	53	17	nec metus facilisis lorem tristique aliquet. Phasellus fermentum	t	f	2022-04-14 17:31:42
34	2	30	erat neque non quam. Pellentesque habitant morbi	f	t	2022-01-25 07:22:58
35	73	83	lobortis risus.	t	t	2022-04-18 03:39:44
36	36	36	dictum placerat, augue. Sed molestie.	t	f	2022-02-06 17:35:15
37	62	61	volutpat nunc sit	t	f	2022-02-17 18:40:56
38	68	39	sociis natoque penatibus et	t	t	2021-11-12 12:41:54
39	41	73	eu dolor egestas rhoncus. Proin nisl sem,	t	t	2021-09-14 12:42:36
40	91	67	tellus. Aenean egestas hendrerit neque. In ornare sagittis	t	f	2021-06-17 00:02:30
41	16	40	ipsum non arcu. Vivamus	f	f	2021-09-28 12:16:57
42	23	27	eleifend, nunc risus	t	f	2021-07-01 16:00:58
43	32	19	a,	f	f	2022-01-13 00:07:08
44	85	28	turpis vitae purus	f	f	2021-10-25 02:33:52
45	43	91	sagittis. Duis gravida. Praesent eu nulla at sem molestie	t	f	2021-07-16 08:33:31
46	57	83	risus. Nunc	f	f	2021-06-27 20:04:07
47	44	10	gravida nunc sed	t	f	2021-06-01 10:36:08
48	80	32	interdum enim non nisi. Aenean	f	t	2021-11-09 11:28:22
49	57	68	scelerisque scelerisque dui. Suspendisse ac metus vitae	f	f	2021-05-26 16:11:48
50	47	41	adipiscing ligula. Aenean gravida nunc sed pede. Cum	f	t	2021-07-01 05:30:22
51	80	74	odio a purus. Duis	t	f	2021-05-07 05:32:57
52	53	58	Donec feugiat metus sit amet ante. Vivamus	f	t	2021-08-27 18:29:46
53	71	56	Nam interdum	f	f	2022-02-16 16:43:15
54	42	5	metus. Aenean sed pede nec ante blandit viverra. Donec	f	t	2021-12-09 17:19:49
55	56	66	Nullam vitae diam. Proin dolor. Nulla semper tellus id nunc	f	t	2021-06-17 18:36:35
56	90	32	elit, a feugiat	f	f	2021-08-28 11:04:37
57	92	41	ligula. Aliquam erat volutpat.	f	t	2021-12-01 02:38:21
58	86	87	Morbi quis urna. Nunc quis arcu vel quam	t	t	2021-08-19 06:50:51
59	49	81	Curae Phasellus ornare.	t	f	2021-07-09 09:22:37
60	26	96	libero. Proin sed turpis nec mauris	f	f	2021-12-26 10:09:00
61	83	25	Curabitur vel lectus. Cum sociis natoque penatibus et magnis dis	t	f	2022-01-06 20:15:59
62	52	24	nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas.	t	f	2021-06-04 05:40:20
63	75	33	libero est, congue a, aliquet vel, vulputate	f	t	2021-12-02 10:02:38
64	99	60	sed pede nec ante	f	t	2021-11-25 00:08:27
65	26	41	parturient montes, nascetur ridiculus mus. Aenean eget	f	t	2022-01-26 11:41:35
66	23	81	risus. In mi pede, nonummy ut, molestie	t	t	2021-07-16 07:23:15
67	75	62	non, luctus sit	t	t	2022-03-08 13:04:41
68	31	45	nunc. In at pede.	t	f	2021-08-11 05:29:01
69	2	87	accumsan neque et nunc. Quisque ornare tortor at risus.	f	f	2021-09-29 07:22:12
70	25	7	Phasellus fermentum convallis ligula.	f	f	2021-11-24 05:36:40
71	85	97	lacus. Nulla tincidunt, neque vitae	t	f	2021-11-05 07:49:54
72	83	75	magna. Duis	t	t	2022-01-12 08:09:48
73	85	61	Nulla tincidunt, neque	f	t	2021-07-15 07:54:04
74	65	17	sociis natoque penatibus et magnis	t	f	2022-02-15 04:08:06
75	4	11	sodales purus, in molestie tortor nibh sit amet orci. Ut	f	f	2021-11-24 18:24:19
76	96	31	vel, venenatis vel, faucibus id, libero. Donec consectetuer mauris id	f	t	2021-05-19 20:40:31
77	78	23	quam vel sapien imperdiet ornare. In	t	f	2021-04-30 22:24:41
78	18	53	pede. Cum sociis	f	t	2021-05-12 17:50:26
79	22	93	eu, ultrices sit amet, risus. Donec	t	f	2022-03-17 19:49:56
80	46	5	ante bibendum ullamcorper. Duis	t	f	2021-11-16 17:25:28
81	11	70	sit amet ornare	f	f	2021-06-14 23:40:39
82	37	45	varius orci, in	t	f	2021-05-15 14:53:22
83	31	1	posuere cubilia	f	t	2022-02-19 21:20:55
84	26	23	sollicitudin commodo ipsum. Suspendisse non leo. Vivamus	t	f	2021-11-21 00:56:01
85	93	58	arcu. Nunc mauris. Morbi non sapien	f	t	2021-04-28 16:57:53
86	1	68	Cras convallis convallis dolor. Quisque tincidunt pede ac	f	f	2021-07-01 21:03:16
87	1	39	justo sit amet	f	f	2021-12-09 08:48:25
88	48	54	aliquam iaculis, lacus pede sagittis augue, eu tempor	t	f	2021-06-21 20:42:50
89	37	30	Vestibulum ut eros non enim commodo hendrerit. Donec porttitor	t	f	2022-04-18 09:53:38
90	22	52	tincidunt nibh. Phasellus nulla. Integer vulputate, risus a	f	t	2021-06-28 04:52:05
91	9	60	eget,	t	f	2021-12-31 10:19:42
92	8	15	sem ut cursus luctus, ipsum	f	t	2021-10-23 10:37:48
93	52	64	lectus rutrum	f	t	2021-07-25 17:55:14
94	53	21	lacus. Etiam bibendum fermentum metus. Aenean sed	f	t	2021-12-23 04:50:58
95	61	30	Integer tincidunt	f	t	2022-04-21 12:38:25
96	31	10	Morbi neque tellus, imperdiet non, vestibulum	t	f	2021-08-27 14:36:13
97	46	53	sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh	t	t	2021-07-07 07:32:27
98	50	66	est, mollis non, cursus non,	f	f	2021-11-22 08:50:34
99	46	31	ac libero nec ligula consectetuer rhoncus. Nullam velit dui,	t	f	2021-11-02 09:28:55
100	10	99	ipsum cursus vestibulum. Mauris magna. Duis dignissim	t	f	2021-09-07 23:48:42
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.photo (id, url, owner_id, description, uploaded_at, size, metadata) FROM stdin;
1	https://reddit.com	74	Donec dignissim magna a tortor.	2021-11-22 19:21:10	6	{"id" : 1, "url" : "https://reddit.com", "size" : 6}
2	https://youtube.com	26	ac urna. Ut tincidunt	2021-11-17 04:46:46	4	{"id" : 2, "url" : "https://youtube.com", "size" : 4}
3	http://walmart.com	65	Praesent eu	2022-03-17 16:32:39	5	{"id" : 3, "url" : "http://walmart.com", "size" : 5}
4	http://ntflix.com	77	vel turpis. Aliquam adipiscing lobortis risus. In	2021-09-01 14:17:21	3	{"id" : 4, "url" : "http://ntflix.com", "size" : 3}
5	http://cnn.com	51	magna	2022-04-20 13:44:32	3	{"id" : 5, "url" : "http://cnn.com", "size" : 3}
6	http://google.com	79	arcu iaculis enim, sit amet ornare lectus justo eu	2021-08-30 07:49:09	8	{"id" : 6, "url" : "http://google.com", "size" : 8}
7	http://netflix.com	24	hendrerit id, ante.	2022-04-23 17:02:52	6	{"id" : 7, "url" : "http://netflix.com", "size" : 6}
8	https://wikipedia.org	62	Ut nec urna et arcu imperdiet ullamcorper. Duis	2021-07-15 03:42:51	10	{"id" : 8, "url" : "https://wikipedia.org", "size" : 10}
9	http://twitter.com	3	enim. Nunc ut erat. Sed nunc est, mollis	2021-05-27 19:17:08	10	{"id" : 9, "url" : "http://twitter.com", "size" : 10}
10	https://cn.com	72	erat, in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum	2021-09-09 01:11:15	5	{"id" : 10, "url" : "https://cn.com", "size" : 5}
11	https://yahoo.com	58	Aliquam erat volutpat. Nulla facilisis. Suspendisse	2021-10-30 06:07:10	7	{"id" : 11, "url" : "https://yahoo.com", "size" : 7}
12	http://whatsapp.com	7	nisi. Mauris nulla. Integer urna. Vivamus	2021-07-25 16:28:38	7	{"id" : 12, "url" : "http://whatsapp.com", "size" : 7}
13	http://titter.com	43	odio. Phasellus at augue id ante dictum cursus. Nunc	2021-04-27 16:12:43	6	{"id" : 13, "url" : "http://titter.com", "size" : 6}
14	http://nn.com	18	vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie	2021-06-15 07:15:33	3	{"id" : 14, "url" : "http://nn.com", "size" : 3}
15	https://instagram.com	4	Morbi quis urna. Nunc quis arcu	2021-09-22 04:33:18	9	{"id" : 15, "url" : "https://instagram.com", "size" : 9}
16	https://wikipeda.org	71	Nunc mauris elit, dictum eu, eleifend	2021-12-28 13:00:53	7	{"id" : 16, "url" : "https://wikipeda.org", "size" : 7}
17	http://twiter.com	14	Duis risus odio, auctor vitae, aliquet nec,	2021-11-03 23:47:16	3	{"id" : 17, "url" : "http://twiter.com", "size" : 3}
18	http://baidu.com	96	lacus, varius et,	2021-06-22 18:48:33	3	{"id" : 18, "url" : "http://baidu.com", "size" : 3}
19	https://ebay.com	92	est, vitae sodales nisi magna sed dui. Fusce aliquam, enim	2021-07-17 11:09:27	9	{"id" : 19, "url" : "https://ebay.com", "size" : 9}
20	https://dgg.com	5	Maecenas ornare	2021-07-07 10:40:58	4	{"id" : 20, "url" : "https://dgg.com", "size" : 4}
21	http://naver.com	70	iaculis enim, sit	2022-03-16 04:59:32	8	{"id" : 21, "url" : "http://naver.com", "size" : 8}
22	https://nefli.com	34	eget tincidunt dui augue eu tellus. Phasellus elit pede,	2021-11-16 18:00:28	2	{"id" : 22, "url" : "https://nefli.com", "size" : 2}
23	https://nytimes.com	13	sapien molestie orci tincidunt	2022-03-01 23:34:54	9	{"id" : 23, "url" : "https://nytimes.com", "size" : 9}
24	http://zoom.us	88	nascetur ridiculus mus. Donec dignissim magna a tortor. Nunc	2021-07-22 04:13:58	7	{"id" : 24, "url" : "http://zoom.us", "size" : 7}
25	http://cngan.com	12	aliquet lobortis, nisi nibh	2021-08-17 20:04:31	3	{"id" : 25, "url" : "http://cngan.com", "size" : 3}
26	http://zom.us	86	eu tellus. Phasellus	2022-02-01 12:19:36	9	{"id" : 26, "url" : "http://zom.us", "size" : 9}
27	https://cnnl.com	20	ipsum dolor sit amet,	2022-02-18 13:06:10	10	{"id" : 27, "url" : "https://cnnl.com", "size" : 10}
28	http://wikpedia.org	56	lectus ante dictum mi, ac	2021-06-14 05:17:18	5	{"id" : 28, "url" : "http://wikpedia.org", "size" : 5}
29	http://ebaty.com	53	dui. Cum sociis natoque penatibus et magnis	2021-09-05 18:46:24	8	{"id" : 29, "url" : "http://ebaty.com", "size" : 8}
30	https://redit.com	79	tortor, dictum eu, placerat eget,	2022-01-06 13:44:56	8	{"id" : 30, "url" : "https://redit.com", "size" : 8}
31	https://yaho.com	29	Donec at arcu. Vestibulum ante ipsum primis in	2021-07-09 17:01:12	3	{"id" : 31, "url" : "https://yaho.com", "size" : 3}
32	http://cnln.com	61	Aliquam ultrices iaculis odio. Nam interdum	2021-09-04 01:43:34	8	{"id" : 32, "url" : "http://cnln.com", "size" : 8}
33	https://cnnk.com	80	nunc, ullamcorper eu, euismod ac, fermentum	2022-03-16 06:45:07	6	{"id" : 33, "url" : "https://cnnk.com", "size" : 6}
34	https://pinterest.com	8	amet, risus. Donec nibh enim, gravida sit amet, dapibus	2022-04-15 00:14:07	2	{"id" : 34, "url" : "https://pinterest.com", "size" : 2}
35	http://facebook.com	26	ultrices iaculis odio.	2021-09-22 08:17:41	9	{"id" : 35, "url" : "http://facebook.com", "size" : 9}
36	https://eb.com	19	dignissim. Maecenas ornare egestas ligula.	2022-02-01 12:44:29	5	{"id" : 36, "url" : "https://eb.com", "size" : 5}
37	https://redd.com	60	eget, volutpat ornare, facilisis	2022-01-10 08:52:54	5	{"id" : 37, "url" : "https://redd.com", "size" : 5}
38	http://cngn.com	27	mauris sit amet lorem semper auctor. Mauris vel turpis.	2022-01-14 16:46:55	9	{"id" : 38, "url" : "http://cngn.com", "size" : 9}
39	https://bay.com	25	eu odio tristique pharetra. Quisque ac libero	2022-02-13 02:01:32	10	{"id" : 39, "url" : "https://bay.com", "size" : 10}
40	https://guardian.co.uk	98	nec, leo. Morbi neque	2021-11-20 16:05:05	5	{"id" : 40, "url" : "https://guardian.co.uk", "size" : 5}
41	https://wipedia.org	68	a, auctor	2021-11-18 19:04:26	2	{"id" : 41, "url" : "https://wipedia.org", "size" : 2}
42	https://yaoo.com	61	et arcu imperdiet ullamcorper. Duis	2021-10-08 00:04:35	9	{"id" : 42, "url" : "https://yaoo.com", "size" : 9}
43	http://net.com	10	nisi nibh lacinia orci,	2022-04-10 07:07:53	10	{"id" : 43, "url" : "http://net.com", "size" : 10}
44	http://instagra.com	2	aliquet molestie tellus. Aenean egestas hendrerit neque. In ornare sagittis	2021-05-23 23:14:57	3	{"id" : 44, "url" : "http://instagra.com", "size" : 3}
45	http://netf.com	91	mattis. Integer eu lacus. Quisque	2021-06-20 01:17:01	6	{"id" : 45, "url" : "http://netf.com", "size" : 6}
46	http://netfli.com	93	et, commodo	2022-03-31 03:59:41	9	{"id" : 46, "url" : "http://netfli.com", "size" : 9}
47	https://flix.com	96	mattis velit	2022-04-17 08:47:01	10	{"id" : 47, "url" : "https://flix.com", "size" : 10}
48	https://ahoo.com	17	luctus vulputate, nisi	2021-12-26 22:56:43	2	{"id" : 48, "url" : "https://ahoo.com", "size" : 2}
49	http://hoo.com	91	ornare, lectus ante dictum mi, ac mattis velit justo	2022-04-06 13:56:36	9	{"id" : 49, "url" : "http://hoo.com", "size" : 9}
50	http://pinteret.com	35	in, dolor. Fusce	2021-12-07 12:55:49	5	{"id" : 50, "url" : "http://pinteret.com", "size" : 5}
51	http://pterest.com	82	malesuada vel, convallis in, cursus	2022-02-12 16:29:04	8	{"id" : 51, "url" : "http://pterest.com", "size" : 8}
52	http://gardian.co.uk	36	luctus et ultrices posuere cubilia Curae Donec tincidunt. Donec	2021-10-18 04:57:19	10	{"id" : 52, "url" : "http://gardian.co.uk", "size" : 10}
53	http://pintert.com	53	neque non	2022-01-07 07:13:58	2	{"id" : 53, "url" : "http://pintert.com", "size" : 2}
54	http://gurdian.co.uk	75	venenatis vel, faucibus id, libero. Donec	2022-01-14 08:33:19	9	{"id" : 54, "url" : "http://gurdian.co.uk", "size" : 9}
55	http://wikipea.org	22	ut mi. Duis risus	2021-12-29 05:07:17	6	{"id" : 55, "url" : "http://wikipea.org", "size" : 6}
56	http://yah.com	12	In scelerisque scelerisque	2021-12-21 01:58:34	6	{"id" : 56, "url" : "http://yah.com", "size" : 6}
57	http://facebok.com	80	semper tellus id nunc interdum feugiat.	2021-08-19 20:21:23	7	{"id" : 57, "url" : "http://facebok.com", "size" : 7}
58	http://eay.com	19	semper. Nam tempor diam dictum sapien. Aenean massa.	2022-02-23 23:49:05	7	{"id" : 58, "url" : "http://eay.com", "size" : 7}
59	https://nav.com	6	ut mi. Duis risus	2021-08-14 04:46:06	8	{"id" : 59, "url" : "https://nav.com", "size" : 8}
60	https://walmart.com	55	purus sapien, gravida non, sollicitudin a, malesuada id,	2021-06-26 11:22:08	4	{"id" : 60, "url" : "https://walmart.com", "size" : 4}
61	https://cggnn.com	86	vel, venenatis vel, faucibus id, libero. Donec	2022-03-28 18:38:37	4	{"id" : 61, "url" : "https://cggnn.com", "size" : 4}
62	http://cntn.com	79	mollis. Duis	2022-04-06 16:54:03	7	{"id" : 62, "url" : "http://cntn.com", "size" : 7}
63	http://gogle.com	53	gravida sit amet, dapibus id, blandit at, nisi. Cum	2022-02-19 05:49:47	9	{"id" : 63, "url" : "http://gogle.com", "size" : 9}
64	http://nelix.com	87	hendrerit id, ante. Nunc	2021-08-05 01:39:24	7	{"id" : 64, "url" : "http://nelix.com", "size" : 7}
65	https://baby.com	19	Praesent eu dui. Cum sociis natoque penatibus et magnis	2021-07-14 10:59:21	3	{"id" : 65, "url" : "https://baby.com", "size" : 3}
66	https://zoo.us	89	enim non nisi.	2022-01-28 03:01:38	3	{"id" : 66, "url" : "https://zoo.us", "size" : 3}
67	http://pay.com	53	Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate,	2021-09-18 20:01:29	7	{"id" : 67, "url" : "http://pay.com", "size" : 7}
68	https://eddit.com	87	vitae, erat. Vivamus nisi. Mauris	2021-11-11 01:57:11	4	{"id" : 68, "url" : "https://eddit.com", "size" : 4}
69	https://yahoaso.com	95	est, congue a, aliquet	2021-07-02 10:34:07	1	{"id" : 69, "url" : "https://yahoaso.com", "size" : 1}
70	https://twittr.com	49	Etiam laoreet, libero et tristique pellentesque, tellus sem	2021-06-17 16:57:45	6	{"id" : 70, "url" : "https://twittr.com", "size" : 6}
71	http://yotube.com	84	et	2022-02-13 02:34:41	1	{"id" : 71, "url" : "http://yotube.com", "size" : 1}
72	http://ikipedia.org	56	et ultrices posuere cubilia Curae Phasellus ornare.	2022-02-07 12:11:19	6	{"id" : 72, "url" : "http://ikipedia.org", "size" : 6}
73	http://whatsap.com	69	feugiat. Sed nec metus	2022-02-07 16:54:48	4	{"id" : 73, "url" : "http://whatsap.com", "size" : 4}
74	http://redit.com	30	nulla. Integer vulputate,	2021-06-14 15:37:22	4	{"id" : 74, "url" : "http://redit.com", "size" : 4}
75	http://bbc.co.uk	37	risus. Nunc ac sem ut	2022-03-22 00:24:42	8	{"id" : 75, "url" : "http://bbc.co.uk", "size" : 8}
76	http://pint.com	34	In nec orci. Donec nibh.	2022-02-18 23:40:20	3	{"id" : 76, "url" : "http://pint.com", "size" : 3}
77	http://y.com	72	felis	2021-05-06 03:30:00	3	{"id" : 77, "url" : "http://y.com", "size" : 3}
78	http://zoaom.us	76	ipsum primis in faucibus orci luctus et	2021-06-29 10:48:01	2	{"id" : 78, "url" : "http://zoaom.us", "size" : 2}
79	http://interest.com	46	consequat dolor vitae dolor. Donec fringilla.	2021-10-08 16:59:07	8	{"id" : 79, "url" : "http://interest.com", "size" : 8}
80	http://ver.com	22	amet luctus vulputate,	2021-11-09 09:35:40	2	{"id" : 80, "url" : "http://ver.com", "size" : 2}
81	http://twitt.com	70	Quisque varius. Nam porttitor	2021-12-07 16:26:37	8	{"id" : 81, "url" : "http://twitt.com", "size" : 8}
82	https://terest.com	12	Nunc pulvinar arcu et pede. Nunc sed orci	2021-05-25 02:45:41	3	{"id" : 82, "url" : "https://terest.com", "size" : 3}
83	https://ger.com	34	a	2021-06-09 23:08:57	5	{"id" : 83, "url" : "https://ger.com", "size" : 5}
84	https://cnun.com	19	est ac mattis semper, dui lectus rutrum urna,	2022-01-10 00:21:06	3	{"id" : 84, "url" : "https://cnun.com", "size" : 3}
85	http://insta.com	86	ut, sem. Nulla interdum. Curabitur dictum. Phasellus in	2021-05-18 10:07:45	7	{"id" : 85, "url" : "http://insta.com", "size" : 7}
86	https://nimes.com	68	torquent per conubia nostra, per inceptos hymenaeos. Mauris ut	2021-08-03 15:47:27	2	{"id" : 86, "url" : "https://nimes.com", "size" : 2}
87	https://igram.com	44	Vestibulum ut eros non enim commodo hendrerit.	2022-03-22 23:40:16	4	{"id" : 87, "url" : "https://igram.com", "size" : 4}
88	https://kipedia.org	92	eu elit. Nulla facilisi. Sed neque. Sed	2021-07-19 15:00:38	7	{"id" : 88, "url" : "https://kipedia.org", "size" : 7}
89	https://naer.com	65	Nullam suscipit, est	2021-07-23 18:15:07	7	{"id" : 89, "url" : "https://naer.com", "size" : 7}
90	http://yahoor.com	26	arcu vel quam dignissim pharetra. Nam ac nulla. In	2022-02-21 16:28:33	6	{"id" : 90, "url" : "http://yahoor.com", "size" : 6}
91	https://whatapp.com	47	facilisis lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus	2021-04-25 07:07:10	9	{"id" : 91, "url" : "https://whatapp.com", "size" : 9}
92	https://inagram.com	38	sociis natoque penatibus et	2022-03-14 04:35:25	5	{"id" : 92, "url" : "https://inagram.com", "size" : 5}
93	https://nyimes.com	69	Duis ac arcu.	2022-04-20 01:45:27	9	{"id" : 93, "url" : "https://nyimes.com", "size" : 9}
94	https://facbook.com	98	Phasellus vitae mauris sit amet lorem	2022-04-10 21:55:04	6	{"id" : 94, "url" : "https://facbook.com", "size" : 6}
95	http://pinter.com	82	Sed molestie. Sed id risus quis diam	2022-03-09 14:37:05	10	{"id" : 95, "url" : "http://pinter.com", "size" : 10}
96	https://pin.com	84	hendrerit	2021-07-24 12:48:02	8	{"id" : 96, "url" : "https://pin.com", "size" : 8}
97	https://baidu.com	2	elit. Aliquam auctor, velit eget laoreet	2022-03-11 23:45:48	9	{"id" : 97, "url" : "https://baidu.com", "size" : 9}
98	http://googl.com	45	Nunc sollicitudin commodo ipsum.	2022-01-07 08:20:24	4	{"id" : 98, "url" : "http://googl.com", "size" : 4}
99	https://nix.com	34	dolor. Nulla semper tellus id nunc interdum feugiat. Sed	2021-12-30 07:07:30	9	{"id" : 99, "url" : "https://nix.com", "size" : 9}
100	http://youtub.com	71	tristique senectus et netus	2022-04-10 10:03:22	5	{"id" : 100, "url" : "http://youtub.com", "size" : 5}
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.profiles (user_id, main_photo_id, created_at, user_contacts) FROM stdin;
1	22	2021-12-31 09:19:38	\N
2	28	2022-04-19 04:24:32	\N
3	36	2021-09-03 23:35:44	\N
4	70	2021-05-14 18:10:30	\N
5	58	2022-01-03 14:02:48	\N
6	78	2021-04-25 07:22:34	\N
7	58	2021-11-30 13:42:00	\N
8	21	2021-11-14 22:54:43	\N
9	39	2022-03-26 04:28:21	\N
10	20	2021-05-06 09:02:59	\N
11	28	2021-12-24 06:14:49	\N
12	68	2021-10-06 14:36:12	\N
13	68	2021-06-04 01:38:30	\N
14	39	2021-05-01 19:08:50	\N
15	38	2021-08-07 09:07:03	\N
16	81	2021-06-11 16:52:11	\N
17	14	2021-07-04 12:15:52	\N
18	11	2021-12-06 21:10:12	\N
19	39	2021-11-23 01:31:59	\N
20	12	2022-03-22 19:20:49	\N
22	45	2021-11-07 17:20:30	\N
23	9	2022-03-13 16:27:04	\N
24	71	2021-06-05 02:16:16	\N
25	55	2021-10-06 00:05:00	\N
26	86	2022-01-13 16:04:40	\N
27	8	2021-08-15 12:32:33	\N
28	90	2021-10-09 11:02:39	\N
29	63	2021-05-08 11:40:45	\N
30	67	2021-05-15 08:28:16	\N
31	51	2021-06-02 04:31:05	\N
32	65	2021-09-13 16:56:49	\N
33	65	2021-11-03 21:20:04	\N
34	63	2022-04-16 18:54:30	\N
35	50	2021-10-07 13:57:50	\N
36	19	2022-02-13 09:46:21	\N
37	49	2021-06-09 00:15:43	\N
38	83	2021-09-06 17:09:41	\N
39	40	2021-06-03 15:36:22	\N
40	15	2022-04-07 07:01:49	\N
41	70	2021-07-02 17:07:31	\N
42	58	2021-11-12 07:29:23	\N
43	87	2022-01-22 16:01:38	\N
44	63	2021-07-08 09:37:27	\N
45	33	2021-10-13 15:35:12	\N
46	71	2021-10-01 10:53:28	\N
47	53	2021-09-05 19:57:41	\N
48	31	2022-01-10 01:38:48	\N
49	59	2021-08-22 20:24:13	\N
50	9	2021-12-31 10:43:37	\N
51	29	2022-02-04 16:16:46	\N
52	2	2021-12-16 22:22:42	\N
53	49	2022-01-25 00:51:11	\N
54	27	2021-08-30 23:35:29	\N
55	98	2021-06-12 17:56:46	\N
56	57	2022-01-17 22:04:01	\N
57	12	2021-09-08 13:09:02	\N
58	28	2022-04-22 06:28:09	\N
59	30	2021-09-01 00:26:39	\N
60	1	2021-06-05 13:13:57	\N
61	42	2022-02-03 02:26:09	\N
62	1	2021-08-28 08:34:48	\N
63	38	2021-10-12 11:22:51	\N
64	67	2021-08-01 20:34:30	\N
65	58	2021-12-06 09:36:28	\N
66	27	2022-01-05 10:09:17	\N
67	85	2021-05-21 22:39:39	\N
68	61	2022-02-02 12:11:12	\N
69	77	2021-07-27 02:21:08	\N
70	70	2021-07-31 21:15:26	\N
71	71	2021-11-20 06:42:58	\N
72	15	2021-09-09 00:52:27	\N
73	30	2022-04-12 07:01:38	\N
74	59	2022-01-01 18:50:01	\N
75	47	2022-03-25 08:14:30	\N
76	6	2021-10-25 03:22:11	\N
77	38	2021-08-30 08:15:11	\N
78	40	2021-09-09 20:04:38	\N
79	25	2021-05-10 14:28:14	\N
80	7	2022-01-20 17:25:57	\N
81	55	2021-05-19 03:05:21	\N
82	31	2021-09-26 18:48:56	\N
83	44	2021-11-07 22:58:56	\N
84	3	2021-09-03 22:06:00	\N
85	73	2021-12-22 21:50:39	\N
86	50	2022-04-06 07:18:16	\N
87	80	2021-11-16 13:36:56	\N
88	86	2022-02-25 14:00:29	\N
89	95	2021-06-30 00:32:05	\N
90	83	2022-04-24 01:36:32	\N
91	20	2021-07-24 19:18:52	\N
92	83	2022-04-21 07:08:34	\N
93	59	2022-01-23 05:51:25	\N
94	57	2022-02-23 00:33:02	\N
95	38	2022-02-28 02:57:03	\N
96	42	2021-09-14 04:51:05	\N
97	57	2022-04-09 13:21:57	\N
98	41	2021-10-17 17:50:28	\N
99	69	2021-06-07 06:12:50	\N
100	14	2021-08-29 05:36:06	\N
21	55	2021-06-30 03:25:54	(1-334-870-2427," integer.mollis@protonmail.org")
\.


--
-- Data for Name: subscriptions_communities; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.subscriptions_communities (id, user_subscriber_id, subscription_communities_id, created_at) FROM stdin;
1	46	24	2021-12-09 23:53:59
2	2	80	2021-09-11 20:11:05
3	33	30	2021-07-03 06:24:19
4	39	81	2021-07-23 03:03:38
5	93	99	2021-09-26 04:38:04
6	5	85	2022-02-14 22:26:11
7	91	86	2022-01-13 06:00:27
8	51	50	2021-05-27 17:15:25
9	42	25	2022-04-02 05:27:56
10	85	25	2021-11-07 09:40:13
11	3	32	2022-02-01 23:56:13
12	9	51	2021-12-15 14:08:09
13	53	58	2021-07-21 06:39:34
14	87	53	2021-07-28 18:05:22
15	19	24	2022-03-21 21:48:35
16	87	8	2022-03-30 00:43:19
17	26	95	2021-12-14 02:37:58
18	1	24	2021-11-08 11:11:27
19	85	45	2022-01-17 10:32:07
20	87	80	2021-06-06 02:43:52
21	22	68	2021-06-01 22:44:00
22	81	53	2021-12-15 15:12:48
23	89	52	2021-08-17 13:01:00
24	46	60	2021-05-24 22:32:23
25	47	3	2022-03-18 14:37:33
26	26	99	2022-03-19 07:47:05
27	5	7	2021-08-11 13:32:37
28	49	18	2021-07-26 19:36:17
29	83	40	2021-05-23 18:06:34
30	56	53	2022-03-13 14:10:45
31	69	53	2021-05-15 18:20:04
32	10	6	2022-03-03 14:42:50
33	45	80	2021-10-02 22:39:53
34	89	84	2021-09-02 17:08:35
35	85	66	2022-04-12 06:36:32
36	87	47	2022-04-03 09:48:44
37	21	20	2021-09-07 09:46:24
38	19	95	2021-08-19 23:08:14
39	79	34	2021-05-01 18:15:06
40	48	19	2021-06-08 08:49:03
41	2	96	2022-03-03 20:03:16
42	83	95	2022-04-13 17:51:19
43	24	68	2022-02-09 13:16:00
44	54	35	2021-11-14 09:24:41
45	77	69	2021-09-14 16:21:30
46	7	58	2022-04-04 16:00:43
47	67	35	2021-10-23 23:13:07
48	14	57	2021-08-21 21:50:46
49	6	76	2022-04-05 22:45:23
50	5	56	2022-02-20 04:22:00
51	89	38	2022-04-12 17:35:56
52	46	31	2021-07-02 05:49:47
53	5	58	2021-04-30 15:00:56
54	58	85	2021-05-22 18:54:54
55	3	9	2021-06-13 16:13:00
56	37	73	2021-07-05 19:16:31
57	53	44	2021-06-14 12:35:19
58	52	42	2022-03-21 00:59:07
59	78	20	2021-06-21 14:16:59
60	27	43	2022-01-30 14:55:56
61	80	3	2021-05-30 07:09:21
62	22	44	2021-12-31 09:13:35
63	83	17	2021-05-22 03:10:28
64	15	97	2021-06-16 01:47:45
65	20	85	2021-11-29 15:15:41
66	64	71	2021-10-14 15:01:10
67	77	17	2021-08-20 14:05:14
68	21	90	2022-03-04 23:16:02
69	65	6	2021-09-09 21:05:50
70	45	11	2022-02-12 04:40:50
71	20	63	2022-02-25 23:36:32
72	63	18	2022-02-03 11:06:31
73	50	52	2021-11-09 13:48:11
74	20	41	2022-04-20 21:20:28
75	37	86	2021-07-24 10:19:22
76	9	72	2021-09-30 00:51:53
77	76	3	2022-03-06 23:23:14
78	92	2	2021-11-03 05:19:24
79	65	90	2021-10-11 04:23:04
80	78	62	2022-04-09 15:24:35
81	10	63	2021-04-29 10:19:54
82	77	86	2021-05-28 19:22:58
83	89	5	2022-04-15 14:22:10
84	55	92	2022-03-09 19:40:03
85	32	72	2021-06-13 18:46:55
86	66	80	2022-01-20 17:38:25
87	6	92	2021-05-06 16:41:54
88	41	58	2021-12-02 13:18:30
89	10	91	2021-08-28 14:05:01
90	8	46	2021-08-23 04:43:56
91	42	67	2021-08-17 15:48:01
92	6	65	2022-02-14 12:51:31
93	96	60	2021-06-07 10:51:02
94	82	57	2021-09-16 08:36:02
95	31	83	2022-02-15 06:55:18
96	5	3	2022-01-31 00:59:40
97	31	14	2021-07-10 16:30:22
98	47	82	2021-10-01 05:54:11
99	81	48	2021-11-30 14:38:10
100	91	11	2021-08-02 17:41:24
\.


--
-- Data for Name: subscriptions_users; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.subscriptions_users (id, user_subscriber_id, subscription_user_id, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.users (id, first_name, last_name, email, phone) FROM stdin;
1	Shelley	Kelly	metus.in@yahoo.com	1-831-517-5373
2	Elvis	Keith	tincidunt.donec@icloud.com	(258) 197-5592
3	Erica	Salinas	lacus@icloud.edu	1-111-774-7986
4	Clio	Christian	netus.et@aol.ca	(774) 802-6677
5	Linda	Delgado	porttitor.interdum@protonmail.couk	(881) 450-6272
6	Alfonso	Wallace	in.consectetuer@icloud.edu	1-650-886-6878
7	Anika	Combs	nunc.quisque@yahoo.couk	(791) 622-8402
8	Shaeleigh	Hartman	lacus.aliquam@icloud.couk	(454) 578-6765
9	Quentin	Calderon	malesuada.id@protonmail.org	1-313-255-2936
10	Rana	Frank	arcu.eu@icloud.couk	1-490-435-2214
11	Suki	Leon	fermentum.convallis@yahoo.com	(585) 742-5814
12	Tanya	Phillips	neque.in.ornare@yahoo.org	(313) 717-5631
13	Dexter	Harper	in.condimentum@protonmail.edu	(251) 932-1531
14	Mannix	Schultz	habitant.morbi@icloud.edu	1-713-344-1684
15	Howard	Cummings	libero.morbi@protonmail.edu	1-316-680-7233
16	Kane	Weiss	pede.ultrices@google.net	1-779-761-4030
17	Summer	Ratliff	lobortis.ultrices@outlook.couk	1-451-256-6863
18	Quamar	Cash	eu@aol.couk	1-886-372-7387
19	Kirestin	Castaneda	libero.at@icloud.edu	(798) 164-8262
20	Phillip	Davis	et.magnis@aol.com	1-518-575-2782
22	Helen	Mcclain	at.auctor@aol.com	(557) 809-7677
23	Keefe	Alexander	morbi@icloud.ca	(378) 281-6143
24	Driscoll	Merrill	nam.ligula@protonmail.couk	1-454-682-8832
25	Piper	Olsen	commodo@icloud.net	1-538-228-7167
26	Gary	Galloway	tempus.mauris.erat@outlook.couk	(589) 988-8723
27	Elton	Solis	pede@hotmail.net	1-621-677-1354
28	Mechelle	Blevins	nulla.integer.urna@protonmail.edu	(122) 679-3285
29	Gemma	Fleming	vitae.diam@yahoo.couk	(128) 420-7534
30	Byron	Salazar	cubilia.curae@protonmail.com	(728) 215-5755
31	Amos	Taylor	turpis@outlook.couk	1-654-378-4967
32	Josiah	Stuart	ante.dictum@icloud.net	(804) 738-2334
33	Kieran	Bishop	metus@google.ca	1-628-831-9649
34	Adria	Keith	tellus.lorem.eu@hotmail.ca	(512) 638-0640
35	Carly	Solomon	adipiscing.lobortis@hotmail.com	1-582-430-6054
36	Uta	Forbes	sapien.cras@icloud.edu	1-527-228-2362
37	Cally	Bryant	ipsum@hotmail.com	(157) 332-2726
38	Cooper	Hicks	gravida.sit.amet@yahoo.com	1-774-626-7488
39	Fuller	Christensen	fermentum@aol.ca	1-875-482-3929
40	Cairo	Molina	ligula.nullam.feugiat@icloud.org	1-814-918-9401
41	Jolene	Myers	nisl.maecenas@hotmail.net	1-141-422-3785
42	Garrison	Warren	ante.ipsum.primis@hotmail.org	(416) 435-2444
43	Barry	Landry	tempus.mauris.erat@yahoo.couk	(461) 157-4784
44	Ivor	Adams	etiam.gravida.molestie@hotmail.edu	(386) 563-7566
45	Mechelle	Wooten	neque.non@google.ca	(311) 536-5314
46	Perry	Jarvis	dolor.nonummy@google.org	1-125-768-1283
47	Tana	Bowman	semper.cursus.integer@hotmail.org	1-221-798-1726
48	Sonya	Randall	non.lacinia@yahoo.edu	1-712-177-9774
49	Brody	Albert	aliquet.diam@google.org	(236) 783-1815
50	Berk	Newton	sit.amet@outlook.edu	(550) 162-0144
51	Noelani	Yang	odio@aol.couk	(175) 951-2924
52	Ann	Bell	ante.ipsum.primis@icloud.ca	(388) 946-3386
53	Rose	Swanson	donec@protonmail.ca	1-687-686-0465
54	Emma	Burch	eu.erat@google.edu	(642) 665-8447
55	Slade	Bradshaw	ipsum.porta@google.com	(662) 754-9643
56	Francesca	Blankenship	erat@yahoo.couk	(603) 344-0178
57	Amanda	Hardy	aptent.taciti@icloud.ca	1-208-436-8673
58	Nathaniel	Shelton	mauris.eu@yahoo.couk	(712) 417-8615
59	Dustin	Stein	nisl.sem@outlook.edu	(659) 724-2468
60	Carlos	Baird	tellus@google.edu	1-683-615-7284
61	Kelsie	Larsen	aliquam.enim@hotmail.couk	(888) 552-5417
62	Signe	Knapp	rutrum.magna@google.net	(898) 207-5392
63	Allegra	Kim	lorem.eu@aol.ca	(617) 768-1728
64	Nelle	Gray	diam.lorem@protonmail.ca	1-255-823-7687
65	Chiquita	Stark	odio.etiam.ligula@hotmail.com	1-522-583-2038
66	Tara	Wong	nunc@protonmail.com	1-242-272-4435
67	Priscilla	Acosta	eu.nibh.vulputate@google.couk	(784) 519-3876
68	Erica	Burns	vel.lectus.cum@google.edu	1-634-478-0397
69	Norman	Summers	consectetuer.rhoncus@yahoo.net	(211) 585-8279
70	Fulton	Horton	donec.nibh.quisque@yahoo.com	(902) 472-6767
71	Shea	Greene	nam.consequat.dolor@icloud.edu	(907) 683-8126
72	Meredith	Carrillo	phasellus.dapibus@aol.couk	1-287-434-8567
73	Craig	Hahn	sodales@hotmail.net	(564) 185-7651
74	Slade	Woodward	aliquam@google.net	(948) 782-8866
75	Jakeem	Vasquez	quisque@aol.com	1-847-253-3937
76	Jaquelyn	Ross	aliquet.vel@yahoo.edu	(185) 116-2555
77	Aileen	Byers	justo.proin@outlook.net	(746) 878-2913
78	Melissa	Valencia	ornare.facilisis@protonmail.ca	1-476-217-4803
79	Wynter	Franklin	non.justo@icloud.edu	(526) 565-9867
80	Ian	Parker	orci.ut@protonmail.couk	(793) 264-3441
81	Hayden	Vang	venenatis@icloud.ca	1-285-415-3751
82	Octavius	Austin	sem.molestie.sodales@outlook.ca	(752) 333-6177
83	Kaseem	Boyer	cursus.non@hotmail.couk	(629) 956-3261
84	Oren	Hammond	elit@hotmail.ca	1-253-213-6988
85	Aladdin	Stuart	non.lacinia@google.edu	(668) 486-4562
86	Madeson	Marshall	quam.vel@protonmail.org	1-346-611-8677
87	Halla	Andrews	tincidunt.donec.vitae@outlook.ca	(154) 544-4451
88	Alexa	Santana	lectus@aol.net	(397) 420-2935
89	Hyatt	Dunn	ligula@icloud.couk	(348) 728-3436
90	Mufutau	Leon	purus.in.molestie@google.edu	1-956-647-1863
91	Patience	Miles	donec@icloud.couk	1-747-325-4652
92	Christopher	Mathis	lorem.fringilla.ornare@icloud.net	(775) 485-6456
93	Chanda	Hickman	natoque.penatibus@aol.net	(229) 256-6325
94	Eleanor	Clements	natoque.penatibus@icloud.couk	(564) 754-8244
95	Aileen	Barnett	magna.phasellus@aol.couk	(667) 470-4326
96	Valentine	Wilson	orci.tincidunt@aol.ca	1-561-889-7588
97	Wyoming	Goodwin	nisi@aol.org	1-433-610-7557
98	Sylvester	Atkinson	sed.malesuada@icloud.com	1-312-108-6720
99	Kenneth	Hammond	nulla.vulputate@protonmail.net	(256) 471-1516
100	Belle	Hoffman	eu.neque@aol.edu	1-876-481-3197
21	Xantha	Hancock	integer.mollis@protonmail.org	1-334-870-2427
\.


--
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.video (id, url, owner_id, description, uploaded_at, size) FROM stdin;
1	https://reddit.com	74	Donec dignissim magna a tortor.	2021-11-22 19:21:10	6
2	https://youtube.com	26	ac urna. Ut tincidunt	2021-11-17 04:46:46	4
3	http://walmart.com	65	Praesent eu	2022-03-17 16:32:39	5
4	http://ntflix.com	77	vel turpis. Aliquam adipiscing lobortis risus. In	2021-09-01 14:17:21	3
5	http://cnn.com	51	magna	2022-04-20 13:44:32	3
6	http://google.com	79	arcu iaculis enim, sit amet ornare lectus justo eu	2021-08-30 07:49:09	8
7	http://netflix.com	24	hendrerit id, ante.	2022-04-23 17:02:52	6
8	https://wikipedia.org	62	Ut nec urna et arcu imperdiet ullamcorper. Duis	2021-07-15 03:42:51	10
9	http://twitter.com	3	enim. Nunc ut erat. Sed nunc est, mollis	2021-05-27 19:17:08	10
10	https://cn.com	72	erat, in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum	2021-09-09 01:11:15	5
11	https://yahoo.com	58	Aliquam erat volutpat. Nulla facilisis. Suspendisse	2021-10-30 06:07:10	7
12	http://whatsapp.com	7	nisi. Mauris nulla. Integer urna. Vivamus	2021-07-25 16:28:38	7
13	http://titter.com	43	odio. Phasellus at augue id ante dictum cursus. Nunc	2021-04-27 16:12:43	6
14	http://nn.com	18	vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie	2021-06-15 07:15:33	3
15	https://instagram.com	4	Morbi quis urna. Nunc quis arcu	2021-09-22 04:33:18	9
16	https://wikipeda.org	71	Nunc mauris elit, dictum eu, eleifend	2021-12-28 13:00:53	7
17	http://twiter.com	14	Duis risus odio, auctor vitae, aliquet nec,	2021-11-03 23:47:16	3
18	http://baidu.com	96	lacus, varius et,	2021-06-22 18:48:33	3
19	https://ebay.com	92	est, vitae sodales nisi magna sed dui. Fusce aliquam, enim	2021-07-17 11:09:27	9
20	https://dgg.com	5	Maecenas ornare	2021-07-07 10:40:58	4
21	http://naver.com	70	iaculis enim, sit	2022-03-16 04:59:32	8
22	https://nefli.com	34	eget tincidunt dui augue eu tellus. Phasellus elit pede,	2021-11-16 18:00:28	2
23	https://nytimes.com	13	sapien molestie orci tincidunt	2022-03-01 23:34:54	9
24	http://zoom.us	88	nascetur ridiculus mus. Donec dignissim magna a tortor. Nunc	2021-07-22 04:13:58	7
25	http://cngan.com	12	aliquet lobortis, nisi nibh	2021-08-17 20:04:31	3
26	http://zom.us	86	eu tellus. Phasellus	2022-02-01 12:19:36	9
27	https://cnnl.com	20	ipsum dolor sit amet,	2022-02-18 13:06:10	10
28	http://wikpedia.org	56	lectus ante dictum mi, ac	2021-06-14 05:17:18	5
29	http://ebaty.com	53	dui. Cum sociis natoque penatibus et magnis	2021-09-05 18:46:24	8
30	https://redit.com	79	tortor, dictum eu, placerat eget,	2022-01-06 13:44:56	8
31	https://yaho.com	29	Donec at arcu. Vestibulum ante ipsum primis in	2021-07-09 17:01:12	3
32	http://cnln.com	61	Aliquam ultrices iaculis odio. Nam interdum	2021-09-04 01:43:34	8
33	https://cnnk.com	80	nunc, ullamcorper eu, euismod ac, fermentum	2022-03-16 06:45:07	6
34	https://pinterest.com	8	amet, risus. Donec nibh enim, gravida sit amet, dapibus	2022-04-15 00:14:07	2
35	http://facebook.com	26	ultrices iaculis odio.	2021-09-22 08:17:41	9
36	https://eb.com	19	dignissim. Maecenas ornare egestas ligula.	2022-02-01 12:44:29	5
37	https://redd.com	60	eget, volutpat ornare, facilisis	2022-01-10 08:52:54	5
38	http://cngn.com	27	mauris sit amet lorem semper auctor. Mauris vel turpis.	2022-01-14 16:46:55	9
39	https://bay.com	25	eu odio tristique pharetra. Quisque ac libero	2022-02-13 02:01:32	10
40	https://guardian.co.uk	98	nec, leo. Morbi neque	2021-11-20 16:05:05	5
41	https://wipedia.org	68	a, auctor	2021-11-18 19:04:26	2
42	https://yaoo.com	61	et arcu imperdiet ullamcorper. Duis	2021-10-08 00:04:35	9
43	http://net.com	10	nisi nibh lacinia orci,	2022-04-10 07:07:53	10
44	http://instagra.com	2	aliquet molestie tellus. Aenean egestas hendrerit neque. In ornare sagittis	2021-05-23 23:14:57	3
45	http://netf.com	91	mattis. Integer eu lacus. Quisque	2021-06-20 01:17:01	6
46	http://netfli.com	93	et, commodo	2022-03-31 03:59:41	9
47	https://flix.com	96	mattis velit	2022-04-17 08:47:01	10
48	https://ahoo.com	17	luctus vulputate, nisi	2021-12-26 22:56:43	2
49	http://hoo.com	91	ornare, lectus ante dictum mi, ac mattis velit justo	2022-04-06 13:56:36	9
50	http://pinteret.com	35	in, dolor. Fusce	2021-12-07 12:55:49	5
51	http://pterest.com	82	malesuada vel, convallis in, cursus	2022-02-12 16:29:04	8
52	http://gardian.co.uk	36	luctus et ultrices posuere cubilia Curae Donec tincidunt. Donec	2021-10-18 04:57:19	10
53	http://pintert.com	53	neque non	2022-01-07 07:13:58	2
54	http://gurdian.co.uk	75	venenatis vel, faucibus id, libero. Donec	2022-01-14 08:33:19	9
55	http://wikipea.org	22	ut mi. Duis risus	2021-12-29 05:07:17	6
56	http://yah.com	12	In scelerisque scelerisque	2021-12-21 01:58:34	6
57	http://facebok.com	80	semper tellus id nunc interdum feugiat.	2021-08-19 20:21:23	7
58	http://eay.com	19	semper. Nam tempor diam dictum sapien. Aenean massa.	2022-02-23 23:49:05	7
59	https://nav.com	6	ut mi. Duis risus	2021-08-14 04:46:06	8
60	https://walmart.com	55	purus sapien, gravida non, sollicitudin a, malesuada id,	2021-06-26 11:22:08	4
61	https://cggnn.com	86	vel, venenatis vel, faucibus id, libero. Donec	2022-03-28 18:38:37	4
62	http://cntn.com	79	mollis. Duis	2022-04-06 16:54:03	7
63	http://gogle.com	53	gravida sit amet, dapibus id, blandit at, nisi. Cum	2022-02-19 05:49:47	9
64	http://nelix.com	87	hendrerit id, ante. Nunc	2021-08-05 01:39:24	7
65	https://baby.com	19	Praesent eu dui. Cum sociis natoque penatibus et magnis	2021-07-14 10:59:21	3
66	https://zoo.us	89	enim non nisi.	2022-01-28 03:01:38	3
67	http://pay.com	53	Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate,	2021-09-18 20:01:29	7
68	https://eddit.com	87	vitae, erat. Vivamus nisi. Mauris	2021-11-11 01:57:11	4
69	https://yahoaso.com	95	est, congue a, aliquet	2021-07-02 10:34:07	1
70	https://twittr.com	49	Etiam laoreet, libero et tristique pellentesque, tellus sem	2021-06-17 16:57:45	6
71	http://yotube.com	84	et	2022-02-13 02:34:41	1
72	http://ikipedia.org	56	et ultrices posuere cubilia Curae Phasellus ornare.	2022-02-07 12:11:19	6
73	http://whatsap.com	69	feugiat. Sed nec metus	2022-02-07 16:54:48	4
74	http://redit.com	30	nulla. Integer vulputate,	2021-06-14 15:37:22	4
75	http://bbc.co.uk	37	risus. Nunc ac sem ut	2022-03-22 00:24:42	8
76	http://pint.com	34	In nec orci. Donec nibh.	2022-02-18 23:40:20	3
77	http://y.com	72	felis	2021-05-06 03:30:00	3
78	http://zoaom.us	76	ipsum primis in faucibus orci luctus et	2021-06-29 10:48:01	2
79	http://interest.com	46	consequat dolor vitae dolor. Donec fringilla.	2021-10-08 16:59:07	8
80	http://ver.com	22	amet luctus vulputate,	2021-11-09 09:35:40	2
81	http://twitt.com	70	Quisque varius. Nam porttitor	2021-12-07 16:26:37	8
82	https://terest.com	12	Nunc pulvinar arcu et pede. Nunc sed orci	2021-05-25 02:45:41	3
83	https://ger.com	34	a	2021-06-09 23:08:57	5
84	https://cnun.com	19	est ac mattis semper, dui lectus rutrum urna,	2022-01-10 00:21:06	3
85	http://insta.com	86	ut, sem. Nulla interdum. Curabitur dictum. Phasellus in	2021-05-18 10:07:45	7
86	https://nimes.com	68	torquent per conubia nostra, per inceptos hymenaeos. Mauris ut	2021-08-03 15:47:27	2
87	https://igram.com	44	Vestibulum ut eros non enim commodo hendrerit.	2022-03-22 23:40:16	4
88	https://kipedia.org	92	eu elit. Nulla facilisi. Sed neque. Sed	2021-07-19 15:00:38	7
89	https://naer.com	65	Nullam suscipit, est	2021-07-23 18:15:07	7
90	http://yahoor.com	26	arcu vel quam dignissim pharetra. Nam ac nulla. In	2022-02-21 16:28:33	6
91	https://whatapp.com	47	facilisis lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus	2021-04-25 07:07:10	9
92	https://inagram.com	38	sociis natoque penatibus et	2022-03-14 04:35:25	5
93	https://nyimes.com	69	Duis ac arcu.	2022-04-20 01:45:27	9
94	https://facbook.com	98	Phasellus vitae mauris sit amet lorem	2022-04-10 21:55:04	6
95	http://pinter.com	82	Sed molestie. Sed id risus quis diam	2022-03-09 14:37:05	10
96	https://pin.com	84	hendrerit	2021-07-24 12:48:02	8
97	https://baidu.com	2	elit. Aliquam auctor, velit eget laoreet	2022-03-11 23:45:48	9
98	http://googl.com	45	Nunc sollicitudin commodo ipsum.	2022-01-07 08:20:24	4
99	https://nix.com	34	dolor. Nulla semper tellus id nunc interdum feugiat. Sed	2021-12-30 07:07:30	9
100	http://youtub.com	71	tristique senectus et netus	2022-04-10 10:03:22	5
\.


--
-- Name: communities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.communities_id_seq', 1, false);


--
-- Name: friendship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.friendship_id_seq', 1, false);


--
-- Name: friendship_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.friendship_statuses_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.photo_id_seq', 1, false);


--
-- Name: subscriptions_communities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.subscriptions_communities_id_seq', 1, false);


--
-- Name: subscriptions_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.subscriptions_users_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: video_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.video_id_seq', 1, false);


--
-- Name: communities communities_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.communities
    ADD CONSTRAINT communities_name_key UNIQUE (name);


--
-- Name: communities communities_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.communities
    ADD CONSTRAINT communities_pkey PRIMARY KEY (id);


--
-- Name: communities_users communities_users_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.communities_users
    ADD CONSTRAINT communities_users_pkey PRIMARY KEY (community_id, user_id);


--
-- Name: friendship friendship_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship
    ADD CONSTRAINT friendship_pkey PRIMARY KEY (id);


--
-- Name: friendship_statuses friendship_statuses_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship_statuses
    ADD CONSTRAINT friendship_statuses_name_key UNIQUE (name);


--
-- Name: friendship_statuses friendship_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship_statuses
    ADD CONSTRAINT friendship_statuses_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: photo photo_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: photo photo_url_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_url_key UNIQUE (url);


--
-- Name: subscriptions_communities subscriptions_communities_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.subscriptions_communities
    ADD CONSTRAINT subscriptions_communities_pkey PRIMARY KEY (id);


--
-- Name: subscriptions_users subscriptions_users_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.subscriptions_users
    ADD CONSTRAINT subscriptions_users_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: video video_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_pkey PRIMARY KEY (id);


--
-- Name: video video_url_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_url_key UNIQUE (url);


--
-- Name: communities communities_creator_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.communities
    ADD CONSTRAINT communities_creator_id_fk FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: communities_users communities_users_community_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.communities_users
    ADD CONSTRAINT communities_users_community_id_fk FOREIGN KEY (community_id) REFERENCES public.communities(id);


--
-- Name: communities_users communities_users_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.communities_users
    ADD CONSTRAINT communities_users_user_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: friendship friendship_requested_by_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship
    ADD CONSTRAINT friendship_requested_by_user_id_fk FOREIGN KEY (requested_by_user_id) REFERENCES public.users(id);


--
-- Name: friendship friendship_requested_to_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship
    ADD CONSTRAINT friendship_requested_to_user_id_fk FOREIGN KEY (requested_to_user_id) REFERENCES public.users(id);


--
-- Name: friendship friendship_status_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship
    ADD CONSTRAINT friendship_status_id_fk FOREIGN KEY (status_id) REFERENCES public.friendship_statuses(id);


--
-- Name: messages messages_from_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_from_user_id_fk FOREIGN KEY (from_user_id) REFERENCES public.users(id);


--
-- Name: messages messages_to_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_to_user_id_fk FOREIGN KEY (to_user_id) REFERENCES public.users(id);


--
-- Name: photo photo_owner_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_owner_id_fk FOREIGN KEY (owner_id) REFERENCES public.users(id);


--
-- Name: profiles profiles_main_photo_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_main_photo_id_fk FOREIGN KEY (main_photo_id) REFERENCES public.photo(id);


--
-- Name: profiles profiles_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_user_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: subscriptions_communities subscriptions_communities_subscription_communities_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.subscriptions_communities
    ADD CONSTRAINT subscriptions_communities_subscription_communities_id_fk FOREIGN KEY (subscription_communities_id) REFERENCES public.communities(id);


--
-- Name: subscriptions_communities subscriptions_communities_user_subscriber_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.subscriptions_communities
    ADD CONSTRAINT subscriptions_communities_user_subscriber_id_fk FOREIGN KEY (user_subscriber_id) REFERENCES public.users(id);


--
-- Name: subscriptions_users subscriptions_users_subscription_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.subscriptions_users
    ADD CONSTRAINT subscriptions_users_subscription_user_id_fk FOREIGN KEY (subscription_user_id) REFERENCES public.users(id);


--
-- Name: subscriptions_users subscriptions_users_user_subscriber_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.subscriptions_users
    ADD CONSTRAINT subscriptions_users_user_subscriber_id_fk FOREIGN KEY (user_subscriber_id) REFERENCES public.users(id);


--
-- Name: profiles user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT user_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: video video_owner_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_owner_id_fk FOREIGN KEY (owner_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

