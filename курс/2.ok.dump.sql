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
-- Name: delete_active_users_trigger(); Type: FUNCTION; Schema: public; Owner: gb_user
--

CREATE FUNCTION public.delete_active_users_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE user_id INTEGER;
BEGIN
   user_id := NEW.id;
        RAISE EXCEPTION 'User with ID: % is activ', NEW.id;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.delete_active_users_trigger() OWNER TO gb_user;

--
-- Name: active_users; Type: VIEW; Schema: public; Owner: gb_user
--

CREATE VIEW public.active_users AS
SELECT
    NULL::integer AS id,
    NULL::text AS "user",
    NULL::bigint AS count_messages,
    NULL::bigint AS count_discussion_messages;


ALTER TABLE public.active_users OWNER TO gb_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: discussion_messages; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.discussion_messages (
    id integer NOT NULL,
    from_user_id integer NOT NULL,
    discussions_id integer NOT NULL,
    body text,
    created_at timestamp without time zone
);


ALTER TABLE public.discussion_messages OWNER TO gb_user;

--
-- Name: discussion_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.discussion_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.discussion_messages_id_seq OWNER TO gb_user;

--
-- Name: discussion_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.discussion_messages_id_seq OWNED BY public.discussion_messages.id;


--
-- Name: discussions; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.discussions (
    id integer NOT NULL,
    owner_id integer NOT NULL,
    name text,
    created_at timestamp without time zone
);


ALTER TABLE public.discussions OWNER TO gb_user;

--
-- Name: discussions_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.discussions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.discussions_id_seq OWNER TO gb_user;

