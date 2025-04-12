--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Ubuntu 17.2-1.pgdg22.04+1)
-- Dumped by pg_dump version 17.2 (Ubuntu 17.2-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: matches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.matches (
    match_id integer NOT NULL,
    year integer NOT NULL,
    round text NOT NULL,
    winner_id integer,
    opponent_id integer,
    winner_goals integer NOT NULL,
    opponent_goals integer NOT NULL
);


ALTER TABLE public.matches OWNER TO postgres;

--
-- Name: matches_match_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.matches_match_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.matches_match_id_seq OWNER TO postgres;

--
-- Name: matches_match_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.matches_match_id_seq OWNED BY public.matches.match_id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teams_team_id_seq OWNER TO postgres;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: matches match_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches ALTER COLUMN match_id SET DEFAULT nextval('public.matches_match_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Data for Name: matches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.matches (match_id, year, round, winner_id, opponent_id, winner_goals, opponent_goals) FROM stdin;
1	2018	Final	1	2	4	2
2	2018	Third Place	3	4	2	0
3	2018	Semi-Final	2	4	2	1
4	2018	Semi-Final	1	3	1	0
5	2018	Quarter-Final	2	5	3	2
6	2018	Quarter-Final	4	6	2	0
7	2018	Quarter-Final	3	7	2	1
8	2018	Quarter-Final	1	8	2	0
17	2014	Final	17	15	1	0
18	2014	Third Place	18	7	3	0
19	2014	Semi-Final	15	18	1	0
20	2014	Semi-Final	17	7	7	1
21	2014	Quarter-Final	15	3	1	0
22	2014	Quarter-Final	18	19	1	0
23	2014	Quarter-Final	7	12	2	1
24	2014	Quarter-Final	17	1	1	0
9	2018	Eighth-Final	2	9	2	1
10	2018	Eighth-Final	5	10	2	1
11	2018	Eighth-Final	6	11	1	0
12	2018	Eighth-Final	4	12	2	1
13	2018	Eighth-Final	3	13	3	2
14	2018	Eighth-Final	7	14	2	0
15	2018	Eighth-Final	1	15	4	3
16	2018	Eighth-Final	8	16	2	1
25	2014	Eighth-Final	15	11	1	0
26	2014	Eighth-Final	3	20	2	1
27	2014	Eighth-Final	18	14	2	1
28	2014	Eighth-Final	19	21	2	1
29	2014	Eighth-Final	1	22	2	0
30	2014	Eighth-Final	17	23	2	1
31	2014	Eighth-Final	7	24	2	1
32	2014	Eighth-Final	12	8	2	0
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teams (team_id, name) FROM stdin;
1	France
2	Croatia
3	Belgium
4	England
5	Russia
6	Sweden
7	Brazil
8	Uruguay
9	Denmark
10	Spain
11	Switzerland
12	Colombia
13	Japan
14	Mexico
15	Argentina
16	Portugal
17	Germany
18	Netherlands
19	Costa Rica
20	USA
21	Greece
22	Nigeria
23	Algeria
24	Chile
\.


--
-- Name: matches_match_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.matches_match_id_seq', 32, true);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 24, true);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (match_id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: matches matches_opponent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_opponent_id_fkey FOREIGN KEY (opponent_id) REFERENCES public.teams(team_id);


--
-- Name: matches matches_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_winner_id_fkey FOREIGN KEY (winner_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--

