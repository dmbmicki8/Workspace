--
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 12.0
-- Dumped by pg_dump version 12.0

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

DROP DATABASE "PoetryKids";
--
-- Name: PoetryKids; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "PoetryKids" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE "PoetryKids" OWNER TO postgres;

\connect "PoetryKids"

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
-- Name: author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author (
    id integer NOT NULL,
    name character varying,
    grade_id integer,
    gender_id integer
);


ALTER TABLE public.author OWNER TO postgres;

--
-- Name: emotion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emotion (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.emotion OWNER TO postgres;

--
-- Name: gender; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gender (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.gender OWNER TO postgres;

--
-- Name: grade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grade (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.grade OWNER TO postgres;

--
-- Name: poem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.poem (
    id integer NOT NULL,
    title character varying,
    text text,
    author_id integer,
    char_count integer,
    poki_num integer
);


ALTER TABLE public.poem OWNER TO postgres;

--
-- Name: poem_emotion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.poem_emotion (
    id integer NOT NULL,
    intensity_percent integer,
    poem_id integer,
    emotion_id integer
);


ALTER TABLE public.poem_emotion OWNER TO postgres;

--
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.author (id, name, grade_id, gender_id) FROM stdin;
\.
COPY public.author (id, name, grade_id, gender_id) FROM '$$PATH$$/3226.dat';

--
-- Data for Name: emotion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emotion (id, name) FROM stdin;
\.
COPY public.emotion (id, name) FROM '$$PATH$$/3225.dat';

--
-- Data for Name: gender; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gender (id, name) FROM stdin;
\.
COPY public.gender (id, name) FROM '$$PATH$$/3224.dat';

--
-- Data for Name: grade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grade (id, name) FROM stdin;
\.
COPY public.grade (id, name) FROM '$$PATH$$/3223.dat';

--
-- Data for Name: poem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.poem (id, title, text, author_id, char_count, poki_num) FROM stdin;
\.
COPY public.poem (id, title, text, author_id, char_count, poki_num) FROM '$$PATH$$/3227.dat';

--
-- Data for Name: poem_emotion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.poem_emotion (id, intensity_percent, poem_id, emotion_id) FROM stdin;
\.
COPY public.poem_emotion (id, intensity_percent, poem_id, emotion_id) FROM '$$PATH$$/3228.dat';

--
-- Name: author Author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT "Author_pkey" PRIMARY KEY (id);


--
-- Name: emotion Emotion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emotion
    ADD CONSTRAINT "Emotion_pkey" PRIMARY KEY (id);


--
-- Name: gender Gender_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gender
    ADD CONSTRAINT "Gender_pkey" PRIMARY KEY (id);


--
-- Name: grade Grade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grade
    ADD CONSTRAINT "Grade_pkey" PRIMARY KEY (id);


--
-- Name: poem_emotion PoemEmotion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poem_emotion
    ADD CONSTRAINT "PoemEmotion_pkey" PRIMARY KEY (id);


--
-- Name: poem Poem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poem
    ADD CONSTRAINT "Poem_pkey" PRIMARY KEY (id);


--
-- Name: author Author_GenderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT "Author_GenderId_fkey" FOREIGN KEY (gender_id) REFERENCES public.gender(id);


--
-- Name: author Author_GradeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT "Author_GradeId_fkey" FOREIGN KEY (grade_id) REFERENCES public.grade(id);


--
-- Name: poem_emotion PoemEmotion_EmotionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poem_emotion
    ADD CONSTRAINT "PoemEmotion_EmotionId_fkey" FOREIGN KEY (emotion_id) REFERENCES public.emotion(id);


--
-- Name: poem_emotion PoemEmotion_PoemId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poem_emotion
    ADD CONSTRAINT "PoemEmotion_PoemId_fkey" FOREIGN KEY (poem_id) REFERENCES public.poem(id);


--
-- Name: poem Poem_AuthorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poem
    ADD CONSTRAINT "Poem_AuthorId_fkey" FOREIGN KEY (author_id) REFERENCES public.author(id);


--
-- PostgreSQL database dump complete
--