--
-- Name: discussions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.discussions_id_seq OWNED BY public.discussions.id;


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
-- Name: groups; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name character varying(120),
    creator_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.groups OWNER TO gb_user;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO gb_user;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: groups_users; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.groups_users (
    group_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.groups_users OWNER TO gb_user;

--
-- Name: guest_logs; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.guest_logs (
    id integer NOT NULL,
    requested_by_user_id integer NOT NULL,
    requested_to_user_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.guest_logs OWNER TO gb_user;

--
-- Name: guest_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.guest_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guest_logs_id_seq OWNER TO gb_user;

--
-- Name: guest_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.guest_logs_id_seq OWNED BY public.guest_logs.id;


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
-- Name: other_profiles; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.other_profiles (
    user_id integer,
    twitter_name character varying(50),
    tiktok_name character varying(50),
    vk_name character varying(50),
    telegram_name character varying(50),
    viber_name character varying(50),
    whatsapp_name character varying(50),
    other_name character varying(50)
);


ALTER TABLE public.other_profiles OWNER TO gb_user;

--
-- Name: photo; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.photo (
    id integer NOT NULL,
    url character varying(250) NOT NULL,
    owner_id integer NOT NULL,
    description character varying(250) NOT NULL,
    uploaded_at timestamp without time zone NOT NULL,
    size integer NOT NULL
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
    date_of_birth timestamp without time zone,
    location character varying(50),
    career character varying(120),
    studies character varying(50),
    army character varying(120),
    created_at timestamp without time zone
);


ALTER TABLE public.profiles OWNER TO gb_user;

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
-- Name: discussion_messages id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.discussion_messages ALTER COLUMN id SET DEFAULT nextval('public.discussion_messages_id_seq'::regclass);


--
-- Name: discussions id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.discussions ALTER COLUMN id SET DEFAULT nextval('public.discussions_id_seq'::regclass);


--
-- Name: friendship id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship ALTER COLUMN id SET DEFAULT nextval('public.friendship_id_seq'::regclass);


--
-- Name: friendship_statuses id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship_statuses ALTER COLUMN id SET DEFAULT nextval('public.friendship_statuses_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: guest_logs id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.guest_logs ALTER COLUMN id SET DEFAULT nextval('public.guest_logs_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: photo id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: video id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.video ALTER COLUMN id SET DEFAULT nextval('public.video_id_seq'::regclass);


--
-- Data for Name: discussion_messages; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.discussion_messages (id, from_user_id, discussions_id, body, created_at) FROM stdin;
1	85	76	sodales at, velit.	2022-03-28 03:08:21
2	54	98	placerat, augue. Sed molestie. Sed id risus	2021-01-03 11:03:35
3	76	39	Curae	2021-07-18 08:42:14
4	36	94	semper rutrum. Fusce dolor	2022-05-12 03:54:18
5	42	78	Cras eget	2021-11-18 01:40:08
6	80	69	mauris sagittis placerat.	2022-01-29 06:17:44
7	29	38	blandit congue. In	2022-01-20 10:06:35
8	34	2	justo eu arcu. Morbi	2022-04-16 09:35:56
9	76	84	Donec at arcu. Vestibulum ante	2020-08-21 01:31:44
10	39	73	vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse	2021-12-26 05:59:17
11	29	7	suscipit nonummy.	2021-02-18 10:14:21
12	15	60	egestas hendrerit neque.	2020-12-26 17:07:56
13	92	26	at, libero. Morbi accumsan	2020-05-22 17:53:50
14	11	54	Integer in magna. Phasellus dolor	2021-03-11 09:17:30
15	24	7	Phasellus ornare. Fusce	2021-02-11 00:25:32
16	39	17	Aliquam adipiscing lobortis risus. In mi pede,	2022-01-17 18:26:05
17	92	75	nibh sit	2021-01-09 09:02:02
18	65	84	varius.	2021-08-11 09:32:15
19	34	45	tempus scelerisque,	2021-01-04 11:16:37
20	53	14	eget, volutpat ornare, facilisis eget, ipsum. Donec sollicitudin adipiscing ligula.	2021-05-06 14:43:48
21	92	82	Duis elementum, dui	2020-07-10 16:17:15
22	81	42	sed tortor. Integer aliquam adipiscing lacus. Ut nec urna	2020-11-15 11:22:52
23	59	19	Quisque purus sapien, gravida non, sollicitudin	2020-09-19 08:48:49
24	91	36	eros nec tellus. Nunc	2022-01-21 14:33:06
25	4	47	eu eros. Nam consequat	2022-01-14 03:26:05
26	21	43	Proin vel arcu eu odio tristique	2020-06-18 05:38:18
27	52	12	In scelerisque scelerisque	2021-01-03 13:10:48
28	87	11	Suspendisse aliquet, sem	2021-07-03 00:29:10
29	54	52	nisi. Aenean eget metus. In nec	2021-03-12 09:08:38
30	30	86	vulputate velit eu sem. Pellentesque ut ipsum ac mi	2020-10-15 23:19:18
31	12	69	nisl sem, consequat nec, mollis	2021-05-18 04:56:47
32	30	41	lorem, eget mollis lectus pede	2021-11-03 14:11:29
33	58	15	Aliquam ultrices iaculis odio. Nam interdum enim non	2021-12-07 10:53:20
34	98	15	dignissim magna a tortor. Nunc commodo auctor velit.	2020-11-29 19:56:28
35	59	62	dictum ultricies ligula. Nullam enim. Sed nulla ante,	2022-01-14 18:35:07
36	55	14	nonummy ipsum non arcu.	2020-09-22 22:55:25
37	17	65	sagittis.	2021-07-24 08:52:59
38	78	45	pede nec ante blandit	2020-07-28 09:55:25
39	61	95	et, euismod et, commodo at, libero. Morbi accumsan	2021-04-13 15:36:25
40	52	98	Aliquam rutrum	2021-05-17 08:52:53
41	23	50	Proin sed turpis nec mauris blandit	2020-07-07 16:21:05
42	76	62	sed, facilisis vitae, orci. Phasellus dapibus	2020-11-23 12:23:08
43	51	40	nisl sem, consequat nec, mollis vitae,	2021-10-10 03:15:49
44	96	19	ipsum leo elementum	2021-01-09 05:01:09
45	42	54	pede. Cras vulputate	2021-06-13 22:11:21
46	95	45	vulputate, risus a ultricies adipiscing,	2020-12-05 06:33:57
47	13	6	Aenean	2020-09-02 19:00:20
48	85	14	nulla. In tincidunt congue turpis. In condimentum.	2020-07-18 19:28:45
49	90	69	facilisis lorem tristique aliquet. Phasellus fermentum	2021-10-24 07:52:32
50	62	6	lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit	2021-01-03 22:17:13
51	21	33	molestie tellus. Aenean egestas hendrerit neque.	2021-06-30 21:11:41
52	33	71	gravida nunc sed pede.	2021-01-10 21:21:41
53	27	84	nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus.	2021-03-17 11:40:15
54	65	84	elit pede, malesuada vel, venenatis vel, faucibus id, libero.	2021-05-20 16:42:45
55	63	23	nulla vulputate dui, nec tempus mauris erat	2021-04-14 00:09:30
56	58	52	quis massa. Mauris vestibulum, neque sed dictum	2021-02-28 06:18:33
57	56	34	nonummy ut, molestie in, tempus eu,	2021-06-13 22:02:36
58	61	17	leo elementum sem,	2021-01-04 12:03:00
59	99	58	In mi pede, nonummy ut, molestie in, tempus	2020-11-04 04:58:49
60	23	8	ultricies ornare, elit elit fermentum risus, at	2020-07-17 03:00:57
61	63	80	mauris sagittis placerat. Cras	2021-11-23 04:11:00
62	57	22	eget ipsum. Suspendisse	2020-06-07 14:17:17
63	16	87	urna justo faucibus lectus, a sollicitudin orci sem eget massa.	2022-01-24 17:48:32
64	30	47	enim. Etiam imperdiet dictum magna. Ut tincidunt orci	2020-08-20 08:56:13
65	13	36	vulputate, lacus. Cras	2020-10-17 21:26:47
66	69	52	eget mollis lectus	2021-07-23 01:05:54
67	87	96	tempor augue ac ipsum. Phasellus vitae mauris	2020-12-24 19:43:08
68	44	61	velit eu sem. Pellentesque ut ipsum ac mi	2020-12-22 03:25:57
69	6	19	posuere cubilia	2020-09-17 18:14:26
70	99	87	eu turpis. Nulla	2021-05-13 00:49:11
71	49	67	eget odio. Aliquam vulputate ullamcorper magna. Sed eu	2020-09-04 05:36:28
72	86	80	facilisis vitae,	2021-01-30 01:30:10
73	97	83	eu, placerat eget, venenatis a, magna. Lorem	2020-09-09 12:17:26
74	42	90	pretium neque. Morbi quis urna. Nunc quis arcu vel	2022-01-11 16:55:00
75	17	70	vulputate, nisi sem semper erat, in consectetuer ipsum nunc	2020-09-03 05:41:41
76	71	20	elementum, lorem ut aliquam	2022-03-28 01:55:07
77	68	87	eget odio. Aliquam vulputate ullamcorper magna. Sed eu	2021-04-26 05:14:34
78	21	28	consectetuer ipsum nunc id	2022-04-11 00:46:04
79	53	95	rutrum lorem ac risus.	2021-10-27 04:08:43
80	99	76	non, dapibus rutrum, justo.	2021-06-01 16:41:11
81	1	10	accumsan sed,	2021-04-12 11:30:22
82	27	69	vitae, erat. Vivamus nisi. Mauris nulla. Integer	2021-09-04 18:44:40
83	79	68	urna, nec luctus felis purus ac	2021-02-25 23:00:10
84	30	93	egestas. Aliquam nec enim.	2021-04-06 15:07:47
85	71	79	justo sit amet nulla. Donec non justo. Proin non	2020-12-24 16:35:28
86	91	9	tincidunt, nunc ac mattis ornare,	2021-01-07 14:25:28
87	22	58	mauris, rhoncus id, mollis nec, cursus a, enim.	2020-09-23 07:54:20
88	49	43	Duis sit amet diam eu dolor	2020-07-20 13:08:30
89	23	91	feugiat metus	2021-01-31 12:46:30
90	92	17	Fusce fermentum fermentum arcu.	2022-04-26 04:03:38
91	49	93	orci. Phasellus dapibus quam	2020-12-08 07:46:27
92	20	5	velit. Quisque	2020-09-18 08:08:19
93	17	39	metus. In nec	2021-02-03 13:31:29
94	44	45	egestas rhoncus. Proin nisl sem, consequat nec,	2021-01-09 05:28:32
95	19	4	hendrerit id, ante. Nunc mauris sapien, cursus	2021-05-21 23:26:08
96	84	14	in, hendrerit consectetuer, cursus et, magna. Praesent	2021-09-11 14:29:28
97	11	21	Proin dolor. Nulla semper tellus id	2022-01-22 01:22:00
98	31	20	lacus. Mauris non	2021-03-02 16:22:42
99	55	29	sagittis placerat. Cras dictum	2021-04-21 18:35:21
100	92	42	sed leo. Cras vehicula aliquet libero. Integer in	2021-04-05 04:50:52
\.


--
-- Data for Name: discussions; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.discussions (id, owner_id, name, created_at) FROM stdin;
1	53	rutrum, justo. Praesent luctus. Curabitur egestas nunc	2022-01-16 13:21:25
2	8	hendrerit id, ante. Nunc mauris sapien, cursus in, hendrerit consectetuer,	2021-03-29 04:34:13
3	50	Cras convallis convallis dolor. Quisque tincidunt pede	2022-04-23 01:55:21
4	69	nec, diam. Duis mi	2021-12-03 17:35:30
5	26	nibh sit amet orci. Ut sagittis	2022-05-13 01:39:46
6	18	eleifend vitae, erat. Vivamus nisi. Mauris nulla. Integer urna.	2021-07-30 21:21:19
7	26	vitae semper egestas,	2021-09-06 12:52:09
8	91	vitae risus. Duis a mi fringilla mi lacinia	2021-04-19 23:26:27
9	68	libero nec ligula consectetuer	2020-08-23 07:10:15
10	87	sem magna nec quam. Curabitur vel lectus.	2020-06-17 15:27:13
11	13	ipsum nunc id	2021-04-24 16:57:28
12	43	Duis mi enim, condimentum eget, volutpat ornare,	2020-11-05 20:47:05
13	51	vitae	2021-01-11 14:16:02
14	46	morbi tristique senectus et netus et malesuada fames ac	2022-05-15 15:45:33
15	87	eu, ultrices sit amet, risus.	2020-06-04 07:04:53
16	70	et, magna.	2021-08-02 20:08:23
17	67	purus ac	2021-06-08 17:28:38
18	96	Aliquam erat volutpat. Nulla dignissim.	2020-11-01 23:24:12
19	16	nec quam. Curabitur vel lectus. Cum sociis natoque	2021-09-27 01:15:57
20	79	sodales elit erat vitae risus. Duis a	2020-10-03 22:53:42
21	25	enim nec	2021-03-21 11:17:28
22	84	mollis. Phasellus libero mauris, aliquam eu,	2021-01-30 17:37:05
23	91	ipsum. Suspendisse sagittis.	2022-02-09 07:52:18
24	64	dui. Cum sociis natoque penatibus et	2022-04-29 16:21:06
25	22	ut mi. Duis	2021-08-24 12:45:00
26	93	enim. Sed nulla ante, iaculis nec,	2021-10-11 13:36:21
27	45	Sed et libero. Proin mi. Aliquam gravida mauris ut	2022-01-11 04:28:39
28	72	dolor. Fusce feugiat. Lorem ipsum dolor sit amet, consectetuer	2022-05-03 01:46:26
29	69	nunc, ullamcorper eu, euismod ac, fermentum	2021-11-18 07:31:06
30	90	eget, dictum placerat, augue. Sed molestie. Sed id	2021-08-15 20:55:25
31	13	ridiculus mus. Aenean eget magna. Suspendisse tristique	2020-08-16 03:01:08
32	78	est ac mattis semper, dui lectus rutrum	2020-06-15 23:45:47
33	58	lobortis quam a felis ullamcorper viverra. Maecenas iaculis	2020-12-25 15:08:21
34	30	ipsum cursus vestibulum. Mauris	2021-06-14 07:27:17
35	9	bibendum.	2021-07-16 00:38:36
36	22	nascetur ridiculus mus. Donec dignissim	2021-10-24 09:49:06
37	16	hendrerit. Donec	2021-05-09 21:17:39
38	75	tincidunt aliquam arcu. Aliquam ultrices iaculis odio.	2021-09-08 15:56:31
39	88	velit justo nec ante. Maecenas	2021-01-12 03:51:00
40	99	erat. Vivamus nisi. Mauris nulla. Integer	2022-05-15 10:08:00
41	14	et	2020-06-21 10:39:32
42	71	mattis ornare,	2020-12-01 13:25:29
43	26	Morbi accumsan laoreet ipsum.	2021-03-26 23:17:38
44	51	Cum sociis	2021-09-10 20:49:12
45	91	Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis	2021-06-09 22:44:40
46	65	urna convallis erat, eget tincidunt dui augue eu tellus. Phasellus	2020-06-16 14:52:30
47	79	nibh vulputate	2022-05-15 23:26:40
48	69	sit amet diam	2020-11-04 12:05:30
49	89	dis parturient montes, nascetur ridiculus mus. Proin vel arcu	2021-07-20 16:39:38
50	71	elit elit fermentum risus, at	2021-04-18 19:55:54
51	57	risus varius orci,	2021-08-14 16:14:20
52	2	quam vel sapien imperdiet ornare. In faucibus. Morbi	2022-05-05 04:25:35
53	64	commodo at, libero. Morbi accumsan	2022-01-10 16:16:27
54	43	convallis convallis dolor. Quisque tincidunt pede	2022-01-12 22:56:02
55	81	a purus. Duis elementum, dui quis accumsan convallis, ante	2021-09-15 05:04:57
56	36	sapien molestie orci tincidunt adipiscing. Mauris molestie	2021-02-03 18:22:05
57	37	Duis cursus, diam at pretium aliquet, metus urna	2021-11-18 10:27:01
58	21	justo eu arcu. Morbi	2021-11-25 12:01:16
59	61	sit amet diam	2021-03-28 09:40:54
60	26	risus. Nunc ac sem ut dolor dapibus	2021-11-11 08:21:53
61	56	lorem, auctor quis, tristique	2022-02-21 14:37:36
62	53	et magnis dis parturient montes, nascetur	2021-10-21 02:56:11
63	31	enim. Etiam imperdiet	2021-11-05 15:04:41
64	41	adipiscing lobortis risus. In	2022-03-27 13:50:55
65	23	rutrum eu, ultrices sit amet, risus.	2021-01-07 19:44:42
66	94	sem egestas blandit. Nam nulla magna,	2021-10-18 08:23:29
67	21	auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa	2022-03-04 11:52:27
68	99	Duis elementum, dui quis accumsan convallis, ante lectus convallis	2020-10-10 16:34:15
69	57	semper	2021-07-10 10:00:49
70	52	nisl elementum purus,	2022-03-08 01:21:03
71	24	congue turpis.	2022-03-16 15:12:40
72	69	nisi.	2022-02-20 06:21:59
73	23	Fusce aliquet magna a	2022-02-18 15:34:40
74	15	lobortis, nisi nibh lacinia orci, consectetuer euismod est	2020-11-07 09:19:16
75	10	sollicitudin commodo ipsum. Suspendisse	2022-05-05 11:46:26
76	17	turpis egestas. Fusce aliquet magna	2020-12-17 16:42:58
77	64	Pellentesque ultricies dignissim lacus. Aliquam rutrum	2021-06-22 06:28:27
78	29	metus sit amet ante. Vivamus non lorem vitae	2021-10-26 09:57:17
79	92	in consequat	2021-02-07 14:01:50
80	55	semper tellus id nunc	2020-10-14 18:27:13
81	26	dui lectus rutrum urna, nec	2021-09-08 19:15:48
82	48	senectus et netus et malesuada fames ac turpis egestas. Fusce	2021-07-30 10:32:38
83	2	dictum eleifend, nunc risus varius orci, in	2020-06-16 10:10:03
84	15	Etiam imperdiet dictum magna. Ut tincidunt orci quis lectus.	2021-02-22 00:10:08
85	24	mi	2020-05-23 22:22:46
86	21	viverra. Maecenas	2022-04-24 10:01:34
87	36	ac facilisis facilisis, magna tellus faucibus	2020-06-10 22:18:39
88	20	Phasellus	2021-04-09 00:20:04
89	30	elementum at, egestas a, scelerisque	2020-09-15 07:22:23
90	79	condimentum. Donec at arcu. Vestibulum ante ipsum primis in	2022-01-02 21:49:00
91	13	nisl. Nulla	2021-08-07 08:06:57
92	73	in, hendrerit consectetuer, cursus et, magna. Praesent interdum ligula	2022-02-02 14:34:58
93	35	dolor dapibus	2022-01-12 20:59:57
94	28	Fusce fermentum fermentum arcu.	2022-05-14 06:54:33
95	45	erat semper rutrum. Fusce dolor quam, elementum	2021-07-01 23:19:15
96	21	condimentum. Donec at arcu. Vestibulum ante	2020-10-21 16:28:08
97	63	eu enim. Etiam imperdiet dictum magna.	2022-01-23 05:21:45
98	10	mi lacinia mattis. Integer eu lacus.	2021-09-29 09:46:41
99	15	consequat dolor vitae dolor. Donec fringilla.	2020-12-16 17:37:13
100	77	metus. Aenean sed pede	2021-06-05 01:20:58
\.


--
-- Data for Name: friendship; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.friendship (id, requested_by_user_id, requested_to_user_id, status_id, requested_at, confirmed_at) FROM stdin;
1	27	86	2	2021-03-02 15:15:29	2020-10-19 19:04:00
2	76	100	2	2021-04-11 01:05:49	2022-03-25 16:55:24
3	83	33	3	2021-10-20 12:21:55	2020-09-15 03:47:59
4	46	70	3	2021-02-12 20:56:39	2020-08-02 14:46:58
5	81	48	1	2021-12-16 22:21:36	2022-03-21 15:58:05
6	72	95	1	2022-03-25 12:23:52	2021-09-23 18:07:10
7	21	59	1	2021-07-31 10:32:42	2020-06-06 03:34:45
8	26	24	2	2022-03-13 06:25:48	2021-09-01 20:55:27
9	63	68	2	2020-11-14 19:07:57	2021-02-20 22:59:14
10	74	69	2	2020-07-18 14:26:29	2022-02-17 16:27:03
11	45	22	2	2022-03-29 02:41:43	2021-01-11 18:32:05
12	65	39	3	2022-05-09 13:44:08	2021-11-22 14:07:35
13	58	34	1	2020-06-04 04:34:05	2021-02-05 05:01:50
14	86	9	2	2021-09-09 17:44:27	2020-06-06 12:25:48
15	80	90	2	2020-10-19 16:27:14	2020-11-29 22:35:08
16	48	8	3	2021-05-13 03:02:53	2021-08-17 10:23:30
17	45	30	2	2021-12-15 17:19:27	2020-11-17 14:58:59
18	59	32	2	2021-06-05 14:42:14	2020-08-09 00:31:01
19	94	58	2	2020-09-16 19:38:51	2021-03-07 11:01:39
20	7	88	1	2021-01-11 00:44:16	2021-07-07 12:54:38
21	56	19	2	2022-02-21 20:56:55	2022-05-07 00:37:38
22	14	37	2	2021-12-28 02:35:56	2020-07-30 18:11:25
23	98	57	2	2020-09-05 14:28:27	2021-07-09 15:36:59
24	75	42	3	2021-10-27 10:34:40	2022-05-12 04:26:58
25	78	80	2	2021-10-03 23:24:56	2021-07-05 19:58:08
26	30	34	1	2021-10-17 00:47:34	2021-09-23 19:59:48
27	33	64	1	2021-08-22 06:00:57	2020-10-14 15:54:01
28	77	66	1	2020-12-30 17:51:10	2020-08-04 01:25:32
29	48	37	3	2020-09-08 15:24:34	2022-02-05 14:58:21
30	92	81	2	2022-01-19 18:39:20	2022-02-05 18:27:52
31	65	99	3	2022-03-10 16:41:29	2021-05-03 10:30:50
32	15	62	1	2020-11-24 12:01:08	2021-05-10 00:47:17
33	69	59	3	2021-05-06 07:40:48	2020-06-07 12:23:39
34	2	53	1	2022-02-23 02:04:35	2021-05-02 15:06:51
35	46	78	3	2021-07-13 00:54:04	2021-10-14 16:21:28
36	52	62	1	2020-11-12 07:25:43	2021-09-09 04:16:57
37	11	32	2	2020-10-17 22:03:31	2020-05-29 23:32:32
38	51	59	2	2020-09-16 08:31:00	2021-03-14 12:43:19
39	52	80	1	2020-10-25 21:55:21	2021-08-03 10:33:43
40	16	12	2	2021-08-16 18:15:55	2022-04-30 17:30:19
41	83	84	2	2021-02-12 14:06:48	2022-03-28 11:32:50
42	19	8	2	2020-08-10 18:00:52	2022-03-03 03:14:20
43	50	6	3	2020-11-19 09:53:42	2020-11-07 02:52:32
44	74	56	3	2021-12-26 00:50:43	2021-05-03 14:13:18
45	22	96	2	2020-09-06 19:19:13	2021-07-25 18:55:45
46	3	92	2	2021-04-07 20:25:25	2020-08-30 13:54:24
47	61	54	3	2021-04-02 04:25:59	2021-12-16 15:37:50
48	100	82	3	2022-01-16 07:50:20	2022-02-14 05:06:43
49	70	47	1	2021-11-29 08:52:53	2020-11-17 06:15:39
50	11	4	2	2020-12-17 16:21:34	2022-03-20 06:57:34
51	20	30	2	2021-12-21 18:59:33	2021-07-20 00:57:50
52	17	5	2	2022-01-11 04:46:18	2022-03-19 05:33:31
53	82	72	1	2022-01-11 03:15:07	2020-06-20 13:40:27
54	98	59	2	2022-02-17 22:45:18	2020-06-20 21:36:51
55	68	66	1	2021-06-30 00:41:29	2020-09-28 21:32:39
56	72	26	1	2022-01-25 20:30:51	2021-08-30 00:29:35
57	86	30	1	2021-03-17 19:47:16	2022-02-09 06:43:39
58	73	31	2	2021-11-27 21:51:13	2021-10-20 02:01:56
59	40	26	2	2020-06-30 20:11:17	2021-05-27 12:20:52
60	63	49	1	2021-10-11 08:58:04	2020-06-03 02:41:35
61	44	79	2	2020-09-26 22:04:17	2021-10-26 17:30:49
62	100	37	2	2021-12-20 13:38:01	2022-04-18 16:11:03
63	57	32	2	2020-06-06 05:24:47	2021-07-08 18:06:51
64	89	98	2	2020-08-17 06:55:36	2021-11-20 01:43:54
65	23	49	1	2021-07-15 02:48:12	2021-05-04 06:33:09
66	43	71	3	2020-07-04 21:00:06	2021-11-03 11:02:07
67	92	86	2	2020-11-06 05:35:26	2021-06-01 22:19:11
68	30	66	3	2022-04-05 20:50:52	2021-06-14 01:16:00
69	24	67	2	2022-03-18 17:21:48	2021-01-20 03:10:22
70	53	3	2	2020-07-04 21:56:27	2021-02-05 19:38:19
71	26	74	1	2020-07-31 12:17:01	2020-09-24 11:19:50
72	45	95	2	2021-12-16 07:32:56	2020-10-12 21:10:04
73	98	76	1	2022-01-12 09:14:46	2022-02-09 14:11:17
74	38	79	2	2021-05-08 07:11:27	2021-07-15 22:50:49
75	8	91	2	2022-04-16 23:56:13	2021-01-06 06:24:39
76	25	19	1	2020-11-26 16:45:02	2020-05-23 00:02:00
77	39	83	2	2021-10-26 15:26:40	2022-02-21 09:38:38
78	33	28	3	2022-03-06 02:39:44	2020-08-06 18:30:07
79	45	41	1	2021-10-20 08:37:00	2021-03-24 22:25:09
80	20	43	3	2022-03-28 16:23:26	2020-12-17 13:17:37
81	54	91	1	2022-03-05 23:47:30	2021-07-20 14:37:04
82	73	92	1	2021-08-05 18:29:22	2021-05-03 20:34:44
83	85	69	3	2020-07-09 10:59:27	2020-11-17 12:39:38
84	50	28	3	2021-02-16 22:48:31	2022-04-06 05:48:44
85	30	41	1	2021-11-15 02:20:14	2021-06-16 15:59:45
86	22	100	1	2022-02-21 03:16:59	2021-02-16 22:25:03
87	2	29	2	2022-04-10 06:17:54	2020-07-29 14:50:08
88	64	100	1	2021-09-15 12:28:46	2022-03-11 17:38:39
89	51	18	2	2021-08-25 03:12:21	2022-04-09 22:45:05
90	49	8	2	2022-01-10 12:42:01	2022-02-01 07:20:58
91	8	86	2	2021-04-29 07:00:05	2020-11-15 21:50:43
92	67	20	3	2020-08-01 21:05:56	2020-11-10 21:53:19
93	38	83	2	2021-05-30 06:00:30	2020-12-24 17:12:45
94	89	27	2	2021-06-11 16:47:35	2021-07-23 09:36:07
95	59	5	1	2021-11-29 18:38:06	2021-07-08 09:52:47
96	18	65	1	2020-10-10 22:44:56	2021-02-18 02:59:26
97	57	85	3	2021-11-01 04:12:50	2020-09-28 11:37:31
98	65	47	2	2020-09-12 07:36:56	2022-03-23 17:54:01
99	47	28	3	2020-06-11 12:56:12	2021-05-15 12:38:12
100	6	84	3	2020-11-29 10:52:44	2021-06-25 04:53:41
\.


--
-- Data for Name: friendship_statuses; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.friendship_statuses (id, name) FROM stdin;
1	друзья
2	запрос отправлен
3	запрос принят
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.groups (id, name, creator_id, created_at) FROM stdin;
60	lacus. Nulla tincidunt,	34	2021-10-17 07:57:05
1	arcu Curabitur ut	27	2022-02-26 05:21:03
2	sodales elit erat	44	2021-06-22 13:52:32
3	Integer aliquam adipiscing	76	2021-12-10 10:39:33
4	leo Morbi neque	2	2022-04-24 11:05:45
5	felis orci, adipiscing	20	2022-05-18 20:13:16
6	vestibulum lorem, sit	3	2022-01-15 05:04:15
7	aliquet diam. Sed	29	2021-11-27 02:54:19
8	eu tellus eu	37	2022-01-22 04:22:48
9	Ut semper pretium	12	2020-07-28 09:13:59
10	sodales at, velit.	70	2020-12-10 05:40:17
11	nibh. Aliquam ornare,	47	2020-11-08 18:19:53
12	Donec nibh enim,	58	2021-10-07 15:57:26
13	Sed nulla ante,	89	2022-02-11 10:34:42
14	non enim. Mauris	66	2021-02-14 14:15:16
15	ligula. Aenean euismod	27	2020-07-24 02:00:58
16	ultrices. Duis volutpat	72	2021-06-05 18:43:00
17	Morbi sit amet	11	2022-04-08 06:49:41
18	dictum magna. Ut	43	2020-12-06 23:38:48
19	quis accumsan convallis,	9	2021-04-01 07:37:19
20	augue id ante	52	2022-02-28 18:02:59
21	a feugiat tellus	37	2020-06-09 23:33:04
22	Donec feugiat metus	84	2021-08-30 16:14:04
23	nibh. Quisque nonummy	66	2021-08-27 14:36:38
24	tristique senectus et	42	2022-03-10 00:24:40
25	Nunc mauris. Morbi	54	2020-06-30 23:26:08
26	consectetuer, cursus et,	23	2020-09-23 22:32:35
27	non, sollicitudin a,	4	2021-07-20 08:05:24
28	semper et, lacinia	27	2022-04-04 16:57:04
29	commodo hendrerit. Donec	96	2021-12-09 11:10:55
30	Ut nec urna	17	2021-07-21 05:31:22
31	accumsan interdum libero	42	2022-05-03 05:02:56
32	consectetuer cursus	43	2021-06-13 10:26:09
33	sem semper erat,	91	2022-01-16 03:45:53
34	rhoncus id, mollis	61	2020-11-30 05:23:07
35	Integer sem elit,	79	2021-11-05 17:42:36
36	libero nec ligula	63	2020-07-29 09:10:33
37	felis eget varius	38	2020-06-13 19:36:07
38	risus, at fringilla	79	2021-10-22 12:11:08
39	amet ultricies sem	81	2020-11-07 19:55:18
40	Maecenas iaculis aliquet	85	2020-06-01 17:09:06
41	mauris sagittis placerat.	30	2020-11-02 23:52:36
42	Duis elementum, dui	97	2020-09-18 09:43:22
43	Nullam vitae diam.	72	2022-04-03 06:50:10
44	Maecenas mi felis,	89	2020-09-13 09:41:07
45	posuere cubilia Curae	13	2020-06-11 14:34:34
46	Fusce diam nunc,	46	2020-11-09 11:42:57
47	Donec felis orci,	80	2020-08-11 11:00:36
48	Donec nibh. Quisque	90	2021-07-12 14:19:12
49	Cras pellentesque. Sed	45	2021-02-21 08:14:22
50	senectus et netus	75	2021-06-28 22:58:31
51	placerat eget, venenatis	90	2021-07-29 02:19:51
52	nibh vulputate mauris	4	2021-09-02 09:43:55
53	nec, malesuada ut,	86	2020-12-04 00:03:59
54	dictum mi, ac	68	2021-10-06 04:36:34
55	nec, mollis vitae,	78	2021-01-30 08:46:20
56	dui. Fusce diam	52	2021-10-03 20:58:52
57	Vivamus rhoncus. Donec	55	2021-10-13 03:37:35
58	mollis lectus pede	17	2020-12-20 06:05:46
59	pede. Cum sociis	97	2022-02-24 07:59:30
61	Suspendisse sed dolor.	2	2021-08-08 23:25:00
62	rhoncus. Nullam velit	4	2021-01-06 10:00:06
63	elementum at, egestas	81	2021-08-17 04:12:40
64	commodo at, libero.	21	2021-04-13 16:39:10
65	primis in faucibus	88	2021-03-27 22:39:25
66	vel est tempor	53	2022-04-03 00:49:15
67	turpis egestas. Fusce	49	2020-11-11 18:11:04
68	libero et tristique	86	2021-04-23 22:29:06
69	erat nonummy ultricies	22	2021-02-10 04:50:43
70	bibendum ullamcorper. Duis	8	2020-08-22 14:08:28
71	vulputate, posuere vulputate,	99	2021-09-15 02:56:39
72	sit amet risus.	23	2022-04-17 13:18:46
73	dolor dapibus gravida.	2	2020-12-13 10:26:13
74	Donec non justo.	25	2020-08-07 05:18:18
75	ac metus vitae	84	2021-10-12 21:49:10
76	consequat dolor vitae	60	2021-10-10 15:26:48
77	feugiat tellus lorem	100	2020-12-31 18:07:21
78	amet, risus. Donec	94	2021-10-28 10:45:27
79	Integer vulputate, risus	31	2022-04-11 09:41:13
80	tempor diam dictum	10	2022-01-20 04:53:48
81	at, egestas a,	91	2020-11-10 06:26:00
82	Nullam velit	58	2020-12-25 19:06:43
83	Cras interdum.	46	2020-06-07 21:06:15
84	magna. Nam ligula	95	2021-09-28 00:01:27
85	facilisi. Sed neque.	61	2020-09-22 05:43:19
86	metus sit amet	31	2020-09-11 12:34:27
87	et, rutrum eu,	33	2020-11-29 22:52:40
88	eget metus. In	25	2021-06-14 15:50:26
89	non, egestas a,	6	2022-05-19 10:07:54
90	lacus. Cras interdum.	16	2021-03-06 23:24:15
91	Suspendisse sed	9	2021-07-14 09:41:07
92	diam eu dolor	63	2020-06-13 06:56:23
93	sollicitudin orci sem	52	2021-08-19 00:40:10
94	sollicitudin a, malesuada	72	2021-08-08 15:06:40
95	neque. In ornare	44	2022-01-04 03:03:40
96	adipiscing elit. Curabitur	93	2021-11-21 22:09:27
97	facilisis lorem tristique	35	2021-03-15 22:11:58
98	Aliquam ornare, libero	20	2021-02-04 19:02:23
99	enim, sit amet	47	2020-07-27 01:03:19
100	Nunc ut erat.	17	2021-10-05 12:08:11
\.


--
-- Data for Name: groups_users; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.groups_users (group_id, user_id, created_at) FROM stdin;
47	47	2020-09-15 16:53:47
6	68	2022-04-20 03:30:02
83	39	2021-03-28 02:45:34
75	39	2021-05-22 00:36:52
86	58	2022-02-11 23:11:11
55	55	2021-06-10 15:34:30
83	2	2021-08-19 08:01:44
98	48	2021-03-13 08:57:03
41	60	2021-12-12 11:43:42
54	74	2020-10-11 13:11:07
3	63	2021-02-20 10:32:57
90	75	2021-07-02 00:57:01
51	19	2021-05-19 17:46:13
84	37	2021-11-14 21:19:23
67	31	2020-12-27 21:04:04
61	51	2020-09-08 07:24:32
67	1	2021-05-05 22:15:00
71	6	2020-08-10 14:55:36
94	76	2020-07-03 23:56:53
67	65	2020-07-09 01:36:25
83	63	2020-08-11 09:57:03
87	28	2021-03-03 09:57:08
51	47	2021-05-13 20:25:59
21	10	2020-12-29 22:53:15
88	49	2021-06-25 21:03:51
2	63	2021-11-23 01:25:36
33	91	2021-09-07 10:50:05
80	44	2021-12-22 22:54:08
68	94	2021-09-26 16:39:14
8	75	2021-08-21 22:16:18
76	11	2020-07-19 16:23:13
3	89	2020-05-28 05:59:12
30	3	2021-05-21 15:20:18
95	96	2021-11-20 06:22:13
64	28	2022-02-01 15:43:18
70	44	2021-03-13 20:40:48
15	71	2020-08-10 08:11:54
22	28	2020-09-30 12:47:07
49	98	2020-12-13 16:18:01
78	87	2020-07-22 16:00:52
70	36	2021-11-06 03:54:21
60	45	2020-09-04 21:31:29
68	32	2020-06-24 12:02:53
18	99	2021-12-03 21:14:00
3	38	2021-05-09 22:00:26
9	14	2021-05-24 01:42:30
65	55	2021-09-21 19:26:15
81	30	2021-11-07 15:39:17
61	68	2021-03-11 19:50:00
77	41	2020-10-16 16:39:24
45	14	2021-12-10 08:29:27
8	87	2020-05-21 15:35:00
95	78	2021-02-24 13:31:54
61	70	2020-10-08 18:48:53
67	37	2021-05-04 21:57:38
57	70	2020-09-12 18:56:58
90	41	2021-12-19 09:58:47
8	68	2022-02-15 06:54:31
96	57	2020-12-22 12:32:55
30	45	2022-02-06 14:47:21
58	67	2021-10-04 00:43:40
70	55	2020-08-22 09:28:33
11	75	2021-10-05 01:38:17
29	16	2022-02-26 23:29:34
34	65	2020-11-11 03:26:27
84	18	2020-09-16 01:32:25
88	37	2022-02-24 23:32:27
16	3	2021-01-30 21:13:26
96	23	2021-09-13 04:31:29
10	16	2021-01-30 17:39:25
55	11	2022-01-27 18:11:16
90	40	2020-05-22 07:15:33
3	85	2020-08-03 18:41:26
13	99	2021-12-04 22:15:37
31	16	2021-05-11 11:08:36
12	41	2020-07-21 16:59:04
48	64	2022-03-19 00:54:33
22	12	2021-02-26 16:38:11
93	14	2020-08-23 06:54:26
28	46	2020-10-19 23:23:31
64	42	2022-02-23 11:39:34
69	3	2021-06-18 10:32:12
19	33	2020-11-06 02:38:28
3	18	2022-04-10 12:37:28
42	27	2021-02-13 03:22:35
97	5	2022-04-30 02:19:35
52	22	2022-01-06 19:09:13
73	22	2021-07-09 17:55:50
30	64	2020-12-14 06:58:47
78	99	2021-04-30 20:28:20
55	54	2021-10-09 04:06:03
74	44	2021-06-11 14:36:38
43	9	2021-10-01 11:40:12
49	69	2021-02-15 12:16:43
13	2	2020-11-22 11:32:14
35	51	2022-02-12 15:33:28
50	80	2022-04-08 12:29:25
47	42	2021-03-26 04:51:31
19	50	2021-05-22 04:51:46
17	35	2021-04-20 19:21:13
\.


--
-- Data for Name: guest_logs; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.guest_logs (id, requested_by_user_id, requested_to_user_id, created_at) FROM stdin;
1	28	86	2021-11-08 20:31:15
2	74	3	2020-06-02 17:40:53
3	6	32	2021-07-07 11:13:57
4	48	7	2022-04-10 23:46:55
5	20	67	2021-08-02 03:36:29
6	66	65	2021-04-14 17:40:43
7	43	41	2022-04-01 17:31:57
8	32	85	2022-04-18 00:18:24
9	77	27	2021-08-25 17:43:07
10	88	24	2021-03-29 20:31:31
11	81	44	2020-10-29 16:05:48
12	73	15	2021-08-11 14:58:08
13	38	3	2022-02-20 00:27:24
14	12	48	2020-09-11 19:27:41
15	6	13	2020-09-07 20:39:11
16	57	25	2020-07-24 18:46:40
17	83	64	2020-08-18 08:39:55
18	17	99	2021-09-08 03:16:46
19	86	22	2022-04-19 11:15:15
20	2	92	2021-07-12 11:25:09
21	47	73	2022-04-10 18:56:28
22	83	55	2020-10-07 17:05:17
23	2	81	2021-06-03 23:55:24
24	49	43	2021-11-25 15:18:48
25	35	48	2021-10-01 14:42:04
26	6	33	2021-05-08 09:27:15
27	44	35	2022-01-06 17:25:17
28	75	10	2022-03-05 06:43:42
29	86	51	2020-08-26 19:34:25
30	99	7	2022-05-01 05:21:52
31	9	33	2021-07-22 18:28:51
32	64	58	2021-02-14 20:58:01
33	85	65	2020-10-26 03:27:38
34	37	17	2021-07-25 10:49:56
35	6	37	2021-03-16 12:26:46
36	11	70	2022-05-09 08:08:38
37	66	84	2021-05-22 20:46:31
38	98	3	2021-07-29 10:43:40
39	22	85	2020-07-25 05:03:58
40	1	37	2020-05-26 16:20:25
41	48	5	2020-11-22 09:12:50
42	39	74	2021-02-02 14:00:57
43	65	8	2022-02-08 00:57:54
44	44	75	2020-10-05 17:24:04
45	35	15	2021-03-08 10:55:00
46	22	72	2021-12-07 22:24:15
47	99	31	2021-02-28 10:02:46
48	19	20	2020-07-01 20:34:28
49	2	22	2021-11-18 01:19:13
50	9	30	2022-02-07 23:45:33
51	55	63	2021-01-17 04:02:28
52	85	64	2022-05-14 21:12:37
53	66	58	2021-12-07 02:13:05
54	70	78	2020-09-19 15:01:52
55	7	64	2021-11-09 17:08:02
56	65	95	2020-09-12 05:37:38
57	24	59	2021-07-04 22:09:48
58	94	21	2022-03-24 04:14:44
59	46	5	2020-07-14 16:33:12
60	13	77	2020-09-22 09:22:54
61	49	13	2022-04-08 11:29:33
62	24	76	2022-02-23 07:05:40
63	74	24	2020-08-14 06:04:53
64	55	81	2022-01-10 19:49:17
65	61	14	2022-01-25 16:40:28
66	26	41	2020-08-13 17:59:53
67	39	14	2020-09-19 03:39:01
68	16	2	2020-12-01 04:39:16
69	70	27	2021-01-31 01:17:22
70	23	65	2021-03-03 07:13:36
71	94	58	2021-11-12 12:14:29
72	15	80	2021-11-01 21:50:00
73	50	37	2021-05-08 12:59:05
74	19	55	2021-04-18 22:54:20
75	25	11	2022-03-26 08:02:12
76	89	53	2020-09-06 23:06:56
77	84	52	2021-01-28 01:13:22
78	32	69	2020-10-13 20:47:47
79	55	74	2021-07-22 17:45:27
80	40	14	2021-04-06 04:17:55
81	93	12	2022-04-08 05:35:43
82	1	30	2022-03-09 05:57:43
83	76	64	2021-06-14 14:46:44
84	76	57	2021-12-02 07:34:27
85	18	11	2021-05-10 02:32:32
86	67	38	2021-03-19 00:36:10
87	81	41	2020-07-04 17:27:50
88	33	57	2022-01-12 06:43:42
89	9	35	2020-06-20 17:59:11
90	55	44	2021-04-06 01:57:03
91	28	90	2020-12-10 08:37:34
92	16	32	2021-12-01 08:26:39
93	8	94	2021-10-14 05:26:26
94	70	93	2021-08-17 15:34:26
95	23	20	2021-12-16 19:47:23
96	99	13	2021-06-19 02:11:14
97	1	41	2020-08-05 13:58:00
98	41	14	2022-04-03 20:38:48
99	81	34	2022-02-24 15:49:26
100	57	58	2022-03-08 01:15:59
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.messages (id, from_user_id, to_user_id, body, is_important, is_delivered, created_at) FROM stdin;
1	38	63	condimentum. Donec at	f	f	2022-05-16 04:52:32
2	20	4	vitae diam. Proin dolor. Nulla	f	t	2022-01-24 16:33:54
3	66	74	enim, sit amet ornare lectus justo eu arcu. Morbi sit	t	t	2022-05-09 02:47:34
4	99	27	eu eros. Nam consequat	t	f	2020-10-13 08:30:18
5	94	85	pede et risus. Quisque libero lacus, varius et, euismod et,	t	t	2022-01-25 21:07:01
6	37	98	justo faucibus lectus,	f	t	2021-06-04 03:51:45
7	98	72	Cras pellentesque. Sed dictum. Proin	f	f	2020-11-16 01:33:30
8	96	20	laoreet lectus quis massa. Mauris vestibulum, neque sed	t	f	2021-01-01 01:57:51
9	3	89	leo. Cras vehicula aliquet	t	t	2021-09-02 12:40:30
10	38	29	luctus. Curabitur egestas nunc sed libero. Proin sed turpis	f	f	2021-11-22 01:57:59
11	67	77	tortor, dictum eu, placerat eget, venenatis a,	f	f	2022-01-17 18:28:18
12	96	22	velit egestas lacinia. Sed congue, elit sed consequat auctor,	t	f	2022-01-08 18:47:38
13	48	57	Aliquam tincidunt, nunc	t	f	2021-01-30 02:18:42
14	90	37	erat semper rutrum. Fusce dolor quam, elementum at, egestas a,	t	t	2022-03-06 05:42:32
15	20	68	risus. Donec egestas. Aliquam nec enim. Nunc ut erat.	t	f	2021-06-26 13:07:12
16	35	88	tellus sem	f	t	2021-10-04 20:44:14
17	32	43	enim nec tempus	f	t	2021-07-10 09:20:53
18	18	42	est, mollis non, cursus non, egestas a, dui. Cras pellentesque.	f	f	2021-12-01 23:31:47
19	61	22	Suspendisse aliquet molestie tellus. Aenean egestas hendrerit neque. In	t	t	2020-08-22 17:53:57
20	67	85	arcu vel quam dignissim pharetra. Nam ac nulla.	f	f	2021-08-29 10:28:36
21	74	85	turpis. Nulla aliquet. Proin	f	f	2020-06-12 02:55:53
22	2	91	arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien,	t	f	2020-08-17 11:58:30
23	87	52	erat semper rutrum. Fusce dolor quam, elementum at,	f	t	2020-10-02 05:34:20
24	92	59	auctor ullamcorper, nisl	f	t	2021-05-01 08:55:24
25	41	27	ornare, elit elit fermentum risus,	f	t	2022-01-06 03:16:51
26	84	70	dui, nec tempus mauris erat	f	t	2021-08-23 00:00:34
27	80	87	mollis. Phasellus libero mauris, aliquam eu, accumsan sed,	f	f	2020-09-30 23:56:32
28	53	19	varius. Nam porttitor scelerisque neque.	f	t	2021-10-01 13:48:20
29	25	51	est ac mattis semper, dui	t	f	2021-03-03 00:19:45
30	55	42	elit, pretium et, rutrum non, hendrerit id, ante.	f	f	2021-02-06 19:29:58
31	55	72	egestas a, dui. Cras	t	t	2021-06-25 18:47:46
32	89	16	enim, gravida sit amet, dapibus	t	t	2021-08-12 08:19:41
33	99	42	libero. Proin	t	t	2022-03-25 21:43:02
34	32	91	Nunc quis arcu vel quam	f	t	2021-10-16 06:34:52
35	80	17	sed, hendrerit a, arcu.	t	f	2022-03-09 17:24:13
36	94	99	cursus. Integer mollis.	f	t	2020-09-16 05:20:49
37	23	64	ut mi. Duis risus	t	t	2020-06-09 19:14:05
38	62	88	purus gravida sagittis.	t	t	2021-11-20 19:10:05
39	74	96	Phasellus dapibus quam quis diam. Pellentesque habitant morbi tristique	t	t	2020-12-04 10:42:13
40	53	45	arcu. Vivamus sit amet risus. Donec	f	t	2021-04-01 08:40:52
41	39	78	Cum sociis natoque penatibus et magnis	f	f	2022-04-26 09:07:40
42	78	46	fames ac turpis	f	f	2020-08-22 06:36:33
43	90	17	Nunc quis	t	t	2021-06-21 02:15:07
44	66	50	sed orci lobortis augue scelerisque mollis. Phasellus libero mauris,	f	t	2022-03-29 05:20:15
45	33	30	est tempor bibendum. Donec felis orci, adipiscing non, luctus	t	f	2021-09-11 13:05:10
46	52	56	Donec	f	f	2020-05-31 06:30:53
47	20	35	iaculis, lacus pede sagittis	f	t	2022-04-03 23:50:37
48	71	38	luctus et ultrices posuere	t	f	2021-08-08 06:20:47
49	6	13	Fusce aliquam, enim nec	t	f	2021-05-26 20:51:46
50	50	92	odio tristique pharetra. Quisque ac	f	f	2020-06-06 13:41:45
51	98	76	enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque	f	t	2021-06-25 14:25:39
52	21	82	luctus vulputate, nisi sem semper erat,	f	t	2020-12-27 02:31:49
53	56	86	enim diam vel arcu. Curabitur ut odio	f	f	2021-04-22 02:23:15
54	95	87	elit, pharetra ut, pharetra sed, hendrerit a, arcu. Sed	f	t	2021-12-01 12:26:53
55	63	10	vitae, erat. Vivamus nisi. Mauris	f	t	2021-10-12 12:20:23
56	39	96	sed, hendrerit a, arcu. Sed et libero.	t	t	2022-03-10 21:14:15
57	10	73	ornare tortor at risus. Nunc ac sem ut dolor	f	f	2020-08-08 04:53:47
58	98	60	primis in faucibus	f	t	2021-11-10 03:28:50
59	5	35	turpis.	f	f	2022-01-20 03:00:22
60	6	64	vestibulum. Mauris magna.	f	f	2020-12-19 01:38:14
61	6	81	enim, gravida	f	t	2021-01-22 11:21:36
62	37	63	elit, dictum eu, eleifend nec,	f	t	2020-08-29 03:12:38
63	75	42	Duis dignissim tempor arcu. Vestibulum ut eros non enim	t	f	2020-09-21 23:43:39
64	27	60	Vestibulum accumsan neque et nunc. Quisque	t	f	2020-10-05 18:49:06
65	29	24	Donec consectetuer mauris id sapien. Cras dolor dolor,	t	t	2021-03-22 15:37:23
66	41	20	ac orci. Ut semper pretium neque. Morbi quis	f	f	2020-08-22 01:30:16
67	81	85	diam luctus lobortis. Class aptent taciti	f	f	2021-12-19 03:13:46
68	45	4	sem molestie sodales. Mauris blandit enim	t	f	2020-08-15 19:31:58
69	57	78	ut ipsum ac mi eleifend egestas. Sed pharetra,	f	t	2021-06-19 17:26:42
70	53	78	lectus rutrum urna, nec luctus felis purus ac tellus.	f	f	2021-03-11 05:47:27
71	81	90	orci sem eget massa. Suspendisse eleifend.	t	f	2022-05-17 14:13:04
72	95	23	ullamcorper viverra.	f	t	2020-08-22 12:40:27
73	37	54	placerat. Cras dictum ultricies ligula. Nullam enim.	t	t	2020-06-17 07:21:49
74	9	18	massa. Quisque porttitor eros nec tellus. Nunc	t	t	2021-05-12 18:22:52
75	76	50	tellus sem mollis	t	f	2020-09-24 01:38:45
76	7	55	Proin vel	f	t	2021-10-01 04:09:15
77	90	59	conubia	f	t	2021-08-19 13:12:18
78	72	74	et magnis dis parturient montes, nascetur	f	t	2020-11-17 14:47:55
79	50	96	eu, euismod ac, fermentum vel, mauris. Integer	f	t	2021-11-14 04:08:40
80	83	79	risus, at fringilla purus	f	f	2020-08-06 14:49:45
81	16	77	convallis dolor. Quisque tincidunt pede ac urna.	f	f	2022-01-08 22:05:43
82	4	30	urna. Ut tincidunt vehicula risus. Nulla	t	t	2021-06-19 06:40:27
83	86	34	est ac mattis semper, dui lectus rutrum urna,	t	f	2021-05-26 05:15:55
84	45	65	fermentum vel, mauris. Integer	f	f	2021-11-12 22:21:39
85	97	17	nulla at sem	t	f	2021-08-28 04:44:27
86	60	14	elit pede, malesuada vel, venenatis vel,	f	f	2021-01-08 09:31:49
87	70	83	venenatis a,	t	f	2021-02-06 16:27:08
88	69	49	ornare tortor at risus. Nunc ac sem ut dolor dapibus	f	t	2021-07-20 01:51:12
89	83	70	Praesent interdum ligula eu enim. Etiam imperdiet dictum magna. Ut	t	f	2021-07-03 09:02:45
90	82	79	lectus pede et risus. Quisque	t	t	2022-02-15 15:54:48
91	9	97	Ut nec urna et	t	t	2022-01-31 02:30:28
92	63	88	ipsum primis in faucibus orci luctus et ultrices posuere	t	t	2022-03-03 12:57:08
93	71	36	bibendum ullamcorper. Duis cursus,	f	t	2020-07-06 06:23:38
94	97	86	Duis ac arcu. Nunc mauris. Morbi non sapien molestie orci	f	f	2021-08-07 02:22:05
95	58	68	lectus quis	t	t	2021-09-24 01:06:39
96	62	78	magna. Lorem ipsum dolor sit amet, consectetuer adipiscing	t	f	2020-08-30 02:59:33
97	17	98	Morbi accumsan laoreet ipsum. Curabitur consequat,	t	t	2020-10-03 21:48:54
98	13	64	quam dignissim pharetra. Nam	t	t	2021-06-11 21:14:10
99	78	30	scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed,	t	t	2021-08-12 16:07:50
100	79	55	Nam nulla magna, malesuada vel,	f	t	2021-05-19 19:57:39
\.


--
-- Data for Name: other_profiles; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.other_profiles (user_id, twitter_name, tiktok_name, vk_name, telegram_name, viber_name, whatsapp_name, other_name) FROM stdin;
11	Rhoda Conway	Marny Dodson	Miriam Stafford	Belle Avery	Nigel Stein	Alden Whitney	Pamela Hood
12	Palmer Stevenson	Renee Adams	Hedwig Daniel	Velma Sullivan	Benjamin Calderon	Dane Bryant	Sawyer Acosta
13	Amber Bean	Maryam Flowers	Desirae Soto	Xanthus Vinson	Cally Hodges	Julie Newton	Suki Clements
14	Eric Lara	Karina Stewart	Ashton Pugh	Hedley Hebert	Cullen Mccall	Dexter Pope	Myra Raymond
15	Ralph Boyle	Odysseus Rutledge	John Juarez	Phoebe Mercado	Connor Velazquez	Pascale Livingston	Madison Burgess
16	Oprah Aguilar	Tallulah Page	Plato Mayo	William Dixon	Idona Best	Cyrus Oliver	Jerry Wells
17	Adrienne Boyle	Joel Nixon	Aladdin Rocha	Theodore Deleon	Indigo Burch	Nina Carter	Dale Dickerson
18	Chelsea Bruce	Dieter Holden	Quail Pennington	Yuri Herring	Mari Case	Lance Pearson	Barry Tucker
19	Rebecca Herring	Dahlia Hurst	Inga Vaughan	Yael Ellis	Cathleen Chambers	Reagan Kramer	Clinton Vazquez
20	Emerson Daniels	Bevis Mooney	Erin Nash	Kelly Franks	George Hayes	Tanner Williams	Audra Vinson
21	Paki Duncan	Kennedy Gentry	Guy Snyder	Dustin Williamson	Laura Bates	Todd Pace	Stewart Hamilton
22	Natalie Salinas	Oren Fuentes	Azalia Dyer	Myles Cortez	Xenos Avery	Coby Rhodes	Grady Kirkland
23	Cullen Duncan	Ryan Charles	Leonard Rivera	Adrienne Massey	Kessie Campbell	Ezra Booth	Laith Marsh
24	Olga Grimes	Cynthia William	Hunter Reyes	Grant Douglas	Riley Cote	Hilda Mcconnell	Jakeem Lloyd
25	Caesar Durham	Beau Gates	Kevin Salinas	Duncan Cervantes	Griffin Mejia	Marshall Owen	Patience Hardy
26	Madison Berg	Tana Larsen	Rowan Potter	Dalton Miranda	Aimee Pace	Jasper Luna	Jermaine Roach
27	Randall Hall	Denise Justice	Kane Charles	Raven Church	Rosalyn Best	Alec Booth	Carlos Ortega
28	Hall Espinoza	Barclay Sampson	Calista Simon	Arsenio Parks	Karen Rivers	Amal Malone	Oren Drake
29	Denton Atkinson	Burton Heath	Judah Kirby	Clinton Beasley	Nicholas Benson	Cailin Maddox	Michael Chase
30	Libby Hudson	Wyatt Garrett	Winter Harmon	Christian Wall	Gray Hyde	August Flynn	Doris Velazquez
31	Daryl Sweeney	Fallon Gomez	Camilla Mcneil	Whitney Stevens	Gray Noble	Beau Alexander	Troy Irwin
32	Caleb Hester	Burke Smith	Petra Roach	Gillian Contreras	Carol Walton	Philip Snow	Stone Shannon
33	Vaughan Roberts	Xavier Pittman	Erin Olson	Chester Glenn	Alisa Gaines	Cherokee Galloway	Hillary Chambers
34	Demetria Rice	Hyatt Witt	Chancellor Holder	Yael Aguilar	Tatiana English	Gay Flores	Hall Hull
35	Malik Mcclure	Leslie Dunlap	Florence Kinney	Merritt Hale	Allegra Serrano	Jeremy Zamora	Hayden Dunn
36	Nolan Foreman	Orla Randall	Galvin Stewart	Hedy Kim	Illana Solomon	Mara Barrett	Jermaine Velasquez
37	Alfreda Webster	Brennan Preston	Samantha Houston	Althea Franklin	Yuli Osborn	Miriam Larsen	India Patterson
38	Signe Glover	Josephine Glenn	Nina Oliver	Mark Cotton	Xander Lowery	Buffy Calhoun	Jocelyn Gregory
39	Cameran Nguyen	Brendan Copeland	Benjamin Beasley	Leo Harper	Linus Morgan	Branden Santiago	Edan Diaz
40	Leila Baird	Autumn Espinoza	Preston Dillard	Drake Rojas	Jeremy House	Cathleen Barnett	Meredith Mosley
41	Phelan Fletcher	Sasha Mcconnell	Candice Mcmillan	Clayton Robertson	Libby Burch	Angela Walter	Rina Whitaker
42	Fritz Gomez	Lewis Mccarty	Lydia Pate	Hyatt Gibson	Connor David	Brody Mercado	James Zimmerman
43	Indira Fischer	Cassady Wyatt	Debra Smith	Elizabeth Bartlett	Gannon Contreras	Bruno Gallagher	Sage Ingram
44	Lucy Vargas	Sybil Cardenas	Cairo Dillard	Shoshana Delacruz	Elton Skinner	Murphy Greene	Abigail O'Neill
45	Stephanie Garza	Howard Lang	Wylie Hebert	Ariana Farrell	Zia Martin	Aidan Hays	Damon Barry
46	Talon Grant	Lynn Bowers	Cameran Mueller	Destiny Frederick	Blake Wilder	Tatum Graham	Graiden Chavez
47	Hayfa Blackburn	Katell Sellers	Yasir Paul	Bree Reyes	Amanda Frederick	Leilani Pate	Benedict Stephenson
48	Hamilton Bell	Kai Gallagher	Eugenia Abbott	Jena Black	Karyn Velazquez	Avye Campos	Anjolie Britt
49	Dane Briggs	Brenda Horton	Preston Hull	Clayton Vang	Alea Byrd	Francesca Wooten	Naida Elliott
50	Fiona Joseph	Hilary Barry	Wayne Morgan	Olga Pierce	Latifah Marks	Maxine Ward	Dieter Sweeney
51	David Dunn	Britanney Vinson	Halla Salinas	Whilemina Cain	Alea Taylor	Travis Parker	Courtney Dillon
52	Howard Barnett	Lyle Aguirre	Phelan Luna	Linus Bruce	Brenda Oliver	Thane Neal	Brock Whitfield
53	Mary Giles	Reese Roth	Isaiah Wolf	Otto Macias	Teagan Stewart	Dale Snyder	Olga York
54	Paula Leach	Melyssa Rich	Rina Gibbs	Ariel Olsen	Gavin Cherry	Ruth Henry	Christopher Watson
55	Suki Stewart	Ray Hayden	Salvador Ferrell	Chloe King	Colin Walton	Gil Gallegos	Victor Dickerson
56	Grady Adams	Silas Wallace	Cally Sears	Bethany Hendricks	Kylee Mendoza	Elaine Estes	Simon Buck
57	Julian Solis	Jonah Landry	Dawn Hardin	Basil Bradley	Shaeleigh Cohen	September Noel	Lenore Terry
58	Haley O'donnell	Geraldine Jefferson	Wesley Joyner	Brandon Quinn	Vivien Walter	Minerva Gay	Elmo Adams
59	Tobias Roman	Grace Boyer	Jamalia Hendricks	Karly Macdonald	Ezekiel Lopez	Kasimir Ross	Anika Gamble
60	Daquan Newman	Reese Hartman	Cherokee Sellers	Mason Wood	Ignatius Macias	Burton Carrillo	Zia Patel
61	Wilma Steele	Jesse Middleton	Brenda Harmon	Travis Benton	Travis Huffman	Allegra Yang	Colt Beard
62	May Guerra	Melanie Odom	Britanney Macias	Cleo Moses	Simon Perkins	Griffith Mccullough	Jonah Sutton
63	Libby Crane	Myles Lucas	Luke Lindsay	Howard Witt	Brielle Maxwell	Cadman Mcdonald	Eric Skinner
64	Kelly Santiago	Theodore Cooper	Heather Merritt	Ella Rojas	Alyssa Vang	Mercedes Irwin	Simon Cummings
65	Steven Casey	Mannix Romero	Adrienne Ayers	Preston Anderson	Raya Cummings	Uma Blackburn	Brian Espinoza
66	Colorado Clemons	Nash Spence	Nehru Colon	Elliott Sanford	Yuli Mccoy	Julian Martinez	Roth Lowery
67	Lance Vaughn	Noel Conrad	Slade Mcfadden	Elliott Talley	Basil George	Malcolm Goodman	Tyler Sargent
68	Chancellor Hickman	Mari Mccarthy	Felicia Moreno	Emery Pickett	Sawyer Case	Preston Flynn	Cruz Dorsey
69	Quon Johns	Myles Taylor	Stacy Velez	Jasper Ruiz	Mariko Travis	Wade Cleveland	Shannon Petersen
70	Ira Castillo	Tate Rich	Camilla Roy	Laura Montgomery	Keegan Navarro	Byron Glenn	Duncan Acosta
71	Beau Moran	Abbot Rodriquez	Todd Moody	Devin Richards	Susan Burke	Nell Hardin	Alexander Frye
72	Michelle Wynn	Lara Hicks	Rooney Mcmillan	Malik Olsen	Dawn Hensley	Randall Fletcher	Lev Montgomery
73	Whitney Hopper	Minerva Trevino	Keefe Buck	Gavin Payne	Grant Britt	Fatima Douglas	Calista Rodriquez
74	Travis Hendrix	Harrison Acevedo	Scott Newman	Quentin Riley	Jaden Stokes	Gage Hays	Cody Hodges
75	Scarlet Dominguez	Jackson Church	Aurora Lawrence	Roanna Rojas	Sonia Preston	Natalie Jenkins	Graiden Macias
76	Valentine Mathews	Nell Herring	Harper Thomas	Evan Walters	Jack Cox	Kieran Keith	Serina Blackburn
77	Reagan Hebert	Leilani Horn	Oleg Gallegos	Fatima Terry	Rowan Caldwell	Rafael Sparks	Portia Conway
78	Elliott Davenport	Blaze Dotson	Buffy Marks	Sydnee Baird	Porter Tanner	Alexander Vincent	Brenna Barry
79	Joseph Hudson	Xanthus Gentry	Ronan Nolan	James Bolton	Mannix Mcdaniel	Kiona Slater	Myles Waters
80	Amy Shepherd	Jonah William	Reese Velazquez	Florence Yates	Cecilia Herring	Bree Christensen	Sawyer Huff
81	Vivien Downs	Shaine Velazquez	Simone Knox	Baker Dunlap	Scott Mcintyre	Whilemina Griffith	Wynter Sosa
82	Rinah Pena	Eaton Morrison	Aladdin Pena	Erich Patel	Aquila Pena	Keely Baird	Jared Hopkins
83	Anne Glover	Cameron Norman	Ayanna Grimes	Coby Craig	Macy Waller	Zia Mcpherson	Cameron Stevenson
84	Ryan Meadows	Harlan Hancock	Gail Mooney	Sybill Hendrix	Ulysses Stewart	Shea Rocha	Abra Peck
85	Brett Giles	Ciaran Hampton	Ferris Lowery	Maia Conway	Keefe Bishop	Alfreda Crawford	Anthony Marshall
86	Lunea Fuentes	Portia Rowe	Xaviera Riley	Dai Adams	Herrod Stephens	Lavinia Blackwell	Phoebe Pittman
87	Remedios Greer	Benedict Clemons	Nero Cruz	Veronica Vaughan	Paki Harris	Mufutau Lowe	Imogene Schwartz
88	Nicholas Gonzalez	Micah Key	Heather Ingram	Bradley Hardin	Xantha England	Ocean Salas	Boris Riley
89	Nadine Welch	Winter Underwood	Mohammad Ballard	Howard Bridges	Gabriel Casey	Audrey Holloway	Jakeem Peterson
90	Dominique Mcconnell	Helen Ramirez	Forrest Cantu	Madaline Morales	Mufutau Lindsay	Cally Burns	Ulysses Nicholson
91	Sawyer Norman	Randall Wilkins	Tucker Keith	Conan Bartlett	Simone Floyd	Kiara Joseph	Odysseus Cash
92	Slade Pearson	Raya Mcintosh	Kirk Leach	Karly Wolf	Otto Gonzalez	Cullen Moon	Xandra Mack
93	Haley Clark	Sonya Roth	Flynn Mcfadden	Montana Cook	Denton Potts	Kimberley Fowler	Colt Sampson
94	Amos Landry	Sylvester Barton	Alana Acevedo	Drew Barnett	Rylee Griffin	Quon Ward	Alana Parks
95	Henry West	Sybil Hoover	Logan Griffith	Kato Garcia	Hedy Gomez	April Hardy	Rashad Lawson
96	Linus Rosales	Kelly Chan	Brandon Roy	Inez Hendrix	Cairo Dillon	Marcia Hill	Jarrod Hobbs
97	Wendy Hunter	Kalia Watkins	Jamalia Jefferson	Fritz Greene	Kelsey Norman	Theodore Valdez	Ira Stafford
98	Kevin Petersen	Vernon Bailey	Vera Mosley	Shannon Sears	Jorden Byrd	Stephanie Zimmerman	Raymond Bridges
99	Jasmine Greer	Dolan Berg	Halla Rogers	Aiko Burns	Kiona Alford	Lael Lewis	Orlando Roth
100	India Vance	Nero Garrett	Christopher Barrera	Kuame Hahn	Kylee Dixon	Jelani Bishop	Hasad Acevedo
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.photo (id, url, owner_id, description, uploaded_at, size) FROM stdin;
1	https://nytimes.com/group/9	60	sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus	2021-12-15 18:55:16	1149
2	https://nytimes.com/site	78	ornare, facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida	2020-09-26 02:55:09	12521
3	http://reddit.com/sub	34	justo sit amet nulla. Donec non justo. Proin non massa	2021-10-06 18:07:44	4999
4	http://facebook.com/en-ca	94	Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui	2021-12-28 00:34:56	5402
5	https://wikipedia.org/group/9	64	sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem	2021-09-13 07:23:15	14812
6	http://pinterest.com/user/110	47	dolor. Fusce mi lorem, vehicula et, rutrum eu, ultrices sit	2021-01-15 04:07:40	10991
7	http://guardian.co	59	id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim	2021-08-29 18:21:33	3962
8	https://wikipedia.org/en-us	90	commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus	2020-11-22 23:00:49	28495
9	http://twitter.com/user/110	26	eu tempor erat neque non quam. Pellentesque habitant morbi tristique	2020-11-14 17:31:01	21287
10	http://google.com/one	76	Donec at arcu. Vestibulum ante ipsum primis in faucibus orci	2021-11-11 03:56:33	23045
11	https://facebook.com/group/9	97	consequat dolor vitae dolor. Donec fringilla. Donec feugiat metus sit	2020-09-15 09:19:05	6418
12	http://facebook.com/one	72	Duis volutpat nunc sit amet metus. Aliquam erat volutpat. Nulla	2021-02-08 01:21:20	1778
13	https://ebay.com/en-ca	35	orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu,	2020-10-28 04:01:41	9810
14	https://baidu.com/settings	11	iaculis nec, eleifend non, dapibus rutrum, justo. Praesent luctus. Curabitur	2020-11-08 03:32:02	6660
15	http://nytimes.com/user/110	98	aliquet vel, vulputate eu, odio. Phasellus at augue id ante	2021-10-05 20:29:24	6719
16	http://netflix.com/fr	96	tellus, imperdiet non, vestibulum nec, euismod in, dolor. Fusce feugiat.	2020-12-04 20:26:50	14071
17	https://pinterest.com/user/110	28	dictum eleifend, nunc risus varius orci, in consequat enim diam	2021-02-28 16:39:07	4182
18	https://ebay.com/one	99	morbi tristique senectus et netus et malesuada fames ac turpis	2022-01-18 15:04:18	20471
19	http://wikipedia.org/settings	23	eu eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec	2021-11-25 02:44:40	1834
20	http://ebay.com/user/110	25	molestie orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare,	2020-06-08 09:01:29	15819
21	http://guardian.co.uk/fr	23	gravida. Praesent eu nulla at sem molestie sodales. Mauris blandit	2021-05-10 14:27:09	12766
22	http://reddit.com/site	16	pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod	2020-12-27 07:21:21	16183
23	http://yahoo.com/one	62	felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam lorem,	2021-09-24 06:29:23	11820
24	https://reddit.com/user/110	7	feugiat. Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum	2021-11-20 14:29:10	409
25	https://twitter.com/user/110	87	Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet	2020-08-01 17:17:30	1580
26	http://nytimes.com/sub/cars	55	Donec felis orci, adipiscing non, luctus sit amet, faucibus ut,	2020-06-23 19:29:34	8685
27	http://instagram.com/en-us	44	Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper	2020-07-17 16:25:32	18962
28	https://wikipedia.org/fr	60	Nullam scelerisque neque sed sem egestas blandit. Nam nulla magna,	2022-02-04 19:58:15	21838
29	http://reddit.com	9	velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas.	2020-09-01 15:22:20	19982
30	http://netflix.com/group/9	83	placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam nisl.	2021-04-01 02:04:35	21748
31	http://instagram.com	50	purus. Maecenas libero est, congue a, aliquet vel, vulputate eu,	2020-11-09 02:34:08	29830
32	https://naver.com/en-us	77	libero et tristique pellentesque, tellus sem mollis dui, in sodales	2022-03-03 19:06:17	1640
33	https://baidu.com/group/9	99	semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices	2020-11-29 00:24:58	18928
34	https://youtube.com/en-us	52	sit amet diam eu dolor egestas rhoncus. Proin nisl sem,	2021-01-14 10:38:53	8312
35	http://netflix.com/settings	73	a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras	2022-02-19 08:05:02	14849
36	https://ebay.com/fr	93	dolor. Fusce feugiat. Lorem ipsum dolor sit amet, consectetuer adipiscing	2021-10-07 06:20:46	16873
37	https://instagram.com/sub	96	molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas ornare	2022-01-29 14:22:18	25666
38	http://cnn.com/settings	98	non lorem vitae odio sagittis semper. Nam tempor diam dictum	2022-01-06 14:41:50	20781
39	https://netflix.com/user/110	44	libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet	2022-01-04 16:05:07	11203
40	https://cnn.com/en-ca	12	mus. Proin vel arcu eu odio tristique pharetra. Quisque ac	2021-05-10 04:52:33	23298
41	https://pinterest.com/one	45	vulputate dui, nec tempus mauris erat eget ipsum. Suspendisse sagittis.	2020-07-19 22:01:46	26366
42	https://ebay.com/site	40	eget, dictum placerat, augue. Sed molestie. Sed id risus quis	2021-02-21 21:23:36	4956
43	https://youtube.com/en	35	est, congue a, aliquet vel, vulputate eu, odio. Phasellus at	2020-12-15 05:43:13	12864
44	https://walmart.com/group/9	33	sit amet, consectetuer adipiscing elit. Etiam laoreet, libero et tristique	2020-09-05 23:57:53	10627
45	https://guardian.co.uk/en-ca	41	imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non,	2021-01-16 07:34:46	27528
46	http://google.com/sub	15	Donec felis orci, adipiscing non, luctus sit amet, faucibus ut,	2020-05-30 00:19:08	26999
47	http://pinterest.com/site	25	pretium neque. Morbi quis urna. Nunc quis arcu vel quam	2021-03-05 10:42:09	9985
48	https://whatsapp.com/one	91	fringilla. Donec feugiat metus sit amet ante. Vivamus non lorem	2021-10-09 07:54:18	6968
49	https://zoom.us/en-us	26	tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed	2020-11-26 01:21:42	21634
50	http://instagram.com/user/110	77	vitae velit egestas lacinia. Sed congue, elit sed consequat auctor,	2022-02-08 11:22:53	16006
51	http://naver.com/settings	43	est, mollis non, cursus non, egestas a, dui. Cras pellentesque.	2021-03-22 04:56:22	21861
52	https://pinterest.com/en-ca	14	odio vel est tempor bibendum. Donec felis orci, adipiscing non,	2021-04-25 16:15:22	888
53	http://walmart.com/sub	58	ante. Vivamus non lorem vitae odio sagittis semper. Nam tempor	2022-05-05 17:49:42	21752
54	https://cnn.com/one	40	vitae, posuere at, velit. Cras lorem lorem, luctus ut, pellentesque	2020-06-17 02:49:50	8581
55	http://netflix.com/sub/cars	12	mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris	2020-10-05 18:17:43	25562
56	http://baidu.com/site	7	erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus	2021-03-18 22:41:49	13378
57	http://baidu.com/sub	27	odio. Nam interdum enim non nisi. Aenean eget metus. In	2021-09-21 10:13:57	12211
58	https://reddit.com/sub/cars	17	a, magna. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.	2020-08-30 06:59:23	21511
59	https://baidu.com/site	63	tellus. Aenean egestas hendrerit neque. In ornare sagittis felis. Donec	2022-04-15 23:26:36	434
60	http://netflix.com	49	amet, dapibus id, blandit at, nisi. Cum sociis natoque penatibus	2022-02-10 17:25:35	10501
61	http://naver.com/en-us	23	egestas hendrerit neque. In ornare sagittis felis. Donec tempor, est	2020-06-29 06:07:48	10878
62	http://google.com	97	Donec sollicitudin adipiscing ligula. Aenean gravida nunc sed pede. Cum	2020-08-14 19:01:55	27649
63	https://ebay.com	3	Pellentesque tincidunt tempus risus. Donec egestas. Duis ac arcu. Nunc	2021-02-10 13:56:06	1387
64	https://facebook.com/one	47	nunc. Quisque ornare tortor at risus. Nunc ac sem ut	2021-07-13 23:32:49	28173
65	http://nytimes.com/group/9	19	risus varius orci, in consequat enim diam vel arcu. Curabitur	2022-04-09 14:11:03	7679
66	https://bbc.co.uk/sub	53	libero. Proin mi. Aliquam gravida mauris ut mi. Duis risus	2021-01-31 13:10:35	18708
67	https://twitter.com/group/9	5	vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce	2021-08-30 19:15:14	25320
68	https://ebay.com/ru	75	ornare, lectus ante dictum mi, ac mattis velit justo nec	2022-04-29 02:44:00	14390
69	http://walmart.com/one	21	ut, pharetra sed, hendrerit a, arcu. Sed et libero. Proin	2021-02-13 14:42:13	14602
70	http://wikipedia.org/one	20	sed pede nec ante blandit viverra. Donec tempus, lorem fringilla	2022-05-20 17:11:50	7131
71	https://google.com/fr	72	ut, sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla	2021-10-06 14:39:40	19765
72	https://twitter.com/en-ca	57	ornare sagittis felis. Donec tempor, est ac mattis semper, dui	2020-06-08 12:43:04	23160
73	http://ebay.com/sub	4	non, feugiat nec, diam. Duis mi enim, condimentum eget, volutpat	2021-07-09 19:44:09	2838
74	http://instagram.com/one	83	orci. Ut semper pretium neque. Morbi quis urna. Nunc quis	2022-02-12 16:35:34	10026
75	http://guardian.co.uk/site	16	facilisis non, bibendum sed, est. Nunc laoreet lectus quis massa.	2021-06-19 23:07:51	4057
76	https://walmart.com/fr	10	Cum sociis natoque penatibus et magnis dis parturient montes, nascetur	2020-12-03 02:08:24	9285
77	https://google.com/settings	86	at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas	2021-07-05 01:59:38	6800
78	https://nytimes.com/one	4	neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede	2021-02-10 01:24:15	18941
79	https://netflix.com/settings	32	sit amet nulla. Donec non justo. Proin non massa non	2020-10-03 12:46:06	1349
80	https://youtube.com	18	dictum eleifend, nunc risus varius orci, in consequat enim diam	2021-03-24 04:42:55	22417
81	http://naver.com/sub	56	sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam	2022-04-14 01:48:40	13244
82	https://guardian.co.uk	74	faucibus orci luctus et ultrices posuere cubilia Curae Phasellus ornare.	2020-06-22 16:39:08	12230
83	http://cnn.com/en-us	32	risus. Donec nibh enim, gravida sit amet, dapibus id, blandit	2021-04-03 06:10:53	14292
84	https://facebook.com/sub/cars	87	neque. Nullam ut nisi a odio semper cursus. Integer mollis.	2022-03-13 00:46:58	26099
85	http://facebook.com/sub/cars	8	Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet	2021-09-23 04:37:57	4004
86	https://youtube.com/settings	77	Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci.	2022-03-31 21:57:13	21474
87	http://reddit.com/settings	18	dapibus quam quis diam. Pellentesque habitant morbi tristique senectus et	2021-08-11 06:08:50	2661
88	https://wikipedia.org	65	Fusce mi lorem, vehicula et, rutrum eu, ultrices sit amet,	2021-03-09 05:59:11	10556
89	http://pinterest.com/en-us	19	at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac	2021-04-06 05:41:43	23308
90	https://baidu.com/user/110	69	Cum sociis natoque penatibus et magnis dis parturient montes, nascetur	2022-01-22 08:25:32	26017
91	https://baidu.com/one	85	sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus	2021-09-25 10:03:57	11909
92	http://reddit.com/one	57	Mauris ut quam vel sapien imperdiet ornare. In faucibus. Morbi	2022-02-04 11:52:01	2201
93	https://google.com/en-us	80	et, euismod et, commodo at, libero. Morbi accumsan laoreet ipsum.	2021-10-16 03:21:38	22403
94	http://facebook.com/site	48	Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio.	2021-09-11 01:48:51	18268
95	http://facebook.com/sub	7	quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam	2021-07-30 11:24:27	11696
96	https://zoom.us/one	47	Maecenas ornare egestas ligula. Nullam feugiat placerat velit. Quisque varius.	2022-03-27 09:00:18	29801
97	https://naver.com/site	77	mauris a nunc. In at pede. Cras vulputate velit eu	2021-09-21 22:44:42	24485
98	http://cnn.com	16	gravida nunc sed pede. Cum sociis natoque penatibus et magnis	2021-03-14 04:49:30	18853
99	https://instagram.com/sub/cars	34	odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam	2021-03-17 03:55:42	28306
100	https://pinterest.com/settings	12	vitae, orci. Phasellus dapibus quam quis diam. Pellentesque habitant morbi	2021-01-16 14:33:20	25529
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.profiles (user_id, main_photo_id, date_of_birth, location, career, studies, army, created_at) FROM stdin;
1	98	1973-01-16 14:11:38	Yeosu	In Cursus Et Incorporated	Pede Cum Sociis Corp.	In Aliquet Company	2017-09-11 05:54:12
2	21	1993-10-27 08:20:02	Pereira	Pellentesque Massa Incorporated	At Velit Ltd	Vivamus LLC	2020-09-09 01:37:39
3	70	2015-07-29 23:17:46	Dera Bugti	Diam Sed Associates	At Limited	Amet Metus LLC	2020-09-25 19:34:31
4	29	2001-01-06 18:33:17	Sullana	Praesent Interdum PC	Faucibus Orci Luctus Associates	Nullam Vitae LLC	2020-02-19 18:13:55
5	85	2015-02-22 14:51:36	Villahermosa	Pede PC	Eu Sem Incorporated	Ligula Consectetuer Corp.	2020-04-22 04:47:17
6	13	2019-06-06 12:59:21	Lambayeque	Conubia Nostra Industries	Condimentum Inc.	Dui Inc.	2018-01-16 14:44:39
7	60	1985-12-26 16:11:42	Ockelbo	Mauris Vestibulum Inc.	Porttitor Eros LLP	Aliquet Lobortis Foundation	2016-08-07 01:18:41
8	57	1980-02-08 05:03:52	Sokoto	Odio Incorporated	Velit Aliquam Ltd	Ut Nec Urna Incorporated	2018-12-08 01:16:01
9	19	2005-01-27 06:04:41	Tønsberg	Urna Company	Tellus Faucibus Foundation	Fusce PC	2019-11-06 20:47:39
10	99	1996-03-18 04:52:54	Bismil	Urna Suscipit Institute	Ullamcorper Duis Associates	Dolor Associates	2020-06-24 07:47:58
11	75	1994-02-08 23:12:52	Makurdi	Eleifend Non Dapibus Institute	Consectetuer Institute	Tortor Institute	2019-07-20 21:25:53
12	37	2000-12-17 11:51:40	Lodhran	Quis Arcu Vel Institute	Pretium Incorporated	Egestas A Dui Corporation	2017-05-27 19:01:57
13	50	1972-04-25 07:49:49	Timaru	In Nec PC	Dictum Magna Ut Corporation	Nec Tellus Limited	2022-04-01 17:57:19
14	81	1971-12-10 05:55:07	Hamburg	Euismod Consulting	Venenatis Vel Faucibus LLP	Egestas Rhoncus Proin PC	2017-04-15 15:30:03
15	59	1984-08-14 17:01:47	Karacabey	Tristique Aliquet Inc.	Dictum Phasellus LLP	Scelerisque Sed Sapien Industries	2020-09-09 20:04:07
16	99	1975-09-22 10:16:43	Phalaborwa	Magna Sed Corp.	Leo Cras LLC	Turpis Egestas Ltd	2019-10-15 02:09:41
17	69	2003-09-03 18:01:33	Gadag Betigeri	Nec Quam Corp.	Mattis Cras Eget LLP	Nonummy Industries	2019-10-03 04:46:43
18	94	1976-11-19 22:32:39	Cáceres	Id Libero Limited	Pellentesque Corp.	Faucibus Id Libero Limited	2020-05-23 22:34:07
19	61	1985-09-09 13:10:18	Anápolis	Pellentesque A Corp.	Mi Ac PC	Aliquam Eros PC	2016-06-10 20:52:44
20	73	2014-08-07 04:35:36	Awka	Cursus Diam At Associates	Amet Incorporated	Phasellus At LLC	2020-05-31 20:09:43
21	20	1974-09-30 00:56:16	Konotop	Etiam Associates	At Pede Incorporated	Nascetur Ridiculus Corp.	2021-01-24 04:40:09
22	5	1970-09-07 06:56:00	Sabadell	Neque Tellus Imperdiet Limited	Arcu Consulting	Ultricies Dignissim Ltd	2019-01-18 13:38:07
23	73	1990-03-18 09:16:47	Phalaborwa	Ultrices Mauris Ipsum Limited	Dolor Fusce Mi Inc.	Vestibulum Massa PC	2017-07-21 06:17:24
24	82	1985-07-09 16:18:44	Koszalin	Phasellus Elit Pede Industries	Id Ante Nunc Ltd	Sociis Company	2017-06-02 15:51:18
25	24	1993-12-19 18:24:23	Tolyatti	Nunc Id Enim LLP	Lobortis Quis Inc.	Tincidunt Corp.	2018-12-17 06:12:21
26	85	1976-03-16 23:40:16	Hengelo	Tellus Faucibus Leo Foundation	Tincidunt PC	Vitae Aliquam LLP	2017-04-08 10:56:40
27	29	2005-07-04 02:14:43	Rhyl	Et Rutrum LLP	Mi Foundation	Id Ante Dictum Corp.	2017-11-19 14:19:11
28	50	2016-09-05 22:49:24	Hamar	Ligula Donec LLP	Gravida Praesent Inc.	Sit Limited	2022-01-11 03:40:24
29	47	2014-07-03 05:39:34	Santiago	Luctus Institute	Dignissim Pharetra PC	Aliquet Proin Velit Inc.	2021-04-03 20:55:34
30	51	1973-07-14 09:53:34	Orroli	Consequat Lectus Ltd	Non Consulting	Vestibulum Ante Ipsum Limited	2019-06-13 13:28:48
31	38	2019-04-26 02:11:42	Mexico City	Elit LLP	Curabitur Company	Nec Urna Suscipit Corp.	2021-06-22 07:23:43
32	60	2003-02-09 21:06:17	Bakhmut	Nisi Nibh Institute	Fusce Associates	Est Mauris Corp.	2021-04-08 07:11:40
33	62	2016-01-15 14:32:24	Cork	Dui Limited	Et Incorporated	Porttitor Interdum Consulting	2017-03-09 11:57:01
34	53	1971-11-04 18:53:58	Cañas	Curabitur Vel Company	Sagittis Duis Associates	Id Incorporated	2022-04-14 09:03:22
35	68	2021-05-05 07:01:35	Dutse	Sed Consulting	Orci Donec Nibh Corp.	Sed Incorporated	2020-12-29 00:56:13
36	50	2012-09-06 13:08:17	Launceston	Eu Institute	Lectus Quis Massa LLP	Velit LLC	2020-10-20 16:58:08
37	3	1995-09-15 05:18:29	San Pancrazio Salentino	Dictum Sapien Corp.	Viverra Maecenas LLC	Eget Odio Incorporated	2020-02-16 20:16:05
38	7	1974-12-17 15:15:07	Coevorden	Nunc Corp.	Purus Ac Tellus Industries	Pellentesque Tincidunt Incorporated	2021-08-29 04:29:22
39	3	2005-10-11 15:19:08	Springdale	Nec Urna Corporation	Luctus Aliquet Associates	Curabitur Sed PC	2018-01-14 07:09:18
40	14	2019-07-20 12:07:41	Jonesboro	Nulla Tempor LLP	Molestie Pharetra Inc.	Tristique Senectus Foundation	2018-12-02 09:33:04
41	63	2012-02-29 19:08:13	Belém	Sed Dictum PC	Sed Foundation	Ipsum Dolor Inc.	2018-06-10 20:39:03
42	36	1995-12-27 03:29:32	Puntarenas	Duis Foundation	Tellus PC	Vel Arcu LLC	2017-11-21 14:30:36
43	8	1982-09-14 22:09:51	Porsgrunn	Convallis Est Limited	Non Leo Ltd	At Augue Company	2018-11-13 16:57:58
44	59	1975-12-14 05:55:35	Greater Hobart	Metus In Corp.	Aliquet Proin Institute	Suspendisse Company	2020-04-22 08:23:55
45	50	2019-07-31 17:10:24	Kaliningrad	Lectus Pede Ultrices Associates	Nullam Vitae Diam Corporation	Ornare Lectus LLC	2019-12-23 14:21:26
46	24	1989-12-06 00:42:09	Vienna	A LLC	Non Foundation	Sed Malesuada Augue Associates	2019-03-16 17:15:49
47	97	1985-02-14 00:55:09	Bayugan	Pede Praesent Incorporated	Magna Incorporated	Nunc Sed PC	2020-10-26 01:42:16
48	16	1977-08-30 02:58:48	Watson Lake	Luctus Aliquet Corporation	Imperdiet Dictum Magna LLP	Enim Condimentum PC	2019-06-04 21:30:11
49	53	2004-06-21 06:06:31	Manisa	Tincidunt LLP	Rutrum Lorem Ac Inc.	Donec LLC	2019-06-23 12:10:28
50	17	1987-09-01 00:34:14	Galway	Nisi A Odio Corporation	Ipsum Dolor Corporation	Gravida Inc.	2016-12-18 03:18:44
51	92	1978-03-01 11:47:51	San Rafael	Et Rutrum PC	Nulla Eget Foundation	Nisi Institute	2016-09-17 21:41:22
52	11	1977-12-22 02:36:03	Bedok	Fringilla PC	Ultrices Associates	Nullam Velit Inc.	2020-06-21 07:01:48
53	22	2012-04-20 06:50:54	Westport	Nibh Lacinia Corp.	Nonummy Ac Limited	Ullamcorper Associates	2021-10-12 22:43:23
54	27	1976-09-03 03:53:09	Sokoto	Urna Justo LLP	Vehicula Limited	Auctor Associates	2017-04-27 20:35:27
55	21	1970-07-22 02:05:13	Marabá	Sit Amet Lorem Inc.	Amet Ultricies Foundation	Tortor Integer Limited	2016-08-11 13:23:39
56	93	1995-07-01 00:45:13	Okene	A Ultricies Limited	Aliquam Auctor Industries	Sagittis Augue Eu Ltd	2021-03-15 14:03:55
57	79	2002-12-27 00:53:19	Gongju	Mus Company	Eu Odio Industries	Maecenas Ornare Corporation	2019-04-17 23:45:10
58	14	1988-04-18 10:28:44	Bergen	Et Magnis Dis Ltd	Donec Dignissim Magna PC	Fusce Mi Associates	2021-10-24 05:31:26
59	13	1983-01-11 05:40:30	Canberra	Cras Corp.	Maecenas Mi Felis Institute	Molestie Orci Tincidunt Company	2017-09-19 05:08:29
60	12	2016-03-11 07:37:56	Göksun	Volutpat Nulla Inc.	Sollicitudin Associates	Egestas Aliquam Inc.	2019-09-25 05:37:28
61	100	1998-06-05 01:15:24	Inírida	Sit Amet Limited	Montes Nascetur Institute	Habitant Morbi Inc.	2018-08-16 22:32:55
62	42	2022-04-10 21:51:18	Rutland	Lobortis PC	In Consectetuer LLC	Netus Et Malesuada PC	2017-06-08 05:13:07
63	20	2012-12-16 16:48:35	Burnie	Vestibulum Nec Euismod Corp.	Arcu Imperdiet Foundation	Tristique LLC	2020-04-05 18:25:15
64	2	2003-04-24 01:20:19	Secunda	Duis At LLC	Odio Auctor Vitae Associates	Nec Leo Institute	2017-08-10 09:13:42
65	3	2002-01-27 12:51:51	Galway	Amet Ultricies Foundation	Non Massa Non LLC	Natoque Penatibus Institute	2017-04-07 01:42:57
66	4	2005-02-02 22:52:38	Fort Collins	Eu Accumsan Sed Corporation	Cras Pellentesque Sed LLP	Consectetuer Ltd	2021-08-25 04:52:57
67	30	1992-07-03 11:41:26	Heredia	Nulla Industries	Urna Vivamus Consulting	Neque Morbi Quis Incorporated	2017-03-20 05:30:58
68	87	1998-06-14 03:22:06	Gangneung	Libero Associates	Euismod Est Inc.	Adipiscing Enim Consulting	2019-04-01 12:22:19
69	49	2001-02-26 14:59:19	Katowice	Eget Mollis Corp.	Ullamcorper Duis Ltd	Non Ante PC	2016-09-22 20:16:08
70	96	1989-07-03 02:53:54	Tomaszów Mazowiecki	Consectetuer Adipiscing Elit Associates	Donec Corp.	Nunc Risus Foundation	2020-05-10 19:43:36
71	62	1996-10-14 13:02:42	Baguio	Lectus Associates	Tincidunt Donec LLC	Erat Vivamus Inc.	2019-05-24 15:44:06
72	79	1977-02-25 03:30:09	Perk	Nam Consequat Dolor PC	Justo LLC	Pede Malesuada Vel Corporation	2020-10-22 17:47:27
73	42	1981-04-13 05:27:27	Şereflikoçhisar	Dapibus Quam Quis PC	Fermentum Associates	Auctor Ullamcorper Nisl Corp.	2021-08-22 01:08:01
74	81	1977-05-13 07:32:38	Cametá	Proin Vel Arcu Consulting	Ipsum Corporation	Eget Inc.	2018-05-29 22:04:39
75	18	1974-06-10 22:33:27	Puno	Ligula Donec Ltd	Nonummy Incorporated	Diam Sed Ltd	2018-08-03 15:12:38
76	87	2000-03-02 02:51:26	Ovalle	Penatibus Et Industries	Orci Corp.	Sem Pellentesque LLP	2019-10-22 23:04:34
77	77	1999-12-28 03:44:06	Suncheon	Est Industries	Fusce Foundation	Amet Ornare Limited	2019-11-14 00:29:24
78	71	2000-12-17 12:34:39	Siquirres	Ullamcorper Nisl LLC	Feugiat Metus Sit LLC	Elit Erat Company	2018-09-06 23:39:30
79	60	1984-04-24 07:44:44	Killa Saifullah	Ipsum Limited	Nec Eleifend Limited	Nunc Inc.	2018-01-31 16:50:02
80	61	2005-03-28 21:34:01	Bangalore	Non Leo Corporation	Hendrerit Donec Corp.	Lobortis Ultrices Ltd	2019-12-23 11:35:05
81	55	2012-07-07 18:46:49	Jemappes	Nisl Quisque Consulting	Sem Magna Nec LLP	Ut Tincidunt Orci LLC	2021-04-01 17:17:26
82	69	2000-04-08 16:34:19	Białystok	Est Mauris LLP	Quam Elementum LLC	Proin Foundation	2018-06-20 08:54:22
83	43	1980-05-07 11:12:33	Reading	Mollis Foundation	Nascetur Ridiculus Mus Associates	Dui Fusce Diam LLC	2018-06-12 05:57:03
84	14	2005-04-21 04:30:36	Ijebu Ode	Lacinia Mattis LLP	Convallis Convallis Dolor LLP	Adipiscing Elit PC	2017-02-12 06:22:11
85	4	1997-08-17 21:29:48	Balıkesir	Nec Enim Inc.	Diam Proin Industries	Orci In Ltd	2020-10-10 08:48:52
86	67	1999-05-26 03:01:26	Odendaalsrus	Imperdiet Ornare Limited	Ornare Facilisis Inc.	Enim Suspendisse Limited	2017-09-06 14:04:00
87	92	1982-04-23 11:46:19	Huntly	Justo Praesent Company	Et Eros Corporation	Sagittis Augue Limited	2019-11-11 16:17:12
88	83	1985-07-27 17:10:06	Ryazan	Dolor Nonummy Ltd	Faucibus Leo Consulting	Eros Proin Industries	2019-06-03 15:03:53
89	25	2002-08-26 17:33:48	Khuzdar	Pharetra Nam LLC	Mauris Inc.	Per Conubia Nostra Corporation	2020-09-11 14:17:54
90	50	1995-04-30 09:47:29	Mandai	Magna Ut PC	Sit Amet Consectetuer Industries	Nulla Integer Ltd	2017-12-01 03:40:07
91	56	1977-07-20 10:43:56	Mollem	Non Justo Limited	Arcu Limited	Tortor At Foundation	2019-08-31 09:39:01
92	5	2021-11-10 11:58:13	Jhansi	Adipiscing Mauris Molestie Corp.	Ut Dolor Dapibus PC	Leo Vivamus Nibh Consulting	2021-01-03 15:14:44
93	44	1994-10-09 14:28:33	Geertruidenberg	Lacus Etiam Bibendum Inc.	Erat Volutpat Nulla LLC	Duis Elementum Dui Limited	2018-06-29 17:45:23
94	86	2008-01-07 01:44:20	Workum	Consectetuer Mauris Foundation	Nisl Maecenas Malesuada Incorporated	Sit LLP	2018-07-04 00:49:42
95	43	1970-06-08 13:00:47	Barranca	Mollis Integer Tincidunt Industries	Ut Industries	Nibh Industries	2019-08-21 04:46:36
96	28	1994-08-04 20:57:22	Chepén	Id Corporation	Enim Curabitur Corporation	Erat Etiam Vestibulum Corporation	2016-10-04 13:23:34
97	48	1979-05-08 10:01:12	Vigo	Maecenas Mi Felis LLC	Lectus Ante Corp.	Diam LLP	2017-06-30 06:32:52
98	84	1978-10-25 19:23:12	Kristiansand	Condimentum Eget PC	Id Libero PC	Massa Vestibulum Ltd	2018-07-02 09:18:57
99	44	2005-02-14 14:19:56	Vigan	Nonummy Corp.	Inceptos Hymenaeos Consulting	Dui Suspendisse Corp.	2016-11-09 09:58:57
100	9	1993-06-01 22:14:11	Körfez	Adipiscing Lobortis Foundation	Nec Malesuada LLC	Ultrices Vivamus Corp.	2018-05-11 22:15:48
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.users (id, first_name, last_name, email, phone) FROM stdin;
1	Griffin	Duffy	eu@outlook.org	1-377-180-7371
2	Thane	Duke	sagittis.placerat.cras@aol.net	1-952-625-3932
3	Pamela	Mercer	quis.diam@protonmail.couk	1-117-783-6741
4	Deanna	Norton	dignissim@google.org	582-2151
5	Sonya	Bush	dolor.fusce.mi@aol.com	1-837-217-7981
6	Jonas	Mcleod	nonummy.ac@icloud.com	1-654-248-8377
7	Josephine	Ray	sed@hotmail.edu	1-268-940-5525
8	Kevyn	Bridges	convallis.ante@aol.couk	343-1245
9	Lavinia	Coleman	et.magnis@outlook.net	704-8381
10	Kaitlin	Burks	orci.donec@yahoo.org	1-801-667-5670
11	Neil	Burris	tincidunt@icloud.edu	1-570-446-6477
12	Xanthus	Buchanan	arcu.morbi@aol.ca	516-6457
13	Basil	Mason	donec.fringilla@outlook.com	193-6125
14	Ferdinand	Mendoza	lacus@google.edu	1-648-382-1342
15	Ebony	Goodwin	vel.vulputate.eu@protonmail.org	926-6912
16	Cora	Landry	blandit@google.net	796-2307
17	Stephen	Floyd	felis.orci@yahoo.com	628-4558
18	Stuart	Reed	montes@protonmail.net	642-7752
19	Darryl	Snow	odio.nam@aol.net	228-4057
20	Connor	Baird	amet.dapibus.id@aol.edu	575-2421
21	Joan	Fischer	arcu.vestibulum@icloud.couk	1-810-214-7837
22	Lareina	Hewitt	tempus@outlook.org	132-3104
23	Dane	Sloan	varius.et@google.com	1-433-885-9617
24	Alec	Rosario	quisque.porttitor@icloud.org	1-480-814-8413
25	Thomas	Grimes	proin.dolor.nulla@protonmail.org	1-874-744-4411
26	Sandra	Franks	metus.eu@hotmail.net	209-3341
27	Caesar	Hill	curabitur.consequat@google.com	1-721-354-4773
28	Giacomo	Allison	enim.etiam@yahoo.ca	1-223-558-6852
29	Nero	Norris	quam.vel@hotmail.net	1-581-842-8290
30	Boris	Morton	amet.consectetuer@protonmail.edu	212-0711
31	Galena	Pittman	nibh@hotmail.org	1-340-653-7114
32	Zahir	Cochran	at.pretium@yahoo.net	720-5627
33	Curran	Wall	nibh.sit.amet@google.ca	483-6143
34	Rowan	Scott	mollis@icloud.edu	838-7585
35	Daquan	Buckner	quam.vel@icloud.edu	318-9836
36	Azalia	Hicks	amet.lorem.semper@google.com	1-684-870-3469
37	Dexter	Pope	rutrum.magna@icloud.net	1-426-234-4116
38	Gwendolyn	Dejesus	sollicitudin.a@google.couk	418-6062
39	Jason	Shaffer	vel.mauris@outlook.org	516-5535
40	Keely	Bell	phasellus.libero.mauris@protonmail.couk	830-4323
41	Alec	Dejesus	aliquet.nec@aol.edu	1-855-127-8706
42	Brenden	Hoover	non.quam@google.org	1-910-194-2874
43	Lars	Mcpherson	mi.lacinia@outlook.net	1-313-904-1443
44	Dominic	Rowe	lobortis@yahoo.ca	594-8114
45	Samson	Lewis	libero.proin@aol.net	245-7859
46	Vladimir	Dean	euismod.enim@google.org	1-355-675-5674
47	Kylee	Salinas	accumsan.convallis@yahoo.com	1-662-685-0653
48	Walter	Fulton	ut.dolor.dapibus@hotmail.edu	1-263-449-4560
49	Cally	Cruz	vitae.risus@protonmail.edu	1-926-470-8084
50	Oleg	Witt	arcu.nunc.mauris@aol.couk	787-6471
51	Wayne	Valencia	mi@protonmail.net	978-8718
52	Kelsie	Downs	sociis.natoque@icloud.com	1-373-662-5672
53	Dahlia	Mcintyre	ut.lacus@hotmail.ca	1-178-780-4799
54	Reuben	Welch	vel@aol.org	681-6766
55	Nora	Miles	non.magna@google.org	213-4549
56	Omar	Calderon	ut.pellentesque@protonmail.edu	1-645-863-5125
57	Alfreda	Blevins	elit.curabitur@outlook.org	1-273-932-5719
58	Stuart	Chaney	rutrum.lorem@outlook.net	1-882-642-7653
59	Addison	Castillo	lacus.aliquam@aol.net	1-678-344-8879
60	Nathaniel	Bishop	diam.duis.mi@hotmail.edu	866-3134
61	Giselle	Hall	elit@protonmail.com	963-1536
62	Quin	Preston	nunc.ullamcorper@protonmail.com	823-3427
63	Urielle	Leonard	pellentesque.tincidunt@icloud.org	143-3412
64	Rajah	Colon	duis@aol.org	753-4685
65	Josephine	Dixon	libero.dui.nec@protonmail.ca	1-586-416-6532
66	Denise	Wells	metus.urna@hotmail.com	351-7094
67	Colin	Hodge	lorem.vehicula@yahoo.com	1-851-515-6267
68	Eric	Salas	curabitur.massa@protonmail.net	1-374-759-6710
69	Adena	Pacheco	cursus.luctus@protonmail.couk	1-613-551-3795
70	Audrey	Curtis	auctor@protonmail.edu	1-416-184-8412
71	Kalia	Hunt	cras@yahoo.ca	1-138-387-4684
72	Sasha	Hooper	et.lacinia@outlook.edu	1-358-286-8632
73	Raja	Kelly	vestibulum.nec@aol.org	1-137-589-2742
74	Lars	Acosta	odio@icloud.net	717-1766
75	Michael	Roman	eleifend.nunc@protonmail.couk	492-3147
76	Brenden	Hawkins	cursus.nunc@yahoo.org	1-691-482-3914
77	Natalie	Rowe	in.scelerisque@protonmail.edu	1-337-871-1560
78	Josiah	Campbell	dapibus.rutrum@hotmail.couk	639-9558
79	Addison	Williamson	mus.donec.dignissim@outlook.couk	488-6787
80	Nita	Dillard	nulla.ante@protonmail.couk	974-4920
81	Jasmine	Bonner	malesuada.fames.ac@aol.couk	1-242-362-1538
82	Bert	Carpenter	velit@outlook.com	1-649-318-1805
83	Ora	Carlson	ac.libero@outlook.org	385-3718
84	Kermit	Santiago	ridiculus.mus@outlook.couk	124-6187
85	Piper	Beach	enim.consequat.purus@icloud.ca	232-5965
86	Clayton	Rush	eu.dui@yahoo.com	1-238-978-6242
87	Ima	Rich	ad.litora@icloud.org	1-286-353-7022
88	Plato	Jordan	faucibus@hotmail.org	743-9706
89	Darius	Henson	facilisis.facilisis@outlook.org	371-4875
90	Rigel	Snow	donec.at@hotmail.edu	465-2594
91	Portia	Parker	rutrum.magna.cras@aol.com	813-2997
92	Desirae	Forbes	vel@aol.couk	1-916-917-3283
93	Shad	Ayala	nunc.sit.amet@icloud.com	1-533-453-1806
94	Curran	Walters	quisque.nonummy.ipsum@protonmail.org	345-9463
95	Charles	Mclaughlin	mi.tempor@google.ca	1-488-652-6431
96	Jin	Bates	ac.turpis@outlook.ca	1-653-325-4175
97	Donna	Mcgowan	sit.amet@google.ca	1-296-338-7854
98	Kylie	Brewer	posuere.vulputate@hotmail.ca	1-522-978-5504
99	Laura	Pollard	nunc.sit@protonmail.com	753-5299
100	Ingrid	White	conubia.nostra.per@protonmail.net	1-416-417-0028
\.


--
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: gb_user
--

COPY public.video (id, url, owner_id, description, uploaded_at, size) FROM stdin;
1	http://cnn.com/sub/cars	98	magna a tortor. Nunc commodo auctor velit. Aliquam nisl. Nulla	2020-06-25 06:04:11	68655
2	https://pinterest.com	2	Donec egestas. Duis ac arcu. Nunc mauris. Morbi non sapien	2021-06-28 11:21:52	31468
3	https://reddit.com/group/9	47	amet massa. Quisque porttitor eros nec tellus. Nunc lectus pede,	2021-04-20 04:31:55	76535
4	https://whatsapp.com/site	33	pellentesque a, facilisis non, bibendum sed, est. Nunc laoreet lectus	2022-03-15 19:26:16	532
5	https://pinterest.com/en-ca	78	Vivamus nibh dolor, nonummy ac, feugiat non, lobortis quis, pede.	2020-12-07 11:36:33	18280
6	http://baidu.com/settings	46	nunc nulla vulputate dui, nec tempus mauris erat eget ipsum.	2020-09-12 14:40:13	524
7	http://netflix.com/en-us	13	pede. Suspendisse dui. Fusce diam nunc, ullamcorper eu, euismod ac,	2021-10-03 13:16:54	25813
8	https://cnn.com/sub/cars	34	mauris. Integer sem elit, pharetra ut, pharetra sed, hendrerit a,	2020-07-05 10:36:58	83371
9	https://cnn.com/site	14	auctor non, feugiat nec, diam. Duis mi enim, condimentum eget,	2021-08-09 20:10:47	63079
10	https://twitter.com/en-ca	60	interdum. Curabitur dictum. Phasellus in felis. Nulla tempor augue ac	2021-02-02 23:05:54	60908
11	http://cnn.com/user/110	53	Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla.	2020-10-30 16:44:30	55237
12	https://netflix.com/sub	90	enim, condimentum eget, volutpat ornare, facilisis eget, ipsum. Donec sollicitudin	2021-05-15 14:23:54	36072
13	http://bbc.co.uk/en-ca	10	nisi dictum augue malesuada malesuada. Integer id magna et ipsum	2022-03-10 19:41:09	45879
14	http://twitter.com/fr	22	Etiam gravida molestie arcu. Sed eu nibh vulputate mauris sagittis	2020-12-02 00:29:25	16859
15	http://guardian.co.uk/sub/cars	75	Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus	2021-07-23 12:38:56	21017
16	http://ebay.com/sub	39	vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce	2021-07-15 02:22:31	14511
17	https://baidu.com/settings	94	egestas, urna justo faucibus lectus, a sollicitudin orci sem eget	2020-06-06 14:26:51	22666
18	http://youtube.com/fr	57	in, cursus et, eros. Proin ultrices. Duis volutpat nunc sit	2021-08-28 07:23:55	7197
19	https://twitter.com/fr	2	Vestibulum ante ipsum primis in faucibus orci luctus et ultrices	2022-01-06 22:53:47	38652
20	https://walmart.com	27	Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu eros.	2021-12-21 04:23:47	58153
21	http://pinterest.com/group/9	69	dui. Fusce diam nunc, ullamcorper eu, euismod ac, fermentum vel,	2020-06-29 09:10:37	33084
22	https://reddit.com/sub/cars	7	Fusce feugiat. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.	2021-10-07 11:45:38	63040
23	https://walmart.com/settings	60	nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus.	2020-06-19 01:10:56	70282
24	http://youtube.com/sub/cars	61	condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus	2020-11-17 20:44:07	92992
25	http://yahoo.com/site	12	nascetur ridiculus mus. Proin vel nisl. Quisque fringilla euismod enim.	2022-02-06 18:35:37	7453
26	http://naver.com/one	49	nec ante. Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere	2020-09-15 15:03:20	49533
27	https://facebook.com/one	6	lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit elit fermentum	2022-01-25 03:43:32	90997
28	https://facebook.com/sub	30	vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum.	2020-12-23 16:02:20	59684
29	http://guardian.co.uk/user/110	73	sit amet massa. Quisque porttitor eros nec tellus. Nunc lectus	2020-06-12 01:30:41	21304
30	http://naver.com/settings	79	lectus pede, ultrices a, auctor non, feugiat nec, diam. Duis	2021-08-18 15:55:12	13266
31	http://wikipedia.org/en-us	97	magna. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Etiam	2020-10-02 23:19:25	28225
32	http://zoom.us/site	92	dolor dolor, tempus non, lacinia at, iaculis quis, pede. Praesent	2021-04-24 03:16:13	79363
33	https://netflix.com/one	75	magnis dis parturient montes, nascetur ridiculus mus. Proin vel arcu	2022-04-06 05:41:59	1928
34	http://cnn.com/group/9	74	erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus	2021-07-30 20:07:49	95364
35	http://baidu.com/en-us	100	nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus	2021-01-07 17:45:19	31963
36	https://netflix.com/user/110	6	dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit.	2022-01-04 02:12:56	81871
37	http://whatsapp.com/sub	79	eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est.	2021-08-10 23:19:50	38389
38	https://walmart.com/one	62	mattis semper, dui lectus rutrum urna, nec luctus felis purus	2021-12-26 03:37:07	21144
39	http://baidu.com/user/110	10	diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est	2020-08-06 18:00:04	21540
40	https://bbc.co.uk/sub	76	Sed auctor odio a purus. Duis elementum, dui quis accumsan	2021-07-17 15:25:17	90793
41	http://twitter.com/sub/cars	5	diam luctus lobortis. Class aptent taciti sociosqu ad litora torquent	2022-01-08 19:17:17	21775
42	http://pinterest.com/en-ca	54	urna convallis erat, eget tincidunt dui augue eu tellus. Phasellus	2020-06-06 19:25:15	24785
43	https://twitter.com/user/110	7	mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam	2022-04-29 13:06:20	16443
44	http://baidu.com/fr	1	hendrerit neque. In ornare sagittis felis. Donec tempor, est ac	2020-09-12 22:38:49	23862
45	http://nytimes.com/sub/cars	34	justo nec ante. Maecenas mi felis, adipiscing fringilla, porttitor vulputate,	2021-10-16 21:55:00	92336
46	http://reddit.com/en-ca	70	congue a, aliquet vel, vulputate eu, odio. Phasellus at augue	2020-05-25 22:11:50	9999
47	https://google.com/user/110	28	dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer	2021-07-03 12:13:21	47062
48	https://ebay.com/en-ca	18	Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque	2021-05-10 22:38:54	18147
49	http://whatsapp.com/sub/cars	39	Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis,	2021-08-17 22:07:29	63874
50	http://instagram.com/fr	76	Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis	2022-04-19 22:00:20	53717
51	https://naver.com/en-ca	54	ultrices sit amet, risus. Donec nibh enim, gravida sit amet,	2021-01-03 07:50:19	78671
52	https://instagram.com/fr	8	sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	2021-06-22 21:41:43	866
53	https://yahoo.com/fr	48	non, luctus sit amet, faucibus ut, nulla. Cras eu tellus	2020-10-23 16:49:05	80306
54	http://pinterest.com/one	21	est, vitae sodales nisi magna sed dui. Fusce aliquam, enim	2021-06-17 20:12:47	97027
55	https://walmart.com/ru	15	Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna	2021-12-12 17:49:54	35027
56	https://instagram.com/ru	87	augue id ante dictum cursus. Nunc mauris elit, dictum eu,	2021-04-09 10:14:01	36647
57	https://baidu.com	40	aptent taciti sociosqu ad litora torquent per conubia nostra, per	2020-08-27 05:38:06	74878
58	http://bbc.co.uk/settings	52	pharetra ut, pharetra sed, hendrerit a, arcu. Sed et libero.	2021-07-30 13:13:15	15210
59	http://netflix.com/site	73	libero et tristique pellentesque, tellus sem mollis dui, in sodales	2021-12-14 23:01:30	58065
60	https://facebook.com/site	55	dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer	2021-10-01 15:52:45	26526
61	https://cnn.com/one	53	Aliquam gravida mauris ut mi. Duis risus odio, auctor vitae,	2021-08-10 01:07:00	49197
62	http://ebay.com/one	95	consequat, lectus sit amet luctus vulputate, nisi sem semper erat,	2022-01-03 07:04:34	76289
63	http://netflix.com/group/9	53	venenatis vel, faucibus id, libero. Donec consectetuer mauris id sapien.	2021-12-24 10:44:00	5533
64	https://wikipedia.org/one	4	egestas. Aliquam fringilla cursus purus. Nullam scelerisque neque sed sem	2021-05-23 21:26:46	91533
65	http://cnn.com/group/5	3	velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus.	2021-11-26 01:45:45	49653
66	https://guardian.co.uk/fr	95	Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor ullamcorper,	2022-04-16 01:43:02	74640
67	https://netflix.com/group/9	48	ut, sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla	2021-03-26 05:41:54	62078
68	https://google.com/fr	85	erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse	2021-05-15 08:25:44	67086
69	http://pinterest.com	30	Nulla tincidunt, neque vitae semper egestas, urna justo faucibus lectus,	2020-09-27 14:38:05	96433
70	https://whatsapp.com/one	26	Etiam gravida molestie arcu. Sed eu nibh vulputate mauris sagittis	2020-08-30 02:30:32	63262
71	http://facebook.com/sub/cars	50	accumsan convallis, ante lectus convallis est, vitae sodales nisi magna	2020-09-11 09:15:53	16711
72	https://whatsapp.com/ru	6	aliquet lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu	2020-08-29 18:41:19	75180
73	http://baidu.com/set	39	ornare, elit elit fermentum risus, at fringilla purus mauris a	2021-10-16 16:11:56	64251
74	https://youtube.com/sub	49	elit, pellentesque a, facilisis non, bibendum sed, est. Nunc laoreet	2021-05-02 18:20:07	26627
75	https://youtube.com/settings	8	vel, convallis in, cursus et, eros. Proin ultrices. Duis volutpat	2022-04-25 10:28:34	39104
76	http://reddit.com/fr	47	ipsum leo elementum sem, vitae aliquam eros turpis non enim.	2021-01-29 04:13:35	56156
77	http://twitter.com/user/110	6	senectus et netus et malesuada fames ac turpis egestas. Aliquam	2020-09-07 15:24:44	20922
78	https://ebay.com/one	80	egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere	2021-04-11 20:35:07	43654
79	https://nytimes.com/sub/cars	72	tellus lorem eu metus. In lorem. Donec elementum, lorem ut	2021-02-26 22:48:48	2558
80	http://naver.com/sub	14	Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie	2020-08-04 04:13:47	45164
81	https://naver.com/one	83	in faucibus orci luctus et ultrices posuere cubilia Curae Donec	2020-05-31 20:54:04	12378
82	https://nytimes.com/group/9	50	nunc sed libero. Proin sed turpis nec mauris blandit mattis.	2021-10-09 17:07:01	8563
83	https://cnn.com	69	et magnis dis parturient montes, nascetur ridiculus mus. Donec dignissim	2021-10-09 15:06:08	68020
84	https://facebook.com	20	in sodales elit erat vitae risus. Duis a mi fringilla	2021-10-24 10:38:14	91204
85	http://ebay.com/sub/cars	20	Phasellus dapibus quam quis diam. Pellentesque habitant morbi tristique senectus	2021-12-15 03:22:49	20321
86	http://walmart.com/one	58	risus. Duis a mi fringilla mi lacinia mattis. Integer eu	2022-02-03 18:54:13	51010
87	https://guardian.co.uk/sub/cars	46	odio. Aliquam vulputate ullamcorper magna. Sed eu eros. Nam consequat	2021-07-22 01:03:53	21053
88	http://nytimes.com/user/110	76	vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros	2022-01-04 00:54:56	19104
89	http://zoom.us/sub	96	Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed	2020-12-16 00:04:57	13910
90	https://youtube.com/sub/cars	8	luctus felis purus ac tellus. Suspendisse sed dolor. Fusce mi	2021-08-28 19:24:35	7244
91	https://zoom.us/sub	71	velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas.	2021-11-18 18:43:08	81263
92	http://baidu.com/one	3	viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis,	2021-04-19 02:08:31	91438
93	https://twitter.com/group/9	88	venenatis vel, faucibus id, libero. Donec consectetuer mauris id sapien.	2021-10-09 18:58:32	69460
94	http://whatsapp.com/one	12	volutpat ornare, facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean	2021-05-24 03:27:08	34307
95	https://google.com/sub/cars	2	quis, tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris nulla.	2020-09-08 23:45:46	45331
96	http://baidu.com/group/9	71	cursus luctus, ipsum leo elementum sem, vitae aliquam eros turpis	2022-05-06 20:06:19	8109
97	http://wikipedia.org/sub	66	vestibulum lorem, sit amet ultricies sem magna nec quam. Curabitur	2021-08-17 13:54:52	49661
98	http://bbc.co.uk/group/9	80	risus varius orci, in consequat enim diam vel arcu. Curabitur	2022-05-06 11:54:37	92416
99	http://google.com/en-us	52	Nullam velit dui, semper et, lacinia vitae, sodales at, velit.	2020-11-27 05:12:56	86832
100	https://cnn.com/settings	74	imperdiet nec, leo. Morbi neque tellus, imperdiet non, vestibulum nec,	2020-10-16 10:46:06	2962
\.


--
-- Name: discussion_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.discussion_messages_id_seq', 1, false);


--
-- Name: discussions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.discussions_id_seq', 1, false);


--
-- Name: friendship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.friendship_id_seq', 1, false);


--
-- Name: friendship_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.friendship_statuses_id_seq', 1, false);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.groups_id_seq', 1, false);


--
-- Name: guest_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.guest_logs_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.photo_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: video_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.video_id_seq', 1, false);


--
-- Name: discussion_messages discussion_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.discussion_messages
    ADD CONSTRAINT discussion_messages_pkey PRIMARY KEY (id);


--
-- Name: discussions discussions_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.discussions
    ADD CONSTRAINT discussions_pkey PRIMARY KEY (id);


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
-- Name: groups groups_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_name_key UNIQUE (name);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: groups_users groups_users_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.groups_users
    ADD CONSTRAINT groups_users_pkey PRIMARY KEY (group_id, user_id);


--
-- Name: guest_logs guest_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.guest_logs
    ADD CONSTRAINT guest_logs_pkey PRIMARY KEY (id);


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
-- Name: active_users _RETURN; Type: RULE; Schema: public; Owner: gb_user
--

CREATE OR REPLACE VIEW public.active_users AS
 SELECT users.id,
    concat(users.first_name, ' ', users.last_name) AS "user",
    count(messages.created_at) AS count_messages,
    count(discussion_messages.created_at) AS count_discussion_messages
   FROM ((public.users
     LEFT JOIN public.messages ON (((users.id = messages.from_user_id) AND (messages.is_delivered = true))))
     LEFT JOIN public.discussion_messages ON ((users.id = discussion_messages.from_user_id)))
  WHERE ((messages.created_at > (now() - '1 year'::interval)) OR (discussion_messages.created_at > (now() - '1 year'::interval)))
  GROUP BY users.id
  ORDER BY (count(messages.created_at)) DESC, (count(discussion_messages.created_at)) DESC;


--
-- Name: users check_users_on_delete; Type: TRIGGER; Schema: public; Owner: gb_user
--

CREATE TRIGGER check_users_on_delete BEFORE DELETE ON public.users FOR EACH ROW EXECUTE FUNCTION public.delete_active_users_trigger();


--
-- Name: discussion_messages discussion_messages_discussions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.discussion_messages
    ADD CONSTRAINT discussion_messages_discussions_id_fk FOREIGN KEY (discussions_id) REFERENCES public.discussions(id) ON DELETE CASCADE;


--
-- Name: discussion_messages discussion_messages_from_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.discussion_messages
    ADD CONSTRAINT discussion_messages_from_user_id_fk FOREIGN KEY (from_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: discussions discussions_owner_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.discussions
    ADD CONSTRAINT discussions_owner_id_fk FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: friendship friendship_requested_by_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship
    ADD CONSTRAINT friendship_requested_by_user_id_fk FOREIGN KEY (requested_by_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: friendship friendship_requested_to_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship
    ADD CONSTRAINT friendship_requested_to_user_id_fk FOREIGN KEY (requested_to_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: friendship friendship_status_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship
    ADD CONSTRAINT friendship_status_id_fk FOREIGN KEY (status_id) REFERENCES public.friendship_statuses(id) ON DELETE CASCADE;


--
-- Name: groups groups_creator_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_creator_id_fk FOREIGN KEY (creator_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: groups_users groups_users_group_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.groups_users
    ADD CONSTRAINT groups_users_group_id_fk FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: groups_users groups_users_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.groups_users
    ADD CONSTRAINT groups_users_user_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: guest_logs guest_logs_requested_by_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.guest_logs
    ADD CONSTRAINT guest_logs_requested_by_user_id_fk FOREIGN KEY (requested_by_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: guest_logs guest_logs_requested_to_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.guest_logs
    ADD CONSTRAINT guest_logs_requested_to_user_id_fk FOREIGN KEY (requested_to_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: messages messages_from_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_from_user_id_fk FOREIGN KEY (from_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: messages messages_to_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_to_user_id_fk FOREIGN KEY (to_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: other_profiles other_profiles_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.other_profiles
    ADD CONSTRAINT other_profiles_user_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: photo photo_owner_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_owner_id_fk FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_main_photo_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_main_photo_id_fk FOREIGN KEY (main_photo_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_user_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: video video_owner_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_owner_id_fk FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

