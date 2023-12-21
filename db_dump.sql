--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 16.1

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: admin
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO admin;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: admin
--

COMMENT ON SCHEMA public IS '';


--
-- Name: InfluenceLevel; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public."InfluenceLevel" AS ENUM (
    'TIEF',
    'MITTEL',
    'HOCH',
    'UNKNOWN'
);


ALTER TYPE public."InfluenceLevel" OWNER TO admin;

--
-- Name: VoteStatus; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public."VoteStatus" AS ENUM (
    'YES',
    'NO',
    'UNKNOWN'
);


ALTER TYPE public."VoteStatus" OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Bill; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Bill" (
    id text NOT NULL,
    title text NOT NULL,
    "billText" text NOT NULL,
    "sponsorId" text,
    "voteResult" public."VoteStatus" DEFAULT 'UNKNOWN'::public."VoteStatus" NOT NULL
);


ALTER TABLE public."Bill" OWNER TO admin;

--
-- Name: Canton; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Canton" (
    id text NOT NULL,
    "shortName" text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Canton" OWNER TO admin;

--
-- Name: Committee; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Committee" (
    id text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Committee" OWNER TO admin;

--
-- Name: InterestGroup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."InterestGroup" (
    id text NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    "aliasNames" text NOT NULL
);


ALTER TABLE public."InterestGroup" OWNER TO admin;

--
-- Name: LobbyOrganization; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."LobbyOrganization" (
    id text NOT NULL,
    name text NOT NULL,
    rechtsform text NOT NULL
);


ALTER TABLE public."LobbyOrganization" OWNER TO admin;

--
-- Name: Parliamentarian; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Parliamentarian" (
    id text NOT NULL,
    "cantonId" text NOT NULL,
    "partyId" text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL
);


ALTER TABLE public."Parliamentarian" OWNER TO admin;

--
-- Name: ParliamentarianRelatedToOrganization; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."ParliamentarianRelatedToOrganization" (
    "parliamentarianId" text NOT NULL,
    "organizationId" text NOT NULL,
    "position" text NOT NULL,
    "influenceLevel" public."InfluenceLevel" DEFAULT 'UNKNOWN'::public."InfluenceLevel" NOT NULL,
    verguetung text
);


ALTER TABLE public."ParliamentarianRelatedToOrganization" OWNER TO admin;

--
-- Name: ParliamentarianVote; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."ParliamentarianVote" (
    "parliamentarianId" text NOT NULL,
    "billId" text NOT NULL,
    "voteStatus" public."VoteStatus" NOT NULL
);


ALTER TABLE public."ParliamentarianVote" OWNER TO admin;

--
-- Name: Party; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Party" (
    id text NOT NULL,
    "shortName" text NOT NULL,
    "fullName" text NOT NULL
);


ALTER TABLE public."Party" OWNER TO admin;

--
-- Name: _CommitteeToParliamentarian; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."_CommitteeToParliamentarian" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_CommitteeToParliamentarian" OWNER TO admin;

--
-- Name: _InterestGroupToLobbyOrganization; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."_InterestGroupToLobbyOrganization" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_InterestGroupToLobbyOrganization" OWNER TO admin;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO admin;

--
-- Data for Name: Bill; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Bill" (id, title, "billText", "sponsorId", "voteResult") FROM stdin;
3902bda0-d003-4ad8-825c-38ec0a33f7e0	Angemessene Wasserzinsen		\N	YES
308b647f-1131-430d-8acb-a1c600b5a8f4	Öffentliches Beschaffungswesen. Ausbildung von Lehrlingen als Kriterium		\N	YES
65abeda3-1bf3-450f-be7b-7494a71496d3	Teilung eingezogener Vermögenswerte. Bundesgesetz		\N	YES
49b74bb8-8892-4b66-a843-568153ecc414	SchKG. Schutz gutgläubiger Erwerber		\N	YES
c940eff9-5af5-4825-9f5b-4bbefbd816d5	Revidierte Rheinschifffahrtsakte. Zusatzprotokoll Nr. 7		\N	YES
c7419180-6830-435c-91c2-aa63009730dd	Finanzierung der Gesundheitsleistungen aus einer Hand. Einführung des Monismus		6	YES
dfea9a26-ef3d-48ec-bb78-299f3c1201df	Voranschlag 2024 mit integriertem Aufgaben- und Finanzplan 2025-2027		6	NO
8273b1c3-94f7-422a-a1d8-aff900989e6a	Die IKT-Gesamtarchitektur der Armee nachhaltig und kohärent steuern		6	NO
1523a63a-0f8d-43bc-b567-adfe00bafc91	Aufrufe zu Hass und Gewalt aufgrund des Geschlechts müssen strafbar werden		6	NO
4c300ecb-2939-46b0-abd9-afbf010d74b8	Rückführungsoffensive und konsequente Ausweisung von Straftätern und Gefährdern		6	YES
96151634-acf2-4f9e-bd54-afb7007c8a7b	Vorbereitung und Unterstützung der humanitären Minenräumung in der Ukraine		6	NO
ad989cee-de35-4fde-b2d1-0b0d190d861d	Weiterentwicklung des Schengen-Besitzstands (Überwachungsmechanismus)		6	NO
9d822ee7-c84c-4178-8b36-4ef00bbb223b	Modernisierung der Wirtschaftsbeziehungen zwischen der Schweiz und der Republik Korea		6	YES
249099df-f86a-4fe6-a532-3df9a15e0e39	Russische und andere ausländische Spione konsequent ausweisen		6	YES
cb5d45e0-f093-474b-b1ee-afc801068164	Rohstoffsektor mittels unabhängiger Aufsicht stärken		6	NO
95b5667c-6138-42f0-b8a2-af2000d5b73f	Das Recht auf digitale Unversehrtheit in die Verfassung aufnehmen		6	NO
1f5d832f-d31b-49b8-a26d-28487662b835	Modernisierung des Gewährleistungsrechts		6	YES
ff195055-5b7e-48ec-b23f-b02200c25d67	Mehr Schutz von Kulturgütern in der Schweiz		6	YES
671a8430-57d0-4694-b1d4-b01c00718828	Kapazitätsplanung im Asylbereich umfassend angehen		6	YES
190c19ef-be90-45bf-b9c6-afc700ee176a	Steuerabzug der Kosten für die Installation von Ladeinfrastrukturen in Gebäuden		6	YES
56589903-f505-4b43-8c46-afc000bc9c5a	Aussetzung des Resettlement-Programms 2024/25		6	YES
c665539d-6be7-4452-9b27-afb7007dbca0	Rückführungen nach Algerien. Forcierung der Zusammenarbeit im Bereich der Rückkehr dank der Anwendung von Artikel 25a des Schengener Kodex		6	YES
bc2d5201-991f-49cd-928c-add700b29b20	Bei häuslicher Gewalt die Härtefallpraxis nach Artikel 50 AIG garantieren		6	YES
0c0c4255-472d-422e-a455-6003c2820090	Rüstungsbeschaffungen. Verbesserung des Evaluationsverfahrens und Erhalt des politischen Handlungsspielraums bis zum Typenentscheid		6	NO
93ee3ae9-69b2-4273-b9bf-afc700f5e381	AHV-Renten für bedürftige Rentnerinnen und Rentner erhöhen		6	YES
d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	Änderung des Kriegsmaterialgesetzes		6	YES
443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	Korrektur der Praxisänderung in Bezug auf Asylgesuche von Afghaninnen		6	NO
94a9ebba-2ea2-449a-a7e4-2da09a5585e6	Erneuerung der strassenseitigen Autoverlade-Infrastruktur. Zusatzkredit		6	NO
097c1168-858b-4390-b4a6-b0230085ba0b	Verschiebung der Einführung der Anforderung von 3,5 Prozent Biodiversitätsförderflächen im Ackerbau um ein Jahr		6	YES
b0d54477-9760-4595-97bf-afc801062891	Die Kantone müssen für gewählte Gemeindepolitikerinnen und -politiker strafrechtliche Immunität vorsehen können		6	NO
66e16f07-36f4-4fc7-ba98-7168df9e9995	Weiterentwicklungen des Schengen-Besitzstands. Finanzielle Hilfe im Bereich Grenzverwaltung und Visumpolitik		6	NO
e2c7af9b-2788-406b-b382-afc500e2de5a	Gewalttätiger Extremismus in der Schweiz		6	YES
e37e8e4d-0b45-40ba-a340-b0230080f7e0	Die Stärkeproduktion in der Schweiz erhalten		6	NO
29790ba8-4ae9-497a-93b3-afc801079cc1	Für eine faire Verteilung der Schadenskosten bei einem Mangel der Mietsache ohne Verschulden der Vertragsparteien		6	NO
dc549f88-6735-4539-bc44-afb7007d5be6	Intervention in Brüssel, damit Italien endlich das Dublin-Abkommen einhält		6	YES
67495532-fa85-472b-b59b-af5e00f4ae4d	Transparenz im Mietwesen verbessern		6	NO
0775eb08-d871-4e20-aefd-af2000d463d9	Schützen wir die Bäuerinnen und Bauern. Für eine Ombudsstelle in Landwirtschafts- und Ernährungsfragen		6	NO
1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	Schutzstatus S. Zugang zum Arbeitsmarkt erleichtern		6	YES
53a79b77-c31c-4326-81a7-f83d333f2600	Sanktionen gegen die Hamas prüfen		6	YES
3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	Revision des Aussenwirtschaftsgesetzes		6	YES
e623fb98-5a74-4a95-b84e-afc600e97860	Rückführung von Eritreern, deren Asylantrag abgelehnt wurde. Lancierung eines Pilotprojekts in einem Drittstaat		6	NO
760ce247-b948-466b-b2e9-af6c00bc5863	Mehr Rechtssicherheit im Mietrecht		6	YES
4472ab7f-b7e0-4901-9271-fe74aee3f570	Strategie zur Sicherung der Schweizer Trink- und Mineralwasserquellen sowie der Wasserversorgungsanlagen		6	YES
bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	Keine Verteuerung der Munition für die Schützen, keine Schwächung des Wehrwillens		6	YES
d938eee3-7755-4da0-8494-0887ac618422	Revision EPDG (Übergangsfinanzierung und Einwilligung)		6	NO
ea3c08d8-29ef-4750-9746-aff900b12965	Ressourcenausstattung der Armee mit einer Kosten-Fähigkeiten-Planung sicherstellen		6	NO
ba4a1c99-48d7-40da-86ea-0c77f3797150	Voranschlag 2023. Nachtrag II		6	YES
\.


--
-- Data for Name: Canton; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Canton" (id, "shortName", name) FROM stdin;
1	ZH	Zürich
2	BE	Bern
3	LU	Luzern
4	UR	Uri
5	SZ	Schwyz
6	OW	Obwalden
7	NW	Nidwalden
8	GL	Glarus
9	ZG	Zug
10	FR	Freiburg
11	SO	Solothurn
12	BS	Basel-Stadt
13	BL	Basel-Landschaft
14	SH	Schaffhausen
15	AR	Appenzell Ausserrhoden
16	AI	Appenzell Innerrhoden
17	SG	St. Gallen
18	GR	Graubünden
19	AG	Aargau
20	TG	Thurgau
21	TI	Tessin
22	VD	Waadt
23	VS	Wallis
24	NE	Neuenburg
25	GE	Genf
26	JU	Jura
\.


--
-- Data for Name: Committee; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Committee" (id, name) FROM stdin;
27	Geschäftsprüfungskommission NR
1	Kommission für soziale Sicherheit und Gesundheit NR
60	Immunitätskommission NR
38	Delegation bei der Interparlamentarischen Union
11	Kommission für Wirtschaft und Abgaben NR
9	Kommission für Wissenschaft, Bildung und Kultur NR
21	Gerichtskommission
39	Büro NR
37	Delegation EFTA / Europäisches Parlament-V
64	Ständige parlamentarische Delegation zur Teilnahme an Aktivitäten im Rahmen der OECD-V
3	Kommission für Umwelt, Raumplanung und Energie NR
30	Delegation für die Beziehungen zum Landtag des Fürstentums Liechtenstein
17	Aussenpolitische Kommission NR
42	Delegation bei der Parlamentarischen Versammlung des Europarates
62	Delegation bei der parlamentarischen Versammlung der Frankophonie
5	Kommission für Verkehr und Fernmeldewesen NR
7	Sicherheitspolitische Kommission NR
35	Delegation bei der parlamentarischen Versammlung der OSZE
63	Mitwirkung des Parlamentes im Bereich von Soft Law
53	Staatspolitische Kommission SR
52	Kommission für Wirtschaft und Abgaben SR
54	Kommission für Rechtsfragen SR
58	Büro SR
59	Büro Vereinigte Bundesversammlung
48	Kommission für Umwelt, Raumplanung und Energie SR
20	Begnadigungskommission
15	Kommission für Rechtsfragen NR
13	Staatspolitische Kommission NR
31	Delegation für die Beziehungen zum Österreichischen Parlament
55	Aussenpolitische Kommission SR
57	Geschäftsprüfungskommission SR
47	Kommission für soziale Sicherheit und Gesundheit SR
51	Kommission für Wissenschaft, Bildung und Kultur SR
40	Geschäftsprüfungsdelegation
50	Sicherheitspolitische Kommission SR
32	Delegation für die Beziehungen zum Deutschen Bundestag
18	Redaktionskommission
44	Delegation für die Beziehungen zum Italienischen Parlament
19	Finanzkommission NR
49	Kommission für Verkehr und Fernmeldewesen SR
41	Delegation bei der parlamentarischen Versammlung des nordatlantischen Verteidigungsbündnisses (NATO)
29	Delegation für die Beziehungen zum Französischen Parlament
56	Finanzkommission SR
43	Finanzdelegation
\.


--
-- Data for Name: InterestGroup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."InterestGroup" (id, name, description, "aliasNames") FROM stdin;
1	Pharma	Medikamentenforschung, Medikamentenvertrieb, Pharmafirmen, Apotheken	
2	Krankenkassen	Krankenkassen, Dachorganisationen KK, Unterorganisationen KK	
3	Gesundheit	Gesundheitsförderung, Drogenmissbrauch	
4	Arztmedizin	Ärzte, Arzmedizin, Berufsorganisationen Ärzte, medizinische Dienstleistungen, Physiotherapie, Hebammen	
5	Spitäler	Spitäler, Spitalorganisationen	
6	Patienten	Patientenorganisationen, Gesundheitskonsumenten	
7	Spitex	Spitex, Spitexverbände und -Organisationen	
8	Öffentliches Gesundheitswesen	Gesundheitsdirektoren, Kantone, öffentliche Gesundheitsorganisationen,Gesundheitsfinanzierer	
9	Medizinaltechniken	Forschung, Handel, technische Hilfsmittel im Bereich Medizinaltechnik	
10	Musik	Musiker, Produzenten etc, verschiedener Ausrichtung. zB. Rock- und Popmusik, Vereinigungen von Künstlern in diesem Bereich. Auch Klassik; Orchester etc.	
12	Gemeinwohl/Gesellschaft	Gemeinnützige Institutionen im sozialen Bereich. Ums Wohl der Gesellschaft in verschiedener Hinsicht (Alter, Jugend,  Behinderung, Gewalt etc.)	
13	Kantone/Regionen	Vertreter von Kantonen, Repräsentanten wie zB Regierungsräte, Generalsekretäre, Mitglieder der Legislativen, Funktionäre der kantonalen Parteien; Regionen wie zB Regions Basiliensis, Espace Mittelland	
14	Städte	vor allem im Ständeverband organisierte Exponenten. Aber auch Parteifunktionäre auf Stadt-Ebene (nicht Gemeinden unterhalb Stadtgrösse).	
15	Behinderung	Organisationen, die sich mit Menschen mit Beeinträchtigungen beschäftigen.	
16	Banken	Banken, Kantonalbanken, Privatbanken, Anlagefonds, kollektive Kapitalgesellschaften	
17	Rohstoffhandel	zB Clencore, Gasindustrie, Ölindustrie	
18	Consulting/PR	PR- und Public Affairs-Firmen, Kommunikationsagenturen, Consultingunternehmen.	
19	Immobilien/Hauseigentümer	Immobilienhändler, Hauseigentümer, Makler, Wohnbaugenossenschaften	
20	Parteien	alle Parteien	
21	Militärgeschichte	Militärhistoriker/Militär-Reisen, Vereinigungen, die ehemalige Bunker betreiben etc.	
23	Wirtschaft allgemein	Gremien, die sich mit wirtschaftlichen Fragen auseinandersetzen, beraten, promoten. Wie zB. Swiss Economic Forum und andere.	
24	Migration	Asylwesen, Ausländerrecht, Flüchtlingswesen	
25	Hilfswerke	Hilfswerke allgemein wie zB Heks aber auch Stiftungen in ähnlicher RIchtung	
26	Individualverkehr	motorisierter Individualverkehr wie zB TCS, ACS, aber auch Mobility	
27	Bildungsförderung	Insitutionen, die die Bildung fördern, Stipendien vergeben etc.	
28	Privatschulen	Privatschulen aller Niveaus	
29	Energieversorger	Elektrizitätsversorger, örtliche EWS, Firmen der Energiewirtschaft etc.	
30	Atomenergie	Atomlobby, herkömmliche Energieträger	
31	Energie allgemein	allgemeine Tätigkeiten im Energiesektor, zb Energie-Agentur der Wirtschaft, Energiestadt Label.	
32	Alternativenergie	Alternative Energien, Vereinigungen, zb SES, Dachorganisation für erneuerbare Energien.	
33	Öffentlicher Verkehr	lokale ÖV-Unternehmen, Verbände des öffentlichen Verkehrs, Litra, VÖV, VCS etc	
34	Kunsthandwerk	Kunsthandwerk-Förderung, Buchbinder	
35	Staatspolitik allgemein	Institutionen mit staatspolitischen Anliegen, auch Bürgergemeinden, Korporationen etc. sowie Organisationen, die der Unterstützung von Parteien dienen, Fundraisingorganisationen von Parteien etc.	
36	Logistik/Transport	Logistik, Transport, Spedition, inkl Verbände wie Asta, aber auch zB Spedlogswiss, Camionneure sowie Unternehmen aus dem Bereich Nutzfahrzeuge. Auch Frachtschiffahrt auf dem Rhein	
38	Nahrungsmittel	Nahrungsmittelproduzenten, Schokolade, Früchte, Kaffee, Getränkeindustrie etc. inkl Milchwirtschaft (doppelte Branchen/Interessengruppe-Zuteiung)	
39	Milchwirtschaft	Milchverarbeiter, Käsereien, Molkereien	
40	Handelsbeziehungen international	Verbände der Exportwirtschaft, Freundschaftsvereinigungen, Delegationen zB Schweiz-Südafrika, Schweiz-Kasachstan, Schweiz-Taiwan. Idee, Handelsbeziehungen etablieren.	
41	Bildung/Wissenschaft	Schulen, Fachhochschulen, Unis, Universitäre Einrichtungen (div. Institute), Berufsschulen	
42	Pensionskassen	Einrichtungen der beruflichen Vorsorge nach BVG.	
43	Langsamverkehr	Velo	
44	Kulturinstitutionen	Kulturinstitiutionen aller Art wie Stadttheater, Museen, Vereine, Veranstalter, Denkmalpflege. Aber auch Museen mit Sammlungen kulturhistorischer Art und gesellschaftlichen Themen (Ballenberg, Verkehrshaus etc.)	
45	Think Tanks	Denkfabriken wie zB Avenir Suisse, Denknetz Schweiz etc.	
46	Oel-/Gasindustrie	Erdölkonzerne, Tankstellen, Gasunternehmen (Socar, Gazprom)	
47	Dienstleister Kommunikation	Kommunikationsdienstleister wie Swisscom, Cablecom, ICT-Firmen	
48	Printmedien	Zeitungen, Zeitschriften mit Hauptgeschäft im Printmedienbereich sowie Druckereien.	
49	Elektronische Medien	Medien, mit Haupttätigkeit im elektronischen Bereich	
50	Cleantech	Unternehmen der Cleantechbranche	
51	Bauhauptgewerbe	Für eine detailliertere Abgrenzung der beiden Bereiche, insbesondere für die Frage, was zum Bauhauptgewerbe gehört, kann der gesamtschweizerisch geltende Landesmantelvertrag für das Schweizerische Bauhauptgewerbe (LMV 2008, 2008 - 2010) herangezogen werden. Dieser definiert folgende Bereiche als Bauhauptgewerbe (Art. 2 Abs. 1 LMV 2008):\na)    Hochbau, Tiefbau (einschliesslich Spezialtiefbau), Untertagbau und Strassenbau (einschliesslich Belagseinbau);\n\nb)    Aushub, Abbruch, Deponie- und Recyclingbetriebe;\n\nc)    Steinhauer- und Steinbruchgewerbe sowie Pflästereibetriebe;\n\nd)    Marmor- und Granitgewerbe;\n\ne)    Gerüst-, Fassadenbau- und Fassaden-Isolationsbetriebe, ausgenommen Betriebe, die in der Gebäudehülle (umfasst geneigte Dächer, Unterdächer, Flachdächer und Fassadenbekleidungen, mit dazugehörendem Unterbau und Wärmedämmung) tätig sind;\n\nf)     Abdichtungs- und Isolationsbetriebe für Arbeiten an der Gebäudehülle im weiteren Sinn und analoge Arbeiten im Tief- und Untertagbau;\n\ng)    Betoninjektions- und Betonsanierungsbetriebe, Betonbohr- und Betonschneide-unternehmen;\n\nh)    Betriebe, die Asphaltierungen ausführen und Unterlagsböden erstellen (wie Schaler, Eisenleger, Maurer)\n\ni)     Gartenbaufirmen, soweit sie mehrheitlich Arbeiten wie Bauarbeiten, Planierungen, Maurerarbeiten usw., ausführen;\n\nj)     Betriebe bzw. Betriebsteile der Sand- und Kiesgewinnung;\n\nk)    Transport von und zu Baustellen;\n\nl)     Herstellung und Transport von lagerfähigen Baustoffen.	
120	Rettungswesen	Rettungsdienste wie z.B. Rega, Ambulanzen, Feuerwehr etc.	
52	Baunebengewerbe	Zum Baunebengewerbe gehören grundsätzlich sämtliche übrigen Bauarbeiten wie bspw. Maler-, Gipser-, Dachdecker-, Plattenleger-, Gärtner-, Spenglerei-, Heizungs-, Klima-, Lüftungs-, Schreiner-, Zimmerei-, Metallbau- sowie Sanitär- und Elektroinstallationsarbeiten. Diese Abgrenzung entbindet den Auftraggeber allerdings nicht davon, im Einzelfall zu prüfen, ob die konkreten Bauarbeiten ein tragendes Element betreffen; dies deshalb weil bestimmte Arbeitsgattungen (bspw. Zimmerei- oder Metallbauarbeiten) je nach Bauvorhaben ein tragendes oder nicht tragendes Element betreffen können.	
53	Arbeitnehmerorganisationen	Gewerkschaften, Angestellte Kaderorganisation,	
54	Umwelt & Natur	Organisationen wie Greenpeace, Pro Natura, Vogelwarte, Landschaftsschutz	
55	Tierschutz	Tierschutzorganisationen	
56	Sozialversicherungen	Sozialversicherungen, Sozialwerke, AHV, IV, Ausgleichskassen, etc.	
57	Versicherungen	alle Versicherungen, auch Suva, exklusive Krankenversicherer (KVG)	
58	Advokaturen/Treuhand	Treuhänder, Anwälte, Notare, Wirtschaftsprüfer und ihre Standesorganisationen	
59	KMU/Gewerbe/Arbeitgeber	Organisationen, Interessenverbände; KMU-Verband, Gewerbeverband etc. Berufsorganisationen, Selbstständige, Arbeitgeberorganisationen	
60	Tourismus/Gastronomie	Gastro, Hotellerie, Tourismus	
61	Industrie	Industrieunternehmen	
62	Medien allgemein	Verbände und Institutionen aus dem Bereich Medien.	
63	Kulturförderung	allgemeine Kulturförderung, auch kulturhistorisch	
64	Reinigungsgewerbe	Reinigungsbranche, Hauswarte, Facility Management	
65	Spitzensport	professionelle Sportarten	
66	Breitensport	Amateurszene, Volksläufe, Laiensport	
67	Gleichstellung	Frauenorganisationen, Männerverbände, kantonale und instituionelle Fachstellen für Gleichstellung, div Frauenorganisationen	
68	Hilfswerke international	Hilfswerke mit Engagement in der Dritten Welt/Schwellenländern, Zusammenarbeit mit DEZA etc.	
69	Kosmetika/pharmazeutische Produkte	Kosmetikaindustrie, Drogerien, heilmittelähnliche Substanzen, Produkte mit Zusatzstoffen etc.	
70	Aussenpolitik allgemein	Beziehungspflege, Imagepflege, Schweiz-PR, wirtschaftlich motiviert	
71	Friedensförderung/Menschenrechte	Förderung der Menschenrechte und zivile Friedensförderung im Bereich der Aussenpolitik	
72	Sicherheit allgemein	private Sicherheitsdienste, private Initiativen zur Verbesserung der Sicherheit und Verhinderung Kriminalität	
73	Pflege	Pflege in Heimen, Pflegeinstitutionen, auch Verbände wie SBK	
74	Dienstleistungen allg.	Verschiedene Dienstleister wie Vergleichsportale, Messen, Ausstellungen und andere Vermittler zwischen der Wirtschaft/Gewerbe und Konsumenten.	
75	Pro EU	pro europäisch	
76	EU-Gegner	EU-kritische Organisationen (wie z.B. AUNS).	
77	Futtermittel/Pflanzenbau	Futtermittelindustrie, Futtermühlen, Pflanzenbau, etc.	
78	IT	Organisationen und Unternehmen aus dem Bereich ICT	
79	Heime/Institutionen	Diverse Heime, also Alters-, Behinderten-, Kinderheime (private und öffentliche Institutionen).	
80	Ökologie	Umweltbereich in der Landwirtschaft, zB Kleinbauern	
81	Konsumentenschutz	Konsumenten	
82	Weinbau, Bier und Spirituosen	Rebbau, Weinbau, Winzern, Verarbeiter, Schnapsbrenner, Spirituosen, Bierbrauer, Bierhändler	
83	Promotion/Label	Verkaufsorganisationen, Label, Promotionsverbände	
84	Obstwirtschaft	Obstwirtschaft, Pflanzer, Verarbeiter, Händler --> Schnaps siehe Weinbau/Spirituosen	
85	Landwirtschaft allgemein	Verschiedene landwirtschaftliche Organisationen, Bürgschaftsgenossenschaften, IGs etc	
86	Viehwirtschaft	Viehzucht, Händler, Pferdezucht etc	
87	Maschinenindustrie	Unternehmen der Maschinen-, Elektro- und Metallindustrie (auch Motoren, Pumpen, etc) sowie die Werkzeugbranche.	
88	Dienstleistungen Gesundheit	Unternehmen und Organisationen mit Dienstleistungen im Bereich Gesundheitswesen	
89	Sport allgemein	Sportmuseum, Schiedsrichter, Ausrüster, Fans etc.	
90	Verkehrssicherheit	Organisationen, die sich in der Sicherheit im Verkehr allgemein engagieren. BFU, Roadcross etc	
91	Klima	Klimapolitik und nachhaltige Entwicklung, My Climate	
92	Detailhandel	Detailhändler	
93	Umwelt allgemein	allgemeiner Umweltschutz,  technologisches, etc.	
94	Raumplanung	Themen der Raumplanung, Landschaftsschutz	
95	Rüstungsindustrie	Wehrtechnik, Waffen, Rüstungsgüter	
96	Produktion/Handel Landwirtschaft	Saatgut, Herstellung, Handel mit landwirtschaftlichen Produkten etc.	
97	Biotech	Firmen der Biotechnologie, auch Gentech, Syngenta etc.	
98	Mieter	Mieterinnen und Mieterverbände	
99	Abgaben und Steuern	Steuersenkungsinitiativen, Abgabenkritiker, Befürworter von Steuerwettbewerb	
100	Berggebiete	Organisationen, die sich explizit für Berggebiete einsetzen	
101	Textilindustrie	Firmen der Textilindustrie, Textilverarbeitung	
102	Kinder/Jugend	Unterstützung von Kindern, Jugend; Förderung, Interessenvertretung von Kindern-/Jugendlichen	
103	Religion	Religiöse Gruppen verschiedener Glaubensrichtungen und Freikirchen.	
104	Innere Sicherheit	Organisationen im Bereich innere Sicherheit, Antiterrorismus, Nachrichtendienste, Bundeskriminalpolizei, Bundesanwaltschaft, Fedpol	
105	Polizei	Diverse Polizeikorps, Berufsverbände, Organisationen mit Bezug zu Polizeikorps bzw. Dienstleistungen im Zusammenhang mit der Polizeibehörde.	
106	Gemeinden	Organisationen, Verbände der Gemeinden	
107	Investmentgesellschaften	Investmentgesellschaften, Beteiligungsgesellschaften	
108	Handel	Import/Export von Gütern aller Art.	
111	Militär	Armee, Militär, Luftwaffe	
115	Chemie/Biotech	Unternehmen der chemischen Industrie und Biotech.	
116	Luftfahrt	Unternehmen der zivilen und militärischen Luftfahrt	
117	Aufsichtsgremien	Aufsichtsgremien der Kantone und des Bundes (z.B. Stiftungsaufsicht, Finma etc)	
118	Globalisierungskritiker	Organisationen aus dem Bereich Förderung der Menschenrechte, Freihandelspolitik, die sich einsetzen für faire Handelsbeziehungen von Schweizer Wirtschaftsunternehmen; auch globalisierungskritissche Organisationen.	
119	Grafik	Grafik, Typografie sowie andere der Werbung/Printmedien vorgelagerte Berufe und Tätigkeiten.	
121	Vermögensverwalter	Unabhängie Vermögensverwalter, wie sie beispielsweise im Verband der Schweizerischen Vermögensverwalter organisisert sind (Anlageberater und andere Finanzdienstleister).	
122	Wasser	Wasserversorgung, Abwasserentsorgung, Abwasserreinigung und ähnliches	
123	Wasserkraft	Wasserkraftwerke, Pumpspeicherkraftwerke	
124	Landwirtschaftstechnik	Technische Hilfsmittel und Tätigkeiten für die Landwirtschaft, z.B. Landmaschinen etc.	
125	Werbung	Unternehmen der klassischen Werbebranche; also Werbefirmen, Unternehmen zur Aquisition von Werbung	
126	Abfallwirtschaft	Abfallwirtschaft, Deponien sowie Unternehmen der Recyclingbranche	
127	Zuwanderungskritiker	Organisationen, die sich für eine Beschränkung der Zuwanderung einsetzen.	
128	Bildende Künste	Bildende Künstler wie Kunstmaler, Bildhauer etc.	
129	Buchhandel	Buchhändler und Buchverlage	
130	Uhrenindustrie	Unternehmen der Uhrenindustrie bzw. Zulieferer der Uhrenindustrie.	
131	AKW-Gegner	Kritiker und Gegner der Atomenergie bzw. klassische AKW-Gegner.	
132	Schifffahrt	Unternehmen aus dem Bereich der touristischen Schiffahrt.	
133	Tabak	Verbände und Organisationen der Tabakindustrie, des Tabakhandels, Tabakanbaus, Zigarrenvereine etc.	
134	Gentechnik-Kritiker	Kritker der Gentechnologie	
135	Holz- und Waldwirtschaft	Sägereien, Holzverarbeiter, Holzvermarkter;	
136	Glücksspiel	Lotteriegesellschaften, Casinos und ähnliche Einrichtungen aus dem Bereich des Glücksspiels.	
137	Geflügelzucht	Unternehmen, Verbände und Firmen mit dem Hauptzweck der Geflügelzucht (Pouletmästereien etc).	
138	Architektur	Architekten, Architekturbüros im engeren Sinn.	
139	Film/Theater	Film- und Theaterschaffen.	
140	Literatur	Schriftsteller und Autoren.	
141	Zivilschutz	Setzt sich für den Schutz der Bevölkerung ein: Sicherheit, Intervention und Prävention.	
143	Justiz	Gerichte bzw. rechtssprechende Organe, also auch Staatsanwälte etc.	
144	Lärmschutz	Lärmschutz allgemein auch Anwohnervereinigungen in Sachen Fluglärm, SBB-Lärm, etc.	
145	Fischerei	Fischerei, Fischer, Fischzucht	
146	Zünfte, Verbindungen und Serviceclubs	Handwerkerzünfte, Studentenverbindungen sowie andere Vereinigungen wie Serviceclubs, deren Zweck letztlich die Vernetzung von Berufsleuten, Studenten und Unternehmern zum Zweck haben.	
147	Kleintierzucht	Kaninchenzüchter und andere Kleintierzüchter, (vorwiegend Freizeitbereich).	
148	Internationale Institutionen	Internationale Institutionen und Organisationen.	
\.


--
-- Data for Name: LobbyOrganization; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."LobbyOrganization" (id, name, rechtsform) FROM stdin;
4	Schweizer Musikinsel Rheinau	Stiftung
118	Raiffeisenbank Menzingen-Neuheim, Menzingen	Genossenschaft
3	Albert Bächtold-Stiftung	Stiftung
43	Schweizerischer Gemeindeverband	Verein
17	Associazione Svizzera Inquilini (Asi) Federazione della Svizzera	Verein
2	ROBINVEST AG	AG
12	comparis.ch AG	AG
22	Schweizerische Gesundheitsdirektorenkonferenz (GDK)	Staatlich
42	Fédération des Entreprises romandes FER Genève	Verein
61	aspero ag	AG
13	Alfred Flury-Stiftung	Stiftung
11	Hüppi AG	AG
18	Movimento dei Senza Voce	Verein
60	adoro consulting ag	AG
79	Europäische Bewegung Schweiz	Verein
8	Automobil Club der Schweiz, ACS	Verein
98	Schweizerische Stiftung für Klinische Krebsforschung	Stiftung
119	Ausgleichskasse Verom	Verein
9	Industrie- und Handelsverein Thal-Gäu-Bipperamt	Verein
122	alps - Alpines Museum der Schweiz	Stiftung
121	Internetplattform Swissmip	Verein
62	Dr. Sebastian Frehner Consulting	Einzelunternehmen
25	Public Health Schweiz	Verein
40	Schweizerisches Konsumentenforum kf	Verein
41	Associazione Consumatrici della Svizzera Italiana (	Verein
23	Forum Managed Care	Verein
24	Fourchette verte Tessin	Verein
123	Schweizerisches Arbeiterhilfswerk SAH Wallis	Verein
124	Pro Mente Sana Suisse romande	Verein
63	pro rabais	Verein
64	xundart AG	AG
125	Universitätsspital Basel	Oeffentlich-rechtlich
66	Santé sexuelle suisse	Stiftung
126	Schweizerische Pfadistiftung	Stiftung
65	SPO Schweizerische Patientenorganisation	Stiftung
127	Compasso - Berufliche Eingliederung - Informationsportal für Arbeitgeber	Verein
128	IAMANEH Schweiz Suisse Svizzera Switzerland	Verein
69	Interessengemeinschaft öffentlicher Verkehr Schweiz	Verein
67	Gesellschaft Schweiz - Albanien	Verein
129	GELIKO Schweizerische Gesundheitsligen-Konferenz	Verein
68	Interessengemeinschaft öffentlicher Verkehr Ostschweiz	Verein
130	Schweizerischer Verband des Personals öffentlicher Dienste (V.P.O.D.)	Verein
70	miva	Verein
71	umverkehR	Verein
131	WWF Region Basel	Verein
132	RadioZürisee AG	AG
133	TopPharm Apotheke Paradeplatz AG	AG
72	Stiftung Albert Grütter-Schlatter zur Unterstützung alleinstehender alter Leute	Stiftung
134	Schweizerische Greina-Stiftung (SGS) zur Erhaltung der alpinen Fliessgewässer	Stiftung
135	Schweizerische Sportmittelschule Engelberg AG	AG
73	Pro Senectute Kanton Solothurn - Für das Alter	Stiftung
74	Keradonum Stiftung Hornhautbank	Stiftung
14	Jugend ohne Drogen	Verein
136	Gewerbeverband der Stadt Zürich	Verein
76	Interessengemeinschaft öffentliche Arbeitsplätze	Verein
15	Stiftung zur Förderung der Weiterbildung in Hausarztmedizin	Stiftung
16	Associazione per l'aiuto medico al Centro America	Verein
77	Komitee Pro Eppenberg	Verein
138	Swiss Police ICT	Verein
137	Pro Natura Basel	Verein
78	Verband Lehrerinnen & Lehrer Solothurn	Verein
139	Schweizerisches Rotes Kreuz Kanton Zürich	Verein
165	Fondation "Le Tremplin"	Stiftung
164	Bildungszentrum für geistig behinderte Erwachsene des Kantons Freiburg	Stiftung
140	swisscleantech	Verein
141	Frauenzentrale Zürich	Verein
191	Aqua Viva	Verein
166	Fondation Les Buissonnets	Stiftung
192	Gesellschaft für das Weinbaumuseum am Zürichsee	Verein
143	Kistenfabrik und Holzhandels AG	AG
167	Fonds de recherche du centenaire de l'Université de Fribourg	Stiftung
142	Fritz Heid AG, Thürnen	AG
168	SchweizMobil	Stiftung
194	Swiss Leaders	Verein
169	Stiftung éducation21	Stiftung
196	Verein für Ingenieurbiologie	Verein
145	Gewerbeverein Sissach und Umgebung	Verein
170	Die Freunde des Konservatoriums Freiburg	Verein
195	Spitex-Verband Kanton Zürich	Verein
144	Treff 44 AG	AG
146	Hauseigentümerverband Sissach/Läufelfingen	Verein
147	Liga der Baselbieter Steuerzahler	Verein
197	Fachhochschule Nordwestschweiz FHNW	Staatlich
171	Dachverband Komplementärmedizin	Verein
148	KGIV der Wirtschaftskammer Basel-Landschaft	Informelle Gruppe
19	Nationale Arbeitsgemeinschaft Suchtpolitik	Verein
199	Regionalplanungsgruppe Rohrdorferberg-Reusstal	Staatlich
173	Denknetz	Verein
172	Dachverband Schweizerischer Patientenstellen	Verein
20	EQUAM Stiftung	Stiftung
150	LifeWatch GmbH	GmbH
174	Gesundheitsligen des Kantons Freiburg	Verein
149	Wirtschaftsrat der Wirtschaftskammer Basel-Landschaft	Informelle Gruppe
202	Stiftung Ballenberg	Stiftung
200	Verteilung Alkoholzehntel im Aargau	Staatlich
175	Krebsliga des Kantons Freiburg	Verein
218	Schweizer Jugend forscht	Stiftung
220	Stiftung Kinderdorf Pestalozzi	Stiftung
201	Albert und Ida Nüssli-Stutz-Stiftung	Stiftung
152	Young Kickers Foundation	Stiftung
221	Aufsichtskommission der Interstaatlichen Erwachsenenmatura	Ausserparlamentarische Kommission
151	tracker.ch AG	AG
176	Nationale Informationsstelle für Kulturgüter-Erhaltung (NIKE)	Verein
153	Sportmuseum Schweiz in Liquidation	Stiftung
223	HKG Consulting AG	AG
177	Association Ouestrail	Verein
181	Schweizeriche Gesellschaft für Gesundheitspolitik SGGP	Verein
159	Lions Club Winterthur	Verein
184	Partners in Learning Leadership Forum	Informelle Gruppe
251	Stiftung VITA Parcours	Stiftung
206	Kurt Imhof Stiftung für Medienqualität	Stiftung
190	Allianz "Ja zur Initiative für den OeV"	Informelle Gruppe
322	Careum Stiftung	Stiftung
282	Ospita - Die Schweizer Gesundheitsunternehmen	Verein
284	Kanton Tessin	Staatlich
244	LITRA Informationsdienst öffentlicher Verkehr	Verein
247	Osiris Therapeutics Inc., Baltimore	AG
325	Foundation National Institute for Cancer Epidemiology and Registration (NICER)	Stiftung
344	Schweizerischer Gewerbeverband	Verein
314	Genossenschaft Studentenhaus ALV	Genossenschaft
346	H + die Spitäler der Schweiz	Verein
212	Stiftung Speranza in Liquidation	Stiftung
348	Associazione Scigué	Verein
335	Anlagestiftung Pensimo für Personalvorsorge-Einrichtungen	Stiftung
320	Spital Thurgau AG	AG
224	Seniorweb AG	AG
216	ch-intercultur	Verein
358	FDP Die Liberalen Basel-Stadt	Verein
258	Sicherheitsverbund Schweiz (politische Leitung)	Staatlich
260	Les hôpitaux universitaires de Genève	Oeffentlich-rechtlich
409	SwissMediaForum AG	AG
402	Spitex Schweiz	Verein
300	Schweizerische Wettbewerbsvereinigung in Liquidation	Verein
458	Glencore (Schweiz) AG	AG
418	CSD Holding AG	AG
460	Raiffeisen Schweiz Genossenschaft	Genossenschaft
419	Swiss eHealth Forum	Informelle Gruppe
269	Groupe E SA	AG
49	Kaufmännischer Verband Schweiz	Verein
481	Schweizerischer Pensionskassenverband (ASIP)	Verein
490	VPS Verlag Personalvorsorge und Sozialversicherung AG	AG
56	CASTAGNA, Beratungs- und Informationsstelle	Verein
497	Genossenschaft Gebäudehülle Schweiz	Genossenschaft
504	ASTAG Schweizerischer Nutzfahrzeugverband	Verein
82	IG Pro Vebo - Pro Insos	Verein
92	Berner Jägerverband (BEJV)	Verein
97	Stiftung Pro Senectute Aargau	Stiftung
94	Aktion für vernünftige Energiepolitik Schweiz	Verein
506	Emmi-Wohlfahrtsfonds	Stiftung
511	Sanagate AG	AG
535	Schweizerischer Verkehrssicherheitsrat	Verein
543	Cleantech21 Foundation	Stiftung
550	Verein CULTURA	Verein
561	Schweizer Forum Elektromobilität	Informelle Gruppe
566	Kantonales Ethik-Forum St. Gallen	Staatlich
602	WWF Schweiz	Stiftung
595	Spiritsuisse	Verein
620	Gewerbekammer des Schweizerischen Gewerbeverbands	Verein
624	Lungenliga Schweiz	Verein
638	Kaufmännischer Verband Zürich	Verein
646	Swiss Science Center Technorama	Stiftung
652	Association romande contre la drogue ARCD	Verein
663	Association suisse pour l'Evaluation d'Impact sur la Santé en liquidation	Verein
682	Verein Zusammenschluss Oberlandstrasse	Verein
681	Die Mitte Zürich	Verein
675	Syna	Verein
713	PHS Public Health Services GmbH	GmbH
725	FER Neuchâtel fédération des entreprises romandes	Verein
729	Betonsuisse Marketing AG	AG
759	bauenschweiz	Verein
749	MKR Consulting AG	AG
773	Groupement Romand d'Etudes des Addictions GREA	Verein
778	HELVETAS Swiss Intercooperation	Verein
802	Knecht Mühle AG	AG
809	Churfirsten-Club	Verein
815	Konferenz der kantonalen Direktoren des öffentlichen Verkehrs (KöV)	Staatlich
696	Leichtathletik Club Zug	Verein
831	Europäischer Versicherungsverband	Verein
840	Krebser AG	AG
851	ELICT AG in Liquidation	AG
869	Swiss Cyber Storm	Verein
875	Vorsorgeforum	Verein
892	IG Freiheit	Verein
896	compenswiss (Fonds de compensation AVS/AI/APG)	Oeffentlich-rechtlich
917	Trendtage Gesundheit Luzern	Verein
924	Parlamentarischer Verein Schweiz - USA	Verein
938	OVT Oberwallis Verkehr und Tourismus	Verein
946	Hochparterre AG	AG
955	Stiftung für das Oekumenische Zentrum der Psychiatrischen Universitätsklinik Basel	Stiftung
964	Spida Familienausgleichskasse Genossenschaft	Genossenschaft
985	Europäische Vereinigung zur Förderung der Gesundheit	Verein
980	Schweizerische Rettungsflugwacht (Rega)	Stiftung
996	Schutzverband der Bevölkerung um den Flugplatz Emmen	Verein
1017	Förderstiftung Technopark Aargau	Stiftung
1034	UWA Immobilien AG	AG
1021	Hochschule Luzern	Oeffentlich-rechtlich
1045	Naturfreunde Schweiz	Verein
1039	Sinergy Infrastructure SA	AG
1090	NaturSpielWald	Verein
1065	Gruppe für eine Schweiz ohne Armee	Verein
1110	Verband Schweizer Privatradios	Verein
1121	ADEV Wasserkraftwerk AG	AG
1152	Calanda Recycling AG	AG
1144	Medien-Panoptikum	Verein
1168	Event + Kart AG Bonaduz in Liquidation	AG
1161	Calanda Muldenservice AG	AG
1196	Stiftung Salecina	Stiftung
1195	Verband Verkauf Schweiz	Verein
1201	auto-schweiz VEREINIGUNG SCHWEIZER AUTOMOBIL-IMPORTEURE	Verein
1215	Commission consultative militaire (Genève)	Staatlich
1221	Beso Batterieentsorgungs-Selbsthilfeorganisation Genossenschaft in Liquidation	Genossenschaft
1240	Glarner Kantonalbank	Oeffentlich-rechtlich
1262	MediaTi Web SA	AG
1249	Grüne Partei Basel-Stadt	Verein
229	Verein Cleantech Aargau	Verein
250	Sanitas Krankenversicherung	Stiftung
275	cemsuisse Verband der Schweizerischen Cementindustrie	Verein
234	Axpo Holding AG	AG
188	Association Sortir du nucléaire	Verein
252	Swiss School of Public Health (SSPH+), Zürich	Stiftung
281	Verein PPP (Public Private Partnership) Schweiz	Verein
304	Ospedale Malcantonese Fondazione Giuseppe Rossi	Stiftung
306	Wohlfahrtsstiftung der Elektra Baselland in Liquidation	Stiftung
308	atelier politique Fehr	Einzelunternehmen
248	Rahn AG	AG
289	santésuisse	Verein
313	Verein Publikationen Spezialkulturen	Verein
210	Forum Alter und Migration	Informelle Gruppe
291	Schweizer Obstverband	Verein
332	Pensimo Fondsleitung AG	AG
349	mcw - Miriam C. Wetter Arni	Einzelunternehmen
255	vips Vereinigung Pharmafirmen in der Schweiz	Verein
294	Schweizerischer Fussballverband	Verein
215	Skilift Oberegg-St. Anton AG	AG
338	Baloise Leben AG	AG
295	Hausärzte Schweiz, Berufsverband der Haus- und Kinderärztinnen Schweiz	Verein
353	Aids Hilfe beider Basel	Verein
256	Institut Suisse de Police (ISP)	Stiftung
339	Baloise Versicherung AG	AG
370	Caisse de retraite anticipée du second oeuvre romand (RESOR)	Stiftung
249	Fritz Gerber-Stiftung für begabte junge Menschen	Stiftung
341	Stiftung Allalin	Stiftung
356	Musikbüro Basel	Verein
363	Gewerbeverband Basel-Stadt	Verein
405	Verein TIXI Aargau	Verein
299	Perron Campaigns GmbH	GmbH
263	Schweizerischer Hebammenverband	Verein
426	Università della Svizzera italiana	Oeffentlich-rechtlich
264	ARGOS, Association d'aide aux personnes toxico-dépendantes	Verein
457	Hirzel.Neef.Schmid.Konsulenten AG	AG
469	BG Mitte, Bürgschaftsgenossenschaft für KMU	Genossenschaft
472	Arbeitgeber Baselland	Verein
473	Maler- und Gipserunternehmer-Verband Baselland	Verein
480	ABB Schweiz Holding AG	AG
484	PROVITA Gesundheitsversicherung AG	AG
106	Retraites Populaires	Oeffentlich-rechtlich
494	Metall NWCH	Verein
58	PRO FAMILIA SCHWEIZ	Verein
28	FMH Verbindung der Schweizer Ärztinnen und Ärzte	Verein
30	Ente Ospedaliero Cantonale (EOC)	Oeffentlich-rechtlich
85	Spitex Verband Kanton Solothurn	Verein
429	curafutura - Die innovativen Krankenversicherer	Verein
39	economiesuisse	Verein
520	veb.ch Schweizerischer Verband der dipl. Experten in Rechnungslegung und Controlling und der Inhaber des eidg. Fachausweises in Finanz- und Rechnungs…	Verein
522	Schweizerische Treuhand-Kammer	Verein
544	Maxmakers AG	AG
557	Swisscom (Schweiz) AG	AG
554	Azienda elettrica ticinese	Oeffentlich-rechtlich
577	Pflege	Parlamentarische Gruppe
588	Gebäudeversicherung Bern (GVB)	Oeffentlich-rechtlich
597	Vermeiren (Svizzera) SA	AG
611	Förderverein ProPapiliorama	Verein
618	Dianam S.A.	AG
636	Zürich Erneuerbar	Verein
637	Biodiversität und Artenschutz	Parlamentarische Gruppe
654	Schweizerische Vereinigung für Qualitäts- und Management-Systeme (SQS)	Verein
644	Pro Seniorweb - Stiftung	Stiftung
684	Panathlon Club Winterthur	Verein
683	Haflingerverein Nordostschweiz (HNO)	Verein
678	IG Detailhandel Schweiz	Einfache Gesellschaft
707	St-Paul Immobilier SA	AG
719	Verein für Originalgraphik	Verein
704	JPF Gravières SA	AG
758	Kernkraftwerk Leibstadt AG	AG
752	Seilbahnen Schweiz	Verein
776	Bundeskriminalamt BKA	Staatlich
800	Schweizerische Volkspartei Waadt	Verein
799	Geschäftsberichte - Symposium AG	AG
804	Hauseigentümerverband Aargau	Verein
817	Konferenz Kantonaler Volkswirtschaftsdirektoren (VDK)	Staatlich
829	Konkordat über die Schürfung und Ausbeutung von Erdöl	Staatlich
847	Verein Steamtown	Verein
837	Garaio AG	AG
860	Stiftung BASE (Basel Agency for Sustainable Energy)	Stiftung
858	Verein Surprise	Verein
884	VCS Verkehrs-Club der Schweiz Sektion Luzern	Verein
879	Coordinamento donne della sinistra	Verein
912	Tripartite Kommission des Bundes	Ausserparlamentarische Kommission
897	Stiftung Auffangeinrichtung BVG	Stiftung
927	Zentrale Paritätische Kontrollstelle, ZPK	Verein
933	Accertis AG	AG
951	Radio Rottu Oberwallis AG	AG
962	Schilliger Holding AG	AG
978	Patronale Stiftung der Cube Media AG in Liquidation	Stiftung
982	Europäische Vereinigung zur Förderung der Gesundheit, Schweiz	Verein
997	Sicherheit für alle	Verein
1004	BSC Young Boys Betriebs AG	AG
1024	Hauseigentümerverband Kanton Luzern	Verein
1015	Green Datacenter AG	AG
1032	FC Luzern-Innerschweiz AG	AG
1054	Institut Kinderseele Schweiz - Schweizerische Stiftung zur Förderung der psychischen Gesundheit von Kindern und Jugendlichen	Stiftung
1067	Handels- und Industrieverein des Kantons Bern	Verein
1092	Verband Schweizerischer, Polizeibeamter (VSPB)Verbandssekretariat	Verein
1108	Lötschberg Komitee	Verein
1111	Staatskanzlei des Kantons Bern	Staatlich
1127	Touring Club Schweiz (TCS), Sektion Waldstätte	Verein
1154	Pro Libertate	Verein
1130	Gönner-Vereinigung der Schweizer Paraplegiker-Stiftung (GöV)	Verein
1150	Kieswerk Calanda AG	AG
274	Amis de la Fille-Dieu	Verein
231	Institut für Wirtschaftsethik der Universität St. Gallen	Staatlich
161	Berner Fachhochschule	Oeffentlich-rechtlich
187	Allianz Atomausstieg	Verein
277	Verein Eidgenössisches Turnfest 2013	Verein
279	Neue Helvetische Gesellschaft NHG	Verein
207	Stiftung Regionales Blutspende-Zentrum	Stiftung
283	Aktion Medienfreiheit	Verein
285	Novartis International AG	AG
246	AXA Versicherungen AG	AG
288	INTERPHARMA	Verein
326	Pestalozzi-Stiftung für die Förderung der Ausbildung Jugendlicher aus schweizerischen Berggegenden	Stiftung
290	Schweizerische Aussenwirtschaftsförderung OSEC	Verein
211	Forum Vera	Verein
292	Schweizerischer Versicherungsverband (SVV)	Verein
318	HRS Holding AG	AG
350	furrerhugi.ag	AG
351	BG OST-SÜD Bürgschaftsgenossenschaft für KMU	Genossenschaft
204	Gen Suisse - Schweizerische Stiftung für Gentechnik	Stiftung
354	Aids-Hilfe Schweiz	Verein
360	Netzwerk Kinderbetreuung	Verein
406	Sport Heart GmbH	GmbH
298	Stiftung UNIA	Stiftung
261	Forum Gesundheit Schweiz	Informelle Gruppe
415	alliance F - Bund Schweizerischer Frauenorganisationen	Verein
404	Swiss Women Network Swonet	Informelle Gruppe
436	Stiftung centro del bel libro	Stiftung
455	IMMOBILIARE MEGISTI SA	AG
420	Energie-Agentur der Wirtschaft (EnAW)	Verein
464	Scholten Partner GmbH	GmbH
447	touring club schweiz (TCS) Sektion Zürich	Verein
50	Travail.Suisse	Verein
52	Raiffeisenbank Liestal-Oberbaselbiet Genossenschaft	Genossenschaft
272	Liebherr Maschinen Bulle AG	AG
488	Sulzer Vorsorgeeinrichtung	Stiftung
496	Verband Basellandschaftlicher Elektro-Installationsfirmen VBLEI	Verein
110	ACS Sektion Waadt	Verein
81	Pro Natura Solothurn	Verein
34	Fédération Romande des Consommateurs (FRC)	Verein
495	EIT.swiss	Verein
90	GEWA	Stiftung
35	Stiftung für Konsumentenschutz	Stiftung
516	Dynamics Group AG	AG
528	Bundesamt für Strassen ASTRA	Staatlich
548	UBS Clean Energy Infrastructure Switzerland AG	AG
526	Velokonferenz Schweiz	Informelle Gruppe
567	Kantonale Ethikkommission Zürich, Abteilung A	Staatlich
560	SOCAR Energy Switzerland GmbH	GmbH
582	Kanton Waadt	Staatlich
589	Verband Holzindustrie Schweiz HIS	Verein
590	JagdSchweiz	Verein
623	Liga für Zeckenkranke Schweiz (LiZ)	Verein
634	Association Nochlezhka Suisse Solidaire	Verein
627	Schweizerische Muskelgesellschaft	Verein
655	Personalvorsorgestiftung der Wilhelm Schulthess-Stiftung	Stiftung
662	QualiCCare	Verein
688	CLINIQUE LE NOIRMONT SOCIETE COOPERATIVE	Genossenschaft
686	Allianz Schweizer Krankenversicherer in Liquidation	Verein
716	syneric GmbH	GmbH
703	Pensionskasse des Interkantonalen Rückversicherungsverbandes in Liquidation	Stiftung
721	Freiburgischer Arbeitgeberverband UPCF	Verein
701	Stiftung Technopark Zürich	Stiftung
730	Senso5	Stiftung
765	Josef Voegeli-Stiftung	Stiftung
781	Avenergy Suisse	Verein
782	Migros-Genossenschafts-Bund	Genossenschaft
807	Transports publics fribourgeois Holding (TPF) SA	AG
808	Schweizerische Volkspartei Basel-Stadt	Verein
819	Glattstrom Buchholz AG	AG
826	Verein Appenzellerland Tourismus AI	Verein
841	MALI International AG	AG
828	GRIAG Holding AG	AG
868	Swiss Cyber Experts	Verein
863	The Gold Standard Foundation	Stiftung
878	VPOD Ticino	Verein
891	Mobile Jugendarbeit Basel/Riehen	Verein
913	Tripartite Kommission des Kantons Tessin FlaM	Ausserparlamentarische Kommission
899	Edizioni Sociali SA in liquidazione	AG
936	Eidgenössische Kommission für Kinder- und Jugendfragen EKKJ	Ausserparlamentarische Kommission
943	Berner Oberland Medien AG BOM	AG
959	IC AG Beratung	AG
961	Partner Immobilien AG	AG
988	Scuola superiore medico tecnica SSMT	Staatlich
981	Association d'aide aux enfants "Omoana"	Verein
1000	Kuratorium Wasserturm	Verein
1010	Burson Cohn & Wolfe AG, Zweigniederlassung Bern	AG
1026	Swiss-Chinese Chamber of Commerce	Verein
1031	ICTswitzerland	Verein
1044	Vereinigung Aargauischer Angestelltenverbände (VAA)	Verein
1038	RADIO CHABLAIS SA	AG
1091	Familienzentrum Karussell Region Baden	Verein
1076	Verband der Arbeitgeber Region Bern	Verein
1112	Vifor Pharma AG	AG
1099	Grunder Pferdemanagement AG	AG
1151	Kieswerk Reichenau AG	AG
1116	Unibau-Generalunternehmung AG	AG
1132	Mobimo Holding AG	AG
1149	Calanda-Beton AG	AG
1164	Kantonsspital Graubünden Immobilien AG in Liquidation	AG
1175	Interessengemeinschaft Kleinwasserkraft Glarnerland (KWK Glarnerland)	Verein
1167	Baustoffwerk Trimmis AG	AG
1214	Schweizer Heimatschutz, Sektion Genf	Verein
1238	Nimbus AG	AG
1222	Orthotec AG	AG
1261	AIDA Marketing SA	AG
1231	Standeskommission	Staatlich
1266	Auslandschweizer-Organisation	Stiftung
1282	Rotary Club Fribourg Cité	Verein
1271	Swiss Communication Agency Sagl	GmbH
1274	Hotel Allegro Bern AG	AG
158	Arbeitsgruppe Gesundheitswesen	Informelle Gruppe
232	Solothurner Spitäler AG	AG
186	Cochrane Schweiz	Informelle Gruppe
235	De Martin AG Surface Technology	AG
278	Tourismus Jura & Drei-Seen-Land	Verein
302	Schweizerische Akademie der Medizinischen Wissenschaften (SAMW)	Stiftung
240	Emmi AG	AG
241	Verkehrsbetriebe Luzern AG	AG
243	Industrie- und Handelskammer Zentralschweiz IHZ	Verein
323	AMIS Plus Stiftung	Stiftung
310	Charlotte und Hans Haller Stiftung	Stiftung
312	Agro-Marketing Suisse (AMS)	Verein
253	Jerusalem Foundation Switzerland	Stiftung
329	Stiftung für Sucht- und Gesundheitsforschung	Stiftung
316	Stiftung Schweizer Volkskultur	Stiftung
317	Stiftung MyHandicap	Stiftung
293	Solidar Suisse	Verein
336	Schweizerischer Arbeitgeberverband	Verein
321	Roland Eberle Mercanda Consulting	Einzelunternehmen
154	FH SCHWEIZ, Dachverband der Absolventinnen und Absolventen Fachhochschulen	Verein
296	Die Schweizerische Post AG	Oeffentlich-rechtlich
297	Swiss Textiles Textilverband Schweiz	Verein
376	Société Immobilière Cluse-Préau SA	AG
259	Pulita Putzteam GmbH	GmbH
394	HKG Engineering AG Baden	AG
6	bosec consulting gmbh	GmbH
403	Aargauischer Tierschutzverein	Verein
417	Reliva AG	AG
450	Eidgenössische Arbeitskommission EAK	Staatlich
461	Verband Schweizerischer Kantonalbanken	Verein
446	Touring Club Suisse (TCS)	Verein
466	Sensor Advice GmbH	GmbH
101	Verein Schweizerisches Netzwerk gesundheitsfördernder Spitäler und Dienste	Verein
271	JPF Holding S.A., Bulle	AG
105	Pro Infirmis, Zweigniederlassung Kanton Thurgau und Schaffhausen	Verein
491	Wohlfahrtsfonds der Angestellten und Arbeiter der Firma Caliqua AG	Stiftung
108	Fondation Mont-Calme	Stiftung
80	Palliative Care Netzwerk Kanton Solothurn	Verein
115	Centre Patronal	Verein
83	SEV - Gewerkschaft des Verkehrspersonals	Verein
87	Schweizerische Vereinigung zum Schutz der kleinen und mittleren Bauern	Verein
369	Berufsübergreifende Kontroll-Vereinigung AIC	Verein
508	Kaufmännischer Verband Baselland KVBL	Verein
529	Swiss Re AG	AG
536	Fonds für Verkehrssicherheit	Ausserparlamentarische Kommission
539	Eawag	Staatlich
559	Alpiq Holding SA	AG
565	Eidgenössische Kommission für allgemeine Leistungen und Grundsatzfragen (ELGK)	Ausserparlamentarische Kommission
584	FFU FachFrauen Umwelt PEE Professionnelles En Environnement	Verein
596	Association Spitex privée Suisse (ASPS)	Verein
576	Pro Natura - Schweizerischer Bund für Naturschutz	Verein
606	BEST WESTERN SWISS HOTELS Genossenschaft in Liquidation	Genossenschaft
619	Oltra AG	AG
633	Watch it	Informelle Gruppe
647	HKG Engineering AG	AG
656	Kommission für Wirtschaftspolitik	Ausserparlamentarische Kommission
672	OK Tage der Aerophilatelie 2014	Informelle Gruppe
679	Foundation - Global Risk Forum GRF Davos in Liquidation	Stiftung
694	Kernkraftwerk Gösgen-Däniken AG	AG
695	Connecta, Integration geistig Behinderter im Arbeitsmarkt	Verein
714	SwissNOSO	Verein
723	Fédération des Entreprises Romandes de l'Arc jurassien	Verein
751	Verband öffentlicher Verkehr, Genossenschaft (VöV)	Genossenschaft
755	Notariatskommission des Kantons Obwalden	Staatlich
747	CONCORDIA Schweizerische Kranken- und Unfallversicherung	Verein
750	Baloise Holding AG	AG
779	Korporation Mendle	Oeffentlich-rechtlich
803	Mühle Leibstadt AG	AG
814	Université de Neuchâtel	Oeffentlich-rechtlich
786	Qualitätsstrategie Schweizer Land- und Ernährungswirtschaft	Informelle Gruppe
830	Gönnervereinigung der Stiftung Speranza	Verein
722	Fédération des Entreprises Romandes Genève	Verein
848	Fortra International GmbH	GmbH
843	PHILIPP FANKHAUSER PRODUCTIONS AG	AG
871	MUS-E Schweiz	Verein
874	Energiedienst Holding AG	AG
889	Patientenstelle Zürich	Verein
900	Paritätische Landeskommission Gebäudetechnik	Verein
921	Bund der Steuerzahler (BDS) Thurgau	Verein
893	Statistisch-Volkswirtschaftliche Gesellschaft Basel	Verein
941	CADES centrale d'achats des établissements sanitaires société coopérative en liquidation	Genossenschaft
937	Kommission für Ausländerbewilligungen des Kantons Tessin	Staatlich
967	CRB, Schweizerische Zentralstelle für Baurationalisierung	Verein
968	Schweizerisch-Liechtensteinischer Gebäudetechnikverband (suissetec)	Verein
986	Universität Zürich	Staatlich
990	Berner Public Relations Gesellschaft	Verein
1012	Swissphotonics - Verein Schweizer Laser und Photonik Netz, Wollerau	Verein
1013	Noser Management AG	AG
1007	ICT-Berufsbildung Schweiz	Verein
1041	Aargauischer Gewerkschaftsbund	Verein
1033	Kago Wärmesysteme GmbH	GmbH
1062	Wetec Service und Verkauf AG	AG
1105	Grunder Holding GmbH	GmbH
1064	Amnesty International - Schweizer Sektion	Verein
1079	Schweizer Wanderwege	Verein
1109	Stiftung für Radio und Kultur Schweiz	Stiftung
1114	FDP Die Liberalen Kanton Luzern	Verein
1134	Swisscontact, Schweizerische Stiftung für technische Entwicklungszusammenarbeit	Stiftung
1118	Auto AG Holding	AG
1158	Föderation der Motorradfahrer der Schweiz (FMS)	Verein
1163	Stiftung Kantonsspital Graubünden	Stiftung
230	Center for Disability and Integration, Universität St.Gallen	Staatlich
183	Koordinationsstab Harmos der Schweizerischen Konferenz der kantonalen Erziehungsdirektoren EDK	Staatlich
233	Moriz und Elsa von Kuffner - Stiftung	Stiftung
163	ACADEMIE MOBILITE SA	AG
236	KIBAG HOLDING AG	AG
238	BDO AG	AG
303	Casa anziani Malcantonese Fondazione Giovanni e Giuseppina Rossi	Stiftung
305	Fondazione Circolo Franchi Liberali e Filarmonica Liberale-Radicale Collina d'Oro	Stiftung
287	foraus - Forum Aussenpolitik - Forum de politique étrangère	Verein
309	Profil	Stiftung
343	Intergenerika	Verein
209	Technopark Aargau	Stiftung
328	Stiftung für Lungendiagnostik	Stiftung
315	Hauseigentümerverband Meilen und Umgebung	Verein
347	Schweizerischer Mieterinnen- und Mieterverband	Verein
333	Aktiengesellschaft für die Neue Zürcher Zeitung	AG
334	Asga Pensionskasse Genossenschaft	Genossenschaft
319	Swiss Steel Holding AG	AG
352	Stiftung Schloss Neu-Bechburg	Stiftung
156	Schweizerischer Turnverband STV	Verein
340	SWISSAID, Schweizerische Stiftung für Entwicklungszusammenarbeit	Stiftung
373	IndustriALL Global Union	Verein
377	Suva	Oeffentlich-rechtlich
393	Verband Schweizerischer Schreinermeister und Möbelfabrikanten	Verein
5	fun & business AG	AG
398	Oncosuisse, Schweizerische Vereinigung gegen Krebs	Verein
387	Soliswiss - Genossenschaft der Schweizer im Ausland	Genossenschaft
459	Inlandbanken	Parlamentarische Gruppe
437	FDP Die Liberalen Kanton Zürich	Verein
462	Vereinigung Schweizerischer Futtermittelfabrikanten (VSF)	Verein
267	Editions D + P (Démocrate + Pays)	AG
448	Touring Club Schweiz TCS Ortsgruppe Winterthur	Verein
99	Stiftung OL SCHWEIZ	Stiftung
104	Schweizer Vogelschutz SVS/BirdLife Schweiz	Verein
54	Kinderschutz Schweiz	Stiftung
498	Verband Dach & Wand Baselland (Vdwbl)	Verein
501	Autogewerbeverband der Schweiz AGVS, Sektion beider Basel	Verein
366	Bund der Steuerzahler (BDS)	Verein
27	Swiss Label	Verein
86	Staatspersonalverband Kanton Solothurn	Verein
422	Fourchette verte Schweiz - Das Label der ausgewogenen Ernährung	Verein
36	Schweizerischer Gewerkschaftsbund	Verein
523	Schweizerischer Verband der Telekommunikation ASUT	Verein
518	Kaufmännischer Verband Luzern	Verein
547	Ampard AG in Liquidation	AG
552	EVTEC AG	AG
569	Rheumaliga Zürich, Zug und Aargau	Verein
553	ewz UTN NE1 AG	AG
592	Schweizerischer Bäcker-Confiseurmeister-Verband	Verein
598	Schweizer Zucker AG	AG
609	Projektgruppe Dombresson der Fondation Suisse Bellevue	Informelle Gruppe
610	Universitätsspital Zürich	Oeffentlich-rechtlich
630	IG Zöliakie der deutschen Schweiz	Verein
642	Forum Elle (Die Frauenorganisation der Migros)	Verein
648	Netzwerk Arbeit Kanton Schwyz	Verein
641	Parlamentarische Gruppe Suchtpolitik, Prävention und Jugendschutz	Parlamentarische Gruppe
687	Schweizerischer Verband für Gemeinschaftsaufgaben der Krankenversicherer (SVK)	Verein
680	Stiftung RoadCross Schweiz	Stiftung
690	SASIS AG	AG
705	JPF Immobilier SA	AG
741	Guido Fluri-Stiftung	Stiftung
745	Stiftung Kranken- und Unfallkasse Konkordia	Stiftung
764	Glattwerk AG	AG
753	Zentralschweizer Komitee Durchgangsbahnhof Luzern	Informelle Gruppe
798	ZHAW Zürcher Hochschule für Angewandte Wissenschaften	Staatlich
787	Espace mobilité	Verein
810	Verband Stahl-, Metall- und Papier-Recycling VSMR	Verein
789	LCD Gestion Fiduciaire Sàrl	GmbH
821	Stiftung PWG zur Erhaltung von preisgünstigen Wohn- und Gewerberäumen der Stadt Zürich	Oeffentlich-rechtlich
823	plusimmo AG	AG
832	Fachverband VREG-Entsorgung	Verein
849	Energie Service Biel/Bienne (ESB)	Oeffentlich-rechtlich
852	Büro Dr. Rösti GmbH in Liquidation	GmbH
864	Das Kind im Zentrum AG	AG
882	Centre Touristique Gruyères-Moléson-Vudalla S.A.	AG
890	Sexuelle Gesundheit und Rechte	Parlamentarische Gruppe
906	Paritätische Kommission für Bau und Technik des Kantons Tessin	Verein
908	Paritätische Kommission für Carosseriegewerbe des Kantons Tessin	Verein
929	Gewerbeverband Baselland	Verein
931	Tripartite Kommission Flankierende Massnahmen BL	Staatlich
950	Oberwalliser-Presseverein AG in Liquidation	AG
945	Quantum Digital AG	AG
971	Personalfürsorgestiftung der Herzog Gruppe	Stiftung
974	World Plumbing Council (WPC)	Verein
999	Organisation der Arbeitswelt Medizinischer Masseure	Verein
1003	Gemeinde Ollon	Staatlich
1023	Kantonale Offiziersgesellschaft Luzern	Verein
1030	Club der 200	Verein
1047	Schweiz. Vereinigung für Sonnenenergie (Sses)	Verein
1056	Visana Beteiligungen AG	AG
1068	A Planer AG	AG
1093	Grunder Ingenieure AG	AG
1106	Concour Suisse Ernst Haefliger	Verein
1066	Schweizerische Mobiliar Versicherungsgesellschaft AG	AG
1123	Willy Gysin AG	AG
1126	Rotary-Club Luzern	Verein
1117	Wascosa Holding AG	AG
1148	Repower AG	AG
1173	Branchenverband Schweizer Reben und Weine	Verein
1133	GT-Consulting Georges Theiler	Einzelunternehmen
1188	Association pour la Défense des Chômeurs ADC	Verein
1200	Stiftung SoliWerk	Stiftung
182	Hochspannung unter den Boden	Verein
160	Swisscup Zürich	Informelle Gruppe
162	Kompetenzzentrum Sexualpädagogik und Schule	Oeffentlich-rechtlich
276	Stiftung Bieler Kommunikationstage	Stiftung
237	Stiftung Kartause Ittingen	Stiftung
239	CSS Holding AG	AG
208	Stiftung Vindonissapark	Stiftung
242	Stiftung BioPolis Entlebuch	Stiftung
307	Politcom, Agentur für politische Kommunikation und Public Affairs, Thomas de Courten	Einzelunternehmen
324	Dr. med. Ernst und Fanny Bachmann-Huber-Stiftung	Stiftung
311	Arbeitskreis Sicherheit und Wehrtechnik	Informelle Gruppe
327	Schweizerische Herzstiftung	Stiftung
345	Hauseigentümerverband Baselland	Verein
331	Verein "Forum Zürcher Gespräche"	Verein
254	Krebsliga des Kantons Zürich	Verein
213	Hauseigentümerverband Sektion Baden/Brugg/Zurzach	Verein
214	IG Musikinitiative	Informelle Gruppe
337	SWISS RETAIL FEDERATION (Vereinigung der Mittel- und Grossbetriebe des schweizerischen Detailhandels)	Verein
179	Pro Velo Schweiz	Verein
371	Immobiliengenossenschaft COGERIM	Genossenschaft
375	Unia Viva AG	AG
362	Arbeitgeberverband Basel	Verein
408	Respekt ist Pflicht - für alle	Informelle Gruppe
410	AWI AG	AG
413	VSV Verband des Schweizerischen Versandhandels	Verein
425	Université de Lausanne	Staatlich
434	Swiss Reha	Verein
266	Paul Grüninger Stiftung	Stiftung
451	INSTITUT LIBERTAS	Stiftung
47	Schweizer Bauernverband (SBV)	Verein
365	Aktion für eine unabhängige und neutrale Schweiz (AUNS)	Verein
479	Leder Partner in Liquidation	KG
485	SWICA Gesundheitsorganisation	Verein
483	Pensionskasse der Pro Infirmis	Stiftung
500	Arcosana AG	AG
505	Astag, Sektion Nordwestschweiz	Verein
26	Schweizerischer Verband freier Berufe (SVFB)	Verein
84	Spital Club Solothurn	Verein
93	Verband Bernischer Gemeinden VBG	Verein
430	Délégation de Taiwan, République de Chine	Verein
428	Alliance Santé	Informelle Gruppe
510	INTRAS Assurance-maladie SA	AG
534	Stiftung SYMPHASIS	Stiftung
541	Schweizerischer Ingenieur- und Architektenverein (SIA)	Verein
556	Elektrizitätswerke des Kantons Zürich (EKZ)	Oeffentlich-rechtlich
562	Fachkommission Gesundheit FDP	Informelle Gruppe
571	Physioswiss	Verein
585	sanu durabilitas - Schweizerische Stiftung für Nachhaltige Entwicklung	Stiftung
575	Departement Gesundheit der Zürcher Hochschule für Angewandte Wissenschaften	Staatlich
603	WWF - WORLD WIDE FUND FOR NATURE (formerly World Wildlife Fund)	Stiftung
626	Cystische Fibrose Schweiz CFS	Verein
615	Stiftung Schweizerische Akademie für Chiropraktik	Stiftung
645	machs! GmbH	GmbH
651	Swissgrid AG	AG
668	SwissHTA; Value & Valuation of Health Technologies	Informelle Gruppe
664	Equiterre	Verein
667	Association of International Pharmaceutical Manufacturers	Verein
693	CAVO-Stiftung	Stiftung
708	St-Paul Holding SA	AG
720	Fédération Patronale et Economique	Verein
744	CONCORDIA Versicherungen AG	AG
743	Nagra, Nationale Genossenschaft für die Lagerung radioaktiver Abfälle	Genossenschaft
736	Coopérative Cité Derrière	Genossenschaft
761	Interessengemeinschaft Schweizer Bergprodukte	Verein
783	Gruppe Grosser Stromkunden GGS	Einfache Gesellschaft
769	Freunde des Kollegi Sarnen	Verein
780	strasseschweiz	Verein
813	Universität Genf	Staatlich
697	Orientierungslauf-Vereinigung Zug (OLV Zug)	Verein
820	Cavallino Holding AG	AG
838	Gummi Merkur AG in Liquidation	AG
845	Zumbach Electronic AG	AG
854	Volkswirtschaft Berner Oberland	Verein
866	Organisation der Arbeitswelt Umwelt	Verein
877	Sozialdemokratische Partei der Schweiz	Verein
883	Leitungsausschuss Freiburger S-Bahn	Informelle Gruppe
902	Paritätische Landeskommission Elektrogewerbe	Verein
910	Schweizerischer Verband der Sozialversicherungs-Fachleute, SVS, Sektion Tessin	Verein
940	Visana Versicherungen AG	AG
925	Kinaesthetics Schweiz AG	AG
952	Zürichsee Medien AG	AG
958	Herzog Haustechnik AG Luzern	AG
966	Spida Personalvorsorgestiftung	Stiftung
973	KMU- und Gewerbeverband Kanton Luzern	Verein
998	IG Supermoto Emmen	Verein
1005	RADIO BERN1 AG	AG
1011	Burson Cohn & Wolfe AG	AG
1028	EY Entrepreneur Of The Year Alumni	Verein
1043	Kein Atommüll im Bözberg (KAIB)	Verein
1048	Groupe E Greenwatt SA	AG
1094	Schweizerisches Kompetenzzentrum für Menschenrechte	Einfache Gesellschaft
1095	Polizeistiftung Schweiz	Stiftung
1059	vivacare AG	AG
1100	Wasserversorgungsgenossenschaft Rüegsau und Umgebung	Genossenschaft
1136	AEE SUISSE - Dachorganisation der Wirtschaft für erneuerbare Energien und Energieeffizienz	Verein
1128	Junge Wirtschaftskammer Luzern - Junior Chamber International Lucerne (JCI Luzern)	Verein
1157	Hauseigentümerverband Kanton Solothurn	Verein
1169	Swissgas, Schweizerische Aktiengesellschaft für Erdgas	AG
1174	Kraftwerke Linthal AG	AG
1194	Stiftung Ombudsman der Privatversicherung und der SUVA	Stiftung
1139	Liegenschaft Hauptgasse 79 AG	AG
1210	Ville de La Chaux-de-Fonds	Staatlich
1192	Kantonal-Solothurnischer Gewerbeverband	Verein
1236	Zenhäusern Akademie AG in Liquidation	AG
180	Alzheimer Schweiz	Verein
257	St. Galler Stiftung für Internationale Studien	Stiftung
378	Tipo-Offset Aurora SA	AG
411	Krebsliga Aargau	Verein
449	Eidgenössische Kommission für Migrationsfragen EKM	Ausserparlamentarische Kommission
452	Schweizerische Gesellschaft für militärhistorische Studienreisen (GMS)	Verein
478	Capriccio Barockorchester	Informelle Gruppe
273	Société coopérative paysanne de cautionnement du canton de Fribourg	Genossenschaft
502	Emmi Finanz AG	AG
116	Centre Patronal Paudex	Verein
88	Vereinigung Solothurnischer Musikschulen	Verein
521	KMU-Forum Baselland	Staatlich
532	Stiftung EMPIRIS	Stiftung
572	Palliative Care Netzwerk Zürich/Schaffhausen	Verein
591	Verein Schweizer Armeemuseum	Verein
622	Stiftung aha! Allergiezentrum Schweiz	Stiftung
649	Lakers Sport AG	AG
670	Grün 19	Verein
677	Schweizerische Lebensrettungs-Gesellschaft SLRG	Verein
717	Stiftung Märtplatz	Stiftung
715	Demenz Forschung Schweiz - Stiftung Synapsis	Stiftung
771	Forum Handicap Thurgau	Einzelunternehmen
777	Appenzeller Kantonalbank	Oeffentlich-rechtlich
805	Aargauische Stiftung für Freiheit und Verantwortung in Politik und Wirtschaft	Stiftung
742	CONCORDIA Beteiligungen AG	AG
835	Vereinigung des Schweizerischen Tabakwarenhandels	Verein
855	emmental versicherung Genossenschaft	Genossenschaft
887	Stiftung Künstlerhaus Boswil	Stiftung
905	Stiftung Werk- und Wohnhaus zur Weid	Stiftung
942	Beat Lauber Strategie- & Kommunikationsberatung	Einzelunternehmen
948	Mengis Druck und Verlag AG	AG
970	Herzoooog Holding AG	AG
993	Gewerbeverein Emmen	Verein
1019	Technopark Luzern	Verein
1042	Jugendlobby Siggenthal	Verein
1069	Kraftwerke Oberhasli AG	AG
1058	sana24 AG	AG
1089	Caritas Schweiz	Verein
1135	Verein für Sozialpsychiatrie Baselland	Verein
1162	Tschudy AG	AG
1176	Feldschützen Linthal	Verein
1213	Association Les Berges de Vessy	Verein
1239	Synegration AG	AG
1224	Zweckverband Abwasserreinigungsanlage (ARA) Bellach-Lommiswil-Langendorf	Staatlich
1267	Gotthard-Komitee	Verein
1305	Verein SwissGAP	Verein
1312	Wascosa AG	AG
1295	Abwasserverband Untersiggenthal-Turgi	Staatlich
1355	Association Suisse des Assurés (ASSUAS) Section Vaud	Verein
1363	Corref	Verein
1400	Verein Stromeffizienz-Initiative	Verein
1405	Newtechclub	Verein
1432	ETH Zürich	Staatlich
1451	IG Arbeitsplätze im Berggebiet und im ländlichen Raum	Verein
1475	Zentrum La Suisse Brig AG	AG
1499	Groupe Mutuel Vie GMV SA	AG
1519	Stiftung KMU Schweiz in Liquidation	Stiftung
1546	Sport Union Schweiz	Verein
1566	Sportverband Kanton Schwyz (SKS)	Verein
1587	Wirtschaftsförderung Kanton Basel-Landschaft	Staatlich
1601	Gewerbeverband des Kantons Zug	Verein
1622	Tourismus PGT	Parlamentarische Gruppe
1641	FONDATION ROMANDE POUR LA CHANSON ET LES MUSIQUES ACTUELLES	Stiftung
1664	Fondation IPT	Stiftung
1690	STARPROJECT AG	AG
1713	Personalvorsorge-Stiftung Kinderhilfe Bethlehem	Stiftung
1732	Verein Nein zur 2. Gotthardröhre	Verein
1769	Flückiger Holz Immobilien AG	AG
1795	Karch Kampagnen GmbH in Liquidation	GmbH
1807	Bündner Bauernverband	Verein
1843	Schweizerische Gesellschaft für Psychiatrie und Psychotherapie	Verein
1868	Fondation en faveur d'un laboratoire de recherches horlogères	Stiftung
1899	SVSE Engelberg Schweizerischer Sportverband öffentlicher Verkehr	Verein
1927	Hauseigentümerverband Schaffhausen	Verein
1938	Verkehrsverein Euthal	Verein
1972	Kantonale Arbeitsmarktkommission Kamko	Staatlich
1988	Volkswirtschaftskommission des Kantons Bern	Staatlich
2001	Bruderschaft St. Valentin	Verein
2049	Dipl.Ing. Heinrich Blumer-Stiftung	Stiftung
2039	Prahmendienst AG	AG
2113	Swiss Prime Site AG	AG
2073	Hirzel.Neef.Schmid.Konsulenten AG Genève	AG
2107	Meili Unternehmungen AG	AG
2150	Helvetia Schweizerische Lebensversicherungsgesellschaft AG	AG
2187	Europäische Transportarbeiter-Föderation	Verein
2178	Schweiz - Libanon	Parlamentarische Freundschaftsgruppe
2225	"Schweizerzeit" Verlags AG	AG
2272	GebäudeKlima Schweiz	Verein
2214	Parlamentarische Gruppe Fürsorgerische Zwangsmassnahmen	Parlamentarische Gruppe
2322	Transports Publics de la Région Lausannoise sa	AG
2285	Clientis Bank Aareland AG	AG
2366	Ulycs S.à r.l.	GmbH
2371	Clearwater Communication AG	AG
2301	eHealth Suisse	Staatlich
2387	Energieregion Bern-Solothurn	Verein
2493	Schweiz - China	Parlamentarische Freundschaftsgruppe
2499	Alpiq InTec Ticino SA	AG
2541	Prison Fellowship Schweiz	Verein
2480	Stiftung Simplon - Ecomuseum & Passwege	Stiftung
2519	Schweizerische Flüchtlingshilfe SFH	Verein
2490	Schweizerischer Feuerwehrverband (SFV)	Verein
2446	Verband Schweizerischer Zigarrenfabrikanten VSZ	Verein
2649	Gemeinde Savièse	Staatlich
2615	Gasser Bau AG	AG
2693	bonainvest AG	AG
2633	Hardegger Immobilien AG	AG
2686	Bracher und Partner Recht AG	AG
155	Groupe Mutuel Services SA	AG
389	Farner St. Gallen AG	AG
381	Gewerkschaft Unia	Verein
412	Ombudsstelle E-Commerce	Einfache Gesellschaft
440	Kantonaler Gewerbeverband Zürich KGV	Verein
444	Berufsmaturitätsschule Zürich BMZ	Staatlich
48	Schweizerische Bankiervereinigung (SwissBanking)	Verein
102	Stiftung Brot für alle	Stiftung
492	Wohlfahrtsfonds Sulzer	Stiftung
111	Etablissement d'assurance contre l'incendie et les éléments naturels du Canton de Vaud (ECA)	Oeffentlich-rechtlich
114	Association Relève PME	Verein
96	Zurzach Care AG	AG
507	Kaufmännischer Verband Baselland, Zweigniederlassung Schulen kvBL	Verein
525	Forum Velostationen Schweiz	Informelle Gruppe
558	Bouygues E&S InTec Management AG	AG
583	Stiftung Landschaftsschutz Schweiz	Stiftung
600	Medizinische Fakultät der Universität Bern	Staatlich
625	Rheumaliga Schweiz	Verein
639	Pro Natura Zürich	Verein
657	Die Mitte Schweiz	Verein
674	Schweizerische Energie-Stiftung	Stiftung
709	Ombudsstelle Krankenversicherung	Stiftung
733	Zugang für Alle, Schweizerische Stiftung zur behindertengerechten Technologienutzung	Stiftung
766	Stiftung für bürgerliche Politik	Stiftung
791	Donato Sabella Sàrl	GmbH
797	THOMAS KÄHR COMMUNICATIONS GMBH in Liquidation	GmbH
822	wohnbaugenossenschaften schweiz - verband der gemeinnützigen wohnbauträger	Verein
839	Interbus AG	AG
865	Netzwerk Schweizer Pärke	Verein
872	wellatwork.ch GmbH	GmbH
915	Swisspower AG	AG
939	Verband Walliser Gemeinden	Verein
953	FO-Fotorotar AG	AG
935	Schweizerische Vereinigung für internationales Recht	Verein
992	Schweizer Stiftung für Oberflächentechnik (SSO)	Stiftung
1018	PK-AETAS, BVG Sammelstiftung	Stiftung
1040	Fondation Home de Collombey-Muraz en liquidation	Stiftung
1049	Juvent SA	AG
1103	Stiftung Schloss Oberhofen	Stiftung
1113	Energieforum Schweiz	Verein
1101	Hermann und Margrit Rupf-Stiftung	Stiftung
1156	Bus CH - Verband schweizerischer Postautounternehmer	Verein
1183	Universität St. Gallen	Staatlich
1209	Tribunal cantonal Vaud	Staatlich
1191	Karl Ernst AG	AG
1247	Pensionskasse des Schweizerischen Bauernverbandes	Stiftung
1275	Hotel Consulting Group AG	AG
1298	BauernZeitung Nordwestschweiz, Bern und Freiburg AG, Bern	AG
1272	Radio Berner Oberland AG	AG
1332	Repartner Produktions AG	AG
1319	Société coopérative de fromagerie de Châtonnaye-Sédeilles-Rossens	Genossenschaft
1382	FONDATION JEAN MONNET POUR L'EUROPE	Stiftung
1364	Mountain Wilderness	Verein
1411	Thermografie Verband Schweiz	Verein
1430	Info-Entreaide Neuchâtel	Verein
1449	Fédération romande pour l'énergie (FRE)	Verein
1481	Elektrizitätswerk der Stadt Zürich	Oeffentlich-rechtlich
1510	Klipper GmbH	GmbH
1540	Notenstein La Roche Privatbank AG	AG
1544	Schwingklub Muotathal	Verein
1581	Entec AG in Liquidation	AG
1589	Opferhilfe beider Basel	Verein
1623	Lateinische Konsumfragen	Parlamentarische Gruppe
1652	Fondation Favre-Robert-Guyot-Bingguely	Stiftung
1665	Geriamobil	Einzelunternehmen
1701	Krebsliga beider Basel	Verein
1694	Gemeinde Zumikon	Staatlich
1731	Schweizerische Verkehrs-Stiftung (SVS)	Stiftung
1762	simmengroup holding ag	AG
1782	Wettbewerbskommission	Staatlich
1801	Schweizerisches Arbeiterhilfswerk SAH Freiburg	Verein
1824	Stiftung Historisches Erbe der SBB	Stiftung
1841	Verbindung der psychiatrisch-psychotherapeutisch tätigen Ärztinnen und Ärzte, FMPP	Verein
1871	Nebs Sektion Neuenburg	Verein
1903	Programm San Gottardo 2020	Staatlich
1917	Paul und Hulda Gantenbein Stiftung	Stiftung
1945	Seilbahn Weissenstein AG	AG
1975	Stadt- und Gewerbevereinigung Solothurn (SGSo)	Verein
1992	EWD Elektrizitätswerk Davos AG	AG
2029	Technische Betriebe Glarus Süd	Oeffentlich-rechtlich
2005	Verein Chance Wasserstadt	Verein
2060	Inländische Mission - Schweizerisches katholisches Solidaritätswerk	Verein
2097	Zunft zu Schmieden	Verein
2071	Creapole SA	AG
2089	Europäische Union EU	Staatlich
2128	Proviande Genossenschaft	Genossenschaft
2134	Pro Litteris	Genossenschaft
2191	Eidgenössisches Institut für Geistiges Eigentum	Oeffentlich-rechtlich
2247	Stiftung Museum und historisches Material der schweizerischen Luftwaffe	Stiftung
2254	Tripartite Kommission des Kantons St. Gallen	Ausserparlamentarische Kommission
2239	Stiftung Refdata Referenzdaten im schweizerischen Gesundheitswesen	Stiftung
2265	Agro-Treuhand Solothurn-Baselland	Verein
2286	Farner Consulting SA	AG
2291	SFIH - FSIB Holzfeuerungen Schweiz	Verein
2297	Schweizerischer Drummer- und Percussionisten-Wettbewerb	Verein
2302	Bistum Basel	AG
2312	GEDREL SA	AG
2412	Mittwoch-Gesellschaft Zug	Verein
2498	Provvida Madre	Stiftung
2505	Associazione Industrie Ticinesi	Verein
2512	Zentralbibliothek Zürich, öffentliche Stiftung	Oeffentlich-rechtlich
2434	Dental Consulting Michèle Graber	Einzelunternehmen
2531	Schweizerische Vereinigung der AOP-IGP	Verein
2600	Swiss Cancer Foundation	Stiftung
178	Patientenstelle Westschweiz	Verein
372	Egghölzli Verwaltungen AG in Liquidation	AG
390	SECONAIR GmbH	GmbH
383	Stadtärztlicher Dienst Zürich	Staatlich
265	Fussverkehr Schweiz	Verein
44	Schweizerischer Städteverband	Verein
100	THERAPLUS Stiftung für Therapiebegleitung in Liquidation	Stiftung
53	Erdgas Zürich AG	AG
493	AM Suisse	Verein
31	ANW Abbundcenter Nordwestschweiz AG	AG
117	Interkantonaler Rückversicherungsverband	Oeffentlich-rechtlich
423	Schweizeisches Institut für Unternehmerschulung im Gewerbe (SUI)	Genossenschaft
517	Schweizerische Volkspartei	Verein
542	Swiss eMobility	Verein
564	Neue Heimat Schweiz	Informelle Gruppe
578	Klinik Villa im Park AG	AG
604	Casafair Schweiz	Verein
612	Gesundheitscoaching	Informelle Gruppe
650	Microsoft Schweiz GmbH	GmbH
673	Coop-Gruppe Genossenschaft	Genossenschaft
691	Stiftung zur Förderung besonderer gemeinschaftlicher Aufgaben der sozialen Krankenversicherung	Stiftung
635	Association of European Parliamentarians with Africa AWEPA	Verein
740	Société d'Edition du Journal "Le Peuple Valaisan" société coopérative	Genossenschaft
746	CONCORDIA Schweizerische Kranken- und Unfallversicherung AG	AG
784	IG Erdgas	Verein
812	Haute école de travail social et de la santé, EESP	Staatlich
827	Internationale Bodensee Konferenz (IBK)	Staatlich
846	Fonds zugunsten des Personals der Brienz Rothorn Bahn AG in Liquidation	Stiftung
870	Jugendmusikschule Winterthur	Verein
894	Aktion Liberaler Aufbruch, ALA	Verein
903	Paritätische Landeskommission Metallunion	Verein
923	IG Biomedizinische Forschung und Innovation	Einfache Gesellschaft
949	Mengis Medien AG	AG
979	Stiftung Fairmed	Stiftung
1001	Chlausgesellschaft Rothenburg	Verein
1025	Schweizerische Management Gesellschaft	Verein
1051	AEW Energie AG	AG
1071	Verband der Arbeitgeber Region Bern (VAB)	Verein
1122	Alternative Bank Schweiz AG	AG
1115	Riva Baumanagement AG	AG
1131	Verkehrshaus der Schweiz (VHS)	Verein
1138	Genossenschaft Baseltor	Genossenschaft
1216	Le Conservatoire de Musique de Genève	Stiftung
1229	Einigungsstelle	Staatlich
1225	Weiterbildungskurse Dübendorf (WBK)	Stiftung
1252	ecos AG	AG
1307	Bio Suisse, Vereinigung Schweizer Biolandbau-Organisationen	Verein
1329	esolva ag	AG
1318	Mobimo AG	AG
1379	Animalfree Research	Stiftung
1387	Energieforum Nordwestschweiz	Verein
1393	digitalSTROM.org Association in Liquidation	Verein
1419	Banque Cantonale du Valais	Oeffentlich-rechtlich
1434	Swiss Turkish Business Council (STBC)	Verein
1455	Schweiz - Rumänien	Parlamentarische Freundschaftsgruppe
1479	Reflexionsgruppe Erneuerbare Energien des Bundesamts für Energie	Informelle Gruppe
1508	Baugenossenschaft mehr als wohnen	Genossenschaft
1527	L'ENCLOS DE VALERE SA	AG
1549	World Energy Council	Verein
1561	Fondation St-Joseph	Stiftung
1573	Français en Jeu	Verein
1628	MUTUELLE VAUDOISE, Société Coopérative	Genossenschaft
1654	Commune de Jouxtens-Mézery	Staatlich
1666	Zentrum für Recht und Nachhaltigkeit CLS der Universität Luzern	Staatlich
1686	Schweizerische Stiftung für Gefässmedizin	Stiftung
1711	Trägerstiftung Kultur- und Kongresszentrum am See	Stiftung
1727	Jungfreisinnige Kanton Neuchâtel	Verein
1754	Global Blue SA	AG
1787	Schulkommission Breitenrain-Lorraine	Staatlich
1808	Naturpark Beverin	Verein
1833	Bundesamt für Umwelt (BAFU)	Staatlich
1864	Stadtpolizei Zürich	Staatlich
1883	Bertschy & Stocker	KG
1911	Agrisano Prevos	Stiftung
1914	Förderverein energietal toggenburg	Verein
1950	MG Real Estate AG	AG
1966	CORESTATE Capital AG	AG
2018	Patronale Stiftung der Weseta Textil AG	Stiftung
2048	Hans Eberle Stiftung	Stiftung
2056	Leucom Stafag AG	AG
2078	Vereinigung Schweizerischer Assetmanagement- und Vermögensverwaltungsbanken VAV	Verein
2082	Eniwa Wasser AG	AG
2122	scienceindustries	Verein
2168	Schloss Lenzburg	Stiftung
2172	Barmelweid Gruppe AG	AG
2190	Fachvereinigung der Finanzkontrollen	Verein
2246	Stiftung Flying Dream	Stiftung
2232	Seminar St. Beat	Verein
2212	Schweizer Allianz gegen die Internet-Piraterie	Informelle Gruppe
2266	Dorfzentrum Deitingen AG	AG
2328	FONDATION DE BEAULIEU en liquidation	Stiftung
2336	Association du Festival du Film des Diablerets	Verein
2398	Josef Müller-Stiftung	Stiftung
2351	Arbeitsgemeinschaft für Wirtschaft und Gesellschaft (AWG)	Verein
2357	DE VIN ZINZIN SA	AG
2393	Genossenschaft Regiomech	Genossenschaft
2538	VAP Verband Schweizerischer Anschlussgleise- und Privatgüterwagenbesitzer	Verein
2540	Verein Risiko & Sicherheit (VRS)	Verein
2429	Burgergemeinde Bern, Berner Generationshaus	Staatlich
2486	Schulen nach Bern (SnB)	Verein
2595	Evangelische Mittelschule Schiers	Verein
2688	Casalife Services AG	AG
2613	L. Gasser & Co AG	AG
2669	kidswest.ch	Verein
2677	Medien und Kommerzielle Kommunikation	Parlamentarische Gruppe
2684	Sozialdemokratische Partei Sektion Roggwil	Verein
225	Swiss Economic Forum GmbH	GmbH
374	L'Evénement syndical SA en liquidation	AG
379	Wohnbaugenossenschaft "Schönehof" Frauenfeld in Liquidation	Genossenschaft
401	Feriengemeinschaft al Forno Pila-Intragna	Verein
456	Skyline Invest SA	AG
463	Krebsliga Schweiz	Verein
475	Schreinermeister-Verband Baselland	Verein
487	Stiftung zur Förderung der Eigenverantwortung in der beruflichen Vorsorge	Stiftung
503	Emmi-Vorsorgestiftung	Stiftung
32	Autobus AG Liestal	AG
424	Institut für Sozial- und Präventivmedizin, IUMSP	Staatlich
524	Aktive Mobilität	Parlamentarische Gruppe
555	Energie Wasser Bern	Oeffentlich-rechtlich
573	Zeitungshaus AG	AG
594	Securitas AG Schweizerische Bewachungsgesellschaft	AG
617	Trybol AG	AG
632	Aspasie	Verein
658	Farner Consulting AG	AG
676	Hotel & Gastro Union	Verein
689	tarifsuisse ag	AG
727	Jetra AG in Liquidation	AG
760	Fondation Hôpital Jules Daler	Stiftung
767	Fernwärme Siggenthal AG	AG
792	Coopérative de conciergerie "Résidences Bon Accueil" en liquidation	Genossenschaft
790	LCD Gestion, Raymond Clottu	Einzelunternehmen
834	Verband Schweiz. Kartenverleger & Grossisten	Verein
857	Nie wieder Atomkraftwerke	Verein
888	OK Eidgenössisches Volksmusikfest Aarau 2015	Informelle Gruppe
907	Paritätische Kommission für Metallbau des Kantons Tessin	Verein
930	Touring Club Schweiz, Sektion beider Basel	Verein
954	fo education gmbh	GmbH
972	Stiftung zur Förderung der Hochschule Luzern - Technik & Architektur	Stiftung
991	Pro Senectute Kanton Luzern	Stiftung
1014	ASIA-SWISS Investment AG	AG
1046	Vereinigung Pro Wasserschloss	Verein
1070	Volkswirtschaftliche Gesellschaft des Kantons Bern	Verein
1078	Stiftungsforum Schweiz	Verein
1060	Visana Services AG	AG
1153	PIKOM - Parteiunabhängiges Informationskommitee	Verein
1171	Elettricità Industriale SA	AG
1198	Institut für Umwelt und Natürliche Ressourcen (IUNR)	Oeffentlich-rechtlich
1202	Sozialdemokratische Partei Graubünden	Verein
1246	Orascom Development Holding AG	AG
1278	Auslandschweizer	Parlamentarische Gruppe
1297	Agrosolution AG	AG
1310	Swiss Convenience Food Association (SCFA)	Verein
1293	Agrarallianz	Verein
1377	Transparency International Schweiz	Verein
1385	Association des Amis de la Cité	Verein
1234	Pensionskasse der Stadt Dübendorf	Stiftung
1412	Trägerverein Energiestadt	Verein
1440	KMU Frauen Schweiz	Informelle Gruppe
1464	AKONIS AG	AG
1492	Jungfreisinnige Kanton Waadt	Verein
1500	Ausschuss Campagning Schweizerischer Versicherungsverband (SVV)	Informelle Gruppe
1535	Stiftung Konzertsaal und Hotel in Braunwald/Glarus-Süd	Stiftung
1553	Aufsichtskommisson für den Ausgleichsfonds der Arbeitslosenversicherung	Staatlich
1592	Nexus Telecom AG (D)	AG
1600	FDP Die Liberalen Appenzell-Ausserrhoden	Verein
1621	Domaine Jean-René Germanier SA	AG
1648	Bloc 30 S.A., en liquidation	AG
1675	CSS Versicherung AG	AG
1688	Clé de Berne GmbH	GmbH
1714	Reserve-Stiftung Kinderhilfe Bethlehem	Stiftung
1733	Verein Schweizer Gastromesse für einheimische Spezialitäten, ASGT	Verein
1760	Zürcher Kantonalbank	Oeffentlich-rechtlich
1783	Rüstungskommission	Ausserparlamentarische Kommission
1800	Parlamentarische Gruppe für Behindertenfragen handicapées	Parlamentarische Gruppe
1826	ALDI SUISSE AG	AG
1848	Halter AG	AG
1892	EspaceSuisse - Verband für Raumplanung	Verein
1907	Association suisse pour la recherche horlogère ASRH	Verein
1942	AEK Energie AG	AG
1956	Phitora AG	AG
1986	ProWOZ Förderverein	Verein
1967	Swiss Authentication Research and Development AG	AG
2042	Romasita AG	AG
2052	Galledia Fachmedien Frauenfeld AG	AG
2096	Organisation Internationale of the Francophonie (OIF)	Staatlich
2099	PRO WOLLE SCHWEIZ	Verein
2087	DCAF - le Centre pour la gouvernance du secteur de la sécurité - Genève	Stiftung
2148	Oliver Wymann Group	AG
2136	SUISA, Genossenschaft der Urheber und Verleger von Musik	Genossenschaft
2189	EURORAI - European Organisation of Regional External Public Finance Audit Institutions	Informelle Gruppe
2197	VSM Verband Musikschulen Schweiz	Verein
2234	Sportstiftung Thurgau	Stiftung
2213	Berner Kulturagenda BKA	Verein
2264	Marie-Louise Baumann MLB Communications	Einzelunternehmen
2362	Mouvement Citoyens Genevois	Verein
2365	Fondation lausannoise pour le rayonnement de la BD	Stiftung
2372	Premium World AG	AG
2402	Stiftung FZZ zur Förderung des ZeitZentrums in Grenchen	Stiftung
2316	Association des Amis du Cinéma d'Ajoie	Verein
2454	Sozialdemokratische Partei Stadt Bern	Verein
2461	Central European University, CEU	Stiftung
2471	DANET Datennetzgesellschaft Oberwallis AG	AG
2476	Schweizerischer Notarenverband (SNV)	Verein
2483	Verein eJustice.CH	Verein
2438	IMMO-ART Beat Spahni	Einzelunternehmen
2445	Verband der Tankstellenshop-Betreiber der Schweiz VTSS	Verein
2646	Baulink AG	AG
2659	proTell Gesellschaft für ein freiheitliches Waffenrecht	Verein
2621	Gebr. Gasser Holding AG	AG
227	Stiftung Krebsregister Aargau	Stiftung
342	CURAVIVA - Verband Heime und Institutionen Schweiz	Verein
391	Hirslanden AG	AG
262	Association des Amis de la Fondation AGIR	Verein
427	Schweizerische Gesundheitsstiftung Radix	Stiftung
468	Wirtschaftskammer Baselland	Verein
476	Schweizer Musikrat	Verein
486	SCRC Holding AG in Liquidation	AG
57	Pflege- und Adoptivkinder Schweiz	Verein
113	fenaco Genossenschaft	Genossenschaft
33	Konferenz der Kantonsregierungen	Staatlich
421	proparis Vorsorge-Stiftung Gewerbe Schweiz	Stiftung
515	Hauseigentümerverein Gelterkinden und Umgebung	Verein
546	CleanTech Capital GmbH in Liquidation	GmbH
551	The Swiss Leading Hospitals	Verein
586	Fondation du foyer d'accueil Le Christ-Roi	Stiftung
605	Gastgeber-Akademie Schweiz	Informelle Gruppe
629	Selbsthilfe Schweiz	Stiftung
665	Gesundheitsförderung Schweiz	Stiftung
666	European Federation of Pharmaceutical Industries and Associations (EFPIA)	AG
702	media f imprimerie SA	AG
726	Fédération des Entreprises Romandes-Valais	Verein
748	Pro Infirmis	Verein
732	Zeix AG	AG
801	Schweizer Armee	Staatlich
793	Schweizerischer Orientierungslauf-Verband (SOLV)	Verein
833	Vereinigung des Schweizerischen Blumengrosshandels	Verein
859	Bank Cler AG	AG
880	Restoroute de la Gruyère S.A.	AG
904	Paritätische Landeskommission Carrosseriegewerbe	Verein
926	Schweizerischer Seniorenrat	Verein
944	Komitee für eine Schweiz ohne Masern	Informelle Gruppe
969	Verband für Effiziente Energie Erzeugung (V3E)	Verein
987	Universität Bern	Staatlich
1016	green.ch AG	AG
1027	Patronatskomitee Aargauer Schützenfest 2017	Verein
1061	frauenaargau	Verein
1104	Club Politique de Berne	Verein
1120	Auto SA Ticino	AG
1143	IG Motorrad	Verein
1147	Fontavis AG	AG
1187	Fondation La Tène	Stiftung
1189	Procap Schweiz	Verein
1228	FRT Rechtsanwälte	Einzelunternehmen
1257	Radio 3 I Societa Anonima	AG
1265	Fondazione Svizzera Madagascar (F.S.M.)	Stiftung
1301	IP Suisse	Verein
1324	Immobilien Invest Holding AG	AG
1344	Schweizer Paraplegiker-Stiftung	Stiftung
1321	LO immeubles SA	AG
1233	Bäumle Messungen und Beratungen	Einzelunternehmen
1396	Verein Energieallianz	Verein
1339	Schützengesellschaft der Stadt Luzern	Verein
1431	objectif:ne	Verein
1445	Sinergy Commerce SA	AG
1477	Association de l'ancien Hôpital de Gravelone des communes des districts de Sion-Hérens-Conthey	Verein
1505	Erneuerbare Energien	Parlamentarische Gruppe
1520	ZH-Medien GmbH	GmbH
1551	Interessengemeinschaft Energieintensive Branchen	Verein
1570	Aargau Verkehr AG (AVA)	AG
1598	a + b Liegenschaften AG	AG
1603	Fondation Rétropomme	Stiftung
1636	Le Sion Festival	Verein
1660	Westschweizer Verband Komplementärmedizin	Verein
1682	Hess Advisum GmbH	GmbH
1710	Schweizerische Alzheimervereinigung beider Basel	Verein
1725	Fondation St-Raphaël	Stiftung
1748	BSH Bosch und Siemens Hausgeräte GmbH	GmbH
1766	SR Technics Switzerland AG	AG
1789	VALIDITAS Fachverband Schweizer Finanzdienstleister	Verein
1788	Swiss China Investment Platform Association (SCIPA)	Verein
1830	BDP Schweiz	Verein
1863	Schweizerische Radio- und Fernsehgesellschaft	Verein
1881	Büro Cortesi AG	AG
1875	zooschweiz - Verein wissenschaftlich geleiteter zoologischer Gärten der Schweiz	Verein
1930	Masterplan Cleantech	Staatlich
1949	MG Real Estate (Spain) AG	AG
1964	Swiss Link Services AG	AG
1961	FlexGas GmbH	GmbH
2032	Aleco AG in Liquidation	AG
2036	BvR Industrie AG	AG
2077	Eniwa Holding AG	AG
2067	Schweizer Agrarmedien AG	AG
2085	Rapp Gruppe AG	AG
2144	Fournier et Cie SA	AG
2130	Fondation pour la jeunesse suisse Général Guisan	Stiftung
2171	Verein Barmelweid	Verein
2141	Kraftwerke Gougra AG	AG
2224	Genossenschaft Einwohner und Freunde des Weisstannentals in Liquidation	Genossenschaft
2202	Westschweizer Regierungskonferenz (WRK)	Verein
2258	Galledia Event AG	AG
2280	Le Collectif de soutien aux Sans-papiers de la Côte	Informelle Gruppe
2283	Kantonsspital Baden AG	AG
2339	Lausanne Tourisme	Verein
2374	Hürlimann-Wyss Stiftung	Stiftung
2356	GALAAD ASSET MANAGEMENT SA	AG
2453	Verein "Mehr Transparenz"	Verein
2394	Alterszentrum Wengistein	Stiftung
2468	Centre international de formation à l'enseignement des droits de l'homme et de la paix	Stiftung
2507	Verband für die Schweizer Luftfahrt	Verein
2479	Fondation NLZ - Centre national de performance Brigue-Glis	Stiftung
2546	Inclusion Handicap	Verein
2548	Friedensförderung	Parlamentarische Gruppe
2451	Pro Natura Bern	Verein
2651	Penalty d'Or	Verein
2616	Fondazione Lucia Solari	Stiftung
2623	Fédération Internationale de Football Association (FIFA)	Verein
2638	Skiclub Klosters	Verein
2705	CoRelation GmbH	GmbH
2771	Spross Muldenservice AG	AG
2817	Gemeinde Wettingen	Staatlich
228	Freunde des Zentrums für Demokratie (ZDA)	Verein
355	Gemeinnützige Institutionen Basel	Verein
364	Regio Basiliensis	Verein
384	Dachverband Drogenabstinenz Schweiz	Verein
438	FDP Die Liberalen Winterthur	Verein
268	Fiduconsult SA	AG
270	La Liberté médias SA	AG
103	Musikkollegium Winterthur	Verein
59	Basler Kantonalbank	Oeffentlich-rechtlich
91	STIFTUNG WILDSTATION LANDSHUT (SWSL)	Stiftung
368	Parlamentarische Gruppe Basel	Parlamentarische Gruppe
527	Forum Bikesharing Schweiz	Informelle Gruppe
519	Schweizerische Volkspartei Baselland	Verein
538	WOHNEN SCHWEIZ - Verband der Baugenossenschaften	Genossenschaft
581	Grüne Partei der Schweiz (Grüne)	Verein
614	IG Seltene Krankheiten	Informelle Gruppe
616	diabetesschweiz	Verein
669	Schweizer Tourismus-Verband	Verein
661	EnergieSchweiz	Staatlich
706	JPF Construction SA	AG
728	Stiftung Klimarappen	Stiftung
770	AMAG Import AG	AG
794	Jungsozialist*innen Schweiz	Verein
811	Landgasthof Sonne, Lukas Hoffmann-Fässler	Einzelunternehmen
824	Vorsorgestiftung Sparen 3 der Appenzeller Kantonalbank	Stiftung
842	MTD-Immobilien AG in Liquidation	AG
867	Bus alpin	Verein
895	Fondazione CASA ASTRA	Stiftung
911	IndustriAll European Trade Union	Verein
928	Zentrale Arbeitsmarkt-Kontrolle, ZAK	Verein
960	Kursaal-Casino AG Luzern	AG
977	AG Haus der Wirtschaft	AG
1009	Nuklearforum Schweiz	Verein
1020	BaselArea	Verein
1037	Arbeiterstrandbad Tennwil	Stiftung
1063	Public Eye	Verein
1119	Auto AG Rothenburg	AG
1146	Kunz Schmid Rechtsanwälte und Notare AG	AG
1160	Engadiner Kraftwerke AG	AG
1165	Stiftung Pro Kloster St. Johann in Müstair	Stiftung
1190	Procap La Chaux-de-Fonds	Verein
1204	Società Storica Val Poschiavo	Verein
1263	Fondazione Collegio Papio	Stiftung
1281	Grande Dixence SA	AG
1302	SWISSCOFEL	Verein
1330	Elbe Beteiligungs AG in Liquidation	AG
1348	Schweizer Paraplegiker-Vereinigung SPV	Verein
1354	Mieterinnen- und Mieterverband Deutschschweiz	Verein
1386	arv Baustoffrecycling Schweiz	Verein
1407	S.A.F.E. Schweizerische Agentur für Energieeffizienz	Verein
1415	Thermische Netze Schweiz (TNS)	Verein
1437	FDP Die Liberalen Bucheggberg-Lebern	Verein
1447	Verband der Betreiber Schweizerischer Abfallverwertungsanlagen (VBSA)	Verein
1478	HMK Kuhn AG	AG
1509	archi-NETZ	Einfache Gesellschaft
1528	Stiftung IT-Berufsbildung Schweiz	Stiftung
1557	ecoinvent Association	Verein
1591	Nexus Telecom AG in Liquidation	AG
1613	Jungfreisinnige Schweiz	Verein
1633	DOMAINES MAISON GILLIARD SA	AG
1659	Association des Amis du peintre André Gasser	Verein
1679	Stiftung diheiplus in Neuhausen am Rheinfall	Stiftung
1672	Beratungsstelle für Sans-Papiers Luzern und Innerschweiz	Verein
1718	Fondation Mère Sofia	Stiftung
1735	ODEC	Verein
1761	ePower - ICT für die Schweiz	Parlamentarische Gruppe
1777	Verein Getränkekarton-Recycling Schweiz	Verein
1806	Plankis Stiftung	Stiftung
1821	Alpkäserei Urnerboden AG	AG
1850	Huawei Technologies Switzerland AG	AG
1877	Aktiengesellschaft Matterhorn Gotthard Bahn	AG
1906	AgroCleanTech AG in Liquidation	AG
1936	Kanton Uri	Staatlich
1957	IG Initiative zum Schutz der Privatsphäre	Informelle Gruppe
1987	Unionsdruckerei Bern AG	AG
2020	Bergbevölkerung	Parlamentarische Gruppe
2045	Weseta Kraftwerke AG	AG
2007	Kloster Mariastein	Verein
2110	Schroder Investment Management (Switzerland) AG	AG
2068	Schweizer Milchproduzenten SMP Genossenschaft	Genossenschaft
2142	Helvetia Holding AG	AG
2147	Walliser Gewerbeverband (WGV)	Verein
2155	Raiffeisenbank Mittelthurgau Genossenschaft	Genossenschaft
2158	Union suisse des professionnels de l'immobilier	Verein
2226	Christ+Politik	Parlamentarische Gruppe
2201	Schweizer Hotelier-Verein (SHV)	Verein
2211	Audiovision Schweiz	Verein
2218	LAVEBA Genossenschaft	Genossenschaft
2284	Clientis AG	AG
2397	Dübi-Müller-Stiftung	Stiftung
2342	Ville de Lausanne	Staatlich
2350	Pflegekinder-Aktion Zentralschweiz	Verein
2310	Maison du sport international S.A.	AG
2456	Stiftung Domino	Stiftung
2463	Schweizerisches Bundesgericht	Staatlich
2418	Berner Reha Zentrum AG	AG
2511	Les Genevoises PLR	Verein
2433	Business Networking Roundtable	Verein
2439	Senarclens, Leu + Partner AG	AG
2536	Schweizerischen Ausbildungsveranstalter für Gefahrgutbeauftragte (VAG)	Verein
2605	Société des Vieux-Grenadiers	Verein
2662	Schweizerische Bewegung gegen die Islamisierung	Verein
2624	Wenger Vieli AG	AG
2681	Genossenschaft Schweizerisches Kompetenzzentrum Fischerei (SKF)	Genossenschaft
2706	Fondation village lacustre de Gletterens	Stiftung
2772	Platanus Holding AG	AG
2782	Initiativ-Genossenschaft Lindenplatz Altstetten (IGLA)	Genossenschaft
2735	UBS Switzerland AG	AG
2800	Schweizer Alpen-Club SAC	Verein
2810	Verein für soziale Gerechtigkeit	Verein
205	Stiftung Forschung 3R (Vermindern, Verbessern und Vermeiden von Tierversuchen) in Liquidation	Stiftung
388	Institut für Sicherheitsanalysen und strategisches Networking - Stiftung (ISSN)	Stiftung
380	Zivag Verwaltungen AG	AG
385	Kanton St. Gallen	Staatlich
443	RWU Regionalplanung Winterthur und Umgebung	Staatlich
45	Schweizerische Arbeitsgemeinschaft für die Berggebiete (SAB)	Verein
51	EBL (Genossenschaft Elektra Baselland)	Genossenschaft
55	Stiftung Pestalozzianum	Stiftung
499	Auto Gewerbe Verband Schweiz (AGVS)	Verein
29	futureHospital Institute AG in Liquidation	AG
95	Aargauische Kantonalbank	Oeffentlich-rechtlich
470	Stiftung Tierpark Weihermätteli	Stiftung
509	INTRAS Assurance SA	AG
549	Hochschule für Technik Rapperswil (HSR), Fachhochschule Ostschweiz	Staatlich
580	VCS Verkehrs-Club der Schweiz	Verein
599	GastroSuisse	Verein
608	Fondation Suisse Bellevue	Stiftung
621	Groupe Mutuel Assurances GMA SA	AG
640	Familienpolitik	Parlamentarische Gruppe
659	Gleichstellungskommission des Kantons Zürich	Ausserparlamentarische Kommission
698	Rotary Club Ägeri-Menzingen	Verein
724	Bureau Neuchâtelois des Métiers du Bâtiment BNMB	Verein
754	Kirchgemeinde Lungern	Oeffentlich-rechtlich
774	International Center for Counter-Terrorism ICT	Einzelunternehmen
788	OCM Dentaire S.A.	AG
816	OSTAG Ingenieure AG	AG
836	Brienz Rothorn Bahn AG	AG
853	STIFTUNG EICHBERG	Stiftung
876	Stiftung generationplus	Stiftung
914	Ausgleichskasse AHV Kanton Tessin	Staatlich
918	Aktion für eine vernünftige Energiepolitik AVES Thurgau	Verein
919	Raiffeisen Kantonalverband Zug	Verein
934	Fonds de prévoyance en faveur du personnel de la Fondation Les Buissonnets	Stiftung
994	Schweizerische Alzheimervereinigung Luzern	Verein
1035	Société des Officiers du Valais romand (SOVR)	Verein
1053	Grünes Kreuz Schweiz	Stiftung
1057	Visana AG	AG
1098	Stadt Zürich	Staatlich
1137	cR Kommunikation AG	AG
1170	Genossenschaft VSG ASIG	Genossenschaft
1197	Fondazione Internazionale per la Scultura	Stiftung
1142	Gewerbe- und Industrieverein Däniken, Gretzenbach und Umgebung (Gwärb Niederamt)	Verein
1241	Amestha AG	AG
1276	Dauf SA	AG
1253	Lucendro SA	AG
1273	Genossenschaft Dr. Frano Della Casa	Genossenschaft
1313	Wascosa Asset AG	AG
1352	ACTARES - AktionärInnen für nachhaltiges Wirtschaften	Verein
1373	Pro Velo Genf	Verein
1398	Germanwatch e.V.	Verein
1404	LonMark Schweiz, Genossenschaft in Liquidation	Genossenschaft
1435	Ovra electrica Ferrera SA, OEFT	AG
1448	Caritas Valais	Verein
1474	Radio Rhône SA	AG
1503	LobbyTrend Suisse GmbH	GmbH
1521	Bucher + Suter AG	AG
1547	Entwicklung Schweiz	Verein
1565	Schwyzer Schneesportverband (SZSV)	Verein
1593	Noser Engineering AG	AG
1614	Doviva SA	AG
1635	Fondation Louis Moret	Stiftung
1658	E-CHANGER	Verein
1678	Weidmüller Schweiz AG	AG
1709	Förderverein ICT-Scouts & Campus	Verein
1724	Förderverein Ecomuseum Simplon	Verein
1747	NÜSSLI Adunic AG	AG
1773	Schweizer Motoren-Veteranen-Club (SMVC)	Verein
1792	Clavel SA en liquidation	AG
1817	Netzwerk Schweizerisches Arbeiterhilfswerk, Nationales Sekretariat	Verein
1842	Schweizerische Gesellschaft für Kinder- und Jugendpsychiatrie und -Psychotherapie, SGKJPP	Verein
1858	Kultur	Parlamentarische Gruppe
1886	Die Kilbi im Freiburgerland	Stiftung
1922	Kantonale Jagdkommission St. Gallen	Ausserparlamentarische Kommission
1943	Parking AG Solothurn	AG
1963	House of Policy (Switzerland) AG	AG
1952	Stiftung Blumenhaus	Stiftung
1998	Schweizer Berghilfe	Stiftung
2033	Aqua-Terra Holding AG	AG
2037	Condominium Glarus AG	AG
2095	Organisation für wirtschaftliche Zusammenarbeit und Entwicklung	Staatlich
2115	Credit Suisse Funds AG	AG
2101	Amiguet Antoine, Bettschart Sébastien & Eberhard Stéfan	Einfache Gesellschaft
2108	MV Invest AG	AG
2184	Les 4 Vallées SA	AG
2153	Carnegie-Stiftung für Lebensretter (Schweiz)	Stiftung
2140	Stiftung Naturzentrum Glarnerland	Stiftung
2194	Eidgenössische Kommission für Konsumentenfragen	Ausserparlamentarische Kommission
2252	Stadt Schaffhausen	Staatlich
2236	Swiss Cancer Screening	Verein
2242	HCI Solutions AG	AG
2282	Reuss Private Group AG	AG
2338	Fondation HBM Emma KAMMACHER	Oeffentlich-rechtlich
2344	FMV SA	AG
2354	Schweizerischer Verband der Versicherten	Verein
2386	Verein für menschenfreundlichere Fahrzeuge	Verein
2455	Grünliberale Partei Bezirk Brugg	Verein
2500	Verein Holzenergie Schweiz	Verein
2472	Coopérative du Comte-Géraud	Genossenschaft
2428	Schweiz - Israel	Parlamentarische Freundschaftsgruppe
2485	Dr. Schenker Kommunikationszentrum für Wirtschaft und Politik AG	AG
2530	Interessengemeinschaft Mitgliederpresse	Informelle Gruppe
2448	Trägerverein Velo-Initiative	Verein
2609	Soccorso Svizzero d'Inverno	Verein
2666	Fussverkehr Kanton Bern (FVBE)	Verein
2676	Fanpolitik in der Schweiz	Parlamentarische Gruppe
2641	Schweizerische Volkspartei Graubünden	Verein
157	Swiss Olympic Association	Verein
361	Vereinigung für eine starke Region Nordwestschweiz	Verein
382	educationsuisse	Verein
416	femdat.ch	Verein
442	Aktion für vernünftige Energiepolitik AVES, Sektion Winterthur	Verein
465	Gesundheitspolitik der Bundesversammlung	Parlamentarische Gruppe
453	FDP.Die Liberalen Schweiz	Verein
482	BVK Personalvorsorge des Kantons Zürich	Stiftung
107	Caisse de pensions ECA-RP	Stiftung
367	Bürgergemeinderat der Stadt Basel	Staatlich
431	Swisstasting Sàrl	GmbH
477	Hauseigentümerverband Schweiz	Verein
533	SIB Institut Suisse de Bioinformatique	Stiftung
537	Sozialversicherungsanstalt des Kantons Zürich SVA	Oeffentlich-rechtlich
568	Concret AG	AG
579	Association romande et tessinoise des institutions d'action sociale	Verein
607	GENOSSENSCHAFT AMBASSADOR SWISS HOTELS	Genossenschaft
631	aphasie suisse	Verein
613	Bundesamt für Gesundheit (BAG)	Staatlich
671	Eidgenössische Hochschule für Sport EHSM	Staatlich
692	Medidata AG	AG
700	Schweizerische Mobiliar Genossenschaft	Genossenschaft
734	Pensionskasse der Basler Kantonalbank	Stiftung
772	FaH Consulting Hansjörg Fasnacht	Einzelunternehmen
795	SICPA Security Solutions SA	AG
785	Interessengemeinschaft Agrarstandort Schweiz (IGAS)	Verein
818	Ostschweizer BVG- und Stiftungsaufsicht	Oeffentlich-rechtlich
844	Spital STS AG	AG
856	IWB Industrielle Werke Basel	Oeffentlich-rechtlich
881	HFR Freiburger Spital	Oeffentlich-rechtlich
916	Bündnis Freiheitliches Gesundheitswesen	Verein
932	Tripartite Kommission RAV BL	Staatlich
957	Kantonsspital Nidwalden	Oeffentlich-rechtlich
976	Cube Media AG	AG
1002	Alpenclub Gerliswil	Verein
1029	Verein Freunde Luzerns	Verein
1052	Société des Forces Électriques de La Goule SA	AG
1102	Stiftung Sonderschulheim Mätteli Münchenbuchsee	Stiftung
1107	Förderverein Waldstadt Bremer	Verein
1124	ADEV Energiegenossenschaft	Genossenschaft
1155	SRG Aargau Solothurn	Verein
1172	Schweizerischer Weinbauernverband	Verein
1199	IBC Energie Wasser Chur (IBC)	Oeffentlich-rechtlich
1220	DTC Dynamic Test Center AG	AG
1205	Hoppler Tiefbohrungen GmbH	GmbH
1277	Unione Farmaceutica Distribuzione SA	AG
1299	Schweizerischer Getreideproduzentenverband SGPV-FSPC	Verein
1309	Prométerre	Verein
1331	Lagobianco SA	AG
1317	Mobimo Management AG	AG
1378	Paradoxes Communication, François Cherix	Einzelunternehmen
1388	Department of Management, Technology and Economics (D-MTEC) der ETH Zürich	Staatlich
1338	Glarner Kantonal-Schützenverein	Verein
1424	BBV Treuhand AG in Liquidation	AG
1439	LIPS Lucerne Initiative for Peace and Security	Verein
1462	Ingenieurbüro dipl. Ing. ETH/SIA H. Scheiwiller AG	AG
1497	Schweizer Reisekasse (Reka) Genossenschaft	Genossenschaft
1514	natürli zürioberland ag	AG
1536	MAB Möbel AG	AG
1556	Uli Lippuner AG	AG
1576	VPOD Sektion Aargau/Solothurn	Verein
1610	Niederhornbahn AG	AG
1629	VAUDOISE GENERALE, Compagnie d'Assurances SA	AG
1650	Société Immobilière Polyexpo S.A., en liquidation	AG
1663	FONDATION POUR L'ANIMATION SOCIOCULTURELLE LAUSANNOISE	Stiftung
1696	Bund der Public Relations Agenturen der Schweiz (BPRA)	Verein
1712	KINDERHILFE BETHLEHEM	Verein
1734	Car Tourisme Suisse	Informelle Gruppe
1753	gategroup Holding AG	AG
1776	Vale International SA	AG
1802	graubündenVIEH AG	AG
1823	STIFTUNG AVIFORUM ZUR FÖRDERUNG DER SCHWEIZER GEFLÜGELPRODUKTION UND -HALTUNG	Stiftung
1854	Komitee Ja zum Sanierungstunnel am Gotthard	Informelle Gruppe
1852	Hauptstadtregion Schweiz	Parlamentarische Gruppe
1905	Mennonite Central Committee Switzerland (MCC Switzerland)	Verein
1913	Animaltruck AG	AG
1962	Harwood International (Schweiz) AG	AG
1984	Sozialdemokratische Partei Bern-Nord	Verein
1954	Verband der Solothurnisch-Kantonalen Polizei-Beamten	Verein
2002	Romaner-Bruderschaft	Verein
2051	dfinvestors ag	AG
2090	Organisation für Sicherheit und Zusammenarbeit in Europa	Staatlich
2098	CO de La Madone des Centaures	Informelle Gruppe
2086	ZT Medien AG	AG
2145	Fondation Valais de Coeur	Stiftung
2185	Remontées Mécaniques de Grimentz - Zinal SA	AG
2137	Suissimage	Genossenschaft
2180	Kühne + Nagel International AG	AG
2198	Arkeo Praxis für Komplementärtherapie	Einzelunternehmen
2233	Allianz der Wirtschaft für eine massvolle Präventionspolitik	Verein
2240	Schweizerischer Verband für komplementärmedizinische Heilmittel	Verein
2326	TRIDEL SA	AG
2287	Franke Schweiz AG	AG
2340	Municipalité de Lausanne	Staatlich
2346	Familienausgleichskasse Kanton Luzern	Oeffentlich-rechtlich
2381	Konjunkturforschungsstelle der ETH Zürich	Staatlich
2405	XIO Group	AG
2496	Centro culturale L'INCONTRO	Verein
2467	Belalp Bahnen AG	AG
2474	Coopérative d'habitation de L'ERSE	Genossenschaft
2514	Fondation genevoise pour le dépistage du cancer	Stiftung
2437	Eidgenössische Akkreditierungskommission	Ausserparlamentarische Kommission
2597	Montalin BVG-Sammelstiftung	Stiftung
2644	SwissDRG AG	AG
1182	Fondation neuchâteloise et du Dr Humbert en faveur des personnes atteintes de maladies pulmonaires	Stiftung
1208	Union Schweiz von Soroptimist International	Verein
1237	maxon motor ag	AG
1248	Personalfürsorgestiftung der H. Knecht AG, Mühle, Leibstadt	Stiftung
1268	InfraWatt	Verein
1308	Fondation rurale de prévoyance	Stiftung
1343	Verband Schweizerischer Elektrizitätsunternehmen (VSE)	Verein
1320	LO holding Lausanne-Ouchy S.A.	AG
1333	Rotary District 1980	Informelle Gruppe
1390	Biomasse Suisse	Verein
1395	energie-cluster.ch	Verein
1427	Service Social International - Suisse	Stiftung
1444	RCR Publicité SA	AG
1466	Republik und Kanton Genf	Staatlich
1494	Kraus-Vogt Stiftung	Stiftung
1517	AFU Anlagen und Finanz AG in Liquidation	AG
1530	FROX AG	AG
1550	General Electric (Switzerland) GmbH	GmbH
1585	Riva Chur AG	AG
1609	Forum Flugplatz Dübendorf	Verein
1632	MAISON GILLIARD SA	AG
1640	Renate Hotz Communications AG	AG
1670	Centre social protestant Vaud	Stiftung
1697	LURIX Swiss AG in Liquidation	AG
1693	Schulpflege Zumikon	Staatlich
1736	Supported Employment Schweiz	Verein
1768	Flückiger Holz AG	AG
1796	"kagfreiland" (Konsumenten/-innen-Arbeitsgruppe für tier- und umweltfreundliche Nutztierhaltung)	Verein
1818	"Bibliomedia Schweiz - öffentliche Stiftung" (BMS)	Stiftung
1847	Google Switzerland GmbH	GmbH
1866	Swiss Football League	Verein
1887	Verein für eine Sammlung literarischer Studien (ACEL)	Verein
1928	Industrie- & Wirtschafts-Vereinigung Schaffhausen (IVS)	Verein
1944	Schindler Aufzüge AG	AG
1981	Vereinigung für Umweltrecht (VUR)	Verein
1991	Spaeter Chur AG	AG
2030	SN Energie AG	AG
2034	Beta Tex AG in Liquidation	AG
2038	Isinvest AG	AG
2112	Asset Management Association Switzerland	Verein
2084	Stadt Aarau	Staatlich
2103	Schweizer Berufsverband für Immobilienverbriefung, Coptis	Verein
2166	CENTRE DE POLITIQUE DE SECURITE - GENEVE	Stiftung
2173	Klinik Barmelweid AG	AG
2222	Christlicher Bauernbund St. Gallen	Verein
2228	Grünliberale Partei Kanton Luzern	Verein
2256	Schweizerischer Zivilschutzverband SZSV	Staatlich
2262	Rheintal Trust AG	AG
2278	Société coopérative d'habitation "Cité des Philosophes" Morges	Genossenschaft
2395	Bill de Vigier Stiftung	Stiftung
2368	Centre jurassien d'enseignement et de formation (CEJEF)	Staatlich
2345	Chambre de Commerce et d'Industrie France Suisse	Verein
2382	Swiss Radioworld AG	AG
2391	Regionalverkehr Bern-Solothurn AG	AG
2413	Verein BOSSARD SCHULE	Verein
2503	Sicherheitsfonds BVG	Stiftung
2425	Berner Waldbesitzer	Verein
2431	HelpinghandsUAE	Verein
2488	Verein Nische	Verein
2535	Holzkorporation Hegnau	Verein
2606	Société militaire de Genève	Verein
2692	bonainvest Holding AG	AG
2674	SwissTopSport	Verein
2639	Bündner Kunstverein	Verein
2761	KuRo Consulting AG	AG
2714	Schweizerische Volkspartei Kanton Bern	Verein
2725	LactoFama AG in Liq.	AG
2793	Rock/Pop im Bundeshaus	Parlamentarische Gruppe
2823	insieme Schweizerische Vereinigung der Elternvereine für Menschen mit einer geistigen Behinderung	Verein
2754	L'Association du Scoutisme Genevois	Verein
2890	Max Statnik et Co S.A. en liquidation	AG
2845	Coopérative Fribourgeoise de l'Habitat Familial	Genossenschaft
2854	Cremo S.A.	AG
2863	Ecologie libérale	Verein
2998	Verein Dampfzug Waldenburgerbahn (VDWB) - Patronatskommitee "Rettet das Waldeburgerli"	Verein
2942	TADERASS - Hilfe zur Selbsthilfe für TUAREG-Nomaden in Niger	Verein
2983	Gemeinde Bubendorf	Staatlich
2989	Basellandschaftlicher Natur- und Vogelschutzverband	Verein
1649	Zweckverband Wasserversorgung Val-de-Ruz und Neuenburger Berge (SIVAMO)	Staatlich
3097	Fondation Métropole	Stiftung
3017	Schweizerische Volkspartei Stadt Zürich	Verein
3129	Köppel Holding AG	AG
3109	Airboxx GmbH	GmbH
3183	Fédération genevoise pour la prévention de l'alcoolisme	Verein
3173	Vaud-Fribourg TV SA	AG
3190	Ecole Moser SA	AG
3228	ch Stiftung für eidgenössische Zusammenarbeit	Stiftung
3231	PROMEA Familienausgleichskasse	Verein
3261	Jüngere Schützenzunft Naters	Verein
2584	Heinrich Welti-Stiftung	Stiftung
2579	Kantonale Fachkommission für Gleichstellungsfragen, Kanton Bern	Ausserparlamentarische Kommission
3243	examen.ch AG	AG
2568	Interesta AG	AG
3262	Autoeinstellhalle Rathaus AG	AG
3313	CIVIVA Schweizerischer Zivildienstverband	Verein
3339	Stiftung YOU COUNT	Stiftung
3363	CGN Belle Epoque SA	AG
3377	Schweizerisches Institut für Aussenwirtschaft und Angewandte Wirtschaftsforschung, Universität St. Gallen	Staatlich
3406	Association romande pour la promotion de l'engagement civique	Verein
3428	OpenCrew GmbH	GmbH
3438	Schurter Holding AG	AG
3461	Musikgesellschaft Leuca	Verein
3493	IG Gampinen	Informelle Gruppe
3500	Suisse - Solidarité internationale	Parlamentarische Gruppe
3552	cf management gmbh in Liquidation	GmbH
3560	Verband der Gemeindepräsidenten des Kantons Zürich	Staatlich
1185	Fondation La Maison de La Coquille	Stiftung
1141	Michi Nussbaumer, Grafik und Typografie	Einzelunternehmen
1193	PRO SENECTUTE KANTON GRAUBÜNDEN - Für das Alter	Stiftung
1206	Fonds Landschaft Schweiz (FLS)	Staatlich
1227	Stiftung Ostschweizer Schiedsordnung	Stiftung
1304	Verband Schweizer Gemüseproduzenten VSGP	Verein
1341	Stiftung zur Förderung des Verkehrshauses der Schweiz	Stiftung
1349	Verkehrs-Club der Schweiz Sektion Waadt	Verein
1371	Forum Schweizer Selbstregulierungsorganisationen (Forum-SRO)	Verein
1375	Verein Schweizerisches Rotes Kreuz	Verein
1401	Verein cleverenergy	Verein
1420	Stiftung Freude herrscht	Stiftung
909	Schweizerischer Verband der Sozialversicherungs-Fachleute, SVS;	Verein
1472	GazEl SA	AG
1480	Bundesamt für Energie (BFE)	Staatlich
1518	QUO AG	AG
1539	Personalvorsorgestiftung der Möbelfabrik Betschart AG	Stiftung
1555	Energy Science Center ETHZ	Staatlich
1583	ACS Sektion Mitte	Verein
1605	Amstutz Abplanalp Birri AG	AG
1564	Kontrapunkt	Verein
1655	HévivA	Verein
1674	CSS Kranken-Versicherung AG	AG
1695	IAESTE Switzerland	Verein
1707	Schweizerischer Verband für Frauenrechte	Verein
1737	Verband internationaler Hotelfachschulen Luzern VIHL	Verein
1755	Hero AG	AG
1775	TEMENOS AG	AG
1799	IAESTE International	Verein
1816	Hilfs- und Solidaritätsfonds syndicom	Stiftung
1844	BVZ Holding AG	AG
1869	Fondation Suisse pour la Recherche en Microtechnique	Stiftung
1890	Handelskammer Schweiz- Armenien	Verein
1929	Tripartite Konferenz	Staatlich
1924	Genossenschaft Landwirtschaftliches Bau- und Architekturbüro LBA des Schweizerischen Bauernverbandes	Genossenschaft
1973	Wirtschafts - und währungspolitischer Arbeitskreis (WPA)	Parlamentarische Gruppe
1960	AKO Capital AG in Liquidation	AG
2021	Euromontana	Verein
2047	Monte Odina Suiza GmbH	GmbH
2061	Mehrwert Schweiz	Verein
2079	IBAarau Elektro AG	AG
2118	Greater Zurich Area AG	AG
2162	Stiftung Schwiizer hälfed Schwiizer	Stiftung
2149	Helvetia Schweizerische Versicherungsgesellschaft AG	AG
2154	Thurgauer Verband der Raiffeisenbanken	Verein
2177	Vereinigung Schweizerischer Unternehmen in Deutschland	Verein
2182	Luxoft (Switzerland) GmbH	GmbH
2273	Mieterinnen- und Mieterverband Morges	Verein
2275	PMS PARKING MANAGEMENT SERVICES SA	AG
2277	CIEL Electricité SA	AG
2329	Fondation pour l'art musical, lyrique et chorégraphique	Stiftung
2293	Helsana AG	AG
2347	WAS IV	Staatlich
2383	Goldbach Management AG	AG
2491	Kerngruppe Feuerwehr	Parlamentarische Gruppe
2459	Schweizer Nationalkomitee für FEANI (European Federation of National Engeneering Associations )	Verein
2469	Clinique médico-chirurgicale de Valère SA	AG
2475	Schweizerische Stiftung für das Stockalperschloss	Stiftung
2516	Verein Freunde des Museums Altes Zeughaus Solothurn	Verein
2436	Schweizerisches nationales FAO-Komitee	Ausserparlamentarische Kommission
2550	Les Ami-e-s de BD-FIL	Verein
2602	Aéroport International de Genève	Oeffentlich-rechtlich
2661	Fédération Romande Faîtière des Associations de Personnes Concernées par les problèmes liés à la Drogue (F.R.A.P.C.D)	Verein
2618	Il Mattino della Domenica	Einzelunternehmen
2629	Do it AG, Chur	AG
2685	Bracher und Partner AG	AG
2767	HEV Kanton Zürich	Verein
2718	Schweizerische Volkspartei Sektion Lyss-Busswil	Verein
2729	Bruggmühle Goldach AG	AG
2736	Schweizerische Volkspartei International	Verein
2751	Neue Europäische Bewegung Schweiz (Nebs) - Sektion Genf	Verein
2828	Kinder und Jugend	Parlamentarische Gruppe
2922	Demokratische Jurist_innen Schweiz	Verein
2846	Bulliard Immobilier SA	AG
2856	Tierschutz	Parlamentarische Gruppe
2915	Second@s Plus Schweiz	Verein
2936	Industrie- und Handelskammer St. Gallen-Appenzell	Verein
2944	Beirat Zukunft Finanzplatz	Ausserparlamentarische Kommission
2955	Ro­bert-Grimm-Ge­sell­schaft	Verein
3037	Verein für Abfallbeseitigung Rüthi	Verein
3115	Gemeindeverband für Kehrichtbeseitigung Region Aarau-Lenzburg	Oeffentlich-rechtlich
3122	Jost Wohlen AG	AG
3150	Biella-Neher Holding AG	AG
3130	Freunde der Oper Zürich	Verein
3167	Fondation de l'Hermitage Donation Famille Bugnion	Stiftung
3171	SI-REN SA	AG
3091	Orchestre de Chambre de Lausanne	Stiftung
1822	Heizwerk Gotthard AG	AG
3248	LANDI Romont, société coopérative	Genossenschaft
3257	Verein Sozialmedizinisches Zentrum Oberwallis	Verein
3282	t. Theaterschaffen Schweiz Professions du spectacle Suisse Professioni dello spettacolo Svizzera Professiuns da teater Svizra	Verein
3030	Waldwirtschaftsverband St. Gallen und Liechtenstein	Verein
3221	HV Finanzgesellschaft AG	AG
2586	Schweizerische Gesellschaft für Parlamentsfragen	Verein
2569	Kantonsschule Glarus	Staatlich
3304	Schweizerische Volkspartei  Sektion Vetroz	Verein
3331	Evangelische Volkspartei der Schweiz (EVP)	Verein
3358	Schweizerische Volkspartei Oberwallis (SVPO)	Verein
3369	Schweizer Vereinigung für den Rat der Gemeinden und Regionen Europas	Verein
1008	Interessengemeinschaft Berner Luftverkehr (IGBL)	Verein
1212	Interprofession du Vignoble et des Vins de Genève (IVVG)	Verein
1203	Stiftung Auto Recycling Schweiz	Stiftung
1230	Grenzkommission	Staatlich
1284	Freiburger Radfahrer Verband	Verein
1288	Agrisano	Stiftung
1328	Vulcanus Projekt AG	AG
1350	Swissolar - Schweizerischer Fachverband für Sonnenenergie	Verein
1380	Alpen-Initiative	Verein
1179	Caisse cantonale d'assurance populaire	Oeffentlich-rechtlich
1394	Verein Energie Zukunft Schweiz	Verein
1418	Stiftung zeka zentren körperbehinderte aargau	Stiftung
1441	KMU Frauen Solothurn	Verein
1454	Cleantech	Parlamentarische Gruppe
1460	Kbm Engineers SA	AG
1513	Akros AG	AG
1531	ME Advocat AG	AG
1562	Sun 21	Verein
1579	Cave Blavignac SA, succursale de Carouge	AG
1580	Entegra Wasserkraft AG	AG
1620	Spaeter AG	AG
1651	Vadec SA	AG
1668	Stiftung schweizerischer Privatschulen	Stiftung
1680	succèSuisse	Verein
1720	Schweizerische Arbeitsgemeinschaft der Jugendverbände (SAJV)	Verein
1730	Verband Schweizerischer Mineralquellen und Soft-Drink-Produzenten SMS	Verein
1763	Wohnbaugenossenschaft Oberfeld, Ostermundigen	Genossenschaft
1780	SIG Combibloc Services AG	AG
1804	Meliorationsgenossenschaft Thalkirch	Genossenschaft
1832	Brandenberger + Ruosch AG	AG
1860	Promarca Schweizerischer Markenartikelverband	Verein
1872	Eglise Evangélique Mennonite de Tavannes	Verein
1910	Agrisano Krankenkasse AG	AG
1935	Universität Freiburg	Staatlich
1947	W.A. de Vigier Stiftung	Stiftung
1958	IG Schweizer Unternehmer gegen wirtschaftsfeindliche Initiativen	Informelle Gruppe
1994	Lazzarini AG	AG
2022	Rat für Raumordnung	Ausserparlamentarische Kommission
2006	Oltner Kabarett-Tage	Verein
2091	Economic Community Of West African States (ECOWAS)	Staatlich
2081	Eniwa AG	AG
2102	Allreal Holding AG	AG
2125	Swisscopyright	Verein
2169	Stiftung Stapferhaus Lenzburg	Stiftung
2175	Gesellschaft Schweiz-Israel	Verein
2192	Beratende Kommission für Landwirtschaft	Ausserparlamentarische Kommission
2199	Jugend + Musik (j+m)	Verein
2205	République et Canton du Jura	Staatlich
2238	Köhler, Stüdeli & Partner GmbH	GmbH
2321	MAJ Mouvement autonomiste jurassien	Verein
2331	Verein Berner Haus- und KinderärztInnen	Verein
2290	Genossenschaft feusuisse, Verband für Wohnraumfeuerungen, Plattenbeläge und Abgassysteme	Genossenschaft
2373	Stiftung Albisbrunn	Stiftung
2353	Info-Forum freies Unternehmertum	Verein
2311	Parkings-Relais lausannois SA	AG
2492	European Alliance for Israel	Informelle Gruppe
2462	Stadt Bern	Staatlich
2419	Ärztezentrum Oberhasli AG	AG
2477	Verein Landschaftspark Binntal	Verein
2484	PR Bristol Immobilien AG	AG
2529	FONDATION FRANZ WEBER	Stiftung
2552	Kläranlageverband Ellikon an der Thur	Verein
2650	Addor & Künzi avocats SA	AG
2664	Association stop aux abus de via sicura	Verein
2694	Andlauerhof AG	AG
2697	Stiftung für medizinische Weiterbehandlung, Rehabilitation und Prävention BRH	Stiftung
2765	Gebäudeversicherung Kanton Zürich	Oeffentlich-rechtlich
2777	Fondation "L'Estampille"	Stiftung
2783	Hypothekar-Bürgschaftsgenossenschaft für Wohneigentumsförderung HBW in Liquidation	Genossenschaft
2794	Gewerbeverband Kriens GVK	Verein
2749	Le Cercle Silver Economie	Verein
2831	Schweizerische Vereinigung der Eigentümer historischer Wohnbauten Domus Antiqua Helvetica	Verein
2840	Die Mitte Sense	Verein
2898	Schweiz - Lateinamerika	Parlamentarische Freundschaftsgruppe
2927	Samaritervereinigung der Stadt Bern	Verein
2867	Association Terre & Faune	Verein
2970	Alterszentrum Obere Mühle AG	AG
2946	Burgherr Immobilien AG	AG
2956	Solidarité sans frontières	Verein
3009	Peter Lang AG Internationaler Verlag der Wissenschaften in Nachlassliquidation	AG
3044	Blumen Dudler Inhaberin Fabienne Segmüller	Einzelunternehmen
3071	AM-Network	Verein
3151	Orior AG	AG
3158	Genossenschaft Berner Singstudenten-Heim	Genossenschaft
3166	Schweizerische Volkspartei Berner Jura	Verein
1831	Informationsverlag Schweiz GmbH	GmbH
3178	Téléski Le Locle-Sommartel S.A.	AG
3216	Carrosserie Vitali + Müller AG	AG
3249	Kantonale Gebäudeversicherung Freiburg	Oeffentlich-rechtlich
3258	Verein Zentrum Saltina in Liquidation	Verein
3271	Daniel Jositsch Rechtsanwalt	Einzelunternehmen
2554	Gruppenwasserversorgung Forre	Verein
3247	SIB Schweizerisches Institut für Betriebsökonomie AG	AG
2588	St. Claraspital AG	AG
2570	Energie Genossenschaft Schweiz	Genossenschaft
3301	benevol Schweiz	Verein
3320	Schweizerische Zeitschrift für Gesellschafts- und Kapitalmarktrecht	Einzelunternehmen
3357	Walliser Fussballverband	Verein
3355	Decurtins Media und Management GmbH	GmbH
3390	Fondation Comtesse Andrée d'Etchégoyen	Stiftung
3419	Talrat Lötschental Plus	Informelle Gruppe
3405	Sozialdemokratische Partei Winterthur	Verein
3462	Jodlerfest Brig 2017	Verein
3494	Kirchgemeinde Pfarrei St. Theresia	Oeffentlich-rechtlich
1207	Schweizerische Stiftung für das cerebral gelähmte Kind	Stiftung
1219	Société Coopérative Migros Genève	Genossenschaft
1258	Spaeter Ticino SA	AG
1250	Basler Verkehrs-Betriebe (BVB)	Oeffentlich-rechtlich
1286	AGRIDEA Schweizerische Vereinigung für die Entwicklung der Landwirtschaft und des ländlichen Raums	Verein
1325	Petit Mont-Riond SA	AG
1346	Schweizer Paraplegiker-Zentrum Nottwil AG	AG
1367	Regionaler Naturpark Gruyère Pays-d'Enhaut	Verein
1372	Verkehrs-Club der Schweiz Sektion Genf	Verein
1406	Berner Bauern Verband	Verein
1416	Verein Geothermische Kraftwerke Aargau	Verein
1436	Netzwerk Schweiz	Verein
1461	Straub AG, Ingenieure + Geoinformatiker	AG
1471	Electricité de la Lienne SA	AG
1502	HES-SO Fachhochschule Westschweiz	Staatlich
1523	Bucher + Suter AG (D)	AG
1559	Empa, Materials Science and Technology	Staatlich
1586	BVG- und Stiftungsaufsicht beider Basel (BSABB)	Oeffentlich-rechtlich
1611	Harvard Club Zurich	Verein
1630	VAUDOISE VIE, Compagnie d'Assurances SA	AG
1647	Hôtel Pierre-François S.A., en liquidation	AG
1677	Ersparniskasse Schaffhausen AG	AG
1700	Kantonales Staatsschutz-Kontrollorgan Basel-Stadt	Staatlich
1698	Stiftung Haus für elektronische Künste Basel	Stiftung
1749	Costa Kreuzfahrten GmbH	GmbH
1774	Digitale Nachhaltigkeit	Parlamentarische Gruppe
1797	Schweizer Allianz Gentechfrei SAG	Verein
1805	Fundaziun Capricorn	Stiftung
1840	FDP Die Liberalen Stadt Zürich	Verein
1867	Verband Schweizerischer Versicherungsbroker SIBA	Verein
1897	Schweizerischer Verband für Weiterbildung (SVEB)	Verein
1891	Gesellschaft Schweiz-Armenien	Verein
1934	IG Swiss Made	Informelle Gruppe
1948	Matter Group AG	AG
1983	Sozialdemokratische Partei Kanton Bern	Verein
1997	Gebäudeversicherung des Kantons Graubünden	Staatlich
2023	Beirat für Kommunalentwicklung Rheinland-Pfalz	Staatlich
2027	Allianz in den Alpen	Verein
2092	North Atlantic Treaty Organisation NATO	Staatlich
2117	Andermatt Swiss Alps AG	AG
2075	Dr. med. Aufdermaur AG	AG
2167	International Fire Academy	Einfache Gesellschaft
2135	SSA Société Suisse des Auteurs	Genossenschaft
2157	Fondation Suisse pour les enfants malades en République d'Arménie (SEMRAplus)	Stiftung
2243	HarbourClub Chief Communications Officers	Verein
2251	SVP des Kantons Schaffhausen	Verein
2257	LANDI Wartau (Landwirtschaftliche Genossenschaft Wartau)	Genossenschaft
2241	IG eHealth	Verein
2359	Mayer Conseils	Einzelunternehmen
2396	Dr. Wilhelm von Vigier Stiftung	Stiftung
2296	LU Couture AG	AG
2300	Konferenz der kantonalen Sozialdirektorinnen und Sozialdirektoren (SODK)	Staatlich
2309	Fondation de l'ancien dispensaire en liquidation	Stiftung
2408	Gemeinnützige Gesellschaft des Kantons Zug	Verein
2495	Verband der Flugpassagiere des Kantons Tessin (ASPASI)	Verein
2537	GEFAG Gefahrgutausbildung und -Beratung AG	AG
2509	Société Nautique de Genève	Verein
2430	H. Minder AG	AG
2487	Swiss Excellence Forum	Verein
2549	polestica gmbh	GmbH
2643	Stiftung für Qualitätssicherung in der Implantationsmedizin	Stiftung
2658	Pro Schweiz Wallis	Verein
2671	Förderverein Region Gantrisch	Verein
2696	Pensionskasse der Vereinigten Drahtwerke AG, Biel	Stiftung
2702	Genossenschaft Swissconsultants.ch	Genossenschaft
2770	Spross-Immobilien AG	AG
2816	Kappeler - Stiftung	Stiftung
2732	Transports publics genevois (TPG)	Oeffentlich-rechtlich
2741	Schweiz Tourismus	Oeffentlich-rechtlich
2802	SGF Gemeinnütziger Frauenverein Zentralschweiz	Verein
2756	Sparhafen Immobilien AG	AG
2923	Verein für interkulturelle Altersfragen (VIA)	Verein
2850	SBH Société Bulloise de l'Habitat SA	AG
2911	Optinovum GmbH	GmbH
2919	Staatsbürgerliche Gesellschaft der Stadt Bern und Umgebung	Verein
2971	okaj zürich	Verein
2980	Dachverband Offene Kinder- und Jugendarbeit Schweiz	Verein
3035	Zweckverband Altersheim Feldhof Oberriet-Rüthi	Oeffentlich-rechtlich
2964	Sozialdemokratische Partei Bezirk Bülach	Verein
3069	Lions-Club Zug	Verein
3101	Industrieverein Amriswil	Verein
3022	Bund der Steuerzahler (BDS) Frauenfeld	Verein
3108	Von Roll Schweiz AG	AG
3184	Nez Rouge Genf	Stiftung
3199	Télé Anzère. Société Anonyme des Remontées Mécaniques du Wildhorn 1972 Anzère	AG
3211	Kistler Holding AG	AG
3138	Kommission für Bergführer und Skilehrer, Kanton Uri	Ausserparlamentarische Kommission
3250	Grangeneuve Landwirtschaftliches Institut des Kantons Freiburgs	Oeffentlich-rechtlich
3270	Rechtsanwalt Dr. iur. Bernhard Alfred Isenring	Einzelunternehmen
3242	Fondation Jean-Pierre Miéville	Stiftung
3056	Banque Raiffeisen Alpes Chablais Vaudois société coopérative	Genossenschaft
2012	Lungenliga Glarus	Verein
2015	Regierungskonferenz der Gebirgskantone	Verein
3295	Vereinigung Cerebral Schweiz	Verein
3319	Parlamentarische Gruppe Schweiz - Baskenland	Parlamentarische Gruppe
3347	Schweizerische Multiple Sklerose Gesellschaft	Verein
3330	Ausgleichskasse des Kantons Bern	Oeffentlich-rechtlich
3395	Eftec Europe Holding AG	AG
3410	Société de sauvetage de Coppet	Verein
3415	SP Stadt Zürich 5	Verein
1218	XXL Green Project SA, en liquidation	AG
1256	Nuova Società Editrice del Giornale del Popolo SA in liquidazione	AG
1232	Wirtschaftsförderungskommission	Staatlich
1285	SwissTabac	Verein
1323	O4Real SA	AG
1292	NWO-Stiftung Belcampo	Stiftung
1365	Helvetia Latina	Verein
1381	Schweizerischer Fischerei-Verband SFV	Verein
1397	Dr. Pia Stebler Consulting	Einzelunternehmen
1402	Fachvereinigung Wärmepumpen Schweiz FWS	Verein
1429	Association pour un canton de l'Arc jurassien (ACAJU)	Verein
1446	Stiftung Zentrum für nachhaltige Abfall- und Ressourcennutzung ZAR	Stiftung
1476	alp Bauingenieure AG	AG
1491	FDP Die Liberalen Waadt	Verein
1522	Bucher + Suter Inc.	AG
1545	Sport Union Schwyz	Verein
1568	Comité permanent du Salon international de l'automobile	Stiftung
1594	Stiftung für junge Auslandschweizer	Stiftung
1608	Zürcher Handelskammer	Verein
1624	Beratungsbüro FBL associés	Einfache Gesellschaft
1656	Association suisse des locataires Vaud	Verein
1671	Stiftung Brändi	Stiftung
1706	Mühle Hunziken Konzert AG	AG
1715	Arbeitsintegration Schweiz	Verein
1740	Handelskammer beider Basel	Verein
1765	Gemeinde Ostermundigen	Staatlich
1794	Coopérative Tunnel-Riponne	Genossenschaft
1820	Matterhorn Gotthard Verkehrs AG	AG
1845	Fokus Bern	Informelle Gruppe
1870	Westschweizer Konferenz für Weiterbildung	Verein
1902	Schweizerischer Sportverband öffentlicher Verkehr (SVSE)	Verein
1912	Agrisano Versicherungen AG	AG
1915	Genossenschaft pro Mosnang	Genossenschaft
1974	Solothurner Handelskammer	Verein
1953	FC Gerlafingen	Verein
1979	Solothurnischer Juristenverein	Verein
2046	Weseta Textil AG	AG
2026	Schweizerische Studiengesellschaft für Raumordnung und Regionalpolitik	Verein
2094	Interparlamentarische Union IPU	Staatlich
2069	Landwirtschaftlicher Informationsdienst LID	Verein
2160	Association des Amis de Caritas Jura	Verein
2146	Fondation Zermatt Summit	Stiftung
2131	DSJ Alumni Alumnae	Verein
2176	Trägerverein Aargauer Symphonie Orchester Aarau	Verein
2245	Eidgenössische Kommission für Weltraumfragen EKFW	Ausserparlamentarische Kommission
2230	Polizei- und Sicherheitsfragen	Parlamentarische Gruppe
2210	Verein Stop Piracy	Verein
2216	Landi Linth Genossenschaft	Genossenschaft
2270	Aletsch Arena AG	AG
2364	CGN SA	AG
2343	Services industriels de Genève	Oeffentlich-rechtlich
2401	Prof. Dr. Arnold u. Johanna Kaufmann-Anderegg-Stiftung	Stiftung
2388	Aare Seeland mobil AG	AG
2411	Minergie	Verein
2466	Office de Promotion des Industries et des Technologies	Stiftung
2423	Beo Holz	Verein
2543	Sponsoring Schweiz	Verein
2518	Kosciuszko-Gesellschaft	Verein
2440	Verband Schweizerischer Konzertlokale, Cabarets, Dancings und Discotheken (ASCO)	Verein
2553	Verband Schweizer Abwasser- und Gewässerschutzfachleute (VSA)	Verein
2607	Schweizerischer Altzofingerverein	Verein
2663	Association pour la Protection du Paysage du Coude du Rhône	Verein
2673	Verein Kaufmännischer Verband Bern	Verein
2636	immo swiss assets ag	AG
2762	c+j immo AG	AG
2814	Brava	Verein
2781	Comunità di lavoro Regio Insubrica	Verein
2789	FDP Die Liberalen Zürich 9	Verein
2745	Oxford Swiss Society	Verein
2826	Gemeinde Ueberstorf	Staatlich
2881	LYS SNC, en liquidation	KG
2844	Schweizerischer Nationalfonds zur Förderung der wissenschaftlichen Forschung	Stiftung
2903	Fondation de La Côte pour l'aide et les soins à domicile et la prévention	Stiftung
2862	association e-covoiturage.ch	Verein
2967	Schweizerische Volkspartei Aargau	Verein
2977	Perspective CH	Verein
2957	Verein Netzwerk Asyl Aargau	Verein
3008	Emeria Switzerland SA	AG
2997	Liestal Tourismus	Verein
3123	Roltim AG in Liquidation	AG
3018	Verein Cleantech Switzerland in Liquidation	Verein
3024	Zweckverband Rheintaler Binnenkanalunternehmen	Oeffentlich-rechtlich
3111	Aktion für eine vernünftige Energiepolitik Schweiz Solothurn	Verein
3197	CERIMMO DEVELOPPEMENT SA	AG
3175	Fondation pour le commerce lausannois	Stiftung
3217	Vitali Treuhand GmbH	GmbH
3192	SERBECO SA	AG
3195	DEFFERRARD & LANZ SA	AG
3287	Schweizerische Volkspartei Ybrig	Verein
3057	Centre Mondial du Cyclisme	Stiftung
2589	VeriPro AG	AG
2016	Personalwohlfahrtsstiftung der Kontrofina-Holding-Aktiengesellschaft	Stiftung
3303	Schweizerische Volkspartei des Bezirks Conthey	Verein
3337	Swiss Handicap AG	AG
3348	Kunstverein Winterthur	Verein
3368	Fondation MOB GoldenPass historique	Stiftung
3380	Forschungsgemeinschaft für Nationalökonomie, Universität St.Gallen	Staatlich
3425	Arnold-Niederer-Stiftung	Stiftung
3442	Conaxess Trade Switzerland AG	AG
3455	Krankenträgervereinigung Oberwallis	Verein
3480	Schweizer Delegation beim Kongress der Gemeinden und Regionen Europas	Staatlich
3501	Parlamentarische Gruppe Schweiz - Südafrika	Parlamentarische Gruppe
3525	Schützengesellschaft Regensdorf-Watt	Verein
3576	Hauseigentümerverband Fraubrunnen	Verein
1217	Transports Publics Neuchâtelois SA	AG
1223	spirit of management Andreas Burgener	Einzelunternehmen
1226	Stiftung "Switzerland Innovation"	Stiftung
1270	Telesuisse - Verband der Schweizer Regionalfernsehen	Verein
1291	Milchgenossenschaft Oberwichtrach in Liquidation	Genossenschaft
1296	AGRO fiduciaire fribourgeoise SA	AG
1177	Alters- und Pflegeheime Glarus Süd (APGS)	Oeffentlich-rechtlich
1335	Rotary District 1990	Informelle Gruppe
1409	Geothermie-Schweiz	Verein
1425	NeuchEole SA en liquidation	AG
963	Gisler Spenglerei-Bedachungen GmbH	GmbH
1473	EcoBois Recyclage SA	AG
1495	Ausgleichskasse Spida	Verein
1515	AMC International Alfa Metalcraft Corporation AG	AG
1532	FROX communication AG (D)	AG
1543	Katholischer Turn- und Sportverein (KTV) Muotathal	Verein
1590	Sozialdemokratische Partei Baselland, Sekretariat	Verein
1597	Fondation de l'Institut de Recherche Idiap	Stiftung
1625	VAUDOISE ASSURANCES HOLDING SA	AG
1653	r & associés avocats	Einfache Gesellschaft
1667	Universität Luzern	Staatlich
1699	Marie Anna-Stiftung zur Unterstützung kranker Kinder im Raum Basel	Stiftung
1721	S-Com	Einzelunternehmen
1741	Amis du Théâtre de Colombier	Verein
1759	Kasachstan, Justizministerium	Staatlich
1784	Kommission für die Bundesstatistik	Ausserparlamentarische Kommission
1809	Simple & Smart Communication	Einfache Gesellschaft
1829	Aerztegesellschaft des Kantons Zürich	Verein
1849	Hauptstadtregion Schweiz	Verein
1884	Auto-i-DAT AG	AG
1895	Core AG Design Works.	AG
1940	Organisation der Arbeitswelt Agrialiform	Verein
1926	Regionale Wald-Genossenschaft Fontannen	Genossenschaft
1977	Solothurnischer Anwaltsverband (Solav)	Verein
1955	Sozialdemokratische Partei Kanton Solothurn	Verein
2024	SEREC Sàrl en liquidation	GmbH
2008	Schwarzbuben-Vereinigung Solothurn und Umgebung	Verein
2063	Pensionskasse der Gewerkschaft des Verkehrspersonals SEV	Stiftung
2100	Allianz 'Lex Koller bleibt modern'	Informelle Gruppe
2105	Fédération Romande Immobilière	Verein
2109	PSP Swiss Property AG	AG
2152	Stiftung Stockalperturm Gondo	Stiftung
2188	AGILE.CH	Verein
2223	Energieforum Linth	Verein
2250	ACS Sektion Schaffhausen	Verein
2255	Trägerverein Culinarium	Verein
2259	IG Viscosepark Widnau	Verein
2217	Kaufmännischer Verband Winterthur (KVW)	Verein
2334	Arbeitsgemeinschaft Tabakprävention AT	Verein
2370	Pädagogische Hochschule Zug	Staatlich
2376	Goldbach Audience (Switzerland) AG	AG
2379	Schweizerische Nationalbank	Oeffentlich-rechtlich
2358	Cobaty Suisse - Association de Genève	Verein
2392	Hotel Weissenstein AG	AG
2497	Servizio Autoambulanza Mendrisiotto (SAM)	Verein
2504	Schweizerische Vereinigung für Sozialpolitik SVSP	Verein
2427	Schweizerischer Alpwirtschaftlicher Verband SAV	Verein
2517	F-Information	Verein
2528	Tanznetzwerk Schweiz (RESO)	Verein
2599	Drexel und Weiss Energieeffiziente Haustechniksysteme GmbH	GmbH
2608	Eidgenössisches Nuklearsicherheitsinspektorat ENSI	Oeffentlich-rechtlich
2691	bonacasa ag	AG
2675	Läbigi Stadt	Verein
2635	Zukunft Glücksspiel	Informelle Gruppe
2812	aargauische stiftung suchthilfe ags	Stiftung
2815	Familie Fluck-Bernhard Stiftung	Stiftung
2780	Associazione Tiro Storico del San Gottardo	Verein
2733	Schweizerische Volkspartei Kanton Genf	Verein
2797	USS Versicherungen Genossenschaft	Genossenschaft
2808	ESTERMANN - CONSULTING	Einzelunternehmen
2879	IEA Bioenergy	Informelle Gruppe
2842	Zentrum für Neurowissenschaften Zürich (ZNZ)	Staatlich
2853	Gasthof Zum Schlüssel Ueberstorf AG	AG
2907	Futo Trading SA	AG
2918	Schweizerische Volkspartei Stadt Bern	Verein
2939	SGF SG/AR	Verein
2949	Mieterinnen- und Mieterverband Aargau	Verein
2959	Raiffeisenbank Reitnau-Rued Genossenschaft	Genossenschaft
2962	Hängele GmbH	GmbH
3049	CMC Exploitation SA	AG
3072	bergwärts GmbH in Liquidation	GmbH
3153	Veronika und Hugo Bohny Stiftung	Stiftung
3160	Moto-Club Corgémont	Verein
3077	Association pour la Promotion du Chasselas	Verein
3082	Caisse de pensions du personnel communal de Lausanne	Oeffentlich-rechtlich
3209	Burckhardt Compression AG	AG
3238	TECHLIFT Sàrl	GmbH
3193	Société d'exploitation de l'Espace Hippomène SA, en liquidation	AG
3268	SKV Immobilien AG	AG
3283	SRG Bern Freiburg Wallis	Genossenschaft
2577	Verkehrsbetriebe Biel / Transports publics biennois (VB/TPB)	Oeffentlich-rechtlich
3031	Die Mitte St. Gallen	Verein
2592	Schweizerische Rheinhäfen	Oeffentlich-rechtlich
2017	Psychiatrische Dienste Graubünden	Oeffentlich-rechtlich
3306	Rutz & Partner Consulting GmbH	GmbH
3317	Université Populaire Albanaise	Verein
3353	Das Kollektiv für audiovisuelle Werke GmbH	GmbH
3315	Internationale Liga gegen Rassismus und Antisemitismus (Schweiz)	Verein
3388	Fondation Alice et Karl Schenkel-Wagner	Stiftung
3408	Cercle Démocratique de Lausanne	Verein
3432	Kanton Nidwalden	Staatlich
3453	Association valaisanne pour la prophylaxie et les soins dentaires à la Jeunesse	Verein
3478	VCS Verkehrs-Club der Schweiz Sektion Aargau	Verein
1260	MediaTi Holding SA	AG
1251	Stiftung Oekomedia	Stiftung
1255	Hockey Club Ambrì Piotta SA	AG
1326	EVU Partners AG	AG
1315	LANDI Chénens Société coopérative	Genossenschaft
1376	Mobility Genossenschaft	Genossenschaft
1334	Verein Rotary Medien Schweiz/Liechtenstein	Verein
1392	Fondation USPI Vaud	Stiftung
1423	Immobilien AG Optingenstrasse 1, Bern	AG
1180	Aresa, Aéroport régional des Eplatures S.A.	AG
1463	Uli Lippuner aqualog AG	AG
1486	Amicale des Soldats de St-André	Verein
1512	Aeschi & Company GmbH	GmbH
1537	Peter Föhn-Heinzer Holding AG	AG
1554	Institut für Wirtschaft und Ökologie der Universität St. Gallen	Staatlich
1577	Kaufmännischer Verband Aargau Ost (KV Aargau Ost)	Verein
1602	Swiss IT Leadership Forum	Verein
1618	Veuthey & Cie Martigny SA	AG
1639	Schweizerische Public Affairs Gesellschaft	Verein
1683	Polo Bern AG Wichtrach	AG
1704	FASMED Dachverb. der Schweizer Ischen Handels- & Industrievereinig. der Medzinaltechnik	Verein
1716	Luzerner Gewerkschaftsbund	Verein
1738	Frau Sucht Gesundheit FSG	Verein
1756	Kantar Switzerland AG	AG
1778	Stiftung ZEWO	Stiftung
1811	Gaydoul Group AG	AG
1834	Burgergemeinde Bern, DC Bank Deposito-Cassa der Stadt Bern	Oeffentlich-rechtlich
1862	SENIOcare AG	AG
1873	SWISSLOS Interkantonale Landeslotterie Genossenschaft	Genossenschaft
1908	Verein AgroCleanTech	Verein
1937	Musikverein Euthal	Verein
1970	104 - Ausgleichskasse Schreiner	Stiftung
1990	Schweizerische St. Lukasgesellschaft für Kunst und Kirche	Verein
1980	Kleintiere Schweiz	Verein
2025	EUSALP - EU Strategy for the Alpine Region	Informelle Gruppe
2028	Konferenz der Regionen	Informelle Gruppe
2111	Berufsbildung	Parlamentarische Gruppe
2072	mosaic network GmbH	GmbH
2106	Intershop Management AG	AG
2126	Visarte Schweiz Berufsverband Visuelle Kunst	Verein
2132	DSJ / FSPJ Dachverband Schweizer Jugendparlamente	Verein
2159	Fondazione per l'Istituto Svizzero di Roma	Stiftung
2244	Eidgenössische Aufsichtskommission für die fliegerische Vorschulung (SPHAIR)	Ausserparlamentarische Kommission
2271	Weber Verlag AG	AG
2237	Thurgauer Gewerkschaftsbund	Verein
2279	Plateforme sans-papiers Suisse	Informelle Gruppe
2330	TUNNEL DU GRAND-SAINT-BERNARD S.A.	AG
2367	FONDATION COMMUNALE IMMOBILIERE DE LANCY	Oeffentlich-rechtlich
2399	Liberale Aktion	Stiftung
2303	Diözesankonferenz Bistum Basel	AG
2404	Vereinigung für angewandte Produktionstechnik (VPT)	Verein
2410	Lassalle-Haus Bad Schönbrunn	Verein
2464	Obergericht des Kantons Schaffhausen	Staatlich
2506	Camera di commercio, dell'industria, dell'artigianato e dei servizi del Canton Ticino	Verein
2513	Fondation "Au Coeur des Grottes"	Stiftung
2435	Fallschirmgruppe Titlis	Verein
2441	PHOTOMED Solarien Verband Schweiz	Verein
2449	Mieterinnen- und Mieterverband Kanton Bern	Verein
2652	Walliser Anwaltsverband	Verein
2665	Cinésuisse	Verein
2626	DSV A/S	AG
2640	Kulturgesellschaft Klosters	Verein
2704	CARBURA, Schweizerische Pflichtlagerorganisation für flüssige Treib- und Brennstoffe	Verein
2713	Schweizerische Volkspartei Wahlkreis Emmental	Verein
2724	Mühle Bundkofen AG in Liquidation	AG
2790	Parlamentarische Gruppe Schweiz - Slowakei	Parlamentarische Gruppe
2798	Pensionskasse Stadt Zürich	Oeffentlich-rechtlich
2752	Association pour l'Animation des Acacias	Verein
2921	Les Routiers Suisses	Verein
2836	Konservatorium KF	Staatlich
2897	Parlamentarische Gruppe Schweiz - Polen	Parlamentarische Gruppe
2859	Pro Aqua - Pro Vita in Liquidation	Stiftung
2869	Fondation Ynternet.org	Stiftung
3000	Société coopérative de fabriques d'aiguilles et de composants pour l'horlogerie en liquidation	Genossenschaft
2981	Konferenz der kantonalen Beauftragten für Kinder- und Jugendförderung	Staatlich
2960	Dorfladen Reitnau GmbH	GmbH
3042	Verein Swiss Cross	Verein
3119	Fondation pour l'enseignement de la musique	Oeffentlich-rechtlich
3145	Versammlung der Regionen Europas	Verein
3103	Schweizerische Bodensee-Schifffahrt AG	AG
3074	LA MANUFACTURE, ATELIERS PROTEGES, fondation du Dr. A. Rollier	Stiftung
3114	FDP Die Liberalen Aargau	Verein
3172	Mediaprofil SA	AG
3092	Association Internationale des Maires francophones	Verein
3213	Kistler Instrumente AG	AG
3229	Fribourgissima	Verein
3263	Autohalle Kasinoplatz AG	AG
3279	FONDATION SUISSE DE RECHERCHE SUR LES MALADIES MUSCULAIRES	Stiftung
3179	Fondation Job Service Neuchâtel	Stiftung
2560	Schweizerischer Gehörlosenbund	Verein
2581	Stiftung SGB für Bildung und Publikation	Stiftung
2563	Stiftung Medien. Meinungen, Vielfalt.	Stiftung
3308	Kuratorium Blau/Weiss	Verein
3338	Band-Genossenschaft	Genossenschaft
3354	haemmerli.com GmbH	GmbH
3349	Verein Kiosk Josefwiese	Verein
3400	EMS-INVENTA AG	AG
3412	Reporterforum	Verein
3437	PFISTERER Switzerland AG	AG
3457	Verein Freunde der Stiftung Oberwallis für Kinder unserer Welt	Verein
3474	Commission consultative en matière de défense incendie et de secours	Ausserparlamentarische Kommission
3520	Schweizerische Volkspartei Bezirk Dielsdorf	Verein
1259	Tele Ticino SA	AG
1279	Amavita Health Care AG	AG
1254	Ennio Ferrari SA	AG
1290	Personalvorsorgestiftung des Schweizerischen Bauernverbandes	Stiftung
1294	Nationales Nordisches Skizentrum Kandersteg Genossenschaft	Genossenschaft
1353	Association Suisse des locataires - Section romande	Verein
1178	Swiss Engineering STV UTS ATS	Verein
1336	Schweizer Schiesssportverband	Verein
1421	Berner Bauern Verband Management AG	AG
1433	Rechtswissenschaftliche Fakultät der Universität Bern	Staatlich
1453	IG Arbeitsplätze im Berggebiet und im ländlichen Raum / Sektion Wallis	Verein
1465	ETEC Ecologie aquatique Sàrl en liquidation	GmbH
1507	Transfair	Verein
1525	Despond S.A.	AG
1541	Energiedienst AG	AG
1572	Fédération Vaudoise de Coopération (Fedevaco)	Verein
1612	Young Enterprise Switzerland (YES)	Verein
1617	Aproz Sources Minérales SA	AG
1646	Intercommunale Gaz-Energie (IGESA) S.A.	AG
1676	Elektrizitätswerk des Kantons Schaffhausen AG	AG
1691	Port-Associations GmbH	GmbH
1719	syndicom	Verein
1739	Verein Aktion Freiheit und Verantwortung	Verein
1758	Parlamentarische Gruppe Ostschweiz	Parlamentarische Gruppe
1785	Energieplattform Immobilien (EPImmo) in Liquidation	Verein
1812	STIFTUNG UNIVERSITÄRE FERNSTUDIEN SCHWEIZ FS-CH	Stiftung
1837	E-Governement Symposium	Verein
1861	Schweizerische Konferenz für Sozialhilfe SKOS	Verein
1876	Bündnis Für Eine Dauerhafte Und Rollende Nord-Süd-Verbindung	Informelle Gruppe
1888	Groupe des Amis du Club en Fauteuil Roulant Fribourg (GACFRF)	Verein
1941	Matter Beteiligungen AG	AG
1925	Qualinova AG	AG
1959	Dr. Borer Consulting	Einzelunternehmen
1996	Rhätische Bahn AG (RhB)	AG
2003	FDP Die Liberalen Kanton Glarus	Verein
2059	Versicherungskasse SWISSLOS	Stiftung
2114	UBS Fund Management (Switzerland) AG	AG
2074	Schweizerische Bundesbahnen SBB	Oeffentlich-rechtlich
2124	Bildung, Forschung und Innovation	Parlamentarische Gruppe
2151	Die Mitte des französischsprachigen Wallis	Verein
2133	SWISSPERFORM	Verein
2219	Swiss Small Hydro - Schweizer Verband der Kleinwasserkraft	Verein
2248	Aero-Club der Schweiz	Verein
2253	Schweiz - Suryoye	Parlamentarische Freundschaftsgruppe
2215	Schweizerische Hagel-Versicherungs-Gesellschaft, Genossenschaft	Genossenschaft
2269	BLS AG	AG
2335	EOS HOLDING SA	AG
2294	Krankenkasse Luzerner Hinterland	Verein
2299	Kanton Luzern	Staatlich
2305	Compagnie du chemin de fer Lausanne-Echallens-Bercher SA	AG
2407	Stiftung für junge Auslandschweizer, Kantonalkomitee Zug	Stiftung
2494	PostAuto AG	AG
2501	C.S. Invest AG	AG
2542	Parlement Jurassien	Staatlich
2515	Forum Stadt - Netzwerk historischer Städte	Verein
2521	Verband Solothurner Einwohnergemeinden VSEG	Verein
2551	Stiftung Hörnlihütte Zermatt in Liquidation	Stiftung
2647	STUDIO MBH AG	AG
2614	Associazione L'Orto	Verein
2620	HT-Plan Haustechnik-Planungs AG	AG
2678	Büro für Bildungsfragen	Einzelunternehmen
2760	BEELEGAL Bösiger. Engel. Egloff	KG
2709	Aebi Holz AG	AG
2775	RADIO FRIBOURG SA	AG
2818	Spitex Wettingen	Oeffentlich-rechtlich
2791	Schweizerische Volkspartei Frauen Schweiz	Verein
2805	Schweizerische Vereinigung der Strahler, Mineralien- und Fossiliensammler SVSMF	Verein
2877	Triple E&M	Einzelunternehmen
2835	Staat Freiburg	Staatlich
2896	KUNSTSTOFF.swiss	Verein
2905	Forum de l'économie de La Côte	Verein
2929	Omnia Consulting GmbH	GmbH
2933	Berufs- und Weiterbildungszentrum Rapperswil-Jona	Staatlich
2978	Birchmeier Holding AG	AG
3005	Groupement des fabricants d'aiguilles	Verein
2988	Natur- und Vogelschutzverein Bubendorf	Verein
2996	Bezirksschwingklub Waldenburg	Verein
3120	Cinémathèque suisse	Stiftung
3147	WWZ AG	AG
3157	Verein Mütter- und Väterberatung Kanton Bern	Verein
3075	Fondation LA PASSERELLE BELLERINE	Stiftung
3182	Carrefour AddictionS	Verein
3133	FLYER AG	AG
1825	Winterhilfe Uri	Verein
3236	GENILEM VALAIS	Verein
3142	Interkantonale Polizeischule Hitzkirch	Oeffentlich-rechtlich
3260	Academia Natriensis	Verein
3051	GB FIBEXA SA, en liquidation	AG
2559	Förderverein Grosse Berner Renntage	Verein
2585	Stiftung Umwelteinsatz Schweiz (SUS)	Stiftung
2594	Graubünden Wald	Verein
3293	Zürcher Anwaltsverband	Verein
3316	Internationale Liga gegen Rassismus und Antisemitismus (Sektion Genf)	Verein
3344	Verband Schweizerischer Assistenz- und Oberärztinnen und -ärzte	Verein
3361	Centre de Congrès Montreux SA	AG
3373	Association Vaud Promotion	Verein
3399	EMS-CHEMIE HOLDING AG	AG
3420	EVTL Energieversorgung Talschaft Lötschen AG	AG
3436	PFISTERER Ixosil AG	AG
3454	Projet Santé	Verein
3475	WWF Aargau	Verein
3502	Fondation de la Cité Universitaire de Genève	Stiftung
3526	Tell-Museumsgesellschaft Uri	Einfache Gesellschaft
3559	Gemeinde Volketswil	Staatlich
3563	Business and Professional Women Genève	Verein
3564	Business & Professional Women Switzerland	Verein
3632	Luzern Tourismus LT AG	AG
1280	G-Pharma AG	AG
1287	Agrimmo AG	AG
1311	Vereinigung Schweizerischer Kartoffelproduzenten VSKP	Verein
1347	Schweizer Paraplegiker-Forschung AG	AG
1369	politimpuls GmbH	GmbH
1374	Croix-Rouge genevoise, Association cantonale de la Croix-Rouge suisse	Verein
1391	EBP Schweiz AG	AG
1417	Verein Geothermische Kraftwerke Schweiz (VGKS) in Liquidation	Verein
1438	FDP Die Liberalen Kanton Solothurn	Verein
1456	Schweiz - Türkei	Parlamentarische Freundschaftsgruppe
1458	Kanton Wallis	Staatlich
1504	Netzwerk FUTURE	Informelle Gruppe
1524	Schweizer Casino Verband (SCV)	Verein
1542	Skiclub Muotathal	Verein
1567	Schwyzer kantonaler Schwingerverband (SKSV)	Verein
1584	Philipp Müller Generalunternehmung, Immobilien	Einzelunternehmen
1615	COFIGO SA	AG
1634	Fondation Leenaards	Stiftung
1661	Komplementärmedizin	Parlamentarische Gruppe
1685	Cut'n'smoke Cigar-Club Bern	Verein
1692	Tabascom GmbH	GmbH
1722	Eidgenössisches Schützenfest 2015	Verein
1746	Accenture AG	AG
1764	E plus U Energie- und Umweltberatung GmbH	GmbH
1793	NECC SA	AG
1815	Forschungsinstitut für Arbeit und Arbeitsrecht der Universität St. Gallen	Staatlich
1827	Alliance Patrimoine	Informelle Gruppe
1855	LogObject AG	AG
1896	SOG Schweizerische Offiziersgesellschaft	Verein
1909	"Haus des Schweizerbauern"	Stiftung
1919	Stiftung St.Galler Landwirtschaft	Stiftung
1946	Stiftung für schweizerische Rechtspflege	Stiftung
1982	Sozialdemokratische Partei Biel	Verein
1978	New York City Bar	Verein
2043	Kraftwerke Zervreila AG	AG
2054	Aktiengesellschaft Grünes Zentrum Weinfelden	AG
2064	Ferienheimgenossenschaft SEV	Genossenschaft
2070	Coop Rechtsschutz AG	AG
2088	United Nations Organisation UNO	Staatlich
2165	Turdus Vogel- und Naturschutzverein Schaffhausen	Verein
2186	Société d'expansion touristique de Zinal SA	AG
2181	Deutsche Börse AG	AG
2229	Drogenpolitik	Parlamentarische Gruppe
2206	Narwal AG	AG
2276	Parking Centre Ville SA	AG
2323	Société italo-suisse d'exploitation du Tunnel du Grand-Saint-Bernard SA	AG
2363	Parti Socialiste Vaudois	Verein
2337	Schweizerische Gesellschaft der Fachärztinnen und -ärzte für Prävention und Gesundheitswesen	Verein
2400	Max Gubler-Stiftung	Stiftung
2378	Goldbach Group AG	AG
2385	Ausgleichskasse AHV Kanton Genf	Oeffentlich-rechtlich
2409	Hauseigentümerverband Zugerland	Verein
2539	RETEST GmbH in Liquidation	GmbH
2424	Kälbermäster-Verband Kanton Bern	Verein
2478	Die Mitte Oberwallis	Verein
2545	Verein Freunde der Ka-We-De	Verein
2442	Schweizer Brauerei-Verband	Verein
2598	Swiss Bridge	Stiftung
2689	GVB Services AG	AG
2617	Gasser Gartenbau AG	AG
2625	Zurzach Care Zürich AG	AG
2637	Stiftung Sport-Gymnasium Davos (SSGD)	Stiftung
2703	GXO LOGISTICS SWITZERLAND S.A.G.L.	GmbH
2712	Aebi Reisen GmbH	GmbH
2723	Präsidentenkonferenz (PK) des Schweizerischen Rollhockeyverbands (SRHV)	Verein
2787	Verein Zürcher Volksfeste	Verein
2743	Fondation Sommet Mondial des Femmes (FSMF)	Stiftung
2803	Dachverband Schweizerischer Gemeinnütziger Frauen	Verein
2920	Vereinigung Bernaktiv	Verein
2884	Binengarten AG	AG
2899	Wohn- und Grundeigentum	Parlamentarische Gruppe
2910	Optinovum Immobilien AG	AG
2932	Schweizerische Volkspartei Rapperswil-Jona	Verein
2974	Verein Generationenbeziehungen	Verein
2953	Sozialdemokratische Partei Schweiz International	Verein
2987	KMU Frauen Baselland	Informelle Gruppe
3041	Soziale Dienste Mittelrheintal	Verein
3013	Association Réseau Entreprendre Suisse	Verein
3146	Volkswirtschaftsdirektorenkonferenz der Westschweiz	Staatlich
3156	Caisse d'Epargne Courtelary SA	AG
3162	Courvoisier-Gassmann AG	AG
3080	Chablais Région	Verein
3198	ED ENERGIE DURABLE SA	AG
3210	Bucher Industries AG	AG
3235	C'est l'Hiver! Morgins Festival	Verein
3194	Fondation Nicolas BOGUERET	Stiftung
3273	Sozial- & Bildungsfonds des Kaufmännischen Verbandes Schweiz	Stiftung
3289	Stiftung für das Tier im Recht	Stiftung
2576	Verkehrsclub der Schweiz, Sektion Bern	Verein
2013	ECO SWISS	Verein
2583	Schweizerische Sozialpartner-Stiftung für die Auffangeinrichtung gemäss Artikel 60 BVG (Stiftung Auffangeinrichtung BVG)	Stiftung
2566	Städtische Gesundheitsdienste Zürich	Staatlich
3311	Grand Théâtre de Genève	Oeffentlich-rechtlich
3332	Referendumskomitee "Nein zu diesem Fortpflanzungsmedizingesetz"	Verein
3362	Antonie Deusser-Stiftung	Stiftung
3383	öbu - Der Verband für nachhaltiges Wirtschaften	Verein
3409	Fastenaktion, Katholisches Hilfswerk Schweiz	Stiftung
3421	Home in Wiler AG	AG
3446	Kraftwerke Dala AG	AG
3465	Nomads Foundation	Stiftung
3497	Parlamentarische Gruppe Parlamentarians for global Action	Parlamentarische Gruppe
3491	Gönnerverein St. Josef, Oberwalliser Alters-, Pflege- und Behindertenheim	Verein
3530	Staatssekretariat für Wirtschaft	Staatlich
3603	Aargauische Vaterländische Vereinigung	Verein
3611	Sessel- und Skilifte Zuoz AG	AG
3633	HELVETIA PATRIA JEUNESSE	Stiftung
1300	swiss granum	Verein
1289	Stiftung zur Förderung des landwirtschaftlichen Bildungswesens	Stiftung
1345	SIRMED Schweizer Institut für Rettungsmedizin AG	AG
1366	Association Lire et Ecrire	Verein
1362	ParaHelp AG	AG
1408	Stiftung Praktischer Umweltschutz Schweiz Pusch	Stiftung
1340	Stiftung Verkehrshaus der Schweiz	Stiftung
1181	BF Fondation	Stiftung
1450	Walliser Obst- und Gemüsebranchenorganisation	Verein
1493	Farner Consulting AG, Zweigniederlassung Bern	AG
1516	AP Architecture Paysagère S.A.	AG
1533	IG Mineralwasser	Informelle Gruppe
1538	Barfüsser AG	AG
1575	Unia Region Aargau	Verein
1595	Noser Engineering AG (D)	AG
1619	Veuthey & Cie Lausanne S.A.	AG
1558	École polytechnique fédérale de Lausanne, EPFL	Staatlich
1657	Mieterinnen- und Mieterverband Lausanne	Verein
1669	Verband Schweizerischer Privatschulen (VSP)	Verein
1717	CARITAS VAUD	Verein
1728	Crèche des P'tits-Flocons	Verein
1757	Essity Switzerland AG	AG
1772	30. Aargauer Kantonalschützenfest 2017	Verein
1803	Landwirtschaftliche Kreditgenossenschaft Graubünden	Genossenschaft
1828	"Angestellte Schweiz" (Verband Schweizerischer Angestelltenvereine)	Verein
1857	McDonald's Suisse Restaurants Sàrl	GmbH
1859	Patronfonds	Verein
1893	GT Consulting GmbH in Liquidation	GmbH
1923	Kanton Neuenburg	Staatlich
1932	Selecta AG	AG
1951	Helvetische Bank AG	AG
1993	Grischelectra AG	AG
2031	"RON" Anlage-Aktiengesellschaft	AG
2050	Aeulihof AG	AG
2062	Sport-Toto-Gesellschaft in Liquidation	Verein
2066	Schweizerische bäuerliche Bürgschaftsgenossenschaft	Genossenschaft
2120	Dachverband für offene Arbeit mit Kindern in der Stadt Bern	Verein
2123	Swisscable,  Verband für Kommunikationsnetze	Verein
2127	Jagd und Biodiversität	Parlamentarische Gruppe
2138	FORUM MONDIAL DE L'ECONOMIE	Stiftung
2179	Transport	Parlamentarische Gruppe
2227	Grünliberale Partei Schweiz	Verein
2208	furrerhugi.holding ag	AG
2274	Schweizerisches Arbeiterhilfswerk SAH Waadt	Verein
2281	Reuss Private AG	AG
2333	SUCHT SCHWEIZ	Stiftung
2369	Westschweizer Verkehrsdirektoren-Konferenz (CTSO)	Staatlich
2349	Stiftung Luzern hilft	Stiftung
2355	COMPAGNIE FONCIERE DU LEMAN SA	AG
2406	Pro Patria Schweizerische Bundesfeierspende	Stiftung
2460	Association slowUp Jura	Verein
2470	Swiss Fibre Net AG	AG
2508	Associazione Carlo Cattaneo	Verein
2482	Unterstützungsfonds des Schweizerischen Anwaltsverbandes	Stiftung
2489	Dr. oec. publ. Alfred Rey GmbH in Liquidation	GmbH
2533	Eidgenössische Kommission für die Alters-, Hinterlassenen- und Invalidenversicherung	Ausserparlamentarische Kommission
2687	Bracher und Partner Totalunternehmung AG	AG
2653	Union des indépendants (UDI)	Verein
2668	Interessengemeinschaft Musikinstrumentenbauer (IGMIB)	Verein
2630	Do it Service AG	AG
2699	Genossenschaft M+S Bauen und Wohnen	Genossenschaft
2766	Ernst Wilhelm Meier-Stiftung	Stiftung
2778	Fondazione Dazio Grande	Stiftung
2819	Advantis Versicherungsberatung AG	AG
2796	Allmend-Schützen Udligenswil	Verein
2806	SVSMF Sektion Luzern	Verein
2827	Landwirtschaftsbetrieb Bulliard-Marbach	Einzelunternehmen
2883	Komitee "Bürgerliche gegen zweite Röhre"	Informelle Gruppe
2849	SFH Société fribourgeoise de l'habitat SA	AG
2861	Association pour le Bois de Chênes de Genolier (ABCG)	Verein
2917	Second@s Plus Basel	Verein
2973	Assista Protection juridique SA	AG
2952	Aarg. Kulturstiftung Pro Argovia	Stiftung
2985	Schweizerische Volkspartei Bubendorf	Verein
2994	Liga der Baselbieter Stromkunden	Verein
3048	CIMAL SA	AG
3100	Hess Management AG	AG
3102	GFG Gesellschaft für Grundeigentum AG	AG
3026	Benevol St. Gallen	Stiftung
1779	Tetra Pak (Suisse) SA	AG
3200	Home Les Crêtes	Stiftung
3189	dotBase solutions informatiques SA	AG
3191	Pic-Pic Promotion SA, en liquidation	AG
3254	Qualifizierendes Arbeitsmarktprogramm OPRA	Verein
3264	Autoeinstellhalle Waisenhausplatz AG	AG
3285	Raiffeisenbank Yberg Genossenschaft	Genossenschaft
3053	Perrin Frères SA	AG
2562	STB Leichtathletik	Verein
2591	Hauseigentümerverband Basel-Stadt	Verein
2567	Genossenschaft Glarner Krankenversicherung	Genossenschaft
3310	SWIPRA	Stiftung
3329	TearFund Schweiz	Verein
3359	Fondation Casino Barrière de Montreux	Stiftung
3387	FACEME: Fondation accueil collectif de la petite enfance de Montreux et environs	Stiftung
3398	EMS-CHEMIE AG	AG
3422	Lauchernalp Bergbahnen AG	AG
3439	Personalfürsorgefonds der Industrie- und Handelskammer Zentralschweiz	Stiftung
3466	Le Réseau	Verein
3476	Pro Velo Region Baden	Verein
3505	Ehemaligenverein Jungwacht Blauring Rütihof	Verein
3555	Communauté d'études pour l'aménagement du territoire	Staatlich
3578	Offiziersgesellschaft Burgdorf	Verein
3613	Kantonaler Gewerbeverband St. Gallen (KGV)	Verein
3629	SAV Seetalensis	Verein
3645	Kraftwerk Birsfelden AG	AG
3661	Condira AG	AG
3677	Sempachersee Tourismus	Verein
1306	JardinSuisse, Unternehmerverband Gärtner Schweiz	Verein
1342	Verein Luzerner Wanderwege	Verein
1351	Schweizer UNESCO-Kommission - Frühkindliche Bildung in der Schweiz	Ausserparlamentarische Kommission
1361	Hotel Sempachersee AG	AG
1389	Suisse Eole	Verein
1410	Verein Swiss Recycling	Verein
1428	International Social Service	Verein
956	Luzerner Kantonsspital AG	AG
1470	USIC-Stiftung	Stiftung
1469	Schweizerische Vereinigung Beratender Ingenieurunternehmungen (usic)	Verein
1501	Tourismus Pool Schweiz	Einfache Gesellschaft
1534	Murith-Multiwatt S.A.	AG
1560	Agroscope	Staatlich
1578	Natur- und Vogelschutzverein Obersiggenthal	Verein
1588	Schutzverband der Bevölkerung um den Flughafen Basel-Mülhausen	Verein
1631	Caisse de pension VAUDOISE ASSURANCES	Stiftung
1642	Fondation Tissot pour la promotion de l'Economie	Stiftung
1681	Vereinigung der privaten Aktiengesellschaften	Verein
1703	Schweizer Tierschutz STS	Verein
1723	Maison Hospitalière du Grand-Saint-Bernard	Verein
1751	Sport	Parlamentarische Gruppe
1771	Lignum Holzwirtschaft Schweiz	Verein
1790	Asia Pacific Enterprise Development Research Institute	AG
1813	Fonds de solidarité pour la libération sociale dans le tiers monde, Solifonds	Stiftung
1838	Exit	Verein
1851	Glasfasernetz Schweiz	Parlamentarische Gruppe
1898	Volkswirtschaftsdirektion Uri	Staatlich
1921	Olma Messen St.Gallen AG	AG
1931	British American Tobacco International Limited in Liquidation	AG
1968	Volkshaus AG Bern	AG
1976	Schweizerischer Anwaltsverband	Verein
1995	Lazzarini Beteiligungs AG	AG
2041	Prodiga AG	AG
2053	Galledia Print AG	AG
2040	Pris AG in Liquidation	AG
2116	Autorinnen und Autoren der Schweiz, AdS	Verein
2121	Pro Velo Bern	Verein
2129	Schweizer Rindviehproduzenten	Verein
2174	Pflegezentrum Barmelweid AG	AG
2221	St. Gallischer Kantonalschützenverband	Verein
2249	Bodenseerat	Verein
2203	Kanton Bern	Staatlich
2260	Rheintal Messe und Event AG	AG
2268	KM KONSULTA GmbH	GmbH
2288	Caritas Jura	Verein
2341	Romande Energie SA	AG
2298	Die Mitte Luzern	Verein
2304	Ausgleichskasse AHV Kanton Luzern	Oeffentlich-rechtlich
2452	Syndicat des employés genevois (SEGE)	Verein
2414	Eidgenössischer Armbrustschützenverband EASV	Verein
2502	ETC Exclusive Travel Consulting SA	AG
2510	FDP.Die Liberalen Frauen Schweiz	Verein
2481	Pensionskasse Schweizerischer Anwaltsverband (PK SAV)	Stiftung
2520	Regionalplanungsgruppe Espace Solothurn und Umgebung	Verein
2444	Schweizerischer Spirituosenverband	Verein
2603	Genossenschaft Swiss Telecom, Fachverband für professionelle Kommunikationslösungen in Liquidation	Genossenschaft
2611	Servizio cure a domicilio del Luganese - SCuDo	Verein
2670	KleinKunst Schweiz	Verein
2680	savoirsuisse	Informelle Gruppe
2698	Genossenschaft TABEO Langenthal	Genossenschaft
2708	Arbeitsgemeinschaft Schweizerischer Rinderzüchter (ASR) Genossenschaft	Genossenschaft
2773	Hauseigentümerverband Zürich	Verein
2785	Gewerbeverein Altstetten-Grünau	Verein
2820	FIALA Risiko- und Chancenmanagement - Öffentlichkeitsarbeit	Einzelunternehmen
2804	Gemischter Chor Obernau	Verein
2832	Swiss Medical Network Hospitals SA	AG
2886	AJS ingénieurs civils SA	AG
2902	Conservatoire de l'Ouest Vaudois (COV)	Stiftung
2906	Nie wieder Atomkraftwerke - NWA Aargau	Verein
2868	Association du site didactique des énéergies renouvelables de Leysin	Verein
2935	Hauseigentümerverband Linthgebiet	Verein
2947	Burgherr Holding AG	AG
3004	GastroNeuchâtel	Verein
2990	Lions Club Wildenstein	Verein
3011	Synova S.A.	AG
3015	Gemeinde Zollikofen	Staatlich
3019	GUT GROSS & PARTNER AG	AG
3159	BERNbilingue - Freunde des Berner Jura	Verein
3076	ARDA - Aigle Région	Verein
3188	m3 REAL ESTATE SA	AG
3177	Unternehmergruppe Wettbewerbsfähigkeit	Verein
3215	Energie Oberkirch AG	AG
3251	Schweizerische Volkspartei Distrikt Glâne	Verein
3233	CODHA Coopérative de l'habitat associatif	Genossenschaft
3280	Fondation CH2048	Stiftung
3181	Association Suisse-Birmanie	Verein
2561	Flusswelle Bern	Verein
3061	Operation Libero	Verein
3291	PolyReg Allg. Selbstregulierungs-Verein	Verein
3305	Komitee JA zur Ausschaffungsinitiative	Informelle Gruppe
3341	Sozialdemokratische Partei Kanton Zürich	Verein
3365	Interessengemeinschaft Schweiz-Zweiter Weltkrieg	Verein
3371	Schweizerische Volkspartei Bezirk Baden	Verein
3389	Etoiles de Noël	Stiftung
3381	Schweizerisches Institut für Banken und Finanzen der Universität St.Gallen	Staatlich
3404	Sans-Papiers Anlaufstelle Zürich SPAZ	Verein
3451	Stiftung Schloss Leuk	Stiftung
3482	OK Eidgenössisches Musikfest 2016	Informelle Gruppe
3516	Zamt & Zunder	Verein
3538	Hauseigentümerverband Uster	Verein
3575	EXPERTsuisse AG	AG
3591	Bäuerliches Zentrum Schweiz	Verein
3614	LC Turicum	Verein
3596	zubischuhe.ch AG	AG
3587	Männerchor Limpach-Mülchi	Verein
3652	Basler Spendenparlament	Verein
1314	Qualiservice GmbH	GmbH
1322	JJM Participations SA	AG
1383	Amis du Sinfonietta	Verein
1337	Luzerner Kantonalschuetzenverein	Verein
1422	Käsereigenossenschaft Riggisberg	Genossenschaft
1443	Walliser Schiessport Verband (WSSV)	Verein
1457	Conseil du Léman	Staatlich
1487	Société de Promotion des Restoroutes Valaisans SA	AG
1506	Stiftung für angepasste Technologie und Sozialökologie	Stiftung
1529	Schweizerische Alpine Mittelschule Davos (SAMD)	Stiftung
1548	Schweizerischer Energierat	Verein
1569	Handel Schweiz	Verein
1596	Allianz Pro Limmattalbahn	Verein
1616	Evéquoz SA	AG
1637	Implenia AG	AG
1662	Association NiceFuture	Verein
1684	Generation Espace	Verein
1708	Wirtschaftsfrauen Schweiz	Verein
1726	Fondation Institut International des Droits de l'Enfant	Stiftung
1750	Bundeshaus-Band	Parlamentarische Gruppe
1770	Aargauischer Gewerbeverband	Verein
1791	Banque Cantonale Vaudoise	Oeffentlich-rechtlich
1814	Movendo - Das Bildungsinstitut der Gewerkschaften	Verein
1853	Inselspital-Stiftung	Stiftung
1889	Schweiz - Armenien	Parlamentarische Freundschaftsgruppe
1916	HULFTEGG Finanz- und Verwaltungs AG	AG
1918	St. Galler Bauernverband	Verein
1969	Freienhof Thun AG	AG
1965	ORIFLAME COSMETICS S.A., à Luxembourg, succursale de Fribourg	AG
2019	Stiftung Casty-Buchmann, Chur/Masans	Stiftung
2044	KWD Kraftwerk Doppelpower AG	AG
2058	Stiftung für eine nachhaltige Ernährung durch die schweizerische Landwirtschaft	Stiftung
2080	Eniwa Kraftwerk AG	AG
2119	GEM Groupement des Entreprises Multinationales	Verein
2143	Patria Genossenschaft	Genossenschaft
2163	Coopérative d'habitation LES LIBELLULES	Genossenschaft
2156	Parlamentarische Gruppe Genuss	Parlamentarische Gruppe
2220	Schweizer Dachverband Lesen und Schreiben	Verein
2196	SONART - Musikschaffende Schweiz	Verein
2231	Vereinigte Bibelgruppen in Schule, Universität, Beruf	Verein
2261	i+R Wohnbau AG	AG
2267	Solothurner Bauernverband	Verein
2327	polsan AG	AG
2292	Verein Artisana in Liquidation	Verein
2375	Goldbach Media (Switzerland) AG	AG
2403	Stiftung Robert und Marcelle Strüby-Fertig	Stiftung
2390	Regiobank Solothurn AG	AG
2415	Pfadibewegung Schweiz	Parlamentarische Gruppe
2416	Psychische Gesundheit	Parlamentarische Gruppe
2473	Société coopérative Migros Valais	Genossenschaft
2544	Conférence latine des chefs des contrôles des finances	Staatlich
2522	VSS - Verband der Schweizer Studierendenschaften	Verein
2534	Eidgenössische Kommission für die berufliche Vorsorge	Ausserparlamentarische Kommission
2645	Stiftung Tox Info Suisse	Stiftung
2612	Ente Turistico del Luganese	Oeffentlich-rechtlich
2672	Alliance Animale Suisse	Informelle Gruppe
2679	Pädagogische Hochschule Bern	Staatlich
2700	Genossenschaft Alterswohnungen bim Spycher	Genossenschaft
2707	Sunrise GmbH	GmbH
2715	Gemeinde Uetendorf	Staatlich
2727	Sparhafen Bank AG	AG
2792	Volkskultur & Volksmusik	Parlamentarische Gruppe
2748	European Association of Political Consultants (EAPC)	Verein
2830	PwC Holdings Schweiz GmbH	GmbH
2837	Gemeindeverband Region Sense	Staatlich
2848	Bulliard Développement SA	AG
2912	Optiviva Immobilien AG	AG
2966	Energie Genossenschaft Kloten in Liquidation	Genossenschaft
2975	TCS-Zentrum Aargau AG	AG
2982	Paul Börlin-Luder-Stiftung	Stiftung
3036	Lockheed Martin Corporation	AG
3043	Winterhilfe Rüthi	Verein
3070	Homosexuelle Arbeitsgruppen Bern	Verein
3126	SwissFoundations - Verband der Schweizer Förderstiftungen	Verein
3023	Soziale Dienste Oberes Rheintal	Staatlich
3027	Verein St. Galler Rheintal	Verein
3078	Association pour le Château d'Aigle	Verein
3202	Fondation Sarah Oberson	Stiftung
3134	Kantonale urnerische Winkelriedstiftung	Stiftung
3245	HWZ Hochschule für Wirtschaft Zürich AG	AG
3256	Lebensraum Schweiz ohne Grossraubtiere	Verein
3277	FESTIVAL INTERNAZIONALE DEL FILM DI LOCARNO	Verein
3052	Holdigaz SA	AG
3062	Stiftung The Spirit of Bern	Stiftung
2590	Olio Pizzicantò GmbH	GmbH
3222	Toni Schillig-Stiftung	Stiftung
3294	Schweizerische Kriminalistische Gesellschaft	Verein
3318	Menschenrechte	Parlamentarische Gruppe
3350	Genossenschaft Chornlade	Genossenschaft
3324	Sozialvernetzte Lebensgemeinschaft SLG	Verein
3391	FONDATION DE LA CONFRERIE DES VIGNERONS DE VEVEY	Stiftung
3411	Jeunesse de Coppet	Verein
3424	Nicromet GmbH in Liq.	GmbH
3448	PRORELL AG	AG
3456	Stiftung Oberwallis für Kinder unserer Welt	Stiftung
3490	LIVOR AG	AG
3492	Verein Leuk Tourismus	Verein
3529	Gesellschaft Eintracht Luzern	Verein
3602	Kaeser, Glarner & Partner	KG
3615	Freunde der FDP	Verein
3636	Rädlibach GmbH	GmbH
3547	SymbioSwiss Pte Ltd Singapore	GmbH
3658	Green Innovation Tower AG	AG
3458	Kirchenchor St. Jospeh Leuk	Staatlich
3691	Stiftung Vier-Quellen-Weg im Gotthardmassiv	Stiftung
3714	ProEnfance	Verein
3737	FriedensFrauen Weltweit	Verein
3766	Interlaken Classics	Verein
2690	aardeplan AG	AG
2667	Grand Prix von Bern (GP Bern)	Verein
2628	Calandawind AG	AG
2682	Bernisch Kantonaler Fischerei-Verband BKFV	Verein
2768	Spross-Holding AG	AG
2776	Stiftung für die Lauterkeit in der kommerziellen Kommunikation	Stiftung
2786	Stiftung Egger-Looser	Stiftung
2738	Verein e-mobil Züri	Verein
2825	Verein zum Schutz des landwirtschaftlichen Eigentums (VSLG)	Verein
2880	LYSOFT SA	AG
2885	Stiftung UFWIND	Stiftung
2847	La Méridienne Fribourg S.A.	AG
2909	Immobiliengesellschaft Moserstrasse 24 AG	AG
2875	Nova Energie GmbH	GmbH
2972	Schweizer Jugendfilmtage	Verein
3002	Fondation Général Henri Guisan	Stiftung
2986	Gewerbe- und Industrieverein (GIV) Bubendorf und Umgebung	Verein
2965	Dachverband Fluglärmschutz	Verein
3117	Rotary Club Freiamt	Verein
3016	C and E GmbH	GmbH
3149	Bauwerk Group AG	AG
3107	Schweizerische Volkspartei Schwarzbubenland	Verein
3112	Rotary Club Angenstein	Informelle Gruppe
3089	Fondation Béjart Ballet Lausanne	Stiftung
3094	World Union of Olympic Cities	Verein
3029	Trägerverein Integrationsprojekte St. Gallen	Verein
3255	Lebensraum Wallis ohne Grossraubtiere	Verein
3272	Bildungsfonds des KV Schweiz	Stiftung
3058	Fondation Chablaisienne d'Aide à l'Insertion	Stiftung
3055	Transports Publics du Chablais SA	AG
2580	Kulturstiftung des SGB	Stiftung
3067	Zuger Pensionskasse	Oeffentlich-rechtlich
3302	Association Bénévoles Valais-Wallis	Verein
3322	Alumni-Organisation der medizinischen Fakultät der Universität Zürich	Verein
3340	Stiftung Brunnadere-Huus	Stiftung
3367	Fondation du Château de Chillon	Stiftung
3393	Fondation de la Saison culturelle de Montreux	Stiftung
3385	FONDATION CLAUDE NOBS	Stiftung
3430	ACS Sektion Zürich	Verein
3443	Verein Dampferfreunde Vierwaldstättersee	Verein
3472	Gemeinde Reconvilier	Staatlich
3498	Gruppe für die Beziehungen zum kurdischen Volk	Parlamentarische Gruppe
3534	Bruno Walliser Kaminfeger AG	AG
3556	Bau-, Planungs- und Umweltdirektoren-Konferenz	Staatlich
3579	Schützengesellschaft Mülchi	Verein
3592	Schweizerische Volkspartei Herisau	Verein
3545	ProMobil, Zürcher Stiftung für Behindertentransporte	Stiftung
3649	Wohlfahrts-Stiftung Gmür & Co AG	Stiftung
3669	Universitätsverein Luzern	Verein
3654	Verein für Kinderbetreuung Basel	Verein
3696	Ärztekammer FMH	Verein
3726	Stiftung SALLE MODULABLE in Liquidation	Stiftung
3747	Dachverband Regenbogenfamilien	Verein
3777	Forum Helveticum	Verein
3806	Roche Diagnostics International AG	AG
3825	Syntex Pharm AG	AG
3845	Solar Agentur Schweiz	Verein
3897	Solfor SA	AG
3917	Stiftung Zürcher Sprachheilschule Unterägeri	Stiftung
3928	Studerus und Partner AG	AG
3955	Sozialdemokratische Partei Kanton Schaffhausen	Verein
3972	Plattform Agrotreibstoffe	Verein
3816	Freunde von Phelophepa-Stiftung	Stiftung
3989	BioFuels Schweiz - Verband der schweizerischen Biotreibstoffindustrie	Verein
4019	ASSOCIATION ROMANDE DES INTERMEDIAIRES FINANCIERS (ARIF)	Verein
4033	ELEKTROLINK AG	AG
4039	Gönnerverein schaffhauser az	Verein
4082	FHM-Network	Informelle Gruppe
4109	Verband Thurgauer Landwirtschaft (VTL)	Verein
4129	Ersatzkasse gemäss dem Bundesgesetz vom 20. März 1981 über die Unfallversicherung	Stiftung
4145	Verein Kunst + Politik	Verein
4162	Eidgenössisches Justiz- und Polizeidepartement	Staatlich
4179	AWEPA Gruppe Schweiz	Parlamentarische Gruppe
4197	Part Time Optimierung	Verein
4218	eSenioren GmbH	GmbH
4249	Pro Aequalitate	Verein
4263	Mensa Switzerland	Verein
4268	HSO Wirtschaftsschule Schweiz AG	AG
4316	Piraten ohne Grenzen	Verein
4302	The european alliance of eu-critical movements	Verein
4349	Lido-F&B SA	AG
4358	Stiftung für Naturschutz und Wild	Stiftung
4381	Azienda Pozzo Prà Tiro	Informelle Gruppe
4399	Stiftung Kulturraum Ruswil	Stiftung
4438	Schweizerischer Verband der Friedensrichter und Vermittler	Verein
4459	Zentrum für Kieferorthopädie Winterthur	Einzelunternehmen
4471	Hausverein Zürich	Verein
4494	ChristNet	Verein
4517	SWICA Krankenversicherung AG	AG
4540	Schweizerische Gesellschaft für Hydrologie und Limnologie	Verein
4562	Roche Myanmar Company Ltd.	GmbH
4573	BIOMILL AG in Liquidation	AG
4608	Bauernverband Uri	Verein
4646	SSIB Swiss School for International Business AG	AG
4659	Swissgenetics Genossenschaft	Genossenschaft
4679	Schweizerische Landjugendvereinigung	Verein
4729	Fédération de l'industrie horlogère suisse FH	Verein
4739	Eidgenössische Zollverwaltung	Staatlich
4747	Haute école Neuchâtel Berne Jura Arc	Staatlich
4797	Automobil Club der Schweiz, Sektion St. Gallen / Appenzell	Verein
4704	Serco Landtechnik AG	AG
4811	Speedparking Lucente	Einzelunternehmen
4840	Handelskammer und Arbeitgebervereinigung Winterthur	Verein
4862	Schweizer Reise-Verband, SRV	Verein
4876	SWISSCHAM - Verband Schweizerischer Aussenwirtschaftskammern	Verein
4904	Experimentierwerkstatt für Kinder	Einzelunternehmen
2660	Association des Amis et des Anciens des Rives du Rhône	Verein
2622	Sunrise Communications AG	AG
2632	PMR Handels GmbH	GmbH
2683	Stiftung pro Fisch und Wasser, PF+W	Stiftung
2710	Stiftung für Alterswohnungen in der Region Koppigen	Stiftung
2716	Swiss Red-Holstein	Verein
2730	Steiner Mühle AG	AG
2742	Stadt Genf	Staatlich
2746	Institution genevoise de maintien à domicile	Oeffentlich-rechtlich
2829	PwC Strategyand (Switzerland) GmbH	GmbH
2838	Arbeitsgemeinschaft für Wirtschaft und Gesellschaft (AWG) - Deutschfreiburg	Verein
2901	Chambre vaudoise immobilière	Verein
2855	Mehrsprachigkeit CH	Parlamentarische Gruppe
2914	Städtepartnerschaft Basel-Van	Verein
2934	Energieallianz Linth	Verein
3001	Caisse interprofessionnelle neuchâteloise de compensation pour allocations familiales "Cinalfa", Société coopérative	Genossenschaft
3003	Arbeitgeberverband der Schweizer Uhrenindustrie	Verein
2991	Freunde Schloss Wildenstein	Verein
3046	Caisse intercommunale de pensions	Oeffentlich-rechtlich
3014	Nordwestschweizer Regierungskonferenz	Verein
3020	The FORUM ENGELBERG Prize Award Foundation	Stiftung
3025	Holzmarkt Ostschweiz AG	AG
3169	Biopôle SA	AG
3203	Stiftung kmuNEXT in Liquidation	Stiftung
3093	Fondation Festival de la Cité	Stiftung
3227	Vereinigung des Kantonalen Berufsbildungszentrums Freiburg	Verein
3253	Stiftung Seniorenzentrum Naters	Stiftung
3267	Projektorganisation Entwicklungsschwerpunkt Wankdorf	Informelle Gruppe
2573	Krebsforschung Schweiz	Stiftung
2558	Xenia, Fachstelle Sexarbeit	Verein
2011	Swiss-Ski Schweizerischer Skiverband	Verein
2564	Energo SA	AG
3298	Schweizerische Volkspartei Savièse	Verein
3328	angestellte bern	Verein
3342	Sozialdemokratische Partei Stadt Zürich	Verein
3321	Eidgenössische Expertenkommission für das Handelsregister	Ausserparlamentarische Kommission
3396	Emesta Holding AG	AG
3376	Credit Suisse Group AG	AG
3433	Bahnhofparking Stans AG	AG
3444	Luzern diskutiert. Forum für Politik, Wirtschaft & Gesellschaft	Verein
3473	Natur- und Vogelschutzverein Baden/Ennetbaden	Verein
3499	Parlamentarische Gruppe Naher Osten	Parlamentarische Gruppe
3522	Gemeinnützige Gesellschaft Bezirk Dielsdorf	Oeffentlich-rechtlich
3561	Rad- und Motorfahrer-Verband am Zürichsee, Oberland und Linthgebiet	Verein
3590	Personalvorsorgestiftung der Einwohnergemeinden Bolligen, Ittigen und Ostermundigen in Liquidation	Stiftung
3542	Europa Institut an der Universität Zürich	Verein
3546	STARTZENTRUM ZÜRICH Genossenschaft	Genossenschaft
3655	Schweizerische Universitätskonferenz	Oeffentlich-rechtlich
3680	Stiftung Weg der Schweiz in Liquidation	Stiftung
3616	Stiftung Josi J. Meier - Hilfe zur Selbsthilfe	Stiftung
3711	Fondation culturelle de la Fédération vaudoise des entrepreneurs	Stiftung
3727	Andermatt-Urserntal Tourismus GmbH	GmbH
3719	Hérémence Jeunesse	Verein
3767	Jungfrau Klima-Co2operation	Verein
3769	RELLER IMMOBILIEN AG	AG
3808	Roche Finanz AG	AG
3849	Schweizerische Studienstiftung Alumni	Verein
3881	A & O Administration & Organisation Gehrken	Einzelunternehmen
3914	Stiftung Winterhilfe Zug	Stiftung
3921	Private Bildung Schweiz	Verein
3932	Stiftung Zürcher Lighthouse	Stiftung
3952	Schaffhauser Jazzfestival	Verein
3979	Fussballclub Kölliken	Verein
3724	Kommission für Personalfragen des Kantons Uri	Staatlich
4008	Israelitische Kultusgemeinde Baden	Verein
4024	Klingelfuss+Cie.	KG
4057	Gewerkschaftsbund des Kantons St. Gallen	Verein
4090	Sozialdemokratische Partei Neuenburg Kanton	Verein
4099	Stiftung Fintan (Rheinau)	Stiftung
4126	Candrac	Einzelunternehmen
4106	Meili-Fonds des Verbands Thurgauer Landwirtschaft	Stiftung
4150	Réflexion Santé Suisse	Verein
4185	Musikverein Lausen	Verein
4201	Schweizer Heimatschutz SHS	Verein
4226	ARGO Stiftung für Integration von Menschen mit Behinderung in Graubünden	Stiftung
4270	Fondation compagnie Philippe Saire	Stiftung
4279	Association Pages de gauche	Verein
4314	BWO Systems AG	AG
4327	Primeo Greenpower AG	AG
4337	aventron AG	AG
4356	Schweizerische Volkspartei Andelfingen	Verein
4377	VSP Sicurezza & Automazione Sagl in liquidazione	GmbH
4402	Mineralquelle Bad Knutwil AG	AG
4418	TICINO PARCHEGGI SA	AG
4452	Gemeinnütziger Frauenverein Frauenfeld	Verein
4467	Interessengemeinschaft öffentlicher Verkehr Zürich	Verein
4490	Krebsliga Solothurn	Verein
4512	BEGA Berggaststätten AG	AG
4534	Solidaritätsnetz Ostschweiz	Verein
4556	454 Life Sciences Coorp.	GmbH
4572	SEMAG, Saat- und Pflanzgut AG	AG
4610	Bauernverband Obwalden	Verein
4628	Chambre Valaisanne d'Agriculture	Verein
4651	Philippe Zahno communications et conseils Sàrl	GmbH
4661	Verband Schweizerischer Trocknungsbetriebe	Verein
4693	CAVE DE LA CÔTE société coopérative	Genossenschaft
4710	frigemo ag	AG
4763	Kantonsspital Aarau AG	AG
4775	Schweizerischer Blinden- und Sehbehindertenverband (SBV)	Verein
4795	Automobile Club Svizzero, Sezione Ticino	Verein
4750	United Nations Interregional Crime and Justice Research Institute	Staatlich
2631	pluswert GmbH	GmbH
2701	Genossenschaft M&M am Bärg	Genossenschaft
2711	Verein Eidgenössisches Schwing- und Älplerfest 2013 Burgdorf im Emmental in Liquidation	Verein
2779	Fondazione Ticinese di soccorso (Ing. Agostino Nizzola)	Stiftung
2731	Groupe Minoteries SA	AG
2795	Estermann Life Coaching	Einzelunternehmen
2807	Schweizerische Ärztegesellschaft für Homöopathie SAHP	Verein
2755	Sparhafen Genossenschaft	Genossenschaft
2893	Schweizerische Vereinigung für Schifffahrt und Hafenwirtschaft	Verein
2852	Briegli-Park AG	AG
2908	Melaro Immobilien AG	AG
2876	Verein Energie-Information (E-Info)	Verein
2941	Sozialpädagogische Wohngruppen Speerblick	Verein
2950	Naturfreunde Baden	Verein
3006	Fondation "In Memoriam" - Section vaudoise	Stiftung
2993	SPITEX REGIO LIESTAL	Verein
3012	Swiss Newater Holding Sàrl	GmbH
3099	HESS IMMOBILIEN AG	AG
3021	Schachclub Weinfelden	Verein
3161	Netzwerk der Berner Naturpärke	Informelle Gruppe
3113	Astag Schweizerischer Nutzfahrzeugverband, Sektion Solothurn	Verein
3185	Fondation Nez Rouge	Stiftung
3205	Giovanni Giunta Bureau de conseils	Einzelunternehmen
3095	S.I. EJMA LAUSANNE S.A.	AG
3239	Association vaudoise des laborantins et laborantines	Verein
3259	Stiftung Kunst im Spital	Stiftung
3278	Stiftung Bärenpark Bern	Stiftung
2578	Bern Neu Gründen	Verein
3220	Egli + Vitali AG	AG
2593	IG Passivhaus Südostschweiz	Verein
3050	DCFI SA	AG
3314	Cercle de soutien à la rénovation du Musée d'art et d'histoire Genève	Verein
3345	Homosexuelle Arbeitsgruppen Zürich	Verein
3366	Förderverein Radio Argovia	Verein
3386	Fondation PROFA	Stiftung
3401	EMS-PATENT AG	AG
3429	Stiftung zur Palme	Stiftung
3445	Dala Finanz AG in Liquidation	AG
3468	Schweizerischer Public Relations Verband SPRV	Verein
3495	Kirchgemeinde Pfarrei St. Stephan	Staatlich
3535	MDZ Wallisellen AG, Medizinisches Diagnose-Zentrum Glatt	AG
3558	BLS Netz AG	AG
3539	Lions Club Zürcher Oberland	Verein
3584	Schweizerischer Verband für Landtechnik	Verein
3635	Stiftung BEST Art Collection Luzern	Stiftung
3641	Gmür & Co AG	AG
3651	Baobab Books	Verein
3571	Schulheim Schloss Erlach	Oeffentlich-rechtlich
3663	IFA Kongress 2015 AG in Liquidation	AG
3738	Frauenfussballrat Schweiz	Verein
3755	Cargo Forum Schweiz	Informelle Gruppe
3791	Arbeitsgemeinschaft Schweizerischer Sportämter	Verein
3809	Roche Forum Buonas AG	AG
3836	Proterroir Sàrl	GmbH
3850	Verein Lebendiges Rottal	Verein
3885	swissskills	Stiftung
3916	Stiftung Pro Libro Luzern	Stiftung
3927	Verein Schweizer Kurse für Unternehmensführung SKU	Verein
3946	Kindes- und Erwachsenenschutzbehörde der Stadt Zürich	Staatlich
3970	e+co	Einzelunternehmen
3987	Fondation des 4 Marronniers	Stiftung
3834	Fédération des caves viticoles vaudoises, société coopérative	Genossenschaft
4012	Eltan Holding GmbH	GmbH
4032	Elektroplan Buchs & Grossen AG	AG
4060	Regionales Archiv für Frauen- und Geschlechtergeschichte Ostschweiz	Verein
4075	Schweizerischer Verband der Berufsorganisationen im Gesundheitswesen	Verein
4087	Konferenz der Höheren Fachschulen Technik	Verein
4130	Stiftung für ein erweitertes Versicherungsangebot durch die Helsana	Stiftung
4146	Suisseculture sociale	Verein
4156	Swiss Helicopter Association	Verein
4136	Swiss Academy for Development, SA4D	Stiftung
4202	FSC Schweiz	Verein
4244	Verein für Prävention und Drogenfragen Zürcher Oberland	Verein
4243	Fachstelle Fehlgeburt und perinataler Kindstod	Verein
4265	Schneeberger Treuhand AG	AG
4291	PSI-Impuls	Verein
4326	Primeo Wärmeholding AG	AG
4344	Stilcolor SA	AG
4360	Associazione per la storia del movimento cattolico nel Ticino	Verein
4382	Chiasso 1945	Verein
4405	Pilatus Aircraft Service AG	AG
4445	Schweizerische Vereinigung für Führungsausbildung	Verein
4462	Hans-Peter Wüthrich Education GmbH	GmbH
4486	Gewerkschaftsbund des Kantons Solothurn	Verein
4492	Caritas Solothurn	Verein
4533	NATUME büro für natur umwelt mensch - claudia friedl	Einzelunternehmen
4551	Schweizerische Pankreasstiftung	Stiftung
4578	Pedrazzini Holding AG	AG
4594	Schweizer Studiofilm Verband SSV	Verein
4621	Bauernverband Appenzell Ausserrhoden	Verein
4645	FDP Die Liberalen Unterwallis	Verein
4666	Coopérative d'habitation EQUILIBRE	Genossenschaft
4684	ASS Société coopérative des sélectionneurs	Genossenschaft
4728	eBay International AG	AG
4748	Konferenz der Kantonalen Justiz- und Polizeidirektorinnen und -direktoren	Staatlich
4773	Parkinson Schweiz	Verein
4697	Département de l'économie et de la santé canton du jura	Staatlich
4798	ACS Sektion Luzern, Ob- und Nidwalden	Verein
4133	Sansan Versicherungen AG	AG
4826	Chambre vaudoise du commerce et de l'industrie - Association des industries vaudoises	Verein
4848	Kudelski S.A.	AG
4867	Schweizerischer Leasingverband	Verein
4885	SESK Verband der Schweizerischen Schmelzkäseindustrie	Verein
4887	Verband der Walliser Industriellen	Verein
2695	wasserstadtsolothurn AG in Liquidation	AG
2642	Hilfswerk der Evangelisch-reformierten Kirche Schweiz (HEKS)	Stiftung
2769	Spross Ga-La-Bau AG	AG
2722	RHC (Rollhockeyclub) Diessbach	Verein
2788	Bezirksgericht Zürich	Staatlich
2744	Die Mitte Genf	Verein
2824	Freiburger Tourismusverband (FTV)	Verein
2833	regio.garantie Romandie	Verein
2891	Fondation de l'Ecole hôtelière de Lausanne, EHL	Stiftung
2900	Propriétaires Services SA	AG
2928	Hauseigentümerverband Bern und Umgebung	Verein
2874	Nova Energie GmbH (Zweigniederlassung Aarau)	GmbH
2940	Zürichsee Landschaftsschutz	Verein
2951	Quartierverein Altstadt Baden	Verein
2958	Verband der Krankenmobilien-Magazine der Stadt Bern	Verein
2963	Jodlerfest Nordwestschweiz 2016	Verein
3096	S.I. Conservatoire Lausanne S.A.	AG
3143	Forces Motrices Hongrin-Léman S.A. (FMHL)	AG
3155	Pro Flughafen	Verein
3164	Unterstützungskasse des Bernischen Staatspersonalverbandes BSPV	Stiftung
3131	Stiftung Gesundheitsförderung Bad Zurzach + Baden	Stiftung
3132	Seewarte Holding AG	AG
3212	TAW Holding AG	AG
3246	Sabimo AG	AG
3240	PLR Les Libéraux-Radicaux Saint-Maurice	Verein
3275	Regionalkonferenz Bern-Mittelland	Oeffentlich-rechtlich
3290	Vorsorgestiftung des Kaufmännischen Verbandes Schweiz	Stiftung
3054	Société du Gaz de la Plaine du Rhône SA	AG
3063	Fondazione Swiss Institute for Reproductive Medicine	Stiftung
3065	Konferenz der kantonalen Finanzdirektorinnen und Finanzdirektoren	Staatlich
3297	Vereinigung Cerebral Wallis	Verein
3326	Agogis	Verein
3346	Pink Cross	Verein
3336	Arbeitsgruppe "Charta zur Prävention von sexueller Ausbeutung, Missbrauch und anderen Grenzverletzungen"	Informelle Gruppe
3379	Young Leaders Alumni Foundation	Stiftung
3407	Alliance Sud	Verein
3426	SRO Selbstregulierungsorganisation des Schweizerischen Anwaltsverbandes und des Schweizerischen Notarenverbandes	Verein
3447	VARELLION Holding AG	AG
3471	Beratende Kommission für internationale Zusammenarbeit	Ausserparlamentarische Kommission
3496	Genf International	Parlamentarische Gruppe
3532	Vereinigung Pro Heidegg	Verein
3449	Valaiscom AG	AG
3605	Abwasserverband Oberengadin	Verein
3617	Stiftung Luzerner Theater	Stiftung
3634	Tourismus Forum Luzern	Verein
3647	Swisscanto Freizügigkeitsstiftung der Kantonalbanken	Stiftung
3665	Schweizerische Volkspartei Kanton Luzern	Verein
3675	STS SCHWEIZERISCHE TREUHÄNDER SCHULE AG	AG
3692	Opera Mater Christi	Stiftung
3713	Union syndicale valaisanne (USV)	Verein
3732	Batzebär	Stiftung
3764	Interessengemeinschaft Kunsthandwerk Holz	Verein
3786	ASL - Association pour la Sauvegarde du Léman	Verein
3819	Wohlfahrtsstiftung der F. Hoffmann-La Roche AG	Stiftung
3837	Mandaterre Sàrl	GmbH
3866	KPT Krankenkasse AG	AG
3887	SGAB Schweiz. Gesellschaft für angew. Berufsbildungsforschung	Verein
3892	FDP Die Liberalen Kanton Schwyz	Verein
3909	Elementa Group AG	AG
3958	Denk an mich	Stiftung
3874	Alpiq AG	AG
3858	Stiftung Schloss Jegenstorf	Stiftung
3993	Bienenzüchter Unteres Aaretal	Verein
4014	Och Holding AG	AG
4043	Naturschutzverein Hallau	Verein
4068	Wen-Do Schweiz	Verein
4076	Fachverband Sucht	Verein
4101	Schaffhauser Sommertheater	Verein
4138	Aktion für eine vernünftige Energiepolitik Schweiz AVES Sektion Zürich	Verein
4153	Camvet	Verein
4174	Rudolf Steiner Schule St.Gallen	Verein
4187	Tribunal des Prud'hommes	Staatlich
4221	Societad cooperativa promotura d'aradira Surrein-Rabius e contuorn in Liquidation	Genossenschaft
4248	Baumann Kommunikationsgestaltung	Einzelunternehmen
4264	Skiriege Zeglingen	Verein
4309	Horisberger Electronic	Einzelunternehmen
4318	EBM (Genossenschaft Elektra Birseck)	Genossenschaft
4334	Vorarlberger Freiheitliche Partei	Verein
4354	Swiss Shippers' Council	Verein
4374	GAG SUISSE SA in liquidazione	AG
4404	Tautec AG	AG
4419	FONDAZIONE PATRIZIO PATELLI	Stiftung
4455	Turf Club Frauenfeld	Verein
4469	glow. das Glattal	Verein
4493	Hälfte	Verein
4507	ea Druck AG	AG
4539	Schweizerische Vereinigung der Fischereiaufseher	Verein
4560	Roche Products (India) Pvt. Ltd.	GmbH
4581	swissuniversities	Verein
4589	JT International AG Dagmersellen	AG
4631	Chambre Jurassienne d'Agriculture	Verein
4668	Schweizerische Vereinigung für Silowirtschaft	Verein
4688	Schweizerische Vereinigung Industrie + Landwirtschaft	Verein
4733	Ricardo AG	AG
4742	Eidgenössische Institut für Metrologie	Staatlich
4765	Association Suisse des Paralysés (ASPr)	Verein
4787	VIER PFOTEN - Stiftung für Tierschutz	Stiftung
4753	Schweizerische Brotinformation	Informelle Gruppe
4806	Eni Suisse S.A.	AG
4841	Hapimag AG	AG
4858	Roland Berger International AG	AG
4882	Swissrail Industry Association	Verein
4896	Chambre Valaisanne de Commerce et d'Industrie	Verein
4908	Natur- und Vogelschutz Maur-Zumikon	Verein
4940	die CHARTA - Arbeit für Menschen mit Behinderung	Informelle Gruppe
2763	ELRAK AG	AG
2774	Sto AG	AG
2726	Hauseigentümerverband Oberrheintal	Verein
2822	Pro Juventute	Stiftung
2801	Gemeinnütziger Frauenverein Malters (GFM)	Verein
2878	Biogas Forum	Verein
2892	Schifffahrt	Parlamentarische Gruppe
2895	Zurich Film Festival	Verein
2858	Parlamentarische Gruppe MINT-Förderung als Beitrag zur Behebung des Fachkräftemangels	Parlamentarische Gruppe
2930	Schweizerische Volkspartei (SVP) des Kantons St. Gallen	Verein
2969	Obere Mühle Alterswohnungen AG	AG
2945	Burgherr Moosersäge AG	AG
3034	Zweckverband Kehrrichtverwertung Rheintal	Oeffentlich-rechtlich
3040	Sportplatzkonsortium FC/TV Rüthi	Informelle Gruppe
3047	ASSYSTEM SWITZERLAND SA	AG
3098	Hess Investment AG	AG
3127	Weltwoche Verlags AG	AG
3105	FDP Die Liberalen Thurgau	Verein
3165	Bernische Pensionskasse (BPK)	Oeffentlich-rechtlich
1839	FSKB - Fachverband der Schweizerischen Kies- und Betonindustrie	Verein
3176	Gegen Rassismus und Fremdenfeindlichkeit	Parlamentarische Gruppe
3218	SSBL Stiftung für selbstbestimmtes und begleitetes Leben	Stiftung
3252	Stiftung Jugendwohngruppe Anderledy	Stiftung
3196	Lake Geneva Prestige SA	AG
3286	Bauernvereinigung Oberiberg	Verein
2555	Unterhaltsgenossenschaft Ellikon	Genossenschaft
3064	Fondazione per l'orchestra della Svizzera Italiana (FOSI)	Stiftung
2014	Stiftung für den Freulerpalast	Stiftung
3299	Schweizerische Volkspartei Unterwallis	Verein
3325	Verband Schweizer Assistenz- und OberärztInnen, Sektion Zürich	Verein
3356	Raiffeisenbank Mischabel-Matterhorn Genossenschaft	Genossenschaft
3323	kispex Kinder-Spitex Kanton Zürich	Verein
3394	EFTEC AG	AG
3413	möglich-machen GmbH	GmbH
3434	Bergbahnen Engelberg-Trübsee-Titlis AG, BET	AG
3452	Stiftung Roggen Schweiz	Stiftung
3477	Conseil de politique sociale du Canton de Vaud	Staatlich
3518	Regensdorf	Staatlich
3537	Bank BSU Genossenschaft	Genossenschaft
3562	Cercle des dirigeants d'entreprise	Verein
3612	Camping Chapella GmbH	GmbH
3544	diabeteszürich	Verein
3646	Universität Basel	Staatlich
3643	Pensionskasse der Helvetia Versicherungen	Stiftung
3679	Lions Club Altdorf	Verein
3566	Obergericht des Kantons Zürich	Staatlich
3702	Fédération Vaudoise des entrepreneurs, société coopérative	Genossenschaft
3717	Association pour la sauvegarde du Torrent-Neuf de Savièse	Verein
3753	mundi consulting ag	AG
3774	LCH (Dachverband Lehrerinnen und Lehrer Schweiz)	Verein
3803	Roche Chemische Unternehmungen AG	AG
3792	Groupe Sida Genève	Verein
3843	WWF Kanton Bern	Verein
3912	Pfister & Netzwerk	Einzelunternehmen
3924	Aqua Alimenta	Verein
3940	KPMG AG	AG
3873	Auto-Strassenhilfen-Schweiz	Verein
3876	Gewerbeverein Rothrist	Verein
3817	F. Hoffmann-La Roche AG	AG
4010	Kolmar Group AG	AG
4025	eurogold service Zumbühl & Co. Handelsagentur	KG
4038	Evangelische Frauenhilfe Hallau	Verein
4073	Altstadtvereinigung Wil	Verein
4045	Verein Regionaler Naturpark Schaffhausen	Verein
4104	Netzwerk Migrationsrecht	Informelle Gruppe
4152	Gesellschaft Schweizer, Tierärztinnen und Tierärzte (GST)	Verein
4173	Medifilm AG	AG
4137	Gewerbeverein Seefeld	Verein
4208	Komitee für UNICEF Schweiz und Liechtenstein	Verein
4247	Frauengruppe	Parlamentarische Gruppe
4258	Eidgenössische Berufsbildungskommission	Ausserparlamentarische Kommission
4278	Association des Criminologues Aguerris et potentiels de l'Université de Lausanne	Verein
4213	Mediapulse Stiftung für Medienforschung	Stiftung
4317	Freidenker Sektion Wallis	Verein
4340	Regazzi Serramenti e Facciate SA	AG
4361	Centre intercantonal d'information sur les croyances et sur les activités des groupements à caractère spirituel, religieux ou ésotérique	Stiftung
4385	Schweizer Stiftung Farbe	Stiftung
4412	Berner Wanderwege BWW	Verein
4426	Minusgren Sagl	GmbH
4458	Gewerbliches Bildungszentrum Weinfelden	Oeffentlich-rechtlich
4472	Unternehmen Zukunft	Verein
4478	Jugend.gr	Verein
4516	SWICA Versicherungen AG	AG
4542	Verein Saiten	Verein
4564	Berufsbildung Schweiz	Verein
4591	WORLDWEBFORUM beecom AG	AG
4613	Zuger Bauernverband	Verein
4640	Mutterkuh Schweiz	Verein
4663	Schweizerische Vereinigung der Selbsteinkellernden Weinbauern	Verein
4675	Genossenschaft Ökostrom Schweiz	Genossenschaft
4718	Schweizerische Koordinations- und Fachstelle Sucht	Staatlich
4720	Schweizerischer Dachverband Stationäre Suchthilfe	Verein
4745	Institut zur Bekämpfung der Wirtschaftskriminalität	Staatlich
4791	ACS Sektion Genf	Verein
4703	Anicom AG	AG
4800	ACS Sektion Glarus	Verein
4824	Chambre de commerce, d'industrie et des services de Genève	Verein
4843	IFPI, International Federation of the Phonographic Industry	Verein
4863	Schweizer Werbe-Auftraggeberverband SWA	Verein
4884	Verband der Schweizer Druckindustrie	Verein
4914	Centre de liaison des Associations Féminines vaudoises	Verein
4930	Parlamentarische Gruppe Region Basel	Parlamentarische Gruppe
4953	Fédération des Associations de Parents d'Elèves de la Suisse Romande et du Tessin	Verein
2764	Terra Sua AG	AG
2719	aaremilch AG	AG
2784	Stiftung Zürich-Jobs	Stiftung
2740	Fondation in memoriam Comtesse Tatiana Zouboff	Stiftung
2750	Die Mitte Stadt Genf	Verein
2811	Sozialdemokratische Partei Frauen Schweiz	Verein
2839	Die Mitte Freiburg	Verein
2925	Gewerbeverband KMU der Stadt Bern	Verein
2857	Schweiz - Afrika	Parlamentarische Freundschaftsgruppe
2864	Association Ecoparc	Verein
2999	Société Anonyme Immobilière des Patinoires du Littoral Neuchâtelois	AG
2976	Touring Club Schweiz, Sektion Aargau	Verein
2954	Sozialdemokratische Partei Aargau	Verein
2992	Frauenverein Bubendorf	Verein
3068	Lions Club Schweiz-Lichtenstein	Verein
3124	AF Toscano AG	AG
3128	EGS Beteiligungen AG	AG
3073	Gay and Lesbian Sport Bern	Verein
3168	Fondation pour l'art dramatique (Centre dramatique de Lausanne)	Stiftung
3081	Union des communes vaudoises	Stiftung
3208	Burckhardt Compression Holding AG	AG
3136	Schweizerische Volkspartei Uri	Verein
3141	Zentralschweizer Regierungskonferenz	Verein
3269	Verlag SKV AG	AG
3241	Société coopérative de laiterie de Lignerolle	Genossenschaft
2575	SPOG Schweizerische Pädiatrische Onkologie Gruppe	Verein
2010	Schneesport Mittelland-Nordwestschweiz	Verein
3223	För­der­ver­ein Lu­zer­ner Volks­schulen	Verein
2571	Paul Aenishänslin Public Affairs & Communications (PAE-PAC)	Einzelunternehmen
3312	Fondation de la Maison Rousseau et de la Littérature (MRL)	Stiftung
3343	Second@s Plus Zürich	Verein
3364	Fondation de la Ville de Montreux pour l'équipement touristique	Stiftung
3378	Swiss Finance Council	Verein
3384	International Chamber of Commerce Switzerland	Verein
3423	SkiWell AG in Liquidation	AG
3440	Grüne Partei Aargau	Verein
3463	Ordre international des anysetiers	Verein
3481	Umweltwissenschaften Alumni ETH	Verein
3484	Förderverein Kinder- und Jugendtheater Kunterbunt	Verein
3523	Liberales Institut	Stiftung
3588	Verband Schweizerischer Polizeibeamter Sektion Bern-Gemeinden	Verein
3608	Schweizer Skischule Zuoz / La Punt AG	AG
3543	Rotary Club Zürich	Verein
3621	IG Arbeit	Verein
3548	Die Mitte Waadt	Verein
3667	Wabet Holding AG	AG
3569	Fondazione movingAlps	Stiftung
3710	ProFonds	Stiftung
3734	tilia Stiftung für Langzeitpflege	Stiftung
3746	Frauenzentrale des Kantons Bern (FZBE)	Verein
3790	Platôdart	Verein
3820	Stiftung der F. Hoffmann-La Roche AG für Mitarbeiter-Gewinnbeteiligung als Ergänzung der beruflichen Vorsorge in Liquidation	Stiftung
3839	Formapro Sàrl	GmbH
3855	Quality Alliance Eco-Drive	Verein
3898	Montres Journe SA	AG
3905	KLV Verlag AG	AG
3931	ARWA IMMOBILIEN AG	AG
3948	Verein Sexuelle Gesundheit Zürich - Fachstelle für sexuelle Gesundheit	Verein
3978	Turnverein Kölliken	Verein
3860	Heimatland Verlag AG	AG
4001	kw la soupe GmbH in Liquidation	GmbH
4027	Zuger Wirtschaftskammer	Verein
4035	Kantonales Arbeitersekretariat Schaffhausen	Verein
4040	Kaufmännischer Verband Schaffhausen (KVS)	Verein
4083	Lions Club Herrliberg	Verein
4088	Union der Christlichsozialen Schweiz	Verein
4117	HaarRaum Ananiadis-Bucher	Einzelunternehmen
4120	Piratenpartei Kanton Bern	Verein
4172	i-medify AG	AG
4134	Helsana Versicherungen AG	AG
4214	Anneliese Rothenberger Stiftung	Stiftung
4227	Fundaziun Medias Rumantschas FMR	Stiftung
4262	Cercle Suisse des Administratrices	Verein
4288	Beratendes Organ für Fragen der Klimaänderung	Staatlich
4303	IG Öffentlicher Verkehr Wil	Verein
4328	Primeo Management AG	AG
4345	Marcmetal SA	AG
4372	Bo-schi SA	AG
4394	Genossenschaft exposee - messe am see in Liquidation	Genossenschaft
4410	Die Mitte Bern	Verein
4428	Zürich Versicherungs-Gesellschaft AG	AG
4461	KMU Frauen Thurgau	Verein
4479	Klibühni	Verein
4505	Kantonal-Bernischer Baumeisterverband	Verein
4520	Luftseilbahn Kandersteg-Allmenalp AG	AG
4531	WWF St. Gallen	Verein
4546	Pro Velo Region Spiez	Verein
4587	Swiss Cigarette	Verein
4619	Swisspearl Schweiz AG	AG
4637	Verbandsgenossenschaft für Simmentaler Alpfleckviehzucht und Alpwirtschaft (VSA)	Genossenschaft
4653	DigiMig Operations GmbH in Liquidation	GmbH
4583	Comité rail-route Vaud-Genève	Verein
4690	LANDI Centre Broye Société coopérative	Genossenschaft
4732	MCH Group AG	AG
4761	Centre hospitalier universitaire vaudois	Staatlich
4774	Schweizerischer Blindenbund Selbsthilfe blinder und sehbehinderter Menschen (SBb)	Verein
4792	ACS Sektion Wallis	Verein
4725	Verein Schweizerischer Gymnasiallehrerinnen und -lehrer	Verein
4807	Migrol AG	AG
4810	Sixt rent-a-car AG	AG
4838	Handels- und Industrieverein des Kantons Schwyz	Verein
4881	Swissplay - Verband der schweizerischen Spielautomaten Branche	Verein
4901	Eidgenössische Kommission für die Harmonisierung der direkten Steuern des Bundes, der Kantone und der Gemeinden	Ausserparlamentarische Kommission
4916	Genossenschaft REGI Die Neue	Genossenschaft
4938	Patronaler Fonds der Pro Senectute beider Basel	Stiftung
2813	Regionales Pflegezentrum Baden AG	AG
2717	Hauseigentümerverband Burgdorf und Trachselwald	Verein
2728	Schweizerische Volkspartei Kanton Zürich	Verein
2739	Genossenschaft Heimat- und Ortsmuseum Wiedikon	Genossenschaft
2747	CABINET PRIVE DE CONSEILS SA	AG
2757	E&P Immo AG	AG
2841	Platform Networking for Jobs	Verein
2924	Forum für die Integration der Migrantinnen und Migranten	Verein
2904	Commune de Genolier	Staatlich
2916	Junge Schweizerische Volkspartei Kanton Bern	Verein
2937	Schützenverein Jona	Verein
2979	Burkart Immobilien AG in Liquidation	AG
2984	Sollberger Maler AG	AG
2961	Stadt Kloten	Staatlich
3116	Kantonale Schule für Berufsbildung	Staatlich
3125	Ernst Göhner Stiftung	Stiftung
3152	SwissTech Watch Components SA	AG
3106	FDP Die Liberalen Bezirk Arbon	Verein
3028	Suchtberatung Oberes Rheintal	Verein
3187	VALMAR SA	AG
3174	Association Cluster sport international	Verein
3214	Allgemeiner Wohlfahrtsfonds der Kistler Instrumente Aktiengesellschaft, Winterthur	Stiftung
3244	OUI au parc éolien Sur Grati	Verein
3265	Einstellhalle Wankdorf-Allmend AG	AG
3276	Vereinigung für Bern	Verein
2556	Alterszentrum im Geeren	Oeffentlich-rechtlich
3219	Interessengemeinschaft Volkskultur	Verein
2009	Club 100 des Nordwestschweizerischen Skiverbands	Verein
2572	Schweizerische Arbeitsgemeinschaft für Klinische Krebsforschung SAKK	Verein
3309	SWIPRA Services AG	AG
3327	INSOS Schweiz	Verein
3351	Stiftung Wohnungen für kinderreiche Familien (SWkF)	Oeffentlich-rechtlich
3372	Montreux-Vevey Tourisme	Verein
3397	EMS-CHEMIE (Produktion) AG	AG
3414	Asien-Orient-Institut der Universität Zürich	Oeffentlich-rechtlich
3427	Sportclub Lötschental	Verein
3459	Kirchenchor St. Theresia Susten	Verein
3488	Grüne Partei Bezirk Baden	Verein
3512	Kanu-Club Baden-Wettingen	Verein
3551	contrust finance ag	AG
3487	Verein Royal Baden	Verein
3610	Interessengemeinschaft Tourismus Graubünden	Verein
3625	Arbeitsgruppe "Freiheit und Eigenverantwortung des Versicherten in der 2. Säule"	Informelle Gruppe
3620	Förderverein Luzerner Hochschulseelsorge	Verein
3644	Vorsorgefinanzierungsstiftung der Helvetia Versicherungen	Stiftung
3666	SIMT Vertriebs- und Beteiligungs AG	AG
3653	Automobil Club der Schweiz, Sektion beider Basel	Verein
3693	Associazione "Il Bianconiglio"	Verein
3709	Fondation Ecole de la construction	Stiftung
3745	Turnverband Bern-Mittelland	Verein
3765	Dialog5 GmbH	GmbH
3796	Radio Emme AG	AG
3810	Roche Glycart AG	AG
3838	Proconseil Sàrl	GmbH
3868	Genossenschaft KPT	Genossenschaft
3728	Textbüro Holz GmbH	GmbH
3903	Institut Montana Zugerberg AG	AG
3926	Devaux & Rohrbach GmbH	GmbH
3959	Stiftung zur Förderung sozialwissenschaftlicher Forschung über die Weltgesellschaft	Stiftung
3976	Pro Senectute Schweiz	Verein
3991	gasmobil AG	AG
3883	Graduate Institute of International and Development Studies Geneva	Oeffentlich-rechtlich
4013	Burwill Commodities AG in Liquidation	AG
4034	Klar! Schweiz	Verein
4066	Openair rockamweier	Verein
4091	Vereinigung Schweizerischer Verbandssekretäre	Verein
4110	Profi-Lait	Informelle Gruppe
4115	Berufsbildungskommission Kanton Nidwalden	Ausserparlamentarische Kommission
4143	GDFE GmbH	GmbH
4163	Eidgenössisches Departement des Innern	Staatlich
4184	crstl GmbH	GmbH
4200	Eglise évangélique réformée du canton de Vaud	Verein
4223	Verein ibW Höhere Fachschule Südostschweiz	Verein
4241	Kibesuisse	Verein
4281	Fondation du Centre Suisse de Toxicologie Humaine Appliquée - SCAHT	Stiftung
4294	VUE Verein für umweltgerechte Energie	Verein
4307	Druckerei Horisberger AG	AG
4332	Werbeagentur Neuber AG	AG
4350	Repi SA	AG
4367	MINOVIA AG in liquidazione	AG
4397	Luzerner Bäuerinnen- und Bauernverband	Verein
4423	Rotary Club Locarno	Verein
4451	Hauseigentümerverband Frauenfeld	Verein
4433	Vereinigung Weltföderalisten Schweiz	Verein
4488	SEV-GATA	Verein
4508	Die freien Schweizer Brauereien	Verein
4535	Verein Freunde Schloss Werdenberg	Verein
4557	Intermune Inc.	AG
4577	Isler & Pedrazzini AG	AG
4552	Fasnachtsclioque Alti Richtig 1926	Verein
4632	Pro Natura Aargau - Aargauischer Bund für Naturschutz	Verein
4612	Glarner Bauernverband	Verein
4598	Die Mitte 60+	Verein
4727	DeinDeal AG	AG
4741	Bundesamt für Polizei	Staatlich
4746	Haute école de gestion arc	Staatlich
4786	Schweizerischer Demeter-Verband	Verein
4758	Verein Schweizer Wanderimker	Verein
4808	Pirelli Tyre (Suisse) SA	AG
4836	Verband Schweizerischer Glaceproduzenten	Informelle Gruppe
4851	McKinsey & Company, Inc. Switzerland, Wilmington, Zurich Branch	AG
4873	Swiss Association of Trust Companies	Verein
4895	Volkswirtschaftsdirektion des Kantons Zürich	Staatlich
4918	skat foundation	Stiftung
4931	Schweiz - Japan	Parlamentarische Freundschaftsgruppe
4958	Raumentwicklung	Parlamentarische Gruppe
2734	TP Publicité SA, en liquidation	AG
2799	Schweizer Alpen-Club SAC, Sektion Pilatus	Verein
2809	European Parliamentary Forum on Population & Development EPF	Informelle Gruppe
2882	Grünliberale Partei Genf	Verein
2843	EurAsia Heart - A Swiss Medical Foundation	Stiftung
2851	TRANSAT SA	AG
2860	Fondation Sécurité énergétique	Stiftung
2931	Schweizerische Volkspartei See-Gaster	Verein
2938	Gemeinnütziger Frauenverein Rapperswil-Jona	Verein
2948	Direkte Solidarität mit Chiapas	Verein
3007	ACQUAROSSA Terme SA	AG
3010	Swiss Newater Group SA	AG
3118	Eisbahn Wohlen Genossenschaft in Liquidation	Genossenschaft
3144	Konferenz Kantonaler Energiedirektoren	Staatlich
3154	Stiftung Züriwerk	Stiftung
3163	Bernischer Staatspersonalverband	Verein
3170	DEV (Développement Economique Canton de Vaud)	Verein
3201	GRIMSOLAR SA en liquidation	AG
3204	Swiss Business Point, association	Verein
3237	Association Genilem	Verein
3230	Bluefactory Fribourg-Freiburg SA	AG
3234	Discothèque de Morgins SA	AG
3274	Historisch-antiquarische Kommission Bern	Verein
3180	Partei der Arbeit	Verein
3059	Fondation des Maisons de retraite du district d'Aigle	Stiftung
2582	Pensionskassengenossenschaft des Schweizerischen Gewerkschaftsbundes in Liquidation	Genossenschaft
2565	strategiemühle gmbh	GmbH
3300	Fondation de Zambotte	Stiftung
3333	IV-Stelle Kanton Bern	Oeffentlich-rechtlich
3360	Casino de Montreux SA	AG
3370	Société coopérative du Chemin de fer - Musée Blonay-Chamby	Genossenschaft
3392	Fondation du Festival de Jazz de Montreux	Stiftung
3402	DARTFISH SA	AG
3382	Fördervereinigung s/bf-HSG	Verein
3450	Stiftung St. Josef, Oberwalliser Alters-, Pflege- und Behindertenheim	Stiftung
3469	Fondation Anouk	Stiftung
3504	Team Baden	Verein
3553	Département des finances et des relations extérieures du canton de Vaud	Staatlich
3531	Verein Konzernverantwortungsinitiative	Verein
3604	Bund der Steuerzahler (BDS) Aargau	Verein
3624	CVP Eschenbach	Verein
3597	Überparteiliches Komitee "Heiratsstrafe abschaffen - JA"	Informelle Gruppe
3648	Wohlfahrtsfonds der Kraftwerk Birsfelden AG in Liquidation	Stiftung
3671	Finanzkommission der Gemeinde Kerns	Staatlich
3687	Liberty Freizügigkeitsstiftung	Stiftung
3703	Fondation pour le Patrimoine Hospitalier Morgien	Stiftung
3736	Turnverein Bolligen	Verein
3751	Stiftung Kunst- und Kulturhaus Interlaken (KKI)	Stiftung
3779	Pro Sozialcharta	Informelle Gruppe
3800	Zunft zu Hausgenossen	Verein
3821	Pensionskasse der F. Hoffmann-La Roche AG	Stiftung
3854	Markwalder Emmenegger Rechtsanwälte und Wirtschaftskonsulenten	Einzelunternehmen
3888	Verein Blumenhaus Buchegg	Verein
3894	Baryon AG	AG
3929	Private Hochschule Wirtschaft PHW Bern AG	AG
3947	Young Professionals in Swiss Politics	Informelle Gruppe
3973	Biovision - Stiftung für ökologische Entwicklung	Stiftung
3988	Aqua Nostra	Verein
3992	Société coopérative de Laiterie de Vulliens	Genossenschaft
3997	Lions Club Köniz	Verein
4018	Flora, Bona und Rosa Bollag-Stiftung	Stiftung
4065	Theater Jetzt	Verein
4080	Verband der Fachhochschuldozierenden Schweiz	Verein
4096	Winterhilfe Schaffhausen	Verein
4122	JCI Toggenburg	Verein
4049	Spital Männedorf AG	AG
4121	BuCK Bar- und Club-Kommission Bern	Verein
4177	Hot Spots	Verein
4195	Selbsthilfefonds der Schweiz. Wald- und Holzwirtschaft (SHF)	Verein
4220	Swiss Engineering Media AG	AG
4255	Société Coopérative COOQPIT	Genossenschaft
4287	swissICT	Verein
4315	Swiss Privacy Foundation	Verein
4301	Stiftung Pia Ida	Stiftung
4351	AM Suisse Ticino	Verein
4370	STUDIO FIDUCIARIO E IMMOBILIARE ROBERTA PANTANI TETTAMANTI SA	AG
4392	Stiftung KMU Clima	Stiftung
4409	Die Dargebotene Hand Zentralschweiz	Verein
4440	Junge Hausärztinnen und -ärzte Schweiz	Verein
4448	Tierschutzverein Frauenfeld	Verein
4485	Nie wieder Atomkraftwerke - NWA Solothurn	Verein
4502	Stiftung Gabriel Institut	Stiftung
4528	Arbeitsgemeinschaft der Schweizerischen Getränkebranche (ASG)	Verein
4547	Stiftung Zentralbibliothek Solothurn	Stiftung
4575	Junge Wirtschaftskammer Aargau	Verein
4593	Junge Schweizerische Volkspartei Waadt	Verein
4617	Opus One	Einzelunternehmen
4614	UNION DES PAYSANS FRIBOURGEOIS	Verein
4667	Schweizerischer Verband der Zuckerrübenpflanzer	Verein
4682	Swiss Sheep Dog Society	Verein
4680	Verein Ferien auf dem Bauernhof (VFB)	Verein
4730	Fondation de la Haute Horlogerie	Stiftung
4772	Schweizerische Stiftung Pro Mente Sana	Stiftung
4785	ProSpecieRara	Stiftung
4705	Kunz Landtechnik Reiden AG	AG
4676	Schweiz. Bäuerinnen- und Landfrauenverband	Verein
4821	Cembra Money Bank AG	AG
4845	Interessengemeinschaft Tee, Gewürze & verwandte Produkte	Verein
4871	SUISSEDIGITAL VERBAND FÜR KOMMUNIKATIONSNETZE	Verein
4894	Verband Freier Autohandel Schweiz	Verein
4905	x.ref GmbH	GmbH
4932	Die Mitte Basel-Landschaft	Verein
4950	Fondation de l'Auditorium du Jura en liquidation	Stiftung
2834	VIRTÙ Public Affairs AG	AG
2894	Swiss Association for the United World Colleges	Verein
2926	Heit Sorg zu Bärn	Verein
2913	Sicherheitsdirektion Basel-Landschaft	Staatlich
2968	Voser Rechtsanwälte Services AG	AG
2943	IG Tunnel Rapperswil-Jona-Jetzt	Informelle Gruppe
3032	Gemeinde Rüthi SG	Staatlich
3038	Zweckverband Haus Sonnengarten Altstätten	Oeffentlich-rechtlich
3045	Pfarrei Balgach	Staatlich
3121	Genossenschaft Athleticum Niedermatten Wohlen	Genossenschaft
3148	CEDES AG	AG
3104	Stiftung Kulturforum Amriswil	Stiftung
3110	Pensionskasse SIB	Stiftung
3186	Banque du Léman SA	AG
3090	Fondation du Théâtre Kléber-Méleau, TKM	Stiftung
3135	Schweizerische Volkspartei Schattdorf	Verein
3139	Kantonale Jagdkommission Uri	Ausserparlamentarische Kommission
3266	Grosse Schanze AG	AG
3281	Louise Blackborne-Stiftung	Stiftung
2557	Zürcher Bauernverband (ZBV)	Verein
3060	Fondation Frédéric Rouge	Stiftung
3226	Kanton Freiburg	Staatlich
3292	Fachverband für den BVG-Stiftungsrat	Verein
3307	Schweizerische Volkspartei Schwyz	Verein
3352	P.S. Verlags GmbH	GmbH
3334	Schweizerische Arbeitsgemeinschaft Hilfsmittelberatung für Behinderte und Betagte SAHB	Verein
3403	FDP Montreux-Veytaux	Verein
3417	Primarschule Zehntenhof	Staatlich
3431	AUTO ALLIANZ Stiftung zum Schutz der motorisierten Konsumenten und der freien Mobilität	Stiftung
3460	Verein Operette Leuk	Verein
3470	Comité contre les magouilles immobilières	Verein
3519	Unterland-Woche AG in Liquidation	AG
3528	Auffahrtsschwadron Hitzkirch	Informelle Gruppe
3589	Elektromobilität	Parlamentarische Gruppe
3607	Bos-chetta Plauna SA	AG
3595	Schuh-Shop Aado AG	AG
3640	Prevo-System AG	AG
3657	Fussballclub Luzern Verein	Verein
3685	Liberty Vorsorge AG	AG
3690	Stiftung Eishockeyförderung Gotthard	Stiftung
3712	Fondation cantonale pour la formation professionnelle	Stiftung
3735	Kantonale Behindertenkonferenz Bern	Verein
3758	Online Easy AG	AG
3785	Réalise	Verein
3805	Roche Diagnostics (Schweiz) AG	AG
3829	Stiftung für die Erhaltung von Kulturlandschaft und Schloss Buonas	Stiftung
3740	Freundinnen, Freunde, Eltern von Lesben und Schwulen	Verein
3901	Post Tenebras Lux - Société des Genevois de Berne	Verein
3907	Ägerisee Schifffahrt AG	AG
3936	Wohlfahrtsfonds der Mowag Motorwagenfabrik AG	Stiftung
3967	Avenirsocial	Verein
3981	Naturfreunde Kölliken	Verein
3831	Sofia SA	AG
4004	Autorité cantonale de surveillance des fondations et des institutions de prévoyance	Oeffentlich-rechtlich
4021	NetJets Europe GmbH in Liquidation	GmbH
3830	Société rurale d'assurance de protection juridique FRV SA	AG
4062	Fachstelle Frauenhandel und Frauenmigration	Verein
4095	Swiss Medical Network SA	AG
4123	Bäuerinnenvereinigung Wintersberg-Bendel	Verein
4140	Hääss-Chammer-Gnosseschaft Appenzell in Liquidation	Genossenschaft
4149	Netzwerk Impfentscheid	Verein
4164	Eidgenössisches Finanzdepartement	Staatlich
4203	proQuercus	Verein
4225	Stiftung LA PUMERA	Stiftung
4260	Emergence Coaching Laura Perret Ducommun	Einzelunternehmen
4286	Schweizerische Gesellschaft für Aussenpolitik	Verein
4304	Junge für eine unabhängige und neutrale Schweiz	Verein
4313	Approach8 GmbH in Liquidation	GmbH
4343	Regazzi Holding SA	AG
4368	PIZZA IN SA	AG
4383	LibertàeValori	Verein
4400	Zentralschweizer Bauernbund	Verein
4427	Studio legale e notarile Merlini e Nicora	Einzelunternehmen
4456	Verein EXPO2027	Verein
4481	SRG.R	Verein
4497	Evangelisch-methodistische Kirche in der Schweiz	Verein
4526	FC Niederwil	Verein
4543	Verein ostschweizerinnen.ch	Verein
4567	Agroline AG	AG
4592	Interessengemeinschaft (IG) Innenstadtverkehr	Informelle Gruppe
4615	Zentrum für Wirtschaft, Wissenschaft und Politik	Informelle Gruppe
4639	Schweizer Kälbermäster-Verband SKMV	Verein
4665	Association Vivre Ensemble	Verein
4673	SA Agricola Ticinese	AG
4706	Frunoba AG	AG
4735	Victorinox AG	AG
4770	PluSport Behindertensport Schweiz	Verein
4767	autismusschweiz	Verein
4755	Swiss Wine Promotion AG	AG
4815	Association Patronale de l'Horlogerie et de la Microtechnique	Verein
4839	Handelskammer und Arbeitgeberverband Graubünden	Verein
4864	Schweizerische Normen-Vereinigung SNV	Verein
4874	Swiss Biotech Assiociation	Verein
4906	Flora des Kantons Zürich	Informelle Gruppe
4889	Verband Schweizerischer Filialunternehmungen	Verein
4948	Verein für Leseförderung Delémont	Verein
4973	Aida | Bildung + Begegnung	Verein
4992	Allianz Q	Informelle Gruppe
5020	Verein Karpfen pur Natur	Verein
5013	Unia Region Freiburg	Verein
5042	Demole Hovagemyan Wingslaw Avocats Sàrl	GmbH
5066	Schützengesellschaft Sachseln	Verein
5078	SIZ AG	AG
5091	swissstaffing	Verein
5183	UK-Swiss Friendship Association	Parlamentarische Gruppe
5196	Genossenschaft OPTIMA-SOLAR Solothurn	Genossenschaft
3375	Dr. Heinrich Wachter-Stiftung zur Förderung der wissenschaftlichen Forschung an der Hochschule St. Gallen für Wirtschafts- und Sozialwissenschaften	Stiftung
3416	Kantonsschule Enge	Staatlich
3435	GIS Daten AG	AG
3467	Société Romande des Relations Publiques	Verein
3479	Aargauischer Lehrerinnen- und Lehrerverband	Verein
3503	Association Suisse des locataires - section genevoise	Verein
3527	slowUp Seetal	Verein
3599	Bieri Verwaltungs AG	AG
3541	Stiftung GREATER ZURICH AREA Standortmarketing	Stiftung
3628	KKLB-Medienakademie im Landessender Beromünster	Einfache Gesellschaft
3598	Airproduct AG	AG
3642	Ergänzungskasse der Helvetia Versicherungen	Stiftung
3678	Swico	Verein
3682	Schweizer Salinen AG	AG
3700	Schweizerische Akademie der Technischen Wissenschaften (SATW)	Verein
3731	Anwaltskanzlei Kiener & Nellen	Einfache Gesellschaft
3757	Cargo Rail Europe	Verein
3795	Wombat GmbH	GmbH
3811	Roche Holding AG	AG
3794	KPT Versicherungen AG	AG
3844	Smaragd-Gebiet Oberaargau	Verein
3729	Berner Bildungszentrum Pflege AG	AG
3920	Katholische Arbeitsgemeinschaft für Erwachsenenbildung der Schweiz und Liechtensteins	Verein
3910	TSE Real Estate AG	AG
3962	Promembro	Verein
3980	Musikgesellschaft Kölliken	Verein
3859	thunerSeespiele Management AG	AG
4000	Nau media AG	AG
4022	Dr. J. Bollag & Cie. AG	AG
4044	Leseverein Hallau	Verein
4061	ARGE Integration Ostschweiz	Verein
4085	Schweizerische Nationalkommission Justitia et Pax	Informelle Gruppe
4124	Schweizerische Vereinigung für Politische Wissenschaft	Verein
4139	Stiftung Bund der Steuerzahler	Stiftung
4159	Eidgenössisches Departement für Umwelt, Verkehr, Energie und Kommunikation	Staatlich
4175	Vorsorgestiftung RSS, Gemeinschaftsstiftung für Mitarbeitende der Rudolf Steiner Schulen in der Schweiz	Stiftung
4190	ARA Kiesental AG	AG
4191	GGB Gymnastische Gesellschaft Bern	Verein
4253	Consulting Cluster	Verein
4282	Schweizerische Stiftung Pro Venezia	Stiftung
4280	newTree Schweiz	Verein
4325	Primeo Netz AG	AG
4339	Regazzi SA	AG
4363	SWIKAPITAL SA en liquidation	AG
4390	Pflegeheim der Region Rorschach	Einzelunternehmen
4406	PILATUS Flugzeugwerke AG	AG
4449	Kunstverein Frauenfeld	Verein
4460	Aktion Bildungs-Kompass	Verein
4474	INTERNATIONALE SOLARMOBIL FÖDERATION ISF	Verein
4499	Elternclub Gerlafingen	Verein
4525	Stiftung des Schweizerischen Bierbrauervereins für Wissenschaftliche Forschung	Stiftung
4541	Naturwissenschaftliche Gesellschaft St. Gallen	Verein
4565	Grüne Kanton Zürich	Verein
4597	HELVETIAROCKT-Der Verein	Verein
4618	Bauernverband beider Basel BVBB	Verein
4647	Stiftung Europainstitut Basel	Stiftung
4670	Verband Schweizer Pilzproduzenten VSP	Verein
4687	Dachverband Schweizerischer Müller DSM	Verein
4731	Lacoste Switzerland AG	AG
4715	Dachverband für Drogenlegalisierung	Verein
4776	Schweizerischer Zentralverein für das Blindenwesen (SZB)	Verein
4796	Automobil Club der Schweiz (ACS), Sektion Thurgau	Verein
4756	Switzerland Cheese Marketing AG	AG
4818	Aussenwerbung Schweiz	Verein
4835	Frutiger AG	AG
4854	Omya (Schweiz) AG	AG
4880	Swisspasta - Vereinigung der Schweiz. Teigwarenindustrie	Verein
4898	Istituto di previdenza del Cantone Ticino	Oeffentlich-rechtlich
4924	Business and Professional Women Frauenfeld	Verein
4944	Musée jurassien d'art et d'histoire	Stiftung
4954	Europagruppe des Europa Instituts an der Universität Zürich	Informelle Gruppe
4981	Ringier Art AG	AG
4985	Personalverband des Bundes	Verein
5024	Rotes Kreuz	Parlamentarische Gruppe
5056	AA Pharma inc.	AG
5065	CVP Sachseln	Verein
5123	Gewerbegruppe der Bundesversammlung	Parlamentarische Gruppe
5092	Verbandes Schweizerischer Sicherheitsdienstleistungs- Unternehmen	Verein
5186	Unité - Schweizerischer Verband für Personelle Entwicklungszusammenarbeit	Verein
5195	Obst-und Gartenbauverein Dulliken/Starrkirch-Wil	Verein
5305	Pro Baltikum	Parlamentarische Freundschaftsgruppe
5313	Stiftung Sternwarte Uecht	Stiftung
5327	Gesellschaft der Freunde des Stadttheaters Bern	Verein
5337	Fondation pour la Recherche en Périnatalité (FReP)	Stiftung
5419	Kinderlobby Schweiz	Verein
5349	Sport Club 86	Verein
5352	Schweizerische Volkspartei Emmen	Verein
5449	Stiftung Fernfachhochschule Schweiz, Brig FFH-CH	Stiftung
5415	Gemeinde Rümlang	Staatlich
5513	société coopérative de construction et d'habitation Le Bled	Genossenschaft
5523	Jugendparlament Kanton Bern	Verein
5534	Verein Restauration Denkmal 5. Division im Villigerfeld	Verein
5295	Schweizerischer Verband für die nachhaltige Entwicklung im Weinbau	Verein
5100	Jungfreisinnige Kanton Bern	Verein
5105	Parlamentarische Gruppe Wohn- und Immobilienpolitik	Parlamentarische Gruppe
5556	Abwasserverband ARA Region Murten	Oeffentlich-rechtlich
5655	Schweiz - Griechenland	Parlamentarische Freundschaftsgruppe
5634	Ernst Fischer AG, Stahl- und Metallbau	AG
5569	KUBUS Schulung und Beratung	Einzelunternehmen
5163	HRS Renovation AG	AG
5688	Stiftung Bildungswerkstatt Bergwald	Stiftung
3441	Oekopolis Stiftung für interdisziplinäre Information, Innovation und Projektgestaltung im Beziehungsfeld Energie-Technik-Natur	Stiftung
3464	Fondation du Festival du Rire de Montreux	Stiftung
3489	Grüne Baden	Verein
3521	WIBERG Swiss GmbH	GmbH
3485	Junges Theater Baden	Verein
3600	Careproduct AG	AG
3582	Schweizerische Vereinigung für einen starken Agrar- und Lebensmittelsektor	Verein
3618	Universitätsrat Luzern	Oeffentlich-rechtlich
3639	Grand Casino Luzern AG	AG
3660	Informatikleistungszentrum Obwalden - Nidwalden (ILZ)	Oeffentlich-rechtlich
3676	TREUHAND SUISSE Schweizerischer Treuhänderverband	Verein
3574	EXPERTsuisse - Schweizer Expertenverband für Wirtschaftsprüfung, Steuern und Treuhand	Verein
3699	Schweizerische Gesellschaft für Allgemeine Innere Medizin	Verein
3716	École de Musique et des Arts de Savièse	Einzelunternehmen
3718	Parti d'Entente - Savièse	Verein
3762	Viehzuchtgenossenschaft Oberiberg in Liquidation	Genossenschaft
3798	Fleischfachverband Kanton Bern	Verein
3807	Roche Employee Action and Charity Trust	Stiftung
3840	Estimapro Sàrl	GmbH
3880	Sozialdemokratische Partei Regionalverband Oberaargau	Verein
3899	KoRuSa Développements SA en liquidation	AG
3922	Schweizerische Stiftung für audiovisuelle Bildungsangebote SSAB	Stiftung
3933	Stiftung Stunde des Herzens	Stiftung
3961	Verein OneGov.ch	Verein
3875	Swiss Association Value Added Services	Verein
3815	Humer-Stiftung für akademische Nachwuchskräfte	Stiftung
3723	Kommission Energiepolitik Uri	Staatlich
4020	EWA Solutions GmbH	GmbH
4052	Segel Club Männedorf	Verein
4041	Lehrerverein Schaffhausen	Verein
4094	Stiftung Auslandschweizerplatz Brunnen	Stiftung
4047	Verein zur Förderung der sportlichen Betätigung	Verein
4105	Fonds der Thurgauer Landwirtschaft	Stiftung
4154	Retake GmbH	GmbH
4158	Eidgenössisches Departement für auswärtige Angelegenheiten	Staatlich
4192	HAUS DES SPORTS	Stiftung
4198	Eidgenössische Kommission für Frauenfragen	Ausserparlamentarische Kommission
4252	Freunde Kunstmaler Kurt Lanz	Verein
4212	MCDT AG in Liquidation	AG
4296	KIBAG Kies Birr AG	AG
4320	WVB Wärmeverbund Bottmingen AG	AG
4346	Sarefi Immobiliare SA	AG
4364	AGE SA	AG
4389	KELLEN dä Sporttreff, Muttner	Einzelunternehmen
4415	Fachverband Elektroapparate für Haushalt und Gewerbe Schweiz	Verein
4442	Fondation Changins	Stiftung
4464	Stiftung Alterswohnen Rümlang	Stiftung
4487	Blaues Kreuz Schweiz	Verein
4506	Brauerei Rosengarten AG	AG
4527	Lions Club Baden-Heitersberg	Verein
4514	SWICA Holding AG	AG
4563	Verein Sicherheit und Wehrwissenschaft	Verein
4580	Treuhand	Parlamentarische Gruppe
4588	Philip Morris Switzerland Sàrl	GmbH
4622	Bauernverband Appenzell	Verein
4642	Schweizergeflügelproduzenten	Verein
3814	Paul Sacher Stiftung	Stiftung
4691	Agrona AG	AG
4734	SAFE Schweizerische Vereinigung zur Bekämpfung der Piraterie	Verein
4762	Kantonsspital St.Gallen	Oeffentlich-rechtlich
4766	Mobility International Schweiz	Verein
4700	UFA-Bürgschaftsgenossenschaft	Genossenschaft
4724	Verband der Eltern- und Angehörigenvereinigungen Drogenabhängiger	Verein
4823	Handels- und Industriekammer Freiburg	Verein
4831	Desco Immobilien AG	AG
4865	Schweizerischer Hefeverband	Verein
4883	Transocean Ltd.	AG
4911	Praxis Dr. Lukas Hodel	Einzelunternehmen
4925	Parlamentarische Gruppe Freiwilligenarbeit und Ehrenamt	Parlamentarische Gruppe
4942	Komitee Pro Bundesstrasse Basel - Jura	Informelle Gruppe
4952	Fédération des associations de parents d'élèves du canton du Jura	Verein
4972	Coordination Romande des Associations d'Action pour la Santé Psychique CORAASP	Verein
4997	Vereinigung Kantonaler Gebäudeversicherungen (VKG)	Verein
5030	Fondation EcoFormation	Stiftung
5057	JUSO Kanton Bern	Verein
5071	Schweizerische Volkspartei Uster	Verein
5122	Arnold-Otto-Aepli-Gesellschaft	Verein
5132	Bruderschaft der Freiburgischen Weinberge	Verein
5142	Gemeinnützige Gesellschaft Burgdorf	Verein
5197	Kind+Spital - für die Rechte von Kindern und Jugendlichen im Gesundheitswesen	Verein
5276	Freidenkende Region Bern	Verein
5215	Grupo Colombo-Suizo de Pedagogía Especial	Verein
5332	Musikgesellschaft Krattigen	Verein
5344	Verein Region Thal	Verein
5348	Print und Kommunikation	Parlamentarische Gruppe
5438	BDP Kanton Luzern	Verein
5448	Stiftung BENEVOL Graubünden	Stiftung
5460	ethik22 - Institut für Sozialethik	Informelle Gruppe
5472	Siegfried Holding AG	AG
5283	Labor Veritas AG	AG
5484	Freunde des Natur-Museums Luzern	Verein
5296	frauenberatung sexuelle gewalt	Verein
5500	Skiclub Horgen	Verein
5586	Saxer & Co. Kesselhof	KG
5595	Zentrale Paritätische Kommission der Reinigungsbranche in der Deutschschweiz	Verein
5630	KMU Region Hinterthurgau	Verein
5662	Grüne Kanton Luzern	Verein
5670	Comunità familiare	Verein
5572	Hacontex AG	AG
5575	Christlichsoziale Volkspartei Oberwallis	Verein
5248	Die Mitte Thurgau	Verein
5718	CVP Schänis	Verein
3517	Spanischbrödlizunft Baden	Verein
3536	MDZ Uster AG, Medizinisches Diagnose-Zentrum Zürcher Oberland	AG
3486	Trägerverein Kino Orient	Verein
3606	Tourismusorganisation Engadin St. Moritz	Oeffentlich-rechtlich
3583	Schweizerische Steuerkonferenz	Verein
3631	dermazofingen ag	AG
3623	AKV Rauracia	Verein
3668	Standort Promotion in Obwalden	Verein
3689	Lealta Freizügigkeitsstiftung	Stiftung
3706	Fondation des institutions sociales de l'industrie vaudoise de la construction	Stiftung
3743	Freundschaft mit China Bern	Verein
3754	Parlamentariergruppe Pfadi Kanton Bern	Parlamentarische Gruppe
3775	Ebenrain-Konferenz	Informelle Gruppe
3771	Hans Fischer-Bugmann AG	AG
3824	Hoffmann - La Roche Ltd	AG
3842	Association des groupements et organisations romands de l'agriculture	Verein
3882	Kiwanis-Club Bern-Bäregraben	Verein
3891	Stiftung Landguet Ried	Stiftung
3872	ASTAG Schweizerischer Nutzfahrzeugverband, Sektion Aargau	Verein
3944	Stiftung zsge	Stiftung
3956	Parlamentarische Gruppe Tibet	Parlamentarische Gruppe
3977	Vereinigung für Heimatkunde Suhrental	Verein
3862	Opéra de Lausanne	Stiftung
3996	Siemens Schweiz AG	AG
4026	Schweizerischer Juristenverein	Verein
4053	ener-J	Verein
4069	CaBi Antirassismus Treff	Verein
4093	Verein Dazugehören	Verein
4046	Konferenz der Gebäudetechnik-Verbände	Verein
4132	Avanex Versicherungen AG	AG
4148	Pro Amt	Verein
4169	Fondation pour les terrains industriels de Genève (FTI)	Oeffentlich-rechtlich
4182	Stiftung Science et Cité	Stiftung
4216	Seniorweb Lernzentren GmbH in Liquidation	GmbH
4232	Fachhochschule Ostschweiz	Staatlich
4259	Expertengruppen des Bundesamts für Statistik (BFS)	Staatlich
4209	Kommunikation Schweiz	Verein
4297	KIBAG Kies Schafisheim AG	AG
4300	ATB Verband für Sport-Freizeit-Verkehr	Verein
4342	Regapak Regazzi SA	Einzelunternehmen
4365	Domusdea SA	AG
4384	SBS Schifffahrt AG	AG
4416	Kunsthaus Zürich	Einzelunternehmen
4439	Europaplattform Schweiz	Verein
4457	Verein Bodenseegärten	Verein
4475	Neue Energie Zürich	Verein
4496	ERF Medien	Verein
4524	Schweizerischer Verein für umweltgerechte Getränkeverpackungen	Verein
4544	Geopark Sardona	Verein
4568	Sevra Suisse AG	AG
4586	viscom	Verein
4623	Bauernverband Aargau (BVA)	Verein
4649	Novartis Pharma AG	AG
4643	Verband Schweizerischer Pferdezuchtorganisationen	Verein
4660	Schweizerische Eringerviehzuchtverband	Verein
4686	Mühlengenossenschaft Kanton Bern	Genossenschaft
4712	SGG Waser AG	AG
4743	Gesundheitsrechtsinstitut der Universität Neuenburg	Staatlich
4779	Schweizerische Arbeitsgemeinschaft von Ärzten für Menschen mit geistiger oder mehrfacher Behinderung	Verein
4799	ACS Sektion Schwyz-Uri	Verein
4817	AVIA Vereinigung unabhängiger Schweizer Importeure und Anbieter von Energieprodukten, Genossenschaft	Genossenschaft
4842	IBM Schweiz AG	AG
4857	Procter & Gamble Switzerland SARL	GmbH
4888	Verband Schweizer Medien	Verein
4897	Access Public affairs & Communications Sàrl	GmbH
4935	Verein Europäisches Jugendchor Festival Basel	Verein
4956	Start Up Frauen	Verein
4979	Kinok - Cinema in der Lokremise	Verein
4999	Wirtschafts- und Sozialwissenschaftliche Fakultät der Universität Bern	Staatlich
5008	Gesellschaft für bedrohte Völker	Verein
5058	BET Suisse AG	AG
5067	Gemeinde Leuk	Staatlich
5125	Comune di Melide	Staatlich
5089	SwissBeton, Fachverband für Schweizer Betonprodukte	Verein
5141	Vereinigung Kadettenwesen Burgdorf	Verein
5154	Kommission für Forschungspartnerschaften mit Entwicklungsländern	Informelle Gruppe
5303	Stiftung für blinde und sehbehinderte Kinder und Jugendliche Zollikofen	Stiftung
5315	Verein Festival der Natur - Biodiversität erleben	Verein
5324	Freunde Kunstmuseum Bern	Verein
5380	Mutuel Assurance Maladie SA	AG
5388	Stiftung Natur & Wirtschaft	Stiftung
5395	Cercle des Hérensards de Sion	Verein
5443	Schweizerischer Leichtathletikverband	Verein
5451	Geothermie Schweiz	Verein
5358	J&J Stahllab GmbH	GmbH
5475	GRIBAG Beton AG	AG
5530	Höhere Fachschule Holz	Staatlich
5490	Spar- und Leihkasse Frutigen AG	AG
5497	Koalition Luftverkehr, Umwelt und Gesundheit	Verein
5103	Inforama	Staatlich
5590	Schweizerische Gesundheitsaussenpolitik	Staatlich
5561	Associazione Proprietari Fondiari, Sezione Ticino APF-HEV Ticino	Verein
5660	Associazione dei Comuni in ambito socio sanitario	Verein
5158	OXYMORE SOCIETE COOPERATIVE POUR LA CREATION DE COOPERATIVES DE LOGEMENT	Genossenschaft
5679	Grüne Kanton Bern	Verein
5166	HRS Real Estate AG	AG
5695	BB Peinture, Buffat & De Almeida Batista	KG
5638	FHS Alumni	Verein
5641	Trinationaler Atomschutzverband - TRAS	Verein
5772	Fondation 1792	Stiftung
5801	Schweizerische Berufsverband für Angewandte Psychologie SBAP	Verein
5867	Fourchette verte Genf	Verein
5881	FC Schaffhausen	Verein
5909	Mieterinnen- und Mieterverband Regionalgruppe Bern und Umgebung	Verein
5915	Forum Energiespeicher Schweiz	Informelle Gruppe
3515	Verein ehemaliger Bezirksschülerinnen und -schüler Baden	Verein
3550	slk holding ag	AG
3577	Lions Club Landshut	Verein
3609	Förderverein Sessellifte Zuoz	Verein
3627	Historischer Verein Zentralschweiz	Verein
3619	Arbeitsgemeinschaft Wirtschaft und Gesellschaft Kanton Luzern	Verein
3585	Schützengesellschaft der Stadt Bern (Stadtschützen Bern)	Verein
3664	Immo & Co SA	AG
3686	Liberty 3a Vorsorgestiftung	Stiftung
3695	Ordine dei Medici del Canton Ticino	Oeffentlich-rechtlich
3715	Jeunesse Unia du Valais	Verein
3739	Regionaler Naturpark Diemtigtal	Verein
3756	International Union of Wagon Keepers	Verein
3773	Dr. Frank Furrer Rechtsberatung	Einzelunternehmen
3801	Personalvorsorgestiftung von scienceindustries	Stiftung
3797	Gemüseproduzenten-Vereinigung der Kantone Bern und Freiburg, GVBF	Verein
3867	Genossenschaft KPT/CPT Krankenkasse	Genossenschaft
3847	Förderverein Jugendparlament Oberaargau	Verein
3915	Alfred Müller Stiftung	Stiftung
3925	Verein Geothermische Kraftwerke Schweiz, Sektion Zug	Verein
3945	Familienstiftung Naef von Zürich und Kappel am Albis	Stiftung
3953	Verein Atelier A	Verein
3877	competentia Dr. Michael Gehrken	Einzelunternehmen
3865	KPT Holding AG	AG
4002	Parking Plaine de Plainpalais SA	AG
4028	Zuger Treuhändervereinigung	Verein
4054	FC Bure	Verein
4063	momoll theater	Verein
4077	Eidgenössische Kommission für Tabakprävention	Ausserparlamentarische Kommission
4114	K3.Keller-Kommunikation&Konzepte GmbH	GmbH
4141	Lokal Appenzell GmbH	GmbH
4155	Aerosuisse	Verein
4176	Swisscom AG	Oeffentlich-rechtlich
4206	Fanarbeit Schweiz	Verein
4231	Pro Lucmagn	Verein
4271	Fondation Arsenic	Stiftung
4267	Stiftung Davos Festival	Stiftung
4295	MRG Beratungs-AG	AG
4319	Wärmeverbund Oberwil-Therwil AG	AG
4341	Regazzi Schermature Solari SA	AG
4366	Modellami SA in liquidazione	AG
4380	Ente Regionale per lo Sviluppo del Mendrisiotto e Basso Ceresio	Verein
4408	Oskar J. Schwenk	Einzelunternehmen
4432	Orchesterverein Burgdorf	Verein
4465	Walter Kaufmann Stiftung	Stiftung
4473	wohnbaugenossenschaften schweiz regionalverband zürich	Verein
4500	Verein Pro Wasseramt	Verein
4513	Stiftung SWICA Gesundheitsorganisation	Stiftung
4530	Freundinnen und Freunde der Gentiana Primary School Nairobi	Verein
4561	Limited Liability Company Roche Diagnostics Rus. Roche - Moscow Ltd.	GmbH
4590	British American Tobacco Switzerland SA	AG
4616	Life Fair GmbH	GmbH
4638	Swiss Beef CH	Verein
4654	EFTA-Konsultativausschuss	Staatlich
4677	Schweizerischer Pächterverband	Verein
4681	Agrotourismus Schweiz	Verein
4714	Coordination romande des institutions et organisations œuvrant dans le domaine des addictions	Verein
4768	Schweizerische Vereinigung für hirnverletzte Menschen FRAGILE Suisse	Verein
4788	ACS Sektion Les Rangiers	Verein
4723	Ticino Addiction	Verein
4812	Aargauische Industrie- und Handelskammer	Verein
4825	Chambre neuchâteloise du commerce et de l'industrie (CNCI)	Verein
4856	PricewaterhouseCoopers AG	AG
4877	SwissHoldings Verband der Industrie- und Dienstleistungskonzerne der Schweiz	Verein
4900	Konferenz der kantonalen Finanzdirektoren der lateinischen Schweiz	Staatlich
4921	Verein Greuterhof	Verein
4934	IG Südumfahrung NEIN	Verein
4960	Impresa Barella SA	AG
4988	Freiburger Nachrichten AG	AG
5018	Haute Ecole de la Santé La Source	Staatlich
5028	Institut für Unternehmensrecht der Universität Luzern	Staatlich
5061	HSG Alumni	Verein
5072	Schweizerische Volkspartei Volketswil	Verein
5129	SCS 100er-Club	Verein
5097	Zurich Heart House	Informelle Gruppe
5190	Schuldenberatung Schweiz	Verein
5240	Schwyzer Kantonales Schützenfest 2019	Verein
5270	Offiziersgesellschaft Zürcher Unterland	Verein
5316	Swiss Associations Managers	Verein
5325	Freunde Zentrum Paul Klee	Verein
5339	FONDATION MARC MORET	Stiftung
5383	SUPRA-1846 SA	AG
5436	Sozialdemokratische Partei Köniz	Verein
5441	Swiss Unihockey	Verein
5413	Stiftung ombudscom	Stiftung
5455	Freunde des Morgartenschiessens	Verein
5474	Dogger AG	AG
5528	Groupe Romand pour le Matériel de Défense et de Sécurité - GRPM	Verein
5294	Lions Club Sense-Kaiseregg	Verein
5546	Stiftung Doku-Zug	Stiftung
5504	Verein Henry-Dunant-Museum Heiden	Verein
5554	Kantonsgericht Freiburg	Staatlich
5626	Thurgauer Gewerbeverband (TGV)	Verein
5631	Arbeit Aargau	Verein
5665	Gemeinde Fällanden	Staatlich
5111	Gemeinde Dübendorf	Staatlich
5682	Schweizerische Vereinigung der Verbandsausgleichskassen	Verein
5691	SVP Stäfa	Verein
5722	Kesb-Schutz	Verein
5704	Grüne Bezirk und Gemeinde Affoltern	Verein
5179	BDO Visura International AG	AG
5615	Velo Club Monte Tamaro	Verein
5642	Frauenzentrale Aargau	Verein
5878	INTERPRET Schweizerische Interessengemeinschaft für interkulturelles Dolmetschen und Vermitteln	Verein
5370	Verein Limmat-Club Zürich	Verein
5885	Stadt Wädenswil	Staatlich
5889	KutterKommunikation GmbH	GmbH
3554	Konferenz Kantonaler Landwirtschaftsdirektoren	Staatlich
3601	Consira International Investment Holding AG	AG
3581	Schweizerische Offiziersgesellschaft der Logistik	Verein
3630	Gesellschaft zum Bären	Verein
3622	Die Mitte Stadt Luzern	Verein
3549	hs real estate gmbh	GmbH
3674	swissVR	Verein
3565	Kantonsschule Freudenberg Zürich	Staatlich
3697	TCti Trust Center Ticino SA	AG
3725	Andermatt-Sedrun Sport AG	AG
3720	Fanfare Echo du Prabé	Verein
3778	profilQualité	Verein
3799	Gewerbeverein Bremgarten bei Bern	Verein
3823	Jubiläums-Stiftung der F. Hoffmann-La Roche AG	Stiftung
3744	Europa Donna Schweiz	Verein
3857	Kumagra AG	AG
3913	Stiftung re-connected	Stiftung
3896	CMS von Erlach Partners AG	AG
3939	General Dynamics European Land Systems - Mowag GmbH	GmbH
3966	Verein Hochstamm Suisse	Verein
3986	Fondation des Ermitages	Stiftung
3879	Journal B	Verein
4007	Vereinigung Schweizerischer Privatbanken	Verein
4023	emb education GmbH	GmbH
4055	Cabinet Jean-Paul Gschwind	Einfache Gesellschaft
4071	Schweizerischer Friedensrat	Verein
4097	Wangental Natur Pur	Verein
4102	Regionalkonferenz Zürich Nordost	Oeffentlich-rechtlich
4050	Paritätische Landeskommission (PLK) der Schweizerischen Elektrobranche	Verein
4161	Eidgenössisches Departement für Wirtschaft, Bildung und Forschung	Staatlich
4178	Verein Vision Landwirtschaft	Verein
4205	Schweizerischer Forstverein	Verein
4222	Pro Infirmis Kanton Graubünden (Zweigniederlassung)	Verein
4269	alliancefinance	Verein
4266	Verein für eine produzierende Landwirtschaft	Verein
4298	Vereinigung Aktiver Aargauer Senioren	Verein
4330	Goal AG für Werbung und Public Relations	AG
4322	Erdgas AG Laufental-Thierstein (GASAG)	AG
4373	FARMATECH R&M SA	AG
4387	St.Gallen-Bodensee Tourismus	Verein
4422	Società Ticinese degli Ufficiali	Verein
4444	Schweizerische Bibelgesellschaft	Verein
4463	FK-Bau AG	AG
4476	FEINHEIT AG	AG
4495	Livenet	Verein
4521	Hotel Victoria Ritter AG	AG
4545	Pro Simmental	Verein
4558	Roche Deutschland Holding GmbH	GmbH
4595	Association PME Romandie	Verein
4553	IGEN International Inc.	AG
4636	Schweizerische Holsteinzuchtgenossenschaft	Genossenschaft
4658	Schweizerische Vereinigung der Hirschhalter	Verein
4674	Union romande de moulins	Genossenschaft
4694	Lobbywatch.ch	Verein
4738	Eidgenössisches Büro für Konsumentenfragen	Staatlich
4771	pro audito schweiz - Organisation für Menschen mit Hörproblemen	Verein
4784	Schweizer Bergheimat	Verein
4701	Getreide Züri Nord AG	AG
4803	MoMedia AG in Liquidation	AG
4820	BISCOSUISSE	Verein
4849	Liechtensteinische Industrie- und Handelskammer	Verein
4869	Swiss International Airports Association	Verein
4893	Vereinigung Schweiz. Glasfabriken (GLAS)	Verein
4915	Association des Femmes UDC Romandes	Verein
4933	Pro Senectute beider Basel	Stiftung
4955	Stiftung für Freiheit und Menschenrechte	Stiftung
4983	Arbeit	Parlamentarische Gruppe
4783	IG öffentliche Märkte	Verein
5007	Verein Theater Rigiblick	Verein
5034	Sozialdemokratische Partei Bezirk Baden	Verein
5064	Gemeinde Sachseln	Staatlich
5075	Offiziersgesellschaft der Panzertruppen	Verein
5086	FIAL Föderation der Schweizerischen Nahrungsmittel - Industrien	Verein
5098	Vereinigung der Ärzte mit Patientenapotheke	Verein
5192	Frauenzentrale Solothurn	Verein
5202	Stiftung Pro Leuggelbach	Stiftung
5155	AA Gestion et Conseil Sàrl	GmbH
5317	Swiss Wood Innovation Network S-WIN	Verein
5218	GV Subsilvania	Verein
5230	Mieterinnen- & Mieterverband Basel	Verein
5346	Schweizer Bischofskonferenz	Verein
5351	Luga	Einzelunternehmen
5446	Fundaziun OGNA	Stiftung
5456	FDP Die Liberalen Zug	Verein
5509	digitalswitzerland	Verein
5478	Sozialdemokratische Partei Basel-Stadt	Verein
5482	Luzerner Mobilitätskonferenz	Verein
5293	Campus für Demokratie	Informelle Gruppe
5498	IG Dritte Schiene Golden Pass	Verein
5551	World Lottery Association	Verein
5620	ConCordis GmbH	GmbH
5562	Jungfreisinnige Ausserrhoden	Verein
5361	TechniSim, Simon Paul-André	Einzelunternehmen
5672	Janine Wicki - die Konsulentin	Einzelunternehmen
5680	Grüne Mittelland-Süd	Verein
5689	FAiR "Für eine Aufwertung des Zürichseeufers im Recht"	Verein
5697	École Supérieure des Sciences Économiques et Commerciales	Einzelunternehmen
5702	United Help AG	AG
5606	Area City Quinto SA	AG
5610	Cioss SA	AG
5363	FONDATION DU MUSEE DE L'AVIATION MILITAIRE DE PAYERNE	Stiftung
5643	Projekt 210	Verein
5369	Zürcher Presseverein	Verein
5806	Museum im Bellpark	Verein
5809	Mieterinnen- und Mieterverband Luzern, Nidwalden, Obwalden, Uri	Verein
5925	PEDIMA AG	AG
5894	Regionales Ausbildungszentrum Au	Verein
5954	Arnold Mentalcoaching und Beratung	Einzelunternehmen
5959	Harvard University	Staatlich
5996	Holdibat SA	AG
3540	Fachdirektorenkonferenz Lotteriemarkt und Lotteriegesetz (FDKL)	Verein
3626	Innovation zweite Säule	Verein
3637	Jahrzeitstiftung der Zunft zu Safran	Stiftung
3659	Schweizerische Stiftung für Arbeit und Weiterbildung SSAW	Stiftung
3684	Pensionskasse Uri	Oeffentlich-rechtlich
3567	Bezirksgericht Schwyz	Staatlich
3708	Caisse de retraite professionnelle de l'industrie vaudoise de la construction	Stiftung
3701	Schweizerischer Baumeisterverband (SBV)	Verein
3750	Stiftung Bad Heustrich	Stiftung
3781	Saint-Gervais Genève, Fondation pour les Arts de la Scène et les Expressions Culturelles Pluridisciplinaires	Stiftung
3788	Union libanaise culturelle en Suisse	Verein
3826	Museum Tinguely AG	AG
3856	thunerSeespiele AG	AG
3911	Gütsch Immobilien AG in Liquidation	AG
3895	Stiftung FH SCHWEIZ - zur Förderung des dualen Bildungswegs	Stiftung
3935	LGT Bank (Schweiz) AG	AG
3964	Incomindios (Internationales Komitee für die Indigenen Amerikas)	Verein
3983	Verein WIDE Switzerland	Verein
3878	Berner Zeitung	Einzelunternehmen
4003	Fondation des Parkings	Oeffentlich-rechtlich
4015	Mahr AG	AG
4067	Frauenzentrale St. Gallen	Verein
4092	Odd fellows Schweiz	Verein
4108	Familie Haldimann Stiftung	Stiftung
4103	Universität Bielefeld	Oeffentlich-rechtlich
4142	Verband Schweiz. Kreditbanken & Finanzierungsinstitute	Verein
4165	Société coopérative "LE CLOS DES SEMAILLES"	Genossenschaft
4186	Swiss Snowsports Association (SSSA)	Verein
4204	Arbeitsgemeinschaft für den Wald	Verein
4217	Turmonte GmbH	GmbH
4251	Rotary Club Bern	Verein
4277	Société vaudoise pour la protection des animaux	Verein
4292	EFTA/EU-Delegation	Staatlich
4324	Primeo Energie AG	AG
4336	Primeo Industriecontracting AG	AG
4353	Aqua Nostra Sezione Ticino	Verein
4375	MODALOG SA	AG
4398	Stiftung Alterswohnheim Ruswil	Stiftung
4425	Ordine degli avvocati del Cantone Ticino	Oeffentlich-rechtlich
4453	Thurgauer Landfrauenverband	Verein
4466	Schutzverband der Bevölkerung um den Flughafen Zürich	Verein
4480	Mieterinnen- und Mieterverband Graubünden	Verein
4510	Verband Schweizerischer Getränkegrossisten	Verein
4538	Netzwerk Raumplanung	Verein
4559	Roche Vietnam Co., Ltd	AG
4579	VaudRoutes	Verein
4609	Bauernvereinigung des Kantons Schwyz	Verein
4634	Braunvieh Schweiz Genossenschaft	Genossenschaft
4655	Schweizerischer Schweinezucht- und Schweineproduzentenverband Suisseporcs	Verein
4672	Landwirtschaftlicher Genossenschaftsverband Schaffhausen (GVS)	Genossenschaft
4692	Schenk Suisse S.A.	AG
4708	Union-Fruits SA	AG
4721	Schweizerische Gesellschaft für Gesundheitspsychologie	Verein
4777	Sonos Schweizerischer Hörbehindertenverband	Verein
4789	ACS Sektion Neuenburg	Verein
4751	Association des Producteurs de Pommes de terre Nouvelles de l'Arc Lémanique (APPNAL)	Verein
4813	Adecco Group AG	AG
4822	Chambre de commerce et d'industrie du Jura	Verein
4850	Maus Frères SA	AG
4872	Swiss Association of Nutrition Industries	Informelle Gruppe
4903	Suprovita Stiftung	Stiftung
4923	Pädagogische Hochschule Thurgau	Oeffentlich-rechtlich
4939	Stiftung Gérard und Dori Bernus-Lorétan	Stiftung
4959	Kommunalpolitik	Parlamentarische Gruppe
4793	ACS Sektion Freiburg	Verein
5017	VPOD Bern Kanton und Bund	Verein
5009	Arbus Schweiz - Vereinigung für kritische Mediennutzung	Verein
5038	Schweizerisches Arbeiterhilfswerk SAH Bern	Verein
5069	Junge SVP Schweiz	Verein
5079	BVG- und Stiftungsaufsicht des Kantons Zürich (BVS)	Oeffentlich-rechtlich
5090	SWISSMECHANIC Schweizerischer Verband mechanisch-technischer Betriebe	Verein
5143	TeamChrista	Informelle Gruppe
5232	Textilwirtschaft	Parlamentarische Gruppe
5309	Schweizerische Mobiliar Holding AG	AG
5214	Regionales Kompetenzzentrum Bevölkerungsschutz Bern-Mittelland	Oeffentlich-rechtlich
5326	Verein zur Förderung des Bernischen Historischen Museums	Verein
5340	Schweizer Gesundheitstage	Informelle Gruppe
5422	Chindernetz Kanton Schwyz	Verein
5433	Handwerker- und Gewerbeverein Burgdorf	Verein
5440	Année Politique Suisse	Staatlich
5406	Evangelisch-reformierte Kirche des Kantons Freiburg	Staatlich
5416	Couture-zh	Verein
5514	Bio-Vector Sàrl	GmbH
5525	Brauerei Luzern AG	AG
5537	Walo Bertschinger AG Bern	AG
5297	Evangelischer Frauenbund Zürich	Verein
5585	Flugplatzgenossenschaft Obwalden (FGOW)	Genossenschaft
5619	HERZKRAFTWERK AG	AG
5599	Baustellenkontrolle Basel	Verein
5600	Eidgenössische Kommission gegen Rassismus	Ausserparlamentarische Kommission
5667	Verband Schweizerischer Kaderschulen	Verein
5677	Pensionskasse des Personals der Einwohnergemeinde Köniz	Oeffentlich-rechtlich
5118	Heinrich Gebert Kulturstiftung Appenzell	Stiftung
5719	GENECAND Benoit	Einzelunternehmen
5637	SVP Amriswil	Verein
5605	Splash & Spa Tamaro SA	AG
5767	Sbrinz Käse GmbH	GmbH
5773	Wohnbaugenossenschaft ACHT Bern	Genossenschaft
5250	CVP Kreuzlingen	Verein
5254	Sportnetz Regio Kreuzlingen	Verein
5883	Greifvogelstation Berg am Irchel	Verein
5805	Trägerverein Jugendtreff Funky	Verein
3580	Schweizerische Gesellschaft für Agrarrecht	Verein
3594	Hälg Markenschuhe AG	AG
3638	Casino Online AG	AG
3656	Offene Kirche Elisabethen	Verein
3683	Kraftwerk Göschenen AG	AG
3573	Vereinigung Bernischer Sportverbände	Verein
3704	Ensemble Hospitalier de la Côte	Verein
3722	Aufsichtskommission für die Alters- und Hinterlassenenversicherung des Kantons Uri	Ausserparlamentarische Kommission
3759	Giezendanner Transport AG	AG
3772	Genossenschaft Im Spilhöfler Uitikon	Genossenschaft
3787	Schweizerische Gesellschaft für Völkerstrafrecht TRIAL	Verein
3822	Konzernvorsorgestiftung der F. Hoffmann-La Roche AG	Stiftung
3841	AGIR, Agence d'information romande agricole	Verein
3749	Ramseier Holding AG	AG
3889	WorldSkills International	Verein
3886	Schweizerische Hochschulkonferenz	Staatlich
3934	Fondazione Kaspar e Sophie Spörri	Stiftung
3969	Frauenrechte beider Basel	Verein
3985	Fondation du Château de Grandson	Stiftung
3833	Société d'assurance dommages FRV SA	AG
4005	NIDEGGERLAW Sàrl	GmbH
4029	Handelskammer Schweiz-Israel (Hksi)	Verein
4056	Stiftung Heimstätten Wil	Stiftung
4070	Mieterinnen- und Mieterverband Ostschweiz	Verein
4086	Konferenz der Höheren Fachschulen	Verein
4128	Personalvorsorgestiftung der Helsana Versicherungen AG	Stiftung
4119	Piratenpartei Schweiz	Verein
4157	Luft- und Raumfahrt PGLR	Parlamentarische Gruppe
4135	Helsana Zusatzversicherungen AG	AG
4207	Verein velojournal	Verein
4246	Zentrum für Gehör und Sprache	Oeffentlich-rechtlich
4257	Ecole professionnelle de Lausanne	Staatlich
4283	Stiftung bvz Berufslehr-Verbund Zürich	Stiftung
4306	Verband der Poker-, Geschicklichkeits- und Unterhaltungsspiele-Anbieter	Verein
4312	Poker Palace	Einzelunternehmen
4333	EBM Wärme GmbH	GmbH
4357	Fondazione Corippo 1975	Stiftung
4376	Medixentrix SA in liquidazione	AG
4401	Müller Leo, Anwaltskanzlei & Notariat	Einzelunternehmen
4407	Patronale Personalfürsorgestiftung PILATUS-BAHNEN	Stiftung
4441	Stiftung Wissenschaftliche Politikstipendien	Stiftung
4430	Skigruppe der Bundesversammlung	Verein
4489	Schweizerische Alzheimervereinigung Solothurn	Verein
4511	Entlebucher Bier AG	AG
4536	Bruno-Manser-Fonds	Verein
4550	EuroGas AG in Liquidation	AG
4576	FDP Die Liberalen Adliswil	Verein
4606	Basel Tourismus	Verein
4630	AgriGenève	Verein
4641	Vereinigung der Schweizer Eierproduzenten - GalloSuisse	Verein
4644	Schweizerischer Berufsfischerverband	Verein
4685	Chambre d'agriculture du Jura bernois	Verein
4709	platforM services ag	AG
4740	Edelmetallkontrolle	Staatlich
4780	Schweizerische Arbeitsgemeinschaft für Rehabilitation - SAR	Verein
4699	UFA AG	AG
4757	Verein zur Förderung der Produkte aus dem Freiburgerland	Verein
4819	BIBUS HOLDING AG	AG
4832	DKSH Holding AG	AG
4853	Nestlé AG	AG
4879	SwissOlio Verband Schweizerischer Hersteller von Speiseölen, Speisefetten und Margarinen	Informelle Gruppe
4899	Agenzia turistica ticinese SA	AG
4926	Die Mitte Frauen Schweiz	Verein
4945	La Balade de Séprais	Verein
4961	Società Svizzera Impresari Costruttori - Sezione Ticino (SSIC TI)	Verein
4980	Verhandlungsgemeinschaft Bundespersonal	Verein
4892	Vereinigung der Schweizeriche Milchindustrie (VSM)	Verein
5006	Caritas Zürich	Verein
5055	Verein GS1 Schweiz	Verein
5068	CSP Leuk	Verein
5126	Digital Festival AG	AG
5137	FDP Die Liberalen Emmental	Verein
5185	Zunft zum Widder	Verein
5235	WEGMÜLLER Consulting	Einzelunternehmen
5272	Schweizerische Volkspartei Bezirk Bülach	Verein
5206	Stiftung Lindenhof Oftringen	Stiftung
5217	Korporation Sachseln	Oeffentlich-rechtlich
5334	Globale Gesundheit	Parlamentarische Gruppe
5420	Sterbe- und Unterstützungskasse des Verbandes Schweizerischer Polizei-Beamter	Stiftung
5427	Freiburger Verband der spezialisierten Institutionen	Verein
5399	Stiftung Kulturzentrum päpstliche Schweizergarde	Stiftung
5356	Stiftung für die Symphoniekonzerte und das Stadtorchester Winterthur	Stiftung
5461	Stiftung Forum Pfarrblatt der katholischen Kirche im Kanton Zürich	Stiftung
5282	Schweiz - Georgie	Parlamentarische Freundschaftsgruppe
5287	Radio Fiume Ticino SA	AG
5487	Schweizerische Volkspartei Wahlkreisverband Thun	Verein
5545	Verein Winteruniversiade 2021 Luzern-Zentralschweiz	Verein
5584	ZIWAWA GmbH	GmbH
5107	simsa - Swiss Internet Industry Association	Verein
5559	Institut für Rechtswissenschaft und Rechtspraxis der Universität St. Gallen	Oeffentlich-rechtlich
5360	Interwetten Gaming Ltd.	AG
5635	Arbeitgebervereinigung Romanshorn und Umgebung	Verein
5676	Gemeinde Köniz	Staatlich
5574	IG Nachhaltige Geburtshilfe	Verein
5712	Swiss Life AG	AG
5603	City Carburoil SA	AG
5174	Interkantonaler Verband für Arbeitnehmer	Verein
5736	Parlamentarische Gruppe Klimaänderung	Parlamentarische Gruppe
5769	Gesellschaft zum Zytturm	Verein
5800	Stiftung Licht Recycling Schweiz SLRS	Stiftung
5824	Bern Welcome AG	AG
5852	Feriendorf Blatten-Belalp AG	AG
5908	Stiftung Contact	Stiftung
5919	Genossenschaft "Edition Exodus"	Genossenschaft
3586	Vereinigung Berner Division	Verein
3670	Kantonale Steuerrekurskommission Obwalden	Ausserparlamentarische Kommission
3688	Liberty 1e Flex Investstiftung	Stiftung
3694	Associazione Generazioni & Sinergie	Verein
3721	Gebäudeversicherungskommission des Kantons Uri	Staatlich
3763	Schule für Holzbildhauerei	Staatlich
3776	Linguissimo	Informelle Gruppe
3802	Phaor AG	AG
3813	Handelskammer Deutschland-Schweiz	Verein
3741	Insel Gruppe Management AG	AG
3870	Verein Femmes-Tische und Väter Foren	Verein
3893	Schweiz - Korea	Parlamentarische Freundschaftsgruppe
3908	Klinik Adelheid AG	AG
3960	Politbüro Kampagnen & Webdesign	Einzelunternehmen
3974	Médecins Sans Frontières	Verein
3863	Mittelland Transport AG	AG
3994	apisuisse	Verein
4017	Audiatur-Stiftung	Stiftung
4058	Verein Arud	Verein
4089	Centre neuchâtelois d'intégration professionnelle	Oeffentlich-rechtlich
4098	Lokalfernsehen Diessenhofen	Stiftung
4048	AEE Suisse Bern	Verein
4118	JACiD GmbH	GmbH
4160	Eidgenössisches Departement für Verteidigung, Bevölkerungsschutz und Sport	Staatlich
4168	Association caddie service	Verein
4193	Verein Swissdec	Verein
4230	Internationales Kulturforum Disentis	Verein
4261	Panorama	Einzelunternehmen
4274	Société de développement du Centre	Verein
4305	Verein zur Förderung der Lehrstellenvermittlung in der Schweiz	Verein
4323	Primeo Holding AG	AG
4347	Verzasca SA	AG
4371	CENTOVENTUNO SA	AG
4396	Schweizerische Verkehrswissenschaftliche Gesellschaft	Verein
4413	Beratungsstelle für Sans-Papiers Bern	Verein
4446	Stiftung PRO SENECTUTE THURGAU	Stiftung
4434	Plan International Schweiz	Verein
4483	Werkstatt Chur	Verein
4501	Gebet für die Schweiz	Verein
4532	Kultur- und Kunstverein Pic-o-pello	Verein
4548	Verein Theater PurPur	Verein
4571	TTH SA en liquidation	AG
4596	Consulenza Armin Menzi	Einzelunternehmen
4554	Ventana Medical Systems Inc.	AG
4635	Genossenschaft swissherdbook Zollikofen	Genossenschaft
4656	Schweizerischer Schafzuchtverband Genossenschaft	Genossenschaft
4678	Arbeitsgemeinschaft der Berufsverbände landwirtschaftlicher Angestellter	Verein
4726	CHOCOSUISSE, Verband Schweizerischer Schokoladefabrikanten Genossenschaft	Genossenschaft
4719	Schweizerischer Apothekerverband (pharmaSuisse)	Verein
4722	Swiss Society of Addiction Medicine	Verein
4782	Verband für anthroposophische Heilpädagogik und Sozialtherapie	Verein
4749	Swissmedic, Schweizerisches Heilmittelinstitut	Oeffentlich-rechtlich
4802	ACS Sektion Liechtenstein	Verein
4829	Goldbach Neo OOH AG	AG
4847	Verband der privaten Postdienstleister	Verein
4875	Swiss International Air Lines AG	AG
4855	Organisme de Surveillance pour Intermédiaires Financiers & Trustees SO-FIT (Supervisory Organisation for Financial Intermediaries & Trustees SO-FIT)	Verein
4922	Benevol Thurgau	Verein
4941	Komitee SBB Pro Juralinie	Informelle Gruppe
4962	GRUPPO MULTI SA	AG
4968	Verein "Für aktive Senioren"	Verein
4837	Glarner Wirtschaftskammer	Verein
5023	Solafrica	Verein
5036	Gemeinde Zofingen	Staatlich
5046	Hope Organisation for People and Education	Verein
5120	Die dargebotene Hand Ostschweiz und Fürstentum Liechtenstein	Verein
5087	Holzbau Schweiz Verband Schweizer Holzbau-Unternehmungen	Verein
5140	Bertholdia Burgdorf	Verein
5152	FC Naters Oberwallis AG	AG
5241	Kantonal-Schwyzer Turnverband	Verein
5277	TAW Immobilien AG	AG
5321	Komitee "Rettet den Käfigturm"	Informelle Gruppe
5227	Trägerverein Quartiertreffpunkt Kasernenareal	Verein
5426	Lungenliga Freiburg	Verein
5392	Association Choisir La Vie	Verein
5401	AGROLA AG	AG
5357	Aufsichtskommission für den Ausgleichsfonds der Arbeitslosenversicherung	Ausserparlamentarische Kommission
5418	Arbeitsgemeinschaft für eine wirksame und friedenssichernde Milizarmee	Verein
5516	BSC Association	Verein
5481	Verein Green Building Schweiz	Verein
5486	Schweizerische Volkspartei Sektion Uetendorf	Verein
5298	CVP Engelberg	Verein
5502	Bergwerk Käpfnach	Verein
5591	Alumni UNIGE	Verein
5558	Sozialdemokratische Partei Kanton Freiburg	Verein
5658	Fondazione Farguis	Stiftung
5567	Stadt Schlieren ZH	Staatlich
5570	OK Klausenrennen in Liquidation	Verein
5116	Parlamentarische Versammlung der Frankophonie	Staatlich
5247	Stiftung Pro Handicap	Stiftung
5721	Stiftung Schweizer Schule Rom	Stiftung
5729	Commune d'Epalinges	Staatlich
5740	Corum Vermögensverwaltung AG	AG
5744	Home Instead Holding AG	AG
5579	WASAX AG	AG
5644	Personalfürsorgefonds der AEK Energie AG in Liquidation	Stiftung
5902	Club zum Rennweg AG	AG
5856	Spendenverein Bärgüf	Verein
5812	VPOD Sektion Luzern	Verein
5820	Schweizer KMU-Tag	Informelle Gruppe
5946	Medienkritik Schweiz	Verein
5955	Wohnen im Alter Unterschächen	Stiftung
5981	Sidus Consulting GmbH	GmbH
5373	Alumni des Vereins der Offiziere an der Universität St. Gallen	Verein
6011	European Trade Union Confederation (ETUC)	Verein
3650	Schweizerische Konferenz der kantonalen Erziehungsdirektoren	Staatlich
3672	Die Mitte Obwalden	Verein
3570	Berner Schiesssportverband	Verein
3707	Fondation de la métallurgie vaudoise du bâtiment (FMVB)	Stiftung
3730	Zentrum Schönberg AG	AG
3752	Swiss Alps 3000	Verein
3768	REBAG AG	AG
3770	Reller Holding AG	AG
3812	Roche Kapitalmarkt AG	AG
3848	Schweizerische Studienstiftung Fonds für begabte junge Menschen	Stiftung
3869	Kanton Basel-Stadt	Staatlich
3902	Tagesschule Elementa AG	AG
3871	Giezendanner Köln GmbH	GmbH
3937	Personalvorsorgestiftung der Mowag Motorwagenfabrik AG	Stiftung
3965	Humanrights.ch / MERS	Verein
3984	L-2 VD Sàrl	GmbH
3832	Fidasol SA	AG
4006	GSCGI, GROUPEMENT SUISSE DES CONSEILS EN GESTION INDEPENDANTS	Verein
4031	HANDELSKAMMER SCHWEIZ-MALTA	Verein
4037	Contempo	Verein
4081	Technische Gesellschaft Zürich	Verein
4111	Landwirtschaftlicher Klub der Bundesversammlung	Parlamentarische Gruppe
4131	Progrès Versicherungen AG	AG
4107	Spenglerfonds zur Fürsorge für alte landwirtschaftliche Dienstboten	Stiftung
4171	Pensionskasse Accu Oerlikon in Liquidation	Stiftung
4181	UBS Group AG	AG
4215	Radio VOLARE GmbH	GmbH
4245	IG Zivilflugplatz Dübendorf NEIN	Informelle Gruppe
4250	Maurer Partner Communications AG in Liquidation	AG
4285	Gesellschaft für Schweizerische Kunstgeschichte (GSK)	Verein
4311	Event Center GmbH in Liquidation	GmbH
4329	EBM RESEAU DE DISTRIBUTION SAS	AG
4348	Hockey Club Lugano SA	AG
4369	Ramp Beratung SA	AG
4391	AVA Altenrhein	Verein
4417	AUTOSILO PIAZZA CASTELLO SA	AG
4443	Paroisse des Hautes-Joux	Staatlich
4447	Gewerbeverein Frauenfeld	Verein
4477	Società cooperativa per la radiotelevisione svizzera di lingua italiana (CORSI)	Genossenschaft
4498	Religiös-Sozialistische Vereinigung der Deutschschweiz	Verein
4529	Forschungsinstitut für biologischen Landbau (FiBL)	Stiftung
4515	SWICA Management AG	AG
4566	Städtekonferenz Mobilität	Verein
4605	Stiftung tunSchweiz	Stiftung
4624	Unione contadini ticinesi	Verein
4652	BNJ FM SA	AG
4664	Delley Samen und Pflanzen AG	AG
4689	Verband kollektiver Getreidesammelstellen der Schweiz	Verein
4707	Steffen-Ris AG	AG
4760	Orphanet Schweiz	Informelle Gruppe
4696	Département de l'économie et du sport canton de vaud	Staatlich
4794	ACS Sektion Bern	Verein
4752	Landwirtschaftliche Organisation Seeland	Verein
4814	ASCO Association of Management Consultants Switzerland	Verein
4830	Lionbridge Switzerland AG	AG
4861	Nestor Immobilien AG	AG
4878	Swissmem	Verein
4907	WWF Zürich	Verein
4927	Allianz "Nein zur Milchkuh-Initiative"	Informelle Gruppe
4946	ESPRIT MONT-SOLEIL Nature humaine	Verein
4970	Mieterinnen- und Mieterverband Nord-Vaudois	Verein
4969	FONDATION "LA LITTERATURE EN COULEURS"	Stiftung
5000	Parlamentarische Freundschaftsgruppe Schweiz - Kroatien	Parlamentarische Gruppe
5026	Spar- und Leihkasse Bucheggberg AG	AG
5015	Sabesa SA	AG
5048	Parlamentarische Freundschaftsgruppe Schweiz - Katalonien	Parlamentarische Gruppe
5121	Appenzellischer Turnverband	Verein
5131	Bruderschaft des Greyerzer Käses	Verein
5188	Freischütz Immobilien AG	AG
5153	Surseer Woche AG	AG
5204	BVG	Parlamentarische Gruppe
5208	MARVINPAC SA	AG
5329	Skiclub Krattigen	Verein
5231	Dokumentationsstelle Atomfreie Schweiz	Verein
5425	Applico (Stiftung für Menschen mit psychischer Beeinträchtigung)	Stiftung
5430	Mittelschul- und Berufsbildungsamt Kanton Zürich	Staatlich
5404	Postagenturverband	Verein
5412	Schweizerische Stiftung der Kakao- und Schokoladewirtschaft	Stiftung
5465	Fondazione Amici di AMCA	Stiftung
5520	Nein-Komitee Gegenvorschlag zur Anti-Stau-Initiative	Informelle Gruppe
5480	Kaiser AG	AG
5292	Allianz Gesunde Schweiz	Verein
5493	Vereinigung aktiver Senioren- und Selbsthilfeorganisationen der Schweiz	Verein
5583	Seitz Handels- und Kaderschule AG	AG
5589	ellips public affairs & consulting sàrl	GmbH
5625	Fairdruck AG	AG
5564	Fondation de soutien à Plateforme 10	Stiftung
5242	Turnverein Pfäffikon-Freienbach	Verein
5675	Förderverein Reitschule	Verein
5117	Association Défense du français	Verein
5714	Swiss Family Business	Verein
5249	Freunde lebendiges Kreuzlingen	Verein
5604	Monte Tamaro SA	AG
5741	Schweizerische Gesellschaft Technik und Armee (STA)	Verein
5745	RepRisk AG	AG
5822	PERSPEKT GmbH	GmbH
5849	EnBAG Kombiwerke AG	AG
5882	Schweizerische Vogelwarte Sempach	Stiftung
5371	Schweizerischer Katholischer Presseverein	Verein
5917	Rosengasse Olten AG	AG
5891	Handwerker- und Gewerbeverein Wädenswil	Verein
5934	Verein Wohnräume Sennwald	Verein
5953	PLR Les Libéraux-Radicaux Lutry	Verein
5976	Parlamentarische Gruppe Start-up	Parlamentarische Gruppe
5995	Holdigaz Production SA	AG
6009	Interessengemeinschaft öffentlicher Verkehr Oberaargau	Verein
6025	Schützengesellschaft Hergiswil	Verein
3572	Frienisberg - üses Dorf Genossenschaft	Genossenschaft
3705	Philos Assurance Maladie SA	AG
3742	Insel Gruppe AG	AG
3761	ASS-Academy GmbH	GmbH
3784	OSEO Genève	Verein
3804	Roche Diabetes Care AG	AG
3827	Rabbit-Air AG	AG
3851	Young European Swiss YES	Verein
3900	ASSOCIATION PRO ZERO TWO TWO, en liquidation	Verein
3906	Institut Dr. Pfister AG in Liquidation	AG
3938	General Dynamics European Land Systems	AG
3957	IG Lebensraum Klettgau	Informelle Gruppe
3975	EcoSolidar	Verein
3990	FreiCom GmbH	GmbH
3999	Grünau AG	AG
4016	Elinex Holding AG	AG
4036	Rechtsberatungsstelle für Asyl- und Ausländerrecht Schaffhausen	Oeffentlich-rechtlich
4079	Konferenz Hochschuldozierende Schweiz	Informelle Gruppe
4078	Forum Tabakprävention und Behandlung der Tabakabhängigkeit in Gesundheitsinstitutionen Schweiz	Verein
4116	Sozialdemokratische Partei Broye	Verein
4144	Suisseculture	Verein
4170	La Virgule	Verein
4180	UBS Foundation of Economics in Society	Stiftung
4194	Forstunternehmer Schweiz	Verein
4224	Schweizerische Akademie der Geistes- und Sozialwissenschaften SAGW	Verein
4256	Schweizerischen Bankpersonalverband SBPV	Verein
4284	Winterhilfe Kanton Zürich	Verein
4290	Gesellschaft für das Schweizerische Landesmuseum	Verein
4308	Game Assist AG	AG
4338	Verband Schweizer Fachjournalisten	Verein
4359	SG Concordia	Verein
4378	Fondazione Ing. Elvezio e Antonio Pagani	Stiftung
4388	Regio Appenzell AR - St.Gallen - Bodensee	Verein
4424	Ordine dei Notai del Cantone Ticino	Oeffentlich-rechtlich
4454	Thurgauer Arbeitsgemeinschaft für Elternorganisationen	Verein
4470	Metropolitanraum Zürich	Verein
4491	Lungenliga Solothurn	Verein
4509	Bierig GmbH	GmbH
4537	Naturschutzverein Stadt St. Gallen und Umgebung	Verein
4555	Bio Veris Corporation	GmbH
4574	Meliofeed AG	AG
4607	Forum Einstein	Informelle Gruppe
4633	Fédération suisse du franches-montagnes	Verein
4648	Jubiläums-Stiftung des Bankhauses La Roche & Co.	Stiftung
4584	GSTF Gesellschaft Schweizerisch- Tibetische Freundschaft	Verein
4683	Maschinenring Schweiz	Verein
4695	3 B Holding AG	AG
4713	Ernst Sutter AG	AG
4769	inclusione andicap ticino	Verein
4778	Integras, Fachverband Sozial- und Sonderpädagogik	Verein
4754	Schweizerische Genossenschaft der Weich- und Halbhartkäsefabrikanten (SGWH)	Genossenschaft
4804	Bosch Automotive Service Solutions AG in Liquidation	AG
4827	Chemolio Holding AG	AG
4844	Industrie- und Handelskammer Thurgau (IHK Thurgau)	Verein
4870	SIX Group AG	AG
4860	ESCO PROJEKT AG	AG
4917	Genossenschaft Pressverein Frauenfeld	Genossenschaft
4937	Stiftung Sedlmayer-Lips	Stiftung
4964	Banca Raiffeisen Locarno società cooperativa	Genossenschaft
4974	Grundrechte.ch	Verein
4995	Evangelisch-methodistische Kirche Zentralkonferenz Süd- und Osteuropa	Verein
5011	Schweizerische Volkspartei Winterthur	Verein
5039	Schweiz - ALBA	Parlamentarische Freundschaftsgruppe
5049	Schönholzer Transport AG	AG
5081	Fondation du Centre de Formation et de Développement - Virgile	Stiftung
5136	Jungfreisinnige Burgdorf-Emmental	Verein
5184	pfadijugendhuus ballwil	Verein
5199	Pro Kultur Olten	Verein
5205	Parlamentarische Damen Sportgruppe	Parlamentarische Gruppe
5318	Reformierte Kirchen Bern-Jura-Solothurn	Staatlich
5223	eco.ch - Schweizer Forum für nachhaltige Entwicklung	Verein
5377	Jubla Freiburg Kantonslager 2017	Verein
5423	FDP.Die Liberalen Frauen Kanton Schwyz	Verein
5397	Amicale des encaveurs bramoisiens	Verein
5354	Vereinigung schweizerischer Erdgaskonsumenten	Verein
5458	Schweizerischer Verein für Pflegewissenschaft (VFP)	Verein
5466	Fondazione per il bambino malato della Svizzera italiana	Stiftung
5515	Microcrédit Solidaire Suisse - Fondation Georges Aegler pour la création d'entreprises	Stiftung
5284	MediaTi Marketing SA	AG
5291	Nichtübertragbare Krankheiten NCD	Parlamentarische Gruppe
5492	Plattform Land Südtirol	Verein
5101	Arbeitsgemeinschaft zur Förderung des Futterbaues AGFF	Verein
5553	Raiffeisenbank See-Lac Genossenschaft	Genossenschaft
5598	PK BAU Pensionskasse für das erweiterte Baugewerbe Region Basel in Liquidation	Stiftung
5661	Società Anonima Immobiliare Sportiva	AG
5668	Flugplatzkomitee Nidwalden	Verein
5678	ara region bern ag	AG
5685	Partei der Arbeit Kanton Neuenburg	Verein
5578	ZIWAS GmbH	GmbH
5172	WaldSchweiz - Verband der Waldeigentümer	Verein
5705	Kinofoyer Lux	Verein
5710	Hadia Medical Swiss	Verein
5771	NEROS - Netzwerk mineralische Rohstoffe Schweiz	Verein
5845	Le Chardon Bleu SARL	GmbH
5252	European Youth Parliament Switzerland	Verein
5898	Gastro ZH Betriebs GmbH	GmbH
5911	Kommission für Sozial- und Existenzsicherungspolitik des Kantons Bern	Ausserparlamentarische Kommission
5260	Anwalts- und Notariatspraxis Karl Vogler	Einzelunternehmen
5927	Blutspende SRK Schweiz AG	AG
5896	Floor GmbH	GmbH
5966	Pferd	Parlamentarische Gruppe
5984	Bulliard Holding SA	AG
5645	AEK onyx AG	AG
6016	Verein bioabi	Verein
3568	Nie wieder Atomkraftwerke - NWA Schweiz	Verein
3698	Associazione NOI	Verein
3748	Berner Oberland-Bahnen AG	AG
3760	Rollbeton Giezendanner AG	AG
3780	Fondation Auxiliaire du Conservatoire botanique de la Ville de Genève	Stiftung
3789	Verein Slow Food Schweiz	Verein
3828	Ida Barell-Stiftung	Stiftung
3852	Zunftgesellschaft zu Metzgern	Verein
3884	Comité pour l'avortement libre et gratuit	Verein
3918	Stiftung für hochbegabte Kinder	Stiftung
3930	Zürcher Bankenverband	Verein
3954	Schweiz - EU	Parlamentarische Freundschaftsgruppe
3971	Netzwerk Haushälterische Bodennutzung	Verein
3861	BDP Fraubrunnen	Verein
3835	Terremploi Sàrl	GmbH
4009	MHN Treuhand AG	AG
4042	Mittagstisch Hallau	Verein
4059	Städte-Allianz öffentlicher Verkehr Ost- und Zentralschweiz	Verein
4074	Schweizer Berufsverband der Pflegefachfrauen und Pflegefachmänner	Verein
4112	Schweizerische Volkspartei Bezirk Kreuzlingen	Verein
4127	Cinema Teatro Blenio	Verein
4051	MRI Zentrum Männedorf AG	AG
4166	Société coopérative d'habitation La Lancéenne I	Genossenschaft
4151	MG Malerei GmbH	GmbH
4196	YSA Management Sàrl	GmbH
4229	Schweizerische Alzheimervereinigung Graubünden	Verein
4228	Casa sogn Giusep Cumpadials	Stiftung
4272	Fondation d'aide sociale et culturelle du Canton de Vaud	Stiftung
4289	Fondazione Lingue e Culture	Stiftung
4299	Schweizerischer Verband Für Seniorenfragen	Verein
4331	Primeo Wärme AG	AG
4352	Team Ticino	Verein
4362	Nüm par Milí	Informelle Gruppe
4393	Städtisches Korn- und Lagerhaus Rorschach	Oeffentlich-rechtlich
4420	Fondazione Ragioni Critiche	Stiftung
4450	Regio Frauenfeld Tourismus	Verein
4435	Verein Dialog EMRK	Verein
4484	WWF Graubünden	Verein
4503	Landeskirchen-Forum	Verein
4518	ProVAG Versicherungen AG	AG
4523	GastroSocial Pensionskasse	Stiftung
4569	Landor AG	AG
4582	SwissOil Romandie	Verein
4611	Bauernverband Nidwalden	Verein
4650	Westschweizer Regionalradios RRR	Verein
4662	Fédération Vaudoise des Vignerons	Verein
4585	Vereinigung Schweizer Weinhandel	Verein
4717	Föderation der Schweizer Psychologinnen und Psychologen	Verein
4711	Michel Comestibles AG	AG
4764	Association Suisse Romande Intervenant contre les Maladies neuro-Musculaires	Verein
4781	Special Olympics Switzerland	Stiftung
4759	ProRaris Alliance Maladies Rares - Suisse	Verein
4321	AEB Alternativ-Energie Birsfelden AG	AG
4816	Association Suisse des fabricants et commerçants de métaux précieux (ASFCMP)	Verein
4833	Electrosuisse, Verband für Elektro-, Energie- und Informationstechnik	Verein
4866	Schweizerischer Kosmetik- und Waschmittelverband SKW	Verein
4891	Verband Schweizerischer Werbegesellschaften	Verein
4920	Barockkirche Fischingen	Verein
4936	propatient Forschungsstiftung Universitätsspital Basel	Stiftung
4951	Association des parents d'élèves de Delémont et environs	Verein
4989	Solsana AG	AG
4801	ACS Sektion Graubünden	Verein
5005	Natur Umwelt Rümlang	Verein
5037	Gemeinde Bourg-en-Lavaux	Staatlich
5045	Ringier Axel Springer Schweiz AG	AG
5077	KV Bildungsgruppe Schweiz	Verein
5088	Schweizer Buchhandels- und Verlags-Verband SBVV	Verein
5146	La Charmaie SA	AG
5198	Living Museum Verein	Verein
5306	Forum für Universität und Gesellschaft	Informelle Gruppe
5210	FDP Die Liberalen Zofingen (Ortspartei)	Verein
5220	Trägerverein "600 Jahre Niklaus von Flüe 2017"	Verein
5338	Association Foyers de l'Espérance "Emeraude de la réconciliation-olivier de la paix"	Verein
5382	Easy Sana Assurance Maladie SA	AG
5398	Tennis Club Bramois	Verein
5403	Ammann Beratreu GmbH	GmbH
5409	Agefi Com SA	AG
5508	Global Forum Wallis	Informelle Gruppe
5518	Banque cantonale neuchâteloise	Oeffentlich-rechtlich
5285	Società Editrice del Corriere del Ticino SA	AG
5538	TSCHUDIN AG	AG
5499	Naturschutzverein Horgen	Verein
5505	swiss-sport.ch marketing ag in Liquidation	AG
5555	Abwasserverband ARA Region Kerzers	Oeffentlich-rechtlich
5629	Verein Kompetenz-Zentrum Erneuerbare Energie-Systeme Thurgau (KEEST)	Verein
5601	BastA! Baselsstarke Alternative	Verein
5671	Pensionskasse des Bundes PUBLICA	Oeffentlich-rechtlich
5573	Wahlkomitee Werner Hösli	Informelle Gruppe
5246	Evangelische Synode des Kantons Thurgau	Staatlich
5602	Europäischer Radsportverband	Verein
5730	CABO VERDE Stiftung für Bildung	Stiftung
5607	Area di servizio City Moesa SA	AG
5614	Fondazione Egidio e Mariangela Cattaneo	Stiftung
5726	Axpo Power AG	AG
5874	Parlamentarische Freundschaftsgruppe Schweiz - Weissrussland	Parlamentarische Gruppe
5367	Gemeinde Binningen	Staatlich
5804	Swissaid Zürich	Verein
5914	Sustainable Development Solutions Network Switzerland	Informelle Gruppe
5924	OdA Abfall- und Rohstoffwirtschaft	Verein
5943	Bau- und Wohngenossenschaft im Gleis BIG	Genossenschaft
5830	Ernst & Young AG	AG
5835	Kaminfegergeschäft Lüdi GmbH	GmbH
5989	Bauen digital Schweiz	Verein
6007	Kontaktgremium Sicherheit Kanton-Gemeinden	Staatlich
3783	Fondation d'art dramatique de Genève	Oeffentlich-rechtlich
3818	Zusatzvorsorge der F. Hoffmann-La Roche AG	Stiftung
3793	Evaluanda SA	AG
3846	Bündnis für mehr Transparenz in der Politikfinanzierung	Verein
3890	nebag ag	AG
3923	Stiftung St. Martin	Stiftung
3942	Sharaf al Bait / The Deerhunters	Einfache Gesellschaft
3963	Swiss Music Export	Verein
3982	Kein Atommüll im Ballungsgebiet Aarau-Zofingen	Verein
3864	RTW - Recycling Transport AG	AG
4011	Eltaver GmbH	GmbH
4030	Handelskammer Schweiz-USA	Verein
4064	Circus Balloni GmbH	GmbH
4072	Parliamentarians for Nuclear Non-Proliferation and Disarmament	Verein
4100	Spitex Hallau	Verein
4125	Mehrwertsteuer-Konsultativgremium des eidg. Finanzdepartements	Ausserparlamentarische Kommission
4147	Artlink	Verein
4167	Coopérative du Gué	Genossenschaft
4183	Global Diplomacy Lab	Verein
4189	TC Morgins	Verein
4219	Immochem AG	AG
4242	Verband Zürcher Schulpräsidien	Verein
4276	Association...E la Nave Va	Verein
4310	Horisberger Import & Export	Einzelunternehmen
4293	Projekt Fels	Informelle Gruppe
4335	EBM Thérmique SAS	AG
4355	Federazione Cacciatori Ticinesi	Verein
4379	Consorzio Acquedotto regionale del Mendrisiotto (ARM)	Staatlich
4403	SCL Helvetia AG in Liquidation	AG
4411	Sol de Primavera	Verein
4429	bitmedia (Schweiz) AG	AG
4437	Interessengemeinschaft Contact Netz Region Oberaargau-Emmental	Informelle Gruppe
4482	VCS Graubünden	Verein
4504	Bund Schweizer FarbgestalterInnen in der Architektur	Verein
4522	Curlingclub Kandersteg	Verein
4549	PKE Pensionskasse Energie Genossenschaft in Liquidation	Genossenschaft
4570	Fertag France SA	AG
4599	FDP Die Liberalen Baselland	Verein
4620	Schaffhauser Bauernverband	Verein
4629	Chambre Neuchâteloise d'Agriculture et de Viticulture (CNAV)	Verein
4657	Schweizerischer Ziegenzuchtverband (SZZV) Genossenschaft	Genossenschaft
4671	Landwirtschaftliche Bürgschaftsgenossenschaft Baselland	Genossenschaft
4716	Eve&Rave	Verein
4737	Bundesamt Für Landwirtschaft	Staatlich
4744	Rechtsfakultät der Universität Neuenburg	Staatlich
4698	Läderach Agro AG in Liquidation	AG
4702	Roldag, Romanshorner Lagerhaus und Dienstleistungs AG	AG
4805	Driving Center Schweiz AG	AG
4828	Lindt & Sprüngli (Schweiz) AG	AG
4846	BRUGG GROUP AG	AG
4859	Schubarth + Co. AG	AG
4886	Verband der Schweiz. Zellstoff-, Papier- & Kartonindustrie (ZPK)	Verein
4919	Stiftung Lilienberg Unternehmerforum	Stiftung
4943	Fondation Conseil suisse de la presse	Stiftung
4963	Società per le Ferrovie Autolinee Regionali Ticinesi (FART) Società Anonima	AG
4986	Wen-Do St. Gallen	Verein
4998	Berner Meitschi Blog	Informelle Gruppe
5027	Rechtswissenschaftliche Fakultät der Universität Luzern	Staatlich
5059	Kanton Obwalden	Staatlich
5050	HRS Investment AG	AG
5076	KV Bildungsgruppe Schweiz AG	AG
5130	Aargauischer Verein für Gehörlosenhilfe	Verein
5099	BKW AG	AG
5193	Tagesstätte Sonnegg	Verein
5271	Sozialbehörde Bülach	Staatlich
5307	Das Gebäudeprogramm	Staatlich
5209	CVP Niederwil-Nesselnbach	Verein
5219	Historischer Verein Obwalden	Verein
5376	SICHH Swiss Integrative Center for Human Health SA	AG
5386	Groupe Mutuel Prévoyance-GMP	Stiftung
5350	Sport Club 89	Verein
5444	FVRZ-STIFTUNG	Stiftung
5410	Stiftung zur Förderung der unabhängigen und nachhaltigen Konsumenteninformation	Stiftung
5469	Partito Socialista Sezione ticinese del PSS	Verein
5517	Association du gymnase de soir	Verein
5483	Sozialfonds suissetec	Stiftung
5539	Verein für eine Schweizer Olympiakandidatur	Verein
5548	Natur- und Heimatschutz	Parlamentarische Gruppe
5507	Die Innovationsgesellschaft mbH	GmbH
5621	Mietauto AG	AG
5654	Bürgerprotest Fluglärm Ost	Verein
5109	Schweiz - Ukraine	Parlamentarische Freundschaftsgruppe
5159	Stiftung Schweizerische Wildtierwarte	Stiftung
5681	Infozentrum Eichholz	Verein
5636	Leaderinnen Ostschweiz	Verein
5696	Peter Lang Holding AG in Liquidation	AG
5728	Für ein freiheitliches Waffenrecht	Parlamentarische Gruppe
5737	Digitale Schweiz - Initiative für "Smart Switzerland"	Informelle Gruppe
5746	E.H.L. Holding SA	AG
5364	Gunziger und Partner GmbH in Liquidation	GmbH
5365	Enam Cara Sharif & Co, Hair & Beauty Spa Salon in Liquidation	Einzelunternehmen
5366	CVP Binningen-Bottmingen	Verein
5907	Aids Hilfe Bern	Verein
5259	ZVS/BirdLife Zürich	Verein
5817	Tchendukua Ici et Ailleurs - Suisse	Verein
5945	Institut für Wirtschaftsstudien Basel AG	AG
5831	Bank Vontobel AG	AG
5960	Akademien der Wissenschaften Schweiz	Verein
5988	Smart EnergyLink AG	AG
6002	Association Château de Grimisuat	Verein
5862	Ignaz Staub-Stiftung	Stiftung
5757	Omnitrade Handels AG	AG
5781	TOURISMUS-ORGANISATION INTERLAKEN (TOI)	Verein
5268	BLUWIL SERVICE AG	AG
6038	Kleinbasel _ Kirche für alle	Verein
6076	HILTPOLD architectes	Einzelunternehmen
4809	Société Européenne d'Hôtellerie	AG
4834	Firmenich SA	AG
4852	Möbel-Pfister AG	AG
4868	SGS SA	AG
4890	Verband Schweiz. Hersteller von Suppen und Saucen	Verein
4913	Verband der Waadtländer Bäuerinnen	Verein
4929	Parlamentarische Gruppe für öffentlich-private Partnerschaften PPP	Parlamentarische Gruppe
4957	Schweizerischer Verband der Lebensmitteldetaillisten (Veledes)	Verein
4977	Schweizerische Beobachtungsstelle für Asyl- und Ausländerrecht	Verein
4993	Pädagogische Hochschule (PHGR)	Oeffentlich-rechtlich
5004	Plusport Behindertensport Rümlang	Verein
5035	Fischer Club Basel	Verein
5047	Weinbau	Parlamentarische Gruppe
5082	Allpura - Verband Schweizer Reinigungs-Unternehmen	Verein
5134	Axel Müller Healthcare Advisory GmbH	GmbH
5144	Abbaye des officiers du bat car 1	Verein
5237	Stadt Adliswil	Staatlich
5156	Club économique libéral	Verein
5207	Die Mitte Aargau	Verein
5331	Ambassador Club Niesen	Verein
5342	Die Mitte Solothurn	Verein
5387	Mutuelle Valaisanne de Prévoyance	Stiftung
5394	Vereinigung ehemaliger päpstlicher Schweizergardisten	Verein
5353	Verein Luzerner Stadtlauf	Verein
5408	Verein Landschaftstheater Ballenberg	Verein
5468	Solidarität mit Griechenland!	Verein
5519	Abwasserverband ARA Seeland Süd	Oeffentlich-rechtlich
5531	Junge BDP Kanton Bern	Verein
5488	Schweizerischer Wasserwirtschaftsverband	Verein
5299	GV Angelomontana	Verein
5104	Musikverein Metzerlen	Verein
5594	Bau- und Holzarbeiter Internationale	Verein
5653	Hausverein Ostschweiz	Verein
5633	Diguro AG	AG
5110	Verein Machbarkeit Stiftung Forschung Schweiz	Verein
5162	Mutuelle Neuchâteloise Assurance Maladie	Stiftung
5686	Le Locle	Staatlich
5694	Schweizerischer Alpen-Club SAC Sektion Baldern	Verein
5700	Turnverein Männedorf	Verein
5640	Jugendparlament Aargau	Verein
5609	S'ROK AG	AG
5748	Home Instead Schweiz AG	AG
5846	Gemeinde Naters	Staatlich
5877	Fondation romande pour le cinéma (Cinéforom)	Stiftung
5368	Chaîne des Rôtisseurs - Baillage de Suisse	Verein
5912	Ospedale Regionale di Locarno	Oeffentlich-rechtlich
5814	Jositsch Brunner Rechtsanwälte	Einfache Gesellschaft
5930	World Health Organisation WHO	Verein
5936	Swiss Prime Concepts AG	AG
5942	Informationsstelle für Ausländerinnen-  und Ausländerfragen	Verein
5983	Adrian Amstutz	Einzelunternehmen
5374	Sozialdemokratische Partei Zürich 4	Verein
6008	Polizeiverband Bern-Kanton	Verein
6019	Schweizerische Volkspartei Kriens	Verein
5970	Schweiz - Moldawien	Parlamentarische Freundschaftsgruppe
5788	Stiftung COURAGE	Stiftung
6031	PRO LIFE	Verein
6054	Förderverein für Kinder mit seltenen Krankheiten	Verein
6070	BDP Kanton Aargau	Verein
6091	Gemeinde Chiasso	Staatlich
6087	Glacier Express AG	AG
6142	Eidgenössische Koordinationskommission für Familienfragen	Ausserparlamentarische Kommission
6160	Grünliberale Partei Kanton Zürich	Verein
6181	Philanthropos - Institut européen d'études anthropologiques	Verein
6209	GFGZ Gesellschaft zur Förderung der grenzüberschreitenden Zusammenarbeit	Verein
6216	Policlinique médicale universitaire et dispensaire central de Lausanne	Oeffentlich-rechtlich
6243	Tennis-Club Schlieren	Verein
6254	Jujutsu Traditionnel Genève Yama Ryu	Verein
6284	Anny-Klawa-Morf-Stiftung	Stiftung
6305	Coworking Community Bern	Verein
6345	Galenos AG	AG
6335	Sozialdemokratische Partei Bern Süd	Verein
6404	Forum kaufmännischer Berufsfrauen	Verein
6312	AEVIS VICTORIA SA	AG
6375	SimplyScience Stiftung	Stiftung
6356	Conmetec GmbH	GmbH
6524	Fondation Marie-Eléonore d'Olcah	Stiftung
6542	Cannabis Consensus Schweiz	Verein
6364	SelFin Invest AG	AG
6591	Allianz für eine CO2-neutrale Schweiz	Verein
6613	Gönnerverein - Ein Herz für Israel in Liquidation	Verein
6603	Stiftung ecohelp	Stiftung
6506	SwissBoardForum	Verein
6684	Grüne Partei Uster	Verein
6611	Fussball	Parlamentarische Gruppe
6727	Biohof Inselmatt	Einfache Gesellschaft
6738	Verein Niederamt ohne Endlager	Verein
6751	Jugendmusik Glattal	Verein
6774	Pfarrei St. Margaretha	Staatlich
6788	Grünliberale Partei Basel-Stadt	Verein
6816	Stiftung ÖKK	Stiftung
6676	KOLLEKTIV E0B0FF	Einfache Gesellschaft
6844	Tennisclub Elm	Verein
6873	VCS Verkehrs-Club der Schweiz Sektion Zug	Verein
6885	AKKO Gartenbau GmbH	GmbH
6909	Verein NMS Bern	Verein
6935	Wanderwege Graubünden	Verein
6957	TCS Swiss Ambulance Rescue Genève SA	AG
6637	WirtschaftsPortalOst	Verein
6490	ICT Scouts / Campus Förderverein	Verein
7020	Kreisprimarschule Seedorf-Bauen	Staatlich
7047	Flurgenossenschaft Tanne Rüti	Genossenschaft
7071	SWISS EYE NETWORK HOLDING SA	AG
6992	Verein OJA Offene Jugendarbeit Zürich	Verein
7106	Commission cantonale des affaires culturelles du canton de Fribourg	Staatlich
7135	Verein Schweizerisches Landwirtschaftsmuseum Burgrain	Verein
7161	Association en faveur de l'Ecole Rudolf Steiner	Verein
4912	FONDATION SAPHIR	Stiftung
4949	Association interprofessionnelle d'intervenants en matière de Maltraitance des Mineurs	Verein
4967	Pedrazzini Campo SA	AG
4991	Nationale Dach-Organisation der Arbeitswelt Gesundheit	Verein
5001	Federas Beratung AG	AG
5010	Solarspar	Verein
5062	Akademische Verbindung Steinacher	Verein
5053	European Healthcare Distribution Association	Verein
5124	Bruderschaft der Poire à Botzi	Verein
5139	FDP Die Liberalen Burgdorf	Verein
5147	Gemeinde Collombey-Muraz	Staatlich
5234	Stiftung Solidarität mit der Welt (SDW)	Stiftung
5274	Europäischer Dachverband der Dienstleistungsanbieter für Menschen mit Behinderungen	Verein
5311	Eidgenössische Kommission für Wohnungswesen	Staatlich
5323	Swiss Chamber Music Festival	Verein
5228	Pro Kasernenareal	Verein
5345	Green Cross International	Verein
5428	Mütter- und Väterberatung des Seebezirks	Verein
5434	Verein "Stop der Hochpreisinsel - für faire Preise"	Verein
5452	Association pour le développement des energies renouvelables	Verein
5417	CVP Frauen Kanton Zürich	Verein
5280	Schweiz - Aserbaidschan	Parlamentarische Freundschaftsgruppe
5527	Fructus, Vereinigung zur Förderung alter Obstsorten	Verein
5485	Tafelgesellschaft zum Goldenen Fisch	Verein
5495	Vereinigung Pferd	Verein
5550	Jugendsession	Verein
5108	Oikos Alumni St. Gallen	Verein
5597	Ausbildungszentrum Reinigung Rickenbach GmbH	GmbH
5659	Associazione Saetta Verde	Verein
5664	FDP Die Liberalen Fällanden	Verein
5673	Grüne Freie Liste der Stadt Bern	Verein
5244	Mietgericht Uster	Staatlich
5690	Stiftung für gemeinnützige Zwecke der ehemaligen Sparkasse Stäfa	Stiftung
5699	Handball Club Gelb Schwarz Stäfa	Verein
5733	Communication at Natalie Rickli	Einzelunternehmen
5739	FC Nationalrat	Verein
5768	IG Zuger Chriesi	Verein
5802	Assoziation Schweizer Psychotherapeutinnen und Psychotherapeuten	Verein
5875	ProVaMM Sagl	GmbH
5853	World Nature Forum, WNF AG in Liquidation	AG
5807	Frieda - die feministische Friedensorganisation	Verein
5811	Verein Radio 3FACH	Verein
5928	Dr. Thomas Zeltner, Health Solutions GmbH	GmbH
5828	Schweizerischer Israelitischer Gemeindebund (SIG)	Verein
5956	Handballklub HC KTV Altdorf	Verein
5962	Parlamentarische Forum nachhaltiges Wirtschaften	Parlamentarische Gruppe
6003	Regenbogenhaus Zürich	Verein
5648	amitola, gemeinnützige GmbH für Kinder	GmbH
5785	Oeschger-Hintermann Stiftung der NHG	Stiftung
5782	Jungfrau Show Parade	Verein
6046	Swiss Entrepreneurs Foundation	Stiftung
6056	Schweizerischer Verband alleinerziehender Mütter und Väter	Verein
6074	femmedia ChangeAssist Fetz	Einzelunternehmen
6089	Stiftung Alpines Energieforschungscenter AlpEnForCe	Stiftung
6085	Oeko-Energie AG	AG
6122	kunstprojekte.ch	Einzelunternehmen
6150	Verein Museum Schaffen	Verein
6174	Die Mitte Region Belp-Gantrisch	Verein
6207	Gesellschaft zur Förderung der Biervielfalt	Verein
6230	Kantonales Musikfest Wallis 2019	Einfache Gesellschaft
6247	Kiwanis Club Aarau	Verein
6271	Neuroth Hörcenter AG	AG
6286	Stiftung SAPA, Schweizer Archiv der Darstellenden Künste	Stiftung
6303	Metamorphoo GmbH	GmbH
6342	Gemeinde La Tour-de-Peilz	Staatlich
6396	Schweizer Alpen-Club SAC Sektion Weissenstein	Verein
6403	Routiers Suisses Sektion Aargau	Verein
6446	Fondation Groupe Mutuel	Stiftung
6455	Transportunternehmungen Zentralschweiz TUZ	Verein
6509	Sozialliberales Forum	Informelle Gruppe
6514	Stadtwohnung Bern AG	AG
6541	Allianz gegen Waffenexporte in Bürgerkriegsländer	Verein
6474	Stiftung Schulmuseum Bern in Köniz	Stiftung
6577	Stiftung zur Förderung einer behindertengerechten, baulichen Umwelt	Stiftung
6565	Swiss Arbitration Centre AG	AG
6584	Sozialdemokratische Partei Biel-Madretsch	Verein
6640	Interessengemeinschaft Weierwisen	Verein
6668	Schweizerische Volkspartei Kanton Zug	Verein
6671	Genossenschaft Konzert und Theater St.Gallen	Genossenschaft
6709	Grüne Oberaargau	Verein
6734	Robi Olten	Verein
6741	Grüne Partei Region Olten	Verein
6773	Windenergie Stierenberg AG	AG
6782	Christlich Soziale Luzern	Verein
6801	Neutraler Quartierverein Oberes Kleinbasel	Verein
6571	Energiapro SA	AG
6841	Glarner Anwalts- und Notarenverband	Verein
6870	Pro Velo Zug	Verein
6884	Kreis Gewässerraum Pflege GmbH	GmbH
6902	Stiftung World Nature Forum WNF	Stiftung
6916	Società Operai Liberali Luganesi	Verein
6940	Stadt Neuenburg	Staatlich
6967	Gastroenterologie Aarau AG	AG
6489	Verein-verj	Verein
7022	Die Junge Mitte Uri	Verein
7044	P. Rechsteiner GmbH	GmbH
6993	Verein Zigeunerkulturtage Zürich	Verein
7084	Réseau Santé Région Lausanne	Verein
7097	Verein Sonnhalde Gempen	Verein
7127	Berner Fachhochschule - Hochschule für Agrar-, Forst- und Lebensmittelwissenschaften	Oeffentlich-rechtlich
7153	Streikversicherungs-Genossenschaft der Maschinenindustrie	Genossenschaft
7173	Cevi Hasle-Rüegsau	Verein
7130	Netzwerk Sozialer Aargau	Einfache Gesellschaft
6388	Panathlon-Club Oberwallis	Verein
4928	Komitee Chance Expo2027 Kanton Thurgau	Informelle Gruppe
4947	Verein Sibir'elles	Verein
4978	APV Jürg Jenatsch	Verein
4994	Sozialdemokratische Partei Gerlafingen	Verein
5021	Alternative für Deutschland	Verein
5014	Bildungskoalition NGO	Informelle Gruppe
5063	Schweizerischer Studentenverein (StV)	Verein
5074	Offiziersgesellschaft des Kantons Zürich	Verein
5128	Angestelltenvereinigung Angestellte ABB	Verein
5093	Konferenz der Kantonalen Aerztegesellschaften	Verein
5150	Parlamentarische Gruppe Schweiz - ASEAN	Parlamentarische Gruppe
5200	Stiftung Linda	Stiftung
5310	Bildungszentrum für Wirtschaft und Dienstleistung Bern bwd	Verein
5319	Verein Inspektorat der Kompostier- und Vergärbranche der Schweiz	Verein
5222	Selbsthilfe Winterthur und Umgebung	Verein
5336	Haute école de santé de Genève	Staatlich
5347	Parlamentarische Gruppe Bosnien Herzegowina	Parlamentarische Gruppe
5437	BDP Stadt Luzern	Verein
5439	Queer Politics	Verein
5411	Schweizerischer Modegewerbeverband	Verein
5512	Association Téléthon Génève	Verein
5479	Kindes- und Erwachsenenschutzbehörde Basel-Stadt	Staatlich
5289	Fondazione amiche e amici della Pro Grigioni Italiano	Stiftung
5491	Interprofession Raclette du Valais AOP	Verein
5582	TFBO GmbH	GmbH
5506	Gymnasialverbindung Rotacher	Verein
5593	Expertenkommission Zweisprachigkeit des Kantons Bern	Ausserparlamentarische Kommission
5627	Mayer-Kuvert Schweiz AG in Liquidation	AG
5632	Ernst Fischer AG, Stahl- und Metallbau	AG
5666	Verband Schweizerischer Handelsschulen	Verein
5113	Audika AG	AG
5164	HRS International AG	AG
5692	Expo Stäfa	Informelle Gruppe
5170	Kanton Appenzell Innerrhoden	Staatlich
5732	Swiss Venture Club	Verein
5738	SAFFRON AG	AG
5611	Motel City San Gottardo Sagl	GmbH
5720	Cerutti Toitures SA	AG
5873	Neue Aargauer Bank AG	AG
5880	Internationale Bachgesellschaft Schaffhausen	Verein
5372	Feusi Bildungszentrum Solothurn AG	AG
5813	Stiftung Innovationspark Zürich	Stiftung
5929	Stiftung swissHADRON	Stiftung
5937	Foundation For Talents	Stiftung
5832	Holcim (Schweiz) AG	AG
5985	Stiftung Heilpädagogisches Zentrum	Stiftung
5998	L'Energie de Sion-Région SA, ESR	AG
5647	Bischof Stampfli Rechtsanwälte	Einzelunternehmen
5752	Association des Amis de L'Hospice du Grand-Saint-Bernard	Verein
5971	Schweiz - Taiwan	Parlamentarische Freundschaftsgruppe
5790	ITMedia GmbH	GmbH
6033	Psychiatrische Universitätsklinik Zürich	Oeffentlich-rechtlich
6057	Unabhängige Fachstelle für Sozialhilferecht	Verein
6105	Kampagnerei Trede	Einzelunternehmen
6115	Handelskammer Schweiz-Afrika	Verein
6138	civicLab Sàrl	GmbH
6163	Forum politique suisse - Die Netzwerkorganisation der Mitte Schweiz	Verein
6183	Zweckverband Sozialdienste Bezirk Dielsdorf	Oeffentlich-rechtlich
6205	Royal Society of Arts	Verein
6227	Zentrum Karl der Grosse	Staatlich
6239	FC Naters	Verein
6270	East West Book Shop, Rentsch & Co	KG
6287	SEBA Bank AG	AG
6304	Politikwissenschaftliche Beratung Urs Vögeli	Einzelunternehmen
6344	Verein graubündenVIVA	Verein
6334	Stiftung Orchestra della Svizzera Italiana	Stiftung
6440	Militärhistorische Stiftung des Kantons Zug	Stiftung
6411	Liberty Anlagestiftung	Stiftung
6355	Immo Kappeler AG	AG
6461	gigme.ch AG in Liquidation	AG
6466	Schweizer Wirtschaft für die Energiestrategie 2050	Verein
6545	Verein Ziel: Nachtzug!	Verein
6546	BLT Baselland Transport AG	AG
6590	Schweizerzeit-Stiftung	Stiftung
6580	Komitee Bahnanschluss Mittelland	Informelle Gruppe
6616	IW Glanzmann AG	AG
6642	Interessengemeinschaft Strasse Solothurn	Verein
6667	Schweizerische Volkspartei Baar	Verein
6624	Fondation du Docip	Stiftung
6711	Stiftung WBM	Stiftung
6650	Farmy AG	AG
6720	Alumni UniBE	Verein
6752	Musikverein Harmonie Schwamendingen	Verein
6776	Stiftung Naturmuseum St.Gallen	Stiftung
6813	Gemeinde Bregaglia	Staatlich
6832	Schweizerische Volkspartei Obwalden	Verein
6838	Zopfi & Partner GmbH	GmbH
6853	Schweizerische Institut für Männer- und Geschlechterfragen GmbH	GmbH
6894	Crossiety AG	AG
6914	Comune di Comano	Staatlich
6937	INLAW Alexandre Zen-Ruffinen SA	AG
6952	Grünliberale Unteres Furttal	Verein
6977	Quartierverein Feldhasen Suhr	Verein
6491	Muntagna 2027	Verein
7033	FMH Consulting Services AG	AG
7058	Kalinga Institut of Social Sience	Stiftung
7077	Fondation intercommunale des communes de Bardonnex, Carouge et Troinex pour le logement de personnes âgées	Oeffentlich-rechtlich
7001	Grünliberale Partei Kanton Waadt	Verein
7114	Geschäftsprüfungskommission der Stadt St.Gallen	Staatlich
7137	Clerezza GmbH	GmbH
7156	vogelfrei gmbh	GmbH
7183	Die Mitte Oberkirch	Verein
6387	Naturparkkäserei Diemtigtal AG	AG
7226	Studentenverbindung Rusana	Verein
7230	Fondation FIFDH	Stiftung
7247	Denner AG	AG
7272	PrivaSphere AG	AG
7279	American Society of International Law	Verein
4965	Commissione Intercomunale dei Trasporti Locarnesi e Vallemaggia	Staatlich
4987	Sozialversicherungsanstalt des Kantons St. Gallen	Oeffentlich-rechtlich
5002	Parlamentarische Gruppe Gebäudetechnik	Parlamentarische Gruppe
5031	OTC Forest	Informelle Gruppe
5060	Schweizerischer Fourierverband	Verein
5052	pharmalog.ch	Verein
5085	Arbeitgeberverband Schweizerischer Papier-Industrieller	Verein
5096	Sozialdemokratische Partei Stadt Genf	Verein
5189	Altersfragen	Parlamentarische Gruppe
5238	Schweizerische Volkspartei Bremgarten b. Bern	Verein
5302	AV Semper Fidelis	Verein
5278	Check Your Chance	Verein
5322	R - 500 Jahre Reformation	Informelle Gruppe
5226	für angelegenheiten gmbh	GmbH
5390	Phytoark SA	AG
5431	Region Oberaargau	Verein
5442	Ringier Sports AG	AG
5407	Reformierte Kirchgemeinde Freiburg	Staatlich
5511	Regierungskonferenz für Militär, Zivilschutz und Feuerwehr	Staatlich
5522	Jugendparlament Stadt Bern	Oeffentlich-rechtlich
5533	Leematten AG	AG
5543	Stiftung für Menschen mit seltenen Krankheiten	Stiftung
5549	Verein Ostschweizer Freunde der Eringerrasse	Verein
5106	UX Schweiz	Verein
5622	Reformierte Fabrikkirche Winterthur	Verein
5628	EHM Elektro AG	AG
5157	Fondation du Casino de Neuchâtel	Stiftung
5571	Immobilien Linthal AG	AG
5245	Journalismus in der Demokratie	Parlamentarische Gruppe
5716	Interessengemeinschaft Stationshalter Schweiz	Verein
5725	Parlamentarische Freundschaftsgruppe Schweiz - Kirgistan	Parlamentarische Gruppe
5639	SVP Arbon	Verein
5709	Messe Zukunft Alter AG	AG
5612	Union Cycliste Internationale	Verein
5843	My Leukerbad AG	AG
5253	Laureus Metro Sports by Blindspot	Informelle Gruppe
5904	My Swiss Green GmbH	GmbH
5258	Showband.ch	Verein
5920	SwissZinc AG	AG
5819	Erich Hess Immobilien AG	AG
5947	Jugend und Wirtschaft	Verein
5957	Medizinische Universität Wien	Staatlich
5839	Schweizerische Diabetes-Stiftung	Stiftung
5375	JUSO Kanton Zürich	Verein
6000	VALIDA.Suisse	Verein
5858	Pfarrei St. Mauritius	Staatlich
5972	Parlamentarische Gruppe Indische Halbinsel	Parlamentarische Gruppe
5269	M. Stähli AG	AG
6040	Verein ehemaliger Schülerinnen und Schüler St. Galler Haushalt- und Landwirtschaftsschulen	Verein
6059	FDP Die Liberalen Bezirk Münchwilen	Verein
6079	Schweizerische Volkspartei Sektion Burgdorf	Verein
6119	Abwasserverband Obere Bibera	Oeffentlich-rechtlich
6133	AZ Zeitungen AG	AG
6154	Kanton Glarus	Staatlich
6176	Kantonalbernische Offiziersgesellschaft	Verein
6192	Forum für Menschenrechte in Israel/Palästina	Informelle Gruppe
6214	Genossenschaft Kalkbreite	Genossenschaft
6245	rph management gmbh	GmbH
6275	VELUX Schweiz AG	AG
6283	Akademischer Fechtclub Bern	Verein
6309	GSMN Suisse SA	AG
6347	FDP Die Liberalen Bezirk Horgen	Verein
6401	Sportschützen Muhen	Verein
6443	Turnverein Menzingen	Verein
6448	Caisse-maladie de la vallée d'Entremont société coopérative	Genossenschaft
6470	Helvetia ruft	Informelle Gruppe
6510	Kantonale Sporthilfe-Kommission Genf	Stiftung
6528	Lugano Istituti Sociali	Oeffentlich-rechtlich
6434	Agrimo AG	AG
6552	Erzählbistro - Ein Begegnungsort für die Betroffenen fürsorgerischer Zwangsmassnahmen	Verein
6578	BERNEXPO AG	AG
6481	Star TV AG	AG
6629	Verein Pro Burg	Verein
6618	Gewerbeverein Nebikon-Altishofen	Verein
6621	Die Mitte Graubünden	Verein
6690	Zentralschweizer BVG- und Stiftungsaufsicht	Staatlich
6712	Maschinengenossenschaft Lauperswil und Umgebung	Genossenschaft
6649	Stiftung Biotopverbund Grosses Moos	Stiftung
6739	Verein Alte Kirche Härkingen	Verein
6765	Stützpunktfeuerwehr Opfikon	Staatlich
6768	Baugenossenschaft Bänklen	Genossenschaft
6804	Neue Helvetische Gesellschaft - Treffpunkt Schweiz, Gruppe Region Basel	Verein
6825	WWF Kanton Luzern	Verein
6840	Glarus hoch3 AG	AG
6858	VéloValais Sàrl	GmbH
6892	Association des diplômés de Changins	Verein
6896	Camarada	Verein
6932	Freunde Theater Chur	Verein
6945	Zuger Sinfonietta	Verein
6378	Stiftung Entschädigungsfonds für Asbestopfer (EFA)	Stiftung
6995	Grüne Partei Stadt Zürich Kreis 3/9	Verein
6985	Le Temps SA	AG
7034	Neurovision consulting Sàrl	GmbH
7056	Fondation des amis du Château de Miécourt (FACMI)	Stiftung
7076	Association de l'EMS "Résidence de Drize"	Verein
7090	Autorité de surveillance LPP et des fondations de Suisse occidentale	Oeffentlich-rechtlich
7110	IG Aktionshalle Graben	Verein
6381	schreiner kilchenmann AG	AG
7147	Clé d'octave	Verein
7178	Bruno Dobler	Einzelunternehmen
7195	Trunz Holding AG	AG
7206	Alternative-die Grünen Kanton Zug	Verein
7223	Schwingklub Flüelen	Verein
7243	Oettinger Davidoff AG	AG
7266	tripunkt GmbH	GmbH
6835	Gemeinde Glarus Süd	Staatlich
7300	Letzibuzäli Zunft	Verein
7311	Le Matin Dimanche	Einfache Gesellschaft
4966	AIPPI Stiftung zur Förderung des Schutzes von geistigem Eigentum	Stiftung
4990	CIPRA Schweiz	Verein
5019	Soins palliatifs Vaud	Verein
5012	VPOD Freiburg	Verein
5041	Schweizerisches Arbeiterhilfswerk SAH Zürich	Verein
5051	HRS Promotion AG	AG
5080	Celaris AG in Liquidation	AG
5095	MSD International GmbH	GmbH
5191	VCS Verkehrs-Club der Schweiz Sektion Solothurn	Verein
5236	Sozialdemokratische Partei Bern Länggasse-Felsenau	Verein
5273	Gewerbeverein Bülach	Verein
5314	Entrepreneurship Center der Universität Bern	Oeffentlich-rechtlich
5224	Fairmedia	Verein
5341	Gemeinde Herbetswil	Staatlich
5389	Fondation Maison St-François	Stiftung
5432	Zukunft Emmental	Verein
5445	LVW Projekt Tokio 2020	Informelle Gruppe
5454	Rebbaufreunde Menzingen	Verein
5463	mamamap	Informelle Gruppe
5279	Schweiz - Russland	Parlamentarische Freundschaftsgruppe
5524	AUF Arbeitsgemeinschaft Unabhängiger Frauen	Verein
5535	Verein 111. Aargauer Kantonalschwingfest Brugg	Verein
5544	Stiftung MICADO	Stiftung
5501	Parc Ela	Verein
5588	edu-suisse	Verein
5624	jugendarbeit.ch	Informelle Gruppe
5657	Città di Lugano	Staatlich
5663	COMUNDO	Verein
5160	Fondation Mutuelle en liquidation	Stiftung
5115	Parlamentarische Gruppe Uhrenindustrie	Parlamentarische Gruppe
5576	Walter-Zwingli-Stiftung	Stiftung
5169	Schweizerische Volkspartei Bezirk Weinfelden	Verein
5731	SwissSign AG	AG
5707	Leuenberger Architekten AG	AG
5181	CSS Verein	Verein
5617	Swiss Cycling	Verein
5848	EnBAG AG	AG
5826	interimsuisse - Vereinigung für Interim Managment	Verein
5901	Swiss Premium Drinks GmbH	GmbH
5913	Swiss Youth for Climate	Verein
5890	Standortförderung Zimmerberg-Sihltal	Verein
5932	Spitex Verband der Kantone St. Gallen, Appenzell Ausserrhoden und Appenzell Innerrhoden	Verein
5897	Hangar Group GmbH	GmbH
5975	Parlamentarische Gruppe Humanitäre Hilfe-IKRK	Parlamentarische Gruppe
5838	Jodelchörli Heimelig Oberkirch	Verein
5992	Chablais Participations SA en liquidation	AG
6015	Arena Oberaargau	Verein
5652	Komed Regio Thurgau	Verein
5863	OF Ingénierie et conseils Sàrl	GmbH
5765	Institut Menzingen	Verein
6032	Marsch fürs Läbe	Verein
6055	Kometian	Verein
6066	Schweizer Stiftung Pro Aero	Stiftung
6106	Sunraising	Verein
6113	Parlamentarische Gruppe UNO/SDGs	Parlamentarische Gruppe
6124	Trampeltier of Love	Informelle Gruppe
6152	IG Genuss	Informelle Gruppe
6178	Vertex Pharmaceuticals (CH) GmbH	GmbH
6203	Pioneers' Club PCU	Verein
6215	ABILIS Nationale interprofessionelle Stammgemeinschaft der Medikation AG	AG
6246	Gesellschaft Schweiz - UNO	Verein
6263	Wohnpark Linthal AG	AG
6290	plusbildung - Ökumenische Bildungslandschaft Schweiz	Verein
6306	Für eine sichere und vertrauenswürdige Demokratie (E-Voting-Moratorium)	Verein
6326	Verein edupool.ch	Verein
6416	Feldmusik Allenwinden	Verein
6405	Holzindustrie Schweiz, Sektion Nordwest	Verein
6445	Groupe Mutuel Holding SA	AG
6469	Solothurner Filmtage	Verein
6459	Eidgenössische Koordinationskommission für Arbeitssicherheit	Ausserparlamentarische Kommission
6360	Moringa Vertrieb GmbH	GmbH
6536	Coordination régionale pour un aéroport de Genève urbain, respectueux de la population et de l'environnement	Verein
6564	Schweizerischer Verein Balgrist	Verein
6480	Stiftung Sovalore	Stiftung
6627	Natur- und Vogelschutzverein Birmenstorf	Verein
6617	Club Sixtysix	Verein
6606	Gemeinde Cortébert	Staatlich
6688	Swisstransplant - Schweizerische Stiftung für Organspende und Transplantation	Stiftung
6646	Fribourg Rando	Verein
6735	Kunstverein Olten	Verein
6653	NetzCourage	Verein
6764	Umweltfreisinnige St.Gallen	Verein
6786	Lausanne à table	Verein
6797	La Gustav - Akademie für aktuelle Musik	Verein
6833	Gemeinde Engelberg	Staatlich
6834	Stiftung Ora et Labora	Stiftung
6857	Gebäudeversicherung Basel-Stadt	Oeffentlich-rechtlich
6882	Stadt Weinfelden	Staatlich
6904	Schweizerische Volkspartei Wahlkreis Mittelland Nord	Verein
6921	Skiclub Mundaun	Verein
6947	eneba GmbH	GmbH
6954	Stadt Solothurn	Staatlich
6979	Swiss Board Network	Einfache Gesellschaft
7016	Heimatschutz Baselland	Verein
7027	Monte Lema SA	AG
7045	FONCADEM-Fondation de prévoyance en faveur des cadres et des employés de commerce de l'industrie horlogère suisse	Stiftung
7069	Association PRISM (Projet de Réseau Intégré de Soins aux Malades)	Verein
6997	Ferienwerk des VPOD	Stiftung
7105	Agglomération mobul	Staatlich
6380	Concours Mondial de Bruxelles Aigle 2019	Verein
7142	RMAF Remontées mécaniques des Alpes Fribourgeoises	Verein
7164	Verein Lernwerk Turgi	Verein
7192	Pro Velo Sursee	Verein
7200	Kunstverein St. Gallen	Verein
7214	Literarische Gesellschaft Zug	Verein
7236	Jugendwohnnetz Juwo	Verein
7259	THE BRIDGE - THE THIRD MILLENIUM TRAINING SA	AG
6679	Grünliberale Partei Kreis 7&8	Verein
4976	Ernährungssouveränität	Parlamentarische Gruppe
4975	Grüne Stadt Zürich	Verein
5003	Behindertenkonferenz Kanton Zürich	Verein
5032	Vereinigung der Freunde des Klosters Einsiedeln	Verein
5043	Haute école de gestion de Genève	Oeffentlich-rechtlich
5054	Groupement Romand de l'Industrie Pharmaceutique	Verein
5127	leadXpro AG	AG
5094	OsteoSwiss	Informelle Gruppe
5151	Italianità	Parlamentarische Gruppe
5201	Arbeitsgruppe für das Studium von Peak Oil und Gas	Verein
5275	Eurogas	Verein
5213	Zivilschutzorganisation Bantiger	Oeffentlich-rechtlich
5330	Schützengesellschaft Krattigen	Verein
5378	Schweizerische Expertengruppe für virale Hepatitis	Verein
5424	UBS AG	AG
5429	agir pour la dignité	Verein
5400	Swissoil	Verein
5450	Pro Solar	Verein
5462	Komitee pro Berthold	Informelle Gruppe
5473	Landwasser AG in Liquidation	AG
5526	Klima Allianz Schweiz	Informelle Gruppe
5536	Zürcher Hochschule der Künste	Staatlich
5547	Verein Zurich Pride Festival	Verein
5552	Fondation en faveur du personnel de la Loterie Romande	Stiftung
5596	Fondazione ECAP	Stiftung
5656	Parti Socialiste Jurassien	Verein
5362	Association des Amis du CIMA (Musée du Centre International de la Mécanique d'Art)	Verein
5112	Parco Industriale e Immobiliare SA, Giornico in liquidazione	AG
5684	Schweizerischer Verband der Immobilienwirtschaft Zentralschweiz	Verein
5167	"Sicher mobil im Alter"	Informelle Gruppe
5698	Tiefbauamt des Kantons Zürich	Staatlich
5703	Forschung für Leben	Verein
5178	Zytglogge Verlag AG	AG
5182	Kinderanwaltschaft Schweiz	Verein
5799	Stiftung SENS	Stiftung
5251	Insieme Thurgau	Verein
5255	HandballSportClub Kreuzlingen	Verein
5905	Le mot pour dire	Einzelunternehmen
5887	Stiftung grow	Stiftung
5923	Interessengemeinschaft Nassaustrag	Verein
5266	Urex AG	AG
5963	Gebärdensprache	Parlamentarische Gruppe
5977	Wald und Holz	Parlamentarische Gruppe
5994	Holdigaz Prestations SA	AG
5842	Autobus AG Liestal Öffentlicher Verkehr	AG
6024	Schützengesellschaft Kriens	Verein
5860	Stiftung Hochschule Luzern	Stiftung
5777	Konferenz der Sprachdienste der Bundesverwaltung	Staatlich
5763	Fürstentum Liechtenstein	Staatlich
6050	Verein Pro Riet Rheintal	Verein
6077	Pro Familia Fribourg	Verein
6109	LYMO SA, en liquidation	AG
6120	Schweiz - Indien	Parlamentarische Freundschaftsgruppe
6139	SWISS RISK & CARE SA	AG
6165	bureau K. SA	AG
6182	VPOD Region Basel	Verein
6195	SVP Appenzell Ausserrhoden	Verein
6220	Res Publik	Verein
6255	Alpenparlament	Verein
6268	Gemeinde Minusio	Staatlich
6289	Hochalpines Institut Ftan AG	AG
6316	Röntgenplatz-Fest	Informelle Gruppe
6325	Forum Demokratie und Menschenrechte	Informelle Gruppe
6398	Nationale Informationsstelle zum Kulturerbe NIKE	Verein
6350	5620.ch GmbH	GmbH
6450	Verband Medien mit Zukunft	Verein
6484	Förderverein für Freiwilligenarbeit Gesundheit und Alter, Rapperswil-Jona	Verein
6464	Politnetz AG in Liquidation	AG
6532	Waldbesitzervereinigung Obersimmental-Saanenland	Verein
6543	Bündnis für ein Verbot von Kriegsgeschäften	Verein
6553	Spinas Civil Voices AG	AG
6437	Weiterbildung	Parlamentarische Gruppe
6600	Fondation l'EssentiElles	Stiftung
6482	Initiativkomitee Kindes- und Erwachsenenschutz Initiative	Informelle Gruppe
6604	Jurassischer Grundeigentümerverband	Verein
6658	Verein Eidgenössisches Schwing- und Älplerfest 2025 Glarnerlandplus, genannt OK ESAF 2025 Glarnerlandplus	Verein
6625	Trachtengruppe Birmenstorf	Verein
6715	INTERNATIONAL CERTIFICATION BIO SUISSE AG	AG
6736	Filmverein Lichtspiele Olten	Verein
6747	Forstrevier Hardwald Umgebung	Verein
6767	Grünliberale Partei Bezirk Horgen	Verein
6794	LerNetz AG	AG
6812	Willy Mettler-Stiftung	Stiftung
6820	Schweizerischer Ingenieur- und Architektenverein Sektion Thurgau	Verein
6847	GESA Immo SA	AG
6875	Kreis Wasserbau AG	AG
6881	Strupler Holding AG	AG
6918	Stadt Baden	Staatlich
6941	Sozialdemokratische Partei der Stadt Neuenburg	Verein
6963	Les amis du Musée Le Pire de Plonk & Replonk	Verein
6971	FDP Die Liberalen Suhr	Verein
7011	Club des Cent Cols	Verein
7039	Mokber GmbH	GmbH
7046	Fondation de prévoyance des industries horlogère et microtechnique suisses (Prevhor)	Stiftung
6989	Association des Lectures publiques	Verein
7088	T.A.U. ARCHITECTES Sàrl	GmbH
7100	Scuola universitaria professionale della Svizzera italiana (SUPSI)	Oeffentlich-rechtlich
7091	SI Campus HE - Jura SA	AG
7150	Vorsorgestiftung der Verbände der Maschinenindustrie	Stiftung
7162	Zürcher Planungsgruppe Furttal	Verein
7184	JCVP Kanton Luzern	Verein
7134	slowUp Wallis	Einfache Gesellschaft
7216	Grüne Partei Steinhausen	Verein
7234	Kanton Zürich	Staatlich
7252	Olivier Mark Management	Einzelunternehmen
7273	Motorvalve AG	AG
7086	EyesUp	Verein
7303	AS Immobilien AG	AG
7292	Schule Lauerz	Staatlich
4971	CROIX-ROUGE VAUDOISE Association cantonale de la Croix-Rouge suisse	Verein
5016	SPS-Fachkommission Sexuelle Orientierung und Geschlechtsidentität	Informelle Gruppe
5029	RMH Regionalmedien AG	AG
5040	Sozialdemokratische Partei Cully und Umgebung	Verein
5070	FischeRundum, David Fischer	Einzelunternehmen
5083	Arbeitgeberverband Basler Pharma-, Chemie- und Dienstleistungsunternehmen	Verein
5133	Internationales Filmfestival Fribourg	Verein
5145	Dénériaz SA Sion	AG
5194	Graue Panther Olten und Umgebung	Verein
5301	AV Curiensis	Verein
5312	Forum christlicher Führungskräfte	Verein
5216	Jungwacht Blauring Obwalden Nidwalden	Verein
5335	Plateforme Romande de l'accueil de l'Enfance	Verein
5381	Avenir Assurance Maladie SA	AG
5393	Verband Pfadi Wallis	Verein
5355	Tripartite Kommission für Angelegenheiten der IAO	Ausserparlamentarische Kommission
5459	Konferenz der Rotkreuz-Kantonalverbände	Informelle Gruppe
5464	Ready!	Informelle Gruppe
5476	Calanda Gruppe AG	AG
5529	LANDI Büren an der Aare und Umgebung Genossenschaft	Genossenschaft
5489	Stiftung SVP-Parteizeitung	Stiftung
5496	Anlaufstelle Kindes- und Erwachsenenschutz	Verein
5102	Beratungs Forum Schweiz	Verein
5592	Association romande et francophone de Berne et environs	Verein
5560	Fondazione Pro Infantia	Stiftung
5565	Limeco	Oeffentlich-rechtlich
5568	CVP Schlieren	Verein
5243	Schweizerische Vereinigung der diplomierten Versicherungsfachleute	Verein
5687	Schweizerische Reformierte Arbeitsgemeinschaft Kirche-Landwirtschaft	Verein
5168	Rennverein Frauenfeld	Verein
5701	zollingberatungen	Einzelunternehmen
5706	Verein Art Dock Zürich	Verein
5711	Les Amis du Théâtre	Verein
5747	Klassik Nuevo	Verein
5580	Grundli Resort Engelberg GmbH	GmbH
5825	Metro Autopark AG	AG
5900	Arch Gastro AG	AG
5884	Stiftung Jeki Bern	Stiftung
5857	Hilfeleistungsfonds Air Zermatt	Verein
5262	Gewerbeverein Sachseln	Verein
5933	Hauseigentümer-Verband Kanton St. Gallen	Verein
5951	Communicators AG	AG
5978	Wirtschafts- und währungspolitischer Arbeitskreis	Parlamentarische Gruppe
5993	Restaurant du Col de Bretaye SA	AG
6010	Union der Christlichsozialen Zürich	Verein
6023	Hauseigentümerverband Kriens	Verein
5759	Schweizerische Vereinigung für hirnverletzte Menschen FRAGILE Wallis	Verein
5786	Fondation en faveur de Citoyens Suisses Victimes de Sinistres à l'étranger en liquidation	Stiftung
5795	Digitale Gesellschaft	Verein
6035	Pro Senectute Valais-Wallis / Pour la Vieillesse	Stiftung
6061	FDP Die Liberalen Sirnach	Verein
6090	Zürich Tourismus	Verein
6118	Gemeinde Murten	Staatlich
6123	Die Gebirgspoeten	Informelle Gruppe
6149	Fachstelle ASN - Am Steuer nie	Verein
6172	Gilead Sciences Switzerland Sàrl	GmbH
6164	MindNow AG	AG
6201	Fondation Ashoka Suisse	Stiftung
6234	rieder.pfammatter.bregy Advokatur und Notariat	Einzelunternehmen
6252	TOPO Genève	Verein
6274	Lyria SAS	AG
6299	Gewerbeverein Küttigen	Verein
6339	Passwang Club	Verein
6372	Kindes- und Erwachsenenschutzbehörde der Bezirke Winterthur und Andelfingen	Staatlich
6422	Komitee pro Hirzeltunnel	Verein
6409	Addfluence Consulting & Communication GmbH	GmbH
6414	American Swiss Foundation	Stiftung
6471	Stop Hate Speech	Informelle Gruppe
6521	Gemeinde Cugy	Staatlich
6540	Stiftung Kunst & Musik, Klosters	Stiftung
6550	Fondation The Ark	Stiftung
6436	Zuger Kantonaler Imkerverein	Verein
6599	Moesamed SA	AG
6566	BX Swiss AG	AG
6641	Terzo Vorsorgestiftung der WIR Bank	Stiftung
6507	Fondation de prévoyance en faveur du personnel des Transports publics genevois	Oeffentlich-rechtlich
6692	Kommission für das Reussdelta	Informelle Gruppe
6723	Dampfzentrale Bern	Verein
6731	FDP Die Liberalen Attinghausen	Verein
6750	Schweizerische Technische Fachschule Winterthur (STF)	Stiftung
6753	Jason Boon Bigband	Verein
6781	Jodlerchörli Geuensee	Verein
6798	GGG Gesellschaft für das Gute und Gemeinnützige Basel	Verein
6817	Centralemulin SA	AG
6673	Grüne Stadt und Region St.Gallen	Verein
6854	IG Kaffee Schweiz	Verein
6863	Rimas Insurance-Broker AG	AG
6887	Strupler Immobilien GmbH	GmbH
6900	Stiftung Freiheit und Verantwortung	Stiftung
6925	Verband Lehrpersonen Graubünden	Verein
6944	Fondation Château Mercier	Stiftung
6965	Café du Soleil SA	AG
6972	argophia philharmonic	Verein
7013	Interteam	Verein
7035	Personalvorsorgestiftung der Ärzte und Tierärzte PAT-BVG	Stiftung
7017	Lehrerinnen- und Lehrerverein Baselland LVB	Verein
7078	Association de l'EMS "Résidence Les Pervenches"	Verein
7002	Inser SA	AG
7112	Verein Solarplexus	Verein
7141	Kanton Graubünden	Staatlich
7160	Association OIV 2019	Verein
7190	ICT Berufsbildung Zentralschweiz	Verein
6386	Simmental Switzerland AG	AG
6390	ZBM AG	AG
6394	OSEO Neuchâtel	Verein
7253	FTC Communication SA	AG
4982	PLR.Les Libéraux-Radicaux Lavaux-Oron	Verein
4996	Geneva Institute for Human Rights	Verein
5025	Industrielle Betriebe Kloten AG	AG
5033	JUSO Kanton Aargau	Verein
5044	Initiative "Für Ernährungssouveränität"	Informelle Gruppe
5073	Offiziersgesellschaft Zürcher Oberland	Verein
5084	Arbeitgeberverband der Banken in der Schweiz	Verein
5138	FDP Die Liberalen Kanton Bern	Verein
5149	FONDATION POUR LA PROMOTION DU GOÛT	Stiftung
5233	FDP Die Liberalen Kanton St. Gallen	Verein
5304	Parlamentarische Gruppe PHILANTHROPIE/Stiftungen	Parlamentarische Gruppe
5211	FDP Die Liberalen Zofingen (Bezirkspartei)	Verein
5221	Katholisches Pfarramt Sachseln	Staatlich
5379	allianz denkplatz schweiz	Informelle Gruppe
5391	Stadt Sitten	Staatlich
5435	"BundespolitikerInnen für Demokratie und Rechtsstaat"	Verein
5447	Rocksilo	Verein
5457	STIFTUNG ILGENHALDE	Stiftung
5510	Conférence latine des chefs des départements de justice et police	Staatlich
5281	Parlamentarische Gruppe für die Gotthard-Alpentransversale	Parlamentarische Gruppe
5532	Huissoud Watches	Einzelunternehmen
5541	Stiftung Hospiz Zentralschweiz	Stiftung
5581	HFW Luzern AG	AG
5587	FDP Die Liberalen Kanton Nidwalden	Verein
5557	Beratende Gewässerbewirtschaftungskommission	Staatlich
5563	Gemeinsam Wohnen mit Kindern	Verein
5566	European Music Council	Verein
5669	Fondazione DEMIAP	Stiftung
5114	Parlamentarische Gruppe Schweiz - Vietnam	Parlamentarische Gruppe
5119	Die Mitte Appenzell Innerrhoden	Verein
5717	CVP Linth	Verein
5727	Zwilag Zwischenlager Würenlingen AG	AG
5735	Parlamentarische Freundschaftsgruppe Schweiz - Tunesien	Parlamentarische Gruppe
5742	Swiss Data Alliance	Verein
5616	Consiglio parrocchiale Bironico	Staatlich
5847	EnBAG Netze AG	AG
5872	Argovia Philharmonic	Verein
5903	Klotener Stadtfest	Verein
5910	Grünes Bündnis Bern	Verein
5916	Fotografie Albrecht GmbH	GmbH
5265	Projet Socrate	Einzelunternehmen
5938	Durst, Marketing und Kommunikation	Einzelunternehmen
5965	Luftverkehr und Klima	Parlamentarische Gruppe
5837	Verein Dynamo Sempachersee	Verein
5876	FONDAZIONE CENTRO CAPRA	Stiftung
6013	SP Huttwil	Verein
6022	Sicherheitspolitisches Forum an der Universität St. Gallen	Verein
5861	Gastro Wilen AG	AG
5866	Réseau Romand ASA	Verein
6029	Tambourenverein der Stadt Luzern	Verein
6043	Swiss Prime Anlagestiftung	Stiftung
6078	Schweizerische Vokspartei Frauen Kanton Bern	Verein
6098	Gedächtnisstiftung Ellen Hess	Stiftung
6127	verkehrsteiner AG	AG
6140	Innosuisse - Schweizerische Agentur für Innovationsförderung	Oeffentlich-rechtlich
6169	Alexion Pharma GmbH	GmbH
6188	Belvoirpark AG	AG
6199	SwissDiplomats - ZurichNetwork	Verein
6222	Grünliberale Partei Kanton Schwyz	Verein
6257	Swiss Medi Kids AG	AG
6276	Verband der Schweizerischen Versandapotheken	Verein
6296	Verein Modell F	Verein
6338	Portale cantonale di prevenzione contro la radicalizzazione e l'estremismo violento Ticino	Staatlich
6329	W.I.R.E. (Web for Interdisciplinary Research & Expertise)	Einzelunternehmen
6419	Gewerbeverein Baar	Verein
6439	Verein der Gönnerinnen und Gönner Lassalle-Haus Bad Schönbrunn	Verein
6374	DEZOS GmbH	GmbH
6456	Ski-Weltcup Adelboden AG	AG
6472	Swiss 3R Competence Centre (3RCC)	Verein
6467	Swissesco	Verein
6363	St.Galler Kantonalbank AG	AG
6554	Rotary Club Büren an der Aare-Strassberg	Verein
6592	Hardegger Traxler Immobilien AG	AG
6612	Mieterinnen- und Mieterverband Freiburg	Verein
6635	Agro City	Verein
6619	Seilziehclub Ebersecken	Verein
6683	Sentience Politics	Verein
6695	kaisin. AG	AG
6726	BWZ Berufs- und Weiterbildungszentrum Lyss	Stiftung
6737	Verein Step4 Kompetenzzentrum Berufsausbildung	Verein
6740	Grüne Partei Kanton Solothurn	Verein
6763	Gewerbeverein Gaiserwald	Verein
6779	Verkehrs-Club der Schweiz Sektion St. Gallen / Appenzell	Verein
6803	Kulturvereinigung der Aleviten und Bektaschi / Basel ve Cevresi Alevi Bektasi Kültür Birligi	Verein
6827	Eidgenössisch-Demokratische Union Oberwil	Verein
6850	Gruyère Energie S.A.	AG
6867	Stiftung Mühle Schönenberg an der Thur	Stiftung
6903	Union des intérêts de la place financière lémanique	Verein
6924	Stadt Chur	Oeffentlich-rechtlich
6938	Schweizerisches Rotes Kreuz Sektion Neuenburg	Verein
6964	Nez-Rouge Jura	Verein
6984	Pro Natura Genève	Verein
7012	Grüne Baselland	Verein
7032	Centre Ophtalmologique de Rive SA	AG
7055	FAAG - Fondation pour la Formation des Aînées et des Aînés de Genève	Stiftung
7072	Fondation Murs à dessins	Stiftung
7094	eye academy ag	AG
7113	Verein Poetry Slam St. Gallen	Verein
7124	Finanzierungsstiftung Frauenhaus Zürich	Stiftung
7168	Stiftung Wohnheim KONTIKI	Stiftung
7180	ZSO Sursee	Staatlich
7208	Frauenzentrale Zug	Verein
7221	BRICKER.CH	Einzelunternehmen
7248	E. Weber & Cie AG	AG
7268	REWI Advice GmbH	GmbH
6929	Stiftung Frauenkulturarchiv Graubünden	Stiftung
5308	Mobilière Suisse Société d'assurances sur la vie SA	AG
5320	Unterstützungskomitee "Engpass Wankdorf-Muri beseitigen"	Verein
5225	Stiftung Pro Zukunftsfonds Schweiz	Stiftung
5343	Komitee "Weissensteintunnel erhalten"	Informelle Gruppe
5421	Schweizerische Volkspartei Sektion Jegenstorf-Münchringen	Verein
5396	Milice bramoisienne	Verein
5405	Gioventù Socialista Ticino	Verein
5414	Hermann Herzer Stiftung	Stiftung
5471	FDP Die Liberalen Graubünden	Verein
5521	Gemeinde Konolfingen	Staatlich
5288	TSW Musical AG	AG
5540	Europa Forum Luzern	Verein
5494	Fisch vom Hof	Verein
5503	ETH Alumni Vereinigung	Verein
5618	FDP Lugano	Verein
5623	Stadtpolizei Winterthur	Staatlich
5359	Stiftung Dialog	Stiftung
5300	AV Helvetia Oenipontana	Verein
5161	Fondation AMB	Stiftung
5683	Schweizerischer Verband der Immobilienwirtschaft SVIT ("SVIT Schweiz")	Verein
5693	Neue Frauenbewegung 2.0	Informelle Gruppe
5724	Swiss Cardio Technologies AG	AG
5175	Vereinigung Schweizer Mühlenfreunde	Verein
5177	Schweizerisches Institut für Verwaltungsräte	Verein
5770	RVK Rück AG	AG
5774	Junge BDP Schweiz	Verein
5850	Stiftung Zentrum Rund ums Alter	Stiftung
5256	Schweizerische Volkspartei Gretzenbach	Verein
5854	Stiftung UNESCO Welterbe Schweizer Alpen Jungfrau-Aletsch	Stiftung
5808	Pro Velo Luzern	Verein
5816	Sagérime SA	AG
5821	Schuhschweiz	Verein
5949	Fresh up FC	Verein
5833	BEREUTER HOLDING AG	AG
5987	EMS-CHEMIE (Switzerland) AG	AG
5999	esr multimedia SA	AG
6020	Einwohnerrat Kriens	Staatlich
5968	Parlamentarische Freundschaftsgruppe Schweiz - Belgien - Luxembourg	Parlamentarische Gruppe
5787	FDP Die Liberalen International	Verein
6028	Historische Gesellschaft Luzern	Verein
6036	S. Karger AG	AG
6065	Initiativkomitee Fairfood-Initiative	Informelle Gruppe
6095	Biogas Volley Naefels	Verein
6117	SymbioSwiss Sàrl	GmbH
6135	Spirituosen und Prävention	Parlamentarische Gruppe
6159	Law & Economics Club	Verein
6184	INSOS Zürich	Verein
6198	Appenzellische Gemeinnützige Gesellschaft	Verein
6217	Verein für lösungsorientierte Politik	Verein
6235	Cevi Schweiz	Verein
6259	Berner KMU	Verein
6279	Union der Europäischen Föderalisten	Verein
6300	Team 65+	Verein
6324	Verfassungsrat Kanton Wallis	Staatlich
6373	Sensormate AG	AG
6402	Swiss Masters Running	Verein
6410	Verband Aargauer Schützenveteranen	Verein
6354	Bienen	Parlamentarische Gruppe
6460	Eidgenössisches Personalamt	Staatlich
6433	Imkerverein Aegerital	Verein
6362	Bäuerliche Interessengruppe Milchmarkt	Verein
6551	Sektion der Sozialdemokratischen Partei des Seebezirks	Verein
6556	Die Mitte Region Büren	Verein
6561	Swiss Fintech Innovations (SFTI)	Verein
6631	Schweizerischer Verband der Strassen- und Verkehrsfachleute	Verein
6657	Interessensgemeinschaft Gesellschaftsliberale ParlamentarierInnen	Informelle Gruppe
6666	Energie 360 Grad AG	AG
6693	CKW AG	AG
6725	Stiftung von-Rütte-Gut	Stiftung
6702	Kanton Solothurn	Staatlich
6707	Oberaargauer Bauernverein	Verein
6772	Verein für faire Milchpreise	Verein
6785	Coopérative de La Brouette	Genossenschaft
6802	CRESCENDA	Verein
6823	Nova Energie Ostschweiz AG	AG
6839	Autobetrieb Sernftal AG	AG
6852	Hochschule für Technik und Architektur Freiburg	Oeffentlich-rechtlich
6883	Thurgauer kantonaler Schwingerverband	Verein
6901	Trägerverein National Summer Games 2022 St.Gallen	Verein
6933	Schweizerischer Alpenclub SAC Sektion Rätia	Verein
6955	Heilpädagogisches Schulzentrum Balsthal	Oeffentlich-rechtlich
6966	Fachkonferenz Soziale Arbeit der Fachhochschulen Schweiz	Verein
7006	Confrérie du Guillon	Verein
7025	Jungwacht Altdorf	Verein
7042	Kantonales Spital und Pflegezentrum Appenzell	Oeffentlich-rechtlich
7063	MUELLER Consulting & Partner GmbH	GmbH
7066	Schweizerische Ophthalmologische Gesellschaft	Verein
7109	Association pour l'étude de l'histoire du mouvement ouvrier	Verein
7122	Kompetenzzentrum Menschenrechte Universität Zürich	Staatlich
7146	digital.swiss	Einfache Gesellschaft
7177	Urimpuls AG	AG
7187	Junge CVP Schweiz	Verein
7202	Fachhochschule St. Gallen	Staatlich
7217	Nachbarschaft Sankt Michael Zug	Verein
7235	Verein Zukunft Mobilität	Verein
7260	Stiftung Ernesto Conrad	Stiftung
6672	Stadt St. Gallen	Staatlich
7283	SP MigrantInnen	Informelle Gruppe
7313	Match-Maker Ventures	GmbH
7336	Jugend und Sport	Staatlich
7369	KG Gastrokultur GmbH	GmbH
7389	Pensionskasse SRG SSR	Stiftung
7427	Schweizer Verband für Krisenkommunikation	Verein
7473	MediService AG	AG
7479	MVP HOLDING SA	AG
7410	Swiss IPO Consulting GmbH	GmbH
7531	Gemeindebibliothek Rosengarten	Stiftung
7541	Etter Pavage SA	AG
7549	Global Alliance for Tax Justice	Verein
7506	Herr Durst GmbH	GmbH
7630	Genossenschaft Stadion St. Jakob-Park	Genossenschaft
5723	Civitan Club Zürichsee	Verein
5173	Verband Immobilien Schweiz	Verein
5176	Schweiz - Kasachstan	Parlamentarische Freundschaftsgruppe
5743	Parlamentarische Gruppe Schweiz - Spanien	Parlamentarische Gruppe
5798	Pro Senectute Vaud	Verein
5844	Walliser Tourismuskammer	Verein
5879	Pro Dampfer AG	AG
5803	Sozialdemokratische Partei Pfäffikon	Verein
5886	Hangenmoos AG	AG
5261	Schweizerischer Verband für Alimentenfachleute (SVA)	Verein
5931	BUS Ostschweiz AG	AG
5829	Schweizerisches Institut für Auslandforschung	Verein
5973	Parlamentarische Gruppe Seidenstrasse	Parlamentarische Gruppe
5840	Migration	Parlamentarische Gruppe
6006	ZAR Emmental - Oberaargau AG	AG
6017	Vernetzungsprojekt Ybrig	Verein
5775	Associazione delle Imprese Familiari Ticino (AIF Ticino)	Verein
5791	Ucom Standards Track Solutions GmbH	GmbH
5793	Internet Society	Verein
6047	AEE SUISSE Aargau	Verein
6063	Schweizerische Volkspartei Kanton Solothurn	Verein
6080	IG Bätterkinden	Verein
6099	INTEXPO MESSE ST. GALLEN AG Gesellschaft für internationale Messen und Ausstellungen	AG
6136	Die Mitte Stadt Zürich	Verein
6151	Gastro Bümpliz GmbH	GmbH
6177	Verein Zürcher Volksfeste, OK Züri Fäscht	Verein
6196	Verein Energie AR/AI	Oeffentlich-rechtlich
6219	pierrot & pierrette	Einzelunternehmen
6238	Schweizer Dreifarben-Kleinschecken-Klub	Verein
6261	Stadt Freiburg	Staatlich
6280	Gasthaus Metzgerei Brauerei Egger AG	AG
6302	Bündner Heimatschutz	Verein
6343	Powerloop	Verein
6415	Bocciaclub Zug Bellevue	Verein
6438	Meisterschaft Menzingen	Verein
6444	Chöre Innerschweiz	Verein
6468	Vetrotech Saint-Gobain (International) AG	AG
6496	Queeramnesty Schweiz	Informelle Gruppe
6359	Schweizerische Volkspartei Bezirk Winterthur	Verein
6533	Lignum Holzwirtschaft Bern	Informelle Gruppe
6473	Garage Auto Kunz AG	AG
6477	Hilari-Zunft zu Olten	Verein
6560	Zürcher Volkswirtschaftliche Gesellschaft	Verein
6615	Stiftung pro jungwacht blauring	Stiftung
6568	SWISS MEDTECH - Schweizer Medizintechnikverband	Verein
6607	Advokatur Notariat Biel	KG
6689	Fondation Avenir et Santé	Stiftung
6713	männer.ch	Verein
6730	Verband Fachhochschuldozierende Nordwestschweiz	Verein
6758	Verein Hölzli	Verein
6766	Pro Velo Kanton Zürich	Verein
6777	Stiftung für Arbeit SfA	Stiftung
6810	Regionalverband zofingenregio	Verein
6822	Energiefachleute Thurgau EFT	Verein
6842	Gönnerverein des Glarner Wirtschaftsarchivs	Verein
6865	Radio- und Fernsehgesellschaft der deutschen und der rätoromanischen Schweiz	Verein
6889	Chranz-Club	Verein
6908	Gewerbeverein Kirchlindach-Meikirch	Verein
6922	Info fauna - Centre suisse de cartographie de la faune (CSCF) & Koordinationsstelle für Amphibien- und Reptilienschutz in der Schweiz (karch)	Stiftung
6948	RZU / Planungsdachverband Region Zürich und Umgebung	Verein
6975	Genossenschaft Ferienhilfe Schule Suhr	Genossenschaft
6487	Katholische Frauengemeinschaft Rapperswil-Kempraten	Verein
7029	Unione Democratica del Centro Ticino	Verein
7052	Etude NVLE	Einfache Gesellschaft
7070	Fondation Pro Visu	Stiftung
6991	Jai Jagat Genève	Verein
7099	Adelsy di Bruno Storni	Einzelunternehmen
7095	Vereinigung der Walliser Trockenfleischprodukte AOP	Verein
6384	Eidgenössische Kommission zur Beratung des Nationalen Kontaktpunktes für die OECD-Leitsätze für multinationale Unternehmen	Ausserparlamentarische Kommission
7176	SanArena	Stiftung
7152	Arbeitgeberverband der Schweizer Maschinenindustrie	Verein
7197	MycoSolutions AG	AG
7222	CVP- Die Mitte Uri	Verein
7250	Grüne Partei Lausanne	Verein
7265	Lions Club Poschiavo	Verein
7075	Association Pro Senectute Genève	Verein
7298	Swiss Green Resources LTD	GmbH
7320	Kulturstiftung der Credit Suisse Aargau	Stiftung
7363	Landwirtschaft mit Zukunft	Verein
7350	Fondation Jacqueline PETIT	Stiftung
7404	Verein Mittelland Milch	Verein
7454	Kinderbetreuung Malters	Verein
7422	Campaigning Summit Switzerland	Verein
7408	Junge CVP Jura	Verein
7475	Kanton Zug	Staatlich
7555	Bio Oil Schweiz AG	AG
7557	Stiftung Zueflucht	Stiftung
7613	Stiebel Eltron AG	AG
7492	Primarschule Kernenried Zauggenried	Staatlich
7520	Relesta AG	AG
7703	Salex GmbH	GmbH
7716	SwissLegal asg.advocati	Einfache Gesellschaft
7524	Osmose Groupe	Verein
7754	RVK	Verein
7686	Verein Cinetreff Herisau	Verein
7599	Menschenhandel	Parlamentarische Gruppe
7815	Fondation de prévoyance en faveur du Groupe Minoteries SA et des sociétés affiliées	Stiftung
7802	dobler.swiss	Einzelunternehmen
7855	SwissDrink Genossenschaft	Genossenschaft
7867	SCN Club 93	Verein
7572	Sicherheitspolitische Forum St.Gallen	Verein
7765	Fondation de cautionnement de la Banque Cantonale Neuchâteloise	Stiftung
7934	Gönnerverein O.ch	Verein
7959	Stiftung für direkte Demokratie	Stiftung
7980	Mutter & Partner Consulting AG	AG
8013	Fritz Meyer AG	AG
8020	Oléoduc du Rhône S.A.	AG
5734	Nichtionisierende Strahlung, Umwelt und Gesundheit	Parlamentarische Gruppe
5608	Stisa Sviluppo Traffici Internazionali SA	AG
5797	Interessengemeinschaft Luftfahrt Schweiz	Verein
5823	Schweiz - Kosovo	Parlamentarische Freundschaftsgruppe
5851	EWBN Elektrizitätswerk Brig-Naters AG	AG
5257	Egerkinger Komitee - Initiativkomitee "Ja zum Verhüllungsverbot"	Verein
5855	Verein Region Oberwallis	Verein
5918	Flügelrad AG	AG
5892	Historische Gesellschaft Wädenswil	Verein
5935	Stiftung Pro Spitex	Stiftung
5940	VerMaG AG	AG
5836	Messe Luzern AG	AG
5991	Valtema Holding AG	AG
5646	onyx Energie AG	AG
6026	insieme Luzern - für Menschen mit geistiger Beeinträchtigung	Verein
5754	ARTISET Securit AG	AG
5761	agriss	Stiftung
5766	Branchenorganisation Milch (BO Milch)	Verein
6037	Smart Regio Basel	Verein
6073	Verein Selbsthilfe Thurgau	Verein
6103	Klinik Gais AG, kardiale Rehabilitation, Psychosomatik und Psychotherapie	AG
6086	Zgraggen Energie Holding AG	AG
6126	Kinderkrebs Schweiz	Verein
6148	Energie Club Schweiz	Verein
6168	Admeira AG	AG
6191	Gewerkschaftsbund der Stadt Bern und Umgebung (GSB)	Verein
6211	Interregionale Blutspende SRK AG	AG
6232	TCS section Valais	Verein
6258	Health Info Net AG	AG
6277	Zur Rose Suisse AG	AG
6298	Verein ESPOIR	Verein
6310	Rotary Club Zofingen	Verein
6331	Blistersuisse	Verein
6421	Hochwacht Zug Leichtathletik	Verein
6441	Hilfsgesellschaft Menzingen	Verein
6451	Kirche Jesu Christi der Heiligen der Letzten Tage in der Schweiz	Verein
6497	Jodlerklub Aletsch	Verein
6523	Fondation pour le Théâtre du Jura	Stiftung
6535	Infra Suisse	Verein
6435	Zunft und Bruderschaft der Müller, Bäcker und Zuckerbäcker der Stadt Zug	Verein
6589	Ja zum Leben	Verein
6595	Benevol Luzern	Verein
6598	Johanna Spyri-Stiftung	Stiftung
6656	Ecole des missions	Verein
6669	Schweizerischer Turnverband Allenwinden	Verein
6645	frauenraum	Verein
6648	Impuls Seebezirk, Verein	Verein
6703	Pro Infirmis Zweigniederlassung Aargau-Solothurn	Verein
6748	Grünliberale Partei Bezirk Bülach	Verein
6761	St.Galler Juristenverein	Verein
6784	Association Maison de Quartier du désert	Verein
6807	A FoodLiner GmbH	GmbH
6828	Freie Missionsgemeinde Oberwil	Verein
6855	Pro Café	Verein
6871	Förderverein CESCI	Verein
6899	Agrovina	Verein
6923	Fondation Ton sur Ton	Stiftung
6943	Fondation Ateliers du Rhône Chippis	Stiftung
6962	Au P'tit Plus	Verein
6968	Hauseigentümerverband Aarau und Kulm	Verein
7009	La Cible sportive Saint-Légier	Verein
7024	Floorball Uri	Verein
7054	Stiftung Quinten lebt	Stiftung
7061	Amateur Liga des SFV	Verein
7082	Vereinigung der Genfer Städte	Verein
7103	Stadt Bulle	Staatlich
7116	Lesbenorganisation Schweiz	Verein
7151	Wohlfahrtsstiftung Swissmem	Stiftung
7166	Fondation pour le développement et la promotion du patois	Stiftung
7188	Arbeitsgruppe Familienpolitik CVP Schweiz	Verein
7203	Handelsgericht St. Gallen	Staatlich
7219	STV Beromünster	Verein
7224	Historischer Verein Uri	Verein
7256	Caritas Graubünden	Verein
7277	International Bar Association	Verein
7284	Etude Zutter, Locciola, Buche & Associés	Einfache Gesellschaft
7291	Victor Art Events	Einzelunternehmen
7329	Gemeinschaft Evangelischer Kirchen in Europa	Einfache Gesellschaft
7364	Genossenschaft PERMAKULTUR AUENHOF bei FELDBACH	Genossenschaft
7373	Fondazione Sciaredo	Stiftung
7359	solicare AG	AG
7351	Fondation Prima Robert	Stiftung
7457	Jungfreisinnige Graubünden	Verein
7436	histHub	Einfache Gesellschaft
7462	Schweizerische Offiziersgesellschaft der Artillerie	Verein
7449	Gewerbeverein Kreis 5 Züri-West	Verein
7559	Securserv Technologies SA	AG
7489	Formation FIDUCIAIRE SUISSE Romandie SARL	GmbH
7623	Luzerner Forum für Sozialversicherungen und Soziale Sicherheit	Verein
7661	Medisupport SA	AG
7701	Schweizerische Volkspartei Ortspartei Berneck	Verein
7713	FONDATION IMAGES ET SOCIETE	Stiftung
7723	SWS Medien AG PriMedia	AG
7589	Stiftung für Freiheit und Verantwortung	Stiftung
7645	Schilliger Immobilien AG	AG
7728	200 Jahre Schweizer Schiesssportverband	Verein
7797	Grächen & St. Niklaus Tourismus AG	AG
7841	Riviera Airport SA	AG
7835	VAL Group AG	AG
7871	CGS Corporate Group Service AG	AG
7877	Sirea AG Schweizerisches Institut für Immobilienbewertung	AG
7897	Bulletproof GmbH	GmbH
7932	Gemüseproduzenten-Vereinigung der Kantone Thurgau und Schaffhausen	Verein
7946	Reformierte Kirchgemeinde Zollikofen	Verein
7979	Aktiengesellschaft Hallenstadion Zürich	AG
8012	Waldburger Invest AG	AG
8030	Shell Corporate Services Switzerland AG	AG
8068	Bio Partner Renaissance AG	AG
8086	2profile.net GmbH	GmbH
8103	Association forestière de la Noble Contrée	Staatlich
7609	Verband Zürcher Musikschulen	Verein
5810	VPOD Region Zentralschweiz	Verein
5921	TAFE - Trägerverein Ausbildung Fachpersonal Entsorgungsanlagen	Verein
5827	Verein Projekt Doppeltür	Verein
5939	KOMET Werbeagentur AG	AG
5979	Zivildienst	Parlamentarische Gruppe
5990	Türenfabrik Brunegg AG	AG
5841	Autobus AG Liestal Dienstleistungen	AG
6021	WFD Werkflugplatz Dübendorf AG	AG
5969	Schweiz - Kuba	Parlamentarische Freundschaftsgruppe
5783	IG Bödeli-Werke	Verein
6027	Bruderschaft der Herrgottskanoniere Luzern	Verein
6049	Solidaritätshaus St. Gallen	Verein
6069	Bürgerliche Witwen- & Waisenstiftung Schaffhausen	Stiftung
6068	Kinder- und Jugendmedizin	Parlamentarische Gruppe
6110	Kindes- und Erwachsenenschutzbehörde Region Rorschach	Staatlich
6121	Kundendialog	Parlamentarische Gruppe
6146	PRO, Entreprise Sociale Privée d'Intégration et de Réinsertion Professionnelle	Stiftung
6167	Forum Kultur und Ökonomie	Informelle Gruppe
6189	Restaurant Vieux-Bois SA	AG
6210	EPFL-WISH FOUNDATION	Stiftung
6228	Verein Hansbank in allen Gassen	Verein
6248	SwissCCS	Einzelunternehmen
6260	Die Mitte Tessin	Verein
6291	Argenius Risk Experts AG	AG
6318	FDP Die Liberalen Lausanne	Verein
6366	Stiftung zur Förderung von Technologiemanagement, Technologiepolitik und Technologietransfer	Stiftung
6348	Geschichtsverein Adliswil	Verein
6424	Pro Allenwinden	Verein
6428	SWS Medien AG	AG
6483	Fondation Sikypark	Stiftung
6511	Unia Region Waadt	Verein
6539	Kirchner Verein Davos	Verein
6548	Bezirksturnverband Sissach	Verein
6587	Regionalgericht Berner Jura-Seeland	Staatlich
6559	Pensionskasse des Opernhauses Zürich	Stiftung
6504	Drachentöter Naters	Verein
6586	Arbeitsmarktkontrolle Bern (AMKBE)	Verein
6620	Business and Professional Women Luzern	Verein
6623	Kepler Cheuvreux (Suisse) SA	AG
6708	Schweizerische Fachverband Soziale Arbeit im Gesundheitswesen	Verein
6718	Landgasthaus Sonne Wintersberg GmbH	GmbH
6749	Grünliberale Partei Opfikon	Verein
6744	Spital Bülach AG	AG
6769	Kantonsschule Beromünster	Staatlich
6800	Verein Kulturwerkstatt Kaserne	Verein
6821	Kulturkommission des Kantons Thurgau	Staatlich
6849	EauSud S.A.	AG
6876	Kreis Wasserbau Immo AG	AG
6898	Arvinis	Einzelunternehmen
6911	Pro Belpmoos	Verein
6939	Mieterinnen- und Mieterverband Neuenburg	Verein
6973	Freunde der Lenzburg	Verein
6978	Silver Scouts	Einfache Gesellschaft
7010	PRO VELO Riviera	Verein
7030	Comune di Monteggio	Staatlich
7051	Neuenburger Anwaltsverband	Verein
6988	Stiftung Winterhilfe Kanton Schwyz	Stiftung
6998	Interpreten-Hilfsfonds des Schweizerischen Verbandes des Personals öffentlicher Dienste (VPOD)	Stiftung
7098	Istituto ricerche solari Aldo e Cele Daccò (IRSOL)	Stiftung
7126	Eidgenössische Kommission für die Alters-, Hinterlassenen-, und Invalidenversicherung	Ausserparlamentarische Kommission
7148	Mokoro Ltd	GmbH
7165	Kantonalschützenfest Jura 2023	Verein
7189	Kiwanis Club Sursee	Verein
7131	Fachstelle Integration Aargau	Verein
7210	Förderverein der Gewerkschaftsschule Schweiz	Verein
7228	Schweizerische Volkspartei Wohlen-Anglikon	Verein
7244	Ch. Margot & Cie S.A.	AG
7275	LEXIAN AG	AG
7080	Regierung Stadt Carouge	Staatlich
7301	99%-Initiative	Informelle Gruppe
7321	Stiftung Kardio	Stiftung
7361	1L Logistics AG	AG
7372	ZEITGARTEN.CH - Meszmer & Müller	KG
7402	Genossenschaft Milchproduzenten Mittelland	Genossenschaft
7441	Forum Futur - liberales netzwerk für nachhaltige politik	Informelle Gruppe
7432	Gemeinde Oberdorf SO	Staatlich
7480	Gottéron MJ Sàrl	GmbH
7465	Gemeinde Freienbach	Staatlich
7536	Politikwerkstatt GmbH	GmbH
7400	Pully-Lausanne Basketball SA	AG
7487	Trägerverein Fanarbeit FC Luzern	Verein
7508	EVIATEC Digital Solutions AG	AG
7691	BDP Kanton Bern	Verein
7521	Stiftung Kliniken Valens	Stiftung
7671	ETUDE PHILIPPE NANTERMOD SARL	GmbH
7749	Schweizerische Gemeinnützige Gesellschaft	Verein
7755	SENS	Verein
7597	Kindes- und Erwachsenenschutz	Parlamentarische Gruppe
7601	TC Bundeshaus	Parlamentarische Gruppe
7795	Stiftung für die Unterstützung der Forschung im Bereich Seilbahnen	Stiftung
7732	Kunst	Parlamentarische Gruppe
7832	Sicherheitspolitik	Parlamentarische Gruppe
7651	Foederatio Medicorum Chirurgicorum Helvetica	Verein
7570	Climate Technology Centre & Network	Staatlich
7882	Barex S.à r.l.	GmbH
7885	Educa Swiss Schweizerische Stiftung für Bildungsförderung und -finanzierung	Stiftung
7887	Schweizer Patenschaft für Berggemeinden	Verein
7921	Fondation internationale pour la conservation de la nature tropicale	Stiftung
7939	Sammelplatz Schweiz GmbH	GmbH
7961	Kreisschule Aarau-Buchs	Staatlich
8001	TotalEnergies Aviation Suisse SA	AG
8018	Volare Group AG	AG
8031	Shell Finance Switzerland AG	AG
8083	Silvia e Peter Lendi erboristi SA	AG
8098	Ernährungspolitik	Parlamentarische Gruppe
8121	Movetia Austausch und Mobilität	Verein
5264	L'Hebdo	Einfache Gesellschaft
5944	Stiftung Privatschulregister Schweiz	Stiftung
5941	Trägerverein Schweizer Jugendmusikfest 2019 Burgdorf	Verein
5961	Swiss Medical Board	Verein
6001	Sekundarstufe I, Sion	Staatlich
6014	Bernische Ortspolizeivereinigung	Verein
5751	Fondation Fellini pour le cinéma	Stiftung
5776	Coscienza Svizzera - Gruppo di studio e di informazione	Verein
5779	Stiftung Infanterie-Bunker Fischbalmen	Stiftung
5749	Fondation Maison de la Famille à Vérolliez en liquidation	Stiftung
6052	FERI Mit-Wirkung	Einzelunternehmen
6072	Verein Schutzinitiative	Verein
6108	Parlamentarische Gruppe Schweiz - Thailand	Parlamentarische Gruppe
6112	Schweizerische Akademische Gesellschaft für Umweltforschung und Ökologie	Verein
6130	Grünliberale Partei Stadt Zürich	Verein
6155	Läderach (Schweiz) AG	AG
6171	Ericsson AG	AG
6102	Klinik Gais Infrastruktur AG	AG
6213	Mittelständischer Detailhandel	Parlamentarische Gruppe
6223	Junge Grünliberale Kanton Schwyz	Verein
6251	GOSTELI-STIFTUNG	Stiftung
6273	Schweizerische Gesellschaft für Dermatologie und Venerologie	Verein
6297	Spitex Genossenschaft für Bern	Genossenschaft
6322	Zivilgesellschaftliche Plattform Agenda 2030 für nachhaltige Entwicklung	Verein
6371	Handelskammer Schweiz - Taiwan	Verein
6418	Gewerbeverband Kanton Zug	Verein
6351	Hauseigentümerverband Bezirk Küssnacht	Verein
6313	GENERALE BEAULIEU HOLDING SA	AG
6498	Tambouren- und Pfeiferverein Naters	Verein
6513	Juristes progressistes vaudois·es	Verein
6361	Genossenschaft Faire Milch Säuliamt	Genossenschaft
6537	Swiss Finance Boutique AG	AG
6476	Rotary Club Olten	Verein
6594	Stiftung Bildung des Gewerkschaftsbundes Kanton Solothurn	Stiftung
6583	FranktionsZwang	Verein
6636	ScolArch	Einzelunternehmen
6569	Hochschule für Wirtschaft Freiburg	Staatlich
6643	Mieterinnen und Mieterverband Deutschfreiburg	Verein
6694	Eidgenössische Natur- und Heimatschutzkommission	Ausserparlamentarische Kommission
6728	Jungen- und Mädchenpädagogik	Verein
6652	Lycée-Collège Creusets	Staatlich
6743	Energie Opfikon AG	AG
6778	Grünliberale Partei Stadt St.Gallen	Verein
6799	SAH Region Basel in Liquidation	Verein
6818	Grüne Partei Thurgau	Verein
6573	Compagnie Industrielle et Commerciale du Gaz SA	AG
6856	Grüne Oberwallis	Verein
6872	Asylbrücke Zug	Verein
6895	Union des paysannes et femmes rurales genevoises	Verein
6920	Schweizerische Volkspartei Frauen Aargau	Verein
6946	Fondation KISS	Stiftung
6960	Ordre des avocats de Genève	Verein
6980	Aargauer Wanderwege	Verein
6494	Satiremanufaktur	Informelle Gruppe
7037	Appenzeller Bahnen AG	AG
6986	Alpprodukte Pragel / Bödmeren Genossenschaft	Genossenschaft
6990	Kanton Schwyz	Staatlich
7004	Société de développement de Jongny	Verein
7121	Bundesverwaltungsgericht	Staatlich
7144	Étude Javet Schwarb Mauri	Einfache Gesellschaft
7170	Stiftung Alters- und Pflegeheim Hasle-Rüegsau	Stiftung
7194	FDP Die Liberalen St. Gallen-Gossau	Verein
7207	Alternative - die Grünen Stadt Zug	Verein
6392	Luzerner Kantonalbank AG	AG
7238	Latanguera	Einzelunternehmen
7245	Transgourmet Schweiz AG	AG
6675	FigurenTheater St. Gallen	Verein
7295	Gemeinde Savigny	Staatlich
7324	Forschungsinstitut für Internationales Management Universität St. Gallen	Oeffentlich-rechtlich
7346	Reporter ohne Grenzen	Verein
7340	Mobyfly SA	AG
7390	Fachverband Schweizer Raumplaner	Verein
7440	Groupe Sportif Tabeillon	Verein
7459	SAMDalumni	Verein
7406	Foodwatch Deutschland	Verein
7463	Bündner Offiziersgesellschaft	Verein
7395	Fédération romande des associations LGBTIQ	Verein
7539	Oberaufsichtskommission berufliche Vorsorge	Staatlich
7516	Stiftung Kunst für den Tropenwald	Stiftung
7616	Raiffeisenbank Seeland Genossenschaft	Genossenschaft
7628	Sozialdemokratische Partei Klettgau West	Verein
7695	Stiftung LUCERNE FESTIVAL	Stiftung
7669	Verein CH2021	Verein
7643	Zunft zu Pfistern	Verein
7681	Junge Wirtschaftskammer Appenzellerland	Verein
7775	ipso Bildung Holding AG	AG
7689	Variaton Projektorchester	Verein
7647	Schweizerische Belegärzte-Vereinigung	Verein
7825	CHANCE5G	Verein
7834	Aepli Metallbau AG	AG
7866	Bäumle Messungen und Beratungen AG	AG
7840	Bauart Architekten und Planer AG	AG
7892	Hauseigentümerverband Region Winterthur	Verein
7905	Urner Gemeindeverband	Verein
7927	Versorgungssicherheit im Gesundheitswesen	Parlamentarische Gruppe
7951	Genossenschaft Dorfladen Frauenkappelen	Genossenschaft
7964	Impro Suisse Sàrl	GmbH
7579	Centro Competenze Tributarie	Staatlich
8058	Alnatura AG	AG
8067	Bio Partner Schweiz AG	AG
8072	Chocolat Bernrain AG	AG
8076	Delica AG	AG
7606	Stifterverein Medienqualität Schweiz	Verein
8136	Associazione Relazioni Svizzera italiana - Berna	Verein
8143	Sigmacom Telecom SA	AG
8161	Licht- und Wasserwerk Adelboden AG	AG
8039	Schätzle Holding AG	AG
5818	Fachstelle für Schuldenfragen Luzern	Verein
5895	Linax Invest AG	AG
5964	lingua e cultura rumantscha	Parlamentarische Gruppe
5980	Lüthi & Portmann Fleischwaren AG	AG
5997	PERRIN HOLDING SA	AG
6012	Identität Oberaargau	Verein
5758	Qualidruck GmbH in Liquidation	GmbH
5756	digital-liberal.ch	Verein
5764	ÖKK Kranken- und Unfallversicherungen AG	AG
6030	Verein der Freunde der schweizerischen Luftwaffe (VFL)	Verein
6039	Trachtengruppe Werdenberg-Buchs	Verein
6062	MachTheater	Verein
6104	obvita Ostschweizerischer Blindenfürsorgeverein	Verein
6111	Zweckverband Regionale Sport- und Erholungsanlagen Kellen Tübach	Oeffentlich-rechtlich
6129	Literarische Gesellschaft Baden	Verein
6141	Domaines Chevaliers SA	AG
6170	Dachorganisation der Frauenhäuser Schweiz und Liechtenstein	Verein
6190	Mütterzentrum Bern West	Verein
6200	Club diplomatique de Genève	Verein
6231	Allgemeine Musikschule Oberwallis	Verein
6256	Feldschützengesellschaft Walliswil-Wangen	Verein
6264	Service4Glarus AG	AG
6292	Franz Carl Weber AG	AG
6320	Komitee Nein zum schleichenden EU-Beitritt	Informelle Gruppe
6365	Hans Huber-Stiftung	Stiftung
6417	Feldmusik Baar	Verein
6408	Jagdschützen Suhr	Verein
6452	Sinnsprung	Einzelunternehmen
6457	VEREIN INTERNATIONALE LAUBERHORNRENNEN, WENGEN	Verein
6358	Sozialkonferenz Kanton Zürich	Staatlich
6500	St-Barbaraverein	Verein
6538	Freunde des Centro Giacometti	Verein
6575	Berufs- und Weiterbildungszentrum für  Gesundheits- und Sozialberufe St.Gallen	Staatlich
6579	proPellets.ch	Verein
6601	Città di Mendrisio	Staatlich
6505	Türkenbund Brig	Verein
6659	Schweizer Jugendmusikfest 2023	Verein
6685	GrünstattUster	Verein
6696	FDP die Liberalen Kreis 7&8	Verein
6701	Stadt Olten	Staatlich
6706	Les Engagés pour la santé	Verein
6721	Regionaler Führungsstab Toggenburg	Staatlich
6775	Soliday Stiftung Aargau	Stiftung
6793	Stiftung Gärtnerhaus	Stiftung
6815	FDP Die Liberalen Oberengadin - Bregaglia	Verein
6831	Fundaziùn Tgea da tgànt	Stiftung
6845	Schützenverein Matt-Engi	Verein
6864	Aedificura AG	AG
6888	Gastro Thurgau	Verein
6906	Touringclub Schweiz TCS Sektion Bern	Verein
6926	Arbeitsgruppe Kultur & Schule	Informelle Gruppe
6949	Stiftung Mühle Otelfingen	Stiftung
6976	Museumsverein Suhr	Verein
7008	Freiburger Kantonal Musikverband	Verein
6495	Transgender Network Switzerland	Verein
7038	Chech AG	AG
6981	Verein ehemaliger Lenzburger SchülerInnen	Verein
7079	Fondation carougeoise pour le logement de personnes âgées	Oeffentlich-rechtlich
7005	Rotary Club Vevey-Montreux-Riviera	Verein
6379	LCCO SA	AG
6382	Albula Netz AG	AG
7154	Koordinationskonferenz der Bau- und Liegenschaftsorgane der öffentlichen Bauherren	Staatlich
7179	SGV Holding AG	AG
6385	Energie Burgholz AG	AG
6389	netzmedien AG	AG
6393	Green Datacenter Properties AG	AG
7251	festival 4 saisons	Verein
7262	Procap Grischun	Verein
6682	Gemeinde Wetzikon	Staatlich
7293	Alumni phsz	Verein
7310	Weisses Kreuz AG	AG
7306	Groupe CGN SA	AG
7332	Pfadiabteilung Blauen	Verein
7376	Fondation "Divisionnaire F.K. Rünzi"	Stiftung
7425	Gemeinde Dietikon	Staatlich
7458	FDP die Liberalen Baar	Verein
7474	FDP Die liberalen Hünenberg	Verein
7466	Oxia SA	AG
7397	Fondation TRIVAPOR-Marc OESTERLE- Navigation à vapeur sur les lacs jurassiens	Stiftung
7544	Wohnbau-DT GmbH in Liquidation	GmbH
7528	Jeunes socialistes neuchâtelois	Verein
7619	Stiftung Schweizer Jugend-Sinfonie-Orchester	Stiftung
7453	Jodlerclub Blatten	Verein
7668	Verein Weltacker Schweiz	Verein
7715	senesuisse Verband privater Alters- und Pflegeeinrichtungen Schweiz	Verein
7724	Lions Club Erlinsburg	Verein
7726	politiciennes.ch	Verein
7594	Behindertenfragen	Parlamentarische Gruppe
7806	Fondazione Giovanni Enrico e Frida Stamm	Stiftung
7826	Lions Club Titlis	Verein
7852	Trägerverein des Thurgauer Kantonalschützenfest 2023	Verein
7865	Jugendkomitee für eine offene Schweiz	Informelle Gruppe
7737	Verein Winterthurer Musikfestwochen	Verein
7575	Stiftung meineimpfungen in Liquidation	Stiftung
7656	Medgate Partner Network	Stiftung
7926	Kryptowährungen/Digital Assets	Parlamentarische Gruppe
7745	Gemeinde Kirchberg (BE)	Staatlich
7968	Koch Swiss Footage	Einzelunternehmen
7981	Trägerverein Eidgenössisches Schwing- und Älplerfest 2019 Zug	Verein
8059	Bell Schweiz AG	AG
8036	Varo Refining (Cressier) SA	AG
8093	Mifroma SA	AG
8104	SI Rue de Conthey No 2 SA	AG
8109	Frutonic SA	AG
8138	Paxedra AG	AG
8157	Begleitgruppe Räumung ehemaliges Munitionslager Mitholz	Einfache Gesellschaft
8165	PHENOGY AG	AG
8055	Interessengemeinschaft Bio Schweiz (IG BIO)	Verein
8180	The Boeing Company	AG
8195	Allgemeine Offiziersgesellschaft Von Zürich & Umgebung	Verein
8228	Réservé Media Group Sagl	GmbH
5893	Zürcher Planungsgruppe Zimmerberg	Oeffentlich-rechtlich
5948	PROMEA Ausgleichskasse	Oeffentlich-rechtlich
5967	Parlamentarische Gruppe Schweiz - Algerien	Parlamentarische Gruppe
5986	Förderverein Galeata-Quartett	Verein
6004	Jugendparlament Oberaargau	Verein
5750	Fondation Rives-du-Rhône en liquidation	Stiftung
5755	Parlamentarische Gruppe Westsahara	Parlamentarische Gruppe
5778	Freiluft- und Hallenbad Bödeli AG	AG
6044	Credit Suisse Asset Management (Schweiz) AG	AG
6042	IMMONIO AG	AG
6067	Les Fils Maye SA	AG
6082	Operettenbühne Bremgarten	Verein
6128	Kontextplan AG	AG
6145	MATZA - Art, Land Use, Democracy	Informelle Gruppe
6166	Swiss Blockchain Federation (SBF)	Verein
6187	Stiftung Vivendra	Stiftung
6208	Schweiz - Ungarn	Parlamentarische Freundschaftsgruppe
6229	Fondation valaisanne de probation	Stiftung
6237	Swiss Swimming	Verein
6269	A. Segert Publikationen	Einzelunternehmen
6288	Tensor Technologies AG in Liquidation	AG
6317	Konferenz Aargauischer StaatsPersonalVerbände	Verein
6327	HURO / RUI - Referendum und Initiativen	Informelle Gruppe
6333	University of Bologna Law Review	Oeffentlich-rechtlich
6423	Offiziersgesellschaft des Kantons Zug	Verein
6352	Neue Europäische Bewegung Schweiz (Nebs) - Sektion Basel	Verein
6429	Schweizerischer Verband für Pferdesport	Verein
6432	Schweizer Alpen-Club SAC Sektion Rossberg	Verein
6527	Fondazione Maddalena e Alfredo Airoldi	Stiftung
6501	St-Jakobsverein	Verein
6563	Stiftung Schweizerisches Institut für Kunstwissenschaft (SIK-ISEA)	Stiftung
6478	ShelterBox Schweiz	Verein
6626	Verein Spitex Heitersberg	Verein
6634	Association Espace A	Verein
6662	UZH Alumni	Verein
6687	Stadt Uster	Staatlich
6697	Jungfreisinnige Kanton Zürich	Verein
6716	Agrarpolitische Kommission des Schweizerischen Bäuerinnen- und Landfrauenverbandes	Einfache Gesellschaft
6756	Vincenz | Dornier. Anwaltsbüro und Beurkundungen	KG
6770	CVP Rickenbach/Pfeffikon	Verein
6789	Einwohnerrat Riehen	Staatlich
6808	Arslan GmbH	GmbH
6830	Analyt Invest AG	AG
6848	Espace Gruyère SA	AG
6859	Pensionskasse Basel-Stadt	Oeffentlich-rechtlich
6886	Strupler Gartenbau Winterthur AG	AG
6915	PLR I liberali radicali Comano	Verein
6934	Pro Velo Graubünden	Verein
6953	Stiftung Discherheim - Wohnen und Arbeiten Solothurn	Stiftung
6970	FDP.Die Liberalen Frauen Region Aarau	Verein
6492	Volksinitiative für ein gesundes Klima	Informelle Gruppe
7031	Urner Kantonaler Schwingerverband	Verein
7041	Lions Club Appenzell	Verein
6987	Sigristenhaus AG	AG
7089	J-eNOV SA	AG
7101	Festival International du Film sur les Glacier	Verein
7119	Bären-Club	Verein
7149	PK-Netz	Verein
7172	Cevi Regionalverband AG-SO-LU-ZG	Verein
7193	SRG Zentralschweiz	Verein
7205	Stiftung Phönix Zug	Stiftung
7220	Bischofszell Nahrungsmittel AG	AG
7246	Morosoli SA	AG
7263	Graubünden Holz	Oeffentlich-rechtlich
6681	Schweizerische Vereinigung amtlicher Pilzkontrollorgane	Verein
7294	Fondation FC Villars-sur-Glâne pour la promotion du sport	Stiftung
7325	The Conference Board	Einfache Gesellschaft
7330	Schweizerischer Rat der Religionen	Einfache Gesellschaft
7362	Vereinigung für eine Schweiz ohne synthetische Pestizide	Verein
7377	3L Informatik AG	AG
7439	LANDI Zugerland, Genossenschaft	Genossenschaft
7444	Stiftung Schweizerische Sportmittelschule Engelberg	Stiftung
7424	Clean Fuel Now	Verein
7511	ACADEMIA EUREGIO BODENSEE AG	AG
7396	Marche du 1er mars	Verein
7560	CH Gérance Suisse SA	AG
7611	BusinessEurope	Verein
7618	Gemeinde Lignerolle	Staatlich
7625	Cycla - Die Schweizer Velo-Allianz	Informelle Gruppe
7697	Trägerverein 31/07 Bundesfeier	Verein
7670	kindsverlust.ch	Verein
7721	SWS Medien AG Werbung	AG
7684	Tennisclub Herisau	Verein
7598	Gutes Hören	Parlamentarische Gruppe
7810	Brun & Co.	Einzelunternehmen
7731	Bergbahnen Wildhaus AG	AG
7734	Stiftung für den Schweizer Nachwuchs im Radsport	Stiftung
7566	Culture of Change Foundation in Liquidation	Stiftung
7652	Galenica AG	AG
7763	Fondation Culturelle BCN	Stiftung
7900	TRANSFORM HEALTH ASSOCIATION	Verein
7909	Schweizerische Vereinigung der Ingenieurinnen	Verein
7944	Junge Grünliberale der Stadt Zürich	Verein
7970	AZ Regionalfernsehen AG	AG
8011	Porta Ticino Easy Stop SA	AG
8009	ECSA Maintenance AG	AG
8064	bio-familia AG	AG
7770	International Fistball Association	Verein
8097	Schweizerische Schälmühle E. Zwicky AG	AG
7610	jugendsinfonieorchester zürichsee	Verein
8127	La Société des Sentiers des Gorges de l'Areuse	Verein
8156	GRAND CASINO KURSAAL BERN AG	AG
8164	Fussballgolf Thurgau GmbH	GmbH
8046	Ville de Pully	Staatlich
8177	Handballclub Bruggen	Verein
8192	Gesellschaft der Generalstaboffiziere	Verein
8226	Hotel & Gastro formation by Hotel & Gastro Union, GastroSuisse, hotelleriesuisse	Verein
8242	Vereinigung Starke Region Basel/Nordwestschweiz	Verein
6005	Wüthrich Haustechnik AG	AG
5649	Reiterinteressengemeinschaft Frienisberg Süd	Verein
5762	Schweizerische Beratungsstelle für Unfallverhütung bfu	Stiftung
5780	Schweizerische Volkspartei Matten	Verein
5796	MediCuba-Suisse	Verein
6053	The Hunger Project	Verein
6075	Marketing Communications Executives International	Verein
6096	Stiftung Wertbühl	Stiftung
6084	STV Baden Handball	Verein
6143	Staatslabor	Verein
6147	Verein Zivilgesellschaft	Verein
6180	Evolve SA	AG
6193	Gesellschaft Schweiz-Palästina	Verein
6221	Verein Ehemaliger Jungwächter	Verein
6244	Turnverein Aussersihl Zürich	Verein
6266	Fondazione Verzasca - Agenzia di sviluppo territoriale	Stiftung
6285	CooperativeSuisse - Plattform für Genossenschaften und Soziales Unternehmertum	Verein
6315	Kanton Schaffhausen	Staatlich
6341	Bollwerkstatt	Verein
6395	Weinfreunde Menzingen	Verein
6349	Stiftung für die Adliswiler Jugend	Stiftung
6426	Vimentis	Verein
6454	Interessensgemeinschaft öffentlicher Verkehr, Sektion Waadt	Verein
6377	Mori Projekte	Einzelunternehmen
6512	Parti Socialiste Vallée de Joux	Verein
6531	WAS Wirtschaft Arbeit Soziales wira Luzern	Staatlich
6518	Arbeitsgruppe Kernkraftwerkbetreiber Ausschuss nukleare Entsorgung	Informelle Gruppe
6576	Bildungszentrum für Gesundheit und Soziales Weinfelden	Staatlich
6557	Coralisa SA en liquidation	AG
6581	Unterstützungsverein der Archive der Aargauer Arbeiterbewegung	Verein
6633	constructionromande	Verein
6605	Fidinam SA	AG
6608	Stiftung Elternsein	Stiftung
6610	Kantonalschützenverband Uri	Verein
6724	Grüne Seeland	Verein
6733	IG Seepärke Zürich	Verein
6719	Schweizerische Volkspartei Ebnat-Kappel	Verein
6754	Oberst Künzli-Gesellschaft	Verein
6790	BALEX AG	AG
6806	Familien-, Paar- und Erziehungsberatung	Verein
6572	WEYA Sàrl	GmbH
6851	FONDATION SEED CAPITAL FRIBOURG	Stiftung
6861	Fondation pour le développement durable des régions de montagne	Stiftung
6879	Blütenwerke AG	AG
6912	Stiftung Swiss Sport Integrity	Stiftung
6927	Resonanzgruppe Lehrplan 21 GR	Informelle Gruppe
6956	WAEBER MAITRE Avocats au barreau de Genève	Einfache Gesellschaft
6486	Gewerbe Rapperswil-Jona	Verein
6994	IG ROTE FABRIK	Verein
7019	Schulhaus Burg	Staatlich
7040	Turnverein Appenzell	Verein
7057	Fondation "Mémoire, Art et Forêt Bonfol" en liquidation	Stiftung
7081	Rat für nachhaltige Entwicklung des Kantons Genf	Staatlich
7096	Stahlpromotion Schweiz	Verein
7117	Foundation for Cardiological Research and Education - FCRE	Stiftung
7139	Cutohof AG	AG
7163	Stiftung Kinderheim Brugg	Stiftung
7191	Autismus deutsche schweiz	Verein
7199	agrarmodul GmbH	GmbH
7212	Theater Club tctz!	Verein
7233	Verein Eidgenössische Organisatorenprüfung	Verein
7258	Kartex Sport SA in liquidazione	AG
7276	Charles Rodolphe Brupbacher Stiftung	Stiftung
7282	SwissCham Southern Africa	Verein
7297	cybera	AG
7317	Binder Rechtsanwälte KLG	KG
7366	Berufs-, Studien- und Laufbahnberatung St.Gallen	Staatlich
7357	Grünliberale Partei Morges	Verein
7414	CVP Baden	Verein
7382	Grimselbahn AG	AG
7477	Strand Cosmetics Europe	AG
7513	Swiss Trading and Shipping Association	Verein
7500	Valmedia AG	AG
7538	Schwingklub Burgdorf	Verein
7563	Verein Netzwerk Kinderrechte Schweiz	Verein
7617	Aletsch AG	AG
7629	Meier + Cie AG Schaffhausen	AG
7637	OSFIN Organisation de surveillance financière	Verein
7712	MEDIAparc SA	AG
7677	Stiftung Ostschweizer Kinderspital	Stiftung
7758	Bieli Transport AG	AG
7786	pro-salute.ch	Verein
7646	Herzog Bauspenglerei AG Luzern	AG
7819	Bischof Rechtsanwälte	Einfache Gesellschaft
7803	FCW Group AG	AG
7864	Einkaufsgenossenschaft Gebäudetechnik EGT	Genossenschaft
7761	FC St. Gallen Event AG	AG
7574	Schweizerische Hirnliga	Verein
7888	Energissima	Einfache Gesellschaft
7918	Asylnetz Baar	Informelle Gruppe
7936	FinanceMission	Verein
7966	Nationale Jugend Brass Band	Verein
8004	CICA SA	AG
8027	Schweizerische Volkspartei Region Konolfingen	Verein
8022	Osterwalder St. Gallen Holding AG	AG
8070	FE Agentur AG	AG
8099	ALPISA SA	AG
8120	Verein PRS PET-Recycling Schweiz	Verein
8137	Internationale Fernmeldeunion	Staatlich
8150	DocMorris AG	AG
8160	Bovida Real Estate AG	AG
8052	CLINIQUE GENERALE-BEAULIEU SA	AG
8174	Homburger AG	AG
8182	Capita Europe	AG
8220	RTS Radio Télévision Suisse, succursale de la Société suisse de radiodiffusion et télévision	Verein
8245	VAM Verein für aktive Arbeitsmarktmassnahmen	Verein
8267	Basler Kindertheater	Einzelunternehmen
8278	Freundeskreis Carmel du Pâquier	Verein
8335	Historikerinnennetzwerk Schweiz	Verein
8352	European Green Party	Verein
8368	Fussballclub Gunzwil	Verein
8390	Verein Cannabis Research	Verein
6018	Schweizer Allianz Gentechfrei	Verein
5859	Brunni-Bahnen Engelberg AG	AG
5864	Fondation VD 3209	Stiftung
5792	Internet Engineering Task Force	Informelle Gruppe
6034	Limmattalbahn AG	AG
6064	RAFALE INTERNATIONAL, St-Cloud (F), succursale de Berne	AG
6094	Belvédère Asset Management AG	AG
6114	Parlamentarische Gruppe Pazifik-Allianz	Parlamentarische Gruppe
6125	Der gesunde Menschenversand GmbH	GmbH
6157	Milchjugend	Verein
6173	Gebäudeenergieausweis der Kantone	Verein
6194	Stiftung Horyzon	Stiftung
6225	Gemeinde Ingenbohl	Staatlich
6236	Schwimmclub Solothurn	Verein
6267	FDP Die Liberalen Minusio	Verein
6282	Sichere Grenzen im Rheintal	Verein
6307	Komitee Bodeninitiative	Informelle Gruppe
6346	Forum Ostaargauer Strassenentwicklung	Einfache Gesellschaft
6336	Der Schweizerische Schachbund	Verein
6407	Aargauischer Jagdschutzverein	Verein
6427	Crealogix Holding AG	AG
6376	Stiftung Heilsarmee Schweiz	Stiftung
6357	Gemeinde Hagenbuch	Staatlich
6526	Komitee "PH in die Kammgarn"	Informelle Gruppe
6534	SB Saanen Bank AG	AG
6549	EthiX - Lab für Innovationsethik	Verein
6555	Verein Kontrollkommission für umweltschonende und tierfreundliche Landwirtschaft	Verein
6596	Sportpark Bünzmatt AG	AG
6628	Rotary Club Baden- Rohrdorferberg	Verein
6638	Naturgruppe Salix	Verein
6663	Hochschule für Gesundheit Waadt	Oeffentlich-rechtlich
6609	Haus der Volksmusik Altdorf	Verein
6710	Verein Förderung junge Personen in der Gemeindepolitik	Verein
6651	sanu Future Learning AG	AG
6755	Lernfahrkarten GmbH in Liquidation	GmbH
6746	Spitex-Verein Opfikon-Glattbrugg	Verein
6796	BENEVOL Aargau	Verein
6811	Entsorgung Region Zofingen	Verein
6826	Wohnen am Bächli AG	AG
6846	Ville de Bulle	Staatlich
6869	Mieterinnen- und Mieterverband Zug	Verein
6880	Strupler Events GmbH	GmbH
6913	Schweizerische Volkspartei Bern-Mittelland	Verein
6930	Kulturkanton Graubünden	Verein
6950	Gemeinde Otelfingen	Staatlich
6974	Freunde Stadtmuseum Aarau	Verein
6996	Rahn-Stiftung	Stiftung
7018	genossenschaft solaroltingen	Genossenschaft
7036	Ärzteverband des Kantons Genf	Verein
7059	FONDATION JEAN TROILLET	Stiftung
7065	CMGRP Switzerland Sàrl	GmbH
7003	Fondation du Musée suisse de l'appareil photographique de Vevey	Stiftung
7118	FDP Die Liberalen Kanton Neuenburg	Verein
7138	collaborative law and practice Schweiz	Verein
7171	Eidgenössisch-Demokratische Union Kanton Bern	Verein
7129	Frauenstreik Koordinationsgruppe Bern	Informelle Gruppe
7209	OSOLEBIO Zentralschweizer Biomarkt	Verein
7215	FLIZ, FilmLiebhaberInnenZug	Verein
7239	SVIAL/ASIAT - Berufsverband der Hochschulabsolventen im Agro-Food-Bereich	Verein
7264	Spitex Verband Graubünden	Verein
7014	Verein Theaterfestival Basel	Verein
7289	Schweizerische Volkspartei Weinfelden	Verein
7302	Vorzimmer GmbH	GmbH
7344	Centre de liaison des association féminines genevois	Verein
7338	Amt für Wirtschaft und Arbeit Zürich	Staatlich
7374	Elektro Ruppen AG	AG
7360	Akademie-Dialog Santé AG	AG
7381	Hommage 2021	Verein
7423	Audi AG	AG
7482	Ökozentrum Langenbruck	Stiftung
7469	Martin Beratungen	Einzelunternehmen
7501	Fédération des Etudiant-e-s Neuchâtelois-e-s	Oeffentlich-rechtlich
7542	PROPAYSAGES SA	AG
7546	Rösterei Maria-Rickenbach GmbH	GmbH
7491	aeB Schweiz - Akademie für Erwachsenenbildung	Verein
7493	Fondation CULTURE DU BATI	Stiftung
7699	Junge SVP Kanton St. Gallen	Verein
7673	Cave des Muverans Sàrl	GmbH
7525	Stiftung Neues Theaterhaus Luzern	Stiftung
7590	Law and Economics Foundation St. Gallen	Stiftung
7783	Anwälte 44	Einfache Gesellschaft
7814	Stiftung World Vision Schweiz und Liechtenstein, Kinderhilfswerk	Stiftung
7818	metrobasel	Verein
7830	Nordostschweizerisches Jodlerfest 2022 Appenzell	Verein
7759	Fondation communale pour le développement des emplois et du tissu économique en ville de Genève - Fondetec	Oeffentlich-rechtlich
7875	Carrière Féminine	Informelle Gruppe
7891	TCS Landesteil Bern-Mittelland	Verein
7901	Sozialdemokratische Partei Riehen-Bettingen	Verein
7659	Medgate Holding AG	AG
7942	Junge Grünliberale des Kantons Zürich	Verein
7965	IMS Immobilien Multiservice AG	AG
7583	Hof Weissbad AG	AG
8016	Lang Energie AG	AG
8061	Hilcona Aktiengesellschaft	AG
8024	Osterwalder Immobilien Zürich AG	AG
8087	HBC Rotweiss Belp	Verein
8080	Dixa Immobilien AG	AG
8123	The Global Antibiotic Research and Development Partnership (GARDP)	Staatlich
8144	Kreislaufwirtschaft	Parlamentarische Gruppe
7848	Stiftung Drachenburg und Waaghaus Gottlieben	Stiftung
7849	Verein Schlossfestspiele Hagenwil	Verein
8045	Service intercantonal d'entretien du réseau autoroutier des cantons de Fribourg, de Vaud et de la République et canton de Genève (SIERA)	Oeffentlich-rechtlich
8194	Offiziersgesellschaft Freiamt	Verein
8224	Ristorante della Torre	Einzelunternehmen
8211	Café Wortschatz Balsthal	Verein
8264	J'aime ma planète	Verein
5650	Frauenverein Hondrich	Verein
5974	Parlamentarische Gruppe Zentral- und Ostafrika	Parlamentarische Gruppe
5789	Société de tir pratique Valais	Verein
6045	myStromer AG	AG
6041	Offiziersgesellschaft Werdenberg	Verein
6071	Kanton Thurgau	Staatlich
6081	Société coopérative de l'abattoir régional d'Orbe	Genossenschaft
6100	Pensionskasse Stadt St.Gallen	Oeffentlich-rechtlich
6134	Bündner Tagblatt Verlags AG	AG
6153	Euroinferno	Verein
6186	SmartKids GmbH in Liquidation	GmbH
6197	Hauseigentümerverband Appenzell Ausserrhoden	Verein
6226	Gassmann Beratung & Forschung	Einzelunternehmen
6250	Xing Ambassador Community Argovialand	Informelle Gruppe
6272	Booking.com	AG
6293	Fondation pour la Garde Suisse Pontificale au Vatican	Stiftung
6321	fair unterwegs - arbeitskreis tourismus & entwicklung	Verein
6370	Swiss Bike Park AG	AG
6400	Triathlonclub Zofingen	Verein
6311	Soja Netzwerk Schweiz	Verein
6447	AMB Assurances SA	AG
6430	sp-ps-section.EU	Verein
6462	KEBAG AG	AG
6522	Gemeinde Torny	Staatlich
6517	Internetcafé Planet 13	Verein
6520	Jungfreisinnige Gros-de-Vaud	Verein
6558	Opernhaus Zürich AG	AG
6614	International Christian Fellowship Zürich	Verein
6567	Swiss Life Holding AG	AG
6661	Allianz gegen Altersdiskriminierung	Verein
6670	Ryser Optik AG	AG
6647	SRG Freiburg	Genossenschaft
6732	FDP Die Liberalen Uri	Verein
6759	Ombudsstelle Alter und Behinderung der Kantone SG, AR und AI	Verein
6745	KZU Kompetenzzentrum Pflege und Gesundheit	Staatlich
6792	Liip AG	AG
6809	Gemeinde Aarburg	Staatlich
6678	Gredig Consulting Services AG in Liquidation	AG
6677	JuBria - Juventud Brigadista	Verein
6878	Umraum Landschaftsarchitektur GmbH	GmbH
6907	Spitex Verband Kanton Bern	Verein
6919	Heimgartner AG	AG
6936	Bioterra	Verein
6958	Fondation PACIFIQUE	Stiftung
6983	Grüne Partei Genf	Verein
7007	Fanfare régionale d'Attalens	Verein
7021	CVP Altdorf	Verein
7043	SCHWEIZERISCHE MOBILIAR Versicherungsgesellschaft, Generalagentur Appenzell, Thomas Rechsteiner	Einzelunternehmen
7068	Association pour le bien des aveugles et malvoyants	Verein
7092	Ensemble à Gauche - Genève	Verein
7115	Skeptiker Schweiz	Verein
6383	ela energiewelt	Verein
7169	Gemeinde Rüegsau	Staatlich
7128	Garage H. Bühlmann AG	AG
7198	Rivengo GmbH	GmbH
7225	Verein der Ehemaligen und Freunde der Kantonalen Mittelschule Uri	Verein
7241	Swiss Shipowners Association	Verein
7254	Stiftung Grüner Bundesplatz	Stiftung
7267	Digital Eleven	Verein
6680	Grüne Bezirk Hinwil	Verein
7299	VPOD Sektion Zug	Verein
7326	Bundesamt für Justiz	Staatlich
7365	Grassrooted GmbH	GmbH
7388	Fasnachtsgesellschaft "Diä Giftigä" Altdorf	Verein
7385	SMPV Schweizerischer Musikpädagogischer Verband	Verein
7456	Stiftung Baukultur Schweiz (SBS)	Stiftung
7476	LiMVO Stiftung für die Verifizierung von Arzneimitteln in Liechtenstein	Stiftung
7498	Kanton Appenzell Ausserrhoden	Staatlich
7393	Procivis AG	AG
7552	Konstituierende Versammlung Grossfreiburg	Verein
7586	Schweizerische Südostbahn AG	AG
7504	Grüne Partei Waadt	Verein
7664	Unilabs St. Gallen AG	AG
7639	Kulturverein Udligenswil	Verein
7642	Carlton Tivoli Tennis Club	Verein
7674	FDP Die Liberalen Grub	Verein
7753	Hürlimann Informatik AG	AG
7593	Vision Konsum	Verein
7788	Einwohnergemeinde Alchenstorf	Staatlich
7801	POOL-Alpin Schweiz AG	AG
7833	Wasserstoff/Power-to-X	Parlamentarische Gruppe
7568	BNJ Suisse SA	AG
7762	FC St. Gallen AG	AG
7889	Notre Armée de Milice, Administration et rédaction	Verein
7767	Nationales Testinstitut für Cybersicherheit NTC	Verein
7923	Søren Henrichsen Design Studio Sàrl	GmbH
7952	Einwohnergemeinde Frauenkappelen	Staatlich
7978	Fondation de l'Orchestre de la Suisse Romande	Stiftung
8003	BP Europa SE, Hamburg, Zweigniederlassung BP (Switzerland) Baar	AG
8017	Oel-Pool AG	AG
8066	Biotta AG	AG
8025	Osterwalder Tanklager Zürich AG	AG
8091	Lega polmonare ticinese	Verein
7605	Stiftung Schürmatt	Stiftung
8132	Verein Spielgruppe Mümliswil	Verein
8140	Zugerberg Finanz AG	AG
7844	Wohnliches St.Georgen	Verein
7996	Rechtsanwälte und Notare Perrig & Partner	Einfache Gesellschaft
8172	Energy Living Lab	Verein
8183	SGT Capital	AG
8214	Gastroconsult AG	AG
8233	Fasnachtsorganisation Fidelitas Flüelen	Verein
8249	Schweizerisches Tropen- und Public Health-Institut	Staatlich
8285	Sorten für morgen	Verein
8294	ASCA, Schweizerische Stiftung für Komplementärmedizin	Stiftung
8297	ASS. CINEMA DES TROIS MONDES PROJECTION DE FILMS	Verein
8355	Société de gestion du Quadrant Sàrl	GmbH
8315	Rad Rennclub Bern	Verein
8404	Radio- und Fernsehgenossenschaft Zürich Schaffhausen (RFZ)	Genossenschaft
8414	Büro Albatros GmbH	GmbH
8444	Cafetier Verband	Verein
5651	Sozialdemokratische Partei Kanton Thurgau	Verein
5760	Stiftung Beratungsstelle für Unfallverhütung in der Landwirtschaft (BUL)	Stiftung
5784	Stiftung für die Auslandschweizer	Stiftung
5267	Matthias Haab AG	AG
6051	South Pole Suisse AG	AG
6060	FDP Die Liberalen Eschlikon	Verein
6097	Wohlfahrtsfonds für die Mitarbeiter des Pressvereins der Thurgauer Volkszeitung	Stiftung
6088	EWA-energieUri AG	AG
6144	VillageOffice Genossenschaft in Liquidation	Genossenschaft
6158	PoliLab	Verein
6185	Suchtprävention Zürcher Unterland	Verein
6206	Schule für Gestaltung Bern und Biel	Staatlich
6224	Grünliberale Partei Sektion Ingenbohl-Brunnen	Verein
6240	Flach Consulting GmbH	GmbH
6265	Schweizerische Volkspartei Gelterkinden und Umgebung	Verein
6295	glp lab	Verein
6337	Dipartimento della sanità et della socialità Ticino	Staatlich
6369	eGovernment St.Gallen digital.	Oeffentlich-rechtlich
6397	Interessensgemeinschaft Angehörigenbetreuung	Verein
6442	Verein Zuger Wanderwege	Verein
6413	Elternbildung CH	Stiftung
6458	AEK Pellet AG	AG
6499	Sectio Brigensis	Verein
6516	Verein Kind, Spiel und Begegnung im Länggassquartier	Verein
6519	Internationale Liga gegen Rassismus und Antisemitismus (Sektion Wallis)	Verein
6502	Katholischer Männerverein Naters	Verein
6503	New City Rollers Naters	Verein
6630	Bruderschaft Sanctae Margarithae	Verein
6639	Freizügigkeitsstiftung der WIR Bank	Stiftung
6664	Bibliobus Chablais Waadt-Wallis	Verein
6644	Fondation Académie d'orgue de Fribourg	Stiftung
6698	Sandbox Community	Informelle Gruppe
6729	Schweizerische Arbeitsgemeinschaft Spielbus	Verein
6757	Stiftung Opferhilfe	Stiftung
6762	Wirtschaft Region St.Gallen WISG	Verein
6791	Energiestadt Aarau konkret	Verein
6805	Quartierverein Gundeldingen-Bruderholz	Verein
6824	Nova Energie Basel AG	AG
6836	Grüne Partei Glarus Süd	Verein
6874	Strupler Gartenbau AG	AG
6893	Rotary Club Genève Palais Wilson	Verein
6905	Schweizerische Volkspartei Sektion Kirchlindach	Verein
6931	Klibühni, Das Theater	Verein
6961	Eidgenössische Filmkommission	Ausserparlamentarische Kommission
6982	Verein der Freunde der Aargauischen Kunstsammlung	Verein
6488	Zoo Gnadenhof Eichberg	Verein
7023	Lungenliga Zentralschweiz	Verein
7048	Bien Naître	Verein
7062	Verein Zukunft Drei-Seen-Land	Verein
7085	diabètevaud	Verein
7104	Association régionale de la Gruyère	Verein
7120	FC Küsnacht	Verein
7143	EAE (Energieagentur Elektrogeräte)	Verein
7155	vogelfrei consulting nadine vögeli	Einzelunternehmen
7186	CVP Wahlkreis Sursee	Verein
7204	Alternatiba Léman	Verein
6391	SmartGridready	Verein
7237	Initiativkomitee Züri Autofrei	Informelle Gruppe
7232	Primarschule Grafenried	Staatlich
7073	Fondation Félix Vallotton	Stiftung
7287	Skiclub Oberwil	Verein
7315	The Innovation in Politics Institute	GmbH
7352	Chatterie du Point du Jour, Zwygart Myriam et Alain	KG
7356	Stadt Morges	Staatlich
7391	Association Cantonale Vaudoise De Football	Verein
7442	Marcuard Family Office AG	AG
7472	Sympany Versicherungen AG	AG
7485	Fondation de la Caisse d'allocations familiales de la Fédération vaudoise des entrepreneurs (CAFEV)	Stiftung
7467	André Vernay	Einzelunternehmen
7533	WAS Immobilien AG	AG
7545	CATMETI GmbH	GmbH
7612	Bärn fägt - Stiftung für Berner Spiel-, Sport- und Erlebnistage	Stiftung
7621	Sozialdemokratische Partei Kanton St. Gallen	Verein
7632	Wärmeverbund Lehenmatt Birs AG	AG
7638	Stadtwohnung Bern GWB AG	AG
7711	Schweizerische Volkspartei Ortspartei Oberriet	Verein
7720	Interkauf AG	AG
7682	Appenzellischer Anwaltsverband	Verein
7776	la Festivalle	Verein
7792	Zanini Gozzi Sagl	GmbH
7817	Nie wieder Atomkraftwerke Region Basel	Verein
7827	Commune d'Aigle	Staatlich
7856	Personalfürsorgestiftung der Brauerei Rosengarten AG	Stiftung
7736	Verein Solidaritätsnetz Zürich	Verein
7573	AsyLex	Verein
7764	Caisse de retraite et d'invalidité du personnel de la Banque Cantonale Neuchâteloise	Stiftung
7739	Fondation Gobat pour la Paix	Stiftung
7933	Supporter-Club der FDP des Kantons St. Gallen	Verein
7958	Hans Barmettler & Co AG	AG
7972	Crax AG	AG
7582	metal.suisse	Verein
8044	Voegtlin - Meyer AG	AG
8035	Tamoil S.A.	AG
8074	Chocolat Stella Bernrain Trading GmbH	GmbH
8079	Total Capsule Solutions SA	AG
8122	Müller-Möhl Foundation	Stiftung
7917	Gewerkschaftsbund des Kantons Zug	Verein
8152	Nachhaltigkeitsziele 2030	Parlamentarische Gruppe
7845	Verein Sitem Start-up Club (SSC)	Verein
8051	Fondation suisse de la Chaîne du Bonheur	Stiftung
8168	Kantonsschule Seetal	Staatlich
8196	Verband Schweizer Tourismusmanager	Verein
8225	Pensionsfonds Gruppe GastroSuisse	Stiftung
8243	Stiftung Patrouille des Glaciers	Stiftung
8261	Emma Schaub-Stiftung	Stiftung
8277	Landesausstellung	Parlamentarische Gruppe
8293	Les Tailleurs Communication SA	AG
5753	Walliser Vereinigung von Institutionen zugunsten von Menschen mit Schwierigkeiten	Verein
5865	Fondation SGIPA	Stiftung
5794	Internet Society Switzerland Chapter	Verein
6048	Aktion gegen Fluglärm	Verein
6058	Smarter Thurgau	Verein
6107	Gönnervereinigung YB-Frauen	Verein
6083	SATUS Schweiz	Verein
6131	WORKcontrol Suisse AG	AG
6156	GESKA AG	AG
6175	Crausaz & Partenaires Stratégie et Communication SA	AG
6161	speakers.ch ag	AG
6202	FORUM SUISSE DE POLITIQUE INTERNATIONALE	Verein
6241	Schweizerischer Fachverband Mütter- und Väterberatung	Verein
6253	Association des Habitant-e-s de la Jonction	Verein
6278	Coopérative d'habitation Mpf-Loge	Genossenschaft
6301	Schweizerische Volkspartei Wahlkreis Mittelland Süd	Verein
6340	Genossenschaft Wärmeverbund Herbetswil	Genossenschaft
6332	Aprioris AG	AG
6420	Harvard Club of Switzerland	Verein
6425	Schweizerische Gesellschaft für Gesetzgebung	Staatlich
6453	Christian Public Affairs	Verein
6431	Suisag, Aktiengesellschaft für Dienstleistungen in der Schweineproduktion	AG
6465	SAINT-GOBAIN ISOVER S.A.	AG
6544	Association Noe21	Verein
6574	Holdigaz Immobilier SA	AG
6479	Stiftung für Schweizerische Kunstgeschichte	Stiftung
6562	easyvote	Informelle Gruppe
6632	Fédération Neuchâteloise des associations professionnelles du Second Œuvre	Verein
6660	Interessengemeinschaft Sichere Renten	Informelle Gruppe
6686	Junge Grüne Zürich	Verein
6722	Soziale Innovation Bern Accelerator	Verein
6705	Stiftung Kinder- und Jugendtheater Olten	Stiftung
6654	gymKIRCHENFELD Alumni	Verein
6771	Kreiskomitee Die Mitte Michelsamt	Verein
6787	Société Coopérative d'Habitation Lausanne	Genossenschaft
6814	Region Maloja	Staatlich
6829	Berilex AG	AG
6837	Auer Meier Zopfi AG	AG
6860	Télé Mont-Noble SA	AG
6890	Rotary Club Weinfelden	Verein
6897	FONDATION SCHWAB POUR L'ENTREPRENARIAT SOCIAL	Stiftung
6917	Samaritani Sezione Comano	Verein
6951	Grünliberale Bezirk Dielsdorf	Verein
6570	Commune de Montreux	Staatlich
6493	Campax	Verein
7026	Spinelli SA	AG
7053	Casamondo AG	AG
7060	Landwehr - Blasorchester Kanton und Stadt Freiburg	Staatlich
6999	Sterbekasse des Schweizerischen Verbandes des Personals öffentlicher Dienste (V.P.O.D.)	Stiftung
7107	Comité du Fonds d'équipement touristique du canton de Fribourg	Staatlich
7125	Stiftung Frauenhaus Zürich	Stiftung
7157	Gemeinde Hägendorf	Staatlich
7181	Förderverein Schule und Wohnen Mariazell Sursee	Verein
7196	clavis IT ag	AG
7211	Quarta Lingua Vereinigung zur Förderung der rätoromanischen Sprache und Kultur	Verein
7229	SOS MEDITERRANEE Suisse	Verein
7255	LE REPUIS	Stiftung
7270	Ferien- und Sportzentrum Hoch-Ybrig AG	AG
6928	Frauenzentrale Graubünden	Verein
7305	Fonds Respect	Verein
7328	Evangelisch-reformierte Kirche Schweiz (EKS)	Verein
7348	FONDATION POUR LA PROTECTION DES ANIMAUX	Stiftung
7386	IV-Allianz	Informelle Gruppe
7416	Arbeitsgemeinschaft pro Wahrnehmung	Verein
7420	SCORES - Swiss Committee on Reparations for Slavery	Informelle Gruppe
7392	Verein für eine sichere Schweiz	Verein
7446	Kiwanis Club Jura	Verein
7527	Grünliberale Partei Stadt Luzern	Verein
7551	Alliance SwissPass	Verein
7502	Commune de Boudry	Staatlich
7547	European Renewable Gas Registry	Verein
7490	Suissetec Neuchâtel	Verein
7519	Wohnbaupartner AG	AG
7636	Wasserfallen Management GmbH	GmbH
7707	Duttweiler Treuhand AG	AG
7676	Liberty Brass Band Ostschweiz	Verein
7526	Schnyder Ingenieure ZG AG	AG
7779	BSF Swissphoto AG	AG
7690	Gemeinde Stettlen	Staatlich
7820	GEPABU Personalvorsorgestiftung	Stiftung
7829	RhB Immobilien AG	AG
7863	Stiftung Alterssparkonten Isoliergewerbe	Stiftung
7874	Grünliberale Partei Aargau	Verein
7893	Red Spark AG	AG
7657	Medgate Mini Clinic AG	AG
7925	Klima	Parlamentarische Gruppe
7956	Grünliberale Partei Bezirk Aarau	Verein
7960	Kühni Consulting GmbH	GmbH
7584	a:primo Verein zur frühen Förderung sozial benachteiligter Kinder	Verein
8014	Fritz Meyer Holding AG	AG
8032	Shell Lubricants Switzerland AG	AG
8094	Migros Industrie AG	AG
7771	Schweizer Gesangsfestival 2022	Verein
7608	Stiftung Kalaidos Fachhochschule	Stiftung
8134	VPOD Sektion NGO	Verein
8142	Stiftung KMU Rechtsdurchsetzung SKR	Stiftung
7989	Concours Hippique International de Genève	Verein
8056	A. Kuster Sirocco AG	AG
8170	contactify AG	AG
8191	Gewerbeverein Reusstal	Verein
8216	LUKS Spitalbetriebe AG	AG
8209	Geschichte	Parlamentarische Gruppe
8250	nature products Switzerland GmbH	GmbH
8280	Bravenex AG	AG
8305	Kingfluencers AG	AG
8345	FONDATION DE LA MAISON DE L'ABSINTHE	Stiftung
8330	Pensionskasse Unia	Stiftung
8350	solutions tarifaires suisses sa	AG
8394	Politforum Thun	Verein
8377	Fondation Clos Fleuri	Stiftung
8449	Autosilo Dorfplatz AG	AG
6092	Ticino for finance	Verein
6116	Swiss-China World Silk Road Association	Verein
6137	Gericke Holding AG	AG
6162	Reatch - Research and Technology in Switzerland	Verein
6179	VARO Energy Tankstorage AG	AG
6204	Kellerhals Carrard Bern KlG	KG
6218	Stiftung Schloss Burgdorf	Stiftung
6249	Gewerbeverband Aarau	Verein
6262	Fondation NOF - Nouvel Opéra Fribourg - Neue Oper Freiburg	Stiftung
6281	FLEISCHFACHVERBAND St. Gallen - Liechtenstein	Verein
6308	HKV Handelsschule KV Schaffhausen	Verein
6328	Paritätischer Verein Informationssystem Allianz Bau	Verein
6399	Kanton Basel-Landschaft	Staatlich
6406	Pro Holz Aargau	Verein
6353	Winterhilfe Baselland	Verein
6485	Frauen- und Müttergemeinschaft Jona	Verein
6463	Pfenninger Bau AG	AG
6515	Demokratie ohne Grenzen Schweiz	Verein
6547	Damenturnverein Thürnen	Verein
6475	Curling Verband des Kantons Waadt	Verein
6593	Soziademokratische Partei Bezirk Dielsdorf	Verein
6597	Fondation pour le concours "Environnement + Jeunesse"	Stiftung
6602	Stillförderung Schweiz	Stiftung
6655	Der Gewerbeverein	Verein
6622	MindMaze SA	AG
6691	Strafvollzugskonkordat Nordwest- und Innerschweiz	Staatlich
6699	Global Shapers Community Zurich Hub	Informelle Gruppe
6717	Winterhilfe Ticino	Verein
6742	Stadt Opfikon	Staatlich
6760	St.Galler Anwaltsverband	Verein
6783	Stiftung Hof Rickenbach	Stiftung
6795	Verein Blaues Kreuz Aargau-Luzern	Verein
6819	Grüne Partei Eschlikon	Verein
6843	Jassclub Tödi	Verein
6866	Peregrina-Stiftung	Stiftung
6891	Union Suisse des oenologues	Verein
6910	Stiftung südhang Klinik für Suchttherapien	Stiftung
6942	Etude Sidney Kamerzin	Einfache Gesellschaft
6959	Fondation Universitaire pour le logement des étudiants	Stiftung
6969	Interessengemeinschaft Ostumfahrung Suhr	Verein
7015	Verein Erlebnisraum Tafeljura	Verein
7028	Fondazione Malcantone	Stiftung
7049	Fondation en faveur de la construction de logements pour personnes âgées à Cortaillod	Stiftung
7064	Airbus	AG
7000	Schlichtungsbehörde nach Gleichstellungsgesetz	Staatlich
7111	Genossenschaft Buchhandlung Comedia	Genossenschaft
7123	Vogeldorf Alchenstorf	Verein
7159	Patientenstelle Aargau Solothurn	Verein
7185	Die Junge Mitte Wahlkreis Sursee	Verein
7133	Gehirn und Trauma-Stiftung	Stiftung
7218	Aarau Mobil	Verein
7240	Schweizerische Gesellschaft für Agrarwirtschaft und Agrarsoziologie SGA	Verein
7231	Schweizerische Volkspartei Region Fraubrunnen	Verein
7271	Umbricht Rechtsanwälte AG	AG
7281	Ius Alumni	Verein
7304	Kehrseite Winterthur	Verein
7322	Freunde Vindonissapark	Verein
7368	Verein Landesausstellung Svizra27	Verein
7358	Sozialdemokratische Partei Kanton Tessin	Verein
7379	Interessengemeinschaft Berufsbildung Wirtschaftsinformatik	Verein
7443	Vereinigung Schweizerischer Stadtgärtnereien und Gartenbauämter (VSSG)	Verein
7434	Ecole de Musique et Fanfare Municipale de Collonge-Bellerive	Oeffentlich-rechtlich
7409	Mr. Campaigning AG	AG
7448	Gönnerverein FC Blue Stars Zürich	Verein
7554	FRESCH-MEDIEN AG	AG
7561	NOBLE INTERNATIONAL INVESTMENT HOLDINGS LIMITED	GmbH
7615	Tourismus Support Glarnerland AG	AG
7451	Peace Watch Switzerland	Verein
7635	Hornschlittenclub der Stadt Luzern	Verein
7705	Politikwissenschaftliche Beratung Schweiz GmbH	GmbH
7709	TH Finanz AG	AG
7750	Accounto AG	AG
7685	Tennis-Club Heiden	Verein
7596	Bürgergemeinden und Korporationen	Parlamentarische Gruppe
7794	Residenza Emmy Società Cooperativa	Genossenschaft
7798	Touristische Unternehmung Grächen AG	AG
7831	Inter-Parliamentary Alliance on China	Parlamentarische Gruppe
7854	alpinfra, Hilfe für Berggemeinden	Verein
7838	Fondation du Musée de la Tourbière	Stiftung
7653	Lindenhofgruppe AG	AG
7898	LiveCom Alliance	Stiftung
7742	Burkina Faso	Staatlich
7954	Medicus Mundi International	Verein
7910	bilding - Schweizerische Stiftung zur Förderung des Ingenieurnachwuchses im Bauwesen	Stiftung
7985	Operation Libero Bern (Sektion)	Verein
8043	Suter, Joerin AG	AG
7768	Calanda Holding AG	AG
8085	FDP Die Liberalen Reinach BL	Verein
8102	Parti Socialiste du Valais Romand	Verein
8112	Heidi Chocolat Group AG	AG
7916	Drogen Forum Zug DFZ	Verein
8149	Lonza Group AG	AG
7846	Vinotrade AG	AG
7997	Velomedien AG	AG
8110	GAUTSCHI SPEZIALITÄTEN AG	AG
8197	Schweizer Alpen-Club, Sektion Bern	Verein
8222	bikoka by Jérôme Hayoz	Einzelunternehmen
8241	Fondation equal-salary	Stiftung
8259	Kultur-Stiftung Basel H. Geiger	Stiftung
8272	Forum Climatique de la Côte	Verein
8318	Donatorenvereinigung des FC Breitenrain	Verein
8325	Hangar Technics AG	AG
8340	Compagnie des chemins de fer du Jura (C.J.) SA	AG
8382	Immo Amstutz SA	AG
8386	ProCinema, Schweizerischer Verband für Kino und Filmverleih	Verein
8422	Fondation du Centre culturel des Terreaux	Stiftung
8457	Schweizerische Vereinigung für Flugwissenschaften	Verein
7182	Planungs- und Baukommission Oberkirch	Staatlich
7201	Club 2000	Verein
7213	Kinder- und Jugendtheater Zug	Verein
7249	Junge Grüne Schweiz	Verein
7269	Gemeinde Unteriberg	Staatlich
7067	Fondation La vue pour la vie - eyesight4life	Stiftung
7288	Aiducation International	Verein
7319	MDE Beteiligungen AG	AG
7345	Green Boots	Verein
7349	FONDATION JOSEE PESCI	Stiftung
7335	Anlaufstelle für Sans-Papiers Basel	Verein
7428	IG Silbern	Verein
7460	ipwalumni	Verein
7484	ISMF- International Ski Mountaineering Federation	Verein
7530	SAV-FSA Service AG	AG
7535	TMF Extraktionswerk AG	AG
7399	Verein zur Unterstützung der fairen Milch	Verein
7548	Institut neue Schweiz	Verein
7622	Kilchenmann AG	AG
7452	Die Mitte Malters	Verein
7666	Vereinigung Nordwestschweizerischer Spitäler	Verein
7710	Delegation bei der parlamentarischen Versammlung der OSZE	Staatlich
7747	Alliance Enfance	Verein
7588	Centravo Holding AG	AG
7782	Verein Energie-Wende	Verein
7811	Jungfreisinnige Kanton Zug	Verein
7821	Ski Valais	Verein
7824	FDP.Die Liberalen St. Gallen	Verein
7860	Public Beta	Verein
7873	Innotas AG	AG
7738	SAO Association - Frauen für Frauen auf der Flucht	Verein
7576	World Medical Association	Verein
7907	Unisanté Sàrl	GmbH
7938	Ecole Secondaire du Val Terbi	Staatlich
7971	wasen.ch (Dorfchronik)	Informelle Gruppe
8002	Benoil SA	AG
8028	Shell Holdings Switzerland AG	AG
8023	Osterwalder Zürich AG	AG
8084	Burger Söhne SA	AG
8090	Berner Konferenz für Sozialhilfe, Kindes- und Erwachsenenschutz BKSE	Verein
8114	Holle baby food AG	AG
8135	Forum per l'italiano in Svizzera	Verein
8147	Schweizer Jugendmusikverband	Verein
7772	Bildungszentrum Gesundheit Basel-Stadt	Staatlich
8049	Schwingklub Oberwallis	Verein
8175	UpGrain AG	AG
8190	Verein Kloster Maria Rosengarten Wonnenstein	Verein
8212	Verein Haar und Kamm	Verein
8234	Lärmliga Schweiz	Verein
8251	Schweiz - Kirgisistan	Parlamentarische Freundschaftsgruppe
8283	Ski Club des Rochers-de-Naye	Informelle Gruppe
8304	SwissCognitive - World-Leading AI Network	Verein
8324	BHP - Brugger und Partner AG	AG
8339	Netto-Null.swiss AG	AG
8358	Bewegung Courage Civil	Verein
8385	Stadt Lenzburg	Staatlich
8364	Gemeinde Beromünster	Staatlich
8417	STIFTUNG SERGE RACHMANINOFF	Stiftung
8459	Stiftung Architektur Schweiz	Stiftung
8439	ZA Immo GmbH	GmbH
8516	Rosson Software AG	AG
8551	OIKOCREDIT DEUTSCHE SCHWEIZ, Förderkreis der Oekumenischen Entwicklungsgenossenschaft Oikocredit	Verein
8532	FDP. Die Liberalen Niederweningen	Verein
8592	Géothermie Préalpes SA	AG
8485	Groupe Lucien Barrière Suisse SA	AG
8621	Ngo-Koordination Post Beijing	Verein
8647	SECURIX AG	AG
8699	ETH AI Center	Staatlich
8725	BEBike	Verein
8756	Verein CH++	Verein
8763	PLATH AG	AG
8811	Drück-Top GmbH	GmbH
8852	Association Maison des Amériques	Verein
8843	Stiftung HIS	Stiftung
8899	moneycab gmbh	GmbH
8902	YPSC Sàrl	GmbH
8962	Einwohnergemeinde Worb	Staatlich
8946	Gruppo Materiale Difesa e Sicurezza della Svizzera Italiana (GMDSI)	Verein
8989	Jungfreisinnige Stadt Zürich	Verein
9012	KAM-Service GmbH	GmbH
8949	Impact Gstaad Association	Verein
9068	Bio Brüterei Lindenberg AG	AG
8997	Raiffeisenbank Oberseetal Genossenschaft	Genossenschaft
9114	Chambre Immobiliere du Valais	Verein
9008	Armit AG	AG
9235	communicaziun.ch ag	AG
8982	Burkart Advisory GmbH	GmbH
9301	Solilogis AG	AG
7227	Kanton Aargau	Staatlich
7242	Global Mountain Action	Verein
7261	Fondo Solidarietà Poschiavina (FSP)	Stiftung
7074	Kantonaler Ausschuss für die Zuteilung des Agrarförderungsfonds (Genf)	Staatlich
7280	International Fiscal Association	Verein
7323	Binder & Partner AG	AG
7354	FDP Die Liberalen Frauen St. Gallen	Verein
7333	sur le pont	Verein
7378	Gymnasium Lerbermatt	Staatlich
7426	Zürcher Public Relations Gesellschaft	Verein
7421	Business ZOME GmbH	GmbH
7407	Friends of Rural Women and Children	Verein
7512	Campaign Camp Switzerland	Verein
7550	Independent Commission for the Reform of International Corporate Taxation	Verein
7401	Gemeinde Vuadens	Staatlich
7515	Fachmagazin arzt|spital|pflege	Einfache Gesellschaft
7620	Handshake	Verein
7633	Feldmusik Udligenswil	Verein
7700	Schweizerische Volkspartei Kreispartei Rheintal	Verein
7522	Schweizerischer Verband ziviler Drohnen SVZD	Verein
7717	Genossenschaft amarenda	Genossenschaft
7756	Société des Amis du Musée d'Histoire Naturelle (SAMH)	Verein
7687	Spitex Appenzellerland	Verein
7793	Fondazione per le Facoltà di Lugano dell'Università della Svizzera italiana	Stiftung
7800	Verein Grächen und St. Niklaus Tourismus und Gewerbe	Verein
7650	Die medizinischen Laboratorien der Schweiz	Verein
7837	FC Saint-Paul	Verein
7872	Schweizerische Volkspartei Bezirk Affoltern am Albis	Verein
7654	Beznau Verfahren	Verein
7766	FDP Die Liberalen Lugano	Verein
7660	Medgate AG	AG
7943	Junge Grünliberale Schweiz	Verein
7963	AULA - Verein Ehemaliger der Alten Kantonsschule Aarau	Verein
7581	IG zur Durchsetzung von Patientenverfügungen	Informelle Gruppe
8019	Moveri AG	AG
8021	Osterwalder St. Gallen AG	AG
8038	VARO Energy Marketing AG	AG
8101	Allianz Digitale Sicherheit Schweiz ADSS	Verein
8113	HOCHDORF Holding AG	AG
8133	Staatssekretariat für Bildung, Forschung und Innovation	Staatlich
8141	TRANSTERRA Immobilien AG	AG
7994	Koordination Inlandbanken	Informelle Gruppe
8054	Schweizerische Exportrisikoversicherung	Oeffentlich-rechtlich
8176	GREEN Advisors AG	AG
8200	Evangelisch-reformierte Petrus-Kirchgemeinde Bern	Verein
8221	Fondation des Grangettes	Stiftung
8236	Winterhilfe Aargau	Verein
8257	Schweiz - Westsahara	Parlamentarische Freundschaftsgruppe
8271	Alterssiedlung Rankhof	Stiftung
8295	Genossenschaft Borna, Arbeits- und Wohngemeinschaft Rothrist	Genossenschaft
8310	Expedition Zukunft	Verein
8313	Verein Internationales Reportagen Festival Bern	Verein
8371	Die Junge Mitte Kanton Luzern	Verein
8375	MarschPreis.LU	Verein
8411	Green-Cross	Parlamentarische Gruppe
8467	Nature Inclusive Urban Design	Verein
8426	Keller-Frei Holding AG	AG
8513	ed:solution ag	AG
8548	Etzelwerk AG	AG
8572	Entreprise Forestière Daniel Ruch SA	AG
8581	SIU - Schweizerisches Institut für Unternehmerschulung AG	AG
8598	Elbit Systems Switzerland AG	AG
8486	Die Junge Mitte Kanton Bern	Verein
8632	Sozialdemokratische Partei Crans-Montana und Lens	Verein
8656	Budliger Treuhand AG	AG
8711	BOS Österreich Gmbh	GmbH
8742	SIG-Zukunftsstiftung	Stiftung
8762	Peter Beschnidt Consulting International	Einzelunternehmen
8812	Volksinitiative "Jederzeit Strom für alle (Blackout stoppen)"	Verein
8834	Association de la Crèche Les Libellules	Verein
8838	Soroptimist Fribourg	Verein
8869	Bernischer Anwaltsverband BAV/AAB	Verein
8956	Die Mitte Schaffhausen	Verein
8887	Sozialdemokratische Partei Zürich 10	Verein
8935	IG Jungreben	Verein
8967	SikaBau AG	AG
9013	Energieagentur St.Gallen GmbH	GmbH
9052	Korporation Gruonwald	Verein
9063	Federazione delle ONG della Svizzera italiana	Verein
9072	apiservice GmbH	GmbH
8999	Fondation 5R-Saint-Ursanne	Stiftung
9089	Swiss Center of Excellence on Net-Zero Emissions	Staatlich
9010	Petrus Real Estate AG	AG
9300	UTY3 Sàrl	GmbH
9020	Verein Pro Familia Ostschweiz	Verein
7274	Ernst und Adeline Schneider Stiftung	Stiftung
7278	Schweizerische Vereinigung für Schiedsgerichtbarkeit	Verein
7285	Skilift Rossberg AG	AG
7327	Schweizer Dialog	Informelle Gruppe
7331	Fondation Jonas	Stiftung
7375	Stiftung zur Unterstützung und Förderung von Jugendchören im Oberwallis	Stiftung
7403	AZM Verwaltungs AG	AG
7419	Theologische Bewegung für Solidarität und Befreiung	Verein
7461	Freidenker-Vereinigung Schweiz	Verein
7483	Jerusalem Gebet Schweiz	Verein
7514	CTA ADVISORY LLP, Londres, succursale de Genève	KG
7471	Schweizerische Arbeitsgemeinschaft für Gesundheitsökonomie und Gesundheitswissenschaften	Verein
7398	Fondation Les Urbaines	Stiftung
7488	CVP Wahlkreis Hochdorf	Verein
7517	SmartCity Alliance	Verein
7662	PharmaFocus AG	AG
7494	Volkshochschule Frauenfeld	Verein
7523	Kevin Grangier Rhétorique | Médias | Campagnes	Einfache Gesellschaft
7497	Stiftung Gewerkschaftsschule Schweiz	Stiftung
7725	LABOR, Expérimentation urbaine	Verein
7777	Stiftung CONTACTIONS	Stiftung
7813	Nordwestschweizerisches Schwingfest 2021	Einfache Gesellschaft
7822	Fondation Papiliorama	Stiftung
7850	Operette Sirnach	Verein
7859	Junge SVP Tessin	Verein
7869	Schweizerischer Katholischer Frauenbund SKF	Verein
7879	tunAargau	Verein
7894	Expo-Event. Live Communication Verband Schweiz	Verein
7577	REDOG Schweizerischer Verein für Such- und Rettungshunde	Verein
7842	sitem-insel AG	AG
7945	ewp AG Effretikon	AG
7930	Everlife.ch SA	AG
8026	SAPPRO SA	AG
7908	Gesellschaft für Ingenieurbaukunst	Verein
8071	Blattmann Schweiz AG	AG
8075	Delica AG	AG
8115	Hosberg AG	AG
8130	altumtre AG	AG
8151	GetDiversity GmbH	GmbH
7991	Les Libéraux-Radicaux arrondissement Ouest Lausannois	Verein
7999	Grüne Freie Liste Zollikofen	Verein
8186	Hilfswerk der Vereinten Nationen für Palästina-Flüchtlinge im Nahen Osten	Staatlich
8205	KOSMOS space	Verein
8219	FDP Donatoren-Vereinigung Kanton Luzern	Verein
8239	Cyber	Parlamentarische Gruppe
8256	Schweiz - Vereinte Nationen	Parlamentarische Freundschaftsgruppe
8286	Blueberry Schweiz AG	AG
8319	Gönnerverein Kinderspitex Joël Mühlemann	Verein
8351	Klettgauer Bote	Einzelunternehmen
8342	Liberethica	Verein
8401	Pure Holding AG	AG
8409	Tramondo Investment Partners AG	AG
8451	CV Labs AG	AG
8436	GASCO	Verein
8474	Urex Immobilien AG	AG
8477	Pro Futuris	Verein
8536	Piusicur	Verein
8530	Schule Bürglen UR	Staatlich
8523	Association des communes de Crans-Montana (ACCM)	Oeffentlich-rechtlich
8597	IG-Nord	Verein
8613	bonvita AG	AG
8620	FDP.Die Liberalen des Kantons Freiburg	Verein
8640	Fachverein Geschichte der Universität Zürich	Verein
8698	Metrosuisse	Verein
8671	Prewo Wohnbau AG, Zürich	AG
8718	TESORINO AG	AG
8748	Stiftung für die Gemeindegüter von Neu-Lengnau	Stiftung
8753	FDP.Die Liberalen Münsingen-Rubigen	Verein
8731	Ritterorden vom Heiligen Grab zu Jerusalem - Schweizerische Statthalterei	Verein
8854	Verein metroswiss	Verein
8877	Swiss Association for Compliance and Competition Law (ACCL)	Verein
8938	Chocolate City AGENTUR J. Walpen	Einzelunternehmen
8883	Schweiz - Free Iran	Parlamentarische Freundschaftsgruppe
8960	Die Mitte Bulle	Verein
8936	Die Mitte Zurzibiet	Verein
8804	INGRADO-Servizi per le dipendenze	Stiftung
9015	Gewerbe Steinach	Verein
9038	Offiziersgesellschaft des Kantons St. Gallen	Verein
9062	Kantonaler Lehrerinnen und Lehrerverband St. Gallen	Verein
9079	Solidaritätsnetz Sans-Papier Bern	Verein
8795	Schweizerische Evangelische Allianz	Verein
9118	Mouvement Pro Fribourg	Verein
9209	SVP Bezirk Laufenburg	Verein
9120	DE BOCCARD ASSOCIES SA	AG
9027	Association des pharmaciens indépendants (API)	Verein
7286	Gospelchor Oberwil	Verein
7314	BOXS AG	AG
7355	Jungfreisinnige Kanton St. Gallen	Verein
7308	I Verdi del Ticino	Verein
7343	Domaine des Glycines - Putallaz	Einzelunternehmen
7380	Nordwestschweizer Schwingfest	Verein
7383	Vaterschaftsurlaub jetzt!	Verein
7481	Fondation Bykov	Stiftung
7529	Wohnbaugenossenschaft Warmbächli	Genossenschaft
7534	Cantosana AG	AG
7450	Berti Wicke-Stiftung	Stiftung
7564	enersis suisse AG	AG
7614	Schweizerischer Judo & Ju-Jitsu Verband (SJV)	Verein
7626	Banca Raiffeisen del Malcantone società cooperativa	Genossenschaft
7665	Unilabs Pathologie SA	AG
7495	Projethics Sàrl en liquidation	GmbH
7496	SwissSkills Marketing & Events	Verein
7748	Editions de l'ASLOCA Romande	Verein
7719	SwissHealth Ventures AG	AG
7727	AVIVO	Verein
7812	Wirtschaftsregion ZUGWEST	Verein
7796	EHC Visp Sport AG	AG
7412	procampaigning - Gesellschaft für Campaigning in Liquidation	Verein
7836	Trägerverein Jubiläums-Schwinget 125 Jahre ESV "Appenzell 2024"	Verein
7839	Verein Zürcher Forum	Verein
7876	Vereinigung Die Schweiz in Europa	Verein
7655	Medgate Technologies AG	AG
7903	Alfen SA	AG
7658	Medgate Integrated Care Holding AG	AG
7955	Corozal Sustainable Future Initiative	Verein
7962	Vereinigung Wirtschaftsingenieure Schweiz	Verein
8005	Conrad-Storz AG	AG
7585	ADEV Solarstrom AG	AG
8060	Bell Food Group AG	AG
8096	Baer AG	AG
8111	Heidi Chocolaterie Suisse SA	AG
7915	Alternative - die Grünen Baar	Verein
8126	Pittet Associés SA	AG
8153	ISOLUTIONS AG	AG
7847	Fondation PlanetSolar	Stiftung
8148	Schweizerischer Brass Band Verband	Verein
8181	VitalAire Suisse SA	AG
8206	Ente Regionale per lo Sviluppo del Luganese	Verein
8223	GastroTicino	Verein
8240	Fair ist anders	Parlamentarische Gruppe
8255	Schweiz - Tibet	Parlamentarische Freundschaftsgruppe
8273	Haute École Du Paysage, D'ingénierie Et D'architecture De Genève	Staatlich
8321	Halbzeit - gemeinsam gegen Rassismus	Verein
8327	SIG Security GmbH	GmbH
8356	STIFTUNG WIRTSCHAFT UND ÖKOLOGIE SWO	Stiftung
8391	Pro Familia Ostschweiz	Verein
8387	Swiss Cyber Security Days	GmbH
8431	Fondation Pro Senectute Genève - Carouge	Stiftung
8454	Michael Köpfli Beratung & Projektarbeit	Einzelunternehmen
8438	Verein FDP-Kampagnen	Verein
8492	faire Sagl	GmbH
8528	Zentrum für Demokratie Aarau	Einfache Gesellschaft
8571	Afiro	Verein
8524	Kammerchor Konservatorium Winterthur	Verein
8600	Grünliberale Partei Seeland	Verein
8497	grainmade AG	AG
8637	Jugendparlament Kanton Zürich	Verein
8625	Vereinigung gegen Fluglärm	Verein
8714	Gössi Consulting AG	AG
8720	Schweiz - Schweden	Parlamentarische Freundschaftsgruppe
8696	Raiffeisenbank Basel Genossenschaft	Genossenschaft
8801	Soliday Stiftung Schweiz	Stiftung
8755	PLR.Les Libéraux-Radicaux Moudon	Verein
8850	Verein zur Förderung des FAA-HSG	Verein
8860	Association des Amis du Musée Militaire vaudois	Verein
8920	Republica AG	AG
8788	Kommission für Forschung im Strassenwesen FOKO	Ausserparlamentarische Kommission
8944	Verein für eine inklusive Schweiz	Verein
8987	SolSarine AG	AG
8893	Swiss Jazz Days	Verein
8688	Pfister Schnieper Consulting AG	AG
9050	Stiftung für Kurortseinrichtungen Naters-Blatten-Belalp	Stiftung
9064	SUBOENO SA	AG
8993	Förderung der Schweizer Dienstleistungsbranche Holz im Kanton Waadt	Oeffentlich-rechtlich
9103	Stiftung Inspire	Stiftung
9117	Association Banque Alimentaire Fribourgeoise	Verein
9213	Club "Bürgerliche 100″	Verein
9100	Stiftung Kind und Familie KiFa Schweiz	Stiftung
9025	Gemeinde Tübach	Staatlich
7296	Care & Cure AG in Liquidation	AG
7316	Loanboox GmbH	GmbH
7353	Gemeindeverband Sozialdienst Region Trachselwald	Oeffentlich-rechtlich
7370	Slow Food Bern	Verein
7342	Swiss Association for Zero Emission Boat	Verein
7418	Genossenschaft Beata	Genossenschaft
7433	Forum Oberdorf	Verein
7437	Kanuklub Biel Magglingen	Verein
7464	Stiftung Lebensabend im eigenen Heim	Stiftung
7470	SVP Romanshorn	Verein
7556	Swiss Travel Security	Stiftung
7587	acrevis Bank AG	AG
7505	Grüne Partei Ost-Lausanne	Verein
7509	JUSO Basel-Stadt	Verein
7696	Stiftung Lucerne Festival Friends	Stiftung
7706	Coronadialog	Informelle Gruppe
7714	Association pour le Développement du Nord Vaudois	Verein
7680	Appenzeller Blasmusikverband	Verein
7757	Fehrenpark AG	AG
7784	Planzer Support AG	AG
7603	Trägerverein "Ja zu mehr Natur, Landschaft und Baukultur"	Verein
7649	EGK-Gesundheitskasse	Stiftung
7851	Pro Manu	Verein
7857	Pfadi Luzern - Kantonalverband der Luzerner Pfadfinderinnen und Pfadfinder	Verein
7760	EasyVrac	GmbH
7878	Sanacare AG	AG
7899	Medicus Mundi Schweiz	Verein
7741	Micarna SA	AG
7967	BitHawk AG	AG
7969	Viasuisse AG	AG
7931	Maria und Walter Strebi-Erni Stiftung	Stiftung
8042	Schätzle GebTech AG	AG
8033	Shell Trading Switzerland AG	AG
8092	Elsa Group SA	AG
8088	Schweizerische Volkspartei Kreisverband Interlaken-Oberhasli	Verein
8106	Eidgenössisches Hochschulinstitut für Berufsbildung	Staatlich
8125	Schweizerischer Verband der Umweltfachleute	Verein
8154	Die Dargebotene Hand der Nordwestschweiz	Verein
8166	BRR Investment AG	AG
7995	IG Zukunft Pflanzenschutz	Informelle Gruppe
8173	IMD Business School	Einzelunternehmen
8198	Schneesportinitiative Schweiz	Verein
8215	JMD AG	AG
8237	Nachhaltigkeitsnetzwerk Zentralschweiz	Verein
8254	Schweiz - Serbien	Parlamentarische Freundschaftsgruppe
8275	YOUNG Festival	Verein
8334	Forschungsstiftung Strom und Mobilkommunikation	Stiftung
8311	VCS Verkehrs-Club der Schweiz beider Basel	Verein
8343	FC Helvetia	Verein
8299	FEGEMS FEDERATION GENEVOISE DES ETABLISSEMENTS MEDICO-SOCIAUX	Verein
8410	MüPa.Beratung. GmbH	GmbH
8433	SBC Treuhand AG	AG
8446	Deloitte AG	AG
8488	CISA - Christliche Institutionen der Sozialen Arbeit	Verein
8430	Grüne Partei der Stadt Freiburg	Verein
8540	Schweizerische Gesellschaft für Geschichte	Verein
8531	Märlihüüs - Céline Stadler	Verein
8591	Mobiliar Umzüge & Transporte GmbH	GmbH
8604	Egyptian Education Foundation	Stiftung
8499	Apple Switzerland AG	AG
8630	Freisinnige Gros-de-Vaud	Verein
8654	FDP. Die Liberalen Urdorf	Verein
8702	Swiss Economics SE AG	AG
8693	Gefässpraxis Büchel	Einzelunternehmen
8770	Internationales Festival Geistlicher Musik	Verein
8766	RWM Schweiz AG	AG
8729	Fondation HORTUS	Stiftung
8851	International Trade Union Confederation	Verein
8841	HIS Beteiligungen AG	AG
8879	Opticon Consulenza Internazionale Aschwanden Jürg	Einzelunternehmen
8923	Wohngenossenschaft Zollikofen (WoGeZo)	Genossenschaft
8907	Politagentur.ch GmbH	GmbH
8889	Eidgenössischer Schwingerverband	Verein
8687	Caisse de prévoyance du personnel de l'Etat	Oeffentlich-rechtlich
8690	Albert Egger AG	AG
9035	Triaplus AG	AG
8954	Die Mitte Basel-Stadt	Verein
8793	Interaction	Verein
9111	Cinéconomie - Allianz der Schweizer Filmwirtschaft	Verein
9098	Bern Tourismus AG	AG
9216	Verein Individualbesteuerung Schweiz	Verein
9231	Meutel 2000 SA	AG
9021	Verein ehemaliger Kantonssekundarschüler St.Gallen	Verein
9014	Stiftung Mühlhof	Stiftung
7290	Sakkas Avocats	Einfache Gesellschaft
7337	Verein Klimaschutz Schweiz	Verein
7339	Dedale Solutions, Putallaz	Einzelunternehmen
7341	Proloc - la maison en plus simple (inaktiv)	Einfache Gesellschaft
7415	Neue Wege	Verein
7430	Venture Kick	Verein
7435	Diplomatische Dokumente der Schweiz	Einzelunternehmen
7447	Handelskammer Kosovo - Schweiz	Verein
7553	Schweizerische Gesellschaft für Palliative Medizin, Pflege und Begleitung	Verein
7543	GROSSRIED SA	AG
7486	media-work gmbh	GmbH
7518	Kern & Sammet AG	AG
7663	Unilabs, Laboratoire d'analyses médicales SA	AG
7698	Stiftung Solidarität mit der Welt Regionalkomitee Oberwallis	Verein
7672	Cave des Murgères Sàrl	GmbH
7722	SWS Medien AG Verlag	AG
7683	Appenzellische Offiziersgesellschaft	Verein
7778	LiteraturBasel	Verein
7600	Startups und Unternehmertum	Parlamentarische Gruppe
7730	Garanto- Die Gewerkschaft des Zoll- und Grenzwachtpersonals	Verein
7828	HIG Immobilien Anlage Stiftung	Stiftung
7567	Swiss Radioplayer GmbH	GmbH
7868	Phyfferzunft Altishofen	Verein
7881	Schweizerische Volkspartei Bezirk Uster	Verein
7895	Beaulieu SA	AG
7904	Korporationsbürgergemeinde Flüelen	Staatlich
7913	Kantonsrat Zug	Staatlich
7950	BDP Seeland	Verein
7928	Swiss Association for Autonomous Mobility	Verein
7982	Verein Bundeslager 2021	Verein
8006	Coop Mineraloel AG	AG
8034	Shell Treasury Company Switzerland AG	AG
8037	VARO Energy Direct Sales AG	AG
8089	Fondation Haute école de travail social et de la santé Lausanne - HETSL	Stiftung
8108	Frutarom Schweiz AG	AG
8124	Association pharmaGenève	Verein
8145	LGBTI	Parlamentarische Gruppe
8163	LANDI Mittelthurgau, Genossenschaft	Genossenschaft
8050	Pro Familia Basel Regio	Verein
8171	SWISS CENTER FOR DESIGN AND HEALTH (SCDH) AG	AG
8202	Schweizerische Volkspartei Tegerfelden	Verein
8217	Spital Nidwalden AG	AG
8238	Brot und Confiserie	Parlamentarische Gruppe
8262	Historisches Museum Basel	Staatlich
8284	Carna Libertas - Verein für verantwortungsvollen Fleischgenuss	Verein
8332	AgriGas GmbH	GmbH
8328	Gastro ZH Event GmbH	GmbH
8357	Lurag Luzerner Raststätten AG	AG
8374	Business Up SA	AG
8397	Piazza-Zemp GmbH	GmbH
8440	Further at Work GmbH	GmbH
8466	Sozialdemokratische Partei Bern-Holligen	Verein
8421	NuovoColor AG	AG
8429	Grüne Partei Kanton Freiburg	Verein
8514	Feuerwehrkoordination Schweiz FKS, Beherbergungsleistungen	Staatlich
8567	Förderung der wirtschaftlichen Nutzung von Cannabis	Parlamentarische Gruppe
8577	Kiwanis Club Oron-Jorat	Verein
8582	Axpo Services AG	AG
8610	Wattz AG	AG
8616	Digitec Galaxus AG	AG
8639	Tennisclub Waldmann	Verein
8680	Commune de Mies	Staatlich
8716	PRO SCHWEIZ	Verein
8743	rivedia.com GmbH	GmbH
8750	SIGA Swiss Institute for Global Affairs	Verein
8826	Fürsorgestiftung economiesuisse	Stiftung
8833	Zupfmusik-Verband Schweiz	Verein
8855	frauenOase	Verein
8898	die plattform	Verein
8955	Die Mitte Glarus	Verein
8906	Initiativkomitee "Jede einheimische und erneuerbare kWh zählt!"	Verein
8911	Kooperation Ostermundigen Bern	Stiftung
8890	Pro Gottardo ferrovia d'Europa	Verein
9011	Pollux Reinigungsservice AG	AG
9049	Evangelische Allianz Deutschschweiz	Verein
9042	PH Möbel Bau GmbH	GmbH
8794	Laurag AG	AG
9115	Gmür Event Payment	Einzelunternehmen
9091	Zünd Consulting Sàrl	GmbH
9099	Regionalprodukte Das Beste der Region	Verein
8983	Kaufmann Gotthard AG	AG
9119	Reckitt Benckiser (Switzerland) AG	AG
7347	Gemeinde Grandevent	Staatlich
7334	March against Bayer & Syngenta	Verein
7413	Bank Julius Bär & Co. AG	AG
7455	AV Notkeriana	Verein
7405	Schweizerische Volkspartei Bezirk Lenzburg	Verein
7510	Cerisier	Verein
7468	Pierre Avoi Invest SA	AG
7537	Casino Gesellschaft Burgdorf	Verein
7562	Verein "Ja zum Schutz der Kinder und Jugendlichen vor Tabakwerbung"	Verein
7503	Stadt Prilly	Staatlich
7624	Benediktinerkloster Mariastein	Verein
7692	Baugenossenschaft Fridolin	Genossenschaft
7694	Academia Raetica	Verein
7708	Duttweiler Holding AG	AG
7718	B Lab (Suisse), en liquidation	Verein
7752	Die Mitte Zug	Verein
7592	Planair SA	AG
7787	Wasserngrat 2000 AG	AG
7816	Alevitische Gemeinde Regio Basel	Verein
7411	business campaigning by Peter Metzinger	Einzelunternehmen
7853	Schweizerischer Fonds für Hilfe bei nicht versicherbaren Elementarschäden	Stiftung
7862	Isolsuisse, Verband Schweizerischer Isolierfirmen für Wärme-, Kälte-, Schall- und Brandschutz	Verein
7571	MFO Asset Management	AG
7883	Bauer Zürcher Haeny Rechtsanwälte	Einfache Gesellschaft
7906	Meliorationsgenossenschaft Reussebene Uri	Staatlich
7935	Assoc. Syndicale & Pédagogique, Des Enseignantes & Enseignants, De la Suisse Romande (SER)	Verein
7949	Benevol Agentur für Freiwillige	Verein
7976	Stiftung Zürcher Journalistenpreis	Stiftung
8008	ECSA Chemicals AG	AG
8015	Halter AG Wil	AG
8063	Bimbosan AG	AG
8082	Dübör Backtrennmittel- und Apparatebau AG	AG
8100	Fondazione per la ricerca e lo sviluppo dell'Università della Svizzera italiana	Stiftung
8105	Berg & Bett Betriebs AG	AG
8128	Junge SVP Oberwallis	Verein
8131	SOSTA - Zwischenhalt für Kinder in Krise	Verein
8162	Branchenverband Thurgau Weine	Verein
8040	Schätzle AG	AG
7843	Prix Wasserfrau	Verein
8187	FountainVest Partners	AG
8203	Schweizerische Volkspartei Bezirk Bad Zurzach	Verein
8229	RISTOSUTER Sagl	GmbH
8246	Stiftung Helvetiflora	Stiftung
8265	Förderverein der Musik Akademie Basel	Verein
8282	ARTISET	Verein
8306	Conscious Influence Hub	Verein
8347	Stiftung für die Renovation der Kaserne der päpstlichen Schweizergarde im Vatikan	Stiftung
8354	Kompetenzplattform Permakultur-Landwirtschaft	Verein
8360	Feldmusik Gunzwil	Verein
8403	Bytix AG	AG
8413	Verein Eidgenössisches Jodlerfest 2023 Zug, genannt OK EJF 2023 Zug	Verein
8419	Stiftung Luzerner Feuerbestattung	Stiftung
8447	Zurzach Care Luzern AG	AG
8491	atorex AG	AG
8535	Swiss Tennis	Verein
8507	StandUp4Democracy	Verein
8533	Stiftung für altersgerechte Wohnungen, Mitlödi	Stiftung
8588	Expedia Group Inc.	AG
8496	Akomag Corporate Communications AG	AG
8618	Junge SVP Kanton Aargau	Verein
8649	Planck Security AG	AG
8672	Prewo AG Zürich	AG
8741	Leading Swiss Agencies	Verein
8759	BridgeKo GmbH	GmbH
8751	Eidgenössische Schiedskommission für die Verwertung von Urheberrechten und verwandten Schutzrechten	Staatlich
8816	Familienstiftung Arthur Ottiger	Stiftung
8847	Stiftung für Erziehung zur Toleranz (SET)	Stiftung
8859	Stiftung Berufsbildungscampus Ostschweiz	Stiftung
8870	Sozialdemokratische Partei Bezirk Lenzburg	Verein
8942	Association Arythmie	Verein
8910	FLUX - Goldener Verkehrsknoten	Stiftung
8986	Solothurner Kantonaler Schwingerverband	Verein
8689	Umwelt Zeitung & Medien AG	AG
9041	Aprior Weinhandel GmbH	GmbH
9075	Radgruppe Bundeshaus	Informelle Gruppe
9083	Project R Genossenschaft	Genossenschaft
9096	EnerCom Kirchberg AG	AG
9004	meier+zünd Kollektivgesellschaft	KG
9092	OK Eidgenössisches Tambouren- und Pfeiferfest 202	Verein
9236	Vereinigung der Museen im historischen Zentrum von Morges	Verein
8976	Antenne ICARO - Kompetenzzentrum	Verein
9323	Verein Selbsthilfe BE	Verein
7307	Gaillard & Costamagna Sàrl, en liquidation	GmbH
7387	Allianz Ergänzungsleistungen	Informelle Gruppe
7417	Netzwerk migrationscharta.ch	Informelle Gruppe
7431	Zweckverband Schulkreis Bellach-Lommiswil-Selzach (BeLoSe)	Oeffentlich-rechtlich
7478	SMVO Schweizerischer Verband für die Verifizierung von Arzneimitteln	Verein
7499	Serafe AG	AG
7532	Krauthammer & Partner GmbH	GmbH
7540	Verkehrs-Club der Schweiz, Sektion Tessin	Verein
7558	Lions Club Genf	Verein
7507	Claire & George Stiftung	Stiftung
7631	Immo-Genossenschaft Convivere	Genossenschaft
7702	Airborn Fuels Switzerland AG	AG
7641	Spitalradio LuZ	Verein
7746	foodwaste.ch AG	AG
7644	Spenglerei Pilatus AG	AG
7688	Grünliberale Partei Kanton Bern	Verein
7729	Theater Szene	Verein
7799	TUG Gastro AG	AG
7804	Association vaudoise pour la sauvegarde des logements des personnes précarisées	Verein
7735	Union Cantonale Neuchâteloise Des Arts & Metiers	Verein
7569	Schweizerische Organisation für Lösungsmittel-Verwendung	Verein
7880	Affolter Transporte AG	AG
7896	Spectrum GmbH	GmbH
7578	ELCA Group SA	AG
7744	Alumni BFH-HAFL	Verein
7977	Verband Frauenunternehmen	Verein
8010	ECSA AG	AG
8029	Shell (Switzerland) AG	AG
8065	BIOFARM-Genossenschaft	Genossenschaft
8069	Bio Partner Gruppe AG	AG
8078	Riseria Taverne SA	AG
8107	Stiftung für Technologiefolgen-Abschätzung	Staatlich
8116	Hosberg Holding AG	AG
8119	Ofac société coopérative	Genossenschaft
7987	Commune de Crissier	Staatlich
8053	Netzwerk Istanbul-Konvention	Informelle Gruppe
8167	SPitch AG	AG
8189	CS Victims	Informelle Gruppe
8208	Einwohnergemeinde Oberkirch	Staatlich
8231	Sicherheitspolitisches Forum Zentralschweiz	Informelle Gruppe
8252	Schweiz - Kurdischen Volk	Parlamentarische Freundschaftsgruppe
8269	Neutraler Quartierverein St.Alban-Gellert	Verein
8291	LUKS Immobilien AG	AG
8336	Casal-Bernard-Stiftung	Stiftung
8353	Museum Schloss Burgdorf	Verein
8314	Rugby Club Bern	Verein
8362	Oelibrönner Gonzbu	Verein
8398	WIF AG - Wine, Invest & Friendship	AG
8450	Kampahire GmbH	GmbH
8300	FISCHZENTRUM SCHWEIZ	Stiftung
8489	Radix für die italienische Schweiz	Verein
8493	Femmes socialistes du Valais romand	Informelle Gruppe
8506	Markt und Werbung	Parlamentarische Gruppe
8521	Banca Raiffeisen del Camoghè società cooperativa	Genossenschaft
8544	HPV Rorschach	Verein
8482	Fondation rurale interjurassienne	Stiftung
8607	FDP.Die Liberalen Bezirk Aarau	Verein
8634	Neue Helvetische Gesellschaft (NHG) Gruppe Bern	Verein
8673	Pensionskasse der Zürcher Kantonalbank	Oeffentlich-rechtlich
8707	Genossenschaft für Kinderwindmühlen	Genossenschaft
8717	Pensionskasse MOBIL	Stiftung
8768	Systems Assembling SA	AG
8787	OAAT Organisation ambulante Arzttarife AG	AG
8810	Centre de puériculture jurassien	Verein
8830	Loeba GmbH	Genossenschaft
8873	PROPAYSAGES Sàrl	GmbH
8867	Hauseigentümerverband Biel & Umgebung	Verein
8940	SBK Sektion Bern Schweizer Berufsverband für Pflegefachpersonal	Verein
8885	Proficiunt GmbH	GmbH
8934	AWZ Arbeits- und Wohnzentrum Stiftung für Behinderte	Stiftung
8988	VPOD Zürich	Verein
8894	LUSEA - Laboratoire de l'Utilisation de Sol, de l'Espace et de l'Aménagement	Verein
9039	Tonet AG	AG
9076	Green Care Schweiz	Verein
8996	ipso Bildung AG	AG
9106	Kantonalschützenfest Jura 2024	Verein
9207	CH-Schlachtviehversicherung Genossenschaft	Genossenschaft
9124	FICAL-Finanzierungs-Genossenschaft	Genossenschaft
8975	Kantonale Psychiatrische Klinik	Staatlich
9023	Stv Steinach	Verein
7667	Junge Grüne Aargau	Verein
7640	Schwingklub Oberhabsburg	Einzelunternehmen
7678	Stiftung Solidarität mit der Welt Regionalkomitee Ostschweiz	Verein
7565	Schweizerisches Architekturmuseum	Stiftung
7595	Bergberufe	Parlamentarische Gruppe
7602	Stiftung Lebensraum Gebirge	Stiftung
7648	Clienia AG	AG
7805	Stiftung Pro Stadion St. Gallen	Stiftung
7858	Comune di Ponte Capriasca	Staatlich
7870	targens Suisse SA in Liquidation	AG
7890	Verein StadtLand	Verein
7886	Vélo Club Vevey	Informelle Gruppe
7912	Association Mille Sept Sans	Verein
7957	heatconnect AG	AG
7929	Association K - Verein C	Verein
8007	ECSA Energy SA	AG
8057	aeschlimann-mühle ag	AG
8062	HOCHDORF Swiss Nutrition AG	AG
8073	Chocolat Stella SA	AG
8077	Midor AG	AG
7607	Promotion Laufenthal	Verein
8129	Pfarrei Eischoll	Verein
8146	Genossenschaft Migros Ostschweiz	Genossenschaft
7773	Wohnbau-Genossenschaft Nordwest	Genossenschaft
8048	Stadtgemeinde Brig-Glis	Staatlich
8179	Imkerverein Sursee	Verein
8207	SP Migrant*Innen Kanton Bern	Informelle Gruppe
8230	Bau- und Wohngenossenschaft NENA1	Genossenschaft
8248	Stockholm International Peace Research Institute	Stiftung
8279	S.I. L'Emeraude Aigle S.A.	AG
8292	Fondation suisse pour la promotion des échanges et de la mobilité (FPEM)	Stiftung
8308	BLAY Ent. AG	AG
8338	SwissRailvolution	Verein
8380	Fromagerie Amstutz SA	AG
8363	Die Junge Mitte Schweiz	Verein
8389	Koalition für Konzernverantwortung	Verein
8443	PANVICAplus Vorsorgestiftung	Stiftung
8445	Nachhaltigkeit im Finanzsystem	Parlamentarische Gruppe
8472	Sustainable Finance	Parlamentarische Gruppe
8427	Visana Allgemeine Versicherungen AG	AG
8539	Historische Kampfkunst Luzern	Verein
8566	Fair in Air	Verein
8495	Jogne Holding SA	AG
8593	Commune Bretigny-sur-Morrens	Staatlich
8608	SmartEn Smart Energy Europe	Verein
8626	Verein Mädchentreff Bern	Verein
8644	Verein Parldigi	Verein
8678	Association Mille Amis	Verein
8704	Association Danse Neuchâtel (ADN)	Verein
8709	Natur- und Tierparkverein Goldau	Verein
8747	Interreligiöse Arbeitsgemeinschaft in der Schweiz IRAS	Verein
8752	VR hochdrei AG in Liquidation	AG
8825	KODORI-TRAINING Knill	Einzelunternehmen
8848	Trägerverein Jugendtreff Niederlenz	Verein
8861	European Universities Orienteering Championship 2023	Verein
8868	Hauseigentümerverband Kanton Bern	Verein
8924	Berufsbildungszentrum BBZ Biel	Staatlich
8931	Andreas Meier & Co AG	AG
8947	MBBungert Immo AG	AG
8990	arctix GmbH	GmbH
9017	Verband der Ostschweizerischen Sicherheits-Unternehmen	Verein
9048	Film	Parlamentarische Gruppe
9058	Verein Naturpark Baselbiet	Verein
9082	Stockhornblick GmbH	GmbH
9088	Republik AG	AG
9109	Friedrich Naumann Foundation for Freedom	Stiftung
9217	Zürcher Komitee JA zur Individualbesteuerung	Verein
9239	Basic Income Earth Network - Switzerland	Verein
9028	Dermatologische Vereinigung Aargau	Verein
8081	Kennel AG	AG
8095	Groupe ELSA-MIFROMA	Einfache Gesellschaft
7924	Für die Zukunft der Bilateralen	Parlamentarische Gruppe
8118	Fresh Food & Beverage Group AG	AG
8155	Silberschmidt AG	AG
7990	Les Libéraux-Radicaux Crissier	Verein
8047	Schweizerische Volkspartei Pully	Verein
8169	Primavera	Verein
8199	its-ch	Verein
8213	Elfo AG	AG
8235	Swiss Power-to-X Collaborative Innovation Network (SPIN)	Verein
8253	Schweiz - Palästina	Parlamentarische Freundschaftsgruppe
8270	Fimotel AG	AG
8316	Jodlerklub Länggasse	Verein
8346	Schwyzer Kantonal-Schützengesellschaft	Verein
8312	swimsa (Swiss Medical Students' Association)	Verein
8381	focus50plus	Verein
8400	Fleisch-Genossenschaft Sernftal (FGS)	Genossenschaft
8420	Ei AG der SEG-Zürich/Basel	AG
8452	Zürcher Fürsorgeverein für Gehörlose	Verein
8437	POLYGENA AG	AG
8462	SOCIETE COOPERATIVE L'EOLIENNE DES ENFANTS	Genossenschaft
8526	Manhattan Family Office (MFO)	AG
8529	fit4school - Erfolg in der Schule, Erfolg im Leben	Stiftung
8573	Société Coopérative Bois-énergie Jorat-Broye	Genossenschaft
8481	Stiftung zur Unterstützung von Einelternfamilien (SUE)	Stiftung
8605	Musicians For Human Rights	Verein
8498	PRfact AG	AG
8636	Schweiz - Kolumbien	Parlamentarische Freundschaftsgruppe
8642	CH Open	Verein
8713	Etablissement Cantonal d'Assurance du Canton de Vaud	Oeffentlich-rechtlich
8737	Neosana AG	AG
8760	Elca informatik AG	AG
8765	RUAG International Holding AG	AG
8828	Digital Realty	AG
8846	Stiftung Zürcher Institut für interreligiösen Dialog	Stiftung
8862	Association "Le déjeuner Napoléon"	Verein
8871	Pan-European Regional Council	Verein
8925	Stiftung SBS Schweizerische Bibliothek für Blinde, Seh- und Lesebehinderte	Stiftung
8930	WeinStern Wettingen AG	AG
8937	UBS Business Solutions AG	AG
8791	fondation générosité	Stiftung
9031	FONDATION SUISSE DE DEMINAGE (FSD)	Stiftung
8950	FONDATION MAURICE SANDOZ ET MARGUERITE DE REDING	Stiftung
9044	Les Monts de Jéricho SA	AG
8994	Enzo Bianchi Sagl	GmbH
9110	Guido Graf-Luzerner Consulting Management AG	AG
9127	Impact Gstaad AG	AG
9222	Volksinitiative zur Einführung der Individualbesteuerung	Verein
9125	Verein Sportler:innen für Offenheit und Vielfalt	Verein
8984	Jogne Invest SA	AG
8117	Hosberg Immobilien AG	AG
8159	Jungfreisinnige Kanton Luzern	Verein
7992	Taskforce Culture	Informelle Gruppe
7998	Landstuhl bleibt grün	Verein
8178	Agrofutura AG	AG
8204	Sozialdemokratische Partei Bern-Mittelland	Verein
8232	Forstrevier Urnersee	Einfache Gesellschaft
8247	Starke Volksschule Zürich	Verein
8268	Akademische Zunft Basel	Verein
8289	InCine	Verein
8331	Stiftung zur Förderung der Lebensqualität Schwerstbehinderter	Stiftung
8326	AHW Gastro GmbH	GmbH
8379	Jugendprojekt LIFT	Verein
8361	Jugend Brass Band Michelsamt	Informelle Gruppe
8388	SolidaritéS	Verein
8415	HealthyMen AG	AG
8465	Casino du Jura S.A.	AG
8424	Schweizerische Vereinigung für Verwaltungsorganisationsrecht	Verein
8503	Fondation pour l'économie et le développement durable des régions d'Europe (FEDRE)	Stiftung
8550	Die Mitte Biel-Seeland	Verein
8575	Winterhilfe Waadt	Verein
8585	reCIRCLE AG	AG
8590	Uber Switzerland GmbH	GmbH
8511	Sportverband Kanton Schwyz	Verein
8633	Europäische Kommission	Staatlich
8624	Verein Feministische Wissenschaft Schweiz	Verein
8703	TREUHAND SUISSE Schweizerischer Treuhänderverband Sektion Zürich	Verein
8721	UNITERRE	Verein
8798	Cellnex Switzerland AG	AG
8808	École Professionnelle Montreux	Oeffentlich-rechtlich
8829	Assivalor AG	AG
8853	Solothurner Literaturtage	Verein
8876	AGON PARTNERS PUBLIC AFFAIRS AG	AG
8880	NORDAKADEMIE Hochschule der Wirtschaft	AG
8926	Stiftung Uetendorfberg, Schweizerische Wohn- und Arbeitsgemeinschaft für Hörbehinderte	Stiftung
8888	YS Pole Fitness GmbH	GmbH
8965	Care Leaving - ehemalige Heim- und Pflegekinder	Parlamentarische Gruppe
8969	Eduard Meier AG Wettingen	AG
8973	Comité International Olympique (CIO)	Verein
9053	Bezirk Küssnacht am Rigi	Staatlich
9045	Musée gruérien Bibliothèque de Bulle	Verein
9078	Emch+Berger ImmoConsult AG	AG
9003	Swiss Professional Horse Trading GmbH	GmbH
9006	Genossenschaft Wohnen im Alter Tübach	Genossenschaft
9094	Eidgenössische Frauenschwingverband	Verein
9108	FONDATION ARDÉVAZ	Stiftung
9029	SVP Kreispartei Rorschach	Verein
8139	Verein Ärzte für Ärzte	Verein
8158	Bewerbungskomitee Eidgenössisches Schwing- und Älplerfest Thun 2028	Einfache Gesellschaft
7774	Ticiconsult Sagl	GmbH
8041	Patronaler Vorsorgefonds der Schätzle-Betriebe	Stiftung
8188	Jaroslaw Alekseew/Alexei Nawalny	Informelle Gruppe
8184	Ambienta SGR	AG
8218	Panorama Chälenmattli AG	AG
8185	Merantix AG	AG
8260	Stiftung Martinskirche	Stiftung
8288	Institut für Systemisches Management und Public Governance der Universität St. Gallen	Oeffentlich-rechtlich
8333	OFS Ombud Finance Suisse	Stiftung
8298	ZeroWaste Switzerland	Verein
8366	Die Mitte Beromünster	Verein
8383	IG Klima-Zukunft Lenzburg	Verein
8396	Hirschmann-Stiftung	Stiftung
8399	Stiftung für die Förderung des beruflichen Bildungswesens im Autogewerbe	Stiftung
8455	Agglomeration Freiburg	Oeffentlich-rechtlich
8460	FDP Die Liberalen Frauen Stadt Bern	Informelle Gruppe
8463	Grüne Partei Kanton Neuenburg	Verein
8505	Fahrlehrer/innen/Fahrausbildung	Parlamentarische Gruppe
8565	KYMA sea conservation and research	Verein
8574	Groupement forestier Broye-Jorat	Staatlich
8594	Kompass / Europa	Verein
8612	Vincenz Partnerinnen GmbH	GmbH
8617	SVP Berikon	Verein
8641	idée coopérative Genossenschaft	Genossenschaft
8682	eqlosion sàrl	GmbH
8715	Oman-Switzerland Friendship Association (OSFA)	Verein
8767	Safran Vectronix AG	AG
8749	International Holocaust Remembrance Alliance (IHRA)	Verein
8827	Infra 5600 GmbH	GmbH
8872	Liberty Global plc	AG
8865	Erguël Sports SA	AG
8922	RICLIMA SA	AG
8927	Schweizerische Gesellschaft für Wirtschafts- und Sozialgeschichte	Einfache Gesellschaft
8909	5 Sterne Team	AG
8892	Einwohnergemeinde 3323 Bäriswil	Staatlich
9016	Gesellschaft Pro Vadiana	Einfache Gesellschaft
9054	Corps de Musique de la Ville de Bulle	Verein
9061	Verein Jugendsinfonieorchester St.Gallen	Verein
9071	Imkerbildung Schweiz GmbH	GmbH
9097	Bern Meetings & Events AG	AG
9128	Rete Tram-treno del Luganese SA (RTTL)	AG
9232	Trägerverein Lilith	Verein
8914	Stiftung Solothurnisches Zentrum Oberwald	Stiftung
8919	Tramowi AG	AG
8000	A.H. Meyer & Cie AG	AG
8193	Offiziersgesellschaft Thun	Verein
8201	Edelweiss Air AG	AG
8227	Stiftung Schulzentrum Weggis Hotel & Gastro formation	Stiftung
8244	RITEC	Verein
8258	Oekonomische Gemeinnützige Gesellschaft Bern	Verein
8276	Pallifon	Verein
8322	Leist Bern-Nord	Verein
8337	SELVA - Verband der Waldeigentümer Graubünden	Verein
8369	Club 200 FC Gunzwil	Verein
8392	Jucker Farm AG	AG
8405	SVP Dörflingen	Verein
8432	Hilfskasse-Stiftung des Schweizerischen Bäcker-Confiseurmeister-Verbandes	Stiftung
8456	Junge Grüne Kanton Freiburg	Verein
8461	Gemeinde Val-de-Ruz	Staatlich
8515	MIS Trend SA	AG
8549	Nant de Drance SA	AG
8508	Organisationskomitee Eidgenössisches Schützenfest Chur I Graubünden 2026 (ESF2026)	Verein
8525	Junge SVP Kanton Zürich Sektion West/City	Verein
8603	tiko Energy Solutions AG	AG
8500	F.G. Pfister Stiftung	Stiftung
8627	Inno Digital Services AG	AG
8646	PAMACHRO AG	AG
8712	Whistleblowing Institut	Einzelunternehmen
8694	Stiftung Internationales Zentrum der Traditionellen Bewässerung in Europa IZTB	Stiftung
8746	Verein Brunngasse 8	Verein
8805	ArcExpress	Verein
8845	L'association valaisanne des enseignants du cycle d'orientation	Verein
8822	grashobber Schweiz GmbH	GmbH
8863	Stiftung papilio	Stiftung
8939	SP-queer	Verein
8905	Skat Consulting AG	AG
8932	Besserstein Wein AG	AG
8948	Fondation du Grand Prix d'Horlogerie de Genève	Stiftung
8896	Bürgerliche Frauen Schweiz	Verein
9036	Kommission für die Spendengelder "Erdrutsch Brienz/Brinzauls"	Staatlich
9059	Swica Personalvorsorgestiftung	Stiftung
9080	Campagnes.com Sàrl	GmbH
9104	inspire AG für mechatronische Produktionssysteme und Fertigungstechnik	AG
9005	Jona Management AG	AG
9197	Société Coopérative OPTIMA-SOLAR Valais Wallis	Genossenschaft
9238	Treffpunkt Tschüdanga	Verein
8979	Résidence du Ruisseau Sàrl	GmbH
8210	Allianz Sicherheit Schweiz	Verein
8263	Basler Madrigalisten	Verein
8274	FOCUS-E Sàrl	GmbH
8344	LibertyGreen 3a Vorsorgestiftung	Stiftung
8349	Vermittlung schweizerischer Bildung in Indonesien	Verein
8370	Jugendparlament Kanton Luzern	Verein
8402	Gemeinde Dörflingen	Staatlich
8408	Genossenschaft sestorec	Genossenschaft
8441	Zurzach Care Klinik für Schlafmedizin AG	AG
8435	panvica Pensionskasse	Stiftung
8301	BOS Service AG	AG
8428	Diversity & Inclusion Services GmbH	GmbH
8546	ROSAS	Verein
8543	fmc - Schweizer Forum für Integrierte Versorgung	Verein
8584	Auto AG Schwyz	AG
8596	Trafigura Holding Sàrl	GmbH
8606	Freisinnige Partei Stadt Aarau	Verein
8614	Crowd Lobbying	Stiftung
8629	Fondation Bible patrimoine culturel	Stiftung
8652	Kunstturnerhaus Satus Schlieren, Genossenschaft	Genossenschaft
8657	Stiftung Chance	Stiftung
8728	Asia Society Switzerland Foundation	Stiftung
8697	TradeXBank AG	AG
8823	ACT212 Beratungs- und Schulungszentrum Me-Handel	Verein
8817	Mach Müsig	Verein
8835	Yerly Bois S.A.	AG
8864	Forum Musikbühne Uri	Verein
8921	European Federation of Police Unions	Verein
8957	Die Mitte Appenzell Ausserrhoden	Verein
8789	LANDIS & GYR STIFTUNG	Stiftung
8970	MOT Transport AG	AG
8895	Winterhilfe Obwalden	Verein
8951	Planzer Holding AG	AG
9066	Stiftung Schweizerischer Bankenombudsman	Stiftung
9073	Fondation FAVA	Stiftung
9000	Banca Raiffeisen del Cassarate società cooperativa	Genossenschaft
9182	Mobest AG	AG
9230	Mountain Sun Technologies AG	AG
8915	Corona-Hilfswerk.de	Verein
8985	Gregor Kuonen Caveau de Salquenen AG	AG
8266	Liberal-Demokratische Partei Basel-Stadt	Verein
8290	Circular Economy Switzerland	Informelle Gruppe
8296	FONDATION DU CINEMA BIO	Stiftung
8329	Gastro ZH Holding AG	AG
8367	Komitee für ein lebenswertes Beromünster - eine Gemeinde mit Zukunft	Informelle Gruppe
8373	St. Niklausgesellschaft Gunzwil-Dorf	Verein
8412	Bachmann-Roth Holding AG	AG
8434	Familienausgleichskasse PANVICA (FAK)	Verein
8470	Die Junge Mitte Kanton Thurgau	Verein
8475	B&B Trading AG	AG
8464	Ostschweizer Fachhochschule	Oeffentlich-rechtlich
8519	Junge SVP Kanton Zürich	Verein
8569	Association Pain du Gros-de-Vaud	Verein
8587	BASF Schweiz AG	AG
8483	Teamwärch GmbH	GmbH
8501	Gardasa Verwaltungen AG	AG
8631	Walder Wyss AG	AG
8653	Willy-Gradinger-Stiftung	Stiftung
8705	Förderverein Ochsen Oltingen	Verein
8744	Büfa AG	AG
8799	Frédy und Laura Grimm-Stiftung	Stiftung
8815	Schweiz - Finnland	Parlamentarische Freundschaftsgruppe
8819	Sicherheitszweckverband Unteres Furttal	Staatlich
8839	FC Granges-Paccot	Verein
8734	yoveo AG	AG
8882	Energieversorgung	Parlamentarische Gruppe
8928	Vertschi AG	AG
8933	Aargau Tourismus AG	AG
8992	Verein IBU Biathlon-WM 2025 Lenzerheide	Verein
8691	CuriX AG	AG
9057	Nachhaltigkeitsnetzwerk Kanton Solothurn	Verein
9077	Die Plattform feministische Ökonomie. Wenn Frauen zählen	Verein
9085	Schadenorganisation Erdbeben	Verein
9112	Eidgenössische Arbeitszeitgesetzkommission	Ausserparlamentarische Kommission
9090	Swiss Food- & Agro-Tech Association	Verein
9233	Verein Zunfthaus zum Weggen	Verein
8917	Verein Schulen nach Bern	Verein
9234	Universitäre Psychiatrische Dienste Bern (UPD) AG	AG
8281	Patientenverfügung und Selbstbestimmung	Parlamentarische Gruppe
8307	Büetzer Buebe AG	AG
8309	Hangar Media AG	AG
8341	Fondation RERO plus	Stiftung
8384	SAM Basket Massagno	Verein
8407	Brotegg AG	AG
8442	Panvica Ausgleichskasse	Oeffentlich-rechtlich
8468	Eisenplatz	Verein
8448	Zurzach Care Reintegration Zürich AG	AG
8303	WhyWait AG	AG
8537	jobtimal.ch	Verein
8541	Stiftung für Wirtschaft und Gesellschaft	Stiftung
8583	Kommission für Bildung und Beratung des Plantahofs	Verein
8595	SKYGUIDE, Société Anonyme Suisse pour les Services de la Navigation Aérienne civils et militaires	AG
8509	Aneba AG	AG
8628	Internationale Bewegung ATD Vierte Welt	Verein
8645	IC information company AG	AG
8692	CuriX Invest & Management AG	AG
8723	Wohnbaugenossenschaft Rote Leu	Genossenschaft
8769	Thales Suisse SA	AG
8807	129. Nordostschweizer Schwingfest St.Gallen 2025	Verein
8754	Commune de Moudon	Staatlich
8836	Eidgenössische Einigungsstelle zur Beilegung von kollektiven Arbeitsstreitigkeiten	Staatlich
8897	LVO Obwalden	Verein
8881	Alice Schoch-Bockhorn-Stiftung	Stiftung
8958	Die Mitte Jura	Verein
8929	Rebschule Meier AG	AG
8964	Magdalena Schweizer-Stiftung	Stiftung
8512	Rabe GmbH	GmbH
9030	Verein Nordostschweizer Schwingfest 2025 St.Gallen	Verein
9051	Hightech Zentrum Aargau AG	AG
9060	IG öffentlicher Verkehr Stadt St.Gallen	Staatlich
9070	BienenSchweiz - Imkerverband der deutschen und rätoromanischen Schweiz	Verein
8998	Public Discourse Foundation	Stiftung
9116	Eidgenössische Volksinitiative 'Für eine gute und bezahlbare familienergänzende Kinderbetreuung für alle	Informelle Gruppe
9210	SVP Zeihen	Verein
9126	Interessengemeinschaft Sozialpsychiatrie Bern	Verein
8978	Banque Raiffeisen du Val-Terbi société coopérative	Genossenschaft
8913	Bootshafen Unterterzen AG	AG
8348	Jaeger Graber Notare und Rechtsanwälte	Einfache Gesellschaft
8378	Orif, Organisation romande d'intégration et de formation professionnelle	Verein
8393	Stiftung PTA Biel	Stiftung
8376	Wysswiifraktion Gonzbu	Verein
8416	PolitikBeratung Graf-Litscher	Einzelunternehmen
8453	Kommunikationsplan AG	AG
8425	Unternehmer-Vereinigung gegen den EU Beitritt	Verein
8490	Stiftung Harfe und Klavier	Stiftung
8527	Jungfreisinnige Aarau-Lenzburg-Kulm	Verein
8479	Stiftung meinplatz.ch / maplace.ch / mioposto.ch	Stiftung
8578	Communauté Régionale de la Broye	Verein
8599	Alliance Rouge	Verein
8609	Fachhochschule Graubünden	Oeffentlich-rechtlich
8619	Jungfreisinnige Freiburg	Verein
8648	Post CDR AG	AG
8655	Marienburg-Stiftung der Zürcher Kantonalbank	Stiftung
8708	Pan Eco	Stiftung
8724	Verein zur Wahrung der Schweizer Neutralität	Verein
8771	DreamLab Technologies AG	AG
8736	Neosana Services GmbH	GmbH
8730	KMU Forum	Staatlich
8832	Stadt Zürich, Fachschule Viventa	Staatlich
8837	Verein Interessengemeinschaft IG Grimseltunnel	Verein
8866	Le Passage Sàrl	GmbH
8901	Fondation Marcel Bourquin	Stiftung
8943	TCS Swiss Ambulance Rescue SA	AG
8945	Fondation de la Haute Ecole de Musique Vaud Valais Fribourg et du Conservatoire de Lausanne	Stiftung
8891	Association JURA 24	Staatlich
8792	Stiftung Ehrenkodex	Stiftung
9037	Eidgenössisches Armbrustschützenfest 2026 in Weesen SG	Verein
8953	Die Mitte Schwyz	Verein
9069	Verband Aargauer Musikschulen	Verein
9095	OK Eidgenössisches Frauenschwingfest 2024	Verein
9123	Daniel Wiener Freuler Beratung und Kommunikation	Einzelunternehmen
9183	Fritz Suter AG	AG
9101	König Consulting GmbH	GmbH
8981	STM Agency GmbH	GmbH
9107	Organisme de Liaison des Industries Métalliques Européennes	Verein
8406	Initiative gegen Massentierhaltung	Informelle Gruppe
8418	Prefero AG	AG
8458	Kähr GmbH	GmbH
8476	Alder & Schildknecht AG	AG
8504	Société coopérative du Cercle ouvrier lausannois	Genossenschaft
8520	Sindacati Indipendenti Ticinesi	Verein
8522	Società Cooperativa fra produttori e consumatori Migros - Ticino	Genossenschaft
8580	Fondation du Théâtre du Jorat	Stiftung
8602	Stadt Nidau	Staatlich
8615	Rent Systems GmbH	GmbH
8643	Verein Lichtspiel Kinemathek Bern	Verein
8681	ID Watch SA	AG
8701	GRÜNE Kanton St.Gallen	Verein
8695	Verein Wisent im Thal	Verein
8761	Nitrochemie Wimmis AG	AG
8806	Beirat Entsorgung	Staatlich
8818	Association FIS Ski Alpin Championnats du monde 2027 Crans-Montana	Verein
8849	Einwohnergemeinde Niederlenz	Staatlich
8840	Verein G-Movement	Verein
8735	Neosana Sales AG	AG
8903	Stiftung Röhrenhaus in Bäriswil	Stiftung
8886	Solidaritätsaktion für Erdbebenopfer in der Türkei/Syrien	Verein
8963	Schweizerische Agentur für Akkreditierung und Qualitätssicherung	Staatlich
8971	Tägerhard Kies AG	AG
8974	La Fondation Olympique pour la Culture et le Patrimoine	Stiftung
9047	Chaillot Bouchons SA	AG
9043	Orval Immo4U Sàrl	GmbH
9084	SAQ Swiss Association for Quality	Verein
9074	Tour de Berne	Verein
9203	Lungenliga Aargau	Verein
9228	Schweizerische Stiftung für die Geschichte der Post und Telekommunikation	Stiftung
9121	TPH Bausysteme Schweiz AG	AG
9026	Pharmacie du Museum SA	AG
9022	Region Appenzell AR - St.Gallen - Bodensee	Verein
8423	Cité Radieuse	Stiftung
8302	Gewerbeverband Appenzell Ausserhoden	Verein
8517	Bern West Immobilien KMG	Einfache Gesellschaft
8547	Ritom SA	AG
8570	Association Région Gros-de-Vaud	Verein
8545	SVTI Schweizerischer Verein für technische Inspektionen	Verein
8611	tiko Services	AG
8623	Spurwechsel	Verein
8650	AMS Prestige Properties and Concierge Services Sàrl	GmbH
8683	Compagnie du Chemin de fer Montreux Oberland bernois SA	AG
8706	Asylnetz Luzern	Verein
8745	itcnet AG	AG
8764	Rheinmetall Air Defence AG	AG
8844	Ziegelindustrie Schweiz	Verein
8732	Evidenzbasierte Prävention in der medizinischen Grundversorgung	Verein
8875	Sinnvoll Gastro Holding AG	AG
8733	Neosana Life AG	AG
8941	Sozialdemokratische Partei Bern Altstadt Kirchenfeld	Verein
8961	Die Mitte Worb	Verein
8790	Idea Information AG	AG
8972	Eduard Meier Verwaltungs AG	AG
9034	Association Neuchâtel-Berlin	Verein
8952	Die Mitte Nidwalden	Verein
9065	Insta-rex S.A. en liquidation	AG
8995	Allianz Ernährung und Gesundheit	Verein
9113	Frajimmo Sàrl	GmbH
9009	KMU Performer AG	AG
9237	Verein CRADLE	Verein
9024	Musikgesellschaft Steinach	Verein
9340	Solar Energie Effizienz AG, Luzern	AG
8473	Jeunesses Socialistes du Valais Romand	Verein
8534	Genossenschaft Vereinigte Milchbauern Mitte-Ost	Genossenschaft
8478	Junge Bühne Bern	Verein
8480	CHACOMO	Verein
8576	La Forestière, société coopérative de propriétaires et exploitants forestiers	Genossenschaft
8484	La Cucina Tee- und Gewürzhaus GmbH	GmbH
8510	kapisa coaching gmbh in Liquidation	GmbH
8635	Internationale Zusammenarbeit	Parlamentarische Gruppe
8651	Qonexus Services GmbH	GmbH
8700	Gesangfest beider Basel 2023	Verein
8719	Schweiz - Marokko	Parlamentarische Freundschaftsgruppe
8758	B & T AG	AG
8786	Stiftung Theater und Orchester Biel Solothurn TOBS	Stiftung
8824	Eglise évangelique Action Biblique de Meinier	Verein
8820	bio.inspecta AG	AG
8874	Staatskanzlei Luzern	Staatlich
8878	Tennis Club Bad Zurzach	Verein
8803	InterXion (Schweiz) GmbH	GmbH
8908	Balanz AG	AG
8966	Wandern	Parlamentarische Gruppe
8991	Les Champignons de nos terroirs Sàrl	GmbH
9033	ABB Technikerschule	Verein
9056	Soroptimist International Club de Romont	Verein
9046	Association la Tuile	Verein
9081	Asuera Stiftung	Stiftung
9086	Rod Kommunikation AG	AG
9122	BURRI public elements AG	AG
9093	Schweizerischer Tambouren- und Pfeiferverband	Verein
9102	Jconseils.ch Sàrl	GmbH
9019	Trägerverein Integrationsprojekte St. Gallen TISG	Verein
8471	Wiler Forum für Nachhaltigkeit	Verein
8518	FUCHS TRAITEUR - TOOPRE SA	AG
8494	Loungemax Living GmbH	GmbH
8568	Journée UCV 2023 à Montanaire	Verein
8579	La commune de Corcelles-le-Jorat	Staatlich
8601	Grünliberale Nidau	Informelle Gruppe
8487	LANDI Muhen, Genossenschaft	Genossenschaft
8638	Studentengesangsverein Zürich	Verein
8677	RealStuff Informatik AG	AG
8727	Crossinvest SA	AG
8757	Swiss ASD	Informelle Gruppe
8802	RISTORANTE NIDO AG	AG
8814	Onco-Vorsorge und -Nachbetreuung in der Schweiz	Parlamentarische Gruppe
8821	SPITEX BASEL, Stiftung für Hilfe und Pflege zu Hause	Stiftung
8857	PAWA SA	AG
8900	Perrin - Passé Présent	Einzelunternehmen
8904	Société Neuchâteloise de Tir Sportif	Einfache Gesellschaft
8959	Christlich Soziale Schweiz	Verein
8912	MYTY Group AG	AG
8968	Sika Schweiz AG	AG
9032	Ärztinnen und Ärzte des Bezirk Zofingen	Verein
9055	AUTO AG URI	AG
9067	Volksinitiative 'Für eine verantwortungsvolle Wirtschaft innerhalb der planetaren Grenzen	Informelle Gruppe
9087	progresuisse	Informelle Gruppe
8796	REYL & Cie SA	AG
9007	Abwasserverband Morgental	Verein
9198	Genossenschaftsbund OPTIMA-SOLAR Schweiz	Genossenschaft
8980	Rohrer Bauwerke GmbH	GmbH
9018	Elektrizitätswerke-Verband St.Gallen-Appenzell	Verein
203	Reha Rheinfelden	Stiftung
217	Stiftung Pro Innerrhoden	Stiftung
407	Avantidonne - Kontaktstelle für Frauen und Mädchen mit Behinderung	Verein
414	Ticketcorner Holding AG	AG
435	Schweizerischer Verband der Bürgergemeinden und Korporationen	Verein
445	Jubiläumsstiftung der Kantonsschule Winterthur 1963	Stiftung
474	Schweizerischer Maler- und Gipserunternehmer-Verband (SMGV)	Verein
454	FDP Die Liberalen Tessin	Verein
489	Sulzer-Stiftung	Stiftung
112	Société coopérative de laiterie et d'agriculture de Bursins-Vinzel, en liquidation	Genossenschaft
432	Komitee für ein selbständiges Baselbiet	Verein
433	SPEDLOGSWISS Verband schweizerischer Speditions- und Logistikunternehmen	Verein
531	Stiftung Accentus	Stiftung
545	Stiftung Global Infrastructure Basel	Stiftung
563	Yvette Estermann Stiftung	Stiftung
593	Schweizerischer Landmaschinen-Verband SLV	Verein
601	Informationsgruppe Erfrischungsgetränke	Informelle Gruppe
628	Schweizerische Psoriasis und Vitiligo Gesellschaft SPVG	Verein
643	Verein "Unser Recht"	Verein
653	Wilhelm Schulthess - Stiftung	Stiftung
699	Schweizer Weinhandelskontrolle	Stiftung
718	Verein ARC - Bildungsinstitut für Arbeitnehmende	Verein
735	Liberty BVG Sammelstiftung	Stiftung
762	"Organisation der Schweizerischen Stromverbundunternehmen" (Swisselectric) in Liquidation	Verein
796	Association Fokolar Bewegung	Verein
775	European Expert Network on Terrorism Issues (EENeT)	Informelle Gruppe
825	Schwendner Chölbi-Verein	Verein
850	SWISS LINK Payroll AG	AG
873	EnAlpin AG	AG
886	Musik PGM	Parlamentarische Gruppe
922	Verein Geothermie Thurgau	Verein
947	Mengis Druck AG	AG
920	Schweizerische Volkspartei Thurgau	Verein
989	Greenpeace Schweiz	Stiftung
1006	Aktion für eine vernünftige Energiepolitik (AVES), Sektion Bern	Verein
1036	Les Fruits de Martigny SA	AG
1055	Stiftung Visana Plus	Stiftung
1050	BKW Energie AG	AG
1080	Fondation Johanna Dürmüller-Bol	Stiftung
1145	Institut für Finanzwissenschaft, Finanzrecht und Law and Economics (IFF-HSG) - Universität St. Gallen	Staatlich
1159	CCU Recycling AG	AG
1184	Fondation du Centre Ecologique Albert Schweitzer (CEAS)	Stiftung
1166	VQF Verein zur Qualitätssicherung von Finanzdienstleistungen	Verein
1235	Zenhäusern & Partner AG Unternehmensberatung für Öffentlichkeitsarbeit in Liquidation	AG
1264	Fondazione Sasso San Gottardo	Stiftung
1283	Panathlon Club Freiburg/Fribourg	Verein
1303	swisspatat	Verein
1327	connecta ag	AG
1316	Le Journal Agri Sàrl	GmbH
1368	PRO BAHN SCHWEIZ	Verein
1384	Association des amies et amis du Théâtre des Osses (AAATO)	Verein
1399	Stiftung Zukunftsfähigkeit	Stiftung
1413	Umweltallianz	Informelle Gruppe
1442	Tir Sportif Châble-Croix	Verein
1459	Pini Group SA	AG
1485	Parlamentarische Gruppe Green Cross Schweiz	Parlamentarische Gruppe
1498	Mutuel Assurances SA	AG
1526	SCHAUSPIELHAUS ZÜRICH AG	AG
1552	Paul Scherrer Institut (PSI) Ost	Staatlich
1563	Cargo sous terrain AG	AG
1599	N-Pulse AG	AG
1574	Gemeinde Ecublens VD	Staatlich
1638	OLF SA	AG
1673	LuzernPlus	Staatlich
1689	Swiss Capital in Motion GmbH	GmbH
1705	Bains de la Motta S.A.	AG
1729	Komitee No Billag	Informelle Gruppe
1752	Credit Suisse AG	AG
1781	Elopak Systems AG	AG
1798	Pro AI Vaud	Verein
1819	Matterhorn Gotthard Infrastruktur AG	AG
1846	Glasfasernetz Schweiz	Verein
1856	Société de la loterie de la Suisse romande	Verein
1874	Verband Schweizerischer Vermögensverwalter (VSV)	Verein
1933	IGORA-Genossenschaft für Aluminium-Recycling	Genossenschaft
1920	Stiftung Johanneum	Stiftung
1971	Gewerkschaftsbund des Kantons Bern	Verein
1989	Wohnbaugenossenschaft SIEBEN Bern	Genossenschaft
1999	St-Lukas-Bruderschaft	Verein
2004	FDP Die Liberalen Glarus Süd	Verein
2057	Agrisano Pencas	Stiftung
2093	African Union	Staatlich
2083	IBAarau Wärme AG	AG
2076	Dreyfus Söhne & Cie. Aktiengesellschaft, Banquiers	AG
2183	Koordinationsplattform Secteur Suisse EAP	Informelle Gruppe
2170	Stiftung SWONET	Stiftung
2139	pinktank GmbH	GmbH
2193	Eidgenössische Kommission für internationale Lebensmittelsicherheit EKIL	Ausserparlamentarische Kommission
2200	Walliser Hotelier-Verein WHV	Verein
2235	Sammelstiftung Symova	Stiftung
2263	i+R Spezialtiefbau AG	AG
2360	Parti Socialiste Genevois	Verein
2289	ki-management gmbh	GmbH
2295	Danner-Stiftung	Stiftung
2377	dreifive (Switzerland) AG	AG
2384	Bundesamt für wirtschaftliche Landesversorgung (BWL)	Staatlich
2389	Bielersee-Schifffahrts-Gesellschaft AG	AG
2457	Verkehrsforum Aargau	Verein
2417	Stiftung für Patientensicherheit	Stiftung
2426	Blaues Kreuz Bern - Solothurn - Freiburg	Verein
2432	Gastgewerbe	Parlamentarische Gruppe
2547	Schweizerische Friedensstiftung - swisspeace	Stiftung
2443	Schweizer Fleisch-Fachverband SFF	Verein
2601	Comité national des conseillers du commerce extérieur de la France	Verein
2610	GFT Fassaden AG	AG
2619	Josias Gasser Baumaterialien AG	AG
\.


--
-- Data for Name: Parliamentarian; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Parliamentarian" (id, "cantonId", "partyId", "firstName", "lastName") FROM stdin;
6	13	5	Thomas	de Courten
11	2	22	Lorenz	Hess
14	20	22	Christian	Lohr
21	13	1	Daniela	Schneeberger
40	2	3	Matthias	Aebischer
41	9	5	Thomas	Aeschi
44	25	5	Céline	Amaudruz
49	1	3	Jacqueline	Badran
51	1	2	Martin	Bäumle
53	2	2	Kathrin	Bertschy
60	17	5	Roland	Büchel
63	10	22	Christine	Bulliard-Marbach
65	18	22	Martin	Candinas
66	15	1	Andrea	Caroni
76	16	22	Daniel	Fässler
79	22	1	Olivier	Feller
83	19	2	Beat	Flach
88	26	3	Pierre-Alain	Fridez
89	17	3	Claudia	Friedl
96	1	4	Bastien	Girod
98	1	4	Balthasar	Glättli
100	25	9	Roger	Golay
101	5	1	Petra	Gössi
102	13	4	Maya	Graf
106	2	2	Jürg	Grossen
110	17	3	Barbara	Gysi
116	1	5	Alfred	Heer
120	14	5	Thomas	Hurter
125	1	3	Daniel	Jositsch
144	2	3	Nadine	Masshardt
147	1	2	Tiana Angelina	Moser
149	3	22	Leo	Müller
153	11	22	Stefan	Müller-Altermatt
154	14	3	Martina	Munz
159	22	3	Roger	Nordmann
161	13	3	Eric	Nussbaumer
166	9	22	Gerhard	Pfister
167	2	5	Nadja	Umbricht Pieren
168	10	3	Valérie	Piller Carrard
170	21	10	Lorenzo	Quadri
171	21	22	Fabio	Regazzi
172	17	5	Lukas	Reimann
178	17	22	Markus	Ritter
182	1	5	Gregor	Rutz
185	3	1	Peter	Schilliger
188	13	22	Elisabeth	Schneider-Schneiter
190	5	5	Pirmin	Schwander
192	25	3	Carlo	Sommaruga
198	2	4	Aline	Trede
210	2	1	Christian	Wasserfallen
211	19	3	Cédric	Wermuth
219	11	22	Pirmin	Bischof
223	18	22	Stefan	Engler
227	14	5	Hannes	Germann
228	20	22	Brigitte	Häberli-Koller
242	18	1	Martin	Schmid
248	1	1	Hans-Peter	Portmann
250	1	5	Thomas	Matter
251	1	1	Beat	Walti
261	23	5	Jean-Luc	Addor
264	12	15	Sibel	Arslan
270	22	5	Michaël	Buffat
271	2	5	Manfred	Bühler
272	19	5	Thomas	Burgherr
273	19	1	Thierry	Burkart
275	21	5	Marco	Chiesa
277	5	5	Marcel	Dettling
278	17	1	Marcel	Dobler
280	25	3	Laurence	Fehlmann Rielle
283	19	5	Andreas	Glarner
284	3	22	Andrea	Gmür-Schönenberger
285	3	5	Franz	Grüter
287	2	5	Erich	Hess
289	11	5	Christian	Imark
293	1	3	Min Li	Marti
294	18	5	Magdalena	Martullo-Blocher
296	1	3	Mattea	Meyer
297	23	1	Philippe	Nantermod
298	22	5	Jacques	Nicolet
299	10	5	Pierre-André	Page
301	2	5	Werner	Salzmann
302	1	1	Regine	Sauter
304	1	3	Priska	Seiler Graf
305	13	5	Sandra	Sollberger
306	1	5	Barbara	Steinemann
307	1	5	Mauro	Tuena
309	1	5	Bruno	Walliser
310	22	1	Laurent	Wehrli
312	15	5	David	Zuberbühler
314	19	1	Matthias Samuel	Jauslin
315	4	1	Josef	Dittli
316	6	22	Erich	Ettlin
317	9	22	Peter	Hegglin
318	3	1	Damian	Müller
319	23	22	Beat	Rieder
321	7	1	Hans	Wicki
323	22	3	Samuel	Bendahan
327	1	6	Niklaus-Samuel	Gugger
328	20	5	Diana	Gutjahr
329	19	4	Irène	Kälin
330	22	3	Brigitte	Crottaz
331	23	22	Benjamin	Roduit
332	1	3	Fabian	Molina
333	17	22	Nicolò	Paganini
334	3	4	Michael	Töngi
335	2	3	Flavia	Wasserfallen
337	1	22	Philipp	Kutter
339	13	3	Samira	Marti
340	23	22	Philipp Matthias	Bregy
341	17	5	Mike	Egger
343	1	5	Martin	Haab
345	17	22	Benedikt	Würth
346	17	4	Franziska	Ryser
347	2	3	Tamara	Funiciello
348	1	2	Corina	Gredig
349	1	4	Marionna	Schlatter
351	22	3	Pierre-Yves	Maillard
352	4	22	Heidi	Z'graggen
353	1	1	Andri	Silberschmidt
354	11	4	Felix	Wettstein
355	2	4	Christine	Badertscher
356	17	5	Esther	Friedli
357	2	2	Melanie	Mettler
358	2	4	Kilian	Baumann
360	19	5	Benjamin	Giezendanner
361	17	1	Susanne	Vincenz-Stauffacher
363	3	22	Priska	Wismer-Felder
364	19	22	Marianne	Binder-Keller
366	1	3	Céline	Widmer
367	22	4	Sophie	Michaud Gigon
368	12	3	Mustafa	Atici
369	12	2	Katja	Christ
370	19	3	Gabriela	Suter
371	10	4	Gerhard	Andrey
373	19	5	Martina	Bircher
374	18	1	Anna	Giacometti
376	2	19	Andreas	Gafner
378	18	3	Jon	Pult
379	6	5	Monika	Rüegger
380	8	4	Mathias	Zopfi
381	10	1	Johanna	Gapany
382	12	3	Eva	Herzog
383	23	4	Christophe	Clivaz
384	20	5	Jakob	Stark
386	9	20	Manuela	Weichelt
387	20	5	Manuel	Strupler
388	24	1	Damien	Cottier
389	25	3	Christian	Dandrès
390	25	1	Simone	de Montmollin
391	2	5	Lars	Guggisberg
392	22	1	Jacqueline	de Quattro
393	21	1	Alex	Farinelli
394	19	5	Stefanie	Heimgartner
395	24	4	Fabien	Fivaz
396	21	4	Greta	Gysin
398	24	3	Baptiste	Hurni
399	23	22	Sidney	Kamerzin
400	9	1	Matthias	Michel
402	26	22	Charles	Juillard
403	25	4	Delphine	Klopfenstein Broggini
404	25	22	Vincent	Maitre
405	21	5	Piero	Marchesi
406	23	22	Marianne	Maret
410	22	4	Léonore	Porchet
411	1	4	Katharina	Prelicz-Huber
414	16	22	Thomas	Rechsteiner
415	19	1	Maja	Riniker
416	11	3	Franziska	Roth
417	10	22	Marie-France	Roth Pasquier
418	1	2	Barbara	Schaffner
419	4	22	Simon	Stadler
420	21	3	Bruno	Storni
421	24	4	Céline	Vara
422	25	4	Nicolas	Walder
424	13	4	Florence	Brenzikofer
425	19	5	Alois	Huber
426	12	3	Sarah	Wyss
427	23	5	Michael	Graber
428	23	3	Emmanuel	Amoos
429	10	22	Isabelle	Chassot
430	12	16	Patricia	von Falkenstein
431	22	2	Céline	Weber
432	1	5	Benjamin	Fischer
433	22	4	Raphaël	Mahaim
436	22	1	Daniel	Ruch
437	2	6	Marc	Jost
438	26	3	Mathilde	Crevoisier Crelier
439	19	22	Andreas	Meier
440	25	5	Thomas	Bläsi
441	17	5	Michael	Götte
\.


--
-- Data for Name: ParliamentarianRelatedToOrganization; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."ParliamentarianRelatedToOrganization" ("parliamentarianId", "organizationId", "position", "influenceLevel", verguetung) FROM stdin;
11	91	vorstand	TIEF	\N
11	92	vorstand	TIEF	\N
21	143	vorstand	TIEF	\N
21	144	vorstand	TIEF	\N
21	146	vorstand	TIEF	\N
21	147	vorstand	TIEF	\N
6	307	vorstand	TIEF	\N
14	310	vorstand	TIEF	\N
6	343	vorstand	HOCH	\N
6	432	vorstand	TIEF	\N
6	435	vorstand	MITTEL	\N
51	140	beirat	MITTEL	\N
96	140	beirat	MITTEL	\N
11	538	beirat	MITTEL	\N
11	2432	mitglied	TIEF	\N
11	601	vorstand	TIEF	\N
153	637	vorstand	HOCH	\N
65	261	mitglied	TIEF	\N
49	347	vorstand	HOCH	\N
76	779	vorstand	TIEF	\N
76	819	vorstand	TIEF	\N
76	823	vorstand	TIEF	\N
11	923	mitglied	TIEF	\N
185	958	vorstand	TIEF	\N
185	959	vorstand	TIEF	\N
185	960	vorstand	TIEF	\N
185	961	vorstand	TIEF	\N
185	962	vorstand	TIEF	\N
185	963	geschaeftsfuehrend	TIEF	\N
185	971	vorstand	TIEF	\N
185	336	vorstand	MITTEL	\N
185	973	beirat	TIEF	\N
210	1008	vorstand	TIEF	\N
11	1058	vorstand	HOCH	\N
11	1057	vorstand	HOCH	\N
11	1056	vorstand	HOCH	\N
11	1060	vorstand	TIEF	\N
11	1059	vorstand	HOCH	\N
161	1124	vorstand	MITTEL	\N
120	244	vorstand	HOCH	\N
65	244	vorstand	HOCH	\N
106	244	vorstand	MITTEL	\N
242	1183	geschaeftsfuehrend	MITTEL	\N
242	1160	vorstand	HOCH	\N
242	1163	vorstand	TIEF	\N
242	1164	vorstand	TIEF	\N
242	1170	vorstand	HOCH	\N
242	1171	vorstand	TIEF	\N
51	764	vorstand	HOCH	\N
51	556	vorstand	HOCH	\N
51	1053	geschaeftsfuehrend	TIEF	\N
51	1233	finanziell	TIEF	\N
51	1234	vorstand	TIEF	\N
51	674	beirat	MITTEL	\N
159	1352	mitglied	TIEF	\N
192	347	vorstand	HOCH	\N
159	1353	mitglied	TIEF	\N
159	1355	mitglied	TIEF	\N
159	1363	mitglied	TIEF	\N
159	1364	mitglied	TIEF	\N
159	1064	mitglied	TIEF	\N
159	34	mitglied	TIEF	\N
159	604	mitglied	TIEF	\N
159	1365	mitglied	TIEF	\N
159	1366	mitglied	TIEF	\N
159	576	mitglied	TIEF	\N
159	1367	mitglied	TIEF	\N
159	1368	mitglied	TIEF	\N
159	179	mitglied	TIEF	\N
159	6454	mitglied	TIEF	\N
159	1377	mitglied	TIEF	\N
106	1380	beirat	MITTEL	\N
106	1396	vorstand	TIEF	\N
51	1485	vorstand	TIEF	\N
53	415	vorstand	MITTEL	\N
102	415	vorstand	HOCH	\N
147	1504	beirat	TIEF	\N
44	1504	beirat	TIEF	\N
63	1504	beirat	TIEF	\N
98	1504	beirat	TIEF	\N
188	1504	beirat	TIEF	\N
210	1504	vorstand	TIEF	\N
153	1505	vorstand	TIEF	\N
66	1531	taetig	TIEF	\N
242	1547	vorstand	HOCH	\N
242	39	vorstand	HOCH	\N
66	1600	vorstand	TIEF	\N
88	1660	vorstand	TIEF	\N
166	1668	vorstand	TIEF	\N
166	1669	vorstand	MITTEL	\N
227	1677	vorstand	TIEF	\N
11	1682	gesellschafter	TIEF	\N
6	923	mitglied	TIEF	\N
188	923	mitglied	TIEF	\N
66	1750	vorstand	TIEF	\N
66	1758	vorstand	TIEF	\N
172	1758	vorstand	TIEF	\N
14	1800	vorstand	TIEF	\N
120	1846	vorstand	HOCH	\N
51	1846	vorstand	MITTEL	\N
171	1846	vorstand	HOCH	\N
21	1859	vorstand	HOCH	\N
41	1594	taetig	MITTEL	\N
178	1247	vorstand	TIEF	\N
178	47	vorstand	HOCH	\N
178	1290	vorstand	TIEF	\N
227	477	vorstand	HOCH	\N
228	477	vorstand	MITTEL	\N
227	1927	vorstand	TIEF	\N
227	1928	vorstand	TIEF	\N
227	1929	vorstand	MITTEL	\N
250	1941	vorstand	TIEF	\N
219	694	vorstand	HOCH	\N
219	1944	vorstand	TIEF	\N
219	1945	vorstand	TIEF	\N
219	1946	vorstand	TIEF	\N
219	1947	vorstand	TIEF	\N
219	26	vorstand	HOCH	\N
219	86	geschaeftsfuehrend	TIEF	\N
250	1948	vorstand	TIEF	\N
250	1949	vorstand	TIEF	\N
250	1950	vorstand	TIEF	\N
219	1974	mitglied	TIEF	\N
219	1975	mitglied	TIEF	\N
219	1192	mitglied	TIEF	\N
219	1976	mitglied	TIEF	\N
219	1978	mitglied	TIEF	\N
219	1979	mitglied	TIEF	\N
219	576	mitglied	TIEF	\N
219	1980	taetig	TIEF	\N
219	1981	mitglied	TIEF	\N
219	1157	mitglied	TIEF	\N
223	1992	vorstand	HOCH	\N
6	51	vorstand	MITTEL	\N
6	52	vorstand	TIEF	\N
11	90	beirat	TIEF	\N
66	453	vorstand	HOCH	\N
198	1065	mitglied	TIEF	\N
182	892	vorstand	HOCH	\N
101	892	vorstand	HOCH	\N
40	2152	vorstand	TIEF	\N
223	2127	vorstand	TIEF	\N
11	98	beirat	TIEF	\N
227	2251	geschaeftsfuehrend	TIEF	\N
88	295	beirat	MITTEL	\N
88	2309	vorstand	TIEF	\N
88	2157	vorstand	TIEF	\N
88	2316	vorstand	TIEF	\N
88	2321	mitglied	TIEF	\N
88	381	mitglied	TIEF	\N
100	1092	mitglied	TIEF	\N
228	311	mitglied	TIEF	\N
83	2455	vorstand	TIEF	\N
83	2456	vorstand	TIEF	\N
83	583	vorstand	MITTEL	\N
192	340	vorstand	HOCH	\N
89	340	vorstand	HOCH	\N
182	835	vorstand	MITTEL	\N
125	49	vorstand	MITTEL	\N
198	989	mitglied	TIEF	\N
198	602	mitglied	TIEF	\N
198	2558	mitglied	TIEF	\N
198	2559	mitglied	TIEF	\N
198	2560	mitglied	TIEF	\N
198	2562	mitglied	TIEF	\N
170	2611	vorstand	TIEF	\N
170	2616	vorstand	TIEF	\N
251	2624	vorstand	TIEF	\N
251	2626	vorstand	HOCH	\N
251	249	vorstand	TIEF	\N
261	2650	vorstand	TIEF	\N
261	2651	vorstand	TIEF	\N
261	1976	mitglied	TIEF	\N
261	2652	mitglied	TIEF	\N
261	2653	mitglied	TIEF	\N
261	2658	vorstand	TIEF	\N
261	2659	vorstand	HOCH	\N
261	1035	mitglied	TIEF	\N
261	2660	mitglied	TIEF	\N
261	652	mitglied	TIEF	\N
261	2661	mitglied	TIEF	\N
261	2663	mitglied	TIEF	\N
261	2664	mitglied	TIEF	\N
40	2665	vorstand	HOCH	\N
40	2668	geschaeftsfuehrend	HOCH	\N
40	2670	beirat	MITTEL	\N
40	2671	beirat	MITTEL	\N
40	1079	beirat	TIEF	\N
40	2672	beirat	MITTEL	\N
40	1897	vorstand	HOCH	\N
40	2673	mitglied	TIEF	\N
40	2674	vorstand	HOCH	\N
40	2675	mitglied	TIEF	\N
40	2676	vorstand	TIEF	\N
172	2676	vorstand	TIEF	\N
40	2677	vorstand	TIEF	\N
40	2680	beirat	TIEF	\N
63	2680	beirat	TIEF	\N
210	2680	beirat	TIEF	\N
168	2706	vorstand	TIEF	\N
168	58	vorstand	HOCH	\N
167	2713	vorstand	TIEF	\N
287	2714	vorstand	MITTEL	\N
167	2714	vorstand	MITTEL	\N
271	2714	vorstand	MITTEL	\N
44	517	vorstand	MITTEL	\N
60	2726	vorstand	TIEF	\N
44	2732	vorstand	MITTEL	\N
44	2733	vorstand	TIEF	\N
44	2734	vorstand	TIEF	\N
60	2736	vorstand	TIEF	\N
63	2775	vorstand	MITTEL	\N
63	2824	vorstand	TIEF	\N
63	2827	geschaeftsfuehrend	TIEF	\N
63	2828	vorstand	TIEF	\N
63	2831	vorstand	MITTEL	\N
63	2833	vorstand	MITTEL	\N
63	2838	vorstand	TIEF	\N
63	2840	vorstand	MITTEL	\N
65	2855	vorstand	TIEF	\N
102	2855	vorstand	TIEF	\N
227	2855	vorstand	TIEF	\N
188	2858	vorstand	TIEF	\N
147	2898	vorstand	TIEF	\N
228	2899	vorstand	TIEF	\N
79	2899	vorstand	TIEF	\N
79	2900	geschaeftsfuehrend	TIEF	\N
79	2105	geschaeftsfuehrend	HOCH	\N
79	2904	vorstand	TIEF	\N
65	538	beirat	MITTEL	\N
79	1491	vorstand	TIEF	\N
211	1064	mitglied	TIEF	\N
211	1053	mitglied	TIEF	\N
211	989	mitglied	TIEF	\N
211	576	mitglied	TIEF	\N
211	179	mitglied	TIEF	\N
211	293	mitglied	TIEF	\N
211	580	mitglied	TIEF	\N
211	130	mitglied	TIEF	\N
211	381	mitglied	TIEF	\N
211	1037	vorstand	TIEF	\N
211	2906	mitglied	TIEF	\N
211	1344	mitglied	TIEF	\N
211	980	mitglied	TIEF	\N
211	1043	mitglied	TIEF	\N
211	1155	mitglied	TIEF	\N
287	2907	vorstand	TIEF	\N
287	2909	vorstand	TIEF	\N
287	2910	vorstand	TIEF	\N
287	2911	gesellschafter	TIEF	\N
287	2912	vorstand	TIEF	\N
264	2914	vorstand	TIEF	\N
287	2462	taetig	MITTEL	\N
287	2918	vorstand	TIEF	\N
287	892	mitglied	TIEF	\N
287	2919	mitglied	TIEF	\N
287	366	mitglied	TIEF	\N
287	2920	mitglied	TIEF	\N
287	2921	mitglied	TIEF	\N
264	2922	mitglied	TIEF	\N
287	2925	mitglied	TIEF	\N
287	2926	mitglied	TIEF	\N
287	2927	mitglied	TIEF	\N
287	2928	mitglied	TIEF	\N
211	2948	mitglied	TIEF	\N
211	2949	mitglied	TIEF	\N
211	2950	mitglied	TIEF	\N
211	2952	mitglied	TIEF	\N
219	2007	mitglied	TIEF	\N
219	2008	mitglied	TIEF	\N
219	2009	mitglied	TIEF	\N
310	3403	vorstand	TIEF	\N
306	366	mitglied	TIEF	\N
272	2960	gesellschafter	TIEF	\N
272	2962	gesellschafter	TIEF	\N
272	2977	vorstand	TIEF	\N
283	2977	vorstand	TIEF	\N
273	2978	vorstand	TIEF	\N
305	32	vorstand	HOCH	\N
305	473	mitglied	TIEF	\N
305	2985	vorstand	TIEF	\N
305	2986	mitglied	TIEF	\N
305	2987	mitglied	TIEF	\N
305	468	mitglied	TIEF	\N
305	2988	mitglied	TIEF	\N
305	2991	mitglied	TIEF	\N
305	2992	mitglied	TIEF	\N
305	2993	mitglied	TIEF	\N
305	930	mitglied	TIEF	\N
305	147	mitglied	TIEF	\N
305	2994	mitglied	TIEF	\N
305	345	mitglied	TIEF	\N
305	2996	mitglied	TIEF	\N
305	519	vorstand	TIEF	\N
307	3016	geschaeftsfuehrend	TIEF	\N
307	3017	vorstand	TIEF	\N
317	3069	mitglied	TIEF	\N
289	3107	vorstand	TIEF	\N
289	517	vorstand	MITTEL	\N
289	3109	geschaeftsfuehrend	TIEF	\N
314	3117	mitglied	TIEF	\N
251	3125	vorstand	TIEF	\N
251	3128	vorstand	TIEF	\N
251	3153	vorstand	TIEF	\N
251	653	vorstand	TIEF	\N
251	3155	vorstand	MITTEL	\N
251	1608	vorstand	HOCH	\N
271	3156	vorstand	TIEF	\N
271	3159	vorstand	MITTEL	\N
271	3160	vorstand	TIEF	\N
270	1791	geschaeftsfuehrend	TIEF	\N
251	3176	vorstand	TIEF	\N
251	3177	beirat	TIEF	\N
166	1680	vorstand	TIEF	\N
280	3181	vorstand	TIEF	\N
280	130	mitglied	TIEF	\N
125	520	beirat	MITTEL	\N
190	520	beirat	MITTEL	\N
297	3240	mitglied	TIEF	\N
125	3243	vorstand	TIEF	\N
298	3244	vorstand	TIEF	\N
125	3245	vorstand	TIEF	\N
125	3246	vorstand	TIEF	\N
125	3247	vorstand	TIEF	\N
125	3268	vorstand	TIEF	\N
125	3269	vorstand	TIEF	\N
125	3271	geschaeftsfuehrend	TIEF	\N
125	3273	vorstand	TIEF	\N
223	122	beirat	TIEF	\N
125	3289	vorstand	MITTEL	\N
125	986	taetig	MITTEL	\N
125	1976	mitglied	TIEF	\N
125	3293	mitglied	TIEF	\N
125	3294	mitglied	TIEF	\N
261	3298	mitglied	TIEF	\N
261	3299	vorstand	TIEF	\N
182	3306	geschaeftsfuehrend	TIEF	\N
277	3307	vorstand	MITTEL	\N
98	3318	vorstand	TIEF	\N
89	191	beirat	MITTEL	\N
228	191	beirat	MITTEL	\N
293	3352	gesellschafter	TIEF	\N
310	3363	vorstand	TIEF	\N
310	3367	vorstand	TIEF	\N
310	3370	vorstand	TIEF	\N
310	2490	vorstand	MITTEL	\N
310	3391	vorstand	TIEF	\N
310	3392	vorstand	TIEF	\N
294	3394	vorstand	TIEF	\N
294	3395	vorstand	TIEF	\N
294	3396	vorstand	TIEF	\N
294	3397	vorstand	TIEF	\N
294	3399	vorstand	TIEF	\N
294	3400	vorstand	TIEF	\N
294	3401	vorstand	TIEF	\N
294	2122	vorstand	HOCH	\N
319	3423	vorstand	TIEF	\N
319	3421	vorstand	TIEF	\N
319	3422	vorstand	TIEF	\N
319	3424	geschaeftsfuehrend	TIEF	\N
319	3425	vorstand	TIEF	\N
319	2478	vorstand	MITTEL	\N
321	3434	vorstand	TIEF	\N
321	243	vorstand	HOCH	\N
318	991	vorstand	TIEF	\N
188	1266	beirat	MITTEL	\N
192	1278	vorstand	TIEF	\N
192	2159	vorstand	TIEF	\N
192	3470	vorstand	TIEF	\N
192	3496	vorstand	TIEF	\N
192	3498	vorstand	TIEF	\N
306	2728	vorstand	TIEF	\N
306	3520	vorstand	HOCH	\N
304	717	vorstand	TIEF	\N
306	3522	mitglied	TIEF	\N
306	3523	mitglied	TIEF	\N
306	3525	mitglied	TIEF	\N
306	3526	mitglied	TIEF	\N
309	3535	vorstand	TIEF	\N
309	3536	vorstand	TIEF	\N
309	3537	vorstand	TIEF	\N
309	700	taetig	TIEF	\N
309	3538	vorstand	TIEF	\N
309	3539	mitglied	TIEF	\N
302	3541	vorstand	TIEF	\N
302	701	vorstand	TIEF	\N
302	3542	vorstand	HOCH	\N
302	1608	geschaeftsfuehrend	MITTEL	\N
302	3543	mitglied	TIEF	\N
302	602	mitglied	TIEF	\N
302	141	mitglied	TIEF	\N
302	3544	mitglied	TIEF	\N
190	3550	vorstand	TIEF	\N
190	3551	vorstand	TIEF	\N
309	3561	vorstand	TIEF	\N
301	3571	vorstand	TIEF	\N
301	3572	vorstand	TIEF	\N
190	3574	beirat	MITTEL	\N
301	3576	mitglied	TIEF	\N
301	3577	mitglied	TIEF	\N
301	3578	mitglied	TIEF	\N
301	3579	mitglied	TIEF	\N
301	3580	vorstand	TIEF	\N
301	3582	mitglied	TIEF	\N
40	459	mitglied	TIEF	\N
272	2946	vorstand	TIEF	\N
272	2945	vorstand	TIEF	\N
283	3602	gesellschafter	TIEF	\N
283	3604	vorstand	TIEF	\N
283	1153	vorstand	TIEF	\N
283	997	vorstand	TIEF	\N
278	3613	mitglied	TIEF	\N
278	2935	vorstand	TIEF	\N
278	2936	mitglied	TIEF	\N
284	3617	beirat	TIEF	\N
284	1667	vorstand	TIEF	\N
284	3619	vorstand	MITTEL	\N
285	1021	beirat	MITTEL	\N
285	12	beirat	MITTEL	\N
285	1032	beirat	TIEF	\N
285	1015	vorstand	TIEF	\N
285	3658	vorstand	TIEF	\N
285	1016	vorstand	TIEF	\N
285	3659	vorstand	TIEF	\N
316	238	geschaeftsfuehrend	HOCH	\N
316	3666	vorstand	TIEF	\N
316	3667	vorstand	TIEF	\N
316	3574	vorstand	HOCH	\N
316	3668	beirat	TIEF	\N
316	3670	mitglied	TIEF	\N
316	3672	vorstand	MITTEL	\N
316	520	beirat	MITTEL	\N
316	5860	vorstand	TIEF	\N
285	2353	mitglied	TIEF	\N
285	1000	vorstand	TIEF	\N
285	3677	mitglied	TIEF	\N
285	1024	mitglied	TIEF	\N
285	1023	mitglied	TIEF	\N
315	3679	mitglied	TIEF	\N
315	1873	vorstand	MITTEL	\N
315	2538	vorstand	HOCH	\N
315	3686	vorstand	TIEF	\N
315	3687	vorstand	TIEF	\N
315	3688	vorstand	TIEF	\N
315	3689	vorstand	TIEF	\N
315	3690	vorstand	TIEF	\N
315	3691	vorstand	TIEF	\N
275	1365	vorstand	MITTEL	\N
275	3694	mitglied	TIEF	\N
277	3762	mitglied	TIEF	\N
167	3795	geschaeftsfuehrend	TIEF	\N
167	3796	vorstand	HOCH	\N
167	3797	vorstand	MITTEL	\N
167	1154	mitglied	TIEF	\N
167	3799	mitglied	TIEF	\N
317	700	taetig	TIEF	\N
144	1064	mitglied	TIEF	\N
144	130	mitglied	TIEF	\N
144	79	mitglied	TIEF	\N
144	580	mitglied	TIEF	\N
144	2429	mitglied	TIEF	\N
144	2449	mitglied	TIEF	\N
144	3847	mitglied	TIEF	\N
144	676	mitglied	TIEF	\N
144	69	mitglied	TIEF	\N
144	3850	mitglied	TIEF	\N
144	3852	mitglied	TIEF	\N
280	3562	vorstand	TIEF	\N
101	3892	vorstand	TIEF	\N
210	3893	vorstand	TIEF	\N
166	3907	vorstand	TIEF	\N
166	3908	vorstand	TIEF	\N
166	3912	geschaeftsfuehrend	TIEF	\N
166	3914	vorstand	TIEF	\N
166	3915	vorstand	TIEF	\N
166	3917	vorstand	TIEF	\N
166	3918	vorstand	TIEF	\N
166	657	vorstand	HOCH	\N
166	224	vorstand	TIEF	\N
166	204	vorstand	MITTEL	\N
166	3923	vorstand	TIEF	\N
248	3930	vorstand	MITTEL	\N
248	3932	vorstand	TIEF	\N
248	3935	geschaeftsfuehrend	TIEF	\N
154	3887	vorstand	TIEF	\N
154	3952	beirat	TIEF	\N
154	3957	vorstand	HOCH	\N
154	1064	mitglied	TIEF	\N
98	1063	mitglied	TIEF	\N
98	989	mitglied	TIEF	\N
98	580	mitglied	TIEF	\N
98	576	mitglied	TIEF	\N
98	602	mitglied	TIEF	\N
98	674	mitglied	TIEF	\N
98	3964	mitglied	TIEF	\N
98	3404	mitglied	TIEF	\N
98	3965	mitglied	TIEF	\N
98	581	vorstand	HOCH	\N
102	134	vorstand	MITTEL	\N
102	1707	mitglied	TIEF	\N
102	3969	mitglied	TIEF	\N
106	4032	vorstand	TIEF	\N
106	4033	vorstand	TIEF	\N
154	4034	mitglied	TIEF	\N
154	602	mitglied	TIEF	\N
154	130	mitglied	TIEF	\N
154	580	mitglied	TIEF	\N
154	340	mitglied	TIEF	\N
154	717	mitglied	TIEF	\N
154	35	mitglied	TIEF	\N
154	576	mitglied	TIEF	\N
154	347	mitglied	TIEF	\N
154	989	mitglied	TIEF	\N
154	2519	mitglied	TIEF	\N
154	1817	mitglied	TIEF	\N
154	4036	mitglied	TIEF	\N
154	4037	mitglied	TIEF	\N
154	4039	mitglied	TIEF	\N
154	1797	vorstand	MITTEL	\N
154	674	mitglied	TIEF	\N
154	4041	mitglied	TIEF	\N
154	4043	mitglied	TIEF	\N
154	4044	mitglied	TIEF	\N
154	4045	vorstand	HOCH	\N
106	2227	vorstand	MITTEL	\N
106	4047	vorstand	TIEF	\N
106	3589	vorstand	TIEF	\N
110	57	vorstand	TIEF	\N
110	4058	vorstand	TIEF	\N
110	4059	vorstand	MITTEL	\N
110	231	beirat	TIEF	\N
110	130	mitglied	TIEF	\N
110	381	mitglied	TIEF	\N
110	1064	mitglied	TIEF	\N
110	989	mitglied	TIEF	\N
110	580	mitglied	TIEF	\N
110	2956	mitglied	TIEF	\N
110	1380	mitglied	TIEF	\N
312	3594	vorstand	TIEF	\N
283	3598	vorstand	TIEF	\N
283	3599	taetig	TIEF	\N
154	4096	mitglied	TIEF	\N
154	4097	mitglied	TIEF	\N
154	4098	mitglied	TIEF	\N
154	4099	mitglied	TIEF	\N
154	4100	mitglied	TIEF	\N
154	4101	mitglied	TIEF	\N
116	3016	geschaeftsfuehrend	TIEF	\N
168	640	vorstand	TIEF	\N
315	2059	vorstand	TIEF	\N
65	4222	vorstand	TIEF	\N
65	45	vorstand	MITTEL	\N
65	134	vorstand	MITTEL	\N
65	4224	mitglied	TIEF	\N
65	4226	vorstand	TIEF	\N
65	4228	vorstand	TIEF	\N
65	4229	beirat	TIEF	\N
65	4231	vorstand	TIEF	\N
65	4232	beirat	TIEF	\N
21	3676	vorstand	HOCH	\N
21	4264	mitglied	TIEF	\N
182	4267	vorstand	TIEF	\N
182	682	vorstand	TIEF	\N
182	2773	vorstand	TIEF	\N
172	4302	vorstand	TIEF	\N
172	4303	vorstand	TIEF	\N
172	4305	beirat	TIEF	\N
188	4318	vorstand	MITTEL	\N
171	4339	vorstand	TIEF	\N
171	4340	vorstand	TIEF	\N
171	4341	vorstand	TIEF	\N
171	4345	vorstand	TIEF	\N
171	4346	vorstand	TIEF	\N
171	4348	vorstand	TIEF	\N
171	4349	vorstand	TIEF	\N
171	4350	vorstand	TIEF	\N
171	4351	beirat	TIEF	\N
171	446	beirat	MITTEL	\N
171	504	beirat	MITTEL	\N
171	4354	vorstand	HOCH	\N
171	4355	vorstand	TIEF	\N
171	4344	vorstand	TIEF	\N
285	1774	vorstand	TIEF	\N
149	113	vorstand	HOCH	\N
149	4397	vorstand	HOCH	\N
149	4400	vorstand	HOCH	\N
149	4401	taetig	TIEF	\N
147	4415	vorstand	HOCH	\N
147	2227	vorstand	HOCH	\N
89	4529	vorstand	TIEF	\N
89	4530	vorstand	TIEF	\N
89	130	mitglied	TIEF	\N
89	4531	vorstand	TIEF	\N
89	604	vorstand	MITTEL	\N
89	580	mitglied	TIEF	\N
89	584	mitglied	TIEF	\N
89	293	mitglied	TIEF	\N
89	347	mitglied	TIEF	\N
89	3973	mitglied	TIEF	\N
89	4067	mitglied	TIEF	\N
89	4060	mitglied	TIEF	\N
89	4534	mitglied	TIEF	\N
89	4535	mitglied	TIEF	\N
89	602	mitglied	TIEF	\N
89	4536	mitglied	TIEF	\N
89	4537	mitglied	TIEF	\N
89	1797	mitglied	TIEF	\N
89	4540	mitglied	TIEF	\N
89	4541	mitglied	TIEF	\N
89	4542	mitglied	TIEF	\N
89	4543	mitglied	TIEF	\N
89	4544	mitglied	TIEF	\N
297	283	vorstand	TIEF	\N
11	4551	vorstand	TIEF	\N
21	4580	vorstand	TIEF	\N
41	4580	vorstand	TIEF	\N
264	1456	vorstand	TIEF	\N
293	6666	vorstand	MITTEL	\N
296	4597	beirat	TIEF	\N
297	453	vorstand	HOCH	\N
297	12	beirat	MITTEL	\N
297	2158	vorstand	MITTEL	\N
227	12	beirat	MITTEL	\N
125	12	beirat	MITTEL	\N
228	4916	vorstand	TIEF	\N
228	4920	vorstand	TIEF	\N
228	154	beirat	MITTEL	\N
228	4923	beirat	MITTEL	\N
228	4924	mitglied	TIEF	\N
228	4926	mitglied	TIEF	\N
63	4926	mitglied	TIEF	\N
188	4926	mitglied	TIEF	\N
188	1278	vorstand	TIEF	\N
188	3496	vorstand	TIEF	\N
188	4929	vorstand	TIEF	\N
188	4931	vorstand	TIEF	\N
188	1740	vorstand	MITTEL	\N
188	361	mitglied	TIEF	\N
188	4934	mitglied	TIEF	\N
188	1710	beirat	TIEF	\N
188	4941	vorstand	TIEF	\N
188	1709	beirat	TIEF	\N
188	3969	mitglied	TIEF	\N
89	1063	mitglied	TIEF	\N
89	69	mitglied	TIEF	\N
89	4973	mitglied	TIEF	\N
89	674	mitglied	TIEF	\N
98	1064	mitglied	TIEF	\N
98	173	mitglied	TIEF	\N
98	265	mitglied	TIEF	\N
98	4974	mitglied	TIEF	\N
98	4565	vorstand	HOCH	\N
98	4975	mitglied	TIEF	\N
98	1376	mitglied	TIEF	\N
98	4977	beirat	MITTEL	\N
98	71	mitglied	TIEF	\N
89	4978	mitglied	TIEF	\N
89	4979	mitglied	TIEF	\N
110	4584	mitglied	TIEF	\N
110	4303	mitglied	TIEF	\N
110	4985	vorstand	MITTEL	\N
110	4987	geschaeftsfuehrend	TIEF	\N
299	4997	vorstand	TIEF	\N
302	5001	vorstand	TIEF	\N
171	5015	vorstand	TIEF	\N
144	3746	mitglied	TIEF	\N
144	5020	mitglied	TIEF	\N
223	5024	vorstand	TIEF	\N
223	2020	vorstand	TIEF	\N
223	524	vorstand	TIEF	\N
305	517	vorstand	MITTEL	\N
310	640	vorstand	TIEF	\N
110	4070	mitglied	TIEF	\N
110	4071	mitglied	TIEF	\N
110	4073	mitglied	TIEF	\N
63	5133	beirat	TIEF	\N
168	5133	beirat	TIEF	\N
6	5159	vorstand	TIEF	\N
228	5168	beirat	TIEF	\N
76	5172	vorstand	MITTEL	\N
321	6506	beirat	TIEF	\N
248	5183	vorstand	TIEF	\N
53	5205	vorstand	TIEF	\N
304	636	mitglied	TIEF	\N
228	5234	beirat	TIEF	\N
14	5245	vorstand	TIEF	\N
40	5245	vorstand	TIEF	\N
106	5245	vorstand	TIEF	\N
14	5246	mitglied	TIEF	\N
14	5248	vorstand	MITTEL	\N
14	5250	vorstand	TIEF	\N
14	5251	vorstand	HOCH	\N
14	5252	beirat	TIEF	\N
261	5257	vorstand	TIEF	\N
283	5257	vorstand	TIEF	\N
172	5257	vorstand	TIEF	\N
170	5257	mitglied	TIEF	\N
153	4959	vorstand	MITTEL	\N
161	5312	beirat	TIEF	\N
14	5312	beirat	TIEF	\N
228	5312	beirat	TIEF	\N
101	5322	beirat	TIEF	\N
106	5323	beirat	TIEF	\N
63	5335	beirat	MITTEL	\N
153	5002	vorstand	TIEF	\N
153	886	vorstand	TIEF	\N
153	5341	vorstand	MITTEL	\N
153	5342	vorstand	MITTEL	\N
153	5343	vorstand	MITTEL	\N
153	5344	vorstand	TIEF	\N
153	5346	beirat	MITTEL	\N
318	5351	beirat	MITTEL	\N
284	5351	beirat	MITTEL	\N
154	1504	beirat	TIEF	\N
228	5167	beirat	MITTEL	\N
125	5063	mitglied	TIEF	\N
219	5063	mitglied	TIEF	\N
317	5063	mitglied	TIEF	\N
106	5123	mitglied	TIEF	\N
167	5123	mitglied	TIEF	\N
21	5123	mitglied	TIEF	\N
309	5123	mitglied	TIEF	\N
315	5123	mitglied	TIEF	\N
242	5123	mitglied	TIEF	\N
171	5123	mitglied	TIEF	\N
251	4059	vorstand	MITTEL	\N
301	311	mitglied	TIEF	\N
261	311	mitglied	TIEF	\N
307	311	mitglied	TIEF	\N
40	179	vorstand	MITTEL	\N
11	940	vorstand	HOCH	\N
83	5435	vorstand	TIEF	\N
65	5446	beirat	TIEF	\N
223	5446	beirat	TIEF	\N
172	5447	beirat	TIEF	\N
159	1382	vorstand	TIEF	\N
159	5452	mitglied	TIEF	\N
161	2226	vorstand	TIEF	\N
161	3589	vorstand	TIEF	\N
161	4497	mitglied	TIEF	\N
278	868	beirat	TIEF	\N
302	5462	vorstand	HOCH	\N
293	5464	beirat	TIEF	\N
154	5464	beirat	TIEF	\N
321	5464	beirat	TIEF	\N
242	5472	vorstand	TIEF	\N
242	3574	beirat	MITTEL	\N
242	5475	vorstand	TIEF	\N
242	5476	vorstand	HOCH	\N
242	1146	taetig	TIEF	\N
242	2607	mitglied	TIEF	\N
185	5480	vorstand	TIEF	\N
185	5482	vorstand	TIEF	\N
185	446	vorstand	MITTEL	\N
185	1127	vorstand	TIEF	\N
185	1021	beirat	MITTEL	\N
185	1024	mitglied	TIEF	\N
185	1131	mitglied	TIEF	\N
185	3443	mitglied	TIEF	\N
185	3529	mitglied	TIEF	\N
185	5485	mitglied	TIEF	\N
185	5351	beirat	MITTEL	\N
14	127	beirat	TIEF	\N
14	5496	vorstand	TIEF	\N
304	3341	vorstand	MITTEL	\N
304	5497	vorstand	TIEF	\N
304	602	mitglied	TIEF	\N
304	580	mitglied	TIEF	\N
304	989	mitglied	TIEF	\N
304	576	mitglied	TIEF	\N
304	674	mitglied	TIEF	\N
304	141	mitglied	TIEF	\N
323	5514	gesellschafter	TIEF	\N
323	5516	vorstand	TIEF	\N
323	1349	vorstand	TIEF	\N
323	425	taetig	MITTEL	\N
250	766	vorstand	TIEF	\N
273	4931	vorstand	TIEF	\N
185	968	beirat	MITTEL	\N
210	5537	vorstand	TIEF	\N
210	5538	vorstand	TIEF	\N
315	5541	beirat	TIEF	\N
316	5541	beirat	TIEF	\N
285	5541	beirat	TIEF	\N
41	5549	vorstand	TIEF	\N
250	5549	vorstand	TIEF	\N
66	5559	geschaeftsfuehrend	HOCH	\N
275	5560	vorstand	TIEF	\N
275	5561	vorstand	MITTEL	\N
66	5562	mitglied	TIEF	\N
264	5601	vorstand	TIEF	\N
327	5619	vorstand	TIEF	\N
327	5620	geschaeftsfuehrend	TIEF	\N
327	5621	vorstand	TIEF	\N
327	104	vorstand	MITTEL	\N
327	3331	vorstand	MITTEL	\N
329	3440	vorstand	TIEF	\N
329	3478	vorstand	TIEF	\N
329	5631	vorstand	TIEF	\N
329	79	mitglied	TIEF	\N
329	602	mitglied	TIEF	\N
329	1065	mitglied	TIEF	\N
329	1061	mitglied	TIEF	\N
51	2227	vorstand	MITTEL	\N
51	5111	vorstand	MITTEL	\N
228	5120	beirat	TIEF	\N
219	5342	vorstand	MITTEL	\N
219	5648	beirat	TIEF	\N
88	5656	vorstand	MITTEL	\N
170	5659	vorstand	TIEF	\N
170	5660	vorstand	TIEF	\N
170	5661	vorstand	TIEF	\N
170	4383	vorstand	TIEF	\N
185	1681	vorstand	HOCH	\N
185	5683	beirat	MITTEL	\N
316	5709	beirat	TIEF	\N
285	5709	beirat	TIEF	\N
321	5709	beirat	TIEF	\N
125	5710	beirat	TIEF	\N
317	5545	beirat	TIEF	\N
171	5714	vorstand	HOCH	\N
250	5714	mitglied	TIEF	\N
328	5714	mitglied	TIEF	\N
106	5714	mitglied	TIEF	\N
285	5002	vorstand	TIEF	\N
285	1278	vorstand	TIEF	\N
285	1127	mitglied	TIEF	\N
297	5725	vorstand	TIEF	\N
65	1533	vorstand	TIEF	\N
261	5728	vorstand	TIEF	\N
330	5729	vorstand	TIEF	\N
40	2667	vorstand	TIEF	\N
40	1751	vorstand	TIEF	\N
40	98	vorstand	TIEF	\N
40	5730	beirat	TIEF	\N
40	2576	mitglied	TIEF	\N
40	1108	vorstand	MITTEL	\N
278	5732	vorstand	TIEF	\N
278	5742	beirat	MITTEL	\N
98	5742	beirat	MITTEL	\N
106	5742	beirat	MITTEL	\N
285	5742	beirat	MITTEL	\N
147	5743	vorstand	TIEF	\N
331	5749	vorstand	TIEF	\N
331	5751	vorstand	TIEF	\N
331	5753	vorstand	TIEF	\N
210	5756	beirat	TIEF	\N
278	5756	beirat	TIEF	\N
283	5757	vorstand	TIEF	\N
192	293	vorstand	HOCH	\N
192	3318	vorstand	TIEF	\N
192	1889	vorstand	TIEF	\N
317	5760	vorstand	TIEF	\N
317	5761	vorstand	HOCH	\N
317	5765	beirat	TIEF	\N
317	5766	vorstand	HOCH	\N
317	5768	vorstand	TIEF	\N
317	5770	vorstand	TIEF	\N
317	5771	vorstand	TIEF	\N
166	5772	vorstand	TIEF	\N
171	5775	vorstand	TIEF	\N
171	1201	beirat	MITTEL	\N
261	5788	vorstand	TIEF	\N
261	5789	vorstand	TIEF	\N
98	5795	mitglied	TIEF	\N
310	3976	vorstand	MITTEL	\N
310	778	beirat	MITTEL	\N
310	5798	vorstand	TIEF	\N
310	2832	vorstand	TIEF	\N
332	5803	vorstand	TIEF	\N
332	794	mitglied	TIEF	\N
334	884	vorstand	TIEF	\N
334	5662	vorstand	MITTEL	\N
334	5808	mitglied	TIEF	\N
334	3346	mitglied	TIEF	\N
334	602	mitglied	TIEF	\N
334	1342	mitglied	TIEF	\N
334	5806	mitglied	TIEF	\N
334	5811	mitglied	TIEF	\N
334	5812	mitglied	TIEF	\N
287	5819	geschaeftsfuehrend	TIEF	\N
321	1944	vorstand	TIEF	\N
321	759	vorstand	HOCH	\N
321	753	vorstand	TIEF	\N
318	753	vorstand	TIEF	\N
321	1201	beirat	MITTEL	\N
211	5823	vorstand	TIEF	\N
251	4856	beirat	MITTEL	\N
251	282	vorstand	MITTEL	\N
251	3574	beirat	MITTEL	\N
251	646	beirat	MITTEL	\N
251	5827	vorstand	TIEF	\N
211	5827	beirat	TIEF	\N
83	5827	beirat	TIEF	\N
251	5829	vorstand	TIEF	\N
309	5833	vorstand	MITTEL	\N
309	351	vorstand	MITTEL	\N
284	973	beirat	TIEF	\N
285	973	beirat	TIEF	\N
264	5840	vorstand	TIEF	\N
188	39	vorstand	MITTEL	\N
328	920	mitglied	TIEF	\N
319	5843	vorstand	TIEF	\N
319	5844	vorstand	MITTEL	\N
182	5845	geschaeftsfuehrend	TIEF	\N
182	1201	beirat	MITTEL	\N
182	2767	vorstand	MITTEL	\N
316	5859	vorstand	HOCH	\N
316	2177	vorstand	MITTEL	\N
316	5861	taetig	TIEF	\N
316	5862	vorstand	TIEF	\N
284	1347	vorstand	TIEF	\N
280	5865	vorstand	TIEF	\N
280	5866	vorstand	MITTEL	\N
89	5878	vorstand	MITTEL	\N
337	5885	vorstand	MITTEL	\N
337	681	vorstand	MITTEL	\N
337	5886	vorstand	TIEF	\N
337	5887	vorstand	TIEF	\N
337	5123	mitglied	TIEF	\N
337	3155	vorstand	HOCH	\N
337	5890	geschaeftsfuehrend	MITTEL	\N
337	5891	mitglied	TIEF	\N
337	5892	vorstand	TIEF	\N
337	5894	vorstand	TIEF	\N
337	3177	beirat	TIEF	\N
96	1447	vorstand	MITTEL	\N
53	637	vorstand	MITTEL	\N
65	5964	vorstand	TIEF	\N
304	5965	vorstand	TIEF	\N
83	5965	vorstand	TIEF	\N
318	5966	vorstand	TIEF	\N
11	577	vorstand	TIEF	\N
76	5977	vorstand	TIEF	\N
264	340	vorstand	HOCH	\N
63	5984	vorstand	TIEF	\N
63	2215	vorstand	MITTEL	\N
63	1856	vorstand	MITTEL	\N
219	577	vorstand	TIEF	\N
219	596	vorstand	HOCH	\N
219	657	vorstand	MITTEL	\N
277	4400	vorstand	MITTEL	\N
277	1201	beirat	MITTEL	\N
335	6016	vorstand	TIEF	\N
335	130	mitglied	TIEF	\N
51	6021	vorstand	TIEF	\N
63	45	vorstand	MITTEL	\N
76	6043	vorstand	TIEF	\N
83	6047	vorstand	TIEF	\N
89	6048	mitglied	TIEF	\N
89	778	beirat	MITTEL	\N
89	79	mitglied	TIEF	\N
89	6049	mitglied	TIEF	\N
89	6050	mitglied	TIEF	\N
96	6051	taetig	TIEF	\N
294	1533	mitglied	TIEF	\N
182	1533	mitglied	TIEF	\N
228	1533	mitglied	TIEF	\N
83	6062	vorstand	TIEF	\N
40	6062	beirat	TIEF	\N
289	6063	vorstand	MITTEL	\N
102	4785	vorstand	MITTEL	\N
314	6066	vorstand	TIEF	\N
297	1039	taetig	TIEF	\N
297	6067	vorstand	TIEF	\N
147	6068	vorstand	TIEF	\N
318	6068	vorstand	TIEF	\N
53	134	vorstand	MITTEL	\N
154	134	beirat	MITTEL	\N
65	4156	vorstand	HOCH	\N
315	122	beirat	TIEF	\N
304	2230	vorstand	TIEF	\N
168	6077	vorstand	TIEF	\N
167	6078	vorstand	TIEF	\N
167	6080	beirat	TIEF	\N
301	6080	beirat	TIEF	\N
298	800	mitglied	TIEF	\N
147	3956	vorstand	TIEF	\N
149	3845	vorstand	MITTEL	\N
149	6445	beirat	MITTEL	\N
228	6058	vorstand	TIEF	\N
228	5248	vorstand	MITTEL	\N
228	5404	vorstand	TIEF	\N
310	5404	vorstand	TIEF	\N
228	5304	vorstand	TIEF	\N
333	6104	beirat	MITTEL	\N
198	6105	geschaeftsfuehrend	TIEF	\N
293	216	vorstand	HOCH	\N
83	643	vorstand	TIEF	\N
301	6176	beirat	TIEF	\N
328	4086	vorstand	MITTEL	\N
337	4086	vorstand	MITTEL	\N
312	517	vorstand	MITTEL	\N
312	6195	vorstand	MITTEL	\N
312	6196	mitglied	TIEF	\N
312	6197	mitglied	TIEF	\N
312	6198	mitglied	TIEF	\N
278	6213	vorstand	TIEF	\N
188	893	vorstand	TIEF	\N
188	6217	vorstand	TIEF	\N
302	5232	vorstand	TIEF	\N
340	6229	vorstand	TIEF	\N
340	6234	geschaeftsfuehrend	TIEF	\N
340	2652	mitglied	TIEF	\N
340	6239	vorstand	TIEF	\N
341	6280	vorstand	TIEF	\N
341	6281	vorstand	TIEF	\N
341	6282	vorstand	TIEF	\N
161	6284	vorstand	TIEF	\N
161	4286	vorstand	HOCH	\N
11	1344	beirat	TIEF	\N
316	1344	beirat	TIEF	\N
149	1344	beirat	TIEF	\N
166	6288	vorstand	TIEF	\N
166	6290	vorstand	HOCH	\N
120	4155	vorstand	HOCH	\N
120	8	vorstand	HOCH	\N
278	6046	beirat	TIEF	\N
278	5933	vorstand	HOCH	\N
53	6251	vorstand	MITTEL	\N
40	6286	beirat	TIEF	\N
40	6298	beirat	MITTEL	\N
271	283	vorstand	TIEF	\N
289	6339	vorstand	TIEF	\N
153	6340	vorstand	TIEF	\N
11	6345	vorstand	HOCH	\N
334	580	vorstand	HOCH	\N
305	474	vorstand	MITTEL	\N
120	1203	vorstand	HOCH	\N
120	336	vorstand	MITTEL	\N
283	6350	gesellschafter	TIEF	\N
101	6351	vorstand	TIEF	\N
309	440	vorstand	MITTEL	\N
317	118	mitglied	TIEF	\N
343	6360	gesellschafter	TIEF	\N
343	700	taetig	TIEF	\N
343	6361	vorstand	TIEF	\N
343	3582	vorstand	TIEF	\N
345	6365	vorstand	TIEF	\N
345	1873	vorstand	MITTEL	\N
283	6371	vorstand	TIEF	\N
102	5224	beirat	MITTEL	\N
280	124	vorstand	MITTEL	\N
280	402	beirat	MITTEL	\N
106	6391	vorstand	MITTEL	\N
315	923	mitglied	TIEF	\N
315	2547	vorstand	MITTEL	\N
315	6411	vorstand	TIEF	\N
41	6414	mitglied	TIEF	\N
41	6415	mitglied	TIEF	\N
41	6416	mitglied	TIEF	\N
41	6417	mitglied	TIEF	\N
41	1609	mitglied	TIEF	\N
41	6418	mitglied	TIEF	\N
41	6419	mitglied	TIEF	\N
41	6420	mitglied	TIEF	\N
41	2409	mitglied	TIEF	\N
41	6421	mitglied	TIEF	\N
41	892	mitglied	TIEF	\N
41	6422	mitglied	TIEF	\N
41	6423	mitglied	TIEF	\N
41	6424	mitglied	TIEF	\N
41	1896	mitglied	TIEF	\N
41	446	mitglied	TIEF	\N
41	6147	mitglied	TIEF	\N
41	4027	mitglied	TIEF	\N
41	3574	beirat	MITTEL	\N
79	3574	beirat	MITTEL	\N
277	4609	vorstand	MITTEL	\N
317	6439	mitglied	TIEF	\N
317	477	mitglied	TIEF	\N
317	980	mitglied	TIEF	\N
317	6440	mitglied	TIEF	\N
317	6442	mitglied	TIEF	\N
317	6443	mitglied	TIEF	\N
317	4613	mitglied	TIEF	\N
317	6444	mitglied	TIEF	\N
264	778	beirat	MITTEL	\N
264	79	vorstand	HOCH	\N
264	4286	mitglied	TIEF	\N
293	6450	vorstand	HOCH	\N
53	6470	vorstand	TIEF	\N
188	6490	beirat	TIEF	\N
304	6492	mitglied	TIEF	\N
98	6493	vorstand	HOCH	\N
339	1065	mitglied	TIEF	\N
339	2814	mitglied	TIEF	\N
339	5008	mitglied	TIEF	\N
198	6494	vorstand	TIEF	\N
323	5513	vorstand	TIEF	\N
323	3280	beirat	MITTEL	\N
44	6507	vorstand	TIEF	\N
88	4972	vorstand	MITTEL	\N
280	1365	vorstand	MITTEL	\N
280	6510	vorstand	TIEF	\N
125	5078	vorstand	TIEF	\N
125	6514	vorstand	TIEF	\N
144	287	mitglied	TIEF	\N
144	1368	mitglied	TIEF	\N
144	3844	mitglied	TIEF	\N
144	6516	mitglied	TIEF	\N
335	6241	vorstand	HOCH	\N
296	6517	beirat	TIEF	\N
153	6518	beirat	TIEF	\N
297	6519	vorstand	TIEF	\N
289	6371	vorstand	TIEF	\N
170	6527	vorstand	TIEF	\N
170	6528	vorstand	TIEF	\N
210	6535	vorstand	MITTEL	\N
250	3930	beirat	MITTEL	\N
21	1519	vorstand	HOCH	\N
21	6546	vorstand	MITTEL	\N
21	145	mitglied	TIEF	\N
21	6547	mitglied	TIEF	\N
21	6548	mitglied	TIEF	\N
168	1660	vorstand	TIEF	\N
302	127	beirat	TIEF	\N
287	6562	beirat	TIEF	\N
296	6562	beirat	TIEF	\N
65	6562	beirat	TIEF	\N
66	6562	beirat	TIEF	\N
172	6562	beirat	TIEF	\N
210	6562	beirat	TIEF	\N
302	6563	vorstand	HOCH	\N
302	6564	beirat	MITTEL	\N
302	437	vorstand	MITTEL	\N
242	6567	vorstand	HOCH	\N
242	5712	vorstand	HOCH	\N
310	6309	vorstand	TIEF	\N
310	3368	vorstand	TIEF	\N
310	2226	vorstand	TIEF	\N
310	6572	vorstand	TIEF	\N
310	6215	vorstand	TIEF	\N
310	5359	vorstand	MITTEL	\N
14	2094	vorstand	TIEF	\N
14	4923	taetig	MITTEL	\N
14	6576	taetig	TIEF	\N
14	6577	vorstand	TIEF	\N
211	6580	vorstand	TIEF	\N
211	6581	beirat	TIEF	\N
172	6589	mitglied	TIEF	\N
172	6591	vorstand	TIEF	\N
116	2728	geschaeftsfuehrend	TIEF	\N
314	2248	vorstand	HOCH	\N
314	542	vorstand	HOCH	\N
314	1017	vorstand	TIEF	\N
83	5388	vorstand	MITTEL	\N
83	604	vorstand	MITTEL	\N
337	2980	vorstand	MITTEL	\N
100	2343	vorstand	MITTEL	\N
100	3962	vorstand	TIEF	\N
271	1158	taetig	MITTEL	\N
271	3330	taetig	TIEF	\N
271	6606	vorstand	TIEF	\N
271	6607	taetig	TIEF	\N
102	3973	vorstand	TIEF	\N
63	6062	beirat	TIEF	\N
314	6062	beirat	TIEF	\N
315	6609	vorstand	MITTEL	\N
315	6610	mitglied	TIEF	\N
318	2124	vorstand	TIEF	\N
40	6611	vorstand	TIEF	\N
106	6611	vorstand	TIEF	\N
171	6611	vorstand	TIEF	\N
210	6611	vorstand	TIEF	\N
65	6621	vorstand	MITTEL	\N
329	347	mitglied	TIEF	\N
334	347	vorstand	MITTEL	\N
219	6630	mitglied	TIEF	\N
210	759	vorstand	MITTEL	\N
110	6638	mitglied	TIEF	\N
314	5451	vorstand	MITTEL	\N
21	6639	vorstand	TIEF	\N
21	6641	vorstand	TIEF	\N
331	6652	taetig	TIEF	\N
198	6653	mitglied	TIEF	\N
198	6654	mitglied	TIEF	\N
198	71	mitglied	TIEF	\N
198	5617	mitglied	TIEF	\N
198	6655	vorstand	MITTEL	\N
304	43	vorstand	MITTEL	\N
331	6656	taetig	TIEF	\N
301	2203	taetig	MITTEL	\N
248	6657	vorstand	TIEF	\N
248	6661	vorstand	TIEF	\N
49	6662	mitglied	TIEF	\N
310	6663	beirat	TIEF	\N
310	1351	mitglied	TIEF	\N
41	6668	vorstand	TIEF	\N
41	6667	vorstand	TIEF	\N
41	6669	mitglied	TIEF	\N
340	2478	vorstand	MITTEL	\N
346	6670	vorstand	TIEF	\N
346	6675	vorstand	TIEF	\N
346	6676	vorstand	TIEF	\N
348	6295	taetig	TIEF	\N
348	6160	vorstand	MITTEL	\N
348	6679	vorstand	TIEF	\N
349	581	vorstand	MITTEL	\N
349	6680	vorstand	TIEF	\N
102	6437	vorstand	TIEF	\N
337	6437	vorstand	TIEF	\N
317	6438	mitglied	TIEF	\N
380	6154	taetig	MITTEL	\N
368	6806	mitglied	TIEF	\N
354	6705	vorstand	TIEF	\N
228	244	vorstand	HOCH	\N
354	130	mitglied	TIEF	\N
355	340	vorstand	HOCH	\N
355	6707	vorstand	TIEF	\N
354	6708	mitglied	TIEF	\N
355	6709	vorstand	TIEF	\N
354	674	mitglied	TIEF	\N
354	1063	mitglied	TIEF	\N
354	604	mitglied	TIEF	\N
354	602	mitglied	TIEF	\N
354	265	mitglied	TIEF	\N
354	580	mitglied	TIEF	\N
354	3568	mitglied	TIEF	\N
355	6710	vorstand	TIEF	\N
354	1797	mitglied	TIEF	\N
354	5501	mitglied	TIEF	\N
354	2810	mitglied	TIEF	\N
355	6711	vorstand	TIEF	\N
355	1406	vorstand	MITTEL	\N
355	6012	vorstand	TIEF	\N
355	6715	beirat	TIEF	\N
355	5679	vorstand	MITTEL	\N
275	6717	vorstand	TIEF	\N
333	6659	vorstand	TIEF	\N
251	453	vorstand	MITTEL	\N
356	2549	gesellschafter	TIEF	\N
356	6718	geschaeftsfuehrend	TIEF	\N
356	6719	mitglied	TIEF	\N
356	4123	vorstand	TIEF	\N
356	6720	mitglied	TIEF	\N
356	4124	mitglied	TIEF	\N
356	6721	mitglied	TIEF	\N
357	6106	vorstand	TIEF	\N
357	6722	vorstand	TIEF	\N
357	2666	vorstand	TIEF	\N
357	279	vorstand	MITTEL	\N
358	6727	geschaeftsfuehrend	TIEF	\N
354	6713	mitglied	TIEF	\N
354	6728	mitglied	TIEF	\N
354	5419	mitglied	TIEF	\N
354	6729	mitglied	TIEF	\N
354	6730	mitglied	TIEF	\N
315	6731	vorstand	TIEF	\N
315	6732	vorstand	MITTEL	\N
273	3114	mitglied	TIEF	\N
354	5194	mitglied	TIEF	\N
354	6734	mitglied	TIEF	\N
354	6735	mitglied	TIEF	\N
354	6737	mitglied	TIEF	\N
354	6738	mitglied	TIEF	\N
354	6739	mitglied	TIEF	\N
354	6740	mitglied	TIEF	\N
354	6741	mitglied	TIEF	\N
360	3759	geschaeftsfuehrend	TIEF	\N
360	6754	mitglied	TIEF	\N
360	3864	geschaeftsfuehrend	TIEF	\N
360	6755	gesellschafter	TIEF	\N
361	6756	taetig	TIEF	\N
361	6757	vorstand	TIEF	\N
361	6759	taetig	TIEF	\N
361	1976	mitglied	TIEF	\N
361	6761	mitglied	TIEF	\N
361	4543	mitglied	TIEF	\N
361	6762	mitglied	TIEF	\N
361	6763	mitglied	TIEF	\N
361	5933	mitglied	TIEF	\N
361	6764	mitglied	TIEF	\N
363	6782	vorstand	TIEF	\N
363	6770	vorstand	TIEF	\N
363	6771	vorstand	TIEF	\N
363	6772	vorstand	TIEF	\N
363	6773	vorstand	TIEF	\N
364	5207	vorstand	HOCH	\N
364	6775	vorstand	TIEF	\N
363	6783	vorstand	TIEF	\N
366	1098	taetig	MITTEL	\N
366	5041	vorstand	MITTEL	\N
367	34	geschaeftsfuehrend	HOCH	\N
367	179	mitglied	TIEF	\N
367	1063	mitglied	TIEF	\N
367	6784	mitglied	TIEF	\N
367	6785	mitglied	TIEF	\N
367	6786	mitglied	TIEF	\N
367	6787	mitglied	TIEF	\N
369	6788	vorstand	TIEF	\N
369	2227	vorstand	MITTEL	\N
369	6790	taetig	TIEF	\N
370	6791	vorstand	TIEF	\N
370	6793	vorstand	TIEF	\N
371	6792	vorstand	TIEF	\N
371	1122	vorstand	MITTEL	\N
371	6794	vorstand	TIEF	\N
371	6797	vorstand	TIEF	\N
368	6798	geschaeftsfuehrend	TIEF	\N
368	877	taetig	MITTEL	\N
368	363	mitglied	TIEF	\N
368	6799	mitglied	TIEF	\N
368	6800	mitglied	TIEF	\N
368	6802	mitglied	TIEF	\N
368	6805	mitglied	TIEF	\N
368	6807	vorstand	TIEF	\N
368	6808	taetig	TIEF	\N
373	6809	vorstand	TIEF	\N
373	1153	vorstand	TIEF	\N
373	2791	vorstand	TIEF	\N
373	2812	vorstand	HOCH	\N
373	6810	taetig	MITTEL	\N
373	6812	vorstand	TIEF	\N
374	6816	vorstand	MITTEL	\N
376	6828	mitglied	TIEF	\N
378	1380	vorstand	HOCH	\N
378	6831	vorstand	TIEF	\N
379	6832	vorstand	TIEF	\N
379	6834	beirat	TIEF	\N
380	6836	vorstand	TIEF	\N
380	6837	vorstand	TIEF	\N
380	6838	gesellschafter	TIEF	\N
380	6839	vorstand	HOCH	\N
380	6840	vorstand	TIEF	\N
380	6841	vorstand	TIEF	\N
380	6843	vorstand	TIEF	\N
371	6851	vorstand	TIEF	\N
371	6852	beirat	MITTEL	\N
371	6713	beirat	MITTEL	\N
383	425	taetig	MITTEL	\N
383	6856	vorstand	TIEF	\N
383	6858	gesellschafter	TIEF	\N
382	1471	vorstand	TIEF	\N
382	4647	vorstand	TIEF	\N
354	6703	vorstand	TIEF	\N
40	4241	beirat	MITTEL	\N
354	5199	mitglied	TIEF	\N
387	6875	vorstand	TIEF	\N
387	6876	vorstand	TIEF	\N
387	6879	vorstand	TIEF	\N
387	6880	geschaeftsfuehrend	TIEF	\N
387	6881	vorstand	TIEF	\N
387	6882	taetig	TIEF	\N
387	5169	vorstand	TIEF	\N
387	6884	gesellschafter	TIEF	\N
387	6886	vorstand	TIEF	\N
387	6887	gesellschafter	TIEF	\N
387	5626	mitglied	TIEF	\N
387	920	vorstand	TIEF	\N
387	6888	mitglied	TIEF	\N
387	6889	vorstand	TIEF	\N
387	6890	mitglied	TIEF	\N
389	3503	taetig	TIEF	\N
389	347	vorstand	MITTEL	\N
390	6891	vorstand	MITTEL	\N
390	6892	vorstand	TIEF	\N
390	6893	mitglied	TIEF	\N
390	6895	mitglied	TIEF	\N
390	6896	mitglied	TIEF	\N
390	6898	vorstand	TIEF	\N
390	6899	beirat	TIEF	\N
110	6542	vorstand	TIEF	\N
390	6903	vorstand	TIEF	\N
391	2714	vorstand	MITTEL	\N
391	6904	vorstand	TIEF	\N
391	6905	vorstand	TIEF	\N
391	6906	vorstand	TIEF	\N
391	504	vorstand	MITTEL	\N
391	6910	vorstand	TIEF	\N
392	126	vorstand	TIEF	\N
393	4961	geschaeftsfuehrend	TIEF	\N
393	6914	vorstand	TIEF	\N
393	6917	vorstand	TIEF	\N
394	3872	vorstand	TIEF	\N
394	6919	taetig	TIEF	\N
394	6921	vorstand	TIEF	\N
395	6923	vorstand	TIEF	\N
396	1380	beirat	MITTEL	\N
398	7144	taetig	TIEF	\N
398	6938	vorstand	TIEF	\N
398	6941	mitglied	TIEF	\N
398	347	vorstand	MITTEL	\N
399	6942	taetig	TIEF	\N
399	2652	mitglied	TIEF	\N
399	1035	mitglied	TIEF	\N
400	6945	vorstand	TIEF	\N
400	6946	vorstand	TIEF	\N
418	6949	vorstand	TIEF	\N
418	6950	vorstand	TIEF	\N
418	6951	vorstand	TIEF	\N
418	6952	vorstand	TIEF	\N
418	4475	vorstand	TIEF	\N
416	6954	vorstand	MITTEL	\N
416	6955	taetig	TIEF	\N
404	6956	taetig	TIEF	\N
404	1568	vorstand	TIEF	\N
404	6959	vorstand	TIEF	\N
404	2744	vorstand	MITTEL	\N
404	6960	mitglied	TIEF	\N
415	2285	vorstand	TIEF	\N
415	6967	vorstand	TIEF	\N
415	6969	vorstand	TIEF	\N
415	3114	mitglied	TIEF	\N
415	6970	mitglied	TIEF	\N
415	6972	mitglied	TIEF	\N
415	6973	mitglied	TIEF	\N
415	6974	mitglied	TIEF	\N
415	6975	mitglied	TIEF	\N
415	6249	mitglied	TIEF	\N
415	6976	mitglied	TIEF	\N
415	576	mitglied	TIEF	\N
415	6977	mitglied	TIEF	\N
415	980	mitglied	TIEF	\N
415	2800	mitglied	TIEF	\N
415	6978	mitglied	TIEF	\N
415	1344	mitglied	TIEF	\N
415	446	mitglied	TIEF	\N
415	6980	mitglied	TIEF	\N
415	6981	mitglied	TIEF	\N
415	6982	mitglied	TIEF	\N
403	6984	vorstand	TIEF	\N
403	6985	taetig	TIEF	\N
403	6983	vorstand	TIEF	\N
403	6991	beirat	TIEF	\N
411	130	vorstand	MITTEL	\N
411	6992	vorstand	TIEF	\N
411	36	vorstand	MITTEL	\N
411	6993	vorstand	TIEF	\N
411	6996	vorstand	TIEF	\N
411	6997	vorstand	TIEF	\N
411	6998	vorstand	TIEF	\N
411	6999	vorstand	TIEF	\N
411	7000	mitglied	TIEF	\N
353	3351	vorstand	TIEF	\N
44	2731	vorstand	TIEF	\N
277	4639	vorstand	MITTEL	\N
424	581	vorstand	MITTEL	\N
424	7012	vorstand	MITTEL	\N
424	5663	vorstand	MITTEL	\N
424	7015	vorstand	TIEF	\N
424	7017	mitglied	TIEF	\N
424	7019	taetig	TIEF	\N
419	7021	vorstand	TIEF	\N
419	7022	mitglied	TIEF	\N
405	7029	vorstand	TIEF	\N
405	517	vorstand	HOCH	\N
405	7030	vorstand	TIEF	\N
419	7031	vorstand	TIEF	\N
414	7037	vorstand	MITTEL	\N
414	7038	vorstand	TIEF	\N
414	7040	mitglied	TIEF	\N
414	7044	gesellschafter	TIEF	\N
414	7047	vorstand	TIEF	\N
421	7052	taetig	TIEF	\N
272	7053	vorstand	TIEF	\N
341	7054	vorstand	TIEF	\N
280	7055	vorstand	TIEF	\N
280	3183	vorstand	TIEF	\N
88	7056	vorstand	TIEF	\N
327	7058	taetig	TIEF	\N
317	2060	vorstand	TIEF	\N
154	1703	vorstand	HOCH	\N
299	7060	vorstand	TIEF	\N
301	7062	vorstand	TIEF	\N
410	1660	vorstand	TIEF	\N
410	7072	vorstand	TIEF	\N
422	7075	vorstand	TIEF	\N
422	7076	vorstand	TIEF	\N
410	7084	vorstand	TIEF	\N
386	6872	mitglied	TIEF	\N
386	6873	mitglied	TIEF	\N
387	6874	geschaeftsfuehrend	TIEF	\N
406	6861	vorstand	MITTEL	\N
420	580	vorstand	HOCH	\N
417	7103	vorstand	TIEF	\N
417	7104	vorstand	TIEF	\N
417	7105	vorstand	TIEF	\N
417	2839	vorstand	MITTEL	\N
417	7106	vorstand	TIEF	\N
417	7107	mitglied	TIEF	\N
347	130	mitglied	TIEF	\N
275	6445	beirat	MITTEL	\N
79	2432	mitglied	TIEF	\N
327	7128	vorstand	TIEF	\N
210	3701	vorstand	MITTEL	\N
210	244	vorstand	MITTEL	\N
347	7129	mitglied	TIEF	\N
371	179	mitglied	TIEF	\N
371	580	mitglied	TIEF	\N
371	989	mitglied	TIEF	\N
399	2476	mitglied	TIEF	\N
363	7135	vorstand	TIEF	\N
361	7138	mitglied	TIEF	\N
416	5648	beirat	TIEF	\N
381	7142	vorstand	TIEF	\N
390	7160	vorstand	TIEF	\N
418	7162	vorstand	MITTEL	\N
418	3560	vorstand	MITTEL	\N
421	6939	vorstand	TIEF	\N
394	7163	vorstand	TIEF	\N
394	7164	vorstand	TIEF	\N
318	28	beirat	MITTEL	\N
386	3914	vorstand	TIEF	\N
386	7205	vorstand	TIEF	\N
386	980	mitglied	TIEF	\N
386	6931	mitglied	TIEF	\N
386	7206	mitglied	TIEF	\N
386	7207	mitglied	TIEF	\N
386	7208	mitglied	TIEF	\N
386	7209	mitglied	TIEF	\N
386	7211	mitglied	TIEF	\N
386	7212	mitglied	TIEF	\N
386	7213	mitglied	TIEF	\N
386	7214	mitglied	TIEF	\N
386	7215	mitglied	TIEF	\N
386	7217	mitglied	TIEF	\N
368	7283	vorstand	TIEF	\N
389	7284	taetig	TIEF	\N
376	7285	vorstand	TIEF	\N
376	7286	vorstand	TIEF	\N
376	7287	mitglied	TIEF	\N
353	7288	taetig	TIEF	\N
387	7289	vorstand	TIEF	\N
347	381	vorstand	MITTEL	\N
398	178	vorstand	TIEF	\N
400	154	beirat	MITTEL	\N
301	6904	vorstand	TIEF	\N
301	7231	vorstand	TIEF	\N
393	5683	beirat	MITTEL	\N
353	3177	beirat	TIEF	\N
361	7366	beirat	TIEF	\N
21	7368	vorstand	MITTEL	\N
391	3573	vorstand	TIEF	\N
167	7382	vorstand	MITTEL	\N
321	7382	vorstand	HOCH	\N
319	7382	vorstand	HOCH	\N
323	580	vorstand	MITTEL	\N
289	2415	vorstand	MITTEL	\N
275	6528	vorstand	TIEF	\N
51	6445	beirat	MITTEL	\N
425	7402	vorstand	MITTEL	\N
425	7404	vorstand	MITTEL	\N
425	1924	vorstand	TIEF	\N
425	7405	vorstand	TIEF	\N
425	4111	vorstand	MITTEL	\N
317	7439	mitglied	TIEF	\N
63	1935	vorstand	MITTEL	\N
392	669	vorstand	MITTEL	\N
333	669	vorstand	MITTEL	\N
321	135	beirat	TIEF	\N
321	1846	vorstand	HOCH	\N
116	3155	mitglied	TIEF	\N
116	1377	mitglied	TIEF	\N
116	682	mitglied	TIEF	\N
402	7446	mitglied	TIEF	\N
116	7448	mitglied	TIEF	\N
116	7449	mitglied	TIEF	\N
398	1194	vorstand	TIEF	\N
171	1194	vorstand	TIEF	\N
400	1194	vorstand	TIEF	\N
333	2442	vorstand	MITTEL	\N
331	579	vorstand	HOCH	\N
369	7516	vorstand	TIEF	\N
369	7517	beirat	TIEF	\N
420	7540	vorstand	HOCH	\N
63	7543	vorstand	TIEF	\N
388	7573	beirat	MITTEL	\N
340	874	vorstand	TIEF	\N
340	1541	vorstand	TIEF	\N
340	7577	vorstand	MITTEL	\N
273	7578	vorstand	TIEF	\N
369	4871	beirat	MITTEL	\N
389	2367	vorstand	TIEF	\N
278	7581	vorstand	TIEF	\N
316	402	vorstand	HOCH	\N
328	892	vorstand	MITTEL	\N
328	7582	vorstand	TIEF	\N
314	1402	vorstand	TIEF	\N
402	2215	vorstand	MITTEL	\N
331	2219	vorstand	MITTEL	\N
416	7584	vorstand	MITTEL	\N
418	1124	vorstand	MITTEL	\N
418	7585	vorstand	TIEF	\N
418	1390	vorstand	MITTEL	\N
345	7586	vorstand	MITTEL	\N
345	7587	vorstand	TIEF	\N
378	5224	vorstand	HOCH	\N
345	2531	vorstand	MITTEL	\N
345	7590	vorstand	TIEF	\N
159	269	vorstand	HOCH	\N
261	5189	mitglied	TIEF	\N
40	5189	mitglied	TIEF	\N
373	5189	mitglied	TIEF	\N
275	5189	mitglied	TIEF	\N
389	5189	mitglied	TIEF	\N
280	5189	mitglied	TIEF	\N
347	5189	mitglied	TIEF	\N
381	5189	mitglied	TIEF	\N
102	5189	mitglied	TIEF	\N
110	5189	mitglied	TIEF	\N
382	5189	mitglied	TIEF	\N
125	5189	mitglied	TIEF	\N
357	5189	mitglied	TIEF	\N
310	1365	vorstand	MITTEL	\N
321	752	vorstand	HOCH	\N
406	2152	vorstand	TIEF	\N
96	4983	mitglied	TIEF	\N
98	4983	mitglied	TIEF	\N
110	4983	mitglied	TIEF	\N
396	4983	mitglied	TIEF	\N
398	4983	mitglied	TIEF	\N
351	4983	mitglied	TIEF	\N
144	4983	mitglied	TIEF	\N
296	4983	mitglied	TIEF	\N
153	4983	mitglied	TIEF	\N
297	4983	mitglied	TIEF	\N
159	4983	mitglied	TIEF	\N
168	4983	mitglied	TIEF	\N
411	4983	mitglied	TIEF	\N
171	4983	mitglied	TIEF	\N
416	4983	mitglied	TIEF	\N
304	4983	mitglied	TIEF	\N
370	4983	mitglied	TIEF	\N
211	4983	mitglied	TIEF	\N
381	4983	mitglied	TIEF	\N
227	4983	mitglied	TIEF	\N
317	4983	mitglied	TIEF	\N
125	4983	mitglied	TIEF	\N
318	4983	mitglied	TIEF	\N
192	4983	mitglied	TIEF	\N
373	1278	vorstand	TIEF	\N
261	1278	mitglied	TIEF	\N
40	1278	mitglied	TIEF	\N
44	1278	mitglied	TIEF	\N
368	1278	mitglied	TIEF	\N
388	1278	mitglied	TIEF	\N
390	1278	mitglied	TIEF	\N
310	1278	mitglied	TIEF	\N
102	7594	vorstand	TIEF	\N
14	7594	vorstand	TIEF	\N
357	7594	vorstand	TIEF	\N
40	7594	mitglied	TIEF	\N
371	7594	mitglied	TIEF	\N
264	7594	mitglied	TIEF	\N
53	7594	mitglied	TIEF	\N
63	7594	mitglied	TIEF	\N
65	7594	mitglied	TIEF	\N
388	7594	mitglied	TIEF	\N
389	7594	mitglied	TIEF	\N
280	7594	mitglied	TIEF	\N
83	7594	mitglied	TIEF	\N
381	7594	mitglied	TIEF	\N
227	7594	mitglied	TIEF	\N
374	7594	mitglied	TIEF	\N
327	7594	mitglied	TIEF	\N
391	7594	mitglied	TIEF	\N
110	7594	mitglied	TIEF	\N
228	7594	mitglied	TIEF	\N
382	7594	mitglied	TIEF	\N
125	7594	mitglied	TIEF	\N
402	7594	mitglied	TIEF	\N
351	7594	mitglied	TIEF	\N
296	7594	mitglied	TIEF	\N
367	7594	mitglied	TIEF	\N
153	7594	mitglied	TIEF	\N
154	7594	mitglied	TIEF	\N
159	7594	mitglied	TIEF	\N
333	7594	mitglied	TIEF	\N
168	7594	mitglied	TIEF	\N
410	7594	mitglied	TIEF	\N
411	7594	mitglied	TIEF	\N
171	7594	mitglied	TIEF	\N
178	7594	mitglied	TIEF	\N
331	7594	mitglied	TIEF	\N
416	7594	mitglied	TIEF	\N
346	7594	mitglied	TIEF	\N
304	7594	mitglied	TIEF	\N
192	7594	mitglied	TIEF	\N
384	7594	mitglied	TIEF	\N
361	7594	mitglied	TIEF	\N
335	7594	mitglied	TIEF	\N
310	7594	mitglied	TIEF	\N
386	7594	mitglied	TIEF	\N
211	7594	mitglied	TIEF	\N
354	7594	mitglied	TIEF	\N
345	7594	mitglied	TIEF	\N
331	7595	vorstand	TIEF	\N
340	7595	mitglied	TIEF	\N
424	7595	mitglied	TIEF	\N
65	7595	mitglied	TIEF	\N
383	7595	mitglied	TIEF	\N
399	7595	mitglied	TIEF	\N
337	7595	mitglied	TIEF	\N
404	7595	mitglied	TIEF	\N
367	7595	mitglied	TIEF	\N
299	7595	mitglied	TIEF	\N
171	7595	mitglied	TIEF	\N
319	7595	mitglied	TIEF	\N
335	7595	mitglied	TIEF	\N
40	2020	mitglied	TIEF	\N
355	2020	mitglied	TIEF	\N
340	2020	mitglied	TIEF	\N
63	2020	mitglied	TIEF	\N
65	2020	mitglied	TIEF	\N
66	2020	mitglied	TIEF	\N
383	2020	mitglied	TIEF	\N
316	2020	mitglied	TIEF	\N
76	2020	mitglied	TIEF	\N
88	2020	mitglied	TIEF	\N
89	2020	mitglied	TIEF	\N
356	2020	mitglied	TIEF	\N
374	2020	mitglied	TIEF	\N
381	2020	mitglied	TIEF	\N
106	2020	mitglied	TIEF	\N
391	2020	mitglied	TIEF	\N
402	2020	mitglied	TIEF	\N
399	2020	mitglied	TIEF	\N
405	2020	mitglied	TIEF	\N
294	2020	mitglied	TIEF	\N
153	2020	mitglied	TIEF	\N
333	2020	mitglied	TIEF	\N
378	2020	mitglied	TIEF	\N
414	2020	mitglied	TIEF	\N
178	2020	mitglied	TIEF	\N
331	2020	mitglied	TIEF	\N
379	2020	mitglied	TIEF	\N
242	2020	mitglied	TIEF	\N
384	2020	mitglied	TIEF	\N
419	2020	mitglied	TIEF	\N
321	2020	mitglied	TIEF	\N
352	2020	mitglied	TIEF	\N
380	2020	mitglied	TIEF	\N
154	2111	vorstand	TIEF	\N
328	2111	vorstand	TIEF	\N
40	2111	mitglied	TIEF	\N
424	2111	mitglied	TIEF	\N
83	4983	mitglied	TIEF	\N
88	4983	mitglied	TIEF	\N
89	4983	mitglied	TIEF	\N
415	2111	mitglied	TIEF	\N
416	2111	mitglied	TIEF	\N
379	2111	mitglied	TIEF	\N
418	2111	mitglied	TIEF	\N
384	2111	mitglied	TIEF	\N
310	2111	mitglied	TIEF	\N
345	2111	mitglied	TIEF	\N
53	6354	mitglied	TIEF	\N
340	6354	mitglied	TIEF	\N
275	6354	mitglied	TIEF	\N
388	6354	mitglied	TIEF	\N
330	6354	mitglied	TIEF	\N
390	6354	mitglied	TIEF	\N
223	6354	mitglied	TIEF	\N
316	6354	mitglied	TIEF	\N
76	6354	mitglied	TIEF	\N
88	6354	mitglied	TIEF	\N
89	6354	mitglied	TIEF	\N
284	6354	mitglied	TIEF	\N
102	6354	mitglied	TIEF	\N
348	6354	mitglied	TIEF	\N
396	6354	mitglied	TIEF	\N
228	6354	mitglied	TIEF	\N
317	6354	mitglied	TIEF	\N
11	6354	mitglied	TIEF	\N
120	6354	mitglied	TIEF	\N
337	6354	mitglied	TIEF	\N
14	6354	mitglied	TIEF	\N
294	6354	mitglied	TIEF	\N
149	6354	mitglied	TIEF	\N
333	6354	mitglied	TIEF	\N
299	6354	mitglied	TIEF	\N
414	6354	mitglied	TIEF	\N
178	6354	mitglied	TIEF	\N
331	6354	mitglied	TIEF	\N
188	6354	mitglied	TIEF	\N
384	6354	mitglied	TIEF	\N
306	6354	mitglied	TIEF	\N
421	6354	mitglied	TIEF	\N
40	2124	mitglied	TIEF	\N
368	2124	mitglied	TIEF	\N
355	2124	mitglied	TIEF	\N
53	2124	mitglied	TIEF	\N
60	2124	mitglied	TIEF	\N
63	2124	mitglied	TIEF	\N
369	2124	mitglied	TIEF	\N
383	2124	mitglied	TIEF	\N
388	2124	mitglied	TIEF	\N
6	2124	mitglied	TIEF	\N
392	2124	mitglied	TIEF	\N
390	2124	mitglied	TIEF	\N
316	2124	mitglied	TIEF	\N
393	2124	mitglied	TIEF	\N
83	2124	mitglied	TIEF	\N
89	2124	mitglied	TIEF	\N
381	2124	mitglied	TIEF	\N
227	2124	mitglied	TIEF	\N
102	2124	mitglied	TIEF	\N
328	2124	mitglied	TIEF	\N
228	2124	mitglied	TIEF	\N
317	2124	mitglied	TIEF	\N
382	2124	mitglied	TIEF	\N
314	2124	mitglied	TIEF	\N
125	2124	mitglied	TIEF	\N
402	2124	mitglied	TIEF	\N
329	2124	mitglied	TIEF	\N
337	2124	mitglied	TIEF	\N
406	2124	mitglied	TIEF	\N
293	2124	mitglied	TIEF	\N
357	2124	mitglied	TIEF	\N
296	2124	mitglied	TIEF	\N
400	2124	mitglied	TIEF	\N
332	2124	mitglied	TIEF	\N
149	2124	mitglied	TIEF	\N
154	2124	mitglied	TIEF	\N
333	2124	mitglied	TIEF	\N
166	2124	mitglied	TIEF	\N
168	2124	mitglied	TIEF	\N
411	2124	mitglied	TIEF	\N
178	2124	mitglied	TIEF	\N
331	2124	mitglied	TIEF	\N
417	2124	mitglied	TIEF	\N
302	2124	mitglied	TIEF	\N
418	2124	mitglied	TIEF	\N
21	2124	mitglied	TIEF	\N
188	2124	mitglied	TIEF	\N
353	2124	mitglied	TIEF	\N
192	2124	mitglied	TIEF	\N
251	2124	mitglied	TIEF	\N
210	2124	mitglied	TIEF	\N
321	2124	mitglied	TIEF	\N
345	2124	mitglied	TIEF	\N
327	637	vorstand	MITTEL	\N
40	637	mitglied	TIEF	\N
371	637	mitglied	TIEF	\N
355	637	mitglied	TIEF	\N
49	637	mitglied	TIEF	\N
358	637	mitglied	TIEF	\N
51	637	mitglied	TIEF	\N
424	637	mitglied	TIEF	\N
63	637	mitglied	TIEF	\N
383	637	mitglied	TIEF	\N
392	637	mitglied	TIEF	\N
76	637	mitglied	TIEF	\N
280	637	mitglied	TIEF	\N
83	637	mitglied	TIEF	\N
88	637	mitglied	TIEF	\N
89	637	mitglied	TIEF	\N
376	637	mitglied	TIEF	\N
96	637	mitglied	TIEF	\N
98	637	mitglied	TIEF	\N
102	637	mitglied	TIEF	\N
106	637	mitglied	TIEF	\N
110	637	mitglied	TIEF	\N
343	637	mitglied	TIEF	\N
228	637	mitglied	TIEF	\N
314	637	mitglied	TIEF	\N
403	637	mitglied	TIEF	\N
144	637	mitglied	TIEF	\N
367	637	mitglied	TIEF	\N
147	637	mitglied	TIEF	\N
154	637	mitglied	TIEF	\N
161	637	mitglied	TIEF	\N
333	637	mitglied	TIEF	\N
299	637	mitglied	TIEF	\N
411	637	mitglied	TIEF	\N
378	637	mitglied	TIEF	\N
415	637	mitglied	TIEF	\N
178	637	mitglied	TIEF	\N
346	637	mitglied	TIEF	\N
400	2111	mitglied	TIEF	\N
149	2111	mitglied	TIEF	\N
411	2111	mitglied	TIEF	\N
178	7596	mitglied	TIEF	\N
331	7596	mitglied	TIEF	\N
305	7596	mitglied	TIEF	\N
345	7596	mitglied	TIEF	\N
40	1750	mitglied	TIEF	\N
44	1750	mitglied	TIEF	\N
264	1750	mitglied	TIEF	\N
53	1750	mitglied	TIEF	\N
219	1750	mitglied	TIEF	\N
270	1750	mitglied	TIEF	\N
63	1750	mitglied	TIEF	\N
65	1750	mitglied	TIEF	\N
388	1750	mitglied	TIEF	\N
392	1750	mitglied	TIEF	\N
277	1750	mitglied	TIEF	\N
315	1750	mitglied	TIEF	\N
223	1750	mitglied	TIEF	\N
316	1750	mitglied	TIEF	\N
280	1750	mitglied	TIEF	\N
89	1750	mitglied	TIEF	\N
227	1750	mitglied	TIEF	\N
284	1750	mitglied	TIEF	\N
102	1750	mitglied	TIEF	\N
348	1750	mitglied	TIEF	\N
327	1750	mitglied	TIEF	\N
228	1750	mitglied	TIEF	\N
382	1750	mitglied	TIEF	\N
289	1750	mitglied	TIEF	\N
125	1750	mitglied	TIEF	\N
337	1750	mitglied	TIEF	\N
14	1750	mitglied	TIEF	\N
406	1750	mitglied	TIEF	\N
293	1750	mitglied	TIEF	\N
144	1750	mitglied	TIEF	\N
367	1750	mitglied	TIEF	\N
147	1750	mitglied	TIEF	\N
318	1750	mitglied	TIEF	\N
153	1750	mitglied	TIEF	\N
154	1750	mitglied	TIEF	\N
297	1750	mitglied	TIEF	\N
333	1750	mitglied	TIEF	\N
378	1750	mitglied	TIEF	\N
415	1750	mitglied	TIEF	\N
182	1750	mitglied	TIEF	\N
346	1750	mitglied	TIEF	\N
188	1750	mitglied	TIEF	\N
304	1750	mitglied	TIEF	\N
198	1750	mitglied	TIEF	\N
421	1750	mitglied	TIEF	\N
251	1750	mitglied	TIEF	\N
321	1750	mitglied	TIEF	\N
363	1750	mitglied	TIEF	\N
345	1750	mitglied	TIEF	\N
261	5204	mitglied	TIEF	\N
53	5204	mitglied	TIEF	\N
373	5204	mitglied	TIEF	\N
65	5204	mitglied	TIEF	\N
389	5204	mitglied	TIEF	\N
6	5204	mitglied	TIEF	\N
315	5204	mitglied	TIEF	\N
278	5204	mitglied	TIEF	\N
316	5204	mitglied	TIEF	\N
347	5204	mitglied	TIEF	\N
381	5204	mitglied	TIEF	\N
227	5204	mitglied	TIEF	\N
102	5204	mitglied	TIEF	\N
110	5204	mitglied	TIEF	\N
317	5204	mitglied	TIEF	\N
402	5204	mitglied	TIEF	\N
296	5204	mitglied	TIEF	\N
333	5204	mitglied	TIEF	\N
411	5204	mitglied	TIEF	\N
414	5204	mitglied	TIEF	\N
415	5204	mitglied	TIEF	\N
331	5204	mitglied	TIEF	\N
416	5204	mitglied	TIEF	\N
182	5204	mitglied	TIEF	\N
353	5204	mitglied	TIEF	\N
361	5204	mitglied	TIEF	\N
335	5204	mitglied	TIEF	\N
386	5204	mitglied	TIEF	\N
345	5204	mitglied	TIEF	\N
361	1454	vorstand	TIEF	\N
418	1454	vorstand	TIEF	\N
371	1454	mitglied	TIEF	\N
40	1454	mitglied	TIEF	\N
51	1454	mitglied	TIEF	\N
388	1454	mitglied	TIEF	\N
390	1454	mitglied	TIEF	\N
392	1454	mitglied	TIEF	\N
83	1454	mitglied	TIEF	\N
96	1454	mitglied	TIEF	\N
101	1454	mitglied	TIEF	\N
348	1454	mitglied	TIEF	\N
106	1454	mitglied	TIEF	\N
337	1454	mitglied	TIEF	\N
357	1454	mitglied	TIEF	\N
147	1454	mitglied	TIEF	\N
318	1454	mitglied	TIEF	\N
159	1454	mitglied	TIEF	\N
378	1454	mitglied	TIEF	\N
346	1454	mitglied	TIEF	\N
353	1454	mitglied	TIEF	\N
310	1454	mitglied	TIEF	\N
272	2226	mitglied	TIEF	\N
327	2226	mitglied	TIEF	\N
343	2226	mitglied	TIEF	\N
14	2226	mitglied	TIEF	\N
331	2226	mitglied	TIEF	\N
40	1774	mitglied	TIEF	\N
371	1774	mitglied	TIEF	\N
368	1774	mitglied	TIEF	\N
348	1774	mitglied	TIEF	\N
106	1774	mitglied	TIEF	\N
125	1774	mitglied	TIEF	\N
293	1774	mitglied	TIEF	\N
144	1774	mitglied	TIEF	\N
353	1774	mitglied	TIEF	\N
420	1774	mitglied	TIEF	\N
370	1774	mitglied	TIEF	\N
361	1774	mitglied	TIEF	\N
210	1774	mitglied	TIEF	\N
335	1774	mitglied	TIEF	\N
211	1774	mitglied	TIEF	\N
331	2229	mitglied	TIEF	\N
307	2229	mitglied	TIEF	\N
210	2229	mitglied	TIEF	\N
314	3589	vorstand	TIEF	\N
355	3589	mitglied	TIEF	\N
369	3589	mitglied	TIEF	\N
272	7596	mitglied	TIEF	\N
76	7596	mitglied	TIEF	\N
171	7596	mitglied	TIEF	\N
83	1761	mitglied	TIEF	\N
356	1761	mitglied	TIEF	\N
381	1761	mitglied	TIEF	\N
98	1761	mitglied	TIEF	\N
348	1761	mitglied	TIEF	\N
402	1761	mitglied	TIEF	\N
154	1761	mitglied	TIEF	\N
333	1761	mitglied	TIEF	\N
168	1761	mitglied	TIEF	\N
418	1761	mitglied	TIEF	\N
353	1761	mitglied	TIEF	\N
420	1761	mitglied	TIEF	\N
361	1761	mitglied	TIEF	\N
261	4976	mitglied	TIEF	\N
355	4976	mitglied	TIEF	\N
89	4976	mitglied	TIEF	\N
343	4976	mitglied	TIEF	\N
403	4976	mitglied	TIEF	\N
332	4976	mitglied	TIEF	\N
304	4976	mitglied	TIEF	\N
192	4976	mitglied	TIEF	\N
421	4976	mitglied	TIEF	\N
422	4976	mitglied	TIEF	\N
40	1505	mitglied	TIEF	\N
49	1505	mitglied	TIEF	\N
355	1505	mitglied	TIEF	\N
51	1505	mitglied	TIEF	\N
53	1505	mitglied	TIEF	\N
219	1505	mitglied	TIEF	\N
63	1505	mitglied	TIEF	\N
65	1505	mitglied	TIEF	\N
66	1505	mitglied	TIEF	\N
383	1505	mitglied	TIEF	\N
392	1505	mitglied	TIEF	\N
278	1505	mitglied	TIEF	\N
83	1505	mitglied	TIEF	\N
76	1505	mitglied	TIEF	\N
280	1505	mitglied	TIEF	\N
96	1505	mitglied	TIEF	\N
106	1505	mitglied	TIEF	\N
314	1505	mitglied	TIEF	\N
125	1505	mitglied	TIEF	\N
144	1505	mitglied	TIEF	\N
147	1505	mitglied	TIEF	\N
318	1505	mitglied	TIEF	\N
159	1505	mitglied	TIEF	\N
161	1505	mitglied	TIEF	\N
178	1505	mitglied	TIEF	\N
416	1505	mitglied	TIEF	\N
346	1505	mitglied	TIEF	\N
370	1505	mitglied	TIEF	\N
198	1505	mitglied	TIEF	\N
210	1505	mitglied	TIEF	\N
363	1505	mitglied	TIEF	\N
337	640	vorstand	TIEF	\N
261	640	mitglied	TIEF	\N
40	640	mitglied	TIEF	\N
316	640	mitglied	TIEF	\N
280	640	mitglied	TIEF	\N
83	640	mitglied	TIEF	\N
381	640	mitglied	TIEF	\N
227	640	mitglied	TIEF	\N
106	640	mitglied	TIEF	\N
110	640	mitglied	TIEF	\N
228	640	mitglied	TIEF	\N
382	640	mitglied	TIEF	\N
125	640	mitglied	TIEF	\N
402	640	mitglied	TIEF	\N
405	640	mitglied	TIEF	\N
144	640	mitglied	TIEF	\N
367	640	mitglied	TIEF	\N
333	640	mitglied	TIEF	\N
378	640	mitglied	TIEF	\N
178	640	mitglied	TIEF	\N
335	640	mitglied	TIEF	\N
60	2676	mitglied	TIEF	\N
98	2676	mitglied	TIEF	\N
14	2676	mitglied	TIEF	\N
161	2676	mitglied	TIEF	\N
167	2676	mitglied	TIEF	\N
168	2676	mitglied	TIEF	\N
188	2676	mitglied	TIEF	\N
198	2676	mitglied	TIEF	\N
210	2676	mitglied	TIEF	\N
211	2676	mitglied	TIEF	\N
355	2491	mitglied	TIEF	\N
273	2491	mitglied	TIEF	\N
223	2491	mitglied	TIEF	\N
83	2491	mitglied	TIEF	\N
299	2491	mitglied	TIEF	\N
190	2491	mitglied	TIEF	\N
310	2491	mitglied	TIEF	\N
357	4247	vorstand	TIEF	\N
355	4247	mitglied	TIEF	\N
53	4247	mitglied	TIEF	\N
369	4247	mitglied	TIEF	\N
280	4247	mitglied	TIEF	\N
89	4247	mitglied	TIEF	\N
347	4247	mitglied	TIEF	\N
381	4247	mitglied	TIEF	\N
102	4247	mitglied	TIEF	\N
348	4247	mitglied	TIEF	\N
110	4247	mitglied	TIEF	\N
382	4247	mitglied	TIEF	\N
329	4247	mitglied	TIEF	\N
339	4247	mitglied	TIEF	\N
293	4247	mitglied	TIEF	\N
144	4247	mitglied	TIEF	\N
296	4247	mitglied	TIEF	\N
367	4247	mitglied	TIEF	\N
147	4247	mitglied	TIEF	\N
154	4247	mitglied	TIEF	\N
41	5728	mitglied	TIEF	\N
340	5728	mitglied	TIEF	\N
60	5728	mitglied	TIEF	\N
270	5728	mitglied	TIEF	\N
275	5728	mitglied	TIEF	\N
315	5728	mitglied	TIEF	\N
278	5728	mitglied	TIEF	\N
341	5728	mitglied	TIEF	\N
283	5728	mitglied	TIEF	\N
287	5728	mitglied	TIEF	\N
289	5728	mitglied	TIEF	\N
298	5728	mitglied	TIEF	\N
299	5728	mitglied	TIEF	\N
170	5728	mitglied	TIEF	\N
171	5728	mitglied	TIEF	\N
172	5728	mitglied	TIEF	\N
319	5728	mitglied	TIEF	\N
306	5728	mitglied	TIEF	\N
368	1761	mitglied	TIEF	\N
65	1761	mitglied	TIEF	\N
278	1761	mitglied	TIEF	\N
63	7597	mitglied	TIEF	\N
98	7597	mitglied	TIEF	\N
110	7597	mitglied	TIEF	\N
154	7597	mitglied	TIEF	\N
411	7597	mitglied	TIEF	\N
416	7597	mitglied	TIEF	\N
368	5334	mitglied	TIEF	\N
355	5334	mitglied	TIEF	\N
280	5334	mitglied	TIEF	\N
381	5334	mitglied	TIEF	\N
102	5334	mitglied	TIEF	\N
110	5334	mitglied	TIEF	\N
382	5334	mitglied	TIEF	\N
296	5334	mitglied	TIEF	\N
168	5334	mitglied	TIEF	\N
188	5334	mitglied	TIEF	\N
192	5334	mitglied	TIEF	\N
6	7598	vorstand	TIEF	\N
285	7598	mitglied	TIEF	\N
402	7598	mitglied	TIEF	\N
192	7598	mitglied	TIEF	\N
406	1852	vorstand	TIEF	\N
301	1852	vorstand	TIEF	\N
421	1852	vorstand	TIEF	\N
210	1852	vorstand	TIEF	\N
40	1852	mitglied	TIEF	\N
355	1852	mitglied	TIEF	\N
53	1852	mitglied	TIEF	\N
388	1852	mitglied	TIEF	\N
395	1852	mitglied	TIEF	\N
106	1852	mitglied	TIEF	\N
11	1852	mitglied	TIEF	\N
398	1852	mitglied	TIEF	\N
357	1852	mitglied	TIEF	\N
285	459	vorstand	TIEF	\N
21	459	vorstand	TIEF	\N
51	459	mitglied	TIEF	\N
340	459	mitglied	TIEF	\N
270	459	mitglied	TIEF	\N
6	459	mitglied	TIEF	\N
277	459	mitglied	TIEF	\N
223	459	mitglied	TIEF	\N
316	459	mitglied	TIEF	\N
393	459	mitglied	TIEF	\N
76	459	mitglied	TIEF	\N
83	459	mitglied	TIEF	\N
227	459	mitglied	TIEF	\N
284	459	mitglied	TIEF	\N
110	459	mitglied	TIEF	\N
228	459	mitglied	TIEF	\N
317	459	mitglied	TIEF	\N
125	459	mitglied	TIEF	\N
402	459	mitglied	TIEF	\N
318	459	mitglied	TIEF	\N
149	459	mitglied	TIEF	\N
414	459	mitglied	TIEF	\N
178	459	mitglied	TIEF	\N
242	459	mitglied	TIEF	\N
188	459	mitglied	TIEF	\N
366	459	mitglied	TIEF	\N
374	5151	vorstand	TIEF	\N
40	5151	mitglied	TIEF	\N
60	5151	mitglied	TIEF	\N
66	5151	mitglied	TIEF	\N
275	5151	mitglied	TIEF	\N
315	5151	mitglied	TIEF	\N
393	5151	mitglied	TIEF	\N
101	5151	mitglied	TIEF	\N
294	5151	mitglied	TIEF	\N
159	5151	mitglied	TIEF	\N
168	5151	mitglied	TIEF	\N
378	5151	mitglied	TIEF	\N
170	5151	mitglied	TIEF	\N
171	5151	mitglied	TIEF	\N
242	5151	mitglied	TIEF	\N
192	5151	mitglied	TIEF	\N
310	5151	mitglied	TIEF	\N
211	5151	mitglied	TIEF	\N
11	2127	vorstand	TIEF	\N
6	2127	mitglied	TIEF	\N
388	2828	mitglied	TIEF	\N
316	2828	mitglied	TIEF	\N
381	2828	mitglied	TIEF	\N
337	2828	mitglied	TIEF	\N
144	2828	mitglied	TIEF	\N
296	2828	mitglied	TIEF	\N
332	2828	mitglied	TIEF	\N
154	2828	mitglied	TIEF	\N
410	2828	mitglied	TIEF	\N
411	2828	mitglied	TIEF	\N
331	2828	mitglied	TIEF	\N
416	2828	mitglied	TIEF	\N
102	6068	vorstand	TIEF	\N
331	6068	vorstand	TIEF	\N
40	6068	mitglied	TIEF	\N
53	6068	mitglied	TIEF	\N
373	6068	mitglied	TIEF	\N
63	6068	mitglied	TIEF	\N
275	6068	mitglied	TIEF	\N
316	6068	mitglied	TIEF	\N
280	6068	mitglied	TIEF	\N
381	6068	mitglied	TIEF	\N
98	6068	mitglied	TIEF	\N
348	6068	mitglied	TIEF	\N
144	6068	mitglied	TIEF	\N
355	4959	mitglied	TIEF	\N
340	4959	mitglied	TIEF	\N
63	4959	mitglied	TIEF	\N
65	4959	mitglied	TIEF	\N
383	4959	mitglied	TIEF	\N
381	4959	mitglied	TIEF	\N
227	4959	mitglied	TIEF	\N
98	4959	mitglied	TIEF	\N
11	4959	mitglied	TIEF	\N
402	4959	mitglied	TIEF	\N
406	4959	mitglied	TIEF	\N
144	4959	mitglied	TIEF	\N
296	4959	mitglied	TIEF	\N
149	4959	mitglied	TIEF	\N
154	4959	mitglied	TIEF	\N
331	4959	mitglied	TIEF	\N
417	4959	mitglied	TIEF	\N
418	4959	mitglied	TIEF	\N
192	4959	mitglied	TIEF	\N
384	4959	mitglied	TIEF	\N
422	4959	mitglied	TIEF	\N
384	1851	mitglied	TIEF	\N
83	7597	vorstand	TIEF	\N
40	7597	mitglied	TIEF	\N
406	1623	mitglied	TIEF	\N
297	1623	mitglied	TIEF	\N
299	1623	mitglied	TIEF	\N
168	1623	mitglied	TIEF	\N
410	1623	mitglied	TIEF	\N
331	1623	mitglied	TIEF	\N
417	1623	mitglied	TIEF	\N
192	1623	mitglied	TIEF	\N
421	1623	mitglied	TIEF	\N
310	1623	mitglied	TIEF	\N
40	1858	mitglied	TIEF	\N
371	1858	mitglied	TIEF	\N
53	1858	mitglied	TIEF	\N
60	1858	mitglied	TIEF	\N
65	1858	mitglied	TIEF	\N
388	1858	mitglied	TIEF	\N
76	1858	mitglied	TIEF	\N
83	1858	mitglied	TIEF	\N
89	1858	mitglied	TIEF	\N
96	1858	mitglied	TIEF	\N
98	1858	mitglied	TIEF	\N
102	1858	mitglied	TIEF	\N
110	1858	mitglied	TIEF	\N
382	1858	mitglied	TIEF	\N
125	1858	mitglied	TIEF	\N
293	1858	mitglied	TIEF	\N
144	1858	mitglied	TIEF	\N
357	1858	mitglied	TIEF	\N
367	1858	mitglied	TIEF	\N
147	1858	mitglied	TIEF	\N
318	1858	mitglied	TIEF	\N
166	1858	mitglied	TIEF	\N
167	1858	mitglied	TIEF	\N
410	1858	mitglied	TIEF	\N
416	1858	mitglied	TIEF	\N
302	1858	mitglied	TIEF	\N
188	1858	mitglied	TIEF	\N
192	1858	mitglied	TIEF	\N
380	1858	mitglied	TIEF	\N
89	4111	mitglied	TIEF	\N
349	524	vorstand	TIEF	\N
371	524	mitglied	TIEF	\N
264	524	mitglied	TIEF	\N
340	524	mitglied	TIEF	\N
388	524	mitglied	TIEF	\N
83	524	mitglied	TIEF	\N
89	524	mitglied	TIEF	\N
102	524	mitglied	TIEF	\N
382	524	mitglied	TIEF	\N
403	524	mitglied	TIEF	\N
406	524	mitglied	TIEF	\N
144	524	mitglied	TIEF	\N
357	524	mitglied	TIEF	\N
296	524	mitglied	TIEF	\N
367	524	mitglied	TIEF	\N
154	524	mitglied	TIEF	\N
159	524	mitglied	TIEF	\N
418	524	mitglied	TIEF	\N
370	524	mitglied	TIEF	\N
334	524	mitglied	TIEF	\N
198	524	mitglied	TIEF	\N
40	5964	mitglied	TIEF	\N
264	5964	mitglied	TIEF	\N
49	5964	mitglied	TIEF	\N
51	5964	mitglied	TIEF	\N
424	5964	mitglied	TIEF	\N
63	5964	mitglied	TIEF	\N
383	5964	mitglied	TIEF	\N
388	5964	mitglied	TIEF	\N
315	5964	mitglied	TIEF	\N
223	5964	mitglied	TIEF	\N
316	5964	mitglied	TIEF	\N
76	5964	mitglied	TIEF	\N
83	5964	mitglied	TIEF	\N
89	5964	mitglied	TIEF	\N
227	5964	mitglied	TIEF	\N
374	5964	mitglied	TIEF	\N
102	5964	mitglied	TIEF	\N
327	5964	mitglied	TIEF	\N
110	5964	mitglied	TIEF	\N
228	5964	mitglied	TIEF	\N
394	5964	mitglied	TIEF	\N
11	5964	mitglied	TIEF	\N
120	5964	mitglied	TIEF	\N
402	5964	mitglied	TIEF	\N
403	5964	mitglied	TIEF	\N
337	5964	mitglied	TIEF	\N
14	5964	mitglied	TIEF	\N
404	5964	mitglied	TIEF	\N
293	5964	mitglied	TIEF	\N
294	5964	mitglied	TIEF	\N
153	5964	mitglied	TIEF	\N
154	5964	mitglied	TIEF	\N
166	5964	mitglied	TIEF	\N
378	5964	mitglied	TIEF	\N
171	5964	mitglied	TIEF	\N
172	5964	mitglied	TIEF	\N
319	5964	mitglied	TIEF	\N
178	5964	mitglied	TIEF	\N
302	5964	mitglied	TIEF	\N
242	5964	mitglied	TIEF	\N
21	5964	mitglied	TIEF	\N
188	5964	mitglied	TIEF	\N
192	5964	mitglied	TIEF	\N
420	5964	mitglied	TIEF	\N
210	5964	mitglied	TIEF	\N
310	5964	mitglied	TIEF	\N
386	5964	mitglied	TIEF	\N
345	5964	mitglied	TIEF	\N
424	5965	mitglied	TIEF	\N
383	5965	mitglied	TIEF	\N
388	5965	mitglied	TIEF	\N
314	5965	mitglied	TIEF	\N
125	5965	mitglied	TIEF	\N
144	5965	mitglied	TIEF	\N
154	5965	mitglied	TIEF	\N
349	5965	mitglied	TIEF	\N
361	5965	mitglied	TIEF	\N
273	2677	vorstand	TIEF	\N
337	2677	vorstand	TIEF	\N
321	2677	mitglied	TIEF	\N
374	2855	vorstand	TIEF	\N
261	2855	mitglied	TIEF	\N
40	2855	mitglied	TIEF	\N
340	2855	mitglied	TIEF	\N
63	2855	mitglied	TIEF	\N
275	2855	mitglied	TIEF	\N
388	2855	mitglied	TIEF	\N
389	2855	mitglied	TIEF	\N
393	2855	mitglied	TIEF	\N
398	1623	mitglied	TIEF	\N
402	1623	mitglied	TIEF	\N
404	1623	mitglied	TIEF	\N
345	2855	mitglied	TIEF	\N
310	3318	vorstand	TIEF	\N
264	3318	mitglied	TIEF	\N
388	3318	mitglied	TIEF	\N
280	3318	mitglied	TIEF	\N
83	3318	mitglied	TIEF	\N
88	3318	mitglied	TIEF	\N
89	3318	mitglied	TIEF	\N
381	3318	mitglied	TIEF	\N
398	3318	mitglied	TIEF	\N
402	3318	mitglied	TIEF	\N
329	3318	mitglied	TIEF	\N
339	3318	mitglied	TIEF	\N
144	3318	mitglied	TIEF	\N
296	3318	mitglied	TIEF	\N
367	3318	mitglied	TIEF	\N
332	3318	mitglied	TIEF	\N
154	3318	mitglied	TIEF	\N
410	3318	mitglied	TIEF	\N
411	3318	mitglied	TIEF	\N
416	3318	mitglied	TIEF	\N
421	3318	mitglied	TIEF	\N
335	3318	mitglied	TIEF	\N
211	3318	mitglied	TIEF	\N
304	7599	vorstand	TIEF	\N
361	7599	vorstand	TIEF	\N
364	7599	mitglied	TIEF	\N
89	7599	mitglied	TIEF	\N
110	7599	mitglied	TIEF	\N
329	7599	mitglied	TIEF	\N
293	7599	mitglied	TIEF	\N
296	7599	mitglied	TIEF	\N
416	7599	mitglied	TIEF	\N
211	7599	mitglied	TIEF	\N
366	7599	mitglied	TIEF	\N
83	5840	vorstand	TIEF	\N
368	5840	mitglied	TIEF	\N
388	5840	mitglied	TIEF	\N
280	5840	mitglied	TIEF	\N
89	5840	mitglied	TIEF	\N
347	5840	mitglied	TIEF	\N
327	5840	mitglied	TIEF	\N
382	5840	mitglied	TIEF	\N
125	5840	mitglied	TIEF	\N
144	5840	mitglied	TIEF	\N
192	5840	mitglied	TIEF	\N
373	6213	mitglied	TIEF	\N
312	6213	mitglied	TIEF	\N
404	6213	mitglied	TIEF	\N
284	6213	mitglied	TIEF	\N
227	6213	mitglied	TIEF	\N
318	6213	mitglied	TIEF	\N
402	6213	mitglied	TIEF	\N
321	6213	mitglied	TIEF	\N
40	886	mitglied	TIEF	\N
340	886	mitglied	TIEF	\N
63	886	mitglied	TIEF	\N
66	886	mitglied	TIEF	\N
316	886	mitglied	TIEF	\N
83	886	mitglied	TIEF	\N
227	886	mitglied	TIEF	\N
98	886	mitglied	TIEF	\N
102	886	mitglied	TIEF	\N
228	886	mitglied	TIEF	\N
125	886	mitglied	TIEF	\N
337	886	mitglied	TIEF	\N
14	886	mitglied	TIEF	\N
367	886	mitglied	TIEF	\N
333	886	mitglied	TIEF	\N
384	886	mitglied	TIEF	\N
335	886	mitglied	TIEF	\N
211	886	mitglied	TIEF	\N
321	886	mitglied	TIEF	\N
89	5548	mitglied	TIEF	\N
381	5291	vorstand	TIEF	\N
386	5291	vorstand	TIEF	\N
6	5291	mitglied	TIEF	\N
316	5291	mitglied	TIEF	\N
280	5291	mitglied	TIEF	\N
88	5291	mitglied	TIEF	\N
317	5291	mitglied	TIEF	\N
331	5291	mitglied	TIEF	\N
251	5291	mitglied	TIEF	\N
319	2415	vorstand	MITTEL	\N
261	2415	mitglied	TIEF	\N
40	2415	mitglied	TIEF	\N
41	2415	mitglied	TIEF	\N
51	2415	mitglied	TIEF	\N
364	2415	mitglied	TIEF	\N
219	2415	mitglied	TIEF	\N
6	2415	mitglied	TIEF	\N
392	2415	mitglied	TIEF	\N
76	2415	mitglied	TIEF	\N
83	2415	mitglied	TIEF	\N
96	2415	mitglied	TIEF	\N
101	2415	mitglied	TIEF	\N
228	2415	mitglied	TIEF	\N
317	2415	mitglied	TIEF	\N
337	2415	mitglied	TIEF	\N
318	2415	mitglied	TIEF	\N
154	2415	mitglied	TIEF	\N
167	2415	mitglied	TIEF	\N
168	2415	mitglied	TIEF	\N
172	2415	mitglied	TIEF	\N
21	2415	mitglied	TIEF	\N
190	2415	mitglied	TIEF	\N
304	2415	mitglied	TIEF	\N
192	2415	mitglied	TIEF	\N
306	2415	mitglied	TIEF	\N
198	2415	mitglied	TIEF	\N
210	2415	mitglied	TIEF	\N
335	2415	mitglied	TIEF	\N
310	2415	mitglied	TIEF	\N
44	5966	mitglied	TIEF	\N
79	5966	mitglied	TIEF	\N
227	5966	mitglied	TIEF	\N
11	5966	mitglied	TIEF	\N
402	5966	mitglied	TIEF	\N
14	5966	mitglied	TIEF	\N
147	5966	mitglied	TIEF	\N
21	5966	mitglied	TIEF	\N
102	577	vorstand	TIEF	\N
110	577	vorstand	TIEF	\N
40	577	mitglied	TIEF	\N
65	577	mitglied	TIEF	\N
275	577	mitglied	TIEF	\N
14	577	mitglied	TIEF	\N
154	577	mitglied	TIEF	\N
219	5348	mitglied	TIEF	\N
384	2855	mitglied	TIEF	\N
335	2855	mitglied	TIEF	\N
310	2855	mitglied	TIEF	\N
211	2416	mitglied	TIEF	\N
364	3176	mitglied	TIEF	\N
388	3176	mitglied	TIEF	\N
390	3176	mitglied	TIEF	\N
316	3176	mitglied	TIEF	\N
393	3176	mitglied	TIEF	\N
280	3176	mitglied	TIEF	\N
83	3176	mitglied	TIEF	\N
89	3176	mitglied	TIEF	\N
98	3176	mitglied	TIEF	\N
125	3176	mitglied	TIEF	\N
144	3176	mitglied	TIEF	\N
357	3176	mitglied	TIEF	\N
332	3176	mitglied	TIEF	\N
154	3176	mitglied	TIEF	\N
411	3176	mitglied	TIEF	\N
416	3176	mitglied	TIEF	\N
418	3176	mitglied	TIEF	\N
304	3176	mitglied	TIEF	\N
310	3176	mitglied	TIEF	\N
211	3176	mitglied	TIEF	\N
40	4958	mitglied	TIEF	\N
355	4958	mitglied	TIEF	\N
53	4958	mitglied	TIEF	\N
383	4958	mitglied	TIEF	\N
389	4958	mitglied	TIEF	\N
392	4958	mitglied	TIEF	\N
393	4958	mitglied	TIEF	\N
76	4958	mitglied	TIEF	\N
83	4958	mitglied	TIEF	\N
89	4958	mitglied	TIEF	\N
374	4958	mitglied	TIEF	\N
106	4958	mitglied	TIEF	\N
125	4958	mitglied	TIEF	\N
402	4958	mitglied	TIEF	\N
399	4958	mitglied	TIEF	\N
337	4958	mitglied	TIEF	\N
14	4958	mitglied	TIEF	\N
406	4958	mitglied	TIEF	\N
357	4958	mitglied	TIEF	\N
154	4958	mitglied	TIEF	\N
333	4958	mitglied	TIEF	\N
178	4958	mitglied	TIEF	\N
305	2793	vorstand	TIEF	\N
125	2793	vorstand	TIEF	\N
40	2793	mitglied	TIEF	\N
368	2793	mitglied	TIEF	\N
373	2793	mitglied	TIEF	\N
340	2793	mitglied	TIEF	\N
60	2793	mitglied	TIEF	\N
65	2793	mitglied	TIEF	\N
6	2793	mitglied	TIEF	\N
76	2793	mitglied	TIEF	\N
79	2793	mitglied	TIEF	\N
83	2793	mitglied	TIEF	\N
89	2793	mitglied	TIEF	\N
347	2793	mitglied	TIEF	\N
102	2793	mitglied	TIEF	\N
106	2793	mitglied	TIEF	\N
328	2793	mitglied	TIEF	\N
394	2793	mitglied	TIEF	\N
382	2793	mitglied	TIEF	\N
314	2793	mitglied	TIEF	\N
402	2793	mitglied	TIEF	\N
367	2793	mitglied	TIEF	\N
153	2793	mitglied	TIEF	\N
333	2793	mitglied	TIEF	\N
168	2793	mitglied	TIEF	\N
411	2793	mitglied	TIEF	\N
415	2793	mitglied	TIEF	\N
416	2793	mitglied	TIEF	\N
21	2793	mitglied	TIEF	\N
192	2793	mitglied	TIEF	\N
307	2793	mitglied	TIEF	\N
309	2793	mitglied	TIEF	\N
335	2793	mitglied	TIEF	\N
210	2793	mitglied	TIEF	\N
211	2793	mitglied	TIEF	\N
321	2793	mitglied	TIEF	\N
366	2793	mitglied	TIEF	\N
312	2793	mitglied	TIEF	\N
381	5024	vorstand	TIEF	\N
40	5024	mitglied	TIEF	\N
355	5024	mitglied	TIEF	\N
340	5024	mitglied	TIEF	\N
219	5024	mitglied	TIEF	\N
63	5024	mitglied	TIEF	\N
65	5024	mitglied	TIEF	\N
66	5024	mitglied	TIEF	\N
388	5024	mitglied	TIEF	\N
6	5024	mitglied	TIEF	\N
76	5024	mitglied	TIEF	\N
280	5024	mitglied	TIEF	\N
347	5024	mitglied	TIEF	\N
98	5024	mitglied	TIEF	\N
102	5024	mitglied	TIEF	\N
228	5024	mitglied	TIEF	\N
317	5024	mitglied	TIEF	\N
314	5024	mitglied	TIEF	\N
125	5024	mitglied	TIEF	\N
14	5024	mitglied	TIEF	\N
144	5024	mitglied	TIEF	\N
296	5024	mitglied	TIEF	\N
147	5024	mitglied	TIEF	\N
153	5024	mitglied	TIEF	\N
299	5024	mitglied	TIEF	\N
166	5024	mitglied	TIEF	\N
168	5024	mitglied	TIEF	\N
319	5024	mitglied	TIEF	\N
346	5024	mitglied	TIEF	\N
242	5024	mitglied	TIEF	\N
188	5024	mitglied	TIEF	\N
304	5024	mitglied	TIEF	\N
353	5024	mitglied	TIEF	\N
192	5024	mitglied	TIEF	\N
422	5024	mitglied	TIEF	\N
310	5024	mitglied	TIEF	\N
382	2892	vorstand	TIEF	\N
378	2892	vorstand	TIEF	\N
410	890	vorstand	TIEF	\N
297	890	vorstand	TIEF	\N
40	890	mitglied	TIEF	\N
53	890	mitglied	TIEF	\N
388	890	mitglied	TIEF	\N
393	890	mitglied	TIEF	\N
280	890	mitglied	TIEF	\N
83	890	mitglied	TIEF	\N
89	890	mitglied	TIEF	\N
347	890	mitglied	TIEF	\N
98	890	mitglied	TIEF	\N
331	2416	mitglied	TIEF	\N
416	2416	mitglied	TIEF	\N
335	2416	mitglied	TIEF	\N
335	890	mitglied	TIEF	\N
386	890	mitglied	TIEF	\N
211	890	mitglied	TIEF	\N
366	890	mitglied	TIEF	\N
182	6135	vorstand	TIEF	\N
316	6135	vorstand	TIEF	\N
227	6135	vorstand	TIEF	\N
21	6135	vorstand	TIEF	\N
356	6135	vorstand	TIEF	\N
261	1751	mitglied	TIEF	\N
44	1751	mitglied	TIEF	\N
49	1751	mitglied	TIEF	\N
51	1751	mitglied	TIEF	\N
53	1751	mitglied	TIEF	\N
340	1751	mitglied	TIEF	\N
60	1751	mitglied	TIEF	\N
270	1751	mitglied	TIEF	\N
63	1751	mitglied	TIEF	\N
272	1751	mitglied	TIEF	\N
273	1751	mitglied	TIEF	\N
65	1751	mitglied	TIEF	\N
275	1751	mitglied	TIEF	\N
369	1751	mitglied	TIEF	\N
388	1751	mitglied	TIEF	\N
6	1751	mitglied	TIEF	\N
277	1751	mitglied	TIEF	\N
315	1751	mitglied	TIEF	\N
278	1751	mitglied	TIEF	\N
341	1751	mitglied	TIEF	\N
316	1751	mitglied	TIEF	\N
393	1751	mitglied	TIEF	\N
280	1751	mitglied	TIEF	\N
89	1751	mitglied	TIEF	\N
227	1751	mitglied	TIEF	\N
96	1751	mitglied	TIEF	\N
101	1751	mitglied	TIEF	\N
102	1751	mitglied	TIEF	\N
348	1751	mitglied	TIEF	\N
106	1751	mitglied	TIEF	\N
285	1751	mitglied	TIEF	\N
327	1751	mitglied	TIEF	\N
391	1751	mitglied	TIEF	\N
328	1751	mitglied	TIEF	\N
110	1751	mitglied	TIEF	\N
343	1751	mitglied	TIEF	\N
116	1751	mitglied	TIEF	\N
394	1751	mitglied	TIEF	\N
287	1751	mitglied	TIEF	\N
11	1751	mitglied	TIEF	\N
120	1751	mitglied	TIEF	\N
289	1751	mitglied	TIEF	\N
314	1751	mitglied	TIEF	\N
402	1751	mitglied	TIEF	\N
329	1751	mitglied	TIEF	\N
337	1751	mitglied	TIEF	\N
14	1751	mitglied	TIEF	\N
293	1751	mitglied	TIEF	\N
296	1751	mitglied	TIEF	\N
367	1751	mitglied	TIEF	\N
147	1751	mitglied	TIEF	\N
318	1751	mitglied	TIEF	\N
153	1751	mitglied	TIEF	\N
154	1751	mitglied	TIEF	\N
297	1751	mitglied	TIEF	\N
159	1751	mitglied	TIEF	\N
161	1751	mitglied	TIEF	\N
333	1751	mitglied	TIEF	\N
299	1751	mitglied	TIEF	\N
167	1751	mitglied	TIEF	\N
378	1751	mitglied	TIEF	\N
170	1751	mitglied	TIEF	\N
171	1751	mitglied	TIEF	\N
172	1751	mitglied	TIEF	\N
415	1751	mitglied	TIEF	\N
178	1751	mitglied	TIEF	\N
331	1751	mitglied	TIEF	\N
416	1751	mitglied	TIEF	\N
418	1751	mitglied	TIEF	\N
21	1751	mitglied	TIEF	\N
188	1751	mitglied	TIEF	\N
190	1751	mitglied	TIEF	\N
353	1751	mitglied	TIEF	\N
305	1751	mitglied	TIEF	\N
384	1751	mitglied	TIEF	\N
198	1751	mitglied	TIEF	\N
307	1751	mitglied	TIEF	\N
309	1751	mitglied	TIEF	\N
251	1751	mitglied	TIEF	\N
210	1751	mitglied	TIEF	\N
335	1751	mitglied	TIEF	\N
310	1751	mitglied	TIEF	\N
386	1751	mitglied	TIEF	\N
211	1751	mitglied	TIEF	\N
366	1751	mitglied	TIEF	\N
312	1751	mitglied	TIEF	\N
353	7600	vorstand	TIEF	\N
371	7600	mitglied	TIEF	\N
388	7600	mitglied	TIEF	\N
392	7600	mitglied	TIEF	\N
278	7600	mitglied	TIEF	\N
83	7600	mitglied	TIEF	\N
356	7600	mitglied	TIEF	\N
381	7600	mitglied	TIEF	\N
402	7600	mitglied	TIEF	\N
293	7600	mitglied	TIEF	\N
415	7600	mitglied	TIEF	\N
251	7600	mitglied	TIEF	\N
154	5734	vorstand	TIEF	\N
334	5734	vorstand	TIEF	\N
41	5734	mitglied	TIEF	\N
106	5734	mitglied	TIEF	\N
333	5734	mitglied	TIEF	\N
66	7601	vorstand	TIEF	\N
328	7601	mitglied	TIEF	\N
393	7601	mitglied	TIEF	\N
391	7601	mitglied	TIEF	\N
358	5232	mitglied	TIEF	\N
65	5232	mitglied	TIEF	\N
388	5232	mitglied	TIEF	\N
6	5232	mitglied	TIEF	\N
76	5232	mitglied	TIEF	\N
83	5232	mitglied	TIEF	\N
374	5232	mitglied	TIEF	\N
284	5232	mitglied	TIEF	\N
228	5232	mitglied	TIEF	\N
382	5232	mitglied	TIEF	\N
14	5232	mitglied	TIEF	\N
147	5232	mitglied	TIEF	\N
318	5232	mitglied	TIEF	\N
414	5232	mitglied	TIEF	\N
346	890	mitglied	TIEF	\N
304	890	mitglied	TIEF	\N
421	890	mitglied	TIEF	\N
277	1622	mitglied	TIEF	\N
392	1622	mitglied	TIEF	\N
223	1622	mitglied	TIEF	\N
76	1622	mitglied	TIEF	\N
79	1622	mitglied	TIEF	\N
356	1622	mitglied	TIEF	\N
381	1622	mitglied	TIEF	\N
227	1622	mitglied	TIEF	\N
284	1622	mitglied	TIEF	\N
406	1622	mitglied	TIEF	\N
294	1622	mitglied	TIEF	\N
367	1622	mitglied	TIEF	\N
297	1622	mitglied	TIEF	\N
166	1622	mitglied	TIEF	\N
171	1622	mitglied	TIEF	\N
319	1622	mitglied	TIEF	\N
331	1622	mitglied	TIEF	\N
379	1622	mitglied	TIEF	\N
242	1622	mitglied	TIEF	\N
188	1622	mitglied	TIEF	\N
306	1622	mitglied	TIEF	\N
321	1622	mitglied	TIEF	\N
312	1622	mitglied	TIEF	\N
273	4580	mitglied	TIEF	\N
316	4580	mitglied	TIEF	\N
227	4580	mitglied	TIEF	\N
374	4580	mitglied	TIEF	\N
317	4580	mitglied	TIEF	\N
287	4580	mitglied	TIEF	\N
125	4580	mitglied	TIEF	\N
149	4580	mitglied	TIEF	\N
297	4580	mitglied	TIEF	\N
333	4580	mitglied	TIEF	\N
384	4580	mitglied	TIEF	\N
306	4580	mitglied	TIEF	\N
387	4580	mitglied	TIEF	\N
251	4580	mitglied	TIEF	\N
392	5047	mitglied	TIEF	\N
328	6437	vorstand	TIEF	\N
323	6437	mitglied	TIEF	\N
63	6437	mitglied	TIEF	\N
65	6437	mitglied	TIEF	\N
316	6437	mitglied	TIEF	\N
393	6437	mitglied	TIEF	\N
284	6437	mitglied	TIEF	\N
382	6437	mitglied	TIEF	\N
125	6437	mitglied	TIEF	\N
329	6437	mitglied	TIEF	\N
147	6437	mitglied	TIEF	\N
154	6437	mitglied	TIEF	\N
168	6437	mitglied	TIEF	\N
411	6437	mitglied	TIEF	\N
171	6437	mitglied	TIEF	\N
331	6437	mitglied	TIEF	\N
198	6437	mitglied	TIEF	\N
361	6437	mitglied	TIEF	\N
275	2899	vorstand	TIEF	\N
41	2899	mitglied	TIEF	\N
44	2899	mitglied	TIEF	\N
219	2899	mitglied	TIEF	\N
60	2899	mitglied	TIEF	\N
270	2899	mitglied	TIEF	\N
273	2899	mitglied	TIEF	\N
65	2899	mitglied	TIEF	\N
388	2899	mitglied	TIEF	\N
6	2899	mitglied	TIEF	\N
277	2899	mitglied	TIEF	\N
315	2899	mitglied	TIEF	\N
278	2899	mitglied	TIEF	\N
316	2899	mitglied	TIEF	\N
393	2899	mitglied	TIEF	\N
76	2899	mitglied	TIEF	\N
83	2899	mitglied	TIEF	\N
227	2899	mitglied	TIEF	\N
360	2899	mitglied	TIEF	\N
283	2899	mitglied	TIEF	\N
284	2899	mitglied	TIEF	\N
101	2899	mitglied	TIEF	\N
285	2899	mitglied	TIEF	\N
327	2899	mitglied	TIEF	\N
328	2899	mitglied	TIEF	\N
317	2899	mitglied	TIEF	\N
394	2899	mitglied	TIEF	\N
287	2899	mitglied	TIEF	\N
11	2899	mitglied	TIEF	\N
120	2899	mitglied	TIEF	\N
289	2899	mitglied	TIEF	\N
337	2899	mitglied	TIEF	\N
405	2899	mitglied	TIEF	\N
406	2899	mitglied	TIEF	\N
294	2899	mitglied	TIEF	\N
149	2899	mitglied	TIEF	\N
297	2899	mitglied	TIEF	\N
166	2899	mitglied	TIEF	\N
167	2899	mitglied	TIEF	\N
248	2899	mitglied	TIEF	\N
171	2899	mitglied	TIEF	\N
172	2899	mitglied	TIEF	\N
415	2899	mitglied	TIEF	\N
178	2899	mitglied	TIEF	\N
182	2899	mitglied	TIEF	\N
302	2899	mitglied	TIEF	\N
21	2899	mitglied	TIEF	\N
190	2899	mitglied	TIEF	\N
353	2899	mitglied	TIEF	\N
306	2899	mitglied	TIEF	\N
307	2899	mitglied	TIEF	\N
361	2899	mitglied	TIEF	\N
309	2899	mitglied	TIEF	\N
251	2899	mitglied	TIEF	\N
210	2899	mitglied	TIEF	\N
310	2899	mitglied	TIEF	\N
312	2899	mitglied	TIEF	\N
40	5978	mitglied	TIEF	\N
41	5978	mitglied	TIEF	\N
44	5978	mitglied	TIEF	\N
371	5978	mitglied	TIEF	\N
219	5978	mitglied	TIEF	\N
60	5978	mitglied	TIEF	\N
273	5978	mitglied	TIEF	\N
65	5978	mitglied	TIEF	\N
275	5978	mitglied	TIEF	\N
392	5978	mitglied	TIEF	\N
315	5978	mitglied	TIEF	\N
278	5978	mitglied	TIEF	\N
316	5978	mitglied	TIEF	\N
79	5978	mitglied	TIEF	\N
83	5978	mitglied	TIEF	\N
227	5978	mitglied	TIEF	\N
106	5978	mitglied	TIEF	\N
275	1622	mitglied	TIEF	\N
383	1622	mitglied	TIEF	\N
388	1622	mitglied	TIEF	\N
171	5978	mitglied	TIEF	\N
178	5978	mitglied	TIEF	\N
242	5978	mitglied	TIEF	\N
21	5978	mitglied	TIEF	\N
188	5978	mitglied	TIEF	\N
353	5978	mitglied	TIEF	\N
305	5978	mitglied	TIEF	\N
251	5978	mitglied	TIEF	\N
335	5978	mitglied	TIEF	\N
321	5978	mitglied	TIEF	\N
83	5979	vorstand	TIEF	\N
40	5979	mitglied	TIEF	\N
264	5979	mitglied	TIEF	\N
368	5979	mitglied	TIEF	\N
355	5979	mitglied	TIEF	\N
358	5979	mitglied	TIEF	\N
383	5979	mitglied	TIEF	\N
280	5979	mitglied	TIEF	\N
395	5979	mitglied	TIEF	\N
347	5979	mitglied	TIEF	\N
374	5979	mitglied	TIEF	\N
102	5979	mitglied	TIEF	\N
348	5979	mitglied	TIEF	\N
106	5979	mitglied	TIEF	\N
382	5979	mitglied	TIEF	\N
398	5979	mitglied	TIEF	\N
125	5979	mitglied	TIEF	\N
14	5979	mitglied	TIEF	\N
41	1951	vorstand	TIEF	\N
392	594	vorstand	HOCH	\N
392	7614	vorstand	MITTEL	\N
418	4467	vorstand	HOCH	\N
349	265	vorstand	HOCH	\N
363	1389	vorstand	HOCH	\N
391	7616	vorstand	TIEF	\N
390	291	vorstand	MITTEL	\N
348	340	vorstand	HOCH	\N
422	581	vorstand	MITTEL	\N
110	7621	geschaeftsfuehrend	TIEF	\N
65	7622	vorstand	HOCH	\N
381	2824	vorstand	TIEF	\N
332	1064	mitglied	TIEF	\N
382	1698	vorstand	MITTEL	\N
382	7624	beirat	TIEF	\N
219	7624	beirat	TIEF	\N
153	7624	beirat	TIEF	\N
188	7624	beirat	TIEF	\N
102	2547	beirat	MITTEL	\N
382	822	vorstand	TIEF	\N
382	7625	vorstand	TIEF	\N
382	244	vorstand	HOCH	\N
405	7626	vorstand	TIEF	\N
154	3955	vorstand	MITTEL	\N
374	1997	vorstand	TIEF	\N
161	7630	vorstand	TIEF	\N
161	7631	vorstand	TIEF	\N
161	7632	vorstand	TIEF	\N
185	7633	mitglied	TIEF	\N
185	1030	mitglied	TIEF	\N
185	3657	beirat	TIEF	\N
210	7636	gesellschafter	TIEF	\N
125	7637	vorstand	MITTEL	\N
125	7638	vorstand	TIEF	\N
406	7625	vorstand	TIEF	\N
40	7625	vorstand	TIEF	\N
391	7625	vorstand	TIEF	\N
403	7625	vorstand	TIEF	\N
337	7625	vorstand	TIEF	\N
346	7625	vorstand	TIEF	\N
418	7625	vorstand	TIEF	\N
349	7625	vorstand	TIEF	\N
334	7625	vorstand	TIEF	\N
309	7625	vorstand	TIEF	\N
310	7625	vorstand	TIEF	\N
185	7639	mitglied	TIEF	\N
185	7642	mitglied	TIEF	\N
185	7643	mitglied	TIEF	\N
185	7645	vorstand	TIEF	\N
185	7646	vorstand	TIEF	\N
329	1715	vorstand	TIEF	\N
329	5464	beirat	TIEF	\N
329	169	beirat	MITTEL	\N
329	5827	beirat	TIEF	\N
329	7654	vorstand	TIEF	\N
329	7667	mitglied	TIEF	\N
329	7668	beirat	TIEF	\N
329	7669	mitglied	TIEF	\N
329	7670	vorstand	MITTEL	\N
102	2546	vorstand	HOCH	\N
297	7672	geschaeftsfuehrend	TIEF	\N
297	7673	geschaeftsfuehrend	TIEF	\N
416	4241	vorstand	MITTEL	\N
386	402	beirat	MITTEL	\N
273	504	vorstand	HOCH	\N
66	7674	vorstand	TIEF	\N
66	7676	beirat	TIEF	\N
66	7677	beirat	MITTEL	\N
66	7678	beirat	TIEF	\N
66	5121	taetig	MITTEL	\N
66	7680	taetig	TIEF	\N
66	6198	mitglied	TIEF	\N
66	1976	mitglied	TIEF	\N
66	2476	mitglied	TIEF	\N
66	6761	mitglied	TIEF	\N
66	4026	mitglied	TIEF	\N
66	1896	mitglied	TIEF	\N
66	7683	mitglied	TIEF	\N
66	7684	mitglied	TIEF	\N
66	7685	mitglied	TIEF	\N
66	6197	mitglied	TIEF	\N
66	602	mitglied	TIEF	\N
66	1064	mitglied	TIEF	\N
66	7686	mitglied	TIEF	\N
66	7687	mitglied	TIEF	\N
53	7689	mitglied	TIEF	\N
11	7690	vorstand	TIEF	\N
223	7694	vorstand	MITTEL	\N
284	243	vorstand	MITTEL	\N
284	7695	vorstand	TIEF	\N
284	7696	vorstand	TIEF	\N
284	5541	beirat	TIEF	\N
284	7697	vorstand	TIEF	\N
319	7698	vorstand	TIEF	\N
319	6234	geschaeftsfuehrend	TIEF	\N
41	5489	vorstand	TIEF	\N
277	517	vorstand	MITTEL	\N
277	5836	beirat	MITTEL	\N
341	2930	vorstand	TIEF	\N
341	7699	mitglied	TIEF	\N
341	7701	vorstand	TIEF	\N
172	5359	vorstand	MITTEL	\N
396	1507	vorstand	MITTEL	\N
318	5978	mitglied	TIEF	\N
166	5978	mitglied	TIEF	\N
248	5978	mitglied	TIEF	\N
418	4466	vorstand	TIEF	\N
280	3316	vorstand	TIEF	\N
280	3317	vorstand	TIEF	\N
280	7713	vorstand	TIEF	\N
296	877	vorstand	MITTEL	\N
345	7716	taetig	TIEF	\N
316	5683	beirat	MITTEL	\N
418	244	vorstand	HOCH	\N
63	7712	vorstand	TIEF	\N
337	244	vorstand	HOCH	\N
360	244	vorstand	HOCH	\N
406	244	vorstand	HOCH	\N
168	244	vorstand	MITTEL	\N
378	244	vorstand	HOCH	\N
334	244	vorstand	HOCH	\N
65	4223	vorstand	TIEF	\N
337	44	vorstand	MITTEL	\N
337	283	vorstand	TIEF	\N
318	923	vorstand	TIEF	\N
318	7722	vorstand	TIEF	\N
318	7721	vorstand	TIEF	\N
415	2256	vorstand	HOCH	\N
410	50	vorstand	MITTEL	\N
410	66	vorstand	HOCH	\N
410	5019	vorstand	TIEF	\N
410	7725	vorstand	TIEF	\N
410	7726	mitglied	TIEF	\N
250	517	vorstand	MITTEL	\N
389	7727	vorstand	MITTEL	\N
144	7729	mitglied	TIEF	\N
41	517	vorstand	MITTEL	\N
340	1533	mitglied	TIEF	\N
333	1533	mitglied	TIEF	\N
415	1533	mitglied	TIEF	\N
309	1533	mitglied	TIEF	\N
402	1533	mitglied	TIEF	\N
285	2977	vorstand	TIEF	\N
415	2977	vorstand	TIEF	\N
190	2977	vorstand	TIEF	\N
356	7731	vorstand	TIEF	\N
297	7594	vorstand	TIEF	\N
219	7594	mitglied	TIEF	\N
374	7595	mitglied	TIEF	\N
390	2020	mitglied	TIEF	\N
406	2020	mitglied	TIEF	\N
388	2111	mitglied	TIEF	\N
391	2111	mitglied	TIEF	\N
382	2111	mitglied	TIEF	\N
391	2124	mitglied	TIEF	\N
65	2226	mitglied	TIEF	\N
153	2226	mitglied	TIEF	\N
53	1774	mitglied	TIEF	\N
388	1774	mitglied	TIEF	\N
278	1774	mitglied	TIEF	\N
83	1774	mitglied	TIEF	\N
98	1774	mitglied	TIEF	\N
382	1774	mitglied	TIEF	\N
399	1774	mitglied	TIEF	\N
357	1774	mitglied	TIEF	\N
415	1774	mitglied	TIEF	\N
416	1774	mitglied	TIEF	\N
198	1774	mitglied	TIEF	\N
310	1774	mitglied	TIEF	\N
168	4247	mitglied	TIEF	\N
410	4247	mitglied	TIEF	\N
411	4247	mitglied	TIEF	\N
416	4247	mitglied	TIEF	\N
346	4247	mitglied	TIEF	\N
418	4247	mitglied	TIEF	\N
304	4247	mitglied	TIEF	\N
361	4247	mitglied	TIEF	\N
335	4247	mitglied	TIEF	\N
386	4247	mitglied	TIEF	\N
366	4247	mitglied	TIEF	\N
6	1851	mitglied	TIEF	\N
318	3496	vorstand	TIEF	\N
270	3496	mitglied	TIEF	\N
388	3496	mitglied	TIEF	\N
280	3496	mitglied	TIEF	\N
89	3496	mitglied	TIEF	\N
327	3496	mitglied	TIEF	\N
125	3496	mitglied	TIEF	\N
402	3496	mitglied	TIEF	\N
403	3496	mitglied	TIEF	\N
404	3496	mitglied	TIEF	\N
357	3496	mitglied	TIEF	\N
332	3496	mitglied	TIEF	\N
310	3496	mitglied	TIEF	\N
388	5245	mitglied	TIEF	\N
345	2491	mitglied	TIEF	\N
310	2828	mitglied	TIEF	\N
382	4959	mitglied	TIEF	\N
261	1661	mitglied	TIEF	\N
40	1661	mitglied	TIEF	\N
355	1661	mitglied	TIEF	\N
89	1661	mitglied	TIEF	\N
102	1661	mitglied	TIEF	\N
228	1661	mitglied	TIEF	\N
144	1661	mitglied	TIEF	\N
154	1661	mitglied	TIEF	\N
168	1661	mitglied	TIEF	\N
410	1661	mitglied	TIEF	\N
411	1661	mitglied	TIEF	\N
416	1661	mitglied	TIEF	\N
364	1858	mitglied	TIEF	\N
400	1858	mitglied	TIEF	\N
310	1858	mitglied	TIEF	\N
228	6121	vorstand	TIEF	\N
424	7732	vorstand	TIEF	\N
374	7732	vorstand	TIEF	\N
388	4111	mitglied	TIEF	\N
380	5964	mitglied	TIEF	\N
310	4157	mitglied	TIEF	\N
364	2677	mitglied	TIEF	\N
65	2677	mitglied	TIEF	\N
369	2677	mitglied	TIEF	\N
388	2677	mitglied	TIEF	\N
79	2677	mitglied	TIEF	\N
83	2677	mitglied	TIEF	\N
382	2677	mitglied	TIEF	\N
125	2677	mitglied	TIEF	\N
406	2677	mitglied	TIEF	\N
357	2677	mitglied	TIEF	\N
378	2677	mitglied	TIEF	\N
171	2677	mitglied	TIEF	\N
182	2677	mitglied	TIEF	\N
192	1353	geschaeftsfuehrend	HOCH	\N
60	7700	vorstand	TIEF	\N
60	7711	vorstand	TIEF	\N
192	4958	mitglied	TIEF	\N
384	4958	mitglied	TIEF	\N
420	4958	mitglied	TIEF	\N
354	4958	mitglied	TIEF	\N
390	5024	mitglied	TIEF	\N
382	5024	mitglied	TIEF	\N
390	6135	vorstand	TIEF	\N
364	7600	mitglied	TIEF	\N
391	7600	mitglied	TIEF	\N
364	5232	mitglied	TIEF	\N
352	5232	mitglied	TIEF	\N
261	1622	mitglied	TIEF	\N
391	1622	mitglied	TIEF	\N
371	5977	mitglied	TIEF	\N
364	5977	mitglied	TIEF	\N
402	5977	mitglied	TIEF	\N
261	5047	mitglied	TIEF	\N
40	5047	mitglied	TIEF	\N
340	5047	mitglied	TIEF	\N
63	5047	mitglied	TIEF	\N
65	5047	mitglied	TIEF	\N
275	5047	mitglied	TIEF	\N
388	5047	mitglied	TIEF	\N
390	5047	mitglied	TIEF	\N
315	5047	mitglied	TIEF	\N
393	5047	mitglied	TIEF	\N
76	5047	mitglied	TIEF	\N
79	5047	mitglied	TIEF	\N
125	5047	mitglied	TIEF	\N
402	5047	mitglied	TIEF	\N
357	5047	mitglied	TIEF	\N
297	5047	mitglied	TIEF	\N
298	5047	mitglied	TIEF	\N
333	5047	mitglied	TIEF	\N
299	5047	mitglied	TIEF	\N
168	5047	mitglied	TIEF	\N
171	5047	mitglied	TIEF	\N
178	5047	mitglied	TIEF	\N
331	5047	mitglied	TIEF	\N
416	5047	mitglied	TIEF	\N
188	5047	mitglied	TIEF	\N
384	5047	mitglied	TIEF	\N
310	5047	mitglied	TIEF	\N
388	6437	mitglied	TIEF	\N
382	5978	mitglied	TIEF	\N
391	2899	mitglied	TIEF	\N
293	5979	mitglied	TIEF	\N
339	5979	mitglied	TIEF	\N
144	5979	mitglied	TIEF	\N
357	5979	mitglied	TIEF	\N
296	5979	mitglied	TIEF	\N
367	5979	mitglied	TIEF	\N
332	5979	mitglied	TIEF	\N
168	5979	mitglied	TIEF	\N
411	5979	mitglied	TIEF	\N
378	5979	mitglied	TIEF	\N
416	5979	mitglied	TIEF	\N
346	5979	mitglied	TIEF	\N
349	5979	mitglied	TIEF	\N
304	5979	mitglied	TIEF	\N
370	5979	mitglied	TIEF	\N
334	5979	mitglied	TIEF	\N
421	5979	mitglied	TIEF	\N
422	5979	mitglied	TIEF	\N
168	177	vorstand	MITTEL	\N
198	7734	vorstand	TIEF	\N
296	381	mitglied	TIEF	\N
296	130	mitglied	TIEF	\N
296	347	mitglied	TIEF	\N
296	293	mitglied	TIEF	\N
296	7736	mitglied	TIEF	\N
296	1065	mitglied	TIEF	\N
296	141	mitglied	TIEF	\N
296	7737	mitglied	TIEF	\N
296	7738	mitglied	TIEF	\N
296	1063	mitglied	TIEF	\N
296	980	mitglied	TIEF	\N
341	7741	taetig	MITTEL	\N
192	7748	geschaeftsfuehrend	TIEF	\N
273	4291	vorstand	TIEF	\N
318	6531	vorstand	TIEF	\N
41	4430	mitglied	TIEF	\N
41	924	vorstand	TIEF	\N
317	7753	vorstand	TIEF	\N
317	7752	vorstand	MITTEL	\N
317	7754	vorstand	HOCH	\N
393	4795	vorstand	TIEF	\N
398	1641	vorstand	TIEF	\N
289	7757	vorstand	TIEF	\N
289	7758	vorstand	TIEF	\N
166	275	vorstand	MITTEL	\N
403	191	beirat	MITTEL	\N
358	191	beirat	MITTEL	\N
345	7761	vorstand	TIEF	\N
345	7762	vorstand	TIEF	\N
323	2220	vorstand	TIEF	\N
323	877	vorstand	MITTEL	\N
285	7767	vorstand	TIEF	\N
228	6445	beirat	MITTEL	\N
242	7768	vorstand	TIEF	\N
49	576	mitglied	TIEF	\N
49	602	mitglied	TIEF	\N
49	4785	mitglied	TIEF	\N
49	1063	mitglied	TIEF	\N
49	381	mitglied	TIEF	\N
345	7677	beirat	MITTEL	\N
426	5478	vorstand	MITTEL	\N
426	7773	vorstand	TIEF	\N
340	873	vorstand	TIEF	\N
228	2411	vorstand	MITTEL	\N
398	6394	vorstand	TIEF	\N
275	7774	gesellschafter	TIEF	\N
369	204	vorstand	MITTEL	\N
383	583	vorstand	HOCH	\N
347	293	vorstand	MITTEL	\N
347	7776	vorstand	TIEF	\N
376	7777	vorstand	TIEF	\N
343	47	vorstand	MITTEL	\N
343	2557	vorstand	MITTEL	\N
120	2251	vorstand	TIEF	\N
120	4875	taetig	MITTEL	\N
149	3619	mitglied	TIEF	\N
149	7744	mitglied	TIEF	\N
353	8951	taetig	TIEF	\N
402	7057	vorstand	TIEF	\N
351	1814	vorstand	TIEF	\N
278	5509	vorstand	HOCH	\N
278	7802	vorstand	TIEF	\N
144	674	vorstand	HOCH	\N
333	7805	vorstand	TIEF	\N
305	2990	mitglied	TIEF	\N
379	4958	mitglied	TIEF	\N
418	4958	mitglied	TIEF	\N
304	4958	mitglied	TIEF	\N
51	7866	vorstand	TIEF	\N
144	7820	vorstand	TIEF	\N
319	7821	vorstand	TIEF	\N
415	477	vorstand	MITTEL	\N
334	5809	vorstand	TIEF	\N
361	453	vorstand	MITTEL	\N
361	2510	vorstand	MITTEL	\N
361	415	vorstand	MITTEL	\N
361	402	beirat	MITTEL	\N
361	7824	vorstand	TIEF	\N
321	1118	vorstand	TIEF	\N
321	3657	beirat	TIEF	\N
321	7825	vorstand	TIEF	\N
321	5177	beirat	MITTEL	\N
340	477	vorstand	HOCH	\N
364	5189	mitglied	TIEF	\N
98	4976	mitglied	TIEF	\N
333	1505	mitglied	TIEF	\N
51	2432	mitglied	TIEF	\N
356	2432	mitglied	TIEF	\N
101	2432	mitglied	TIEF	\N
166	2432	mitglied	TIEF	\N
301	2432	mitglied	TIEF	\N
371	1851	mitglied	TIEF	\N
402	1851	mitglied	TIEF	\N
261	1852	mitglied	TIEF	\N
63	1852	mitglied	TIEF	\N
381	1852	mitglied	TIEF	\N
153	1852	mitglied	TIEF	\N
168	1852	mitglied	TIEF	\N
319	1852	mitglied	TIEF	\N
198	1852	mitglied	TIEF	\N
167	1852	mitglied	TIEF	\N
335	1852	mitglied	TIEF	\N
332	7831	vorstand	TIEF	\N
355	7831	mitglied	TIEF	\N
154	7831	mitglied	TIEF	\N
166	7831	mitglied	TIEF	\N
346	7831	mitglied	TIEF	\N
422	7831	mitglied	TIEF	\N
211	7831	mitglied	TIEF	\N
388	886	mitglied	TIEF	\N
390	886	mitglied	TIEF	\N
280	886	mitglied	TIEF	\N
402	886	mitglied	TIEF	\N
357	886	mitglied	TIEF	\N
168	886	mitglied	TIEF	\N
411	886	mitglied	TIEF	\N
415	886	mitglied	TIEF	\N
416	886	mitglied	TIEF	\N
345	886	mitglied	TIEF	\N
273	7832	vorstand	TIEF	\N
264	1751	mitglied	TIEF	\N
364	1751	mitglied	TIEF	\N
185	1751	mitglied	TIEF	\N
415	7833	vorstand	TIEF	\N
345	7834	vorstand	TIEF	\N
76	7836	beirat	TIEF	\N
381	700	taetig	TIEF	\N
98	347	vorstand	MITTEL	\N
284	2350	beirat	MITTEL	\N
398	172	vorstand	HOCH	\N
404	7837	vorstand	TIEF	\N
346	4973	vorstand	TIEF	\N
346	173	vorstand	TIEF	\N
346	71	vorstand	TIEF	\N
192	654	beirat	MITTEL	\N
264	654	beirat	MITTEL	\N
227	654	beirat	MITTEL	\N
327	654	beirat	MITTEL	\N
335	7840	beirat	TIEF	\N
335	161	beirat	MITTEL	\N
386	2823	vorstand	HOCH	\N
398	7786	vorstand	TIEF	\N
366	2279	vorstand	MITTEL	\N
171	7841	vorstand	TIEF	\N
364	211	vorstand	MITTEL	\N
315	1344	beirat	TIEF	\N
89	1813	vorstand	TIEF	\N
89	7621	geschaeftsfuehrend	TIEF	\N
89	104	mitglied	TIEF	\N
89	4584	mitglied	TIEF	\N
89	7843	mitglied	TIEF	\N
89	7844	mitglied	TIEF	\N
356	7845	vorstand	TIEF	\N
283	7846	vorstand	TIEF	\N
384	234	vorstand	HOCH	\N
384	7677	beirat	MITTEL	\N
384	1771	vorstand	MITTEL	\N
384	5168	beirat	TIEF	\N
384	7848	vorstand	TIEF	\N
384	7849	vorstand	TIEF	\N
384	7850	beirat	TIEF	\N
384	7851	beirat	TIEF	\N
384	7852	vorstand	TIEF	\N
352	7853	vorstand	MITTEL	\N
248	453	beirat	MITTEL	\N
343	7872	geschaeftsfuehrend	TIEF	\N
327	7873	geschaeftsfuehrend	TIEF	\N
327	211	vorstand	MITTEL	\N
327	340	vorstand	HOCH	\N
327	191	beirat	MITTEL	\N
327	5464	beirat	TIEF	\N
182	4392	vorstand	TIEF	\N
182	283	vorstand	TIEF	\N
83	7874	vorstand	TIEF	\N
83	538	beirat	MITTEL	\N
357	5359	vorstand	HOCH	\N
357	629	beirat	TIEF	\N
357	2227	vorstand	MITTEL	\N
357	7875	vorstand	TIEF	\N
357	7876	vorstand	TIEF	\N
190	7877	taetig	TIEF	\N
426	6068	mitglied	TIEF	\N
14	5291	vorstand	TIEF	\N
426	5291	mitglied	TIEF	\N
399	5977	mitglied	TIEF	\N
297	5977	mitglied	TIEF	\N
272	2967	vorstand	TIEF	\N
272	7879	vorstand	TIEF	\N
287	7880	taetig	TIEF	\N
287	2916	mitglied	TIEF	\N
309	2728	vorstand	TIEF	\N
309	7881	vorstand	TIEF	\N
416	7885	vorstand	TIEF	\N
374	7887	vorstand	TIEF	\N
299	7888	beirat	TIEF	\N
261	7889	mitglied	TIEF	\N
330	178	vorstand	TIEF	\N
391	7891	vorstand	TIEF	\N
248	7924	vorstand	TIEF	\N
219	1943	vorstand	TIEF	\N
219	6954	vorstand	MITTEL	\N
219	7819	taetig	TIEF	\N
340	6611	vorstand	TIEF	\N
345	6611	vorstand	TIEF	\N
371	5963	mitglied	TIEF	\N
388	5963	mitglied	TIEF	\N
83	5963	mitglied	TIEF	\N
374	5963	mitglied	TIEF	\N
102	5963	mitglied	TIEF	\N
154	5963	mitglied	TIEF	\N
168	5963	mitglied	TIEF	\N
411	5963	mitglied	TIEF	\N
384	5963	mitglied	TIEF	\N
370	5963	mitglied	TIEF	\N
422	5963	mitglied	TIEF	\N
345	5963	mitglied	TIEF	\N
410	5334	mitglied	TIEF	\N
426	5334	mitglied	TIEF	\N
402	2491	vorstand	TIEF	\N
410	6068	mitglied	TIEF	\N
369	7925	vorstand	TIEF	\N
289	7925	vorstand	TIEF	\N
402	7925	vorstand	TIEF	\N
400	7925	vorstand	TIEF	\N
285	7926	vorstand	TIEF	\N
53	7599	mitglied	TIEF	\N
389	7599	mitglied	TIEF	\N
83	7599	mitglied	TIEF	\N
347	7599	mitglied	TIEF	\N
339	7599	mitglied	TIEF	\N
332	7599	mitglied	TIEF	\N
154	7599	mitglied	TIEF	\N
410	7599	mitglied	TIEF	\N
411	7599	mitglied	TIEF	\N
410	5291	mitglied	TIEF	\N
261	2856	mitglied	TIEF	\N
40	2856	mitglied	TIEF	\N
355	2856	mitglied	TIEF	\N
280	2856	mitglied	TIEF	\N
83	2856	mitglied	TIEF	\N
98	2856	mitglied	TIEF	\N
102	2856	mitglied	TIEF	\N
343	2856	mitglied	TIEF	\N
125	2856	mitglied	TIEF	\N
357	2856	mitglied	TIEF	\N
318	2856	mitglied	TIEF	\N
154	2856	mitglied	TIEF	\N
334	2856	mitglied	TIEF	\N
299	5977	mitglied	TIEF	\N
371	7833	mitglied	TIEF	\N
60	7833	mitglied	TIEF	\N
341	7833	mitglied	TIEF	\N
393	7833	mitglied	TIEF	\N
381	7833	mitglied	TIEF	\N
98	7833	mitglied	TIEF	\N
120	7833	mitglied	TIEF	\N
289	7833	mitglied	TIEF	\N
299	7833	mitglied	TIEF	\N
417	7833	mitglied	TIEF	\N
418	7833	mitglied	TIEF	\N
185	7833	mitglied	TIEF	\N
242	7833	mitglied	TIEF	\N
370	7833	mitglied	TIEF	\N
361	7833	mitglied	TIEF	\N
395	5617	vorstand	HOCH	\N
403	179	vorstand	HOCH	\N
353	154	vorstand	MITTEL	\N
371	7929	vorstand	TIEF	\N
390	598	vorstand	MITTEL	\N
381	7930	beirat	TIEF	\N
386	1344	beirat	TIEF	\N
361	7933	beirat	TIEF	\N
361	7934	beirat	TIEF	\N
363	3219	vorstand	MITTEL	\N
358	87	vorstand	MITTEL	\N
373	2977	vorstand	TIEF	\N
337	2776	beirat	MITTEL	\N
355	1278	mitglied	TIEF	\N
364	1278	mitglied	TIEF	\N
219	1278	mitglied	TIEF	\N
60	1278	mitglied	TIEF	\N
66	1278	mitglied	TIEF	\N
389	1278	mitglied	TIEF	\N
278	1278	mitglied	TIEF	\N
223	1278	mitglied	TIEF	\N
393	1278	mitglied	TIEF	\N
280	1278	mitglied	TIEF	\N
83	1278	mitglied	TIEF	\N
89	1278	mitglied	TIEF	\N
227	1278	mitglied	TIEF	\N
374	1278	mitglied	TIEF	\N
102	1278	mitglied	TIEF	\N
110	1278	mitglied	TIEF	\N
314	1278	mitglied	TIEF	\N
125	1278	mitglied	TIEF	\N
329	1278	mitglied	TIEF	\N
404	1278	mitglied	TIEF	\N
144	1278	mitglied	TIEF	\N
367	1278	mitglied	TIEF	\N
332	1278	mitglied	TIEF	\N
147	1278	mitglied	TIEF	\N
153	1278	mitglied	TIEF	\N
297	1278	mitglied	TIEF	\N
159	1278	mitglied	TIEF	\N
161	1278	mitglied	TIEF	\N
333	1278	mitglied	TIEF	\N
166	1278	mitglied	TIEF	\N
378	1278	mitglied	TIEF	\N
172	1278	mitglied	TIEF	\N
415	1278	mitglied	TIEF	\N
331	1278	mitglied	TIEF	\N
379	1278	mitglied	TIEF	\N
304	1278	mitglied	TIEF	\N
334	1278	mitglied	TIEF	\N
422	1278	mitglied	TIEF	\N
211	1278	mitglied	TIEF	\N
60	2111	mitglied	TIEF	\N
60	459	mitglied	TIEF	\N
384	459	mitglied	TIEF	\N
410	5348	mitglied	TIEF	\N
168	5977	mitglied	TIEF	\N
410	5047	mitglied	TIEF	\N
301	1304	vorstand	HOCH	\N
404	79	vorstand	MITTEL	\N
149	598	vorstand	HOCH	\N
345	7588	vorstand	HOCH	\N
410	5189	mitglied	TIEF	\N
427	8048	vorstand	TIEF	\N
427	8049	taetig	TIEF	\N
248	3934	vorstand	TIEF	\N
414	7583	vorstand	TIEF	\N
264	8050	vorstand	TIEF	\N
361	7924	mitglied	TIEF	\N
422	7924	mitglied	TIEF	\N
310	7924	mitglied	TIEF	\N
383	5047	vorstand	TIEF	\N
426	5979	mitglied	TIEF	\N
427	1812	taetig	MITTEL	\N
285	8101	vorstand	TIEF	\N
428	8103	vorstand	TIEF	\N
361	140	vorstand	MITTEL	\N
361	8105	vorstand	TIEF	\N
379	40	beirat	MITTEL	\N
316	8141	vorstand	TIEF	\N
40	8142	vorstand	TIEF	\N
428	8143	geschaeftsfuehrend	TIEF	\N
21	5091	beirat	MITTEL	\N
419	5224	vorstand	HOCH	\N
426	6352	vorstand	TIEF	\N
426	858	vorstand	TIEF	\N
392	8144	vorstand	TIEF	\N
159	8144	vorstand	TIEF	\N
379	8144	vorstand	TIEF	\N
395	1858	mitglied	TIEF	\N
337	1858	mitglied	TIEF	\N
154	1858	mitglied	TIEF	\N
331	1858	mitglied	TIEF	\N
53	8145	vorstand	TIEF	\N
388	8145	vorstand	TIEF	\N
347	8145	vorstand	TIEF	\N
337	8145	vorstand	TIEF	\N
400	8145	vorstand	TIEF	\N
422	8145	vorstand	TIEF	\N
384	5977	vorstand	TIEF	\N
424	5977	mitglied	TIEF	\N
223	5977	mitglied	TIEF	\N
298	3582	vorstand	TIEF	\N
166	1524	vorstand	MITTEL	\N
383	4976	mitglied	TIEF	\N
411	5291	mitglied	TIEF	\N
428	2220	vorstand	TIEF	\N
60	477	vorstand	MITTEL	\N
60	5933	vorstand	MITTEL	\N
388	1389	beirat	MITTEL	\N
285	8153	beirat	TIEF	\N
159	7592	vorstand	HOCH	\N
379	3668	beirat	TIEF	\N
353	8155	vorstand	TIEF	\N
353	6046	vorstand	TIEF	\N
273	780	vorstand	HOCH	\N
273	8160	vorstand	TIEF	\N
106	8161	vorstand	MITTEL	\N
106	1350	vorstand	MITTEL	\N
285	7589	vorstand	TIEF	\N
302	2507	vorstand	MITTEL	\N
384	8162	vorstand	MITTEL	\N
387	598	vorstand	MITTEL	\N
387	8164	geschaeftsfuehrend	TIEF	\N
388	7118	vorstand	TIEF	\N
381	2136	vorstand	HOCH	\N
381	8169	vorstand	MITTEL	\N
318	6429	vorstand	MITTEL	\N
382	8152	vorstand	TIEF	\N
357	8152	vorstand	TIEF	\N
363	8152	vorstand	TIEF	\N
304	5232	mitglied	TIEF	\N
345	8190	beirat	TIEF	\N
405	8206	vorstand	TIEF	\N
309	601	vorstand	TIEF	\N
190	5683	beirat	MITTEL	\N
357	4983	mitglied	TIEF	\N
426	7594	mitglied	TIEF	\N
371	2124	mitglied	TIEF	\N
364	2124	mitglied	TIEF	\N
278	2124	mitglied	TIEF	\N
376	2124	mitglied	TIEF	\N
374	2124	mitglied	TIEF	\N
171	2124	mitglied	TIEF	\N
346	2124	mitglied	TIEF	\N
185	2124	mitglied	TIEF	\N
384	2124	mitglied	TIEF	\N
426	2124	mitglied	TIEF	\N
371	1505	mitglied	TIEF	\N
144	8209	vorstand	TIEF	\N
388	8209	mitglied	TIEF	\N
390	8209	mitglied	TIEF	\N
76	8209	mitglied	TIEF	\N
347	8209	mitglied	TIEF	\N
396	8209	mitglied	TIEF	\N
382	8209	mitglied	TIEF	\N
337	8209	mitglied	TIEF	\N
351	8209	mitglied	TIEF	\N
404	8209	mitglied	TIEF	\N
378	8209	mitglied	TIEF	\N
331	8209	mitglied	TIEF	\N
192	8209	mitglied	TIEF	\N
370	8209	mitglied	TIEF	\N
334	8209	mitglied	TIEF	\N
310	8209	mitglied	TIEF	\N
211	8209	mitglied	TIEF	\N
352	8209	mitglied	TIEF	\N
321	459	mitglied	TIEF	\N
335	6068	mitglied	TIEF	\N
89	7925	mitglied	TIEF	\N
422	7925	mitglied	TIEF	\N
331	7833	mitglied	TIEF	\N
420	7833	mitglied	TIEF	\N
273	8210	vorstand	TIEF	\N
228	8210	vorstand	TIEF	\N
392	8210	vorstand	TIEF	\N
285	8210	vorstand	TIEF	\N
316	8213	vorstand	TIEF	\N
356	8214	vorstand	MITTEL	\N
356	599	vorstand	MITTEL	\N
289	8215	geschaeftsfuehrend	TIEF	\N
161	6445	beirat	MITTEL	\N
185	8216	vorstand	TIEF	\N
185	8218	vorstand	TIEF	\N
185	8219	vorstand	TIEF	\N
426	1266	beirat	MITTEL	\N
390	154	beirat	MITTEL	\N
171	127	beirat	TIEF	\N
380	191	beirat	MITTEL	\N
49	8230	beirat	TIEF	\N
98	8230	beirat	TIEF	\N
315	8231	beirat	TIEF	\N
316	8231	beirat	TIEF	\N
388	4825	vorstand	MITTEL	\N
384	6518	beirat	TIEF	\N
373	8236	vorstand	TIEF	\N
284	8237	beirat	TIEF	\N
316	8237	beirat	TIEF	\N
352	8237	beirat	TIEF	\N
315	8237	beirat	TIEF	\N
334	8237	beirat	TIEF	\N
101	8237	beirat	TIEF	\N
421	8098	mitglied	TIEF	\N
422	8098	mitglied	TIEF	\N
354	8098	mitglied	TIEF	\N
343	5305	mitglied	TIEF	\N
340	2147	vorstand	HOCH	\N
106	8240	vorstand	TIEF	\N
391	8240	vorstand	TIEF	\N
185	8240	vorstand	TIEF	\N
188	8240	vorstand	TIEF	\N
321	8240	vorstand	TIEF	\N
261	8240	mitglied	TIEF	\N
66	8240	mitglied	TIEF	\N
278	8240	mitglied	TIEF	\N
83	8240	mitglied	TIEF	\N
356	8240	mitglied	TIEF	\N
381	8240	mitglied	TIEF	\N
328	8240	mitglied	TIEF	\N
394	8240	mitglied	TIEF	\N
289	8240	mitglied	TIEF	\N
314	8240	mitglied	TIEF	\N
294	8240	mitglied	TIEF	\N
297	8240	mitglied	TIEF	\N
171	8240	mitglied	TIEF	\N
301	8240	mitglied	TIEF	\N
21	8240	mitglied	TIEF	\N
353	8240	mitglied	TIEF	\N
305	8240	mitglied	TIEF	\N
309	8240	mitglied	TIEF	\N
251	8240	mitglied	TIEF	\N
210	8240	mitglied	TIEF	\N
310	8240	mitglied	TIEF	\N
83	2548	vorstand	TIEF	\N
315	2548	vorstand	TIEF	\N
355	2548	mitglied	TIEF	\N
383	2548	mitglied	TIEF	\N
102	2548	mitglied	TIEF	\N
161	2548	mitglied	TIEF	\N
304	2548	mitglied	TIEF	\N
310	2548	mitglied	TIEF	\N
354	8242	vorstand	TIEF	\N
192	5655	vorstand	TIEF	\N
40	8243	vorstand	TIEF	\N
210	780	vorstand	MITTEL	\N
382	7778	vorstand	TIEF	\N
337	1761	mitglied	TIEF	\N
406	1664	vorstand	MITTEL	\N
346	4046	vorstand	TIEF	\N
166	5305	vorstand	TIEF	\N
40	5305	mitglied	TIEF	\N
83	5305	mitglied	TIEF	\N
289	5305	mitglied	TIEF	\N
314	5305	mitglied	TIEF	\N
210	5305	mitglied	TIEF	\N
310	5305	mitglied	TIEF	\N
125	2857	vorstand	TIEF	\N
40	2857	mitglied	TIEF	\N
388	2857	mitglied	TIEF	\N
83	2857	mitglied	TIEF	\N
88	2857	mitglied	TIEF	\N
89	2857	mitglied	TIEF	\N
102	2857	mitglied	TIEF	\N
398	2857	mitglied	TIEF	\N
147	2857	mitglied	TIEF	\N
153	2857	mitglied	TIEF	\N
168	2857	mitglied	TIEF	\N
411	2857	mitglied	TIEF	\N
178	2857	mitglied	TIEF	\N
331	2857	mitglied	TIEF	\N
192	2857	mitglied	TIEF	\N
310	2857	mitglied	TIEF	\N
211	2857	mitglied	TIEF	\N
332	5039	mitglied	TIEF	\N
192	5039	mitglied	TIEF	\N
264	1889	mitglied	TIEF	\N
368	1889	mitglied	TIEF	\N
219	1889	mitglied	TIEF	\N
65	1889	mitglied	TIEF	\N
275	1889	mitglied	TIEF	\N
280	1889	mitglied	TIEF	\N
381	1889	mitglied	TIEF	\N
102	1889	mitglied	TIEF	\N
402	1889	mitglied	TIEF	\N
404	1889	mitglied	TIEF	\N
147	1889	mitglied	TIEF	\N
154	1889	mitglied	TIEF	\N
310	1889	mitglied	TIEF	\N
211	1889	mitglied	TIEF	\N
275	5280	mitglied	TIEF	\N
405	5280	mitglied	TIEF	\N
310	5280	mitglied	TIEF	\N
310	2493	vorstand	TIEF	\N
316	2493	mitglied	TIEF	\N
83	2493	mitglied	TIEF	\N
283	2493	mitglied	TIEF	\N
285	2493	mitglied	TIEF	\N
405	2493	mitglied	TIEF	\N
161	2493	mitglied	TIEF	\N
248	2493	mitglied	TIEF	\N
422	2493	mitglied	TIEF	\N
251	2493	mitglied	TIEF	\N
211	2493	mitglied	TIEF	\N
332	3954	vorstand	TIEF	\N
264	3954	mitglied	TIEF	\N
388	3954	mitglied	TIEF	\N
83	3954	mitglied	TIEF	\N
382	3954	mitglied	TIEF	\N
402	3954	mitglied	TIEF	\N
357	3954	mitglied	TIEF	\N
400	3954	mitglied	TIEF	\N
161	3954	mitglied	TIEF	\N
248	3954	mitglied	TIEF	\N
417	3954	mitglied	TIEF	\N
310	3954	mitglied	TIEF	\N
275	5282	vorstand	TIEF	\N
327	5282	mitglied	TIEF	\N
405	5282	mitglied	TIEF	\N
170	5282	mitglied	TIEF	\N
188	5655	vorstand	TIEF	\N
261	5655	mitglied	TIEF	\N
355	5655	mitglied	TIEF	\N
390	5655	mitglied	TIEF	\N
280	5655	mitglied	TIEF	\N
83	5655	mitglied	TIEF	\N
367	5655	mitglied	TIEF	\N
166	5655	mitglied	TIEF	\N
422	5655	mitglied	TIEF	\N
310	5655	mitglied	TIEF	\N
380	5655	mitglied	TIEF	\N
327	6120	vorstand	TIEF	\N
60	6120	vorstand	TIEF	\N
125	6120	vorstand	TIEF	\N
40	6120	mitglied	TIEF	\N
264	6120	mitglied	TIEF	\N
316	6120	mitglied	TIEF	\N
96	1376	mitglied	TIEF	\N
371	8239	vorstand	TIEF	\N
309	8239	vorstand	TIEF	\N
310	6120	mitglied	TIEF	\N
364	2428	mitglied	TIEF	\N
219	2428	mitglied	TIEF	\N
60	2428	mitglied	TIEF	\N
270	2428	mitglied	TIEF	\N
63	2428	mitglied	TIEF	\N
272	2428	mitglied	TIEF	\N
273	2428	mitglied	TIEF	\N
275	2428	mitglied	TIEF	\N
316	2428	mitglied	TIEF	\N
393	2428	mitglied	TIEF	\N
79	2428	mitglied	TIEF	\N
376	2428	mitglied	TIEF	\N
283	2428	mitglied	TIEF	\N
427	2428	mitglied	TIEF	\N
285	2428	mitglied	TIEF	\N
343	2428	mitglied	TIEF	\N
116	2428	mitglied	TIEF	\N
425	2428	mitglied	TIEF	\N
289	2428	mitglied	TIEF	\N
125	2428	mitglied	TIEF	\N
405	2428	mitglied	TIEF	\N
297	2428	mitglied	TIEF	\N
299	2428	mitglied	TIEF	\N
248	2428	mitglied	TIEF	\N
170	2428	mitglied	TIEF	\N
171	2428	mitglied	TIEF	\N
172	2428	mitglied	TIEF	\N
379	2428	mitglied	TIEF	\N
302	2428	mitglied	TIEF	\N
190	2428	mitglied	TIEF	\N
353	2428	mitglied	TIEF	\N
310	2428	mitglied	TIEF	\N
40	4931	mitglied	TIEF	\N
323	4931	mitglied	TIEF	\N
219	4931	mitglied	TIEF	\N
60	4931	mitglied	TIEF	\N
63	4931	mitglied	TIEF	\N
388	4931	mitglied	TIEF	\N
316	4931	mitglied	TIEF	\N
285	4931	mitglied	TIEF	\N
166	4931	mitglied	TIEF	\N
168	4931	mitglied	TIEF	\N
331	4931	mitglied	TIEF	\N
192	4931	mitglied	TIEF	\N
315	5176	vorstand	TIEF	\N
60	5176	mitglied	TIEF	\N
327	5176	mitglied	TIEF	\N
149	5176	mitglied	TIEF	\N
171	5176	mitglied	TIEF	\N
297	8251	vorstand	TIEF	\N
219	8251	mitglied	TIEF	\N
383	8251	mitglied	TIEF	\N
406	8251	mitglied	TIEF	\N
40	3893	mitglied	TIEF	\N
60	3893	mitglied	TIEF	\N
63	3893	mitglied	TIEF	\N
227	3893	mitglied	TIEF	\N
161	3893	mitglied	TIEF	\N
299	3893	mitglied	TIEF	\N
166	3893	mitglied	TIEF	\N
248	3893	mitglied	TIEF	\N
172	3893	mitglied	TIEF	\N
188	3893	mitglied	TIEF	\N
251	3893	mitglied	TIEF	\N
394	5823	vorstand	TIEF	\N
40	5823	mitglied	TIEF	\N
60	5823	mitglied	TIEF	\N
280	5823	mitglied	TIEF	\N
102	5823	mitglied	TIEF	\N
327	5823	mitglied	TIEF	\N
110	5823	mitglied	TIEF	\N
116	5823	mitglied	TIEF	\N
332	5823	mitglied	TIEF	\N
161	5823	mitglied	TIEF	\N
304	5823	mitglied	TIEF	\N
310	5823	mitglied	TIEF	\N
248	5969	vorstand	TIEF	\N
40	5969	mitglied	TIEF	\N
66	5969	mitglied	TIEF	\N
369	5969	mitglied	TIEF	\N
343	5969	mitglied	TIEF	\N
332	5969	mitglied	TIEF	\N
378	5969	mitglied	TIEF	\N
192	5969	mitglied	TIEF	\N
211	5969	mitglied	TIEF	\N
264	8252	vorstand	TIEF	\N
192	8252	vorstand	TIEF	\N
83	8252	mitglied	TIEF	\N
382	8252	mitglied	TIEF	\N
332	8252	mitglied	TIEF	\N
125	2898	vorstand	TIEF	\N
261	2898	mitglied	TIEF	\N
355	2898	mitglied	TIEF	\N
53	2898	mitglied	TIEF	\N
66	2898	mitglied	TIEF	\N
341	2898	mitglied	TIEF	\N
374	2898	mitglied	TIEF	\N
327	2898	mitglied	TIEF	\N
382	2898	mitglied	TIEF	\N
400	2898	mitglied	TIEF	\N
332	2898	mitglied	TIEF	\N
378	2898	mitglied	TIEF	\N
188	2898	mitglied	TIEF	\N
422	2898	mitglied	TIEF	\N
60	2178	mitglied	TIEF	\N
388	2178	mitglied	TIEF	\N
402	2178	mitglied	TIEF	\N
332	2178	mitglied	TIEF	\N
248	2178	mitglied	TIEF	\N
188	2178	mitglied	TIEF	\N
192	8253	vorstand	TIEF	\N
355	8253	mitglied	TIEF	\N
280	8253	mitglied	TIEF	\N
83	8253	mitglied	TIEF	\N
110	8253	mitglied	TIEF	\N
332	8253	mitglied	TIEF	\N
168	8253	mitglied	TIEF	\N
60	5279	vorstand	TIEF	\N
352	5279	vorstand	TIEF	\N
261	5279	mitglied	TIEF	\N
6	5279	mitglied	TIEF	\N
315	5279	mitglied	TIEF	\N
316	5279	mitglied	TIEF	\N
393	5279	mitglied	TIEF	\N
83	5279	mitglied	TIEF	\N
227	5279	mitglied	TIEF	\N
327	5279	mitglied	TIEF	\N
343	5279	mitglied	TIEF	\N
289	5279	mitglied	TIEF	\N
331	6120	mitglied	TIEF	\N
416	6120	mitglied	TIEF	\N
306	6120	mitglied	TIEF	\N
430	6798	beirat	TIEF	\N
416	8254	vorstand	TIEF	\N
261	8254	mitglied	TIEF	\N
60	8254	mitglied	TIEF	\N
83	8254	mitglied	TIEF	\N
283	8254	mitglied	TIEF	\N
333	8254	mitglied	TIEF	\N
310	8254	mitglied	TIEF	\N
172	2253	vorstand	TIEF	\N
211	2253	vorstand	TIEF	\N
275	5971	vorstand	TIEF	\N
332	5971	vorstand	TIEF	\N
422	5971	vorstand	TIEF	\N
261	5971	mitglied	TIEF	\N
264	5971	mitglied	TIEF	\N
355	5971	mitglied	TIEF	\N
60	5971	mitglied	TIEF	\N
316	5971	mitglied	TIEF	\N
393	5971	mitglied	TIEF	\N
83	5971	mitglied	TIEF	\N
283	5971	mitglied	TIEF	\N
106	5971	mitglied	TIEF	\N
327	5971	mitglied	TIEF	\N
328	5971	mitglied	TIEF	\N
289	5971	mitglied	TIEF	\N
125	5971	mitglied	TIEF	\N
405	5971	mitglied	TIEF	\N
161	5971	mitglied	TIEF	\N
299	5971	mitglied	TIEF	\N
166	5971	mitglied	TIEF	\N
248	5971	mitglied	TIEF	\N
171	5971	mitglied	TIEF	\N
172	5971	mitglied	TIEF	\N
416	5971	mitglied	TIEF	\N
210	5971	mitglied	TIEF	\N
310	5971	mitglied	TIEF	\N
102	8255	vorstand	TIEF	\N
327	8255	vorstand	TIEF	\N
332	8255	vorstand	TIEF	\N
422	8255	vorstand	TIEF	\N
355	8255	mitglied	TIEF	\N
280	8255	mitglied	TIEF	\N
83	8255	mitglied	TIEF	\N
89	8255	mitglied	TIEF	\N
98	8255	mitglied	TIEF	\N
110	8255	mitglied	TIEF	\N
153	8255	mitglied	TIEF	\N
154	8255	mitglied	TIEF	\N
331	8255	mitglied	TIEF	\N
192	8255	mitglied	TIEF	\N
306	8255	mitglied	TIEF	\N
211	8255	mitglied	TIEF	\N
380	8255	mitglied	TIEF	\N
378	1456	vorstand	TIEF	\N
40	1456	mitglied	TIEF	\N
355	1456	mitglied	TIEF	\N
340	1456	mitglied	TIEF	\N
280	1456	mitglied	TIEF	\N
227	1456	mitglied	TIEF	\N
332	1456	mitglied	TIEF	\N
422	1456	mitglied	TIEF	\N
283	6208	vorstand	TIEF	\N
261	6208	mitglied	TIEF	\N
60	6208	mitglied	TIEF	\N
270	6208	mitglied	TIEF	\N
63	6208	mitglied	TIEF	\N
275	6208	mitglied	TIEF	\N
277	6208	mitglied	TIEF	\N
341	6208	mitglied	TIEF	\N
376	6208	mitglied	TIEF	\N
343	6208	mitglied	TIEF	\N
289	6208	mitglied	TIEF	\N
298	6208	mitglied	TIEF	\N
299	6208	mitglied	TIEF	\N
248	6208	mitglied	TIEF	\N
182	6208	mitglied	TIEF	\N
312	6208	mitglied	TIEF	\N
125	8256	vorstand	TIEF	\N
327	8256	vorstand	TIEF	\N
40	8256	mitglied	TIEF	\N
355	8256	mitglied	TIEF	\N
66	8256	mitglied	TIEF	\N
280	8256	mitglied	TIEF	\N
83	8256	mitglied	TIEF	\N
89	8256	mitglied	TIEF	\N
374	8256	mitglied	TIEF	\N
102	8256	mitglied	TIEF	\N
348	8256	mitglied	TIEF	\N
402	8256	mitglied	TIEF	\N
332	8256	mitglied	TIEF	\N
318	8256	mitglied	TIEF	\N
154	8256	mitglied	TIEF	\N
411	8256	mitglied	TIEF	\N
378	8256	mitglied	TIEF	\N
422	8256	mitglied	TIEF	\N
310	8256	mitglied	TIEF	\N
211	8256	mitglied	TIEF	\N
355	8257	vorstand	TIEF	\N
332	8257	vorstand	TIEF	\N
330	8257	mitglied	TIEF	\N
280	8257	mitglied	TIEF	\N
88	8257	mitglied	TIEF	\N
89	8257	mitglied	TIEF	\N
296	8257	mitglied	TIEF	\N
192	8257	mitglied	TIEF	\N
414	6445	beirat	MITTEL	\N
355	7746	vorstand	TIEF	\N
355	45	vorstand	MITTEL	\N
355	5550	beirat	MITTEL	\N
83	5550	beirat	MITTEL	\N
89	5550	beirat	MITTEL	\N
106	5550	beirat	MITTEL	\N
110	5550	beirat	MITTEL	\N
411	5550	beirat	MITTEL	\N
355	3966	vorstand	MITTEL	\N
318	518	beirat	MITTEL	\N
316	6506	beirat	TIEF	\N
120	499	vorstand	HOCH	\N
430	3654	vorstand	TIEF	\N
430	2591	vorstand	TIEF	\N
430	8259	vorstand	TIEF	\N
430	8260	vorstand	TIEF	\N
430	8261	vorstand	TIEF	\N
430	8262	beirat	TIEF	\N
430	8263	vorstand	TIEF	\N
430	4933	vorstand	TIEF	\N
430	4940	taetig	TIEF	\N
367	5550	beirat	MITTEL	\N
250	2728	vorstand	TIEF	\N
273	453	vorstand	MITTEL	\N
430	8265	vorstand	TIEF	\N
264	8254	vorstand	TIEF	\N
348	8254	vorstand	TIEF	\N
289	8254	vorstand	TIEF	\N
371	4983	mitglied	TIEF	\N
410	4983	mitglied	TIEF	\N
403	6354	vorstand	TIEF	\N
371	6354	mitglied	TIEF	\N
355	6354	mitglied	TIEF	\N
383	6354	mitglied	TIEF	\N
356	6354	mitglied	TIEF	\N
402	6354	mitglied	TIEF	\N
415	6354	mitglied	TIEF	\N
11	8238	vorstand	TIEF	\N
83	8239	mitglied	TIEF	\N
98	8239	mitglied	TIEF	\N
88	2548	vorstand	TIEF	\N
371	7925	mitglied	TIEF	\N
264	7925	mitglied	TIEF	\N
355	7925	mitglied	TIEF	\N
383	7925	mitglied	TIEF	\N
388	7925	mitglied	TIEF	\N
393	7925	mitglied	TIEF	\N
374	7925	mitglied	TIEF	\N
125	7925	mitglied	TIEF	\N
144	7925	mitglied	TIEF	\N
154	7925	mitglied	TIEF	\N
415	7925	mitglied	TIEF	\N
331	7925	mitglied	TIEF	\N
417	7925	mitglied	TIEF	\N
346	7925	mitglied	TIEF	\N
418	7925	mitglied	TIEF	\N
304	7925	mitglied	TIEF	\N
370	7925	mitglied	TIEF	\N
421	7925	mitglied	TIEF	\N
361	7925	mitglied	TIEF	\N
340	8277	vorstand	TIEF	\N
366	8277	vorstand	TIEF	\N
371	8277	mitglied	TIEF	\N
368	8277	mitglied	TIEF	\N
53	8277	mitglied	TIEF	\N
424	8277	mitglied	TIEF	\N
65	8277	mitglied	TIEF	\N
278	8277	mitglied	TIEF	\N
280	8277	mitglied	TIEF	\N
348	8277	mitglied	TIEF	\N
382	8277	mitglied	TIEF	\N
398	8277	mitglied	TIEF	\N
14	8277	mitglied	TIEF	\N
406	8277	mitglied	TIEF	\N
294	8277	mitglied	TIEF	\N
367	8277	mitglied	TIEF	\N
332	8277	mitglied	TIEF	\N
154	8277	mitglied	TIEF	\N
333	8277	mitglied	TIEF	\N
410	8277	mitglied	TIEF	\N
415	8277	mitglied	TIEF	\N
21	8277	mitglied	TIEF	\N
304	8277	mitglied	TIEF	\N
370	8277	mitglied	TIEF	\N
352	8277	mitglied	TIEF	\N
371	5024	mitglied	TIEF	\N
364	5024	mitglied	TIEF	\N
89	5024	mitglied	TIEF	\N
374	5024	mitglied	TIEF	\N
348	5024	mitglied	TIEF	\N
398	5024	mitglied	TIEF	\N
416	5024	mitglied	TIEF	\N
421	5024	mitglied	TIEF	\N
307	5232	mitglied	TIEF	\N
427	1622	mitglied	TIEF	\N
410	1622	mitglied	TIEF	\N
298	5977	mitglied	TIEF	\N
411	8255	mitglied	TIEF	\N
371	8144	mitglied	TIEF	\N
383	8144	mitglied	TIEF	\N
388	8144	mitglied	TIEF	\N
382	8144	mitglied	TIEF	\N
367	8144	mitglied	TIEF	\N
331	8144	mitglied	TIEF	\N
370	8144	mitglied	TIEF	\N
371	7926	mitglied	TIEF	\N
125	7926	mitglied	TIEF	\N
415	7926	mitglied	TIEF	\N
66	2586	vorstand	TIEF	\N
376	6555	vorstand	TIEF	\N
376	47	taetig	MITTEL	\N
376	1406	vorstand	MITTEL	\N
299	3989	vorstand	TIEF	\N
368	4983	mitglied	TIEF	\N
369	8281	vorstand	TIEF	\N
278	8281	vorstand	TIEF	\N
410	8281	vorstand	TIEF	\N
190	8281	vorstand	TIEF	\N
361	1480	taetig	MITTEL	\N
360	1770	vorstand	TIEF	\N
154	583	vorstand	HOCH	\N
251	1302	vorstand	HOCH	\N
310	1266	vorstand	MITTEL	\N
310	8282	vorstand	TIEF	\N
310	1524	vorstand	MITTEL	\N
424	857	vorstand	TIEF	\N
424	8289	vorstand	TIEF	\N
430	3869	beirat	MITTEL	\N
297	1504	beirat	TIEF	\N
98	8290	mitglied	TIEF	\N
383	8290	mitglied	TIEF	\N
382	8290	mitglied	TIEF	\N
371	8290	mitglied	TIEF	\N
378	8290	mitglied	TIEF	\N
411	8290	mitglied	TIEF	\N
410	8290	mitglied	TIEF	\N
422	8290	mitglied	TIEF	\N
304	8290	mitglied	TIEF	\N
367	8290	mitglied	TIEF	\N
40	169	beirat	MITTEL	\N
185	8291	vorstand	TIEF	\N
299	340	vorstand	HOCH	\N
11	8293	vorstand	TIEF	\N
223	4997	vorstand	TIEF	\N
422	8296	vorstand	TIEF	\N
422	8297	beirat	TIEF	\N
422	8298	beirat	MITTEL	\N
422	8299	beirat	TIEF	\N
380	8301	vorstand	TIEF	\N
312	8302	vorstand	MITTEL	\N
170	7806	vorstand	TIEF	\N
381	6046	vorstand	TIEF	\N
357	8324	taetig	TIEF	\N
40	1504	vorstand	TIEF	\N
382	1504	vorstand	TIEF	\N
284	1504	vorstand	TIEF	\N
337	1504	vorstand	TIEF	\N
417	1504	beirat	TIEF	\N
400	1504	beirat	TIEF	\N
386	6126	vorstand	HOCH	\N
386	8275	vorstand	TIEF	\N
386	8276	vorstand	TIEF	\N
383	1380	vorstand	HOCH	\N
388	7735	vorstand	TIEF	\N
392	1136	vorstand	MITTEL	\N
395	814	beirat	MITTEL	\N
381	8343	vorstand	TIEF	\N
348	54	beirat	MITTEL	\N
394	2977	vorstand	TIEF	\N
398	8345	beirat	TIEF	\N
125	3291	vorstand	HOCH	\N
125	6515	vorstand	TIEF	\N
429	8347	vorstand	TIEF	\N
427	8348	taetig	TIEF	\N
154	191	vorstand	HOCH	\N
154	8351	beirat	TIEF	\N
410	6286	vorstand	TIEF	\N
335	8343	vorstand	TIEF	\N
51	8356	vorstand	TIEF	\N
284	8357	vorstand	TIEF	\N
348	8358	beirat	TIEF	\N
357	5091	beirat	MITTEL	\N
429	2020	mitglied	TIEF	\N
367	2020	mitglied	TIEF	\N
370	637	vorstand	HOCH	\N
383	8239	mitglied	TIEF	\N
394	8239	mitglied	TIEF	\N
312	8239	mitglied	TIEF	\N
317	4756	vorstand	TIEF	\N
361	7853	vorstand	MITTEL	\N
264	8142	vorstand	TIEF	\N
327	8142	vorstand	TIEF	\N
391	8142	vorstand	TIEF	\N
316	8142	vorstand	TIEF	\N
390	4385	vorstand	TIEF	\N
327	3329	vorstand	TIEF	\N
376	1421	vorstand	TIEF	\N
386	822	vorstand	TIEF	\N
275	5489	vorstand	TIEF	\N
188	8277	vorstand	TIEF	\N
305	5842	vorstand	TIEF	\N
417	8377	vorstand	TIEF	\N
417	8378	vorstand	TIEF	\N
417	8379	beirat	TIEF	\N
185	8381	vorstand	TIEF	\N
361	7854	vorstand	TIEF	\N
171	54	beirat	MITTEL	\N
171	5732	beirat	TIEF	\N
171	8384	beirat	TIEF	\N
371	5425	vorstand	TIEF	\N
418	6948	beirat	MITTEL	\N
348	8390	beirat	TIEF	\N
358	8390	beirat	TIEF	\N
110	8390	beirat	TIEF	\N
416	8390	beirat	TIEF	\N
411	8390	beirat	TIEF	\N
371	8390	beirat	TIEF	\N
110	8391	vorstand	TIEF	\N
120	8399	vorstand	TIEF	\N
251	8401	beirat	TIEF	\N
381	1226	vorstand	TIEF	\N
318	8410	gesellschafter	TIEF	\N
331	640	mitglied	TIEF	\N
51	8411	vorstand	TIEF	\N
51	4157	mitglied	TIEF	\N
65	4157	mitglied	TIEF	\N
369	4157	mitglied	TIEF	\N
315	4157	mitglied	TIEF	\N
360	4157	mitglied	TIEF	\N
328	4157	mitglied	TIEF	\N
120	4157	mitglied	TIEF	\N
289	4157	mitglied	TIEF	\N
314	4157	mitglied	TIEF	\N
125	4157	mitglied	TIEF	\N
14	4157	mitglied	TIEF	\N
333	4157	mitglied	TIEF	\N
171	4157	mitglied	TIEF	\N
415	4157	mitglied	TIEF	\N
416	4157	mitglied	TIEF	\N
379	4157	mitglied	TIEF	\N
418	4157	mitglied	TIEF	\N
185	4157	mitglied	TIEF	\N
304	4157	mitglied	TIEF	\N
384	4157	mitglied	TIEF	\N
420	4157	mitglied	TIEF	\N
307	4157	mitglied	TIEF	\N
361	4157	mitglied	TIEF	\N
312	4157	mitglied	TIEF	\N
310	5291	mitglied	TIEF	\N
393	1622	mitglied	TIEF	\N
120	1622	mitglied	TIEF	\N
402	1622	mitglied	TIEF	\N
357	1622	mitglied	TIEF	\N
415	1622	mitglied	TIEF	\N
178	1622	mitglied	TIEF	\N
192	1622	mitglied	TIEF	\N
211	1622	mitglied	TIEF	\N
192	3954	mitglied	TIEF	\N
192	5823	mitglied	TIEF	\N
192	8256	mitglied	TIEF	\N
430	1504	beirat	TIEF	\N
198	8414	geschaeftsfuehrend	TIEF	\N
327	8418	vorstand	TIEF	\N
433	8422	vorstand	TIEF	\N
433	8423	vorstand	TIEF	\N
433	2922	mitglied	TIEF	\N
433	580	mitglied	TIEF	\N
433	602	mitglied	TIEF	\N
433	287	mitglied	TIEF	\N
433	8424	mitglied	TIEF	\N
433	79	mitglied	TIEF	\N
432	8426	beirat	TIEF	\N
11	8427	vorstand	TIEF	\N
315	7598	mitglied	TIEF	\N
168	7598	mitglied	TIEF	\N
331	7598	mitglied	TIEF	\N
384	7598	mitglied	TIEF	\N
422	8431	vorstand	TIEF	\N
316	460	beirat	MITTEL	\N
425	47	vorstand	MITTEL	\N
395	1868	vorstand	TIEF	\N
433	1502	taetig	MITTEL	\N
433	425	taetig	MITTEL	\N
433	1653	taetig	TIEF	\N
343	8439	geschaeftsfuehrend	TIEF	\N
428	1380	vorstand	MITTEL	\N
334	1380	beirat	MITTEL	\N
40	3282	beirat	MITTEL	\N
319	1108	geschaeftsfuehrend	MITTEL	\N
6	1108	vorstand	MITTEL	\N
293	6733	vorstand	TIEF	\N
384	992	vorstand	TIEF	\N
384	382	vorstand	HOCH	\N
432	2428	mitglied	TIEF	\N
433	604	vorstand	MITTEL	\N
433	6655	vorstand	MITTEL	\N
400	538	beirat	MITTEL	\N
395	3313	vorstand	MITTEL	\N
402	8465	vorstand	TIEF	\N
161	79	vorstand	HOCH	\N
400	1774	mitglied	TIEF	\N
415	2415	vorstand	MITTEL	\N
369	2415	mitglied	TIEF	\N
371	8472	vorstand	TIEF	\N
366	8472	vorstand	TIEF	\N
348	8472	mitglied	TIEF	\N
144	8472	mitglied	TIEF	\N
153	8472	mitglied	TIEF	\N
353	8472	mitglied	TIEF	\N
198	8472	mitglied	TIEF	\N
304	3313	vorstand	MITTEL	\N
144	35	vorstand	MITTEL	\N
144	8478	mitglied	TIEF	\N
335	20	vorstand	TIEF	\N
251	5472	vorstand	TIEF	\N
153	1891	vorstand	TIEF	\N
388	344	taetig	MITTEL	\N
393	6916	vorstand	TIEF	\N
393	8489	vorstand	TIEF	\N
188	7368	vorstand	MITTEL	\N
391	1294	vorstand	TIEF	\N
317	8490	vorstand	TIEF	\N
396	8492	geschaeftsfuehrend	TIEF	\N
352	7177	geschaeftsfuehrend	TIEF	\N
273	8438	vorstand	TIEF	\N
66	8438	vorstand	TIEF	\N
353	8438	vorstand	TIEF	\N
415	8500	vorstand	TIEF	\N
310	8503	vorstand	TIEF	\N
364	2572	vorstand	MITTEL	\N
340	344	taetig	MITTEL	\N
333	1454	vorstand	TIEF	\N
358	1454	mitglied	TIEF	\N
65	1454	mitglied	TIEF	\N
369	1454	mitglied	TIEF	\N
289	1454	mitglied	TIEF	\N
154	1454	mitglied	TIEF	\N
384	1454	mitglied	TIEF	\N
431	1505	mitglied	TIEF	\N
331	8505	vorstand	TIEF	\N
406	8505	mitglied	TIEF	\N
424	2548	mitglied	TIEF	\N
337	6068	mitglied	TIEF	\N
433	7925	mitglied	TIEF	\N
98	8144	mitglied	TIEF	\N
357	8144	mitglied	TIEF	\N
154	8144	mitglied	TIEF	\N
346	8144	mitglied	TIEF	\N
422	8144	mitglied	TIEF	\N
431	8144	mitglied	TIEF	\N
354	8144	mitglied	TIEF	\N
182	8506	vorstand	TIEF	\N
316	8506	mitglied	TIEF	\N
356	8506	mitglied	TIEF	\N
381	8506	mitglied	TIEF	\N
337	8506	mitglied	TIEF	\N
333	8506	mitglied	TIEF	\N
301	8506	mitglied	TIEF	\N
185	8506	mitglied	TIEF	\N
384	6135	vorstand	TIEF	\N
431	2856	mitglied	TIEF	\N
374	5977	mitglied	TIEF	\N
364	2899	mitglied	TIEF	\N
373	2899	mitglied	TIEF	\N
390	2899	mitglied	TIEF	\N
356	2899	mitglied	TIEF	\N
399	2899	mitglied	TIEF	\N
404	2899	mitglied	TIEF	\N
318	2899	mitglied	TIEF	\N
299	2899	mitglied	TIEF	\N
331	2899	mitglied	TIEF	\N
379	2899	mitglied	TIEF	\N
185	2899	mitglied	TIEF	\N
384	2899	mitglied	TIEF	\N
387	2899	mitglied	TIEF	\N
321	2899	mitglied	TIEF	\N
343	8251	mitglied	TIEF	\N
188	4648	vorstand	TIEF	\N
348	8507	vorstand	TIEF	\N
393	8	vorstand	HOCH	\N
287	8449	vorstand	TIEF	\N
293	415	vorstand	MITTEL	\N
65	8508	vorstand	TIEF	\N
390	533	vorstand	HOCH	\N
223	7256	vorstand	MITTEL	\N
101	8509	vorstand	TIEF	\N
190	8511	geschaeftsfuehrend	TIEF	\N
332	79	vorstand	HOCH	\N
353	453	vorstand	MITTEL	\N
381	1504	beirat	TIEF	\N
388	1217	vorstand	TIEF	\N
380	6845	mitglied	TIEF	\N
287	8517	geschaeftsfuehrend	TIEF	\N
369	1504	beirat	TIEF	\N
125	8406	mitglied	TIEF	\N
65	4392	vorstand	TIEF	\N
318	917	vorstand	TIEF	\N
120	344	taetig	MITTEL	\N
384	344	taetig	MITTEL	\N
14	309	vorstand	TIEF	\N
387	517	vorstand	MITTEL	\N
431	1504	beirat	TIEF	\N
318	1066	geschaeftsfuehrend	TIEF	\N
403	1047	vorstand	MITTEL	\N
420	1047	vorstand	MITTEL	\N
161	1750	mitglied	TIEF	\N
422	1504	beirat	TIEF	\N
310	1504	beirat	TIEF	\N
378	173	vorstand	TIEF	\N
411	8406	mitglied	TIEF	\N
317	289	vorstand	HOCH	\N
323	6655	vorstand	HOCH	\N
277	8534	vorstand	MITTEL	\N
277	2129	vorstand	MITTEL	\N
301	8536	beirat	MITTEL	\N
335	8537	vorstand	TIEF	\N
120	780	vorstand	HOCH	\N
144	8540	mitglied	TIEF	\N
317	691	vorstand	TIEF	\N
387	2054	vorstand	TIEF	\N
333	8190	beirat	TIEF	\N
333	8544	beirat	TIEF	\N
304	71	mitglied	TIEF	\N
304	8565	mitglied	TIEF	\N
304	8566	mitglied	TIEF	\N
426	8209	mitglied	TIEF	\N
430	4157	mitglied	TIEF	\N
374	2856	vorstand	TIEF	\N
340	8505	mitglied	TIEF	\N
60	8505	mitglied	TIEF	\N
270	8505	mitglied	TIEF	\N
390	8505	mitglied	TIEF	\N
392	8505	mitglied	TIEF	\N
79	8505	mitglied	TIEF	\N
376	8505	mitglied	TIEF	\N
391	8505	mitglied	TIEF	\N
298	8505	mitglied	TIEF	\N
410	8505	mitglied	TIEF	\N
171	8505	mitglied	TIEF	\N
436	8505	mitglied	TIEF	\N
198	8505	mitglied	TIEF	\N
431	8505	mitglied	TIEF	\N
310	8505	mitglied	TIEF	\N
53	8567	vorstand	TIEF	\N
110	8567	vorstand	TIEF	\N
396	8567	vorstand	TIEF	\N
297	8567	vorstand	TIEF	\N
280	8567	mitglied	TIEF	\N
411	8567	mitglied	TIEF	\N
353	8567	mitglied	TIEF	\N
301	5728	mitglied	TIEF	\N
301	1851	mitglied	TIEF	\N
301	8277	mitglied	TIEF	\N
371	8152	mitglied	TIEF	\N
355	8152	mitglied	TIEF	\N
369	8152	mitglied	TIEF	\N
383	8152	mitglied	TIEF	\N
388	8152	mitglied	TIEF	\N
392	8152	mitglied	TIEF	\N
83	8152	mitglied	TIEF	\N
374	8152	mitglied	TIEF	\N
98	8152	mitglied	TIEF	\N
102	8152	mitglied	TIEF	\N
125	8152	mitglied	TIEF	\N
403	8152	mitglied	TIEF	\N
337	8152	mitglied	TIEF	\N
400	8152	mitglied	TIEF	\N
154	8152	mitglied	TIEF	\N
378	8152	mitglied	TIEF	\N
346	8152	mitglied	TIEF	\N
418	8152	mitglied	TIEF	\N
198	8152	mitglied	TIEF	\N
361	8152	mitglied	TIEF	\N
430	8152	mitglied	TIEF	\N
422	8152	mitglied	TIEF	\N
431	8152	mitglied	TIEF	\N
354	8152	mitglied	TIEF	\N
11	8281	vorstand	TIEF	\N
301	4958	mitglied	TIEF	\N
301	7832	vorstand	TIEF	\N
301	1751	mitglied	TIEF	\N
301	4580	mitglied	TIEF	\N
363	2792	vorstand	TIEF	\N
301	7833	mitglied	TIEF	\N
172	2898	mitglied	TIEF	\N
378	8255	mitglied	TIEF	\N
327	5109	vorstand	TIEF	\N
432	5109	mitglied	TIEF	\N
83	5109	mitglied	TIEF	\N
227	5109	mitglied	TIEF	\N
11	5109	mitglied	TIEF	\N
147	5109	mitglied	TIEF	\N
161	5109	mitglied	TIEF	\N
378	5109	mitglied	TIEF	\N
172	5109	mitglied	TIEF	\N
188	5109	mitglied	TIEF	\N
251	5109	mitglied	TIEF	\N
310	5109	mitglied	TIEF	\N
370	140	vorstand	MITTEL	\N
436	8572	vorstand	TIEF	\N
436	8573	vorstand	TIEF	\N
436	8574	vorstand	TIEF	\N
436	8575	vorstand	TIEF	\N
436	8576	vorstand	TIEF	\N
436	8577	mitglied	TIEF	\N
436	8579	vorstand	MITTEL	\N
436	8580	vorstand	TIEF	\N
182	8581	vorstand	TIEF	\N
364	4926	mitglied	TIEF	\N
429	4926	mitglied	TIEF	\N
406	2839	mitglied	TIEF	\N
363	4926	mitglied	TIEF	\N
101	5086	vorstand	MITTEL	\N
421	576	vorstand	HOCH	\N
395	6018	vorstand	MITTEL	\N
374	8583	mitglied	TIEF	\N
101	8584	vorstand	TIEF	\N
431	1870	vorstand	TIEF	\N
400	614	vorstand	MITTEL	\N
83	1892	beirat	MITTEL	\N
361	8612	gesellschafter	TIEF	\N
44	8613	vorstand	TIEF	\N
273	7368	vorstand	MITTEL	\N
289	7368	vorstand	MITTEL	\N
378	4476	vorstand	TIEF	\N
198	581	vorstand	MITTEL	\N
65	8627	vorstand	TIEF	\N
431	6018	beirat	MITTEL	\N
429	8629	vorstand	TIEF	\N
429	3409	vorstand	HOCH	\N
432	8567	mitglied	TIEF	\N
348	8567	mitglied	TIEF	\N
172	8567	mitglied	TIEF	\N
416	8567	mitglied	TIEF	\N
251	8567	mitglied	TIEF	\N
386	8567	mitglied	TIEF	\N
355	8635	vorstand	TIEF	\N
327	8635	vorstand	TIEF	\N
192	8635	vorstand	TIEF	\N
310	8635	vorstand	TIEF	\N
40	8635	mitglied	TIEF	\N
368	8635	mitglied	TIEF	\N
63	8635	mitglied	TIEF	\N
388	8635	mitglied	TIEF	\N
83	8635	mitglied	TIEF	\N
89	8635	mitglied	TIEF	\N
347	8635	mitglied	TIEF	\N
98	8635	mitglied	TIEF	\N
102	8635	mitglied	TIEF	\N
110	8635	mitglied	TIEF	\N
382	8635	mitglied	TIEF	\N
14	8635	mitglied	TIEF	\N
339	8635	mitglied	TIEF	\N
144	8635	mitglied	TIEF	\N
296	8635	mitglied	TIEF	\N
367	8635	mitglied	TIEF	\N
154	8635	mitglied	TIEF	\N
411	8635	mitglied	TIEF	\N
378	8635	mitglied	TIEF	\N
299	8505	vorstand	TIEF	\N
261	8505	mitglied	TIEF	\N
40	8505	mitglied	TIEF	\N
429	2162	vorstand	TIEF	\N
309	344	taetig	MITTEL	\N
166	8688	vorstand	TIEF	\N
369	8636	mitglied	TIEF	\N
374	8636	mitglied	TIEF	\N
147	8636	mitglied	TIEF	\N
331	8636	mitglied	TIEF	\N
422	8636	mitglied	TIEF	\N
310	8636	mitglied	TIEF	\N
353	8392	vorstand	TIEF	\N
327	8636	vorstand	TIEF	\N
261	8636	mitglied	TIEF	\N
40	8636	mitglied	TIEF	\N
355	8636	mitglied	TIEF	\N
11	8690	vorstand	TIEF	\N
315	8152	vorstand	TIEF	\N
432	2899	mitglied	TIEF	\N
427	2899	mitglied	TIEF	\N
430	2899	mitglied	TIEF	\N
352	2899	mitglied	TIEF	\N
60	8693	finanziell	TIEF	\N
355	8694	vorstand	TIEF	\N
355	7668	vorstand	TIEF	\N
153	8695	vorstand	TIEF	\N
188	8696	vorstand	TIEF	\N
347	2811	geschaeftsfuehrend	MITTEL	\N
79	6120	mitglied	TIEF	\N
101	39	beirat	MITTEL	\N
280	3498	mitglied	TIEF	\N
102	4935	vorstand	HOCH	\N
102	8205	beirat	TIEF	\N
430	8205	beirat	TIEF	\N
378	877	vorstand	MITTEL	\N
429	4247	mitglied	TIEF	\N
429	4958	mitglied	TIEF	\N
429	1858	mitglied	TIEF	\N
429	2124	mitglied	TIEF	\N
429	1891	mitglied	TIEF	\N
429	1278	mitglied	TIEF	\N
346	6655	vorstand	HOCH	\N
110	4074	beirat	TIEF	\N
346	8701	vorstand	TIEF	\N
346	581	vorstand	MITTEL	\N
192	632	beirat	MITTEL	\N
355	5176	vorstand	TIEF	\N
421	8704	vorstand	TIEF	\N
354	4201	mitglied	TIEF	\N
354	1380	mitglied	TIEF	\N
426	8705	vorstand	TIEF	\N
14	7597	mitglied	TIEF	\N
406	1818	vorstand	HOCH	\N
334	8706	mitglied	TIEF	\N
321	244	vorstand	HOCH	\N
101	8709	vorstand	TIEF	\N
297	2330	vorstand	MITTEL	\N
380	8711	beirat	TIEF	\N
426	8712	beirat	TIEF	\N
270	8713	vorstand	TIEF	\N
101	8714	vorstand	TIEF	\N
404	657	vorstand	MITTEL	\N
404	8715	beirat	TIEF	\N
404	1976	mitglied	TIEF	\N
405	8716	vorstand	HOCH	\N
299	8716	vorstand	HOCH	\N
227	4441	vorstand	TIEF	\N
404	2832	vorstand	TIEF	\N
411	7598	mitglied	TIEF	\N
430	7598	mitglied	TIEF	\N
398	5291	mitglied	TIEF	\N
168	5291	mitglied	TIEF	\N
415	5024	mitglied	TIEF	\N
393	1889	vorstand	TIEF	\N
153	1889	vorstand	TIEF	\N
429	1889	mitglied	TIEF	\N
388	1889	mitglied	TIEF	\N
310	8719	vorstand	TIEF	\N
388	8719	mitglied	TIEF	\N
125	8719	mitglied	TIEF	\N
402	8719	mitglied	TIEF	\N
248	8719	mitglied	TIEF	\N
331	8719	mitglied	TIEF	\N
188	8719	mitglied	TIEF	\N
422	8719	mitglied	TIEF	\N
65	8720	vorstand	TIEF	\N
329	8720	vorstand	TIEF	\N
340	8720	mitglied	TIEF	\N
388	8720	mitglied	TIEF	\N
289	8720	mitglied	TIEF	\N
147	8720	mitglied	TIEF	\N
161	8720	mitglied	TIEF	\N
198	8720	mitglied	TIEF	\N
361	211	vorstand	HOCH	\N
106	8725	beirat	TIEF	\N
251	1680	vorstand	TIEF	\N
297	1680	vorstand	TIEF	\N
171	8727	vorstand	TIEF	\N
273	6204	taetig	MITTEL	\N
21	8730	vorstand	MITTEL	\N
345	8544	beirat	TIEF	\N
273	344	taetig	MITTEL	\N
316	344	taetig	MITTEL	\N
79	344	taetig	MITTEL	\N
360	344	taetig	MITTEL	\N
314	344	taetig	MITTEL	\N
149	344	taetig	MITTEL	\N
333	344	taetig	MITTEL	\N
185	344	taetig	MITTEL	\N
312	344	taetig	MITTEL	\N
415	311	mitglied	TIEF	\N
414	311	mitglied	TIEF	\N
178	311	mitglied	TIEF	\N
384	311	mitglied	TIEF	\N
167	8536	beirat	MITTEL	\N
110	23	vorstand	HOCH	\N
428	130	vorstand	HOCH	\N
429	8770	vorstand	TIEF	\N
302	346	vorstand	HOCH	\N
14	630	beirat	MITTEL	\N
384	2162	vorstand	TIEF	\N
310	8683	vorstand	TIEF	\N
101	980	vorstand	MITTEL	\N
400	7775	vorstand	TIEF	\N
400	8789	vorstand	TIEF	\N
198	6106	vorstand	TIEF	\N
437	8790	vorstand	TIEF	\N
437	8791	vorstand	TIEF	\N
395	7756	beirat	TIEF	\N
79	244	vorstand	MITTEL	\N
414	892	vorstand	MITTEL	\N
299	7825	beirat	TIEF	\N
340	7825	beirat	TIEF	\N
106	7825	beirat	TIEF	\N
51	7825	beirat	TIEF	\N
285	7825	beirat	TIEF	\N
273	7825	beirat	TIEF	\N
337	7825	beirat	TIEF	\N
405	7825	beirat	TIEF	\N
415	7825	beirat	TIEF	\N
284	7825	beirat	TIEF	\N
345	7825	beirat	TIEF	\N
315	7825	beirat	TIEF	\N
426	7825	beirat	TIEF	\N
316	7825	beirat	TIEF	\N
333	7825	beirat	TIEF	\N
66	7825	beirat	TIEF	\N
319	126	vorstand	TIEF	\N
364	8801	vorstand	TIEF	\N
353	249	vorstand	TIEF	\N
275	7825	vorstand	TIEF	\N
353	1504	beirat	TIEF	\N
355	5023	vorstand	TIEF	\N
340	2432	mitglied	TIEF	\N
369	542	vorstand	MITTEL	\N
6	4871	beirat	MITTEL	\N
390	204	vorstand	MITTEL	\N
393	8804	vorstand	TIEF	\N
402	8805	vorstand	TIEF	\N
172	430	vorstand	TIEF	\N
310	8808	beirat	TIEF	\N
438	2811	geschaeftsfuehrend	MITTEL	\N
289	8812	vorstand	TIEF	\N
278	8812	vorstand	TIEF	\N
317	8812	vorstand	TIEF	\N
328	154	beirat	MITTEL	\N
429	154	beirat	MITTEL	\N
185	4983	mitglied	TIEF	\N
353	4983	mitglied	TIEF	\N
415	8239	mitglied	TIEF	\N
432	1774	mitglied	TIEF	\N
394	2491	mitglied	TIEF	\N
318	8814	mitglied	TIEF	\N
53	5024	mitglied	TIEF	\N
374	8472	mitglied	TIEF	\N
96	8472	mitglied	TIEF	\N
98	8472	mitglied	TIEF	\N
101	8472	mitglied	TIEF	\N
403	8472	mitglied	TIEF	\N
367	8472	mitglied	TIEF	\N
415	8472	mitglied	TIEF	\N
346	8472	mitglied	TIEF	\N
419	8472	mitglied	TIEF	\N
315	1622	mitglied	TIEF	\N
337	1622	mitglied	TIEF	\N
11	7927	vorstand	TIEF	\N
349	5977	mitglied	TIEF	\N
285	8815	vorstand	TIEF	\N
329	8815	vorstand	TIEF	\N
147	8815	vorstand	TIEF	\N
161	8815	vorstand	TIEF	\N
188	8815	vorstand	TIEF	\N
310	8815	vorstand	TIEF	\N
40	8815	mitglied	TIEF	\N
60	8815	mitglied	TIEF	\N
96	8815	mitglied	TIEF	\N
391	8815	mitglied	TIEF	\N
396	8815	mitglied	TIEF	\N
289	8815	mitglied	TIEF	\N
293	8815	mitglied	TIEF	\N
332	8815	mitglied	TIEF	\N
378	8815	mitglied	TIEF	\N
416	8815	mitglied	TIEF	\N
422	8815	mitglied	TIEF	\N
363	8815	mitglied	TIEF	\N
331	1455	vorstand	TIEF	\N
310	1455	vorstand	TIEF	\N
389	1455	mitglied	TIEF	\N
395	1455	mitglied	TIEF	\N
399	1455	mitglied	TIEF	\N
406	1455	mitglied	TIEF	\N
298	1455	mitglied	TIEF	\N
299	1455	mitglied	TIEF	\N
334	1455	mitglied	TIEF	\N
422	1455	mitglied	TIEF	\N
431	1455	mitglied	TIEF	\N
340	8817	vorstand	TIEF	\N
348	8343	vorstand	TIEF	\N
399	8818	vorstand	TIEF	\N
418	8819	vorstand	TIEF	\N
426	8821	vorstand	TIEF	\N
346	126	vorstand	TIEF	\N
390	2510	vorstand	MITTEL	\N
284	1340	vorstand	TIEF	\N
334	753	vorstand	TIEF	\N
66	8424	vorstand	TIEF	\N
429	8852	vorstand	TIEF	\N
382	8249	beirat	MITTEL	\N
382	8855	vorstand	TIEF	\N
337	8480	vorstand	TIEF	\N
384	8859	vorstand	TIEF	\N
331	4773	vorstand	HOCH	\N
331	8862	vorstand	TIEF	\N
376	6072	vorstand	TIEF	\N
352	7854	vorstand	TIEF	\N
352	8863	beirat	TIEF	\N
352	8864	vorstand	TIEF	\N
271	8865	vorstand	TIEF	\N
271	8866	geschaeftsfuehrend	TIEF	\N
271	8867	vorstand	TIEF	\N
271	8868	vorstand	TIEF	\N
271	1976	mitglied	TIEF	\N
271	8869	mitglied	TIEF	\N
210	161	vorstand	MITTEL	\N
429	8882	vorstand	TIEF	\N
341	8882	vorstand	TIEF	\N
106	8882	vorstand	TIEF	\N
318	8882	vorstand	TIEF	\N
159	8882	vorstand	TIEF	\N
371	8882	mitglied	TIEF	\N
355	8882	mitglied	TIEF	\N
369	8882	mitglied	TIEF	\N
392	8882	mitglied	TIEF	\N
83	8882	mitglied	TIEF	\N
144	8882	mitglied	TIEF	\N
418	8882	mitglied	TIEF	\N
384	8882	mitglied	TIEF	\N
380	8882	mitglied	TIEF	\N
428	8883	mitglied	TIEF	\N
264	8883	mitglied	TIEF	\N
368	8883	mitglied	TIEF	\N
364	8883	mitglied	TIEF	\N
305	7825	beirat	TIEF	\N
278	7825	beirat	TIEF	\N
420	7825	beirat	TIEF	\N
437	2226	vorstand	TIEF	\N
382	8883	mitglied	TIEF	\N
437	8883	mitglied	TIEF	\N
329	8883	mitglied	TIEF	\N
351	8883	mitglied	TIEF	\N
293	8883	mitglied	TIEF	\N
296	8883	mitglied	TIEF	\N
367	8883	mitglied	TIEF	\N
332	8883	mitglied	TIEF	\N
159	8883	mitglied	TIEF	\N
168	8883	mitglied	TIEF	\N
410	8883	mitglied	TIEF	\N
411	8883	mitglied	TIEF	\N
378	8883	mitglied	TIEF	\N
171	8883	mitglied	TIEF	\N
416	8883	mitglied	TIEF	\N
418	8883	mitglied	TIEF	\N
334	8883	mitglied	TIEF	\N
422	8883	mitglied	TIEF	\N
335	8883	mitglied	TIEF	\N
310	8883	mitglied	TIEF	\N
211	8883	mitglied	TIEF	\N
366	8883	mitglied	TIEF	\N
426	8883	mitglied	TIEF	\N
396	8885	geschaeftsfuehrend	TIEF	\N
264	8886	vorstand	TIEF	\N
340	8889	vorstand	TIEF	\N
393	8890	vorstand	TIEF	\N
88	8891	vorstand	TIEF	\N
102	6399	beirat	MITTEL	\N
329	5641	vorstand	MITTEL	\N
14	181	vorstand	HOCH	\N
410	7085	vorstand	TIEF	\N
379	8895	beirat	TIEF	\N
379	8896	vorstand	MITTEL	\N
379	8897	mitglied	TIEF	\N
346	733	vorstand	TIEF	\N
419	8898	beirat	TIEF	\N
306	3518	taetig	TIEF	\N
153	1268	vorstand	TIEF	\N
355	3530	beirat	TIEF	\N
341	8913	vorstand	TIEF	\N
380	6658	geschaeftsfuehrend	TIEF	\N
304	3845	vorstand	MITTEL	\N
261	4111	mitglied	TIEF	\N
40	4111	mitglied	TIEF	\N
41	4111	mitglied	TIEF	\N
355	4111	mitglied	TIEF	\N
358	4111	mitglied	TIEF	\N
270	4111	mitglied	TIEF	\N
271	4111	mitglied	TIEF	\N
63	4111	mitglied	TIEF	\N
65	4111	mitglied	TIEF	\N
66	4111	mitglied	TIEF	\N
275	4111	mitglied	TIEF	\N
383	4111	mitglied	TIEF	\N
277	4111	mitglied	TIEF	\N
341	4111	mitglied	TIEF	\N
393	4111	mitglied	TIEF	\N
76	4111	mitglied	TIEF	\N
79	4111	mitglied	TIEF	\N
432	4111	mitglied	TIEF	\N
395	4111	mitglied	TIEF	\N
83	4111	mitglied	TIEF	\N
356	4111	mitglied	TIEF	\N
376	4111	mitglied	TIEF	\N
227	4111	mitglied	TIEF	\N
96	4111	mitglied	TIEF	\N
283	4111	mitglied	TIEF	\N
427	4111	mitglied	TIEF	\N
102	4111	mitglied	TIEF	\N
343	4111	mitglied	TIEF	\N
228	4111	mitglied	TIEF	\N
116	4111	mitglied	TIEF	\N
317	4111	mitglied	TIEF	\N
402	4111	mitglied	TIEF	\N
399	4111	mitglied	TIEF	\N
14	4111	mitglied	TIEF	\N
318	4111	mitglied	TIEF	\N
149	4111	mitglied	TIEF	\N
153	4111	mitglied	TIEF	\N
154	4111	mitglied	TIEF	\N
298	4111	mitglied	TIEF	\N
333	4111	mitglied	TIEF	\N
299	4111	mitglied	TIEF	\N
166	4111	mitglied	TIEF	\N
178	4111	mitglied	TIEF	\N
331	4111	mitglied	TIEF	\N
436	4111	mitglied	TIEF	\N
301	4111	mitglied	TIEF	\N
305	4111	mitglied	TIEF	\N
384	4111	mitglied	TIEF	\N
387	4111	mitglied	TIEF	\N
198	4111	mitglied	TIEF	\N
167	4111	mitglied	TIEF	\N
421	4111	mitglied	TIEF	\N
361	4111	mitglied	TIEF	\N
211	4111	mitglied	TIEF	\N
363	4111	mitglied	TIEF	\N
312	4111	mitglied	TIEF	\N
439	8928	vorstand	TIEF	\N
439	8929	vorstand	TIEF	\N
439	8931	vorstand	TIEF	\N
439	8933	vorstand	TIEF	\N
439	1770	vorstand	TIEF	\N
439	8935	vorstand	TIEF	\N
439	805	vorstand	TIEF	\N
439	5207	vorstand	MITTEL	\N
439	8936	vorstand	TIEF	\N
219	3888	beirat	TIEF	\N
376	2425	vorstand	MITTEL	\N
381	8943	beirat	TIEF	\N
144	1307	mitglied	TIEF	\N
414	1533	mitglied	TIEF	\N
374	40	beirat	MITTEL	\N
40	7885	beirat	TIEF	\N
400	7885	beirat	TIEF	\N
51	8235	vorstand	TIEF	\N
419	6615	vorstand	TIEF	\N
417	657	vorstand	MITTEL	\N
417	8960	vorstand	TIEF	\N
406	4926	mitglied	TIEF	\N
352	4926	mitglied	TIEF	\N
153	8959	vorstand	MITTEL	\N
419	8363	mitglied	TIEF	\N
406	2151	mitglied	TIEF	\N
399	2151	mitglied	TIEF	\N
363	2298	vorstand	MITTEL	\N
149	2298	mitglied	TIEF	\N
284	2298	mitglied	TIEF	\N
414	5119	mitglied	TIEF	\N
348	8883	mitglied	TIEF	\N
110	8883	mitglied	TIEF	\N
396	8883	mitglied	TIEF	\N
348	8966	vorstand	TIEF	\N
125	8966	vorstand	TIEF	\N
419	8966	vorstand	TIEF	\N
65	7833	vorstand	TIEF	\N
51	7833	mitglied	TIEF	\N
439	7833	mitglied	TIEF	\N
358	3954	mitglied	TIEF	\N
369	3954	mitglied	TIEF	\N
330	3954	mitglied	TIEF	\N
437	3954	mitglied	TIEF	\N
433	3954	mitglied	TIEF	\N
404	3954	mitglied	TIEF	\N
378	3954	mitglied	TIEF	\N
416	3954	mitglied	TIEF	\N
437	5823	mitglied	TIEF	\N
340	657	vorstand	MITTEL	\N
429	5877	vorstand	HOCH	\N
361	5799	vorstand	HOCH	\N
273	8982	gesellschafter	TIEF	\N
185	8983	vorstand	TIEF	\N
400	6479	vorstand	TIEF	\N
319	8985	vorstand	TIEF	\N
430	8965	vorstand	TIEF	\N
40	8965	mitglied	TIEF	\N
327	8965	mitglied	TIEF	\N
154	8965	mitglied	TIEF	\N
410	8965	mitglied	TIEF	\N
411	8965	mitglied	TIEF	\N
429	2855	mitglied	TIEF	\N
438	2855	mitglied	TIEF	\N
382	2855	mitglied	TIEF	\N
437	2855	mitglied	TIEF	\N
433	2855	mitglied	TIEF	\N
154	2855	mitglied	TIEF	\N
431	2855	mitglied	TIEF	\N
188	7833	mitglied	TIEF	\N
429	177	beirat	MITTEL	\N
429	1502	beirat	MITTEL	\N
79	177	beirat	MITTEL	\N
79	8993	beirat	TIEF	\N
405	8994	geschaeftsfuehrend	TIEF	\N
386	8995	vorstand	TIEF	\N
333	7520	vorstand	TIEF	\N
400	8996	vorstand	TIEF	\N
439	8932	vorstand	TIEF	\N
53	8998	vorstand	TIEF	\N
333	7519	vorstand	TIEF	\N
272	7368	vorstand	MITTEL	\N
394	1770	vorstand	TIEF	\N
394	999	vorstand	TIEF	\N
402	8340	vorstand	TIEF	\N
402	8999	vorstand	TIEF	\N
393	9000	vorstand	TIEF	\N
393	5091	beirat	MITTEL	\N
330	979	vorstand	HOCH	\N
419	524	vorstand	TIEF	\N
437	1622	mitglied	TIEF	\N
439	1622	mitglied	TIEF	\N
387	366	vorstand	MITTEL	\N
328	5633	vorstand	TIEF	\N
441	9007	vorstand	TIEF	\N
441	1183	vorstand	MITTEL	\N
441	9008	vorstand	TIEF	\N
441	9009	vorstand	TIEF	\N
441	9010	beirat	TIEF	\N
441	9011	vorstand	TIEF	\N
441	9012	gesellschafter	TIEF	\N
441	9013	geschaeftsfuehrend	TIEF	\N
441	7805	vorstand	TIEF	\N
441	9014	vorstand	TIEF	\N
441	9015	mitglied	TIEF	\N
441	9016	vorstand	TIEF	\N
441	9017	vorstand	TIEF	\N
441	9018	vorstand	TIEF	\N
441	9019	vorstand	TIEF	\N
441	9020	vorstand	TIEF	\N
441	9021	vorstand	TIEF	\N
441	9022	vorstand	TIEF	\N
441	9023	mitglied	TIEF	\N
441	9024	mitglied	TIEF	\N
441	2936	taetig	MITTEL	\N
441	7761	taetig	TIEF	\N
441	9025	vorstand	TIEF	\N
440	2354	vorstand	MITTEL	\N
440	9027	vorstand	TIEF	\N
441	9029	vorstand	TIEF	\N
273	9031	vorstand	TIEF	\N
374	8337	vorstand	TIEF	\N
251	248	vorstand	TIEF	\N
251	5173	vorstand	HOCH	\N
373	621	beirat	MITTEL	\N
388	9034	vorstand	TIEF	\N
388	924	vorstand	TIEF	\N
315	9035	vorstand	TIEF	\N
374	9036	vorstand	TIEF	\N
345	9037	beirat	TIEF	\N
441	9038	mitglied	TIEF	\N
432	6567	taetig	MITTEL	\N
371	603	mitglied	TIEF	\N
371	9045	mitglied	TIEF	\N
371	9046	mitglied	TIEF	\N
371	1771	mitglied	TIEF	\N
437	9049	vorstand	TIEF	\N
328	5634	vorstand	TIEF	\N
335	5189	vorstand	TIEF	\N
110	8965	mitglied	TIEF	\N
301	8239	mitglied	TIEF	\N
40	9048	vorstand	TIEF	\N
390	9048	vorstand	TIEF	\N
102	9048	vorstand	TIEF	\N
419	9048	vorstand	TIEF	\N
431	9048	vorstand	TIEF	\N
438	9048	mitglied	TIEF	\N
110	9048	mitglied	TIEF	\N
433	9048	mitglied	TIEF	\N
144	9048	mitglied	TIEF	\N
367	9048	mitglied	TIEF	\N
331	9048	mitglied	TIEF	\N
304	9048	mitglied	TIEF	\N
422	9048	mitglied	TIEF	\N
354	9048	mitglied	TIEF	\N
441	1622	mitglied	TIEF	\N
51	2493	mitglied	TIEF	\N
440	2428	mitglied	TIEF	\N
439	9051	vorstand	TIEF	\N
381	9054	vorstand	TIEF	\N
419	7222	vorstand	MITTEL	\N
352	9055	vorstand	TIEF	\N
429	9056	mitglied	TIEF	\N
354	581	mitglied	TIEF	\N
354	9057	beirat	TIEF	\N
380	8965	vorstand	TIEF	\N
437	1774	mitglied	TIEF	\N
60	8966	vorstand	TIEF	\N
318	9087	mitglied	TIEF	\N
384	4109	mitglied	TIEF	\N
66	9222	vorstand	HOCH	\N
316	1675	vorstand	HOCH	\N
316	7719	vorstand	TIEF	\N
98	9067	mitglied	TIEF	\N
98	7337	mitglied	TIEF	\N
83	9069	vorstand	TIEF	\N
406	9073	vorstand	TIEF	\N
198	161	taetig	MITTEL	\N
198	8343	vorstand	TIEF	\N
198	9074	vorstand	TIEF	\N
198	9075	vorstand	TIEF	\N
433	9076	vorstand	TIEF	\N
425	9076	vorstand	TIEF	\N
357	9077	beirat	TIEF	\N
357	9078	vorstand	TIEF	\N
357	7688	geschaeftsfuehrend	TIEF	\N
357	9079	beirat	TIEF	\N
438	7368	vorstand	HOCH	\N
341	2225	vorstand	TIEF	\N
323	293	vorstand	MITTEL	\N
387	4109	vorstand	MITTEL	\N
417	6850	vorstand	TIEF	\N
417	7888	vorstand	TIEF	\N
381	9222	vorstand	MITTEL	\N
11	4095	vorstand	TIEF	\N
318	6568	vorstand	HOCH	\N
371	9087	mitglied	TIEF	\N
63	9087	mitglied	TIEF	\N
388	9087	mitglied	TIEF	\N
314	9087	mitglied	TIEF	\N
125	9087	mitglied	TIEF	\N
400	9087	mitglied	TIEF	\N
332	9087	mitglied	TIEF	\N
147	9087	mitglied	TIEF	\N
161	9087	mitglied	TIEF	\N
248	9087	mitglied	TIEF	\N
361	9087	mitglied	TIEF	\N
366	9087	mitglied	TIEF	\N
426	9087	mitglied	TIEF	\N
319	2476	vorstand	MITTEL	\N
391	6259	geschaeftsfuehrend	MITTEL	\N
370	5827	beirat	TIEF	\N
370	9089	beirat	MITTEL	\N
167	3761	geschaeftsfuehrend	TIEF	\N
116	4017	vorstand	TIEF	\N
364	4017	vorstand	TIEF	\N
439	9090	vorstand	TIEF	\N
340	9092	vorstand	TIEF	\N
340	9095	vorstand	TIEF	\N
361	5488	vorstand	HOCH	\N
402	9102	gesellschafter	TIEF	\N
363	1136	vorstand	HOCH	\N
402	9106	vorstand	TIEF	\N
297	9108	vorstand	TIEF	\N
316	5181	vorstand	HOCH	\N
388	9109	vorstand	TIEF	\N
40	9111	vorstand	TIEF	\N
400	9111	vorstand	TIEF	\N
429	9111	vorstand	TIEF	\N
357	9111	vorstand	TIEF	\N
395	9111	vorstand	TIEF	\N
396	9112	vorstand	HOCH	\N
439	1504	mitglied	TIEF	\N
182	477	vorstand	MITTEL	\N
386	7553	vorstand	HOCH	\N
331	2147	beirat	MITTEL	\N
331	9114	vorstand	MITTEL	\N
371	9116	vorstand	MITTEL	\N
371	9117	taetig	TIEF	\N
371	9118	mitglied	TIEF	\N
404	9120	vorstand	TIEF	\N
296	9116	beirat	MITTEL	\N
153	9116	beirat	MITTEL	\N
347	9116	beirat	MITTEL	\N
327	9116	beirat	MITTEL	\N
53	9116	beirat	MITTEL	\N
110	9116	beirat	MITTEL	\N
168	9116	beirat	MITTEL	\N
411	9116	beirat	MITTEL	\N
293	9116	beirat	MITTEL	\N
416	9116	beirat	MITTEL	\N
44	9124	vorstand	TIEF	\N
341	8536	beirat	MITTEL	\N
302	3177	beirat	TIEF	\N
393	9128	vorstand	TIEF	\N
383	9197	vorstand	TIEF	\N
428	9197	vorstand	TIEF	\N
331	2141	vorstand	TIEF	\N
369	7368	vorstand	HOCH	\N
296	173	mitglied	TIEF	\N
316	239	vorstand	HOCH	\N
316	1674	vorstand	HOCH	\N
392	9222	vorstand	MITTEL	\N
393	9222	vorstand	MITTEL	\N
382	9222	vorstand	HOCH	\N
380	9222	vorstand	MITTEL	\N
53	9222	vorstand	HOCH	\N
415	9222	vorstand	MITTEL	\N
361	9216	vorstand	MITTEL	\N
390	9216	vorstand	MITTEL	\N
381	9216	vorstand	MITTEL	\N
431	9216	vorstand	MITTEL	\N
44	9216	vorstand	HOCH	\N
198	9216	vorstand	MITTEL	\N
348	9217	vorstand	MITTEL	\N
293	9217	vorstand	MITTEL	\N
349	9217	vorstand	MITTEL	\N
418	9217	vorstand	MITTEL	\N
353	9217	vorstand	MITTEL	\N
335	5292	vorstand	HOCH	\N
41	2432	mitglied	TIEF	\N
389	130	vorstand	MITTEL	\N
357	9228	vorstand	TIEF	\N
438	6523	vorstand	TIEF	\N
318	3444	vorstand	TIEF	\N
170	9231	geschaeftsfuehrend	TIEF	\N
416	9232	vorstand	TIEF	\N
353	9233	vorstand	TIEF	\N
419	1079	vorstand	TIEF	\N
429	1079	vorstand	TIEF	\N
426	7772	taetig	MITTEL	\N
426	9234	taetig	TIEF	\N
310	9236	vorstand	TIEF	\N
301	9237	vorstand	TIEF	\N
383	9238	vorstand	TIEF	\N
410	2365	geschaeftsfuehrend	TIEF	\N
410	1719	mitglied	TIEF	\N
410	6786	mitglied	TIEF	\N
410	9239	mitglied	TIEF	\N
410	4285	mitglied	TIEF	\N
441	6343	vorstand	TIEF	\N
379	6343	vorstand	TIEF	\N
361	9222	vorstand	MITTEL	\N
321	5822	geschaeftsfuehrend	TIEF	\N
223	1993	vorstand	TIEF	\N
297	4645	vorstand	TIEF	\N
144	2675	mitglied	TIEF	\N
89	576	mitglied	TIEF	\N
223	1997	vorstand	TIEF	\N
223	168	vorstand	HOCH	\N
219	2001	mitglied	TIEF	\N
219	2002	mitglied	TIEF	\N
219	1999	mitglied	TIEF	\N
219	2005	vorstand	TIEF	\N
120	1928	beirat	TIEF	\N
219	459	vorstand	TIEF	\N
227	43	vorstand	MITTEL	\N
250	1951	vorstand	TIEF	\N
63	167	vorstand	TIEF	\N
79	2901	geschaeftsfuehrend	HOCH	\N
83	2906	vorstand	MITTEL	\N
287	1154	mitglied	TIEF	\N
211	2951	mitglied	TIEF	\N
211	2953	vorstand	TIEF	\N
211	2810	mitglied	TIEF	\N
211	2955	mitglied	TIEF	\N
211	2956	mitglied	TIEF	\N
211	2957	mitglied	TIEF	\N
98	2956	vorstand	MITTEL	\N
287	2958	vorstand	TIEF	\N
305	2997	mitglied	TIEF	\N
314	3114	vorstand	TIEF	\N
314	1416	vorstand	TIEF	\N
277	3287	vorstand	TIEF	\N
147	191	beirat	MITTEL	\N
192	2468	vorstand	TIEF	\N
309	3534	geschaeftsfuehrend	TIEF	\N
190	3549	gesellschafter	TIEF	\N
301	3584	vorstand	TIEF	\N
294	3398	geschaeftsfuehrend	TIEF	\N
301	3585	mitglied	TIEF	\N
301	3586	mitglied	TIEF	\N
301	3587	mitglied	TIEF	\N
273	3589	vorstand	TIEF	\N
284	3621	vorstand	TIEF	\N
285	3669	mitglied	TIEF	\N
315	3685	beirat	TIEF	\N
167	3798	vorstand	MITTEL	\N
144	3849	mitglied	TIEF	\N
166	3921	vorstand	TIEF	\N
98	3960	geschaeftsfuehrend	TIEF	\N
106	542	vorstand	MITTEL	\N
154	4035	mitglied	TIEF	\N
110	4057	vorstand	TIEF	\N
110	79	mitglied	TIEF	\N
110	576	mitglied	TIEF	\N
110	4060	mitglied	TIEF	\N
110	4061	mitglied	TIEF	\N
110	4062	mitglied	TIEF	\N
110	4063	mitglied	TIEF	\N
110	4065	mitglied	TIEF	\N
110	4066	mitglied	TIEF	\N
110	4067	mitglied	TIEF	\N
116	366	vorstand	MITTEL	\N
65	4134	taetig	TIEF	\N
83	541	taetig	MITTEL	\N
40	340	vorstand	MITTEL	\N
170	2618	geschaeftsfuehrend	TIEF	\N
261	2662	mitglied	TIEF	\N
284	4926	mitglied	TIEF	\N
159	4954	mitglied	TIEF	\N
98	4201	mitglied	TIEF	\N
144	980	mitglied	TIEF	\N
310	5000	vorstand	TIEF	\N
310	1456	vorstand	TIEF	\N
251	3154	vorstand	TIEF	\N
172	2930	vorstand	TIEF	\N
120	5047	vorstand	TIEF	\N
49	5105	vorstand	TIEF	\N
49	5061	mitglied	TIEF	\N
49	5108	mitglied	TIEF	\N
299	5133	beirat	TIEF	\N
14	5247	taetig	TIEF	\N
40	5313	beirat	TIEF	\N
285	5351	beirat	MITTEL	\N
305	5123	mitglied	TIEF	\N
40	5447	beirat	TIEF	\N
242	5471	geschaeftsfuehrend	MITTEL	\N
185	5484	mitglied	TIEF	\N
304	4471	mitglied	TIEF	\N
321	5541	beirat	TIEF	\N
327	5624	beirat	MITTEL	\N
329	989	mitglied	TIEF	\N
329	2906	mitglied	TIEF	\N
329	130	mitglied	TIEF	\N
329	381	mitglied	TIEF	\N
329	581	mitglied	TIEF	\N
328	5626	vorstand	MITTEL	\N
328	2249	mitglied	TIEF	\N
328	5637	vorstand	TIEF	\N
328	5639	vorstand	TIEF	\N
170	5657	vorstand	MITTEL	\N
294	5714	vorstand	HOCH	\N
40	524	vorstand	TIEF	\N
331	5752	vorstand	TIEF	\N
317	5767	geschaeftsfuehrend	TIEF	\N
332	340	vorstand	HOCH	\N
309	5835	geschaeftsfuehrend	TIEF	\N
284	169	beirat	MITTEL	\N
337	5889	geschaeftsfuehrend	TIEF	\N
264	5981	geschaeftsfuehrend	TIEF	\N
63	5986	geschaeftsfuehrend	TIEF	\N
294	517	geschaeftsfuehrend	MITTEL	\N
294	2641	vorstand	TIEF	\N
294	39	vorstand	HOCH	\N
294	5987	vorstand	TIEF	\N
335	555	vorstand	MITTEL	\N
96	1432	taetig	MITTEL	\N
120	6069	vorstand	TIEF	\N
147	6090	vorstand	TIEF	\N
316	154	beirat	MITTEL	\N
340	6232	vorstand	TIEF	\N
166	6289	vorstand	TIEF	\N
264	1344	beirat	TIEF	\N
161	6353	vorstand	TIEF	\N
76	6173	vorstand	TIEF	\N
41	5061	mitglied	TIEF	\N
66	6425	vorstand	TIEF	\N
318	261	vorstand	HOCH	\N
149	6431	vorstand	HOCH	\N
317	6433	mitglied	TIEF	\N
318	462	vorstand	MITTEL	\N
149	6434	vorstand	TIEF	\N
317	5131	mitglied	TIEF	\N
317	6435	mitglied	TIEF	\N
317	6436	mitglied	TIEF	\N
317	6441	mitglied	TIEF	\N
21	344	taetig	MITTEL	\N
171	4343	vorstand	TIEF	\N
171	4357	vorstand	TIEF	\N
110	6640	mitglied	TIEF	\N
227	6611	vorstand	TIEF	\N
248	6660	vorstand	TIEF	\N
349	6681	vorstand	MITTEL	\N
349	6682	taetig	MITTEL	\N
351	36	vorstand	MITTEL	\N
351	2580	vorstand	TIEF	\N
351	2581	vorstand	TIEF	\N
351	106	vorstand	MITTEL	\N
353	6695	vorstand	TIEF	\N
353	6696	vorstand	TIEF	\N
353	6698	mitglied	TIEF	\N
354	197	taetig	MITTEL	\N
330	6706	vorstand	TIEF	\N
354	71	mitglied	TIEF	\N
358	6724	vorstand	TIEF	\N
354	6736	mitglied	TIEF	\N
361	6760	mitglied	TIEF	\N
363	6774	taetig	TIEF	\N
367	4262	mitglied	TIEF	\N
374	6815	vorstand	TIEF	\N
380	6842	vorstand	TIEF	\N
384	6867	vorstand	TIEF	\N
386	130	mitglied	TIEF	\N
386	1064	mitglied	TIEF	\N
386	603	mitglied	TIEF	\N
386	697	mitglied	TIEF	\N
386	6870	mitglied	TIEF	\N
387	6883	vorstand	TIEF	\N
390	1178	mitglied	TIEF	\N
391	6908	vorstand	TIEF	\N
398	6939	vorstand	TIEF	\N
416	6953	vorstand	TIEF	\N
415	6971	vorstand	TIEF	\N
415	6979	mitglied	TIEF	\N
411	6995	vorstand	TIEF	\N
424	7016	vorstand	TIEF	\N
410	7073	vorstand	TIEF	\N
410	7086	vorstand	TIEF	\N
410	6524	beirat	TIEF	\N
410	7088	gesellschafter	TIEF	\N
402	657	vorstand	MITTEL	\N
402	6506	beirat	TIEF	\N
144	5359	vorstand	HOCH	\N
51	5813	vorstand	TIEF	\N
347	1971	taetig	TIEF	\N
378	7137	beirat	TIEF	\N
386	3627	mitglied	TIEF	\N
370	7218	vorstand	TIEF	\N
396	7308	geschaeftsfuehrend	HOCH	\N
425	7403	vorstand	TIEF	\N
309	682	vorstand	TIEF	\N
89	3407	mitglied	TIEF	\N
63	5189	vorstand	TIEF	\N
406	5189	mitglied	TIEF	\N
296	5189	mitglied	TIEF	\N
411	5189	mitglied	TIEF	\N
248	5189	mitglied	TIEF	\N
331	5189	mitglied	TIEF	\N
384	5189	mitglied	TIEF	\N
40	4983	mitglied	TIEF	\N
53	4983	mitglied	TIEF	\N
65	4983	mitglied	TIEF	\N
393	4983	mitglied	TIEF	\N
280	4983	mitglied	TIEF	\N
382	4983	mitglied	TIEF	\N
356	7594	vorstand	TIEF	\N
89	7594	mitglied	TIEF	\N
406	7594	mitglied	TIEF	\N
417	7594	mitglied	TIEF	\N
40	7595	mitglied	TIEF	\N
261	2020	mitglied	TIEF	\N
376	2020	mitglied	TIEF	\N
171	2020	mitglied	TIEF	\N
368	2111	mitglied	TIEF	\N
390	2111	mitglied	TIEF	\N
341	2111	mitglied	TIEF	\N
83	2111	mitglied	TIEF	\N
89	2111	mitglied	TIEF	\N
381	2111	mitglied	TIEF	\N
102	2111	mitglied	TIEF	\N
106	2111	mitglied	TIEF	\N
228	2111	mitglied	TIEF	\N
125	2111	mitglied	TIEF	\N
402	2111	mitglied	TIEF	\N
357	2111	mitglied	TIEF	\N
65	6354	mitglied	TIEF	\N
285	6354	mitglied	TIEF	\N
171	6354	mitglied	TIEF	\N
284	2124	mitglied	TIEF	\N
144	2124	mitglied	TIEF	\N
416	2124	mitglied	TIEF	\N
261	637	mitglied	TIEF	\N
395	637	mitglied	TIEF	\N
125	637	mitglied	TIEF	\N
416	637	mitglied	TIEF	\N
418	637	mitglied	TIEF	\N
349	637	mitglied	TIEF	\N
304	637	mitglied	TIEF	\N
192	637	mitglied	TIEF	\N
334	637	mitglied	TIEF	\N
361	637	mitglied	TIEF	\N
251	637	mitglied	TIEF	\N
310	637	mitglied	TIEF	\N
380	637	mitglied	TIEF	\N
316	7596	vorstand	TIEF	\N
261	7596	mitglied	TIEF	\N
340	1750	mitglied	TIEF	\N
98	1750	mitglied	TIEF	\N
339	1750	mitglied	TIEF	\N
302	1750	mitglied	TIEF	\N
275	5204	mitglied	TIEF	\N
357	5204	mitglied	TIEF	\N
102	1454	mitglied	TIEF	\N
376	2226	mitglied	TIEF	\N
346	1774	mitglied	TIEF	\N
340	3589	mitglied	TIEF	\N
388	3589	mitglied	TIEF	\N
381	3589	mitglied	TIEF	\N
402	3589	mitglied	TIEF	\N
318	3589	mitglied	TIEF	\N
154	3589	mitglied	TIEF	\N
333	3589	mitglied	TIEF	\N
415	3589	mitglied	TIEF	\N
361	3589	mitglied	TIEF	\N
321	3589	mitglied	TIEF	\N
285	1761	vorstand	TIEF	\N
371	1761	mitglied	TIEF	\N
415	1761	mitglied	TIEF	\N
370	4976	mitglied	TIEF	\N
388	1505	mitglied	TIEF	\N
154	1505	mitglied	TIEF	\N
14	6575	taetig	TIEF	\N
83	6240	gesellschafter	TIEF	\N
120	1851	vorstand	TIEF	\N
321	1851	vorstand	TIEF	\N
51	1851	vorstand	TIEF	\N
171	1851	vorstand	TIEF	\N
65	1851	mitglied	TIEF	\N
333	1851	mitglied	TIEF	\N
89	5334	mitglied	TIEF	\N
340	1852	vorstand	TIEF	\N
144	1852	mitglied	TIEF	\N
415	459	mitglied	TIEF	\N
396	5151	mitglied	TIEF	\N
171	2127	mitglied	TIEF	\N
417	2828	mitglied	TIEF	\N
110	6068	mitglied	TIEF	\N
102	4959	mitglied	TIEF	\N
421	4959	mitglied	TIEF	\N
310	4959	mitglied	TIEF	\N
366	4959	mitglied	TIEF	\N
380	4959	mitglied	TIEF	\N
261	1623	mitglied	TIEF	\N
323	1623	mitglied	TIEF	\N
330	1623	mitglied	TIEF	\N
389	1623	mitglied	TIEF	\N
390	1623	mitglied	TIEF	\N
280	1623	mitglied	TIEF	\N
79	1623	mitglied	TIEF	\N
381	1623	mitglied	TIEF	\N
422	1623	mitglied	TIEF	\N
284	1858	mitglied	TIEF	\N
168	1858	mitglied	TIEF	\N
280	524	mitglied	TIEF	\N
168	524	mitglied	TIEF	\N
6	5964	mitglied	TIEF	\N
333	5964	mitglied	TIEF	\N
307	5964	mitglied	TIEF	\N
334	5965	mitglied	TIEF	\N
392	2855	mitglied	TIEF	\N
280	2855	mitglied	TIEF	\N
106	2855	mitglied	TIEF	\N
396	2855	mitglied	TIEF	\N
125	2855	mitglied	TIEF	\N
402	2855	mitglied	TIEF	\N
357	2855	mitglied	TIEF	\N
367	2855	mitglied	TIEF	\N
333	2855	mitglied	TIEF	\N
411	2855	mitglied	TIEF	\N
171	2855	mitglied	TIEF	\N
192	2855	mitglied	TIEF	\N
382	3318	mitglied	TIEF	\N
349	3318	mitglied	TIEF	\N
335	7599	mitglied	TIEF	\N
411	5840	mitglied	TIEF	\N
65	886	mitglied	TIEF	\N
154	886	mitglied	TIEF	\N
110	5291	mitglied	TIEF	\N
393	2415	mitglied	TIEF	\N
418	2415	mitglied	TIEF	\N
318	5348	vorstand	TIEF	\N
340	5348	mitglied	TIEF	\N
381	5348	mitglied	TIEF	\N
381	2416	mitglied	TIEF	\N
110	2416	mitglied	TIEF	\N
357	2416	mitglied	TIEF	\N
296	2416	mitglied	TIEF	\N
96	3176	mitglied	TIEF	\N
366	3176	mitglied	TIEF	\N
314	4958	mitglied	TIEF	\N
261	2793	mitglied	TIEF	\N
283	2793	mitglied	TIEF	\N
172	2793	mitglied	TIEF	\N
335	5024	vorstand	TIEF	\N
83	5024	mitglied	TIEF	\N
297	5024	mitglied	TIEF	\N
211	5024	mitglied	TIEF	\N
381	890	mitglied	TIEF	\N
102	890	mitglied	TIEF	\N
406	890	mitglied	TIEF	\N
293	890	mitglied	TIEF	\N
339	890	mitglied	TIEF	\N
144	890	mitglied	TIEF	\N
357	890	mitglied	TIEF	\N
296	890	mitglied	TIEF	\N
332	890	mitglied	TIEF	\N
154	890	mitglied	TIEF	\N
168	890	mitglied	TIEF	\N
416	890	mitglied	TIEF	\N
379	6135	vorstand	TIEF	\N
66	1751	mitglied	TIEF	\N
228	1751	mitglied	TIEF	\N
144	1751	mitglied	TIEF	\N
168	1751	mitglied	TIEF	\N
304	1751	mitglied	TIEF	\N
321	1751	mitglied	TIEF	\N
171	7600	mitglied	TIEF	\N
60	5232	mitglied	TIEF	\N
333	5232	mitglied	TIEF	\N
415	5232	mitglied	TIEF	\N
178	5232	mitglied	TIEF	\N
416	5232	mitglied	TIEF	\N
379	5232	mitglied	TIEF	\N
21	5232	mitglied	TIEF	\N
190	5232	mitglied	TIEF	\N
384	5232	mitglied	TIEF	\N
210	5232	mitglied	TIEF	\N
335	5232	mitglied	TIEF	\N
345	5232	mitglied	TIEF	\N
65	1622	mitglied	TIEF	\N
289	1622	mitglied	TIEF	\N
310	1622	mitglied	TIEF	\N
242	4580	mitglied	TIEF	\N
327	6437	mitglied	TIEF	\N
261	2899	mitglied	TIEF	\N
116	2899	mitglied	TIEF	\N
333	2899	mitglied	TIEF	\N
305	2899	mitglied	TIEF	\N
51	5978	mitglied	TIEF	\N
101	5978	mitglied	TIEF	\N
285	5978	mitglied	TIEF	\N
328	5978	mitglied	TIEF	\N
228	5978	mitglied	TIEF	\N
317	5978	mitglied	TIEF	\N
120	5978	mitglied	TIEF	\N
289	5978	mitglied	TIEF	\N
125	5978	mitglied	TIEF	\N
294	5978	mitglied	TIEF	\N
250	5978	mitglied	TIEF	\N
367	5978	mitglied	TIEF	\N
315	465	vorstand	TIEF	\N
6	465	vorstand	TIEF	\N
166	2493	mitglied	TIEF	\N
219	1852	mitglied	TIEF	\N
6	5842	vorstand	TIEF	\N
278	7706	mitglied	TIEF	\N
21	7707	geschaeftsfuehrend	TIEF	\N
21	7708	vorstand	TIEF	\N
60	517	vorstand	MITTEL	\N
298	7714	geschaeftsfuehrend	MITTEL	\N
318	7723	vorstand	TIEF	\N
327	1533	mitglied	TIEF	\N
390	7595	mitglied	TIEF	\N
264	1774	mitglied	TIEF	\N
364	4247	mitglied	TIEF	\N
49	459	mitglied	TIEF	\N
357	1661	mitglied	TIEF	\N
390	4111	mitglied	TIEF	\N
168	2677	mitglied	TIEF	\N
334	2677	mitglied	TIEF	\N
364	2855	mitglied	TIEF	\N
388	7599	mitglied	TIEF	\N
364	6213	mitglied	TIEF	\N
382	886	mitglied	TIEF	\N
310	886	mitglied	TIEF	\N
310	5548	mitglied	TIEF	\N
357	5291	mitglied	TIEF	\N
335	5291	mitglied	TIEF	\N
355	5047	mitglied	TIEF	\N
406	5047	mitglied	TIEF	\N
306	5047	mitglied	TIEF	\N
410	5979	mitglied	TIEF	\N
102	2415	vorstand	HOCH	\N
337	7747	vorstand	TIEF	\N
289	126	vorstand	TIEF	\N
49	989	mitglied	TIEF	\N
347	7116	vorstand	MITTEL	\N
167	3873	vorstand	TIEF	\N
305	7368	vorstand	MITTEL	\N
390	3316	vorstand	TIEF	\N
185	972	vorstand	TIEF	\N
410	6542	vorstand	TIEF	\N
363	4397	vorstand	MITTEL	\N
44	7815	vorstand	TIEF	\N
368	364	mitglied	TIEF	\N
368	7816	mitglied	TIEF	\N
368	7817	mitglied	TIEF	\N
102	126	vorstand	TIEF	\N
321	7826	mitglied	TIEF	\N
6	7703	gesellschafter	TIEF	\N
378	7831	mitglied	TIEF	\N
192	886	mitglied	TIEF	\N
366	1817	vorstand	MITTEL	\N
297	2143	mitglied	TIEF	\N
343	2728	geschaeftsfuehrend	TIEF	\N
370	5223	vorstand	HOCH	\N
307	440	mitglied	TIEF	\N
40	7924	mitglied	TIEF	\N
371	7924	mitglied	TIEF	\N
368	7924	mitglied	TIEF	\N
330	7924	mitglied	TIEF	\N
280	7924	mitglied	TIEF	\N
374	7924	mitglied	TIEF	\N
125	7924	mitglied	TIEF	\N
367	7924	mitglied	TIEF	\N
304	7924	mitglied	TIEF	\N
410	5963	mitglied	TIEF	\N
403	7925	vorstand	TIEF	\N
310	577	vorstand	TIEF	\N
410	2856	mitglied	TIEF	\N
379	7833	mitglied	TIEF	\N
387	7932	vorstand	TIEF	\N
315	1278	mitglied	TIEF	\N
402	1278	mitglied	TIEF	\N
248	1278	mitglied	TIEF	\N
345	459	mitglied	TIEF	\N
63	3777	vorstand	TIEF	\N
358	8098	vorstand	TIEF	\N
314	8098	vorstand	TIEF	\N
371	8098	mitglied	TIEF	\N
53	8098	mitglied	TIEF	\N
383	8098	mitglied	TIEF	\N
102	8098	mitglied	TIEF	\N
106	8098	mitglied	TIEF	\N
403	8098	mitglied	TIEF	\N
367	8098	mitglied	TIEF	\N
154	8098	mitglied	TIEF	\N
428	8102	vorstand	TIEF	\N
333	1622	vorstand	TIEF	\N
402	8154	beirat	TIEF	\N
387	8163	vorstand	TIEF	\N
370	1350	vorstand	HOCH	\N
310	2124	mitglied	TIEF	\N
293	8209	mitglied	TIEF	\N
371	459	mitglied	TIEF	\N
65	459	mitglied	TIEF	\N
171	459	mitglied	TIEF	\N
355	3318	mitglied	TIEF	\N
185	8217	vorstand	TIEF	\N
370	8234	vorstand	HOCH	\N
40	8238	vorstand	TIEF	\N
390	8238	vorstand	TIEF	\N
341	8238	vorstand	TIEF	\N
357	8238	vorstand	TIEF	\N
318	8238	vorstand	TIEF	\N
149	8238	vorstand	TIEF	\N
298	8238	vorstand	TIEF	\N
168	8238	vorstand	TIEF	\N
182	8238	vorstand	TIEF	\N
340	8240	mitglied	TIEF	\N
319	8240	mitglied	TIEF	\N
388	2548	mitglied	TIEF	\N
382	2857	mitglied	TIEF	\N
211	5039	mitglied	TIEF	\N
421	1889	mitglied	TIEF	\N
154	3954	mitglied	TIEF	\N
316	5655	mitglied	TIEF	\N
355	6120	mitglied	TIEF	\N
83	6120	mitglied	TIEF	\N
89	6120	mitglied	TIEF	\N
376	6120	mitglied	TIEF	\N
283	6120	mitglied	TIEF	\N
102	6120	mitglied	TIEF	\N
110	6120	mitglied	TIEF	\N
228	6120	mitglied	TIEF	\N
337	6120	mitglied	TIEF	\N
332	6120	mitglied	TIEF	\N
341	2428	mitglied	TIEF	\N
402	2428	mitglied	TIEF	\N
312	2428	mitglied	TIEF	\N
310	4931	mitglied	TIEF	\N
83	3893	mitglied	TIEF	\N
89	5823	mitglied	TIEF	\N
227	5969	mitglied	TIEF	\N
40	2898	mitglied	TIEF	\N
341	7700	vorstand	TIEF	\N
51	7702	vorstand	TIEF	\N
340	8506	mitglied	TIEF	\N
437	6453	vorstand	TIEF	\N
185	5279	mitglied	TIEF	\N
437	8795	taetig	TIEF	\N
332	8635	mitglied	TIEF	\N
307	5279	mitglied	TIEF	\N
211	5279	mitglied	TIEF	\N
65	2253	mitglied	TIEF	\N
285	5971	mitglied	TIEF	\N
379	5971	mitglied	TIEF	\N
329	8255	mitglied	TIEF	\N
83	1456	mitglied	TIEF	\N
285	6208	mitglied	TIEF	\N
388	8256	mitglied	TIEF	\N
370	8256	mitglied	TIEF	\N
355	8258	vorstand	TIEF	\N
390	169	beirat	MITTEL	\N
430	8266	vorstand	MITTEL	\N
430	367	mitglied	TIEF	\N
430	8267	beirat	TIEF	\N
430	8268	mitglied	TIEF	\N
430	8269	mitglied	TIEF	\N
430	8271	vorstand	TIEF	\N
430	4937	vorstand	TIEF	\N
430	4939	vorstand	TIEF	\N
431	8272	beirat	TIEF	\N
431	541	vorstand	MITTEL	\N
411	6354	mitglied	TIEF	\N
310	7925	mitglied	TIEF	\N
402	8277	mitglied	TIEF	\N
430	8277	mitglied	TIEF	\N
378	1622	mitglied	TIEF	\N
429	8278	vorstand	TIEF	\N
341	8284	beirat	TIEF	\N
354	8290	mitglied	TIEF	\N
416	8295	beirat	TIEF	\N
102	1504	vorstand	TIEF	\N
390	1504	beirat	TIEF	\N
395	1504	beirat	TIEF	\N
329	1504	beirat	TIEF	\N
390	6472	beirat	TIEF	\N
223	8337	vorstand	TIEF	\N
369	8338	vorstand	MITTEL	\N
106	8339	vorstand	TIEF	\N
110	402	beirat	MITTEL	\N
405	7774	gesellschafter	TIEF	\N
421	5190	vorstand	MITTEL	\N
14	6068	mitglied	TIEF	\N
305	5841	vorstand	TIEF	\N
333	8390	beirat	TIEF	\N
337	4157	vorstand	TIEF	\N
299	4157	mitglied	TIEF	\N
331	5305	mitglied	TIEF	\N
433	1408	mitglied	TIEF	\N
380	1851	vorstand	TIEF	\N
102	1108	vorstand	MITTEL	\N
382	1108	vorstand	HOCH	\N
392	6354	mitglied	TIEF	\N
392	8239	mitglied	TIEF	\N
420	8239	mitglied	TIEF	\N
400	2548	mitglied	TIEF	\N
316	8209	mitglied	TIEF	\N
374	8209	mitglied	TIEF	\N
348	5840	mitglied	TIEF	\N
314	8472	vorstand	TIEF	\N
106	8567	mitglied	TIEF	\N
280	8635	mitglied	TIEF	\N
331	8635	mitglied	TIEF	\N
340	2899	mitglied	TIEF	\N
299	2857	vorstand	TIEF	\N
190	8510	geschaeftsfuehrend	TIEF	\N
264	581	vorstand	MITTEL	\N
328	8535	vorstand	TIEF	\N
430	5189	mitglied	TIEF	\N
294	2111	mitglied	TIEF	\N
331	2111	mitglied	TIEF	\N
301	1750	mitglied	TIEF	\N
340	7596	mitglied	TIEF	\N
402	7596	mitglied	TIEF	\N
384	7596	mitglied	TIEF	\N
337	8505	mitglied	TIEF	\N
410	8567	mitglied	TIEF	\N
89	8152	mitglied	TIEF	\N
421	8152	mitglied	TIEF	\N
301	2899	mitglied	TIEF	\N
192	5109	mitglied	TIEF	\N
417	4926	vorstand	MITTEL	\N
314	583	vorstand	MITTEL	\N
354	7786	vorstand	TIEF	\N
316	8501	vorstand	TIEF	\N
399	8505	mitglied	TIEF	\N
416	8635	mitglied	TIEF	\N
304	8635	mitglied	TIEF	\N
334	8635	mitglied	TIEF	\N
211	8635	mitglied	TIEF	\N
433	1622	mitglied	TIEF	\N
430	1622	mitglied	TIEF	\N
430	5977	mitglied	TIEF	\N
125	8636	vorstand	TIEF	\N
378	8636	mitglied	TIEF	\N
102	8700	beirat	TIEF	\N
374	5471	geschaeftsfuehrend	MITTEL	\N
168	807	vorstand	MITTEL	\N
370	7598	mitglied	TIEF	\N
161	8719	mitglied	TIEF	\N
333	2128	mitglied	TIEF	\N
171	344	taetig	MITTEL	\N
166	5279	mitglied	TIEF	\N
171	5279	mitglied	TIEF	\N
328	8794	vorstand	TIEF	\N
369	7825	beirat	TIEF	\N
418	7825	beirat	TIEF	\N
210	7825	beirat	TIEF	\N
297	7825	beirat	TIEF	\N
328	7825	beirat	TIEF	\N
120	7825	beirat	TIEF	\N
353	7825	beirat	TIEF	\N
391	7825	beirat	TIEF	\N
44	8796	taetig	TIEF	\N
333	8807	vorstand	TIEF	\N
418	1505	mitglied	TIEF	\N
364	1622	mitglied	TIEF	\N
65	8815	mitglied	TIEF	\N
383	1455	mitglied	TIEF	\N
321	7928	vorstand	TIEF	\N
414	7041	vorstand	TIEF	\N
333	8882	mitglied	TIEF	\N
424	8883	mitglied	TIEF	\N
429	8883	mitglied	TIEF	\N
383	8883	mitglied	TIEF	\N
330	8883	mitglied	TIEF	\N
280	8883	mitglied	TIEF	\N
83	8883	mitglied	TIEF	\N
429	4111	mitglied	TIEF	\N
428	182	vorstand	MITTEL	\N
312	3596	vorstand	TIEF	\N
106	5989	vorstand	HOCH	\N
185	7644	vorstand	TIEF	\N
331	2151	mitglied	TIEF	\N
76	5119	mitglied	TIEF	\N
188	4932	mitglied	TIEF	\N
11	4410	vorstand	MITTEL	\N
223	6621	vorstand	HOCH	\N
402	8958	mitglied	TIEF	\N
333	3031	vorstand	HOCH	\N
178	3031	vorstand	MITTEL	\N
345	3031	vorstand	MITTEL	\N
166	7752	vorstand	HOCH	\N
426	8965	vorstand	TIEF	\N
388	8966	vorstand	TIEF	\N
439	3954	mitglied	TIEF	\N
438	8965	mitglied	TIEF	\N
223	8992	vorstand	TIEF	\N
429	5927	vorstand	MITTEL	\N
441	9006	vorstand	TIEF	\N
441	9030	vorstand	TIEF	\N
371	576	mitglied	TIEF	\N
391	9048	vorstand	TIEF	\N
437	2857	mitglied	TIEF	\N
102	5149	vorstand	TIEF	\N
333	8146	vorstand	MITTEL	\N
329	7368	vorstand	MITTEL	\N
424	4241	beirat	MITTEL	\N
424	9058	vorstand	TIEF	\N
110	3967	mitglied	TIEF	\N
110	9060	mitglied	TIEF	\N
110	9061	mitglied	TIEF	\N
110	9062	mitglied	TIEF	\N
49	732	geschaeftsfuehrend	TIEF	\N
153	865	vorstand	TIEF	\N
11	1055	vorstand	HOCH	\N
242	1169	vorstand	HOCH	\N
110	604	mitglied	TIEF	\N
11	9087	mitglied	TIEF	\N
335	9116	beirat	MITTEL	\N
125	9222	vorstand	MITTEL	\N
374	9222	vorstand	MITTEL	\N
302	9222	vorstand	MITTEL	\N
297	9222	vorstand	MITTEL	\N
410	1064	mitglied	TIEF	\N
410	989	mitglied	TIEF	\N
361	6671	vorstand	TIEF	\N
424	8910	beirat	TIEF	\N
335	9323	beirat	TIEF	\N
185	9340	vorstand	TIEF	\N
6	32	vorstand	MITTEL	\N
6	433	vorstand	MITTEL	\N
101	9081	vorstand	TIEF	\N
314	3122	vorstand	TIEF	\N
312	3592	vorstand	TIEF	\N
41	1512	gesellschafter	TIEF	\N
402	1052	vorstand	TIEF	\N
63	4983	mitglied	TIEF	\N
154	4983	mitglied	TIEF	\N
285	517	vorstand	MITTEL	\N
272	2947	vorstand	TIEF	\N
355	9087	mitglied	TIEF	\N
390	9087	mitglied	TIEF	\N
382	9087	mitglied	TIEF	\N
110	4069	mitglied	TIEF	\N
89	4539	mitglied	TIEF	\N
49	440	mitglied	TIEF	\N
51	5109	vorstand	TIEF	\N
227	3280	beirat	MITTEL	\N
317	3280	beirat	MITTEL	\N
210	5123	mitglied	TIEF	\N
329	674	mitglied	TIEF	\N
329	5642	mitglied	TIEF	\N
318	6428	vorstand	TIEF	\N
40	6437	vorstand	TIEF	\N
98	6492	mitglied	TIEF	\N
278	39	beirat	MITTEL	\N
339	4597	beirat	TIEF	\N
270	800	geschaeftsfuehrend	MITTEL	\N
211	6562	beirat	TIEF	\N
348	2227	vorstand	MITTEL	\N
354	25	beirat	MITTEL	\N
251	6518	mitglied	TIEF	\N
386	6869	mitglied	TIEF	\N
386	6871	mitglied	TIEF	\N
319	7095	vorstand	MITTEL	\N
66	1183	mitglied	TIEF	\N
223	1998	beirat	MITTEL	\N
219	2006	mitglied	TIEF	\N
393	2111	mitglied	TIEF	\N
144	2111	mitglied	TIEF	\N
66	2124	mitglied	TIEF	\N
421	637	mitglied	TIEF	\N
6	7596	vorstand	TIEF	\N
321	5204	mitglied	TIEF	\N
251	3589	mitglied	TIEF	\N
261	1761	mitglied	TIEF	\N
65	640	mitglied	TIEF	\N
406	640	mitglied	TIEF	\N
171	2676	mitglied	TIEF	\N
406	4247	mitglied	TIEF	\N
6	5728	mitglied	TIEF	\N
178	5728	mitglied	TIEF	\N
309	5728	mitglied	TIEF	\N
312	5728	mitglied	TIEF	\N
198	6611	vorstand	TIEF	\N
106	1851	mitglied	TIEF	\N
79	459	mitglied	TIEF	\N
383	1623	mitglied	TIEF	\N
88	1623	mitglied	TIEF	\N
317	5964	mitglied	TIEF	\N
168	2855	mitglied	TIEF	\N
102	5966	mitglied	TIEF	\N
410	2416	mitglied	TIEF	\N
411	2416	mitglied	TIEF	\N
110	890	mitglied	TIEF	\N
411	890	mitglied	TIEF	\N
376	1751	mitglied	TIEF	\N
182	5232	mitglied	TIEF	\N
340	1622	mitglied	TIEF	\N
223	2899	mitglied	TIEF	\N
337	5978	mitglied	TIEF	\N
147	5978	mitglied	TIEF	\N
304	5978	mitglied	TIEF	\N
273	7613	beirat	TIEF	\N
332	989	mitglied	TIEF	\N
154	7628	vorstand	TIEF	\N
360	7625	vorstand	TIEF	\N
289	810	vorstand	HOCH	\N
297	7671	geschaeftsfuehrend	TIEF	\N
66	7682	mitglied	TIEF	\N
53	7688	geschaeftsfuehrend	TIEF	\N
60	2930	vorstand	TIEF	\N
299	3496	mitglied	TIEF	\N
310	2230	mitglied	TIEF	\N
185	4111	mitglied	TIEF	\N
439	8930	vorstand	TIEF	\N
404	6309	vorstand	TIEF	\N
368	381	mitglied	TIEF	\N
368	7818	mitglied	TIEF	\N
319	2899	mitglied	TIEF	\N
404	4095	beirat	TIEF	\N
305	2984	geschaeftsfuehrend	TIEF	\N
357	7924	mitglied	TIEF	\N
106	5988	vorstand	TIEF	\N
298	6081	vorstand	TIEF	\N
40	244	vorstand	MITTEL	\N
284	1344	beirat	TIEF	\N
6	1344	beirat	TIEF	\N
110	1344	beirat	TIEF	\N
285	283	vorstand	TIEF	\N
310	582	beirat	MITTEL	\N
421	8707	vorstand	TIEF	\N
414	7043	geschaeftsfuehrend	TIEF	\N
264	4247	mitglied	TIEF	\N
166	5963	vorstand	TIEF	\N
356	459	mitglied	TIEF	\N
51	4959	mitglied	TIEF	\N
393	4959	mitglied	TIEF	\N
83	4959	mitglied	TIEF	\N
331	2855	mitglied	TIEF	\N
144	886	mitglied	TIEF	\N
402	5348	mitglied	TIEF	\N
357	5348	mitglied	TIEF	\N
297	5348	mitglied	TIEF	\N
384	5348	mitglied	TIEF	\N
161	7924	mitglied	TIEF	\N
380	5931	vorstand	HOCH	\N
349	8098	mitglied	TIEF	\N
153	8144	vorstand	TIEF	\N
363	8237	beirat	TIEF	\N
328	344	taetig	MITTEL	\N
21	8238	vorstand	TIEF	\N
382	2547	vorstand	MITTEL	\N
437	8792	vorstand	TIEF	\N
283	8250	geschaeftsfuehrend	TIEF	\N
14	6120	mitglied	TIEF	\N
294	6120	mitglied	TIEF	\N
310	2178	vorstand	TIEF	\N
437	8793	vorstand	TIEF	\N
154	8253	mitglied	TIEF	\N
317	5279	mitglied	TIEF	\N
389	2416	mitglied	TIEF	\N
314	5279	mitglied	TIEF	\N
125	5279	mitglied	TIEF	\N
405	5279	mitglied	TIEF	\N
153	5279	mitglied	TIEF	\N
298	5279	mitglied	TIEF	\N
437	6031	vorstand	TIEF	\N
65	7825	vorstand	TIEF	\N
171	7825	beirat	TIEF	\N
381	7825	beirat	TIEF	\N
415	126	vorstand	TIEF	\N
89	8883	mitglied	TIEF	\N
347	8883	mitglied	TIEF	\N
389	5979	mitglied	TIEF	\N
98	8883	mitglied	TIEF	\N
433	8883	mitglied	TIEF	\N
346	8883	mitglied	TIEF	\N
280	2334	vorstand	TIEF	\N
360	3871	gesellschafter	TIEF	\N
381	4111	mitglied	TIEF	\N
294	4111	mitglied	TIEF	\N
331	8965	vorstand	TIEF	\N
440	9026	geschaeftsfuehrend	TIEF	\N
198	179	mitglied	TIEF	\N
346	9103	vorstand	TIEF	\N
319	5279	mitglied	TIEF	\N
310	5279	mitglied	TIEF	\N
364	2977	mitglied	TIEF	\N
360	2977	vorstand	TIEF	\N
315	7595	mitglied	TIEF	\N
337	2111	vorstand	TIEF	\N
371	2111	mitglied	TIEF	\N
310	2892	mitglied	TIEF	\N
6	334	vorstand	MITTEL	\N
431	8274	geschaeftsfuehrend	TIEF	\N
102	7925	mitglied	TIEF	\N
168	1504	beirat	TIEF	\N
110	5932	vorstand	HOCH	\N
284	8331	vorstand	TIEF	\N
315	5291	mitglied	TIEF	\N
354	5291	mitglied	TIEF	\N
40	1622	mitglied	TIEF	\N
355	1622	mitglied	TIEF	\N
345	8209	mitglied	TIEF	\N
192	1266	vorstand	MITTEL	\N
301	6354	mitglied	TIEF	\N
430	7596	mitglied	TIEF	\N
429	8417	vorstand	TIEF	\N
\.


--
-- Data for Name: ParliamentarianVote; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."ParliamentarianVote" ("parliamentarianId", "billId", "voteStatus") FROM stdin;
53	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
185	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
144	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
357	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
376	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
386	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
172	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
11	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
149	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
178	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
211	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
329	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
89	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
331	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
389	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
100	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
251	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
261	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
277	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
280	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
285	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
289	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
297	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
302	dfea9a26-ef3d-48ec-bb78-299f3c1201df	UNKNOWN
310	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
314	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
327	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
333	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
332	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
337	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
341	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
343	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
360	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
370	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
40	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
44	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
210	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
371	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
383	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
96	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
96	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
411	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
65	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
120	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
98	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
294	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
328	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
403	0775eb08-d871-4e20-aefd-af2000d463d9	NO
339	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
340	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
373	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
369	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
393	dfea9a26-ef3d-48ec-bb78-299f3c1201df	UNKNOWN
422	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
358	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
396	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
349	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
410	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
51	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
170	dfea9a26-ef3d-48ec-bb78-299f3c1201df	UNKNOWN
41	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
49	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
182	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
63	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
83	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
106	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
14	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
293	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
168	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
21	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
161	dfea9a26-ef3d-48ec-bb78-299f3c1201df	UNKNOWN
296	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
110	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
198	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
161	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
154	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
248	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
250	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
272	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
278	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
283	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
287	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
379	760ce247-b948-466b-b2e9-af6c00bc5863	YES
299	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
304	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
312	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
323	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
330	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
334	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
40	097c1168-858b-4390-b4a6-b0230085ba0b	UNKNOWN
44	097c1168-858b-4390-b4a6-b0230085ba0b	YES
394	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
411	097c1168-858b-4390-b4a6-b0230085ba0b	NO
96	097c1168-858b-4390-b4a6-b0230085ba0b	NO
120	097c1168-858b-4390-b4a6-b0230085ba0b	YES
428	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
210	097c1168-858b-4390-b4a6-b0230085ba0b	YES
172	097c1168-858b-4390-b4a6-b0230085ba0b	YES
298	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
374	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
63	097c1168-858b-4390-b4a6-b0230085ba0b	YES
366	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
355	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
346	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
357	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
387	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
417	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
188	097c1168-858b-4390-b4a6-b0230085ba0b	YES
159	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
388	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
367	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
394	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
51	097c1168-858b-4390-b4a6-b0230085ba0b	NO
399	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
53	097c1168-858b-4390-b4a6-b0230085ba0b	NO
116	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
166	097c1168-858b-4390-b4a6-b0230085ba0b	YES
170	097c1168-858b-4390-b4a6-b0230085ba0b	YES
418	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
391	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
404	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
425	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
433	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
6	097c1168-858b-4390-b4a6-b0230085ba0b	YES
161	097c1168-858b-4390-b4a6-b0230085ba0b	UNKNOWN
11	097c1168-858b-4390-b4a6-b0230085ba0b	YES
14	097c1168-858b-4390-b4a6-b0230085ba0b	YES
149	097c1168-858b-4390-b4a6-b0230085ba0b	YES
153	097c1168-858b-4390-b4a6-b0230085ba0b	YES
167	097c1168-858b-4390-b4a6-b0230085ba0b	YES
168	097c1168-858b-4390-b4a6-b0230085ba0b	NO
178	097c1168-858b-4390-b4a6-b0230085ba0b	YES
21	097c1168-858b-4390-b4a6-b0230085ba0b	YES
211	097c1168-858b-4390-b4a6-b0230085ba0b	NO
185	097c1168-858b-4390-b4a6-b0230085ba0b	YES
182	097c1168-858b-4390-b4a6-b0230085ba0b	YES
144	097c1168-858b-4390-b4a6-b0230085ba0b	NO
198	097c1168-858b-4390-b4a6-b0230085ba0b	NO
89	097c1168-858b-4390-b4a6-b0230085ba0b	NO
154	097c1168-858b-4390-b4a6-b0230085ba0b	NO
100	097c1168-858b-4390-b4a6-b0230085ba0b	YES
248	097c1168-858b-4390-b4a6-b0230085ba0b	YES
251	097c1168-858b-4390-b4a6-b0230085ba0b	YES
250	097c1168-858b-4390-b4a6-b0230085ba0b	YES
261	097c1168-858b-4390-b4a6-b0230085ba0b	YES
264	097c1168-858b-4390-b4a6-b0230085ba0b	NO
270	097c1168-858b-4390-b4a6-b0230085ba0b	YES
271	097c1168-858b-4390-b4a6-b0230085ba0b	YES
272	097c1168-858b-4390-b4a6-b0230085ba0b	YES
278	097c1168-858b-4390-b4a6-b0230085ba0b	YES
280	097c1168-858b-4390-b4a6-b0230085ba0b	NO
283	097c1168-858b-4390-b4a6-b0230085ba0b	YES
287	097c1168-858b-4390-b4a6-b0230085ba0b	YES
289	097c1168-858b-4390-b4a6-b0230085ba0b	YES
293	097c1168-858b-4390-b4a6-b0230085ba0b	NO
294	097c1168-858b-4390-b4a6-b0230085ba0b	YES
296	097c1168-858b-4390-b4a6-b0230085ba0b	NO
298	097c1168-858b-4390-b4a6-b0230085ba0b	YES
299	097c1168-858b-4390-b4a6-b0230085ba0b	YES
305	097c1168-858b-4390-b4a6-b0230085ba0b	YES
306	097c1168-858b-4390-b4a6-b0230085ba0b	YES
307	097c1168-858b-4390-b4a6-b0230085ba0b	YES
309	097c1168-858b-4390-b4a6-b0230085ba0b	YES
310	097c1168-858b-4390-b4a6-b0230085ba0b	YES
441	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
405	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
432	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
436	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
439	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
437	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
440	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
65	097c1168-858b-4390-b4a6-b0230085ba0b	UNKNOWN
159	097c1168-858b-4390-b4a6-b0230085ba0b	NO
116	097c1168-858b-4390-b4a6-b0230085ba0b	YES
49	097c1168-858b-4390-b4a6-b0230085ba0b	NO
83	097c1168-858b-4390-b4a6-b0230085ba0b	NO
88	097c1168-858b-4390-b4a6-b0230085ba0b	UNKNOWN
98	097c1168-858b-4390-b4a6-b0230085ba0b	NO
106	097c1168-858b-4390-b4a6-b0230085ba0b	UNKNOWN
297	097c1168-858b-4390-b4a6-b0230085ba0b	YES
302	097c1168-858b-4390-b4a6-b0230085ba0b	YES
304	097c1168-858b-4390-b4a6-b0230085ba0b	NO
373	097c1168-858b-4390-b4a6-b0230085ba0b	YES
395	097c1168-858b-4390-b4a6-b0230085ba0b	NO
360	097c1168-858b-4390-b4a6-b0230085ba0b	YES
369	097c1168-858b-4390-b4a6-b0230085ba0b	NO
389	097c1168-858b-4390-b4a6-b0230085ba0b	NO
347	097c1168-858b-4390-b4a6-b0230085ba0b	NO
374	097c1168-858b-4390-b4a6-b0230085ba0b	UNKNOWN
41	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
329	097c1168-858b-4390-b4a6-b0230085ba0b	NO
44	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
330	097c1168-858b-4390-b4a6-b0230085ba0b	NO
53	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
331	097c1168-858b-4390-b4a6-b0230085ba0b	YES
63	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
334	097c1168-858b-4390-b4a6-b0230085ba0b	NO
6	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
333	097c1168-858b-4390-b4a6-b0230085ba0b	YES
83	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
332	097c1168-858b-4390-b4a6-b0230085ba0b	NO
98	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
337	097c1168-858b-4390-b4a6-b0230085ba0b	UNKNOWN
11	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
339	097c1168-858b-4390-b4a6-b0230085ba0b	NO
149	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
341	097c1168-858b-4390-b4a6-b0230085ba0b	YES
340	097c1168-858b-4390-b4a6-b0230085ba0b	YES
314	097c1168-858b-4390-b4a6-b0230085ba0b	YES
343	097c1168-858b-4390-b4a6-b0230085ba0b	YES
323	097c1168-858b-4390-b4a6-b0230085ba0b	NO
348	097c1168-858b-4390-b4a6-b0230085ba0b	NO
327	097c1168-858b-4390-b4a6-b0230085ba0b	NO
414	097c1168-858b-4390-b4a6-b0230085ba0b	YES
328	097c1168-858b-4390-b4a6-b0230085ba0b	YES
353	097c1168-858b-4390-b4a6-b0230085ba0b	YES
419	097c1168-858b-4390-b4a6-b0230085ba0b	UNKNOWN
370	097c1168-858b-4390-b4a6-b0230085ba0b	NO
422	097c1168-858b-4390-b4a6-b0230085ba0b	NO
371	097c1168-858b-4390-b4a6-b0230085ba0b	NO
358	097c1168-858b-4390-b4a6-b0230085ba0b	NO
376	097c1168-858b-4390-b4a6-b0230085ba0b	YES
396	097c1168-858b-4390-b4a6-b0230085ba0b	NO
386	097c1168-858b-4390-b4a6-b0230085ba0b	NO
349	097c1168-858b-4390-b4a6-b0230085ba0b	NO
383	097c1168-858b-4390-b4a6-b0230085ba0b	NO
390	097c1168-858b-4390-b4a6-b0230085ba0b	YES
410	097c1168-858b-4390-b4a6-b0230085ba0b	NO
378	097c1168-858b-4390-b4a6-b0230085ba0b	NO
363	097c1168-858b-4390-b4a6-b0230085ba0b	YES
388	097c1168-858b-4390-b4a6-b0230085ba0b	YES
403	097c1168-858b-4390-b4a6-b0230085ba0b	NO
379	097c1168-858b-4390-b4a6-b0230085ba0b	YES
346	097c1168-858b-4390-b4a6-b0230085ba0b	NO
387	097c1168-858b-4390-b4a6-b0230085ba0b	YES
367	097c1168-858b-4390-b4a6-b0230085ba0b	NO
417	097c1168-858b-4390-b4a6-b0230085ba0b	YES
361	097c1168-858b-4390-b4a6-b0230085ba0b	YES
355	097c1168-858b-4390-b4a6-b0230085ba0b	YES
399	097c1168-858b-4390-b4a6-b0230085ba0b	YES
357	097c1168-858b-4390-b4a6-b0230085ba0b	NO
418	097c1168-858b-4390-b4a6-b0230085ba0b	NO
354	097c1168-858b-4390-b4a6-b0230085ba0b	NO
392	097c1168-858b-4390-b4a6-b0230085ba0b	UNKNOWN
391	097c1168-858b-4390-b4a6-b0230085ba0b	YES
404	097c1168-858b-4390-b4a6-b0230085ba0b	YES
405	097c1168-858b-4390-b4a6-b0230085ba0b	YES
424	097c1168-858b-4390-b4a6-b0230085ba0b	UNKNOWN
394	097c1168-858b-4390-b4a6-b0230085ba0b	YES
425	097c1168-858b-4390-b4a6-b0230085ba0b	YES
415	097c1168-858b-4390-b4a6-b0230085ba0b	YES
426	097c1168-858b-4390-b4a6-b0230085ba0b	NO
427	097c1168-858b-4390-b4a6-b0230085ba0b	YES
428	097c1168-858b-4390-b4a6-b0230085ba0b	NO
431	097c1168-858b-4390-b4a6-b0230085ba0b	UNKNOWN
430	097c1168-858b-4390-b4a6-b0230085ba0b	YES
432	097c1168-858b-4390-b4a6-b0230085ba0b	YES
433	097c1168-858b-4390-b4a6-b0230085ba0b	NO
436	097c1168-858b-4390-b4a6-b0230085ba0b	YES
437	097c1168-858b-4390-b4a6-b0230085ba0b	NO
439	097c1168-858b-4390-b4a6-b0230085ba0b	YES
440	097c1168-858b-4390-b4a6-b0230085ba0b	YES
441	097c1168-858b-4390-b4a6-b0230085ba0b	YES
79	097c1168-858b-4390-b4a6-b0230085ba0b	YES
277	097c1168-858b-4390-b4a6-b0230085ba0b	YES
120	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
116	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
411	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
40	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
49	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
65	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
79	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
88	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
106	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
14	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
153	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
172	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
96	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
51	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
170	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
305	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
310	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
312	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
314	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
323	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
327	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
328	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
329	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
330	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
331	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
333	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
332	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
337	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
339	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
341	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
340	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
343	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
373	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
395	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
360	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
369	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
389	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
393	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
347	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
374	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
348	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
414	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
353	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
370	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
422	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
371	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
358	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
376	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
396	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
386	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
349	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
383	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
390	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
410	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
378	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
366	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
363	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
388	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
403	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
379	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
346	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
367	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
417	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
361	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
355	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
399	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
357	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
418	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
354	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
391	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
404	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
405	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
420	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
424	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
394	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
425	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
415	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
426	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
427	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
431	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
166	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
178	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
418	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
211	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
185	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
21	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
144	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
110	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
154	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
182	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
248	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
198	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
250	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
100	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
264	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
251	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
271	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
261	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
277	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
270	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
280	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
272	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
285	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
278	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
289	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
283	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
297	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
287	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
299	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
294	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
304	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
306	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
307	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
302	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
309	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
298	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
437	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
44	1523a63a-0f8d-43bc-b567-adfe00bafc91	UNKNOWN
96	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
49	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
116	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
53	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
159	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
63	1523a63a-0f8d-43bc-b567-adfe00bafc91	UNKNOWN
166	1523a63a-0f8d-43bc-b567-adfe00bafc91	UNKNOWN
65	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
51	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
440	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
293	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
411	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
210	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
170	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
161	1523a63a-0f8d-43bc-b567-adfe00bafc91	UNKNOWN
40	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
172	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
41	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
120	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
6	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
79	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
83	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
88	1523a63a-0f8d-43bc-b567-adfe00bafc91	UNKNOWN
98	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
106	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
11	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
14	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
149	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
153	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
168	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
178	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
21	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
211	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
110	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
185	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
182	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
144	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
198	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
89	1523a63a-0f8d-43bc-b567-adfe00bafc91	UNKNOWN
154	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
100	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
248	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
251	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
250	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
261	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
264	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
270	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
272	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
277	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
278	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
280	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
283	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
285	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
287	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
293	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
294	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
296	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
297	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
310	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
312	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
314	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
323	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
327	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
328	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
329	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
330	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
331	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
51	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
411	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
188	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
170	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
40	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
41	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
44	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
49	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
167	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
296	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
419	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
428	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
432	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
433	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
436	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
439	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
441	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
392	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
188	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
89	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
334	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
387	66e16f07-36f4-4fc7-ba98-7168df9e9995	NO
430	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
188	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
343	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
161	ba4a1c99-48d7-40da-86ea-0c77f3797150	UNKNOWN
309	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
395	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
373	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
88	dfea9a26-ef3d-48ec-bb78-299f3c1201df	UNKNOWN
348	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
393	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
353	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
49	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
411	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
360	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
53	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
210	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
159	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
172	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
414	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
378	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
339	1523a63a-0f8d-43bc-b567-adfe00bafc91	UNKNOWN
116	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
96	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
347	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
79	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
374	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
44	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
210	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
120	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
403	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
41	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
369	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
166	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
419	1523a63a-0f8d-43bc-b567-adfe00bafc91	UNKNOWN
370	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
390	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
170	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
388	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
271	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
422	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
51	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
371	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
358	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
376	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
396	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
386	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
349	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
383	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
390	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
410	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
366	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
363	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
388	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
403	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
379	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
346	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
387	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
367	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
417	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
361	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
355	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
399	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
357	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
418	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
354	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
392	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
391	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
404	1523a63a-0f8d-43bc-b567-adfe00bafc91	UNKNOWN
420	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
424	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
394	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
425	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
415	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
426	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
427	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
428	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
431	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
430	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
432	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
433	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
436	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
437	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
439	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
440	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
441	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
153	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
395	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
430	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
334	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
333	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
337	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
167	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
83	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
341	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
40	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
332	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
6	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
63	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
340	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
272	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
261	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
309	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
310	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
312	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
323	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
327	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
328	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
329	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
294	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
331	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
334	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
333	ba4a1c99-48d7-40da-86ea-0c77f3797150	UNKNOWN
332	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
337	ba4a1c99-48d7-40da-86ea-0c77f3797150	UNKNOWN
339	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
341	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
307	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
340	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
343	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
373	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
395	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
360	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
369	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
393	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
330	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
348	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
414	ba4a1c99-48d7-40da-86ea-0c77f3797150	UNKNOWN
353	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
419	ba4a1c99-48d7-40da-86ea-0c77f3797150	UNKNOWN
370	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
422	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
371	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
347	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
376	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
396	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
386	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
349	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
383	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
390	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
410	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
358	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
363	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
388	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
403	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
379	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
346	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
387	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
367	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
378	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
361	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
355	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
399	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
357	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
418	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
354	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
392	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
417	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
404	ba4a1c99-48d7-40da-86ea-0c77f3797150	UNKNOWN
405	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
424	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
388	ea3c08d8-29ef-4750-9746-aff900b12965	NO
106	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
14	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
149	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
391	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
167	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
168	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
178	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
110	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
185	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
182	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
153	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
198	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
89	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
154	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
41	097c1168-858b-4390-b4a6-b0230085ba0b	YES
248	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
251	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
250	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
144	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
264	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
270	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
271	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
211	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
277	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
280	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
283	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
285	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
287	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
289	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
293	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
100	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
296	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
297	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
299	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
302	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
304	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
305	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
306	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
79	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
63	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
88	ba4a1c99-48d7-40da-86ea-0c77f3797150	UNKNOWN
389	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
110	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
178	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
153	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
11	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
83	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
428	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
425	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
415	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
298	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
366	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
440	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
65	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
431	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
168	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
21	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
210	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
21	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
167	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
14	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
88	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
6	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
433	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
436	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
441	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
211	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
314	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
427	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
168	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
149	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
98	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
439	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
185	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
198	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
89	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
154	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
100	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
248	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
251	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
250	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
261	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
264	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
270	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
271	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
272	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
277	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
278	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
280	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
283	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
285	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
289	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
293	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
294	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
296	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
297	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
298	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
299	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
302	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
304	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
305	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
306	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
307	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
309	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
310	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
312	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
314	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
323	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
327	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
329	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
330	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
331	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
334	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
333	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
332	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
337	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
339	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
341	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
340	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
393	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
305	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
394	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
432	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
312	097c1168-858b-4390-b4a6-b0230085ba0b	YES
374	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
307	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
110	097c1168-858b-4390-b4a6-b0230085ba0b	NO
285	097c1168-858b-4390-b4a6-b0230085ba0b	YES
393	097c1168-858b-4390-b4a6-b0230085ba0b	YES
366	097c1168-858b-4390-b4a6-b0230085ba0b	NO
420	097c1168-858b-4390-b4a6-b0230085ba0b	NO
161	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
188	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
420	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
430	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
278	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
426	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
437	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
376	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
396	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
386	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
349	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
383	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
390	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
410	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
378	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
366	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
363	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
388	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
403	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
346	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
387	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
367	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
417	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
361	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
355	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
399	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
357	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
418	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
354	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
392	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
391	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
404	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
405	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
420	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
424	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
394	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
425	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
426	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
427	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
428	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
431	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
430	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
432	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
433	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
436	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
437	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
439	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
440	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
441	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
106	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
210	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
161	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
172	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
120	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
96	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
159	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
166	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
51	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
411	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
188	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
170	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
40	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
41	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
44	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
49	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
53	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
63	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
65	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
6	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
83	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
88	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
98	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
106	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
14	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
149	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
153	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
167	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
168	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
21	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
211	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
110	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
185	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
182	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
144	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
198	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
89	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
154	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
100	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
248	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
251	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
250	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
264	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
373	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
395	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
360	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
369	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
389	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
393	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
347	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
374	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
348	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
353	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
419	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
370	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
422	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
371	190c19ef-be90-45bf-b9c6-afc700ee176a	UNKNOWN
358	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
304	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
305	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
306	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
307	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
309	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
310	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
312	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
314	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
327	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
328	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
329	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
331	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
334	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
337	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
339	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
341	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
340	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
395	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
360	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
369	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
389	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
393	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
347	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
374	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
348	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
353	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
419	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
370	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
422	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
371	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
358	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
376	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
396	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
386	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
349	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
383	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
390	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
410	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
378	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
366	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
363	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
388	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
403	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
346	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
387	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
367	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
417	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
361	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
355	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
399	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
357	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
418	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
354	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
392	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
391	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
404	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
405	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
420	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
424	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
394	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
425	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
426	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
427	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
428	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
431	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
430	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
432	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
433	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
436	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
437	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
439	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
440	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
441	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
79	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
178	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
210	0775eb08-d871-4e20-aefd-af2000d463d9	YES
161	0775eb08-d871-4e20-aefd-af2000d463d9	UNKNOWN
172	0775eb08-d871-4e20-aefd-af2000d463d9	YES
120	0775eb08-d871-4e20-aefd-af2000d463d9	YES
116	0775eb08-d871-4e20-aefd-af2000d463d9	YES
271	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
272	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
277	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
278	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
280	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
283	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
285	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
287	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
289	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
294	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
296	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
297	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
298	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
299	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
302	e37e8e4d-0b45-40ba-a340-b0230080f7e0	UNKNOWN
98	0775eb08-d871-4e20-aefd-af2000d463d9	NO
106	0775eb08-d871-4e20-aefd-af2000d463d9	UNKNOWN
11	0775eb08-d871-4e20-aefd-af2000d463d9	YES
14	0775eb08-d871-4e20-aefd-af2000d463d9	YES
149	0775eb08-d871-4e20-aefd-af2000d463d9	YES
168	0775eb08-d871-4e20-aefd-af2000d463d9	NO
178	0775eb08-d871-4e20-aefd-af2000d463d9	YES
21	0775eb08-d871-4e20-aefd-af2000d463d9	YES
211	0775eb08-d871-4e20-aefd-af2000d463d9	NO
110	0775eb08-d871-4e20-aefd-af2000d463d9	NO
182	0775eb08-d871-4e20-aefd-af2000d463d9	YES
144	0775eb08-d871-4e20-aefd-af2000d463d9	NO
198	0775eb08-d871-4e20-aefd-af2000d463d9	NO
89	0775eb08-d871-4e20-aefd-af2000d463d9	NO
154	0775eb08-d871-4e20-aefd-af2000d463d9	NO
100	0775eb08-d871-4e20-aefd-af2000d463d9	YES
248	0775eb08-d871-4e20-aefd-af2000d463d9	YES
251	0775eb08-d871-4e20-aefd-af2000d463d9	YES
250	0775eb08-d871-4e20-aefd-af2000d463d9	YES
261	0775eb08-d871-4e20-aefd-af2000d463d9	YES
264	0775eb08-d871-4e20-aefd-af2000d463d9	NO
270	0775eb08-d871-4e20-aefd-af2000d463d9	YES
271	0775eb08-d871-4e20-aefd-af2000d463d9	UNKNOWN
272	0775eb08-d871-4e20-aefd-af2000d463d9	YES
277	0775eb08-d871-4e20-aefd-af2000d463d9	YES
278	0775eb08-d871-4e20-aefd-af2000d463d9	YES
280	0775eb08-d871-4e20-aefd-af2000d463d9	NO
283	0775eb08-d871-4e20-aefd-af2000d463d9	YES
287	0775eb08-d871-4e20-aefd-af2000d463d9	YES
289	0775eb08-d871-4e20-aefd-af2000d463d9	YES
293	0775eb08-d871-4e20-aefd-af2000d463d9	NO
294	0775eb08-d871-4e20-aefd-af2000d463d9	YES
296	0775eb08-d871-4e20-aefd-af2000d463d9	NO
297	0775eb08-d871-4e20-aefd-af2000d463d9	YES
298	0775eb08-d871-4e20-aefd-af2000d463d9	YES
299	0775eb08-d871-4e20-aefd-af2000d463d9	YES
302	0775eb08-d871-4e20-aefd-af2000d463d9	YES
304	0775eb08-d871-4e20-aefd-af2000d463d9	NO
305	0775eb08-d871-4e20-aefd-af2000d463d9	YES
306	0775eb08-d871-4e20-aefd-af2000d463d9	YES
307	0775eb08-d871-4e20-aefd-af2000d463d9	YES
309	0775eb08-d871-4e20-aefd-af2000d463d9	YES
310	0775eb08-d871-4e20-aefd-af2000d463d9	YES
312	0775eb08-d871-4e20-aefd-af2000d463d9	YES
314	0775eb08-d871-4e20-aefd-af2000d463d9	YES
323	0775eb08-d871-4e20-aefd-af2000d463d9	NO
328	0775eb08-d871-4e20-aefd-af2000d463d9	YES
329	0775eb08-d871-4e20-aefd-af2000d463d9	NO
330	0775eb08-d871-4e20-aefd-af2000d463d9	NO
331	0775eb08-d871-4e20-aefd-af2000d463d9	YES
334	0775eb08-d871-4e20-aefd-af2000d463d9	NO
333	0775eb08-d871-4e20-aefd-af2000d463d9	YES
332	0775eb08-d871-4e20-aefd-af2000d463d9	NO
337	0775eb08-d871-4e20-aefd-af2000d463d9	YES
339	0775eb08-d871-4e20-aefd-af2000d463d9	NO
341	0775eb08-d871-4e20-aefd-af2000d463d9	YES
340	0775eb08-d871-4e20-aefd-af2000d463d9	YES
343	0775eb08-d871-4e20-aefd-af2000d463d9	YES
373	0775eb08-d871-4e20-aefd-af2000d463d9	YES
395	0775eb08-d871-4e20-aefd-af2000d463d9	NO
360	0775eb08-d871-4e20-aefd-af2000d463d9	YES
369	0775eb08-d871-4e20-aefd-af2000d463d9	YES
389	0775eb08-d871-4e20-aefd-af2000d463d9	NO
393	0775eb08-d871-4e20-aefd-af2000d463d9	YES
374	0775eb08-d871-4e20-aefd-af2000d463d9	YES
348	0775eb08-d871-4e20-aefd-af2000d463d9	YES
414	0775eb08-d871-4e20-aefd-af2000d463d9	YES
353	0775eb08-d871-4e20-aefd-af2000d463d9	YES
419	0775eb08-d871-4e20-aefd-af2000d463d9	YES
370	0775eb08-d871-4e20-aefd-af2000d463d9	NO
422	0775eb08-d871-4e20-aefd-af2000d463d9	NO
371	0775eb08-d871-4e20-aefd-af2000d463d9	NO
358	0775eb08-d871-4e20-aefd-af2000d463d9	NO
376	0775eb08-d871-4e20-aefd-af2000d463d9	YES
396	0775eb08-d871-4e20-aefd-af2000d463d9	NO
386	0775eb08-d871-4e20-aefd-af2000d463d9	NO
349	0775eb08-d871-4e20-aefd-af2000d463d9	NO
383	0775eb08-d871-4e20-aefd-af2000d463d9	NO
390	0775eb08-d871-4e20-aefd-af2000d463d9	UNKNOWN
410	0775eb08-d871-4e20-aefd-af2000d463d9	NO
378	0775eb08-d871-4e20-aefd-af2000d463d9	NO
366	0775eb08-d871-4e20-aefd-af2000d463d9	NO
388	0775eb08-d871-4e20-aefd-af2000d463d9	YES
166	0775eb08-d871-4e20-aefd-af2000d463d9	YES
51	0775eb08-d871-4e20-aefd-af2000d463d9	UNKNOWN
411	0775eb08-d871-4e20-aefd-af2000d463d9	NO
188	0775eb08-d871-4e20-aefd-af2000d463d9	YES
170	0775eb08-d871-4e20-aefd-af2000d463d9	YES
40	0775eb08-d871-4e20-aefd-af2000d463d9	UNKNOWN
41	0775eb08-d871-4e20-aefd-af2000d463d9	YES
44	0775eb08-d871-4e20-aefd-af2000d463d9	YES
49	0775eb08-d871-4e20-aefd-af2000d463d9	NO
63	0775eb08-d871-4e20-aefd-af2000d463d9	YES
65	0775eb08-d871-4e20-aefd-af2000d463d9	YES
6	0775eb08-d871-4e20-aefd-af2000d463d9	YES
79	0775eb08-d871-4e20-aefd-af2000d463d9	YES
83	0775eb08-d871-4e20-aefd-af2000d463d9	YES
88	0775eb08-d871-4e20-aefd-af2000d463d9	NO
424	0775eb08-d871-4e20-aefd-af2000d463d9	NO
394	0775eb08-d871-4e20-aefd-af2000d463d9	YES
425	0775eb08-d871-4e20-aefd-af2000d463d9	YES
415	0775eb08-d871-4e20-aefd-af2000d463d9	YES
426	0775eb08-d871-4e20-aefd-af2000d463d9	NO
427	0775eb08-d871-4e20-aefd-af2000d463d9	YES
428	0775eb08-d871-4e20-aefd-af2000d463d9	NO
431	0775eb08-d871-4e20-aefd-af2000d463d9	YES
430	0775eb08-d871-4e20-aefd-af2000d463d9	YES
432	0775eb08-d871-4e20-aefd-af2000d463d9	YES
433	0775eb08-d871-4e20-aefd-af2000d463d9	NO
436	0775eb08-d871-4e20-aefd-af2000d463d9	YES
439	0775eb08-d871-4e20-aefd-af2000d463d9	YES
440	0775eb08-d871-4e20-aefd-af2000d463d9	YES
441	0775eb08-d871-4e20-aefd-af2000d463d9	YES
210	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
161	95b5667c-6138-42f0-b8a2-af2000d5b73f	UNKNOWN
172	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
120	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
96	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
159	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
166	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
51	95b5667c-6138-42f0-b8a2-af2000d5b73f	UNKNOWN
411	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
188	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
40	95b5667c-6138-42f0-b8a2-af2000d5b73f	UNKNOWN
41	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
44	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
53	95b5667c-6138-42f0-b8a2-af2000d5b73f	UNKNOWN
63	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
65	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
79	95b5667c-6138-42f0-b8a2-af2000d5b73f	UNKNOWN
83	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
88	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
98	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
106	95b5667c-6138-42f0-b8a2-af2000d5b73f	UNKNOWN
11	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
14	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
149	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
153	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
167	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
168	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
178	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
21	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
211	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
185	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
182	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
144	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
198	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
89	95b5667c-6138-42f0-b8a2-af2000d5b73f	UNKNOWN
154	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
100	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
248	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
251	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
250	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
261	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
264	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
270	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
271	95b5667c-6138-42f0-b8a2-af2000d5b73f	UNKNOWN
272	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
277	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
278	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
280	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
285	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
287	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
289	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
293	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
294	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
296	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
297	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
298	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
299	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
302	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
304	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
305	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
306	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
307	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
309	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
310	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
312	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
314	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
327	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
379	0775eb08-d871-4e20-aefd-af2000d463d9	YES
346	0775eb08-d871-4e20-aefd-af2000d463d9	NO
387	0775eb08-d871-4e20-aefd-af2000d463d9	YES
367	0775eb08-d871-4e20-aefd-af2000d463d9	NO
417	0775eb08-d871-4e20-aefd-af2000d463d9	YES
361	0775eb08-d871-4e20-aefd-af2000d463d9	YES
355	0775eb08-d871-4e20-aefd-af2000d463d9	NO
399	0775eb08-d871-4e20-aefd-af2000d463d9	YES
357	0775eb08-d871-4e20-aefd-af2000d463d9	YES
354	0775eb08-d871-4e20-aefd-af2000d463d9	NO
392	0775eb08-d871-4e20-aefd-af2000d463d9	YES
391	0775eb08-d871-4e20-aefd-af2000d463d9	YES
404	0775eb08-d871-4e20-aefd-af2000d463d9	UNKNOWN
405	0775eb08-d871-4e20-aefd-af2000d463d9	YES
420	0775eb08-d871-4e20-aefd-af2000d463d9	NO
393	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
347	95b5667c-6138-42f0-b8a2-af2000d5b73f	UNKNOWN
374	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
348	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
414	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
353	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
419	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
370	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
422	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
371	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
358	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
376	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
386	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
349	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
383	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
390	95b5667c-6138-42f0-b8a2-af2000d5b73f	UNKNOWN
410	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
378	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
366	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
363	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
388	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
403	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
379	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
346	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
387	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
367	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
417	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
361	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
355	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
399	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
418	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
354	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
392	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
391	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
404	95b5667c-6138-42f0-b8a2-af2000d5b73f	UNKNOWN
405	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
420	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
424	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
394	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
425	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
415	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
426	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
427	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
428	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
431	95b5667c-6138-42f0-b8a2-af2000d5b73f	UNKNOWN
430	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
432	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
433	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
437	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
439	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
440	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
441	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
210	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
161	67495532-fa85-472b-b59b-af5e00f4ae4d	UNKNOWN
172	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
120	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
96	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
116	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
159	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
166	67495532-fa85-472b-b59b-af5e00f4ae4d	UNKNOWN
51	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
411	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
188	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
170	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
40	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
41	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
49	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
53	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
63	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
65	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
6	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
79	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
83	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
88	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
98	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
106	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
11	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
14	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
149	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
153	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
167	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
168	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
178	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
21	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
110	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
329	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
330	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
331	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
334	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
333	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
332	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
337	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
339	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
341	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
343	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
373	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
395	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
360	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
369	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
389	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
280	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
283	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
285	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
287	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
289	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
293	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
294	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
296	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
297	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
298	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
299	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
302	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
305	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
306	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
307	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
309	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
310	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
312	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
314	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
323	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
327	67495532-fa85-472b-b59b-af5e00f4ae4d	UNKNOWN
328	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
329	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
330	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
331	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
334	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
333	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
332	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
337	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
339	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
343	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
373	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
395	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
360	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
369	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
389	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
393	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
347	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
374	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
348	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
414	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
353	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
419	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
370	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
422	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
371	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
358	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
376	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
386	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
349	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
383	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
390	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
410	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
378	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
366	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
363	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
388	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
403	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
379	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
346	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
387	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
367	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
417	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
361	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
355	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
399	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
418	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
354	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
392	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
391	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
404	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
405	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
420	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
424	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
394	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
425	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
415	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
426	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
427	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
428	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
431	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
430	67495532-fa85-472b-b59b-af5e00f4ae4d	UNKNOWN
432	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
433	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
437	67495532-fa85-472b-b59b-af5e00f4ae4d	UNKNOWN
182	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
144	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
198	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
89	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
154	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
100	67495532-fa85-472b-b59b-af5e00f4ae4d	UNKNOWN
248	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
251	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
250	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
264	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
270	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
271	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
272	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
277	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
278	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
41	760ce247-b948-466b-b2e9-af6c00bc5863	YES
44	760ce247-b948-466b-b2e9-af6c00bc5863	YES
49	760ce247-b948-466b-b2e9-af6c00bc5863	NO
53	760ce247-b948-466b-b2e9-af6c00bc5863	UNKNOWN
63	760ce247-b948-466b-b2e9-af6c00bc5863	YES
65	760ce247-b948-466b-b2e9-af6c00bc5863	YES
6	760ce247-b948-466b-b2e9-af6c00bc5863	YES
79	760ce247-b948-466b-b2e9-af6c00bc5863	YES
83	760ce247-b948-466b-b2e9-af6c00bc5863	YES
88	760ce247-b948-466b-b2e9-af6c00bc5863	NO
98	760ce247-b948-466b-b2e9-af6c00bc5863	NO
106	760ce247-b948-466b-b2e9-af6c00bc5863	YES
14	760ce247-b948-466b-b2e9-af6c00bc5863	YES
149	760ce247-b948-466b-b2e9-af6c00bc5863	YES
153	760ce247-b948-466b-b2e9-af6c00bc5863	YES
167	760ce247-b948-466b-b2e9-af6c00bc5863	YES
168	760ce247-b948-466b-b2e9-af6c00bc5863	NO
178	760ce247-b948-466b-b2e9-af6c00bc5863	YES
21	760ce247-b948-466b-b2e9-af6c00bc5863	YES
211	760ce247-b948-466b-b2e9-af6c00bc5863	NO
110	760ce247-b948-466b-b2e9-af6c00bc5863	NO
185	760ce247-b948-466b-b2e9-af6c00bc5863	YES
182	760ce247-b948-466b-b2e9-af6c00bc5863	YES
144	760ce247-b948-466b-b2e9-af6c00bc5863	NO
198	760ce247-b948-466b-b2e9-af6c00bc5863	NO
89	760ce247-b948-466b-b2e9-af6c00bc5863	NO
154	760ce247-b948-466b-b2e9-af6c00bc5863	NO
100	760ce247-b948-466b-b2e9-af6c00bc5863	YES
248	760ce247-b948-466b-b2e9-af6c00bc5863	YES
251	760ce247-b948-466b-b2e9-af6c00bc5863	YES
261	760ce247-b948-466b-b2e9-af6c00bc5863	YES
264	760ce247-b948-466b-b2e9-af6c00bc5863	NO
270	760ce247-b948-466b-b2e9-af6c00bc5863	YES
271	760ce247-b948-466b-b2e9-af6c00bc5863	YES
272	760ce247-b948-466b-b2e9-af6c00bc5863	YES
277	760ce247-b948-466b-b2e9-af6c00bc5863	YES
278	760ce247-b948-466b-b2e9-af6c00bc5863	YES
280	760ce247-b948-466b-b2e9-af6c00bc5863	NO
283	760ce247-b948-466b-b2e9-af6c00bc5863	YES
285	760ce247-b948-466b-b2e9-af6c00bc5863	YES
287	760ce247-b948-466b-b2e9-af6c00bc5863	YES
289	760ce247-b948-466b-b2e9-af6c00bc5863	YES
293	760ce247-b948-466b-b2e9-af6c00bc5863	NO
294	760ce247-b948-466b-b2e9-af6c00bc5863	YES
296	760ce247-b948-466b-b2e9-af6c00bc5863	NO
297	760ce247-b948-466b-b2e9-af6c00bc5863	YES
298	760ce247-b948-466b-b2e9-af6c00bc5863	YES
299	760ce247-b948-466b-b2e9-af6c00bc5863	YES
304	760ce247-b948-466b-b2e9-af6c00bc5863	NO
305	760ce247-b948-466b-b2e9-af6c00bc5863	YES
306	760ce247-b948-466b-b2e9-af6c00bc5863	YES
307	760ce247-b948-466b-b2e9-af6c00bc5863	YES
309	760ce247-b948-466b-b2e9-af6c00bc5863	YES
310	760ce247-b948-466b-b2e9-af6c00bc5863	YES
312	760ce247-b948-466b-b2e9-af6c00bc5863	YES
314	760ce247-b948-466b-b2e9-af6c00bc5863	YES
323	760ce247-b948-466b-b2e9-af6c00bc5863	NO
327	760ce247-b948-466b-b2e9-af6c00bc5863	YES
328	760ce247-b948-466b-b2e9-af6c00bc5863	YES
329	760ce247-b948-466b-b2e9-af6c00bc5863	NO
330	760ce247-b948-466b-b2e9-af6c00bc5863	NO
331	760ce247-b948-466b-b2e9-af6c00bc5863	YES
334	760ce247-b948-466b-b2e9-af6c00bc5863	NO
333	760ce247-b948-466b-b2e9-af6c00bc5863	YES
332	760ce247-b948-466b-b2e9-af6c00bc5863	NO
337	760ce247-b948-466b-b2e9-af6c00bc5863	YES
341	760ce247-b948-466b-b2e9-af6c00bc5863	YES
343	760ce247-b948-466b-b2e9-af6c00bc5863	YES
373	760ce247-b948-466b-b2e9-af6c00bc5863	YES
395	760ce247-b948-466b-b2e9-af6c00bc5863	NO
360	760ce247-b948-466b-b2e9-af6c00bc5863	YES
369	760ce247-b948-466b-b2e9-af6c00bc5863	YES
389	760ce247-b948-466b-b2e9-af6c00bc5863	NO
393	760ce247-b948-466b-b2e9-af6c00bc5863	YES
347	760ce247-b948-466b-b2e9-af6c00bc5863	NO
374	760ce247-b948-466b-b2e9-af6c00bc5863	YES
348	760ce247-b948-466b-b2e9-af6c00bc5863	YES
414	760ce247-b948-466b-b2e9-af6c00bc5863	YES
353	760ce247-b948-466b-b2e9-af6c00bc5863	YES
419	760ce247-b948-466b-b2e9-af6c00bc5863	YES
370	760ce247-b948-466b-b2e9-af6c00bc5863	UNKNOWN
422	760ce247-b948-466b-b2e9-af6c00bc5863	NO
371	760ce247-b948-466b-b2e9-af6c00bc5863	NO
358	760ce247-b948-466b-b2e9-af6c00bc5863	NO
396	760ce247-b948-466b-b2e9-af6c00bc5863	NO
440	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
441	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
340	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
210	760ce247-b948-466b-b2e9-af6c00bc5863	YES
161	760ce247-b948-466b-b2e9-af6c00bc5863	UNKNOWN
172	760ce247-b948-466b-b2e9-af6c00bc5863	YES
120	760ce247-b948-466b-b2e9-af6c00bc5863	YES
96	760ce247-b948-466b-b2e9-af6c00bc5863	NO
116	760ce247-b948-466b-b2e9-af6c00bc5863	YES
166	760ce247-b948-466b-b2e9-af6c00bc5863	UNKNOWN
51	760ce247-b948-466b-b2e9-af6c00bc5863	YES
411	760ce247-b948-466b-b2e9-af6c00bc5863	NO
188	760ce247-b948-466b-b2e9-af6c00bc5863	YES
170	760ce247-b948-466b-b2e9-af6c00bc5863	YES
40	760ce247-b948-466b-b2e9-af6c00bc5863	NO
399	760ce247-b948-466b-b2e9-af6c00bc5863	YES
357	760ce247-b948-466b-b2e9-af6c00bc5863	UNKNOWN
418	760ce247-b948-466b-b2e9-af6c00bc5863	YES
354	760ce247-b948-466b-b2e9-af6c00bc5863	NO
392	760ce247-b948-466b-b2e9-af6c00bc5863	YES
391	760ce247-b948-466b-b2e9-af6c00bc5863	YES
404	760ce247-b948-466b-b2e9-af6c00bc5863	YES
405	760ce247-b948-466b-b2e9-af6c00bc5863	YES
420	760ce247-b948-466b-b2e9-af6c00bc5863	NO
424	760ce247-b948-466b-b2e9-af6c00bc5863	NO
394	760ce247-b948-466b-b2e9-af6c00bc5863	YES
425	760ce247-b948-466b-b2e9-af6c00bc5863	YES
426	760ce247-b948-466b-b2e9-af6c00bc5863	NO
427	760ce247-b948-466b-b2e9-af6c00bc5863	YES
428	760ce247-b948-466b-b2e9-af6c00bc5863	NO
431	760ce247-b948-466b-b2e9-af6c00bc5863	YES
430	760ce247-b948-466b-b2e9-af6c00bc5863	YES
432	760ce247-b948-466b-b2e9-af6c00bc5863	YES
433	760ce247-b948-466b-b2e9-af6c00bc5863	NO
436	760ce247-b948-466b-b2e9-af6c00bc5863	YES
437	760ce247-b948-466b-b2e9-af6c00bc5863	YES
439	760ce247-b948-466b-b2e9-af6c00bc5863	YES
440	760ce247-b948-466b-b2e9-af6c00bc5863	YES
441	760ce247-b948-466b-b2e9-af6c00bc5863	YES
340	760ce247-b948-466b-b2e9-af6c00bc5863	YES
210	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
161	9d822ee7-c84c-4178-8b36-4ef00bbb223b	UNKNOWN
172	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
120	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
96	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
159	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
166	9d822ee7-c84c-4178-8b36-4ef00bbb223b	UNKNOWN
51	9d822ee7-c84c-4178-8b36-4ef00bbb223b	UNKNOWN
411	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
188	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
170	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
40	9d822ee7-c84c-4178-8b36-4ef00bbb223b	UNKNOWN
41	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
44	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
49	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
53	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
65	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
6	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
79	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
83	9d822ee7-c84c-4178-8b36-4ef00bbb223b	UNKNOWN
88	9d822ee7-c84c-4178-8b36-4ef00bbb223b	UNKNOWN
98	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
106	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
14	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
149	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
153	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
167	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
168	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
178	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
21	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
211	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
110	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
185	9d822ee7-c84c-4178-8b36-4ef00bbb223b	UNKNOWN
182	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
144	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
198	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
89	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
154	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
100	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
248	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
251	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
261	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
264	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
270	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
271	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
272	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
277	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
278	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
280	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
283	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
285	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
287	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
289	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
293	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
294	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
296	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
297	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
298	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
299	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
304	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
349	760ce247-b948-466b-b2e9-af6c00bc5863	NO
383	760ce247-b948-466b-b2e9-af6c00bc5863	NO
390	760ce247-b948-466b-b2e9-af6c00bc5863	YES
410	760ce247-b948-466b-b2e9-af6c00bc5863	NO
378	760ce247-b948-466b-b2e9-af6c00bc5863	NO
366	760ce247-b948-466b-b2e9-af6c00bc5863	NO
363	760ce247-b948-466b-b2e9-af6c00bc5863	YES
388	760ce247-b948-466b-b2e9-af6c00bc5863	YES
403	760ce247-b948-466b-b2e9-af6c00bc5863	NO
346	760ce247-b948-466b-b2e9-af6c00bc5863	NO
387	760ce247-b948-466b-b2e9-af6c00bc5863	YES
367	760ce247-b948-466b-b2e9-af6c00bc5863	NO
417	760ce247-b948-466b-b2e9-af6c00bc5863	YES
361	760ce247-b948-466b-b2e9-af6c00bc5863	YES
355	760ce247-b948-466b-b2e9-af6c00bc5863	NO
341	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
340	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
343	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
373	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
395	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
360	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
369	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
389	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
393	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
347	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
374	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
348	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
353	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
419	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
370	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
422	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
371	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
358	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
376	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
396	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
386	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
349	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
383	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
390	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
410	9d822ee7-c84c-4178-8b36-4ef00bbb223b	UNKNOWN
378	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
366	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
363	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
388	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
403	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
346	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
387	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
367	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
417	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
361	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
355	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
399	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
357	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
418	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
354	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
392	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
391	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
404	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
405	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
420	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
424	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
394	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
425	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
426	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
427	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
428	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
431	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
430	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
432	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
433	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
436	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
437	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
439	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
440	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
441	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
63	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
310	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
210	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
161	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
172	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
120	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
116	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
159	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
166	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
51	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
411	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
188	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
170	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
40	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
41	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
44	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
49	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
53	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
63	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
65	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
6	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
79	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
83	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
88	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
106	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
306	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
307	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
309	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
312	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
314	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
323	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
327	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
328	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
329	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
331	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
334	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
333	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
332	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
337	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
339	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
248	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
251	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
250	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
261	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
264	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
270	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
271	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
272	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
277	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
278	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
280	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
283	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
287	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
289	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
293	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
294	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
296	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
297	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
298	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
299	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
302	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
304	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
305	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
306	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
307	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
309	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
310	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
312	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
314	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
323	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
328	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
329	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
331	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
334	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
333	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
332	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
337	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
339	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
341	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
340	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
343	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
373	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
395	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
360	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
369	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
389	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
393	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
347	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
348	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
414	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
353	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
419	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
370	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
422	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
371	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
358	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
376	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
396	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
386	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
349	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
383	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
390	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
410	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
378	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
366	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
363	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
403	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
379	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
346	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
387	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
367	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
417	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
361	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
355	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
399	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
357	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
418	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
354	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
392	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
391	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
404	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
405	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
420	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
424	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
425	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
14	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
149	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
153	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
167	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
168	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
178	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
21	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
211	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
110	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
182	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
144	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
198	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
89	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
154	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
100	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
120	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
96	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	UNKNOWN
116	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
159	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
166	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	UNKNOWN
51	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	UNKNOWN
411	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
188	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
170	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
40	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
41	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
44	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
53	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
63	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
65	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
6	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
79	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
83	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
88	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
98	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
106	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
11	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
14	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
149	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
153	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
167	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
168	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
178	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
21	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
211	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
185	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	UNKNOWN
182	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
144	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
198	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
89	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
154	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
100	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
248	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
251	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
250	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
261	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
264	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
270	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
271	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
272	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
277	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
278	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
280	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
285	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
287	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
289	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
293	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
294	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
296	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
297	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
298	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
299	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
302	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	UNKNOWN
305	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
306	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
307	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
309	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
310	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
312	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
314	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
323	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
328	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
329	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
330	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
331	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
334	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
333	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
332	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
337	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
339	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
341	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
340	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
343	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
373	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
360	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
369	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
389	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
393	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
347	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
348	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
426	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
427	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
428	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
431	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
430	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
432	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
433	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
436	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
437	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
440	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
441	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
330	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
210	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
161	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	UNKNOWN
172	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
388	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
403	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
379	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
346	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
387	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
367	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
417	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
361	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
355	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
399	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
357	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
418	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
392	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
391	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
404	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
405	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
420	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
424	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
394	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
425	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
415	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
426	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
427	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
428	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
431	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
430	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
432	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
433	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
436	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
437	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
440	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
441	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
304	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
395	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
210	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
161	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
172	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
120	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
96	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
116	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
159	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
166	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
51	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
411	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
188	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
170	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
40	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
41	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
49	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
53	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
63	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
65	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
6	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
79	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
83	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
88	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
98	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
106	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
11	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
14	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
149	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
153	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
167	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
168	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
178	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
21	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
110	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
185	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
182	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
144	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
198	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
89	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
154	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
100	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
248	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
251	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
250	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
261	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
264	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
270	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
271	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
272	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
277	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
278	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
283	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
353	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
419	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
370	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
422	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
371	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
358	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
376	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
396	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
386	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
383	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
390	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
410	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
378	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
366	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
363	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
314	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
323	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
327	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
328	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
329	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
330	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
331	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
334	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
333	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
337	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
339	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
341	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
343	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
373	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
395	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
360	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
369	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
389	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
393	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
347	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
374	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
348	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
414	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
353	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
419	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
370	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
371	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
358	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
376	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
396	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
349	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
383	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
390	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
410	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
378	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
366	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
363	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
388	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
403	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
379	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
346	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
387	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
367	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
417	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
361	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
355	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
399	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
357	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
354	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
392	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
391	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
404	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
405	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
420	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
424	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
394	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
425	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
415	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
426	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
427	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
428	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
431	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
430	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
432	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
433	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
436	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
439	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
440	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
441	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
332	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
422	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
210	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
161	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
172	0c0c4255-472d-422e-a455-6003c2820090	NO
120	0c0c4255-472d-422e-a455-6003c2820090	NO
96	0c0c4255-472d-422e-a455-6003c2820090	YES
116	0c0c4255-472d-422e-a455-6003c2820090	NO
159	0c0c4255-472d-422e-a455-6003c2820090	YES
166	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
51	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
411	0c0c4255-472d-422e-a455-6003c2820090	YES
188	0c0c4255-472d-422e-a455-6003c2820090	NO
170	0c0c4255-472d-422e-a455-6003c2820090	NO
40	0c0c4255-472d-422e-a455-6003c2820090	YES
44	0c0c4255-472d-422e-a455-6003c2820090	NO
287	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
289	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
293	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
294	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
296	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
297	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
298	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
299	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
302	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
305	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
306	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
307	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
309	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
310	249099df-f86a-4fe6-a532-3df9a15e0e39	UNKNOWN
312	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
21	0c0c4255-472d-422e-a455-6003c2820090	YES
211	0c0c4255-472d-422e-a455-6003c2820090	YES
110	0c0c4255-472d-422e-a455-6003c2820090	YES
185	0c0c4255-472d-422e-a455-6003c2820090	YES
182	0c0c4255-472d-422e-a455-6003c2820090	NO
144	0c0c4255-472d-422e-a455-6003c2820090	YES
198	0c0c4255-472d-422e-a455-6003c2820090	YES
89	0c0c4255-472d-422e-a455-6003c2820090	YES
154	0c0c4255-472d-422e-a455-6003c2820090	YES
100	0c0c4255-472d-422e-a455-6003c2820090	NO
248	0c0c4255-472d-422e-a455-6003c2820090	YES
251	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
261	0c0c4255-472d-422e-a455-6003c2820090	NO
264	0c0c4255-472d-422e-a455-6003c2820090	YES
270	0c0c4255-472d-422e-a455-6003c2820090	NO
271	0c0c4255-472d-422e-a455-6003c2820090	NO
272	0c0c4255-472d-422e-a455-6003c2820090	NO
277	0c0c4255-472d-422e-a455-6003c2820090	NO
278	0c0c4255-472d-422e-a455-6003c2820090	NO
280	0c0c4255-472d-422e-a455-6003c2820090	YES
283	0c0c4255-472d-422e-a455-6003c2820090	NO
285	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
287	0c0c4255-472d-422e-a455-6003c2820090	NO
289	0c0c4255-472d-422e-a455-6003c2820090	NO
293	0c0c4255-472d-422e-a455-6003c2820090	YES
294	0c0c4255-472d-422e-a455-6003c2820090	NO
296	0c0c4255-472d-422e-a455-6003c2820090	YES
297	0c0c4255-472d-422e-a455-6003c2820090	YES
298	0c0c4255-472d-422e-a455-6003c2820090	NO
299	0c0c4255-472d-422e-a455-6003c2820090	NO
304	0c0c4255-472d-422e-a455-6003c2820090	YES
305	0c0c4255-472d-422e-a455-6003c2820090	NO
306	0c0c4255-472d-422e-a455-6003c2820090	NO
307	0c0c4255-472d-422e-a455-6003c2820090	NO
309	0c0c4255-472d-422e-a455-6003c2820090	NO
312	0c0c4255-472d-422e-a455-6003c2820090	NO
314	0c0c4255-472d-422e-a455-6003c2820090	YES
323	0c0c4255-472d-422e-a455-6003c2820090	YES
327	0c0c4255-472d-422e-a455-6003c2820090	NO
328	0c0c4255-472d-422e-a455-6003c2820090	NO
329	0c0c4255-472d-422e-a455-6003c2820090	YES
330	0c0c4255-472d-422e-a455-6003c2820090	YES
331	0c0c4255-472d-422e-a455-6003c2820090	NO
334	0c0c4255-472d-422e-a455-6003c2820090	YES
333	0c0c4255-472d-422e-a455-6003c2820090	NO
337	0c0c4255-472d-422e-a455-6003c2820090	NO
339	0c0c4255-472d-422e-a455-6003c2820090	YES
341	0c0c4255-472d-422e-a455-6003c2820090	NO
343	0c0c4255-472d-422e-a455-6003c2820090	NO
373	0c0c4255-472d-422e-a455-6003c2820090	NO
395	0c0c4255-472d-422e-a455-6003c2820090	YES
360	0c0c4255-472d-422e-a455-6003c2820090	NO
369	0c0c4255-472d-422e-a455-6003c2820090	YES
389	0c0c4255-472d-422e-a455-6003c2820090	YES
393	0c0c4255-472d-422e-a455-6003c2820090	YES
347	0c0c4255-472d-422e-a455-6003c2820090	YES
374	0c0c4255-472d-422e-a455-6003c2820090	YES
348	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
414	0c0c4255-472d-422e-a455-6003c2820090	NO
353	0c0c4255-472d-422e-a455-6003c2820090	YES
419	0c0c4255-472d-422e-a455-6003c2820090	NO
370	0c0c4255-472d-422e-a455-6003c2820090	YES
422	0c0c4255-472d-422e-a455-6003c2820090	YES
371	0c0c4255-472d-422e-a455-6003c2820090	YES
358	0c0c4255-472d-422e-a455-6003c2820090	YES
376	0c0c4255-472d-422e-a455-6003c2820090	NO
386	0c0c4255-472d-422e-a455-6003c2820090	YES
349	0c0c4255-472d-422e-a455-6003c2820090	YES
383	0c0c4255-472d-422e-a455-6003c2820090	YES
390	0c0c4255-472d-422e-a455-6003c2820090	YES
410	0c0c4255-472d-422e-a455-6003c2820090	YES
378	0c0c4255-472d-422e-a455-6003c2820090	YES
366	0c0c4255-472d-422e-a455-6003c2820090	YES
363	0c0c4255-472d-422e-a455-6003c2820090	NO
388	0c0c4255-472d-422e-a455-6003c2820090	YES
403	0c0c4255-472d-422e-a455-6003c2820090	YES
379	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
346	0c0c4255-472d-422e-a455-6003c2820090	YES
387	0c0c4255-472d-422e-a455-6003c2820090	NO
367	0c0c4255-472d-422e-a455-6003c2820090	YES
417	0c0c4255-472d-422e-a455-6003c2820090	NO
361	0c0c4255-472d-422e-a455-6003c2820090	YES
355	0c0c4255-472d-422e-a455-6003c2820090	YES
399	0c0c4255-472d-422e-a455-6003c2820090	NO
418	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
53	0c0c4255-472d-422e-a455-6003c2820090	YES
63	0c0c4255-472d-422e-a455-6003c2820090	NO
65	0c0c4255-472d-422e-a455-6003c2820090	NO
6	0c0c4255-472d-422e-a455-6003c2820090	NO
79	0c0c4255-472d-422e-a455-6003c2820090	YES
83	0c0c4255-472d-422e-a455-6003c2820090	YES
88	0c0c4255-472d-422e-a455-6003c2820090	YES
98	0c0c4255-472d-422e-a455-6003c2820090	YES
106	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
14	0c0c4255-472d-422e-a455-6003c2820090	NO
149	0c0c4255-472d-422e-a455-6003c2820090	NO
153	0c0c4255-472d-422e-a455-6003c2820090	NO
167	0c0c4255-472d-422e-a455-6003c2820090	NO
168	0c0c4255-472d-422e-a455-6003c2820090	YES
178	0c0c4255-472d-422e-a455-6003c2820090	NO
436	0c0c4255-472d-422e-a455-6003c2820090	YES
437	0c0c4255-472d-422e-a455-6003c2820090	NO
439	0c0c4255-472d-422e-a455-6003c2820090	NO
440	0c0c4255-472d-422e-a455-6003c2820090	NO
441	0c0c4255-472d-422e-a455-6003c2820090	NO
310	0c0c4255-472d-422e-a455-6003c2820090	YES
332	0c0c4255-472d-422e-a455-6003c2820090	YES
210	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
161	96151634-acf2-4f9e-bd54-afb7007c8a7b	UNKNOWN
172	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
120	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
96	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
159	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
166	96151634-acf2-4f9e-bd54-afb7007c8a7b	UNKNOWN
51	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
411	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
188	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
170	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
40	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
41	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
44	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
49	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
53	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
63	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
65	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
6	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
79	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
83	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
88	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
98	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
11	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
14	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
149	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
153	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
167	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
168	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
178	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
21	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
211	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
110	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
185	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
182	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
144	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
198	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
89	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
154	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
100	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
248	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
250	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
261	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
264	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
270	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
271	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
272	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
277	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
278	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
280	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
283	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
285	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
287	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
289	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
293	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
294	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
296	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
297	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
298	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
302	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
304	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
305	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
306	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
307	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
309	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
310	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
312	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
314	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
323	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
327	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
328	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
329	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
330	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
331	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
334	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
333	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
332	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
339	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
392	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
391	0c0c4255-472d-422e-a455-6003c2820090	NO
404	0c0c4255-472d-422e-a455-6003c2820090	NO
405	0c0c4255-472d-422e-a455-6003c2820090	NO
420	0c0c4255-472d-422e-a455-6003c2820090	YES
424	0c0c4255-472d-422e-a455-6003c2820090	YES
394	0c0c4255-472d-422e-a455-6003c2820090	NO
425	0c0c4255-472d-422e-a455-6003c2820090	NO
415	0c0c4255-472d-422e-a455-6003c2820090	YES
427	0c0c4255-472d-422e-a455-6003c2820090	NO
428	0c0c4255-472d-422e-a455-6003c2820090	YES
431	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
430	0c0c4255-472d-422e-a455-6003c2820090	YES
432	0c0c4255-472d-422e-a455-6003c2820090	NO
433	0c0c4255-472d-422e-a455-6003c2820090	YES
371	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
358	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
376	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
396	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
386	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
349	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
383	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
390	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
410	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
378	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
366	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
363	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
403	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
379	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
346	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
387	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
367	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
417	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
361	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
355	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
399	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
357	96151634-acf2-4f9e-bd54-afb7007c8a7b	UNKNOWN
418	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
354	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
392	96151634-acf2-4f9e-bd54-afb7007c8a7b	UNKNOWN
391	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
404	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
405	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
420	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
424	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
425	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
415	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
426	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
427	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
428	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
431	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
430	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
432	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
433	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
436	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
437	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
439	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
440	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
441	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
210	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
161	e2c7af9b-2788-406b-b382-afc500e2de5a	UNKNOWN
172	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
120	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
116	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
159	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
166	e2c7af9b-2788-406b-b382-afc500e2de5a	UNKNOWN
51	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
411	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
188	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
170	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
40	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
41	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
44	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
49	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
53	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
63	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
65	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
6	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
79	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
83	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
88	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
106	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
11	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
14	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
149	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
153	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
167	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
168	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
178	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
21	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
211	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
110	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
185	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
182	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
144	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
198	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
89	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
154	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
100	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
251	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
340	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
343	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
373	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
395	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
360	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
369	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
389	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
393	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
347	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
348	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
414	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
353	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
419	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
370	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
422	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
299	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
302	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
304	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
305	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
306	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
307	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
309	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
310	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
312	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
314	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
323	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
328	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
329	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
330	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
331	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
334	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
333	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
332	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
337	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
339	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
341	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
340	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
343	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
373	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
395	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
360	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
369	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
389	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
393	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
374	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
348	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
414	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
353	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
419	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
370	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
422	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
371	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
358	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
376	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
396	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
386	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
349	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
383	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
390	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
410	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
378	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
366	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
388	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
403	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
379	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
346	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
387	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
367	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
417	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
361	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
355	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
399	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
357	e2c7af9b-2788-406b-b382-afc500e2de5a	UNKNOWN
418	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
354	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
392	e2c7af9b-2788-406b-b382-afc500e2de5a	UNKNOWN
391	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
404	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
405	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
420	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
394	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
425	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
415	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
426	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
427	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
428	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
431	e2c7af9b-2788-406b-b382-afc500e2de5a	UNKNOWN
430	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
432	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
433	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
436	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
437	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
439	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
440	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
441	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
210	ea3c08d8-29ef-4750-9746-aff900b12965	NO
161	ea3c08d8-29ef-4750-9746-aff900b12965	UNKNOWN
172	ea3c08d8-29ef-4750-9746-aff900b12965	NO
96	ea3c08d8-29ef-4750-9746-aff900b12965	YES
261	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
264	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
270	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
271	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
272	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
277	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
278	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
280	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
283	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
287	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
289	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
298	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
293	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
296	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
297	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
83	ea3c08d8-29ef-4750-9746-aff900b12965	NO
88	ea3c08d8-29ef-4750-9746-aff900b12965	YES
98	ea3c08d8-29ef-4750-9746-aff900b12965	YES
106	ea3c08d8-29ef-4750-9746-aff900b12965	NO
11	ea3c08d8-29ef-4750-9746-aff900b12965	NO
14	ea3c08d8-29ef-4750-9746-aff900b12965	NO
149	ea3c08d8-29ef-4750-9746-aff900b12965	NO
153	ea3c08d8-29ef-4750-9746-aff900b12965	NO
167	ea3c08d8-29ef-4750-9746-aff900b12965	NO
168	ea3c08d8-29ef-4750-9746-aff900b12965	YES
178	ea3c08d8-29ef-4750-9746-aff900b12965	NO
21	ea3c08d8-29ef-4750-9746-aff900b12965	NO
211	ea3c08d8-29ef-4750-9746-aff900b12965	YES
185	ea3c08d8-29ef-4750-9746-aff900b12965	NO
182	ea3c08d8-29ef-4750-9746-aff900b12965	NO
144	ea3c08d8-29ef-4750-9746-aff900b12965	YES
198	ea3c08d8-29ef-4750-9746-aff900b12965	YES
89	ea3c08d8-29ef-4750-9746-aff900b12965	YES
154	ea3c08d8-29ef-4750-9746-aff900b12965	YES
100	ea3c08d8-29ef-4750-9746-aff900b12965	NO
248	ea3c08d8-29ef-4750-9746-aff900b12965	NO
251	ea3c08d8-29ef-4750-9746-aff900b12965	NO
250	ea3c08d8-29ef-4750-9746-aff900b12965	NO
261	ea3c08d8-29ef-4750-9746-aff900b12965	NO
264	ea3c08d8-29ef-4750-9746-aff900b12965	YES
270	ea3c08d8-29ef-4750-9746-aff900b12965	NO
271	ea3c08d8-29ef-4750-9746-aff900b12965	NO
272	ea3c08d8-29ef-4750-9746-aff900b12965	NO
277	ea3c08d8-29ef-4750-9746-aff900b12965	NO
278	ea3c08d8-29ef-4750-9746-aff900b12965	NO
280	ea3c08d8-29ef-4750-9746-aff900b12965	YES
285	ea3c08d8-29ef-4750-9746-aff900b12965	NO
287	ea3c08d8-29ef-4750-9746-aff900b12965	NO
289	ea3c08d8-29ef-4750-9746-aff900b12965	NO
293	ea3c08d8-29ef-4750-9746-aff900b12965	YES
294	ea3c08d8-29ef-4750-9746-aff900b12965	NO
296	ea3c08d8-29ef-4750-9746-aff900b12965	YES
297	ea3c08d8-29ef-4750-9746-aff900b12965	NO
298	ea3c08d8-29ef-4750-9746-aff900b12965	NO
299	ea3c08d8-29ef-4750-9746-aff900b12965	NO
302	ea3c08d8-29ef-4750-9746-aff900b12965	NO
304	ea3c08d8-29ef-4750-9746-aff900b12965	YES
305	ea3c08d8-29ef-4750-9746-aff900b12965	NO
306	ea3c08d8-29ef-4750-9746-aff900b12965	NO
307	ea3c08d8-29ef-4750-9746-aff900b12965	NO
309	ea3c08d8-29ef-4750-9746-aff900b12965	NO
310	ea3c08d8-29ef-4750-9746-aff900b12965	NO
312	ea3c08d8-29ef-4750-9746-aff900b12965	NO
314	ea3c08d8-29ef-4750-9746-aff900b12965	NO
327	ea3c08d8-29ef-4750-9746-aff900b12965	NO
328	ea3c08d8-29ef-4750-9746-aff900b12965	NO
329	ea3c08d8-29ef-4750-9746-aff900b12965	YES
330	ea3c08d8-29ef-4750-9746-aff900b12965	YES
331	ea3c08d8-29ef-4750-9746-aff900b12965	NO
334	ea3c08d8-29ef-4750-9746-aff900b12965	YES
333	ea3c08d8-29ef-4750-9746-aff900b12965	NO
332	ea3c08d8-29ef-4750-9746-aff900b12965	YES
337	ea3c08d8-29ef-4750-9746-aff900b12965	NO
339	ea3c08d8-29ef-4750-9746-aff900b12965	YES
341	ea3c08d8-29ef-4750-9746-aff900b12965	NO
340	ea3c08d8-29ef-4750-9746-aff900b12965	NO
343	ea3c08d8-29ef-4750-9746-aff900b12965	NO
373	ea3c08d8-29ef-4750-9746-aff900b12965	NO
395	ea3c08d8-29ef-4750-9746-aff900b12965	YES
360	ea3c08d8-29ef-4750-9746-aff900b12965	NO
369	ea3c08d8-29ef-4750-9746-aff900b12965	NO
389	ea3c08d8-29ef-4750-9746-aff900b12965	YES
347	ea3c08d8-29ef-4750-9746-aff900b12965	YES
374	ea3c08d8-29ef-4750-9746-aff900b12965	NO
348	ea3c08d8-29ef-4750-9746-aff900b12965	NO
414	ea3c08d8-29ef-4750-9746-aff900b12965	NO
353	ea3c08d8-29ef-4750-9746-aff900b12965	NO
419	ea3c08d8-29ef-4750-9746-aff900b12965	NO
370	ea3c08d8-29ef-4750-9746-aff900b12965	YES
422	ea3c08d8-29ef-4750-9746-aff900b12965	YES
371	ea3c08d8-29ef-4750-9746-aff900b12965	YES
358	ea3c08d8-29ef-4750-9746-aff900b12965	YES
376	ea3c08d8-29ef-4750-9746-aff900b12965	NO
396	ea3c08d8-29ef-4750-9746-aff900b12965	YES
386	ea3c08d8-29ef-4750-9746-aff900b12965	YES
349	ea3c08d8-29ef-4750-9746-aff900b12965	YES
383	ea3c08d8-29ef-4750-9746-aff900b12965	YES
390	ea3c08d8-29ef-4750-9746-aff900b12965	NO
410	ea3c08d8-29ef-4750-9746-aff900b12965	YES
378	ea3c08d8-29ef-4750-9746-aff900b12965	YES
363	ea3c08d8-29ef-4750-9746-aff900b12965	NO
159	ea3c08d8-29ef-4750-9746-aff900b12965	YES
166	ea3c08d8-29ef-4750-9746-aff900b12965	UNKNOWN
51	ea3c08d8-29ef-4750-9746-aff900b12965	NO
411	ea3c08d8-29ef-4750-9746-aff900b12965	YES
188	ea3c08d8-29ef-4750-9746-aff900b12965	NO
170	ea3c08d8-29ef-4750-9746-aff900b12965	NO
40	ea3c08d8-29ef-4750-9746-aff900b12965	YES
41	ea3c08d8-29ef-4750-9746-aff900b12965	NO
44	ea3c08d8-29ef-4750-9746-aff900b12965	NO
53	ea3c08d8-29ef-4750-9746-aff900b12965	NO
63	ea3c08d8-29ef-4750-9746-aff900b12965	NO
65	ea3c08d8-29ef-4750-9746-aff900b12965	NO
6	ea3c08d8-29ef-4750-9746-aff900b12965	NO
79	ea3c08d8-29ef-4750-9746-aff900b12965	NO
405	ea3c08d8-29ef-4750-9746-aff900b12965	NO
420	ea3c08d8-29ef-4750-9746-aff900b12965	YES
424	ea3c08d8-29ef-4750-9746-aff900b12965	YES
394	ea3c08d8-29ef-4750-9746-aff900b12965	NO
425	ea3c08d8-29ef-4750-9746-aff900b12965	NO
415	ea3c08d8-29ef-4750-9746-aff900b12965	NO
426	ea3c08d8-29ef-4750-9746-aff900b12965	YES
427	ea3c08d8-29ef-4750-9746-aff900b12965	NO
428	ea3c08d8-29ef-4750-9746-aff900b12965	YES
431	ea3c08d8-29ef-4750-9746-aff900b12965	NO
430	ea3c08d8-29ef-4750-9746-aff900b12965	NO
432	ea3c08d8-29ef-4750-9746-aff900b12965	NO
433	ea3c08d8-29ef-4750-9746-aff900b12965	YES
437	ea3c08d8-29ef-4750-9746-aff900b12965	NO
439	ea3c08d8-29ef-4750-9746-aff900b12965	NO
440	ea3c08d8-29ef-4750-9746-aff900b12965	NO
441	ea3c08d8-29ef-4750-9746-aff900b12965	NO
210	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
161	8273b1c3-94f7-422a-a1d8-aff900989e6a	UNKNOWN
172	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
120	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
96	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
116	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
159	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
166	8273b1c3-94f7-422a-a1d8-aff900989e6a	UNKNOWN
51	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
411	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
188	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
170	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
40	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
41	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
49	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
53	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
63	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
65	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
6	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
79	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
83	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
88	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
98	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
106	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
11	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
14	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
149	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
153	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
167	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
168	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
178	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
21	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
110	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
185	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
182	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
144	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
198	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
89	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
154	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
100	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
248	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
251	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
250	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
261	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
264	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
270	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
271	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
272	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
277	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
278	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
283	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
285	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
287	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
289	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
293	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
294	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
296	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
297	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
298	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
299	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
302	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
304	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
305	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
306	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
307	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
309	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
310	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
312	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
323	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
403	ea3c08d8-29ef-4750-9746-aff900b12965	YES
379	ea3c08d8-29ef-4750-9746-aff900b12965	NO
346	ea3c08d8-29ef-4750-9746-aff900b12965	YES
387	ea3c08d8-29ef-4750-9746-aff900b12965	NO
367	ea3c08d8-29ef-4750-9746-aff900b12965	YES
417	ea3c08d8-29ef-4750-9746-aff900b12965	NO
361	ea3c08d8-29ef-4750-9746-aff900b12965	NO
355	ea3c08d8-29ef-4750-9746-aff900b12965	YES
399	ea3c08d8-29ef-4750-9746-aff900b12965	NO
418	ea3c08d8-29ef-4750-9746-aff900b12965	NO
354	ea3c08d8-29ef-4750-9746-aff900b12965	YES
392	ea3c08d8-29ef-4750-9746-aff900b12965	UNKNOWN
391	ea3c08d8-29ef-4750-9746-aff900b12965	NO
404	ea3c08d8-29ef-4750-9746-aff900b12965	NO
369	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
389	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
393	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
347	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
374	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
348	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
414	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
353	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
419	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
370	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
422	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
371	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
358	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
396	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
386	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
349	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
383	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
390	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
410	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
378	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
366	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
363	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
388	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
403	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
379	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
346	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
387	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
367	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
417	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
361	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
355	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
357	8273b1c3-94f7-422a-a1d8-aff900989e6a	UNKNOWN
418	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
354	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
392	8273b1c3-94f7-422a-a1d8-aff900989e6a	UNKNOWN
391	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
404	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
405	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
420	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
424	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
394	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
425	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
415	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
426	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
427	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
428	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
431	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
430	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
432	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
436	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
437	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
439	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
440	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
441	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
210	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
161	ff195055-5b7e-48ec-b23f-b02200c25d67	UNKNOWN
172	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
120	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
96	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
116	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
159	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
166	ff195055-5b7e-48ec-b23f-b02200c25d67	UNKNOWN
51	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
411	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
188	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
170	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
40	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
44	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
49	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
53	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
63	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
65	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
6	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
79	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
83	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
88	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
98	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
106	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
11	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
14	ff195055-5b7e-48ec-b23f-b02200c25d67	UNKNOWN
149	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
153	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
167	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
168	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
178	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
211	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
328	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
329	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
330	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
331	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
334	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
333	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
332	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
337	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
339	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
340	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
343	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
373	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
395	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
360	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
277	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
278	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
280	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
283	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
285	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
287	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
289	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
293	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
294	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
296	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
297	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
298	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
299	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
304	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
305	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
306	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
307	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
309	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
310	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
312	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
314	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
323	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
327	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
328	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
329	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
330	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
331	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
334	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
333	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
332	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
337	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
341	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
340	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
343	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
373	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
395	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
360	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
369	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
389	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
393	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
347	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
374	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
348	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
414	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
353	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
419	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
370	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
422	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
371	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
376	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
396	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
386	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
349	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
383	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
390	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
410	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
378	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
366	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
363	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
388	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
403	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
379	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
346	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
387	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
367	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
417	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
361	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
399	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
357	ff195055-5b7e-48ec-b23f-b02200c25d67	UNKNOWN
418	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
354	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
392	ff195055-5b7e-48ec-b23f-b02200c25d67	UNKNOWN
391	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
404	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
405	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
420	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
424	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
394	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
425	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
415	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
426	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
427	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
428	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
431	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
430	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
433	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
185	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
182	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
144	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
198	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
89	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
154	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
100	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
248	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
251	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
261	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
264	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
270	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
271	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
272	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
270	c7419180-6830-435c-91c2-aa63009730dd	NO
280	c7419180-6830-435c-91c2-aa63009730dd	YES
289	c7419180-6830-435c-91c2-aa63009730dd	NO
298	c7419180-6830-435c-91c2-aa63009730dd	NO
305	c7419180-6830-435c-91c2-aa63009730dd	NO
312	c7419180-6830-435c-91c2-aa63009730dd	NO
327	c7419180-6830-435c-91c2-aa63009730dd	YES
328	c7419180-6830-435c-91c2-aa63009730dd	NO
329	c7419180-6830-435c-91c2-aa63009730dd	YES
330	c7419180-6830-435c-91c2-aa63009730dd	YES
331	c7419180-6830-435c-91c2-aa63009730dd	YES
334	c7419180-6830-435c-91c2-aa63009730dd	YES
333	c7419180-6830-435c-91c2-aa63009730dd	YES
332	c7419180-6830-435c-91c2-aa63009730dd	YES
337	c7419180-6830-435c-91c2-aa63009730dd	UNKNOWN
339	c7419180-6830-435c-91c2-aa63009730dd	YES
341	c7419180-6830-435c-91c2-aa63009730dd	NO
340	c7419180-6830-435c-91c2-aa63009730dd	YES
343	c7419180-6830-435c-91c2-aa63009730dd	NO
373	c7419180-6830-435c-91c2-aa63009730dd	NO
395	c7419180-6830-435c-91c2-aa63009730dd	YES
369	c7419180-6830-435c-91c2-aa63009730dd	YES
389	c7419180-6830-435c-91c2-aa63009730dd	YES
393	c7419180-6830-435c-91c2-aa63009730dd	NO
347	c7419180-6830-435c-91c2-aa63009730dd	YES
374	c7419180-6830-435c-91c2-aa63009730dd	NO
348	c7419180-6830-435c-91c2-aa63009730dd	YES
414	c7419180-6830-435c-91c2-aa63009730dd	YES
353	c7419180-6830-435c-91c2-aa63009730dd	NO
419	c7419180-6830-435c-91c2-aa63009730dd	YES
370	c7419180-6830-435c-91c2-aa63009730dd	YES
422	c7419180-6830-435c-91c2-aa63009730dd	YES
371	c7419180-6830-435c-91c2-aa63009730dd	YES
358	c7419180-6830-435c-91c2-aa63009730dd	YES
376	c7419180-6830-435c-91c2-aa63009730dd	NO
396	c7419180-6830-435c-91c2-aa63009730dd	YES
161	c7419180-6830-435c-91c2-aa63009730dd	UNKNOWN
172	c7419180-6830-435c-91c2-aa63009730dd	NO
120	c7419180-6830-435c-91c2-aa63009730dd	NO
436	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
116	c7419180-6830-435c-91c2-aa63009730dd	NO
159	c7419180-6830-435c-91c2-aa63009730dd	YES
166	c7419180-6830-435c-91c2-aa63009730dd	YES
437	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
411	c7419180-6830-435c-91c2-aa63009730dd	YES
170	c7419180-6830-435c-91c2-aa63009730dd	NO
40	c7419180-6830-435c-91c2-aa63009730dd	YES
439	ff195055-5b7e-48ec-b23f-b02200c25d67	UNKNOWN
44	c7419180-6830-435c-91c2-aa63009730dd	NO
49	c7419180-6830-435c-91c2-aa63009730dd	YES
53	c7419180-6830-435c-91c2-aa63009730dd	YES
440	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
65	c7419180-6830-435c-91c2-aa63009730dd	YES
6	c7419180-6830-435c-91c2-aa63009730dd	NO
79	c7419180-6830-435c-91c2-aa63009730dd	NO
441	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
88	c7419180-6830-435c-91c2-aa63009730dd	YES
98	c7419180-6830-435c-91c2-aa63009730dd	YES
106	c7419180-6830-435c-91c2-aa63009730dd	YES
96	c7419180-6830-435c-91c2-aa63009730dd	YES
149	c7419180-6830-435c-91c2-aa63009730dd	YES
153	c7419180-6830-435c-91c2-aa63009730dd	YES
167	c7419180-6830-435c-91c2-aa63009730dd	NO
51	c7419180-6830-435c-91c2-aa63009730dd	UNKNOWN
21	c7419180-6830-435c-91c2-aa63009730dd	NO
211	c7419180-6830-435c-91c2-aa63009730dd	YES
110	c7419180-6830-435c-91c2-aa63009730dd	YES
41	c7419180-6830-435c-91c2-aa63009730dd	NO
182	c7419180-6830-435c-91c2-aa63009730dd	NO
144	c7419180-6830-435c-91c2-aa63009730dd	YES
198	c7419180-6830-435c-91c2-aa63009730dd	YES
63	c7419180-6830-435c-91c2-aa63009730dd	UNKNOWN
154	c7419180-6830-435c-91c2-aa63009730dd	YES
100	c7419180-6830-435c-91c2-aa63009730dd	YES
248	c7419180-6830-435c-91c2-aa63009730dd	NO
83	c7419180-6830-435c-91c2-aa63009730dd	YES
250	c7419180-6830-435c-91c2-aa63009730dd	NO
261	c7419180-6830-435c-91c2-aa63009730dd	UNKNOWN
264	c7419180-6830-435c-91c2-aa63009730dd	YES
14	c7419180-6830-435c-91c2-aa63009730dd	YES
271	c7419180-6830-435c-91c2-aa63009730dd	NO
277	c7419180-6830-435c-91c2-aa63009730dd	NO
278	c7419180-6830-435c-91c2-aa63009730dd	NO
178	c7419180-6830-435c-91c2-aa63009730dd	YES
283	c7419180-6830-435c-91c2-aa63009730dd	NO
285	c7419180-6830-435c-91c2-aa63009730dd	NO
287	c7419180-6830-435c-91c2-aa63009730dd	NO
185	c7419180-6830-435c-91c2-aa63009730dd	NO
293	c7419180-6830-435c-91c2-aa63009730dd	YES
294	c7419180-6830-435c-91c2-aa63009730dd	UNKNOWN
296	c7419180-6830-435c-91c2-aa63009730dd	YES
89	c7419180-6830-435c-91c2-aa63009730dd	YES
299	c7419180-6830-435c-91c2-aa63009730dd	NO
302	c7419180-6830-435c-91c2-aa63009730dd	NO
304	c7419180-6830-435c-91c2-aa63009730dd	YES
251	c7419180-6830-435c-91c2-aa63009730dd	NO
306	c7419180-6830-435c-91c2-aa63009730dd	NO
307	c7419180-6830-435c-91c2-aa63009730dd	NO
309	c7419180-6830-435c-91c2-aa63009730dd	NO
314	c7419180-6830-435c-91c2-aa63009730dd	NO
323	c7419180-6830-435c-91c2-aa63009730dd	YES
437	c7419180-6830-435c-91c2-aa63009730dd	YES
100	d938eee3-7755-4da0-8494-0887ac618422	YES
248	d938eee3-7755-4da0-8494-0887ac618422	YES
388	c7419180-6830-435c-91c2-aa63009730dd	NO
403	c7419180-6830-435c-91c2-aa63009730dd	YES
159	d938eee3-7755-4da0-8494-0887ac618422	YES
346	c7419180-6830-435c-91c2-aa63009730dd	YES
387	c7419180-6830-435c-91c2-aa63009730dd	NO
367	c7419180-6830-435c-91c2-aa63009730dd	YES
63	d938eee3-7755-4da0-8494-0887ac618422	YES
361	c7419180-6830-435c-91c2-aa63009730dd	NO
355	c7419180-6830-435c-91c2-aa63009730dd	YES
399	c7419180-6830-435c-91c2-aa63009730dd	UNKNOWN
153	d938eee3-7755-4da0-8494-0887ac618422	YES
418	c7419180-6830-435c-91c2-aa63009730dd	YES
354	c7419180-6830-435c-91c2-aa63009730dd	YES
392	c7419180-6830-435c-91c2-aa63009730dd	NO
89	d938eee3-7755-4da0-8494-0887ac618422	YES
404	c7419180-6830-435c-91c2-aa63009730dd	YES
405	c7419180-6830-435c-91c2-aa63009730dd	NO
420	c7419180-6830-435c-91c2-aa63009730dd	YES
172	d938eee3-7755-4da0-8494-0887ac618422	NO
394	c7419180-6830-435c-91c2-aa63009730dd	NO
425	c7419180-6830-435c-91c2-aa63009730dd	NO
415	c7419180-6830-435c-91c2-aa63009730dd	NO
41	d938eee3-7755-4da0-8494-0887ac618422	NO
427	c7419180-6830-435c-91c2-aa63009730dd	NO
428	c7419180-6830-435c-91c2-aa63009730dd	YES
431	c7419180-6830-435c-91c2-aa63009730dd	YES
106	d938eee3-7755-4da0-8494-0887ac618422	YES
432	c7419180-6830-435c-91c2-aa63009730dd	NO
433	c7419180-6830-435c-91c2-aa63009730dd	YES
436	c7419180-6830-435c-91c2-aa63009730dd	NO
185	d938eee3-7755-4da0-8494-0887ac618422	UNKNOWN
439	c7419180-6830-435c-91c2-aa63009730dd	YES
440	c7419180-6830-435c-91c2-aa63009730dd	UNKNOWN
441	c7419180-6830-435c-91c2-aa63009730dd	NO
264	d938eee3-7755-4da0-8494-0887ac618422	YES
297	c7419180-6830-435c-91c2-aa63009730dd	NO
188	d938eee3-7755-4da0-8494-0887ac618422	YES
188	c7419180-6830-435c-91c2-aa63009730dd	YES
411	d938eee3-7755-4da0-8494-0887ac618422	YES
272	c7419180-6830-435c-91c2-aa63009730dd	NO
349	c7419180-6830-435c-91c2-aa63009730dd	YES
21	d938eee3-7755-4da0-8494-0887ac618422	YES
390	c7419180-6830-435c-91c2-aa63009730dd	NO
178	d938eee3-7755-4da0-8494-0887ac618422	YES
378	c7419180-6830-435c-91c2-aa63009730dd	YES
251	d938eee3-7755-4da0-8494-0887ac618422	YES
363	c7419180-6830-435c-91c2-aa63009730dd	YES
389	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
250	d938eee3-7755-4da0-8494-0887ac618422	NO
261	d938eee3-7755-4da0-8494-0887ac618422	NO
424	c7419180-6830-435c-91c2-aa63009730dd	YES
83	d938eee3-7755-4da0-8494-0887ac618422	YES
360	c7419180-6830-435c-91c2-aa63009730dd	NO
79	d938eee3-7755-4da0-8494-0887ac618422	YES
210	d938eee3-7755-4da0-8494-0887ac618422	YES
161	d938eee3-7755-4da0-8494-0887ac618422	UNKNOWN
379	c7419180-6830-435c-91c2-aa63009730dd	NO
120	d938eee3-7755-4da0-8494-0887ac618422	YES
96	d938eee3-7755-4da0-8494-0887ac618422	UNKNOWN
116	d938eee3-7755-4da0-8494-0887ac618422	NO
378	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
166	d938eee3-7755-4da0-8494-0887ac618422	YES
51	d938eee3-7755-4da0-8494-0887ac618422	YES
426	c7419180-6830-435c-91c2-aa63009730dd	YES
167	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
170	d938eee3-7755-4da0-8494-0887ac618422	UNKNOWN
40	d938eee3-7755-4da0-8494-0887ac618422	YES
417	c7419180-6830-435c-91c2-aa63009730dd	YES
44	d938eee3-7755-4da0-8494-0887ac618422	UNKNOWN
49	d938eee3-7755-4da0-8494-0887ac618422	YES
53	d938eee3-7755-4da0-8494-0887ac618422	YES
310	c7419180-6830-435c-91c2-aa63009730dd	NO
65	d938eee3-7755-4da0-8494-0887ac618422	YES
6	d938eee3-7755-4da0-8494-0887ac618422	NO
11	c7419180-6830-435c-91c2-aa63009730dd	YES
271	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
88	d938eee3-7755-4da0-8494-0887ac618422	YES
98	d938eee3-7755-4da0-8494-0887ac618422	YES
357	c7419180-6830-435c-91c2-aa63009730dd	YES
11	d938eee3-7755-4da0-8494-0887ac618422	YES
14	d938eee3-7755-4da0-8494-0887ac618422	YES
149	d938eee3-7755-4da0-8494-0887ac618422	YES
383	c7419180-6830-435c-91c2-aa63009730dd	YES
167	d938eee3-7755-4da0-8494-0887ac618422	YES
168	d938eee3-7755-4da0-8494-0887ac618422	YES
307	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
211	d938eee3-7755-4da0-8494-0887ac618422	YES
110	d938eee3-7755-4da0-8494-0887ac618422	YES
391	c7419180-6830-435c-91c2-aa63009730dd	NO
182	d938eee3-7755-4da0-8494-0887ac618422	NO
144	d938eee3-7755-4da0-8494-0887ac618422	YES
198	d938eee3-7755-4da0-8494-0887ac618422	YES
366	c7419180-6830-435c-91c2-aa63009730dd	YES
154	d938eee3-7755-4da0-8494-0887ac618422	YES
168	c7419180-6830-435c-91c2-aa63009730dd	YES
386	c7419180-6830-435c-91c2-aa63009730dd	YES
410	c7419180-6830-435c-91c2-aa63009730dd	YES
430	c7419180-6830-435c-91c2-aa63009730dd	NO
430	d938eee3-7755-4da0-8494-0887ac618422	YES
432	d938eee3-7755-4da0-8494-0887ac618422	NO
387	d938eee3-7755-4da0-8494-0887ac618422	UNKNOWN
436	d938eee3-7755-4da0-8494-0887ac618422	YES
437	d938eee3-7755-4da0-8494-0887ac618422	YES
439	d938eee3-7755-4da0-8494-0887ac618422	YES
440	d938eee3-7755-4da0-8494-0887ac618422	NO
270	d938eee3-7755-4da0-8494-0887ac618422	YES
271	d938eee3-7755-4da0-8494-0887ac618422	NO
272	d938eee3-7755-4da0-8494-0887ac618422	NO
420	d938eee3-7755-4da0-8494-0887ac618422	YES
277	d938eee3-7755-4da0-8494-0887ac618422	NO
280	d938eee3-7755-4da0-8494-0887ac618422	YES
283	d938eee3-7755-4da0-8494-0887ac618422	NO
285	d938eee3-7755-4da0-8494-0887ac618422	NO
294	d938eee3-7755-4da0-8494-0887ac618422	NO
296	d938eee3-7755-4da0-8494-0887ac618422	YES
297	d938eee3-7755-4da0-8494-0887ac618422	YES
298	d938eee3-7755-4da0-8494-0887ac618422	YES
299	d938eee3-7755-4da0-8494-0887ac618422	NO
302	d938eee3-7755-4da0-8494-0887ac618422	YES
304	d938eee3-7755-4da0-8494-0887ac618422	YES
305	d938eee3-7755-4da0-8494-0887ac618422	NO
306	d938eee3-7755-4da0-8494-0887ac618422	NO
433	d938eee3-7755-4da0-8494-0887ac618422	YES
307	d938eee3-7755-4da0-8494-0887ac618422	NO
309	d938eee3-7755-4da0-8494-0887ac618422	NO
310	d938eee3-7755-4da0-8494-0887ac618422	YES
312	d938eee3-7755-4da0-8494-0887ac618422	NO
314	d938eee3-7755-4da0-8494-0887ac618422	YES
323	d938eee3-7755-4da0-8494-0887ac618422	YES
327	d938eee3-7755-4da0-8494-0887ac618422	YES
328	d938eee3-7755-4da0-8494-0887ac618422	YES
329	d938eee3-7755-4da0-8494-0887ac618422	YES
278	d938eee3-7755-4da0-8494-0887ac618422	YES
330	d938eee3-7755-4da0-8494-0887ac618422	YES
334	d938eee3-7755-4da0-8494-0887ac618422	YES
333	d938eee3-7755-4da0-8494-0887ac618422	YES
332	d938eee3-7755-4da0-8494-0887ac618422	YES
337	d938eee3-7755-4da0-8494-0887ac618422	UNKNOWN
339	d938eee3-7755-4da0-8494-0887ac618422	YES
293	d938eee3-7755-4da0-8494-0887ac618422	YES
341	d938eee3-7755-4da0-8494-0887ac618422	NO
340	d938eee3-7755-4da0-8494-0887ac618422	YES
343	d938eee3-7755-4da0-8494-0887ac618422	NO
373	d938eee3-7755-4da0-8494-0887ac618422	NO
395	d938eee3-7755-4da0-8494-0887ac618422	YES
360	d938eee3-7755-4da0-8494-0887ac618422	NO
369	d938eee3-7755-4da0-8494-0887ac618422	YES
389	d938eee3-7755-4da0-8494-0887ac618422	YES
393	d938eee3-7755-4da0-8494-0887ac618422	YES
347	d938eee3-7755-4da0-8494-0887ac618422	YES
374	d938eee3-7755-4da0-8494-0887ac618422	YES
348	d938eee3-7755-4da0-8494-0887ac618422	YES
414	d938eee3-7755-4da0-8494-0887ac618422	YES
419	d938eee3-7755-4da0-8494-0887ac618422	YES
370	d938eee3-7755-4da0-8494-0887ac618422	YES
422	d938eee3-7755-4da0-8494-0887ac618422	YES
371	d938eee3-7755-4da0-8494-0887ac618422	YES
358	d938eee3-7755-4da0-8494-0887ac618422	YES
376	d938eee3-7755-4da0-8494-0887ac618422	NO
396	d938eee3-7755-4da0-8494-0887ac618422	YES
386	d938eee3-7755-4da0-8494-0887ac618422	YES
349	d938eee3-7755-4da0-8494-0887ac618422	YES
383	d938eee3-7755-4da0-8494-0887ac618422	YES
390	d938eee3-7755-4da0-8494-0887ac618422	YES
410	d938eee3-7755-4da0-8494-0887ac618422	YES
378	d938eee3-7755-4da0-8494-0887ac618422	YES
366	d938eee3-7755-4da0-8494-0887ac618422	YES
363	d938eee3-7755-4da0-8494-0887ac618422	YES
379	d938eee3-7755-4da0-8494-0887ac618422	UNKNOWN
346	d938eee3-7755-4da0-8494-0887ac618422	YES
367	d938eee3-7755-4da0-8494-0887ac618422	YES
417	d938eee3-7755-4da0-8494-0887ac618422	YES
361	d938eee3-7755-4da0-8494-0887ac618422	YES
355	d938eee3-7755-4da0-8494-0887ac618422	YES
418	d938eee3-7755-4da0-8494-0887ac618422	YES
354	d938eee3-7755-4da0-8494-0887ac618422	YES
392	d938eee3-7755-4da0-8494-0887ac618422	YES
391	d938eee3-7755-4da0-8494-0887ac618422	NO
404	d938eee3-7755-4da0-8494-0887ac618422	YES
405	d938eee3-7755-4da0-8494-0887ac618422	UNKNOWN
424	d938eee3-7755-4da0-8494-0887ac618422	YES
394	d938eee3-7755-4da0-8494-0887ac618422	NO
425	d938eee3-7755-4da0-8494-0887ac618422	NO
415	d938eee3-7755-4da0-8494-0887ac618422	YES
426	d938eee3-7755-4da0-8494-0887ac618422	YES
427	d938eee3-7755-4da0-8494-0887ac618422	NO
428	d938eee3-7755-4da0-8494-0887ac618422	YES
431	d938eee3-7755-4da0-8494-0887ac618422	YES
441	d938eee3-7755-4da0-8494-0887ac618422	NO
331	d938eee3-7755-4da0-8494-0887ac618422	YES
353	d938eee3-7755-4da0-8494-0887ac618422	YES
161	93ee3ae9-69b2-4273-b9bf-afc700f5e381	UNKNOWN
287	d938eee3-7755-4da0-8494-0887ac618422	NO
289	d938eee3-7755-4da0-8494-0887ac618422	NO
210	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
185	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
144	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
198	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
89	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
154	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
100	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
248	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
251	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
250	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
261	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
264	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
270	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
271	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
272	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
278	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
280	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
283	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
285	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
287	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
289	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
293	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
294	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
296	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
297	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
298	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
299	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
302	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
304	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
305	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
306	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
307	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
309	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
312	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
314	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
323	93ee3ae9-69b2-4273-b9bf-afc700f5e381	UNKNOWN
327	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
330	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
331	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
334	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
333	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
332	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
337	93ee3ae9-69b2-4273-b9bf-afc700f5e381	UNKNOWN
339	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
341	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
340	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
343	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
373	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
395	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
369	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
389	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
393	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
347	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
374	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
348	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
414	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
353	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
419	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
370	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
422	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
371	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
358	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
376	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
396	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
386	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
349	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
383	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
410	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
366	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
96	93ee3ae9-69b2-4273-b9bf-afc700f5e381	UNKNOWN
159	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
405	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
51	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
116	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
188	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
166	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
41	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
411	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
49	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
170	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
63	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
44	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
6	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
53	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
83	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
65	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
98	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
79	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
11	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
88	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
149	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
106	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
167	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
14	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
21	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
168	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
110	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
211	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
182	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
153	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
346	dc549f88-6735-4539-bc44-afb7007d5be6	NO
424	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
394	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
178	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
327	0775eb08-d871-4e20-aefd-af2000d463d9	YES
347	0775eb08-d871-4e20-aefd-af2000d463d9	UNKNOWN
363	0775eb08-d871-4e20-aefd-af2000d463d9	YES
40	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
277	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
360	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
378	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
120	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
310	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
53	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
390	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
182	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
366	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
287	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
388	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
354	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
11	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
391	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
261	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
405	93ee3ae9-69b2-4273-b9bf-afc700f5e381	UNKNOWN
403	dc549f88-6735-4539-bc44-afb7007d5be6	NO
425	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
415	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
428	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
431	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
430	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
432	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
433	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
436	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
437	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
439	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
172	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
188	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
420	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
441	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
65	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
172	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
98	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
363	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
403	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
328	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
346	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
379	93ee3ae9-69b2-4273-b9bf-afc700f5e381	UNKNOWN
343	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
387	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
414	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
367	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
361	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
417	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
379	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
355	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
270	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
330	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
172	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
399	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
418	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
392	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
404	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
420	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
293	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
414	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
379	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
415	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
96	0775eb08-d871-4e20-aefd-af2000d463d9	NO
159	0775eb08-d871-4e20-aefd-af2000d463d9	NO
53	0775eb08-d871-4e20-aefd-af2000d463d9	UNKNOWN
185	0775eb08-d871-4e20-aefd-af2000d463d9	YES
285	0775eb08-d871-4e20-aefd-af2000d463d9	YES
415	190c19ef-be90-45bf-b9c6-afc700ee176a	YES
357	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
116	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
172	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
329	dc549f88-6735-4539-bc44-afb7007d5be6	NO
348	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
392	dc549f88-6735-4539-bc44-afb7007d5be6	YES
440	dc549f88-6735-4539-bc44-afb7007d5be6	YES
63	c665539d-6be7-4452-9b27-afb7007dbca0	YES
182	c665539d-6be7-4452-9b27-afb7007dbca0	NO
287	c665539d-6be7-4452-9b27-afb7007dbca0	NO
328	c665539d-6be7-4452-9b27-afb7007dbca0	NO
393	c665539d-6be7-4452-9b27-afb7007dbca0	NO
366	c665539d-6be7-4452-9b27-afb7007dbca0	YES
420	c665539d-6be7-4452-9b27-afb7007dbca0	YES
182	56589903-f505-4b43-8c46-afc000bc9c5a	NO
144	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
289	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
329	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
348	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
366	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
420	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
51	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
65	dc549f88-6735-4539-bc44-afb7007d5be6	YES
289	dc549f88-6735-4539-bc44-afb7007d5be6	YES
341	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
396	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
357	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
436	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
439	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
159	760ce247-b948-466b-b2e9-af6c00bc5863	NO
11	760ce247-b948-466b-b2e9-af6c00bc5863	YES
250	760ce247-b948-466b-b2e9-af6c00bc5863	YES
302	760ce247-b948-466b-b2e9-af6c00bc5863	YES
339	760ce247-b948-466b-b2e9-af6c00bc5863	NO
376	760ce247-b948-466b-b2e9-af6c00bc5863	YES
386	760ce247-b948-466b-b2e9-af6c00bc5863	UNKNOWN
415	760ce247-b948-466b-b2e9-af6c00bc5863	YES
116	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
11	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
250	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
302	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
305	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
330	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
414	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
379	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
415	9d822ee7-c84c-4178-8b36-4ef00bbb223b	YES
96	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
98	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
11	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
185	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	UNKNOWN
285	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
327	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
374	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
388	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
415	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	NO
439	3a021d62-24f3-4c5a-ab00-2d2c8b3956ce	YES
49	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	UNKNOWN
110	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
283	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
327	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
374	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
414	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
349	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
354	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	YES
439	bd3851d9-c2e8-4eeb-bbf9-b0130088b0ac	NO
44	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
211	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
280	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
285	249099df-f86a-4fe6-a532-3df9a15e0e39	NO
304	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
340	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
386	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
437	249099df-f86a-4fe6-a532-3df9a15e0e39	YES
41	0c0c4255-472d-422e-a455-6003c2820090	NO
49	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
11	0c0c4255-472d-422e-a455-6003c2820090	NO
250	0c0c4255-472d-422e-a455-6003c2820090	NO
302	0c0c4255-472d-422e-a455-6003c2820090	UNKNOWN
340	0c0c4255-472d-422e-a455-6003c2820090	NO
396	0c0c4255-472d-422e-a455-6003c2820090	YES
357	0c0c4255-472d-422e-a455-6003c2820090	YES
354	0c0c4255-472d-422e-a455-6003c2820090	YES
426	0c0c4255-472d-422e-a455-6003c2820090	YES
116	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
106	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
251	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
299	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
337	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
341	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
374	96151634-acf2-4f9e-bd54-afb7007c8a7b	YES
394	96151634-acf2-4f9e-bd54-afb7007c8a7b	NO
96	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
98	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
248	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
250	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
285	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
327	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
347	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
363	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
424	e2c7af9b-2788-406b-b382-afc500e2de5a	YES
120	ea3c08d8-29ef-4750-9746-aff900b12965	NO
116	ea3c08d8-29ef-4750-9746-aff900b12965	NO
49	ea3c08d8-29ef-4750-9746-aff900b12965	YES
110	ea3c08d8-29ef-4750-9746-aff900b12965	YES
283	ea3c08d8-29ef-4750-9746-aff900b12965	NO
323	ea3c08d8-29ef-4750-9746-aff900b12965	YES
393	ea3c08d8-29ef-4750-9746-aff900b12965	NO
366	ea3c08d8-29ef-4750-9746-aff900b12965	YES
357	ea3c08d8-29ef-4750-9746-aff900b12965	UNKNOWN
418	0775eb08-d871-4e20-aefd-af2000d463d9	YES
437	0775eb08-d871-4e20-aefd-af2000d463d9	YES
49	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
110	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
283	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
304	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
323	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
328	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
340	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
396	95b5667c-6138-42f0-b8a2-af2000d5b73f	NO
436	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
44	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
211	67495532-fa85-472b-b59b-af5e00f4ae4d	NO
185	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
261	67495532-fa85-472b-b59b-af5e00f4ae4d	YES
302	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
44	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
210	c7419180-6830-435c-91c2-aa63009730dd	NO
120	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
339	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
358	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
355	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
432	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
363	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
436	ea3c08d8-29ef-4750-9746-aff900b12965	NO
44	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
211	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
280	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
314	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
327	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
341	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
376	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
399	8273b1c3-94f7-422a-a1d8-aff900989e6a	NO
433	8273b1c3-94f7-422a-a1d8-aff900989e6a	YES
41	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
21	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
110	ff195055-5b7e-48ec-b23f-b02200c25d67	YES
250	ff195055-5b7e-48ec-b23f-b02200c25d67	NO
49	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
53	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
63	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
65	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
6	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
79	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
83	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
88	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	UNKNOWN
98	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
106	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
11	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
14	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
149	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
153	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	UNKNOWN
167	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
168	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
178	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	UNKNOWN
21	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
211	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
110	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
185	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
182	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
144	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
198	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
89	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
154	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
100	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
248	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
251	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
250	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
264	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
270	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
271	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
272	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
277	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
278	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
280	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
283	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
285	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
287	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
289	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
293	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
294	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
296	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
297	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
298	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
299	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
302	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	UNKNOWN
304	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
305	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
306	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
307	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
309	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
310	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
312	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
314	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
323	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
327	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
328	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
329	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
330	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
331	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
287	56589903-f505-4b43-8c46-afc000bc9c5a	NO
328	56589903-f505-4b43-8c46-afc000bc9c5a	NO
210	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
161	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	UNKNOWN
172	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
120	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
96	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
116	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
159	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
166	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	UNKNOWN
51	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
411	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
188	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
41	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
170	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	UNKNOWN
40	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
374	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
348	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
414	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
182	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
144	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
161	ad989cee-de35-4fde-b2d1-0b0d190d861d	UNKNOWN
334	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
96	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
333	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
159	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
332	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
337	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	UNKNOWN
49	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
339	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
63	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
341	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
6	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
340	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
83	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
343	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
98	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
373	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
11	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
395	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
149	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
360	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
369	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
389	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
347	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
168	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
353	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
21	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
419	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
110	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
370	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
41	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
422	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
371	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
358	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
376	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
396	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
386	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
349	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
383	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
390	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
410	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
378	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
363	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
388	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
403	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
379	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
346	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
387	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
367	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
417	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
361	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
355	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
399	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
357	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
418	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	UNKNOWN
354	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
392	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
391	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
404	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
405	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
424	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
394	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
425	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
426	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
427	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
428	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
431	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
430	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
432	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
433	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
436	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
437	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	NO
439	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
440	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
441	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
261	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
415	d6b0b2c7-1e6c-4bb4-a03d-afff0107451a	YES
120	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
116	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
51	ad989cee-de35-4fde-b2d1-0b0d190d861d	UNKNOWN
44	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
53	ad989cee-de35-4fde-b2d1-0b0d190d861d	UNKNOWN
65	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
79	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
88	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
106	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
14	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
153	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
178	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
211	ad989cee-de35-4fde-b2d1-0b0d190d861d	UNKNOWN
185	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
312	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
314	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
323	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
327	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
328	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
329	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
330	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
331	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
334	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
333	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
332	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
337	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
339	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
341	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
340	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
343	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
395	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
360	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
369	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
389	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
393	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
347	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
374	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
348	ad989cee-de35-4fde-b2d1-0b0d190d861d	UNKNOWN
414	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
353	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
419	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
370	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
422	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
371	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
358	ad989cee-de35-4fde-b2d1-0b0d190d861d	UNKNOWN
376	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
386	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
349	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
390	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
410	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
378	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
363	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
388	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
403	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
379	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
346	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
387	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
367	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
417	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
361	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
355	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
399	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
357	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
418	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
354	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
392	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
404	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
405	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
420	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
424	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
394	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
425	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
415	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
426	ad989cee-de35-4fde-b2d1-0b0d190d861d	UNKNOWN
427	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
428	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
431	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
430	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
432	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
433	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
436	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
437	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
439	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
440	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
396	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
89	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
154	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
100	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
248	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
251	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
250	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
261	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
264	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
270	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
272	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
277	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
278	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
280	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
283	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
285	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
287	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
289	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
293	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
294	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
296	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
297	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
298	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
299	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
302	ad989cee-de35-4fde-b2d1-0b0d190d861d	UNKNOWN
304	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
305	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
306	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
309	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
310	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
411	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
96	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
188	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
116	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
170	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
159	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
40	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
166	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
41	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
51	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
44	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
49	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
53	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
63	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
6	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
79	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
83	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
98	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
106	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
11	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
14	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
149	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
167	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
168	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
178	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
21	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
110	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
185	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
182	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
198	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
89	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
154	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
100	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
248	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
251	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
250	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
261	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
264	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
270	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
271	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
272	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
277	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
278	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
280	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
283	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
285	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
287	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
293	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
294	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
296	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
297	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
298	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
299	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
302	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
304	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
305	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
306	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
307	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
309	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
310	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
312	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
314	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
323	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
327	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
328	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
330	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
331	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
334	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
333	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
332	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
337	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
339	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
341	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
340	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
343	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
373	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
395	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
360	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
369	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
389	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
393	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
347	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
374	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
188	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
198	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
307	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
383	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
366	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
210	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
167	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
271	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
373	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
391	ad989cee-de35-4fde-b2d1-0b0d190d861d	NO
210	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
161	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
172	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
120	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
378	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
363	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
388	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
403	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
277	bc2d5201-991f-49cd-928c-add700b29b20	NO
278	bc2d5201-991f-49cd-928c-add700b29b20	YES
280	bc2d5201-991f-49cd-928c-add700b29b20	YES
376	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
287	bc2d5201-991f-49cd-928c-add700b29b20	NO
161	bc2d5201-991f-49cd-928c-add700b29b20	UNKNOWN
172	bc2d5201-991f-49cd-928c-add700b29b20	NO
120	bc2d5201-991f-49cd-928c-add700b29b20	NO
396	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
116	bc2d5201-991f-49cd-928c-add700b29b20	NO
414	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
166	bc2d5201-991f-49cd-928c-add700b29b20	YES
51	bc2d5201-991f-49cd-928c-add700b29b20	YES
411	bc2d5201-991f-49cd-928c-add700b29b20	YES
386	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
40	bc2d5201-991f-49cd-928c-add700b29b20	YES
353	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
44	bc2d5201-991f-49cd-928c-add700b29b20	NO
49	bc2d5201-991f-49cd-928c-add700b29b20	YES
53	bc2d5201-991f-49cd-928c-add700b29b20	YES
349	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
65	bc2d5201-991f-49cd-928c-add700b29b20	YES
419	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
79	bc2d5201-991f-49cd-928c-add700b29b20	YES
98	bc2d5201-991f-49cd-928c-add700b29b20	YES
106	bc2d5201-991f-49cd-928c-add700b29b20	YES
11	bc2d5201-991f-49cd-928c-add700b29b20	YES
14	bc2d5201-991f-49cd-928c-add700b29b20	YES
370	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
383	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
153	bc2d5201-991f-49cd-928c-add700b29b20	YES
168	bc2d5201-991f-49cd-928c-add700b29b20	YES
178	bc2d5201-991f-49cd-928c-add700b29b20	YES
21	bc2d5201-991f-49cd-928c-add700b29b20	YES
211	bc2d5201-991f-49cd-928c-add700b29b20	YES
390	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
422	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
182	bc2d5201-991f-49cd-928c-add700b29b20	NO
144	bc2d5201-991f-49cd-928c-add700b29b20	YES
198	bc2d5201-991f-49cd-928c-add700b29b20	YES
89	bc2d5201-991f-49cd-928c-add700b29b20	YES
410	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
154	bc2d5201-991f-49cd-928c-add700b29b20	YES
371	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
248	bc2d5201-991f-49cd-928c-add700b29b20	YES
251	bc2d5201-991f-49cd-928c-add700b29b20	YES
250	bc2d5201-991f-49cd-928c-add700b29b20	NO
379	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
264	bc2d5201-991f-49cd-928c-add700b29b20	YES
358	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
272	bc2d5201-991f-49cd-928c-add700b29b20	NO
283	bc2d5201-991f-49cd-928c-add700b29b20	NO
346	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
387	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
367	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
417	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
361	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
355	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
399	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
357	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
418	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
354	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
392	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
391	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
404	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
405	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
424	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
394	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
425	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
415	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
426	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
427	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
428	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
431	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
430	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
432	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
433	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
436	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
437	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
439	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
440	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
441	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	NO
159	bc2d5201-991f-49cd-928c-add700b29b20	YES
41	bc2d5201-991f-49cd-928c-add700b29b20	NO
6	bc2d5201-991f-49cd-928c-add700b29b20	NO
149	bc2d5201-991f-49cd-928c-add700b29b20	YES
185	bc2d5201-991f-49cd-928c-add700b29b20	YES
100	bc2d5201-991f-49cd-928c-add700b29b20	NO
270	bc2d5201-991f-49cd-928c-add700b29b20	NO
285	bc2d5201-991f-49cd-928c-add700b29b20	NO
96	bc2d5201-991f-49cd-928c-add700b29b20	YES
170	bc2d5201-991f-49cd-928c-add700b29b20	UNKNOWN
63	bc2d5201-991f-49cd-928c-add700b29b20	YES
261	bc2d5201-991f-49cd-928c-add700b29b20	NO
271	bc2d5201-991f-49cd-928c-add700b29b20	NO
289	bc2d5201-991f-49cd-928c-add700b29b20	NO
161	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
294	bc2d5201-991f-49cd-928c-add700b29b20	NO
296	bc2d5201-991f-49cd-928c-add700b29b20	YES
297	bc2d5201-991f-49cd-928c-add700b29b20	YES
298	bc2d5201-991f-49cd-928c-add700b29b20	NO
299	bc2d5201-991f-49cd-928c-add700b29b20	NO
172	dc549f88-6735-4539-bc44-afb7007d5be6	YES
304	bc2d5201-991f-49cd-928c-add700b29b20	YES
305	bc2d5201-991f-49cd-928c-add700b29b20	NO
306	bc2d5201-991f-49cd-928c-add700b29b20	NO
307	bc2d5201-991f-49cd-928c-add700b29b20	NO
309	bc2d5201-991f-49cd-928c-add700b29b20	NO
120	dc549f88-6735-4539-bc44-afb7007d5be6	YES
312	bc2d5201-991f-49cd-928c-add700b29b20	NO
314	bc2d5201-991f-49cd-928c-add700b29b20	YES
323	bc2d5201-991f-49cd-928c-add700b29b20	YES
327	bc2d5201-991f-49cd-928c-add700b29b20	YES
328	bc2d5201-991f-49cd-928c-add700b29b20	NO
96	dc549f88-6735-4539-bc44-afb7007d5be6	NO
330	bc2d5201-991f-49cd-928c-add700b29b20	UNKNOWN
331	bc2d5201-991f-49cd-928c-add700b29b20	YES
334	bc2d5201-991f-49cd-928c-add700b29b20	YES
333	bc2d5201-991f-49cd-928c-add700b29b20	YES
332	bc2d5201-991f-49cd-928c-add700b29b20	YES
116	dc549f88-6735-4539-bc44-afb7007d5be6	YES
341	bc2d5201-991f-49cd-928c-add700b29b20	NO
340	bc2d5201-991f-49cd-928c-add700b29b20	YES
343	bc2d5201-991f-49cd-928c-add700b29b20	NO
373	bc2d5201-991f-49cd-928c-add700b29b20	NO
395	bc2d5201-991f-49cd-928c-add700b29b20	YES
159	dc549f88-6735-4539-bc44-afb7007d5be6	NO
369	bc2d5201-991f-49cd-928c-add700b29b20	YES
389	bc2d5201-991f-49cd-928c-add700b29b20	YES
393	bc2d5201-991f-49cd-928c-add700b29b20	YES
347	bc2d5201-991f-49cd-928c-add700b29b20	YES
374	bc2d5201-991f-49cd-928c-add700b29b20	YES
414	bc2d5201-991f-49cd-928c-add700b29b20	YES
353	bc2d5201-991f-49cd-928c-add700b29b20	YES
419	bc2d5201-991f-49cd-928c-add700b29b20	YES
370	bc2d5201-991f-49cd-928c-add700b29b20	YES
422	bc2d5201-991f-49cd-928c-add700b29b20	YES
293	bc2d5201-991f-49cd-928c-add700b29b20	YES
358	bc2d5201-991f-49cd-928c-add700b29b20	UNKNOWN
376	bc2d5201-991f-49cd-928c-add700b29b20	NO
396	bc2d5201-991f-49cd-928c-add700b29b20	YES
386	bc2d5201-991f-49cd-928c-add700b29b20	YES
349	bc2d5201-991f-49cd-928c-add700b29b20	YES
302	bc2d5201-991f-49cd-928c-add700b29b20	UNKNOWN
390	bc2d5201-991f-49cd-928c-add700b29b20	YES
410	bc2d5201-991f-49cd-928c-add700b29b20	YES
378	bc2d5201-991f-49cd-928c-add700b29b20	YES
366	bc2d5201-991f-49cd-928c-add700b29b20	YES
363	bc2d5201-991f-49cd-928c-add700b29b20	YES
310	bc2d5201-991f-49cd-928c-add700b29b20	YES
379	bc2d5201-991f-49cd-928c-add700b29b20	NO
346	bc2d5201-991f-49cd-928c-add700b29b20	YES
387	bc2d5201-991f-49cd-928c-add700b29b20	NO
367	bc2d5201-991f-49cd-928c-add700b29b20	YES
417	bc2d5201-991f-49cd-928c-add700b29b20	YES
329	bc2d5201-991f-49cd-928c-add700b29b20	YES
355	bc2d5201-991f-49cd-928c-add700b29b20	YES
399	bc2d5201-991f-49cd-928c-add700b29b20	YES
357	bc2d5201-991f-49cd-928c-add700b29b20	YES
418	bc2d5201-991f-49cd-928c-add700b29b20	YES
354	bc2d5201-991f-49cd-928c-add700b29b20	YES
337	bc2d5201-991f-49cd-928c-add700b29b20	YES
391	bc2d5201-991f-49cd-928c-add700b29b20	NO
404	bc2d5201-991f-49cd-928c-add700b29b20	YES
405	bc2d5201-991f-49cd-928c-add700b29b20	NO
420	bc2d5201-991f-49cd-928c-add700b29b20	YES
424	bc2d5201-991f-49cd-928c-add700b29b20	YES
360	bc2d5201-991f-49cd-928c-add700b29b20	NO
425	bc2d5201-991f-49cd-928c-add700b29b20	NO
415	bc2d5201-991f-49cd-928c-add700b29b20	YES
426	bc2d5201-991f-49cd-928c-add700b29b20	YES
427	bc2d5201-991f-49cd-928c-add700b29b20	NO
428	bc2d5201-991f-49cd-928c-add700b29b20	YES
348	bc2d5201-991f-49cd-928c-add700b29b20	YES
430	bc2d5201-991f-49cd-928c-add700b29b20	YES
432	bc2d5201-991f-49cd-928c-add700b29b20	NO
433	bc2d5201-991f-49cd-928c-add700b29b20	YES
436	bc2d5201-991f-49cd-928c-add700b29b20	YES
437	bc2d5201-991f-49cd-928c-add700b29b20	YES
439	bc2d5201-991f-49cd-928c-add700b29b20	YES
440	bc2d5201-991f-49cd-928c-add700b29b20	NO
441	bc2d5201-991f-49cd-928c-add700b29b20	NO
339	bc2d5201-991f-49cd-928c-add700b29b20	YES
388	bc2d5201-991f-49cd-928c-add700b29b20	YES
210	dc549f88-6735-4539-bc44-afb7007d5be6	YES
210	bc2d5201-991f-49cd-928c-add700b29b20	YES
188	bc2d5201-991f-49cd-928c-add700b29b20	YES
167	bc2d5201-991f-49cd-928c-add700b29b20	NO
371	bc2d5201-991f-49cd-928c-add700b29b20	YES
383	bc2d5201-991f-49cd-928c-add700b29b20	YES
403	bc2d5201-991f-49cd-928c-add700b29b20	YES
361	bc2d5201-991f-49cd-928c-add700b29b20	YES
392	bc2d5201-991f-49cd-928c-add700b29b20	YES
394	bc2d5201-991f-49cd-928c-add700b29b20	NO
431	bc2d5201-991f-49cd-928c-add700b29b20	YES
106	dc549f88-6735-4539-bc44-afb7007d5be6	YES
11	dc549f88-6735-4539-bc44-afb7007d5be6	YES
14	dc549f88-6735-4539-bc44-afb7007d5be6	YES
149	dc549f88-6735-4539-bc44-afb7007d5be6	YES
153	dc549f88-6735-4539-bc44-afb7007d5be6	YES
167	dc549f88-6735-4539-bc44-afb7007d5be6	YES
168	dc549f88-6735-4539-bc44-afb7007d5be6	NO
178	dc549f88-6735-4539-bc44-afb7007d5be6	YES
21	dc549f88-6735-4539-bc44-afb7007d5be6	YES
211	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
110	dc549f88-6735-4539-bc44-afb7007d5be6	NO
185	dc549f88-6735-4539-bc44-afb7007d5be6	YES
182	dc549f88-6735-4539-bc44-afb7007d5be6	YES
198	dc549f88-6735-4539-bc44-afb7007d5be6	NO
89	dc549f88-6735-4539-bc44-afb7007d5be6	NO
154	dc549f88-6735-4539-bc44-afb7007d5be6	NO
100	dc549f88-6735-4539-bc44-afb7007d5be6	YES
248	dc549f88-6735-4539-bc44-afb7007d5be6	YES
251	dc549f88-6735-4539-bc44-afb7007d5be6	YES
250	dc549f88-6735-4539-bc44-afb7007d5be6	YES
261	dc549f88-6735-4539-bc44-afb7007d5be6	YES
264	dc549f88-6735-4539-bc44-afb7007d5be6	NO
270	dc549f88-6735-4539-bc44-afb7007d5be6	YES
271	dc549f88-6735-4539-bc44-afb7007d5be6	YES
272	dc549f88-6735-4539-bc44-afb7007d5be6	YES
277	dc549f88-6735-4539-bc44-afb7007d5be6	YES
278	dc549f88-6735-4539-bc44-afb7007d5be6	YES
280	dc549f88-6735-4539-bc44-afb7007d5be6	NO
283	dc549f88-6735-4539-bc44-afb7007d5be6	YES
285	dc549f88-6735-4539-bc44-afb7007d5be6	YES
287	dc549f88-6735-4539-bc44-afb7007d5be6	YES
293	dc549f88-6735-4539-bc44-afb7007d5be6	NO
294	dc549f88-6735-4539-bc44-afb7007d5be6	YES
296	dc549f88-6735-4539-bc44-afb7007d5be6	NO
297	dc549f88-6735-4539-bc44-afb7007d5be6	YES
298	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
299	dc549f88-6735-4539-bc44-afb7007d5be6	YES
302	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
304	dc549f88-6735-4539-bc44-afb7007d5be6	NO
305	dc549f88-6735-4539-bc44-afb7007d5be6	YES
306	dc549f88-6735-4539-bc44-afb7007d5be6	YES
307	dc549f88-6735-4539-bc44-afb7007d5be6	YES
309	dc549f88-6735-4539-bc44-afb7007d5be6	YES
310	dc549f88-6735-4539-bc44-afb7007d5be6	YES
312	dc549f88-6735-4539-bc44-afb7007d5be6	YES
314	dc549f88-6735-4539-bc44-afb7007d5be6	YES
323	dc549f88-6735-4539-bc44-afb7007d5be6	NO
327	dc549f88-6735-4539-bc44-afb7007d5be6	YES
328	dc549f88-6735-4539-bc44-afb7007d5be6	YES
330	dc549f88-6735-4539-bc44-afb7007d5be6	NO
331	dc549f88-6735-4539-bc44-afb7007d5be6	YES
334	dc549f88-6735-4539-bc44-afb7007d5be6	NO
333	dc549f88-6735-4539-bc44-afb7007d5be6	YES
332	dc549f88-6735-4539-bc44-afb7007d5be6	NO
337	dc549f88-6735-4539-bc44-afb7007d5be6	YES
339	dc549f88-6735-4539-bc44-afb7007d5be6	NO
341	dc549f88-6735-4539-bc44-afb7007d5be6	YES
340	dc549f88-6735-4539-bc44-afb7007d5be6	YES
343	dc549f88-6735-4539-bc44-afb7007d5be6	YES
373	dc549f88-6735-4539-bc44-afb7007d5be6	YES
395	dc549f88-6735-4539-bc44-afb7007d5be6	NO
360	dc549f88-6735-4539-bc44-afb7007d5be6	YES
369	dc549f88-6735-4539-bc44-afb7007d5be6	YES
389	dc549f88-6735-4539-bc44-afb7007d5be6	NO
393	dc549f88-6735-4539-bc44-afb7007d5be6	YES
347	dc549f88-6735-4539-bc44-afb7007d5be6	NO
374	dc549f88-6735-4539-bc44-afb7007d5be6	YES
414	dc549f88-6735-4539-bc44-afb7007d5be6	YES
353	dc549f88-6735-4539-bc44-afb7007d5be6	YES
419	dc549f88-6735-4539-bc44-afb7007d5be6	YES
370	dc549f88-6735-4539-bc44-afb7007d5be6	NO
422	dc549f88-6735-4539-bc44-afb7007d5be6	NO
371	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
358	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
376	dc549f88-6735-4539-bc44-afb7007d5be6	YES
396	dc549f88-6735-4539-bc44-afb7007d5be6	NO
386	dc549f88-6735-4539-bc44-afb7007d5be6	NO
349	dc549f88-6735-4539-bc44-afb7007d5be6	NO
383	dc549f88-6735-4539-bc44-afb7007d5be6	NO
390	dc549f88-6735-4539-bc44-afb7007d5be6	YES
410	dc549f88-6735-4539-bc44-afb7007d5be6	NO
378	dc549f88-6735-4539-bc44-afb7007d5be6	NO
366	dc549f88-6735-4539-bc44-afb7007d5be6	NO
363	dc549f88-6735-4539-bc44-afb7007d5be6	YES
388	dc549f88-6735-4539-bc44-afb7007d5be6	YES
379	dc549f88-6735-4539-bc44-afb7007d5be6	YES
411	dc549f88-6735-4539-bc44-afb7007d5be6	NO
188	dc549f88-6735-4539-bc44-afb7007d5be6	YES
170	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
40	dc549f88-6735-4539-bc44-afb7007d5be6	NO
41	dc549f88-6735-4539-bc44-afb7007d5be6	YES
44	dc549f88-6735-4539-bc44-afb7007d5be6	YES
49	dc549f88-6735-4539-bc44-afb7007d5be6	NO
53	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
63	dc549f88-6735-4539-bc44-afb7007d5be6	YES
6	dc549f88-6735-4539-bc44-afb7007d5be6	YES
79	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
83	dc549f88-6735-4539-bc44-afb7007d5be6	YES
88	dc549f88-6735-4539-bc44-afb7007d5be6	NO
98	dc549f88-6735-4539-bc44-afb7007d5be6	NO
394	dc549f88-6735-4539-bc44-afb7007d5be6	YES
425	dc549f88-6735-4539-bc44-afb7007d5be6	YES
415	dc549f88-6735-4539-bc44-afb7007d5be6	YES
426	dc549f88-6735-4539-bc44-afb7007d5be6	NO
427	dc549f88-6735-4539-bc44-afb7007d5be6	YES
428	dc549f88-6735-4539-bc44-afb7007d5be6	NO
431	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
430	dc549f88-6735-4539-bc44-afb7007d5be6	YES
432	dc549f88-6735-4539-bc44-afb7007d5be6	YES
433	dc549f88-6735-4539-bc44-afb7007d5be6	NO
436	dc549f88-6735-4539-bc44-afb7007d5be6	YES
437	dc549f88-6735-4539-bc44-afb7007d5be6	YES
439	dc549f88-6735-4539-bc44-afb7007d5be6	YES
441	dc549f88-6735-4539-bc44-afb7007d5be6	YES
166	dc549f88-6735-4539-bc44-afb7007d5be6	YES
210	c665539d-6be7-4452-9b27-afb7007dbca0	NO
161	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
172	c665539d-6be7-4452-9b27-afb7007dbca0	NO
120	c665539d-6be7-4452-9b27-afb7007dbca0	NO
96	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
116	c665539d-6be7-4452-9b27-afb7007dbca0	NO
159	c665539d-6be7-4452-9b27-afb7007dbca0	YES
51	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
411	c665539d-6be7-4452-9b27-afb7007dbca0	YES
188	c665539d-6be7-4452-9b27-afb7007dbca0	YES
170	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
40	c665539d-6be7-4452-9b27-afb7007dbca0	YES
41	c665539d-6be7-4452-9b27-afb7007dbca0	NO
44	c665539d-6be7-4452-9b27-afb7007dbca0	NO
49	c665539d-6be7-4452-9b27-afb7007dbca0	YES
53	c665539d-6be7-4452-9b27-afb7007dbca0	YES
65	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
6	c665539d-6be7-4452-9b27-afb7007dbca0	NO
79	c665539d-6be7-4452-9b27-afb7007dbca0	NO
83	c665539d-6be7-4452-9b27-afb7007dbca0	YES
88	c665539d-6be7-4452-9b27-afb7007dbca0	YES
98	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
106	c665539d-6be7-4452-9b27-afb7007dbca0	YES
11	c665539d-6be7-4452-9b27-afb7007dbca0	YES
14	c665539d-6be7-4452-9b27-afb7007dbca0	YES
149	c665539d-6be7-4452-9b27-afb7007dbca0	NO
153	c665539d-6be7-4452-9b27-afb7007dbca0	YES
167	c665539d-6be7-4452-9b27-afb7007dbca0	NO
168	c665539d-6be7-4452-9b27-afb7007dbca0	YES
178	c665539d-6be7-4452-9b27-afb7007dbca0	YES
21	c665539d-6be7-4452-9b27-afb7007dbca0	NO
211	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
110	c665539d-6be7-4452-9b27-afb7007dbca0	YES
185	c665539d-6be7-4452-9b27-afb7007dbca0	NO
144	c665539d-6be7-4452-9b27-afb7007dbca0	YES
198	c665539d-6be7-4452-9b27-afb7007dbca0	YES
89	c665539d-6be7-4452-9b27-afb7007dbca0	YES
154	c665539d-6be7-4452-9b27-afb7007dbca0	YES
100	c665539d-6be7-4452-9b27-afb7007dbca0	NO
248	c665539d-6be7-4452-9b27-afb7007dbca0	NO
251	c665539d-6be7-4452-9b27-afb7007dbca0	NO
250	c665539d-6be7-4452-9b27-afb7007dbca0	NO
261	c665539d-6be7-4452-9b27-afb7007dbca0	NO
264	c665539d-6be7-4452-9b27-afb7007dbca0	YES
270	c665539d-6be7-4452-9b27-afb7007dbca0	NO
271	c665539d-6be7-4452-9b27-afb7007dbca0	NO
272	c665539d-6be7-4452-9b27-afb7007dbca0	NO
277	c665539d-6be7-4452-9b27-afb7007dbca0	NO
278	c665539d-6be7-4452-9b27-afb7007dbca0	NO
280	c665539d-6be7-4452-9b27-afb7007dbca0	YES
283	c665539d-6be7-4452-9b27-afb7007dbca0	NO
285	c665539d-6be7-4452-9b27-afb7007dbca0	NO
289	c665539d-6be7-4452-9b27-afb7007dbca0	NO
293	c665539d-6be7-4452-9b27-afb7007dbca0	YES
294	c665539d-6be7-4452-9b27-afb7007dbca0	NO
296	c665539d-6be7-4452-9b27-afb7007dbca0	YES
297	c665539d-6be7-4452-9b27-afb7007dbca0	NO
298	c665539d-6be7-4452-9b27-afb7007dbca0	NO
299	c665539d-6be7-4452-9b27-afb7007dbca0	NO
302	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
304	c665539d-6be7-4452-9b27-afb7007dbca0	YES
305	c665539d-6be7-4452-9b27-afb7007dbca0	NO
306	c665539d-6be7-4452-9b27-afb7007dbca0	NO
307	c665539d-6be7-4452-9b27-afb7007dbca0	NO
309	c665539d-6be7-4452-9b27-afb7007dbca0	NO
310	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
312	c665539d-6be7-4452-9b27-afb7007dbca0	NO
314	c665539d-6be7-4452-9b27-afb7007dbca0	NO
323	c665539d-6be7-4452-9b27-afb7007dbca0	YES
327	c665539d-6be7-4452-9b27-afb7007dbca0	YES
329	c665539d-6be7-4452-9b27-afb7007dbca0	YES
387	dc549f88-6735-4539-bc44-afb7007d5be6	YES
367	dc549f88-6735-4539-bc44-afb7007d5be6	NO
417	dc549f88-6735-4539-bc44-afb7007d5be6	YES
361	dc549f88-6735-4539-bc44-afb7007d5be6	YES
355	dc549f88-6735-4539-bc44-afb7007d5be6	NO
399	dc549f88-6735-4539-bc44-afb7007d5be6	YES
357	dc549f88-6735-4539-bc44-afb7007d5be6	YES
418	dc549f88-6735-4539-bc44-afb7007d5be6	YES
354	dc549f88-6735-4539-bc44-afb7007d5be6	NO
391	dc549f88-6735-4539-bc44-afb7007d5be6	UNKNOWN
404	dc549f88-6735-4539-bc44-afb7007d5be6	YES
405	dc549f88-6735-4539-bc44-afb7007d5be6	YES
420	dc549f88-6735-4539-bc44-afb7007d5be6	NO
424	dc549f88-6735-4539-bc44-afb7007d5be6	NO
389	c665539d-6be7-4452-9b27-afb7007dbca0	YES
347	c665539d-6be7-4452-9b27-afb7007dbca0	YES
374	c665539d-6be7-4452-9b27-afb7007dbca0	NO
185	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
182	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
161	4c300ecb-2939-46b0-abd9-afbf010d74b8	UNKNOWN
330	c665539d-6be7-4452-9b27-afb7007dbca0	YES
96	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
331	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
159	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
334	c665539d-6be7-4452-9b27-afb7007dbca0	YES
411	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
333	c665539d-6be7-4452-9b27-afb7007dbca0	YES
40	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
332	c665539d-6be7-4452-9b27-afb7007dbca0	YES
44	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
337	c665539d-6be7-4452-9b27-afb7007dbca0	YES
53	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
339	c665539d-6be7-4452-9b27-afb7007dbca0	YES
65	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
341	c665539d-6be7-4452-9b27-afb7007dbca0	NO
79	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
340	c665539d-6be7-4452-9b27-afb7007dbca0	YES
88	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
343	c665539d-6be7-4452-9b27-afb7007dbca0	NO
106	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
373	c665539d-6be7-4452-9b27-afb7007dbca0	NO
14	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
395	c665539d-6be7-4452-9b27-afb7007dbca0	YES
153	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
360	c665539d-6be7-4452-9b27-afb7007dbca0	NO
178	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
369	c665539d-6be7-4452-9b27-afb7007dbca0	YES
211	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
110	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
348	c665539d-6be7-4452-9b27-afb7007dbca0	YES
414	c665539d-6be7-4452-9b27-afb7007dbca0	YES
353	c665539d-6be7-4452-9b27-afb7007dbca0	NO
419	c665539d-6be7-4452-9b27-afb7007dbca0	YES
370	c665539d-6be7-4452-9b27-afb7007dbca0	YES
422	c665539d-6be7-4452-9b27-afb7007dbca0	YES
371	c665539d-6be7-4452-9b27-afb7007dbca0	YES
358	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
376	c665539d-6be7-4452-9b27-afb7007dbca0	NO
396	c665539d-6be7-4452-9b27-afb7007dbca0	YES
386	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
349	c665539d-6be7-4452-9b27-afb7007dbca0	YES
383	c665539d-6be7-4452-9b27-afb7007dbca0	YES
390	c665539d-6be7-4452-9b27-afb7007dbca0	NO
410	c665539d-6be7-4452-9b27-afb7007dbca0	YES
378	c665539d-6be7-4452-9b27-afb7007dbca0	YES
363	c665539d-6be7-4452-9b27-afb7007dbca0	YES
388	c665539d-6be7-4452-9b27-afb7007dbca0	NO
403	c665539d-6be7-4452-9b27-afb7007dbca0	YES
379	c665539d-6be7-4452-9b27-afb7007dbca0	NO
346	c665539d-6be7-4452-9b27-afb7007dbca0	YES
387	c665539d-6be7-4452-9b27-afb7007dbca0	NO
367	c665539d-6be7-4452-9b27-afb7007dbca0	YES
417	c665539d-6be7-4452-9b27-afb7007dbca0	YES
361	c665539d-6be7-4452-9b27-afb7007dbca0	NO
355	c665539d-6be7-4452-9b27-afb7007dbca0	YES
399	c665539d-6be7-4452-9b27-afb7007dbca0	YES
357	c665539d-6be7-4452-9b27-afb7007dbca0	YES
418	c665539d-6be7-4452-9b27-afb7007dbca0	YES
354	c665539d-6be7-4452-9b27-afb7007dbca0	YES
392	c665539d-6be7-4452-9b27-afb7007dbca0	NO
391	c665539d-6be7-4452-9b27-afb7007dbca0	NO
404	c665539d-6be7-4452-9b27-afb7007dbca0	YES
405	c665539d-6be7-4452-9b27-afb7007dbca0	NO
424	c665539d-6be7-4452-9b27-afb7007dbca0	YES
394	c665539d-6be7-4452-9b27-afb7007dbca0	NO
425	c665539d-6be7-4452-9b27-afb7007dbca0	NO
415	c665539d-6be7-4452-9b27-afb7007dbca0	NO
426	c665539d-6be7-4452-9b27-afb7007dbca0	YES
427	c665539d-6be7-4452-9b27-afb7007dbca0	NO
428	c665539d-6be7-4452-9b27-afb7007dbca0	YES
431	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
430	c665539d-6be7-4452-9b27-afb7007dbca0	NO
432	c665539d-6be7-4452-9b27-afb7007dbca0	NO
433	c665539d-6be7-4452-9b27-afb7007dbca0	YES
436	c665539d-6be7-4452-9b27-afb7007dbca0	NO
437	c665539d-6be7-4452-9b27-afb7007dbca0	YES
439	c665539d-6be7-4452-9b27-afb7007dbca0	UNKNOWN
440	c665539d-6be7-4452-9b27-afb7007dbca0	NO
441	c665539d-6be7-4452-9b27-afb7007dbca0	NO
166	c665539d-6be7-4452-9b27-afb7007dbca0	YES
120	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
116	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
51	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
188	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
41	4c300ecb-2939-46b0-abd9-afbf010d74b8	UNKNOWN
49	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
63	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
6	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
83	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
98	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
11	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
149	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
167	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
21	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
310	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
312	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
314	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
323	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
327	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
328	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
329	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
330	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
331	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
334	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
333	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
332	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
337	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
339	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
341	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
340	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
373	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
395	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
360	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
369	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
389	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
393	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
347	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
374	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
348	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
414	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
353	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
419	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
370	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
422	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
371	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
358	4c300ecb-2939-46b0-abd9-afbf010d74b8	UNKNOWN
376	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
396	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
349	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
383	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
390	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
410	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
378	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
366	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
363	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
388	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
403	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
379	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
346	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
387	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
367	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
417	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
361	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
355	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
399	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
357	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
354	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
392	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
391	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
404	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
405	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
420	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
424	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
394	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
425	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
415	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
426	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
427	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
428	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
431	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
430	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
432	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
433	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
436	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
439	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
198	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
89	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
154	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
100	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
248	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
251	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
250	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
261	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
264	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
271	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
272	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
277	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
278	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
280	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
283	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
285	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
287	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
289	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
293	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
294	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
296	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
297	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
298	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
299	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
302	4c300ecb-2939-46b0-abd9-afbf010d74b8	UNKNOWN
304	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
305	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
307	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
309	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
51	56589903-f505-4b43-8c46-afc000bc9c5a	YES
49	56589903-f505-4b43-8c46-afc000bc9c5a	YES
411	56589903-f505-4b43-8c46-afc000bc9c5a	YES
172	56589903-f505-4b43-8c46-afc000bc9c5a	NO
188	56589903-f505-4b43-8c46-afc000bc9c5a	YES
120	56589903-f505-4b43-8c46-afc000bc9c5a	NO
170	56589903-f505-4b43-8c46-afc000bc9c5a	UNKNOWN
96	56589903-f505-4b43-8c46-afc000bc9c5a	YES
40	56589903-f505-4b43-8c46-afc000bc9c5a	YES
116	56589903-f505-4b43-8c46-afc000bc9c5a	NO
41	56589903-f505-4b43-8c46-afc000bc9c5a	NO
159	56589903-f505-4b43-8c46-afc000bc9c5a	YES
44	56589903-f505-4b43-8c46-afc000bc9c5a	NO
161	56589903-f505-4b43-8c46-afc000bc9c5a	UNKNOWN
53	56589903-f505-4b43-8c46-afc000bc9c5a	YES
63	56589903-f505-4b43-8c46-afc000bc9c5a	YES
65	56589903-f505-4b43-8c46-afc000bc9c5a	UNKNOWN
6	56589903-f505-4b43-8c46-afc000bc9c5a	NO
79	56589903-f505-4b43-8c46-afc000bc9c5a	NO
83	56589903-f505-4b43-8c46-afc000bc9c5a	YES
88	56589903-f505-4b43-8c46-afc000bc9c5a	YES
98	56589903-f505-4b43-8c46-afc000bc9c5a	YES
106	56589903-f505-4b43-8c46-afc000bc9c5a	YES
11	56589903-f505-4b43-8c46-afc000bc9c5a	YES
14	56589903-f505-4b43-8c46-afc000bc9c5a	YES
149	56589903-f505-4b43-8c46-afc000bc9c5a	UNKNOWN
153	56589903-f505-4b43-8c46-afc000bc9c5a	YES
167	56589903-f505-4b43-8c46-afc000bc9c5a	NO
168	56589903-f505-4b43-8c46-afc000bc9c5a	YES
178	56589903-f505-4b43-8c46-afc000bc9c5a	UNKNOWN
21	56589903-f505-4b43-8c46-afc000bc9c5a	NO
211	56589903-f505-4b43-8c46-afc000bc9c5a	YES
110	56589903-f505-4b43-8c46-afc000bc9c5a	YES
185	56589903-f505-4b43-8c46-afc000bc9c5a	NO
144	56589903-f505-4b43-8c46-afc000bc9c5a	YES
198	56589903-f505-4b43-8c46-afc000bc9c5a	YES
89	56589903-f505-4b43-8c46-afc000bc9c5a	YES
154	56589903-f505-4b43-8c46-afc000bc9c5a	YES
100	56589903-f505-4b43-8c46-afc000bc9c5a	NO
248	56589903-f505-4b43-8c46-afc000bc9c5a	NO
251	56589903-f505-4b43-8c46-afc000bc9c5a	NO
250	56589903-f505-4b43-8c46-afc000bc9c5a	NO
261	56589903-f505-4b43-8c46-afc000bc9c5a	NO
264	56589903-f505-4b43-8c46-afc000bc9c5a	YES
270	56589903-f505-4b43-8c46-afc000bc9c5a	NO
271	56589903-f505-4b43-8c46-afc000bc9c5a	NO
272	56589903-f505-4b43-8c46-afc000bc9c5a	NO
277	56589903-f505-4b43-8c46-afc000bc9c5a	NO
278	56589903-f505-4b43-8c46-afc000bc9c5a	NO
280	56589903-f505-4b43-8c46-afc000bc9c5a	YES
283	56589903-f505-4b43-8c46-afc000bc9c5a	NO
285	56589903-f505-4b43-8c46-afc000bc9c5a	NO
289	56589903-f505-4b43-8c46-afc000bc9c5a	NO
293	56589903-f505-4b43-8c46-afc000bc9c5a	YES
294	56589903-f505-4b43-8c46-afc000bc9c5a	NO
296	56589903-f505-4b43-8c46-afc000bc9c5a	YES
297	56589903-f505-4b43-8c46-afc000bc9c5a	NO
298	56589903-f505-4b43-8c46-afc000bc9c5a	NO
299	56589903-f505-4b43-8c46-afc000bc9c5a	NO
302	56589903-f505-4b43-8c46-afc000bc9c5a	UNKNOWN
304	56589903-f505-4b43-8c46-afc000bc9c5a	YES
305	56589903-f505-4b43-8c46-afc000bc9c5a	NO
306	56589903-f505-4b43-8c46-afc000bc9c5a	NO
307	56589903-f505-4b43-8c46-afc000bc9c5a	NO
309	56589903-f505-4b43-8c46-afc000bc9c5a	NO
310	56589903-f505-4b43-8c46-afc000bc9c5a	UNKNOWN
312	56589903-f505-4b43-8c46-afc000bc9c5a	NO
314	56589903-f505-4b43-8c46-afc000bc9c5a	NO
323	56589903-f505-4b43-8c46-afc000bc9c5a	YES
327	56589903-f505-4b43-8c46-afc000bc9c5a	YES
329	56589903-f505-4b43-8c46-afc000bc9c5a	YES
330	56589903-f505-4b43-8c46-afc000bc9c5a	YES
331	56589903-f505-4b43-8c46-afc000bc9c5a	YES
334	56589903-f505-4b43-8c46-afc000bc9c5a	YES
333	56589903-f505-4b43-8c46-afc000bc9c5a	YES
332	56589903-f505-4b43-8c46-afc000bc9c5a	YES
337	56589903-f505-4b43-8c46-afc000bc9c5a	YES
339	56589903-f505-4b43-8c46-afc000bc9c5a	YES
341	56589903-f505-4b43-8c46-afc000bc9c5a	NO
340	56589903-f505-4b43-8c46-afc000bc9c5a	YES
343	56589903-f505-4b43-8c46-afc000bc9c5a	NO
373	56589903-f505-4b43-8c46-afc000bc9c5a	NO
395	56589903-f505-4b43-8c46-afc000bc9c5a	YES
360	56589903-f505-4b43-8c46-afc000bc9c5a	NO
369	56589903-f505-4b43-8c46-afc000bc9c5a	YES
389	56589903-f505-4b43-8c46-afc000bc9c5a	YES
393	56589903-f505-4b43-8c46-afc000bc9c5a	NO
168	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
270	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
343	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
418	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
440	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
166	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
210	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
144	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
306	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
386	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
437	4c300ecb-2939-46b0-abd9-afbf010d74b8	YES
441	4c300ecb-2939-46b0-abd9-afbf010d74b8	NO
210	56589903-f505-4b43-8c46-afc000bc9c5a	NO
410	56589903-f505-4b43-8c46-afc000bc9c5a	YES
378	56589903-f505-4b43-8c46-afc000bc9c5a	YES
366	56589903-f505-4b43-8c46-afc000bc9c5a	YES
363	56589903-f505-4b43-8c46-afc000bc9c5a	YES
388	56589903-f505-4b43-8c46-afc000bc9c5a	NO
403	56589903-f505-4b43-8c46-afc000bc9c5a	YES
379	56589903-f505-4b43-8c46-afc000bc9c5a	NO
346	56589903-f505-4b43-8c46-afc000bc9c5a	YES
387	56589903-f505-4b43-8c46-afc000bc9c5a	NO
367	56589903-f505-4b43-8c46-afc000bc9c5a	YES
417	56589903-f505-4b43-8c46-afc000bc9c5a	YES
361	56589903-f505-4b43-8c46-afc000bc9c5a	NO
355	56589903-f505-4b43-8c46-afc000bc9c5a	YES
357	56589903-f505-4b43-8c46-afc000bc9c5a	YES
418	56589903-f505-4b43-8c46-afc000bc9c5a	YES
354	56589903-f505-4b43-8c46-afc000bc9c5a	YES
392	56589903-f505-4b43-8c46-afc000bc9c5a	NO
391	56589903-f505-4b43-8c46-afc000bc9c5a	NO
404	56589903-f505-4b43-8c46-afc000bc9c5a	YES
405	56589903-f505-4b43-8c46-afc000bc9c5a	UNKNOWN
420	56589903-f505-4b43-8c46-afc000bc9c5a	YES
424	56589903-f505-4b43-8c46-afc000bc9c5a	YES
394	56589903-f505-4b43-8c46-afc000bc9c5a	NO
425	56589903-f505-4b43-8c46-afc000bc9c5a	NO
415	56589903-f505-4b43-8c46-afc000bc9c5a	NO
426	56589903-f505-4b43-8c46-afc000bc9c5a	YES
427	56589903-f505-4b43-8c46-afc000bc9c5a	NO
428	56589903-f505-4b43-8c46-afc000bc9c5a	YES
431	56589903-f505-4b43-8c46-afc000bc9c5a	YES
430	56589903-f505-4b43-8c46-afc000bc9c5a	NO
432	56589903-f505-4b43-8c46-afc000bc9c5a	NO
436	56589903-f505-4b43-8c46-afc000bc9c5a	NO
437	56589903-f505-4b43-8c46-afc000bc9c5a	YES
439	56589903-f505-4b43-8c46-afc000bc9c5a	YES
440	56589903-f505-4b43-8c46-afc000bc9c5a	NO
441	56589903-f505-4b43-8c46-afc000bc9c5a	NO
166	56589903-f505-4b43-8c46-afc000bc9c5a	YES
210	e623fb98-5a74-4a95-b84e-afc600e97860	NO
161	e623fb98-5a74-4a95-b84e-afc600e97860	UNKNOWN
172	e623fb98-5a74-4a95-b84e-afc600e97860	NO
120	e623fb98-5a74-4a95-b84e-afc600e97860	NO
96	e623fb98-5a74-4a95-b84e-afc600e97860	YES
116	e623fb98-5a74-4a95-b84e-afc600e97860	NO
159	e623fb98-5a74-4a95-b84e-afc600e97860	YES
51	e623fb98-5a74-4a95-b84e-afc600e97860	UNKNOWN
411	e623fb98-5a74-4a95-b84e-afc600e97860	YES
188	e623fb98-5a74-4a95-b84e-afc600e97860	UNKNOWN
170	e623fb98-5a74-4a95-b84e-afc600e97860	UNKNOWN
40	e623fb98-5a74-4a95-b84e-afc600e97860	YES
44	e623fb98-5a74-4a95-b84e-afc600e97860	NO
49	e623fb98-5a74-4a95-b84e-afc600e97860	YES
53	e623fb98-5a74-4a95-b84e-afc600e97860	YES
63	e623fb98-5a74-4a95-b84e-afc600e97860	YES
65	e623fb98-5a74-4a95-b84e-afc600e97860	YES
6	e623fb98-5a74-4a95-b84e-afc600e97860	NO
79	e623fb98-5a74-4a95-b84e-afc600e97860	NO
83	e623fb98-5a74-4a95-b84e-afc600e97860	YES
88	e623fb98-5a74-4a95-b84e-afc600e97860	YES
98	e623fb98-5a74-4a95-b84e-afc600e97860	YES
106	e623fb98-5a74-4a95-b84e-afc600e97860	YES
11	e623fb98-5a74-4a95-b84e-afc600e97860	YES
14	e623fb98-5a74-4a95-b84e-afc600e97860	YES
149	e623fb98-5a74-4a95-b84e-afc600e97860	UNKNOWN
153	e623fb98-5a74-4a95-b84e-afc600e97860	YES
167	e623fb98-5a74-4a95-b84e-afc600e97860	NO
168	e623fb98-5a74-4a95-b84e-afc600e97860	YES
178	e623fb98-5a74-4a95-b84e-afc600e97860	UNKNOWN
211	e623fb98-5a74-4a95-b84e-afc600e97860	YES
110	e623fb98-5a74-4a95-b84e-afc600e97860	YES
185	e623fb98-5a74-4a95-b84e-afc600e97860	NO
182	e623fb98-5a74-4a95-b84e-afc600e97860	NO
144	e623fb98-5a74-4a95-b84e-afc600e97860	YES
198	e623fb98-5a74-4a95-b84e-afc600e97860	YES
89	e623fb98-5a74-4a95-b84e-afc600e97860	YES
154	e623fb98-5a74-4a95-b84e-afc600e97860	YES
100	e623fb98-5a74-4a95-b84e-afc600e97860	NO
248	e623fb98-5a74-4a95-b84e-afc600e97860	NO
251	e623fb98-5a74-4a95-b84e-afc600e97860	NO
250	e623fb98-5a74-4a95-b84e-afc600e97860	NO
261	e623fb98-5a74-4a95-b84e-afc600e97860	NO
264	e623fb98-5a74-4a95-b84e-afc600e97860	YES
270	e623fb98-5a74-4a95-b84e-afc600e97860	NO
271	e623fb98-5a74-4a95-b84e-afc600e97860	NO
272	e623fb98-5a74-4a95-b84e-afc600e97860	NO
277	e623fb98-5a74-4a95-b84e-afc600e97860	NO
280	e623fb98-5a74-4a95-b84e-afc600e97860	YES
374	56589903-f505-4b43-8c46-afc000bc9c5a	UNKNOWN
348	56589903-f505-4b43-8c46-afc000bc9c5a	YES
414	56589903-f505-4b43-8c46-afc000bc9c5a	UNKNOWN
353	56589903-f505-4b43-8c46-afc000bc9c5a	NO
419	56589903-f505-4b43-8c46-afc000bc9c5a	YES
370	56589903-f505-4b43-8c46-afc000bc9c5a	YES
422	56589903-f505-4b43-8c46-afc000bc9c5a	YES
371	56589903-f505-4b43-8c46-afc000bc9c5a	YES
358	56589903-f505-4b43-8c46-afc000bc9c5a	UNKNOWN
396	56589903-f505-4b43-8c46-afc000bc9c5a	YES
386	56589903-f505-4b43-8c46-afc000bc9c5a	YES
349	56589903-f505-4b43-8c46-afc000bc9c5a	YES
383	56589903-f505-4b43-8c46-afc000bc9c5a	YES
390	56589903-f505-4b43-8c46-afc000bc9c5a	NO
314	e623fb98-5a74-4a95-b84e-afc600e97860	NO
323	e623fb98-5a74-4a95-b84e-afc600e97860	YES
327	e623fb98-5a74-4a95-b84e-afc600e97860	YES
328	e623fb98-5a74-4a95-b84e-afc600e97860	NO
329	e623fb98-5a74-4a95-b84e-afc600e97860	YES
330	e623fb98-5a74-4a95-b84e-afc600e97860	YES
331	e623fb98-5a74-4a95-b84e-afc600e97860	YES
334	e623fb98-5a74-4a95-b84e-afc600e97860	YES
333	e623fb98-5a74-4a95-b84e-afc600e97860	YES
332	e623fb98-5a74-4a95-b84e-afc600e97860	YES
337	e623fb98-5a74-4a95-b84e-afc600e97860	YES
341	e623fb98-5a74-4a95-b84e-afc600e97860	NO
340	e623fb98-5a74-4a95-b84e-afc600e97860	YES
343	e623fb98-5a74-4a95-b84e-afc600e97860	NO
373	e623fb98-5a74-4a95-b84e-afc600e97860	NO
395	e623fb98-5a74-4a95-b84e-afc600e97860	YES
360	e623fb98-5a74-4a95-b84e-afc600e97860	NO
369	e623fb98-5a74-4a95-b84e-afc600e97860	YES
389	e623fb98-5a74-4a95-b84e-afc600e97860	YES
393	e623fb98-5a74-4a95-b84e-afc600e97860	NO
347	e623fb98-5a74-4a95-b84e-afc600e97860	YES
374	e623fb98-5a74-4a95-b84e-afc600e97860	NO
348	e623fb98-5a74-4a95-b84e-afc600e97860	YES
414	e623fb98-5a74-4a95-b84e-afc600e97860	YES
353	e623fb98-5a74-4a95-b84e-afc600e97860	NO
419	e623fb98-5a74-4a95-b84e-afc600e97860	YES
370	e623fb98-5a74-4a95-b84e-afc600e97860	YES
422	e623fb98-5a74-4a95-b84e-afc600e97860	YES
371	e623fb98-5a74-4a95-b84e-afc600e97860	YES
376	e623fb98-5a74-4a95-b84e-afc600e97860	NO
396	e623fb98-5a74-4a95-b84e-afc600e97860	YES
386	e623fb98-5a74-4a95-b84e-afc600e97860	YES
349	e623fb98-5a74-4a95-b84e-afc600e97860	YES
383	e623fb98-5a74-4a95-b84e-afc600e97860	YES
390	e623fb98-5a74-4a95-b84e-afc600e97860	NO
410	e623fb98-5a74-4a95-b84e-afc600e97860	YES
378	e623fb98-5a74-4a95-b84e-afc600e97860	YES
366	e623fb98-5a74-4a95-b84e-afc600e97860	YES
363	e623fb98-5a74-4a95-b84e-afc600e97860	YES
388	e623fb98-5a74-4a95-b84e-afc600e97860	NO
403	e623fb98-5a74-4a95-b84e-afc600e97860	YES
379	e623fb98-5a74-4a95-b84e-afc600e97860	NO
346	e623fb98-5a74-4a95-b84e-afc600e97860	YES
387	e623fb98-5a74-4a95-b84e-afc600e97860	NO
367	e623fb98-5a74-4a95-b84e-afc600e97860	YES
417	e623fb98-5a74-4a95-b84e-afc600e97860	YES
361	e623fb98-5a74-4a95-b84e-afc600e97860	NO
399	e623fb98-5a74-4a95-b84e-afc600e97860	YES
357	e623fb98-5a74-4a95-b84e-afc600e97860	YES
418	e623fb98-5a74-4a95-b84e-afc600e97860	YES
354	e623fb98-5a74-4a95-b84e-afc600e97860	YES
392	e623fb98-5a74-4a95-b84e-afc600e97860	NO
391	e623fb98-5a74-4a95-b84e-afc600e97860	NO
404	e623fb98-5a74-4a95-b84e-afc600e97860	YES
405	e623fb98-5a74-4a95-b84e-afc600e97860	NO
420	e623fb98-5a74-4a95-b84e-afc600e97860	YES
424	e623fb98-5a74-4a95-b84e-afc600e97860	YES
394	e623fb98-5a74-4a95-b84e-afc600e97860	NO
425	e623fb98-5a74-4a95-b84e-afc600e97860	NO
415	e623fb98-5a74-4a95-b84e-afc600e97860	NO
426	e623fb98-5a74-4a95-b84e-afc600e97860	YES
427	e623fb98-5a74-4a95-b84e-afc600e97860	NO
428	e623fb98-5a74-4a95-b84e-afc600e97860	YES
431	e623fb98-5a74-4a95-b84e-afc600e97860	UNKNOWN
430	e623fb98-5a74-4a95-b84e-afc600e97860	NO
433	e623fb98-5a74-4a95-b84e-afc600e97860	YES
436	e623fb98-5a74-4a95-b84e-afc600e97860	NO
437	e623fb98-5a74-4a95-b84e-afc600e97860	YES
439	e623fb98-5a74-4a95-b84e-afc600e97860	YES
440	e623fb98-5a74-4a95-b84e-afc600e97860	NO
441	e623fb98-5a74-4a95-b84e-afc600e97860	NO
166	e623fb98-5a74-4a95-b84e-afc600e97860	YES
210	671a8430-57d0-4694-b1d4-b01c00718828	NO
161	671a8430-57d0-4694-b1d4-b01c00718828	UNKNOWN
172	671a8430-57d0-4694-b1d4-b01c00718828	NO
120	671a8430-57d0-4694-b1d4-b01c00718828	NO
96	671a8430-57d0-4694-b1d4-b01c00718828	YES
116	671a8430-57d0-4694-b1d4-b01c00718828	NO
159	671a8430-57d0-4694-b1d4-b01c00718828	YES
166	671a8430-57d0-4694-b1d4-b01c00718828	YES
51	671a8430-57d0-4694-b1d4-b01c00718828	YES
411	671a8430-57d0-4694-b1d4-b01c00718828	YES
188	671a8430-57d0-4694-b1d4-b01c00718828	YES
40	671a8430-57d0-4694-b1d4-b01c00718828	UNKNOWN
285	e623fb98-5a74-4a95-b84e-afc600e97860	NO
287	e623fb98-5a74-4a95-b84e-afc600e97860	NO
289	e623fb98-5a74-4a95-b84e-afc600e97860	NO
293	e623fb98-5a74-4a95-b84e-afc600e97860	YES
294	e623fb98-5a74-4a95-b84e-afc600e97860	NO
296	e623fb98-5a74-4a95-b84e-afc600e97860	YES
297	e623fb98-5a74-4a95-b84e-afc600e97860	NO
298	e623fb98-5a74-4a95-b84e-afc600e97860	NO
299	e623fb98-5a74-4a95-b84e-afc600e97860	NO
304	e623fb98-5a74-4a95-b84e-afc600e97860	YES
305	e623fb98-5a74-4a95-b84e-afc600e97860	NO
306	e623fb98-5a74-4a95-b84e-afc600e97860	NO
310	e623fb98-5a74-4a95-b84e-afc600e97860	NO
312	e623fb98-5a74-4a95-b84e-afc600e97860	NO
167	671a8430-57d0-4694-b1d4-b01c00718828	NO
168	671a8430-57d0-4694-b1d4-b01c00718828	YES
178	671a8430-57d0-4694-b1d4-b01c00718828	UNKNOWN
21	671a8430-57d0-4694-b1d4-b01c00718828	NO
211	671a8430-57d0-4694-b1d4-b01c00718828	YES
110	671a8430-57d0-4694-b1d4-b01c00718828	YES
185	671a8430-57d0-4694-b1d4-b01c00718828	NO
182	671a8430-57d0-4694-b1d4-b01c00718828	NO
144	671a8430-57d0-4694-b1d4-b01c00718828	YES
198	671a8430-57d0-4694-b1d4-b01c00718828	YES
89	671a8430-57d0-4694-b1d4-b01c00718828	YES
154	671a8430-57d0-4694-b1d4-b01c00718828	YES
100	671a8430-57d0-4694-b1d4-b01c00718828	NO
251	671a8430-57d0-4694-b1d4-b01c00718828	NO
250	671a8430-57d0-4694-b1d4-b01c00718828	NO
261	671a8430-57d0-4694-b1d4-b01c00718828	NO
264	671a8430-57d0-4694-b1d4-b01c00718828	YES
270	671a8430-57d0-4694-b1d4-b01c00718828	NO
271	671a8430-57d0-4694-b1d4-b01c00718828	NO
272	671a8430-57d0-4694-b1d4-b01c00718828	NO
277	671a8430-57d0-4694-b1d4-b01c00718828	NO
278	671a8430-57d0-4694-b1d4-b01c00718828	NO
280	671a8430-57d0-4694-b1d4-b01c00718828	YES
283	671a8430-57d0-4694-b1d4-b01c00718828	NO
285	671a8430-57d0-4694-b1d4-b01c00718828	NO
287	671a8430-57d0-4694-b1d4-b01c00718828	NO
289	671a8430-57d0-4694-b1d4-b01c00718828	NO
293	671a8430-57d0-4694-b1d4-b01c00718828	YES
294	671a8430-57d0-4694-b1d4-b01c00718828	NO
296	671a8430-57d0-4694-b1d4-b01c00718828	YES
297	671a8430-57d0-4694-b1d4-b01c00718828	NO
299	671a8430-57d0-4694-b1d4-b01c00718828	NO
302	671a8430-57d0-4694-b1d4-b01c00718828	UNKNOWN
304	671a8430-57d0-4694-b1d4-b01c00718828	YES
305	671a8430-57d0-4694-b1d4-b01c00718828	NO
306	671a8430-57d0-4694-b1d4-b01c00718828	NO
307	671a8430-57d0-4694-b1d4-b01c00718828	NO
309	671a8430-57d0-4694-b1d4-b01c00718828	NO
310	671a8430-57d0-4694-b1d4-b01c00718828	NO
312	671a8430-57d0-4694-b1d4-b01c00718828	NO
314	671a8430-57d0-4694-b1d4-b01c00718828	NO
323	671a8430-57d0-4694-b1d4-b01c00718828	YES
327	671a8430-57d0-4694-b1d4-b01c00718828	YES
328	671a8430-57d0-4694-b1d4-b01c00718828	NO
329	671a8430-57d0-4694-b1d4-b01c00718828	YES
330	671a8430-57d0-4694-b1d4-b01c00718828	YES
331	671a8430-57d0-4694-b1d4-b01c00718828	YES
334	671a8430-57d0-4694-b1d4-b01c00718828	YES
333	671a8430-57d0-4694-b1d4-b01c00718828	YES
337	671a8430-57d0-4694-b1d4-b01c00718828	UNKNOWN
339	671a8430-57d0-4694-b1d4-b01c00718828	YES
341	671a8430-57d0-4694-b1d4-b01c00718828	NO
340	671a8430-57d0-4694-b1d4-b01c00718828	YES
343	671a8430-57d0-4694-b1d4-b01c00718828	NO
373	671a8430-57d0-4694-b1d4-b01c00718828	NO
395	671a8430-57d0-4694-b1d4-b01c00718828	YES
360	671a8430-57d0-4694-b1d4-b01c00718828	NO
369	671a8430-57d0-4694-b1d4-b01c00718828	YES
389	671a8430-57d0-4694-b1d4-b01c00718828	YES
393	671a8430-57d0-4694-b1d4-b01c00718828	NO
347	671a8430-57d0-4694-b1d4-b01c00718828	YES
374	671a8430-57d0-4694-b1d4-b01c00718828	NO
348	671a8430-57d0-4694-b1d4-b01c00718828	YES
414	671a8430-57d0-4694-b1d4-b01c00718828	YES
353	671a8430-57d0-4694-b1d4-b01c00718828	NO
419	671a8430-57d0-4694-b1d4-b01c00718828	YES
370	671a8430-57d0-4694-b1d4-b01c00718828	YES
371	671a8430-57d0-4694-b1d4-b01c00718828	YES
358	671a8430-57d0-4694-b1d4-b01c00718828	UNKNOWN
376	671a8430-57d0-4694-b1d4-b01c00718828	NO
396	671a8430-57d0-4694-b1d4-b01c00718828	YES
386	671a8430-57d0-4694-b1d4-b01c00718828	YES
349	671a8430-57d0-4694-b1d4-b01c00718828	YES
383	671a8430-57d0-4694-b1d4-b01c00718828	YES
390	671a8430-57d0-4694-b1d4-b01c00718828	NO
410	671a8430-57d0-4694-b1d4-b01c00718828	YES
378	671a8430-57d0-4694-b1d4-b01c00718828	YES
366	671a8430-57d0-4694-b1d4-b01c00718828	YES
363	671a8430-57d0-4694-b1d4-b01c00718828	YES
388	671a8430-57d0-4694-b1d4-b01c00718828	NO
403	671a8430-57d0-4694-b1d4-b01c00718828	YES
379	671a8430-57d0-4694-b1d4-b01c00718828	NO
346	671a8430-57d0-4694-b1d4-b01c00718828	YES
387	671a8430-57d0-4694-b1d4-b01c00718828	NO
367	671a8430-57d0-4694-b1d4-b01c00718828	YES
361	671a8430-57d0-4694-b1d4-b01c00718828	NO
44	671a8430-57d0-4694-b1d4-b01c00718828	NO
49	671a8430-57d0-4694-b1d4-b01c00718828	YES
53	671a8430-57d0-4694-b1d4-b01c00718828	YES
63	671a8430-57d0-4694-b1d4-b01c00718828	YES
65	671a8430-57d0-4694-b1d4-b01c00718828	YES
6	671a8430-57d0-4694-b1d4-b01c00718828	NO
79	671a8430-57d0-4694-b1d4-b01c00718828	NO
83	671a8430-57d0-4694-b1d4-b01c00718828	UNKNOWN
88	671a8430-57d0-4694-b1d4-b01c00718828	YES
106	671a8430-57d0-4694-b1d4-b01c00718828	YES
11	671a8430-57d0-4694-b1d4-b01c00718828	YES
14	671a8430-57d0-4694-b1d4-b01c00718828	YES
149	671a8430-57d0-4694-b1d4-b01c00718828	YES
153	671a8430-57d0-4694-b1d4-b01c00718828	YES
431	671a8430-57d0-4694-b1d4-b01c00718828	YES
430	671a8430-57d0-4694-b1d4-b01c00718828	NO
432	671a8430-57d0-4694-b1d4-b01c00718828	NO
433	671a8430-57d0-4694-b1d4-b01c00718828	YES
436	671a8430-57d0-4694-b1d4-b01c00718828	NO
437	671a8430-57d0-4694-b1d4-b01c00718828	YES
439	671a8430-57d0-4694-b1d4-b01c00718828	YES
440	671a8430-57d0-4694-b1d4-b01c00718828	NO
441	671a8430-57d0-4694-b1d4-b01c00718828	NO
426	671a8430-57d0-4694-b1d4-b01c00718828	YES
210	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
161	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	UNKNOWN
172	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
96	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
116	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	UNKNOWN
159	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
166	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
51	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
411	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
188	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
170	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	UNKNOWN
40	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
41	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
44	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
49	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
53	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
63	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
65	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
6	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
79	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
83	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
98	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
106	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
11	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
14	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
149	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
153	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
167	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
168	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
178	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
21	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
211	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
110	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
185	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
182	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
144	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
198	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
89	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
154	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
248	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
251	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
250	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
261	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
264	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
270	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
271	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
272	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
277	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
278	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
280	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
283	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
285	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	UNKNOWN
287	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
289	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
293	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
294	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
296	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
298	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
299	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
302	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	UNKNOWN
304	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
305	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
306	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
307	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
309	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
310	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
312	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
314	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
323	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
327	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
328	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
329	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
330	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
331	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	UNKNOWN
334	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
332	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
399	671a8430-57d0-4694-b1d4-b01c00718828	YES
357	671a8430-57d0-4694-b1d4-b01c00718828	YES
418	671a8430-57d0-4694-b1d4-b01c00718828	YES
354	671a8430-57d0-4694-b1d4-b01c00718828	YES
392	671a8430-57d0-4694-b1d4-b01c00718828	NO
391	671a8430-57d0-4694-b1d4-b01c00718828	NO
404	671a8430-57d0-4694-b1d4-b01c00718828	YES
405	671a8430-57d0-4694-b1d4-b01c00718828	NO
420	671a8430-57d0-4694-b1d4-b01c00718828	YES
394	671a8430-57d0-4694-b1d4-b01c00718828	NO
425	671a8430-57d0-4694-b1d4-b01c00718828	NO
415	671a8430-57d0-4694-b1d4-b01c00718828	NO
427	671a8430-57d0-4694-b1d4-b01c00718828	NO
428	671a8430-57d0-4694-b1d4-b01c00718828	YES
370	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
422	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
371	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
358	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	UNKNOWN
376	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
386	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
349	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
383	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
390	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
410	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
378	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
366	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
363	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
403	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
379	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
346	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
387	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
367	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
417	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
361	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
355	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
399	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
357	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
418	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
354	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
392	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
391	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
404	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
405	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
420	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
424	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
425	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
415	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
426	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
427	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
428	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
431	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
430	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
432	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
433	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
436	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
437	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
439	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
440	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
441	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
348	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
396	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
210	53a79b77-c31c-4326-81a7-f83d333f2600	YES
161	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
120	53a79b77-c31c-4326-81a7-f83d333f2600	YES
96	53a79b77-c31c-4326-81a7-f83d333f2600	YES
116	53a79b77-c31c-4326-81a7-f83d333f2600	YES
159	53a79b77-c31c-4326-81a7-f83d333f2600	YES
166	53a79b77-c31c-4326-81a7-f83d333f2600	YES
51	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
411	53a79b77-c31c-4326-81a7-f83d333f2600	YES
188	53a79b77-c31c-4326-81a7-f83d333f2600	YES
170	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
40	53a79b77-c31c-4326-81a7-f83d333f2600	YES
41	53a79b77-c31c-4326-81a7-f83d333f2600	YES
44	53a79b77-c31c-4326-81a7-f83d333f2600	YES
49	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
53	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
63	53a79b77-c31c-4326-81a7-f83d333f2600	YES
65	53a79b77-c31c-4326-81a7-f83d333f2600	YES
6	53a79b77-c31c-4326-81a7-f83d333f2600	YES
79	53a79b77-c31c-4326-81a7-f83d333f2600	YES
88	53a79b77-c31c-4326-81a7-f83d333f2600	YES
98	53a79b77-c31c-4326-81a7-f83d333f2600	YES
106	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
11	53a79b77-c31c-4326-81a7-f83d333f2600	YES
14	53a79b77-c31c-4326-81a7-f83d333f2600	YES
149	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
153	53a79b77-c31c-4326-81a7-f83d333f2600	YES
167	53a79b77-c31c-4326-81a7-f83d333f2600	YES
168	53a79b77-c31c-4326-81a7-f83d333f2600	YES
178	53a79b77-c31c-4326-81a7-f83d333f2600	YES
21	53a79b77-c31c-4326-81a7-f83d333f2600	YES
211	53a79b77-c31c-4326-81a7-f83d333f2600	YES
110	53a79b77-c31c-4326-81a7-f83d333f2600	YES
185	53a79b77-c31c-4326-81a7-f83d333f2600	YES
182	53a79b77-c31c-4326-81a7-f83d333f2600	YES
144	53a79b77-c31c-4326-81a7-f83d333f2600	YES
198	53a79b77-c31c-4326-81a7-f83d333f2600	YES
89	53a79b77-c31c-4326-81a7-f83d333f2600	YES
100	53a79b77-c31c-4326-81a7-f83d333f2600	YES
339	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
341	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
340	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
343	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
373	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
395	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
360	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
369	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
389	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
347	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
374	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
414	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
353	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
419	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
294	53a79b77-c31c-4326-81a7-f83d333f2600	YES
296	53a79b77-c31c-4326-81a7-f83d333f2600	YES
297	53a79b77-c31c-4326-81a7-f83d333f2600	YES
298	53a79b77-c31c-4326-81a7-f83d333f2600	YES
299	53a79b77-c31c-4326-81a7-f83d333f2600	YES
302	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
304	53a79b77-c31c-4326-81a7-f83d333f2600	YES
305	53a79b77-c31c-4326-81a7-f83d333f2600	YES
306	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
307	53a79b77-c31c-4326-81a7-f83d333f2600	YES
309	53a79b77-c31c-4326-81a7-f83d333f2600	YES
310	53a79b77-c31c-4326-81a7-f83d333f2600	YES
312	53a79b77-c31c-4326-81a7-f83d333f2600	YES
323	53a79b77-c31c-4326-81a7-f83d333f2600	YES
327	53a79b77-c31c-4326-81a7-f83d333f2600	YES
328	53a79b77-c31c-4326-81a7-f83d333f2600	YES
329	53a79b77-c31c-4326-81a7-f83d333f2600	YES
330	53a79b77-c31c-4326-81a7-f83d333f2600	YES
331	53a79b77-c31c-4326-81a7-f83d333f2600	YES
334	53a79b77-c31c-4326-81a7-f83d333f2600	YES
333	53a79b77-c31c-4326-81a7-f83d333f2600	YES
332	53a79b77-c31c-4326-81a7-f83d333f2600	YES
337	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
339	53a79b77-c31c-4326-81a7-f83d333f2600	YES
341	53a79b77-c31c-4326-81a7-f83d333f2600	YES
340	53a79b77-c31c-4326-81a7-f83d333f2600	YES
343	53a79b77-c31c-4326-81a7-f83d333f2600	YES
373	53a79b77-c31c-4326-81a7-f83d333f2600	YES
360	53a79b77-c31c-4326-81a7-f83d333f2600	YES
369	53a79b77-c31c-4326-81a7-f83d333f2600	YES
389	53a79b77-c31c-4326-81a7-f83d333f2600	YES
347	53a79b77-c31c-4326-81a7-f83d333f2600	YES
374	53a79b77-c31c-4326-81a7-f83d333f2600	YES
348	53a79b77-c31c-4326-81a7-f83d333f2600	YES
353	53a79b77-c31c-4326-81a7-f83d333f2600	YES
419	53a79b77-c31c-4326-81a7-f83d333f2600	YES
370	53a79b77-c31c-4326-81a7-f83d333f2600	YES
422	53a79b77-c31c-4326-81a7-f83d333f2600	YES
371	53a79b77-c31c-4326-81a7-f83d333f2600	YES
358	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
376	53a79b77-c31c-4326-81a7-f83d333f2600	YES
396	53a79b77-c31c-4326-81a7-f83d333f2600	YES
386	53a79b77-c31c-4326-81a7-f83d333f2600	YES
349	53a79b77-c31c-4326-81a7-f83d333f2600	YES
383	53a79b77-c31c-4326-81a7-f83d333f2600	YES
390	53a79b77-c31c-4326-81a7-f83d333f2600	YES
410	53a79b77-c31c-4326-81a7-f83d333f2600	YES
378	53a79b77-c31c-4326-81a7-f83d333f2600	YES
366	53a79b77-c31c-4326-81a7-f83d333f2600	YES
388	53a79b77-c31c-4326-81a7-f83d333f2600	YES
403	53a79b77-c31c-4326-81a7-f83d333f2600	YES
379	53a79b77-c31c-4326-81a7-f83d333f2600	YES
346	53a79b77-c31c-4326-81a7-f83d333f2600	YES
387	53a79b77-c31c-4326-81a7-f83d333f2600	YES
367	53a79b77-c31c-4326-81a7-f83d333f2600	YES
417	53a79b77-c31c-4326-81a7-f83d333f2600	YES
361	53a79b77-c31c-4326-81a7-f83d333f2600	YES
355	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
399	53a79b77-c31c-4326-81a7-f83d333f2600	YES
357	53a79b77-c31c-4326-81a7-f83d333f2600	YES
418	53a79b77-c31c-4326-81a7-f83d333f2600	YES
354	53a79b77-c31c-4326-81a7-f83d333f2600	YES
392	53a79b77-c31c-4326-81a7-f83d333f2600	YES
391	53a79b77-c31c-4326-81a7-f83d333f2600	YES
404	53a79b77-c31c-4326-81a7-f83d333f2600	YES
405	53a79b77-c31c-4326-81a7-f83d333f2600	YES
420	53a79b77-c31c-4326-81a7-f83d333f2600	YES
394	53a79b77-c31c-4326-81a7-f83d333f2600	YES
425	53a79b77-c31c-4326-81a7-f83d333f2600	YES
415	53a79b77-c31c-4326-81a7-f83d333f2600	YES
426	53a79b77-c31c-4326-81a7-f83d333f2600	YES
427	53a79b77-c31c-4326-81a7-f83d333f2600	YES
428	53a79b77-c31c-4326-81a7-f83d333f2600	YES
431	53a79b77-c31c-4326-81a7-f83d333f2600	YES
430	53a79b77-c31c-4326-81a7-f83d333f2600	YES
432	53a79b77-c31c-4326-81a7-f83d333f2600	YES
433	53a79b77-c31c-4326-81a7-f83d333f2600	YES
436	53a79b77-c31c-4326-81a7-f83d333f2600	YES
437	53a79b77-c31c-4326-81a7-f83d333f2600	YES
439	53a79b77-c31c-4326-81a7-f83d333f2600	YES
440	53a79b77-c31c-4326-81a7-f83d333f2600	YES
441	53a79b77-c31c-4326-81a7-f83d333f2600	YES
395	53a79b77-c31c-4326-81a7-f83d333f2600	YES
414	53a79b77-c31c-4326-81a7-f83d333f2600	YES
210	1f5d832f-d31b-49b8-a26d-28487662b835	YES
172	1f5d832f-d31b-49b8-a26d-28487662b835	NO
251	53a79b77-c31c-4326-81a7-f83d333f2600	YES
250	53a79b77-c31c-4326-81a7-f83d333f2600	YES
261	53a79b77-c31c-4326-81a7-f83d333f2600	YES
264	53a79b77-c31c-4326-81a7-f83d333f2600	YES
270	53a79b77-c31c-4326-81a7-f83d333f2600	YES
271	53a79b77-c31c-4326-81a7-f83d333f2600	YES
272	53a79b77-c31c-4326-81a7-f83d333f2600	YES
277	53a79b77-c31c-4326-81a7-f83d333f2600	YES
278	53a79b77-c31c-4326-81a7-f83d333f2600	YES
283	53a79b77-c31c-4326-81a7-f83d333f2600	YES
285	53a79b77-c31c-4326-81a7-f83d333f2600	YES
287	53a79b77-c31c-4326-81a7-f83d333f2600	YES
289	53a79b77-c31c-4326-81a7-f83d333f2600	YES
293	53a79b77-c31c-4326-81a7-f83d333f2600	YES
6	1f5d832f-d31b-49b8-a26d-28487662b835	NO
79	1f5d832f-d31b-49b8-a26d-28487662b835	YES
83	1f5d832f-d31b-49b8-a26d-28487662b835	YES
88	1f5d832f-d31b-49b8-a26d-28487662b835	YES
98	1f5d832f-d31b-49b8-a26d-28487662b835	YES
106	1f5d832f-d31b-49b8-a26d-28487662b835	YES
11	1f5d832f-d31b-49b8-a26d-28487662b835	YES
14	1f5d832f-d31b-49b8-a26d-28487662b835	YES
149	1f5d832f-d31b-49b8-a26d-28487662b835	YES
153	1f5d832f-d31b-49b8-a26d-28487662b835	YES
167	1f5d832f-d31b-49b8-a26d-28487662b835	NO
168	1f5d832f-d31b-49b8-a26d-28487662b835	YES
178	1f5d832f-d31b-49b8-a26d-28487662b835	YES
211	1f5d832f-d31b-49b8-a26d-28487662b835	YES
110	1f5d832f-d31b-49b8-a26d-28487662b835	YES
185	1f5d832f-d31b-49b8-a26d-28487662b835	YES
182	1f5d832f-d31b-49b8-a26d-28487662b835	NO
144	1f5d832f-d31b-49b8-a26d-28487662b835	YES
198	1f5d832f-d31b-49b8-a26d-28487662b835	YES
89	1f5d832f-d31b-49b8-a26d-28487662b835	YES
154	1f5d832f-d31b-49b8-a26d-28487662b835	YES
100	1f5d832f-d31b-49b8-a26d-28487662b835	NO
248	1f5d832f-d31b-49b8-a26d-28487662b835	YES
251	1f5d832f-d31b-49b8-a26d-28487662b835	YES
250	1f5d832f-d31b-49b8-a26d-28487662b835	NO
261	1f5d832f-d31b-49b8-a26d-28487662b835	NO
264	1f5d832f-d31b-49b8-a26d-28487662b835	YES
270	1f5d832f-d31b-49b8-a26d-28487662b835	NO
271	1f5d832f-d31b-49b8-a26d-28487662b835	NO
272	1f5d832f-d31b-49b8-a26d-28487662b835	UNKNOWN
277	1f5d832f-d31b-49b8-a26d-28487662b835	NO
280	1f5d832f-d31b-49b8-a26d-28487662b835	YES
283	1f5d832f-d31b-49b8-a26d-28487662b835	NO
285	1f5d832f-d31b-49b8-a26d-28487662b835	NO
287	1f5d832f-d31b-49b8-a26d-28487662b835	NO
289	1f5d832f-d31b-49b8-a26d-28487662b835	NO
293	1f5d832f-d31b-49b8-a26d-28487662b835	YES
294	1f5d832f-d31b-49b8-a26d-28487662b835	NO
296	1f5d832f-d31b-49b8-a26d-28487662b835	YES
297	1f5d832f-d31b-49b8-a26d-28487662b835	YES
298	1f5d832f-d31b-49b8-a26d-28487662b835	NO
299	1f5d832f-d31b-49b8-a26d-28487662b835	NO
302	1f5d832f-d31b-49b8-a26d-28487662b835	UNKNOWN
304	1f5d832f-d31b-49b8-a26d-28487662b835	YES
305	1f5d832f-d31b-49b8-a26d-28487662b835	NO
306	1f5d832f-d31b-49b8-a26d-28487662b835	NO
307	1f5d832f-d31b-49b8-a26d-28487662b835	NO
309	1f5d832f-d31b-49b8-a26d-28487662b835	NO
310	1f5d832f-d31b-49b8-a26d-28487662b835	YES
314	1f5d832f-d31b-49b8-a26d-28487662b835	YES
323	1f5d832f-d31b-49b8-a26d-28487662b835	YES
327	1f5d832f-d31b-49b8-a26d-28487662b835	YES
328	1f5d832f-d31b-49b8-a26d-28487662b835	NO
329	1f5d832f-d31b-49b8-a26d-28487662b835	YES
330	1f5d832f-d31b-49b8-a26d-28487662b835	YES
331	1f5d832f-d31b-49b8-a26d-28487662b835	YES
334	1f5d832f-d31b-49b8-a26d-28487662b835	YES
333	1f5d832f-d31b-49b8-a26d-28487662b835	YES
332	1f5d832f-d31b-49b8-a26d-28487662b835	UNKNOWN
337	1f5d832f-d31b-49b8-a26d-28487662b835	YES
339	1f5d832f-d31b-49b8-a26d-28487662b835	YES
341	1f5d832f-d31b-49b8-a26d-28487662b835	NO
340	1f5d832f-d31b-49b8-a26d-28487662b835	YES
343	1f5d832f-d31b-49b8-a26d-28487662b835	NO
373	1f5d832f-d31b-49b8-a26d-28487662b835	NO
395	1f5d832f-d31b-49b8-a26d-28487662b835	YES
360	1f5d832f-d31b-49b8-a26d-28487662b835	NO
389	1f5d832f-d31b-49b8-a26d-28487662b835	YES
393	1f5d832f-d31b-49b8-a26d-28487662b835	YES
347	1f5d832f-d31b-49b8-a26d-28487662b835	YES
374	1f5d832f-d31b-49b8-a26d-28487662b835	YES
348	1f5d832f-d31b-49b8-a26d-28487662b835	YES
414	1f5d832f-d31b-49b8-a26d-28487662b835	NO
353	1f5d832f-d31b-49b8-a26d-28487662b835	YES
419	1f5d832f-d31b-49b8-a26d-28487662b835	YES
370	1f5d832f-d31b-49b8-a26d-28487662b835	YES
422	1f5d832f-d31b-49b8-a26d-28487662b835	YES
371	1f5d832f-d31b-49b8-a26d-28487662b835	YES
358	1f5d832f-d31b-49b8-a26d-28487662b835	UNKNOWN
376	1f5d832f-d31b-49b8-a26d-28487662b835	NO
396	1f5d832f-d31b-49b8-a26d-28487662b835	YES
386	1f5d832f-d31b-49b8-a26d-28487662b835	YES
349	1f5d832f-d31b-49b8-a26d-28487662b835	YES
383	1f5d832f-d31b-49b8-a26d-28487662b835	YES
390	1f5d832f-d31b-49b8-a26d-28487662b835	YES
378	1f5d832f-d31b-49b8-a26d-28487662b835	YES
96	1f5d832f-d31b-49b8-a26d-28487662b835	YES
116	1f5d832f-d31b-49b8-a26d-28487662b835	UNKNOWN
159	1f5d832f-d31b-49b8-a26d-28487662b835	YES
166	1f5d832f-d31b-49b8-a26d-28487662b835	YES
51	1f5d832f-d31b-49b8-a26d-28487662b835	UNKNOWN
411	1f5d832f-d31b-49b8-a26d-28487662b835	YES
188	1f5d832f-d31b-49b8-a26d-28487662b835	NO
170	1f5d832f-d31b-49b8-a26d-28487662b835	UNKNOWN
40	1f5d832f-d31b-49b8-a26d-28487662b835	UNKNOWN
44	1f5d832f-d31b-49b8-a26d-28487662b835	NO
49	1f5d832f-d31b-49b8-a26d-28487662b835	UNKNOWN
53	1f5d832f-d31b-49b8-a26d-28487662b835	YES
63	1f5d832f-d31b-49b8-a26d-28487662b835	YES
65	1f5d832f-d31b-49b8-a26d-28487662b835	YES
391	1f5d832f-d31b-49b8-a26d-28487662b835	NO
404	1f5d832f-d31b-49b8-a26d-28487662b835	YES
405	1f5d832f-d31b-49b8-a26d-28487662b835	NO
420	1f5d832f-d31b-49b8-a26d-28487662b835	YES
424	1f5d832f-d31b-49b8-a26d-28487662b835	YES
394	1f5d832f-d31b-49b8-a26d-28487662b835	NO
425	1f5d832f-d31b-49b8-a26d-28487662b835	NO
415	1f5d832f-d31b-49b8-a26d-28487662b835	YES
426	1f5d832f-d31b-49b8-a26d-28487662b835	YES
427	1f5d832f-d31b-49b8-a26d-28487662b835	NO
428	1f5d832f-d31b-49b8-a26d-28487662b835	YES
431	1f5d832f-d31b-49b8-a26d-28487662b835	YES
430	1f5d832f-d31b-49b8-a26d-28487662b835	YES
433	1f5d832f-d31b-49b8-a26d-28487662b835	YES
436	1f5d832f-d31b-49b8-a26d-28487662b835	YES
437	1f5d832f-d31b-49b8-a26d-28487662b835	YES
439	1f5d832f-d31b-49b8-a26d-28487662b835	YES
440	1f5d832f-d31b-49b8-a26d-28487662b835	NO
441	1f5d832f-d31b-49b8-a26d-28487662b835	NO
210	b0d54477-9760-4595-97bf-afc801062891	YES
172	b0d54477-9760-4595-97bf-afc801062891	YES
120	b0d54477-9760-4595-97bf-afc801062891	YES
159	b0d54477-9760-4595-97bf-afc801062891	UNKNOWN
166	b0d54477-9760-4595-97bf-afc801062891	YES
51	b0d54477-9760-4595-97bf-afc801062891	YES
411	b0d54477-9760-4595-97bf-afc801062891	NO
188	b0d54477-9760-4595-97bf-afc801062891	YES
170	b0d54477-9760-4595-97bf-afc801062891	UNKNOWN
41	b0d54477-9760-4595-97bf-afc801062891	YES
44	b0d54477-9760-4595-97bf-afc801062891	YES
49	b0d54477-9760-4595-97bf-afc801062891	UNKNOWN
53	b0d54477-9760-4595-97bf-afc801062891	YES
63	b0d54477-9760-4595-97bf-afc801062891	YES
65	b0d54477-9760-4595-97bf-afc801062891	YES
6	b0d54477-9760-4595-97bf-afc801062891	YES
79	b0d54477-9760-4595-97bf-afc801062891	UNKNOWN
83	b0d54477-9760-4595-97bf-afc801062891	YES
88	b0d54477-9760-4595-97bf-afc801062891	NO
98	b0d54477-9760-4595-97bf-afc801062891	NO
106	b0d54477-9760-4595-97bf-afc801062891	YES
11	b0d54477-9760-4595-97bf-afc801062891	YES
14	b0d54477-9760-4595-97bf-afc801062891	YES
149	b0d54477-9760-4595-97bf-afc801062891	YES
153	b0d54477-9760-4595-97bf-afc801062891	YES
167	b0d54477-9760-4595-97bf-afc801062891	YES
168	b0d54477-9760-4595-97bf-afc801062891	NO
21	b0d54477-9760-4595-97bf-afc801062891	YES
211	b0d54477-9760-4595-97bf-afc801062891	NO
110	b0d54477-9760-4595-97bf-afc801062891	NO
185	b0d54477-9760-4595-97bf-afc801062891	YES
182	b0d54477-9760-4595-97bf-afc801062891	YES
144	b0d54477-9760-4595-97bf-afc801062891	NO
198	b0d54477-9760-4595-97bf-afc801062891	NO
89	b0d54477-9760-4595-97bf-afc801062891	NO
154	b0d54477-9760-4595-97bf-afc801062891	NO
100	b0d54477-9760-4595-97bf-afc801062891	YES
248	b0d54477-9760-4595-97bf-afc801062891	YES
251	b0d54477-9760-4595-97bf-afc801062891	YES
250	b0d54477-9760-4595-97bf-afc801062891	YES
261	b0d54477-9760-4595-97bf-afc801062891	UNKNOWN
264	b0d54477-9760-4595-97bf-afc801062891	NO
270	b0d54477-9760-4595-97bf-afc801062891	YES
271	b0d54477-9760-4595-97bf-afc801062891	YES
272	b0d54477-9760-4595-97bf-afc801062891	YES
278	b0d54477-9760-4595-97bf-afc801062891	YES
280	b0d54477-9760-4595-97bf-afc801062891	NO
283	b0d54477-9760-4595-97bf-afc801062891	YES
285	b0d54477-9760-4595-97bf-afc801062891	YES
287	b0d54477-9760-4595-97bf-afc801062891	YES
289	b0d54477-9760-4595-97bf-afc801062891	YES
293	b0d54477-9760-4595-97bf-afc801062891	NO
294	b0d54477-9760-4595-97bf-afc801062891	YES
296	b0d54477-9760-4595-97bf-afc801062891	NO
297	b0d54477-9760-4595-97bf-afc801062891	YES
298	b0d54477-9760-4595-97bf-afc801062891	YES
299	b0d54477-9760-4595-97bf-afc801062891	YES
302	b0d54477-9760-4595-97bf-afc801062891	UNKNOWN
304	b0d54477-9760-4595-97bf-afc801062891	NO
305	b0d54477-9760-4595-97bf-afc801062891	YES
306	b0d54477-9760-4595-97bf-afc801062891	YES
307	b0d54477-9760-4595-97bf-afc801062891	YES
309	b0d54477-9760-4595-97bf-afc801062891	YES
312	b0d54477-9760-4595-97bf-afc801062891	YES
363	1f5d832f-d31b-49b8-a26d-28487662b835	YES
388	1f5d832f-d31b-49b8-a26d-28487662b835	YES
403	1f5d832f-d31b-49b8-a26d-28487662b835	YES
379	1f5d832f-d31b-49b8-a26d-28487662b835	NO
346	1f5d832f-d31b-49b8-a26d-28487662b835	YES
387	1f5d832f-d31b-49b8-a26d-28487662b835	NO
367	1f5d832f-d31b-49b8-a26d-28487662b835	YES
417	1f5d832f-d31b-49b8-a26d-28487662b835	YES
361	1f5d832f-d31b-49b8-a26d-28487662b835	YES
399	1f5d832f-d31b-49b8-a26d-28487662b835	YES
357	1f5d832f-d31b-49b8-a26d-28487662b835	YES
418	1f5d832f-d31b-49b8-a26d-28487662b835	YES
354	1f5d832f-d31b-49b8-a26d-28487662b835	YES
392	1f5d832f-d31b-49b8-a26d-28487662b835	YES
395	b0d54477-9760-4595-97bf-afc801062891	NO
360	b0d54477-9760-4595-97bf-afc801062891	YES
369	b0d54477-9760-4595-97bf-afc801062891	YES
389	b0d54477-9760-4595-97bf-afc801062891	NO
393	b0d54477-9760-4595-97bf-afc801062891	YES
347	b0d54477-9760-4595-97bf-afc801062891	NO
374	b0d54477-9760-4595-97bf-afc801062891	YES
348	b0d54477-9760-4595-97bf-afc801062891	YES
414	b0d54477-9760-4595-97bf-afc801062891	YES
353	b0d54477-9760-4595-97bf-afc801062891	YES
419	b0d54477-9760-4595-97bf-afc801062891	UNKNOWN
370	b0d54477-9760-4595-97bf-afc801062891	NO
422	b0d54477-9760-4595-97bf-afc801062891	NO
358	b0d54477-9760-4595-97bf-afc801062891	UNKNOWN
376	b0d54477-9760-4595-97bf-afc801062891	YES
396	b0d54477-9760-4595-97bf-afc801062891	NO
386	b0d54477-9760-4595-97bf-afc801062891	NO
349	b0d54477-9760-4595-97bf-afc801062891	NO
383	b0d54477-9760-4595-97bf-afc801062891	NO
390	b0d54477-9760-4595-97bf-afc801062891	YES
410	b0d54477-9760-4595-97bf-afc801062891	NO
378	b0d54477-9760-4595-97bf-afc801062891	NO
366	b0d54477-9760-4595-97bf-afc801062891	NO
363	b0d54477-9760-4595-97bf-afc801062891	YES
388	b0d54477-9760-4595-97bf-afc801062891	YES
403	b0d54477-9760-4595-97bf-afc801062891	NO
379	b0d54477-9760-4595-97bf-afc801062891	YES
346	b0d54477-9760-4595-97bf-afc801062891	NO
387	b0d54477-9760-4595-97bf-afc801062891	YES
367	b0d54477-9760-4595-97bf-afc801062891	NO
417	b0d54477-9760-4595-97bf-afc801062891	YES
355	b0d54477-9760-4595-97bf-afc801062891	NO
399	b0d54477-9760-4595-97bf-afc801062891	YES
357	b0d54477-9760-4595-97bf-afc801062891	YES
418	b0d54477-9760-4595-97bf-afc801062891	YES
354	b0d54477-9760-4595-97bf-afc801062891	NO
392	b0d54477-9760-4595-97bf-afc801062891	YES
391	b0d54477-9760-4595-97bf-afc801062891	YES
404	b0d54477-9760-4595-97bf-afc801062891	YES
405	b0d54477-9760-4595-97bf-afc801062891	YES
420	b0d54477-9760-4595-97bf-afc801062891	NO
424	b0d54477-9760-4595-97bf-afc801062891	NO
394	b0d54477-9760-4595-97bf-afc801062891	YES
425	b0d54477-9760-4595-97bf-afc801062891	YES
415	b0d54477-9760-4595-97bf-afc801062891	YES
426	b0d54477-9760-4595-97bf-afc801062891	NO
427	b0d54477-9760-4595-97bf-afc801062891	YES
428	b0d54477-9760-4595-97bf-afc801062891	NO
431	b0d54477-9760-4595-97bf-afc801062891	YES
432	b0d54477-9760-4595-97bf-afc801062891	YES
433	b0d54477-9760-4595-97bf-afc801062891	NO
436	b0d54477-9760-4595-97bf-afc801062891	YES
437	b0d54477-9760-4595-97bf-afc801062891	YES
439	b0d54477-9760-4595-97bf-afc801062891	YES
440	b0d54477-9760-4595-97bf-afc801062891	YES
441	b0d54477-9760-4595-97bf-afc801062891	YES
210	cb5d45e0-f093-474b-b1ee-afc801068164	YES
161	cb5d45e0-f093-474b-b1ee-afc801068164	UNKNOWN
172	cb5d45e0-f093-474b-b1ee-afc801068164	YES
120	cb5d45e0-f093-474b-b1ee-afc801068164	YES
96	cb5d45e0-f093-474b-b1ee-afc801068164	NO
116	cb5d45e0-f093-474b-b1ee-afc801068164	YES
159	cb5d45e0-f093-474b-b1ee-afc801068164	UNKNOWN
166	cb5d45e0-f093-474b-b1ee-afc801068164	YES
51	cb5d45e0-f093-474b-b1ee-afc801068164	UNKNOWN
411	cb5d45e0-f093-474b-b1ee-afc801068164	NO
188	cb5d45e0-f093-474b-b1ee-afc801068164	YES
40	cb5d45e0-f093-474b-b1ee-afc801068164	NO
41	cb5d45e0-f093-474b-b1ee-afc801068164	YES
44	cb5d45e0-f093-474b-b1ee-afc801068164	YES
49	cb5d45e0-f093-474b-b1ee-afc801068164	UNKNOWN
53	cb5d45e0-f093-474b-b1ee-afc801068164	NO
63	cb5d45e0-f093-474b-b1ee-afc801068164	YES
65	cb5d45e0-f093-474b-b1ee-afc801068164	YES
6	cb5d45e0-f093-474b-b1ee-afc801068164	YES
79	cb5d45e0-f093-474b-b1ee-afc801068164	YES
83	cb5d45e0-f093-474b-b1ee-afc801068164	NO
88	cb5d45e0-f093-474b-b1ee-afc801068164	NO
98	cb5d45e0-f093-474b-b1ee-afc801068164	NO
106	cb5d45e0-f093-474b-b1ee-afc801068164	NO
11	cb5d45e0-f093-474b-b1ee-afc801068164	YES
14	cb5d45e0-f093-474b-b1ee-afc801068164	YES
149	cb5d45e0-f093-474b-b1ee-afc801068164	YES
153	cb5d45e0-f093-474b-b1ee-afc801068164	YES
167	cb5d45e0-f093-474b-b1ee-afc801068164	YES
178	cb5d45e0-f093-474b-b1ee-afc801068164	YES
323	b0d54477-9760-4595-97bf-afc801062891	NO
327	b0d54477-9760-4595-97bf-afc801062891	YES
328	b0d54477-9760-4595-97bf-afc801062891	YES
329	b0d54477-9760-4595-97bf-afc801062891	NO
330	b0d54477-9760-4595-97bf-afc801062891	NO
331	b0d54477-9760-4595-97bf-afc801062891	UNKNOWN
334	b0d54477-9760-4595-97bf-afc801062891	NO
333	b0d54477-9760-4595-97bf-afc801062891	YES
332	b0d54477-9760-4595-97bf-afc801062891	NO
339	b0d54477-9760-4595-97bf-afc801062891	NO
341	b0d54477-9760-4595-97bf-afc801062891	YES
340	b0d54477-9760-4595-97bf-afc801062891	YES
343	b0d54477-9760-4595-97bf-afc801062891	YES
373	b0d54477-9760-4595-97bf-afc801062891	YES
271	cb5d45e0-f093-474b-b1ee-afc801068164	YES
272	cb5d45e0-f093-474b-b1ee-afc801068164	YES
277	cb5d45e0-f093-474b-b1ee-afc801068164	YES
278	cb5d45e0-f093-474b-b1ee-afc801068164	YES
280	cb5d45e0-f093-474b-b1ee-afc801068164	NO
283	cb5d45e0-f093-474b-b1ee-afc801068164	YES
285	cb5d45e0-f093-474b-b1ee-afc801068164	YES
287	cb5d45e0-f093-474b-b1ee-afc801068164	YES
289	cb5d45e0-f093-474b-b1ee-afc801068164	YES
293	cb5d45e0-f093-474b-b1ee-afc801068164	NO
294	cb5d45e0-f093-474b-b1ee-afc801068164	YES
296	cb5d45e0-f093-474b-b1ee-afc801068164	NO
297	cb5d45e0-f093-474b-b1ee-afc801068164	YES
299	cb5d45e0-f093-474b-b1ee-afc801068164	YES
302	cb5d45e0-f093-474b-b1ee-afc801068164	UNKNOWN
304	cb5d45e0-f093-474b-b1ee-afc801068164	NO
305	cb5d45e0-f093-474b-b1ee-afc801068164	YES
306	cb5d45e0-f093-474b-b1ee-afc801068164	YES
307	cb5d45e0-f093-474b-b1ee-afc801068164	YES
309	cb5d45e0-f093-474b-b1ee-afc801068164	YES
310	cb5d45e0-f093-474b-b1ee-afc801068164	UNKNOWN
312	cb5d45e0-f093-474b-b1ee-afc801068164	YES
314	cb5d45e0-f093-474b-b1ee-afc801068164	YES
323	cb5d45e0-f093-474b-b1ee-afc801068164	NO
327	cb5d45e0-f093-474b-b1ee-afc801068164	NO
328	cb5d45e0-f093-474b-b1ee-afc801068164	YES
329	cb5d45e0-f093-474b-b1ee-afc801068164	NO
330	cb5d45e0-f093-474b-b1ee-afc801068164	NO
331	cb5d45e0-f093-474b-b1ee-afc801068164	YES
334	cb5d45e0-f093-474b-b1ee-afc801068164	NO
333	cb5d45e0-f093-474b-b1ee-afc801068164	YES
337	cb5d45e0-f093-474b-b1ee-afc801068164	YES
339	cb5d45e0-f093-474b-b1ee-afc801068164	NO
341	cb5d45e0-f093-474b-b1ee-afc801068164	YES
340	cb5d45e0-f093-474b-b1ee-afc801068164	YES
343	cb5d45e0-f093-474b-b1ee-afc801068164	YES
373	cb5d45e0-f093-474b-b1ee-afc801068164	YES
395	cb5d45e0-f093-474b-b1ee-afc801068164	NO
360	cb5d45e0-f093-474b-b1ee-afc801068164	YES
369	cb5d45e0-f093-474b-b1ee-afc801068164	NO
389	cb5d45e0-f093-474b-b1ee-afc801068164	NO
393	cb5d45e0-f093-474b-b1ee-afc801068164	YES
347	cb5d45e0-f093-474b-b1ee-afc801068164	NO
374	cb5d45e0-f093-474b-b1ee-afc801068164	YES
348	cb5d45e0-f093-474b-b1ee-afc801068164	NO
414	cb5d45e0-f093-474b-b1ee-afc801068164	YES
353	cb5d45e0-f093-474b-b1ee-afc801068164	YES
419	cb5d45e0-f093-474b-b1ee-afc801068164	UNKNOWN
370	cb5d45e0-f093-474b-b1ee-afc801068164	NO
371	cb5d45e0-f093-474b-b1ee-afc801068164	NO
358	cb5d45e0-f093-474b-b1ee-afc801068164	UNKNOWN
376	cb5d45e0-f093-474b-b1ee-afc801068164	YES
396	cb5d45e0-f093-474b-b1ee-afc801068164	NO
386	cb5d45e0-f093-474b-b1ee-afc801068164	NO
349	cb5d45e0-f093-474b-b1ee-afc801068164	NO
383	cb5d45e0-f093-474b-b1ee-afc801068164	NO
390	cb5d45e0-f093-474b-b1ee-afc801068164	YES
410	cb5d45e0-f093-474b-b1ee-afc801068164	NO
378	cb5d45e0-f093-474b-b1ee-afc801068164	NO
366	cb5d45e0-f093-474b-b1ee-afc801068164	NO
363	cb5d45e0-f093-474b-b1ee-afc801068164	UNKNOWN
388	cb5d45e0-f093-474b-b1ee-afc801068164	YES
403	cb5d45e0-f093-474b-b1ee-afc801068164	NO
379	cb5d45e0-f093-474b-b1ee-afc801068164	YES
346	cb5d45e0-f093-474b-b1ee-afc801068164	NO
387	cb5d45e0-f093-474b-b1ee-afc801068164	YES
367	cb5d45e0-f093-474b-b1ee-afc801068164	NO
361	cb5d45e0-f093-474b-b1ee-afc801068164	YES
355	cb5d45e0-f093-474b-b1ee-afc801068164	NO
399	cb5d45e0-f093-474b-b1ee-afc801068164	YES
357	cb5d45e0-f093-474b-b1ee-afc801068164	NO
418	cb5d45e0-f093-474b-b1ee-afc801068164	NO
354	cb5d45e0-f093-474b-b1ee-afc801068164	NO
392	cb5d45e0-f093-474b-b1ee-afc801068164	YES
391	cb5d45e0-f093-474b-b1ee-afc801068164	YES
404	cb5d45e0-f093-474b-b1ee-afc801068164	YES
405	cb5d45e0-f093-474b-b1ee-afc801068164	YES
420	cb5d45e0-f093-474b-b1ee-afc801068164	NO
424	cb5d45e0-f093-474b-b1ee-afc801068164	NO
394	cb5d45e0-f093-474b-b1ee-afc801068164	YES
425	cb5d45e0-f093-474b-b1ee-afc801068164	YES
415	cb5d45e0-f093-474b-b1ee-afc801068164	YES
426	cb5d45e0-f093-474b-b1ee-afc801068164	NO
427	cb5d45e0-f093-474b-b1ee-afc801068164	YES
428	cb5d45e0-f093-474b-b1ee-afc801068164	NO
430	cb5d45e0-f093-474b-b1ee-afc801068164	YES
211	cb5d45e0-f093-474b-b1ee-afc801068164	NO
110	cb5d45e0-f093-474b-b1ee-afc801068164	NO
185	cb5d45e0-f093-474b-b1ee-afc801068164	YES
182	cb5d45e0-f093-474b-b1ee-afc801068164	YES
144	cb5d45e0-f093-474b-b1ee-afc801068164	NO
198	cb5d45e0-f093-474b-b1ee-afc801068164	NO
89	cb5d45e0-f093-474b-b1ee-afc801068164	NO
154	cb5d45e0-f093-474b-b1ee-afc801068164	NO
100	cb5d45e0-f093-474b-b1ee-afc801068164	YES
251	cb5d45e0-f093-474b-b1ee-afc801068164	YES
250	cb5d45e0-f093-474b-b1ee-afc801068164	YES
261	cb5d45e0-f093-474b-b1ee-afc801068164	YES
264	cb5d45e0-f093-474b-b1ee-afc801068164	NO
270	cb5d45e0-f093-474b-b1ee-afc801068164	YES
411	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
188	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
170	29790ba8-4ae9-497a-93b3-afc801079cc1	UNKNOWN
40	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
41	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
44	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
49	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
53	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
63	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
65	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
6	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
79	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
83	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
98	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
106	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
11	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
14	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
149	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
153	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
167	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
168	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
178	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
21	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
211	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
110	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
185	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
182	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
144	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
198	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
89	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
154	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
248	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
251	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
250	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
261	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
264	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
270	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
271	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
272	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
277	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
278	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
280	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
283	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
285	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
287	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
289	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
293	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
294	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
296	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
298	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
299	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
302	29790ba8-4ae9-497a-93b3-afc801079cc1	UNKNOWN
304	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
305	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
306	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
307	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
309	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
310	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
312	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
314	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
323	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
327	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
328	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
329	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
330	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
331	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
334	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
332	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
337	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
339	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
341	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
340	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
343	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
373	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
395	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
360	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
369	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
389	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
393	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
347	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
374	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
348	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
414	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
353	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
419	29790ba8-4ae9-497a-93b3-afc801079cc1	UNKNOWN
422	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
433	cb5d45e0-f093-474b-b1ee-afc801068164	NO
436	cb5d45e0-f093-474b-b1ee-afc801068164	YES
437	cb5d45e0-f093-474b-b1ee-afc801068164	NO
439	cb5d45e0-f093-474b-b1ee-afc801068164	YES
440	cb5d45e0-f093-474b-b1ee-afc801068164	YES
441	cb5d45e0-f093-474b-b1ee-afc801068164	YES
210	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
161	29790ba8-4ae9-497a-93b3-afc801079cc1	UNKNOWN
172	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
96	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
116	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
159	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
166	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
51	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
346	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
387	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
367	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
417	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
116	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
159	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
166	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	UNKNOWN
358	29790ba8-4ae9-497a-93b3-afc801079cc1	UNKNOWN
411	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
170	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
40	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
376	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
44	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	UNKNOWN
49	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
53	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
396	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
65	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
6	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
83	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
386	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
98	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
106	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
11	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
349	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
149	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
153	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
167	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
383	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
21	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
211	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	UNKNOWN
110	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
390	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
182	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
144	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
198	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
410	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
154	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
100	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
248	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
378	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
250	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
261	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
264	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
363	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
271	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
277	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
278	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
388	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
283	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
285	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
287	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
403	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
293	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
294	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
296	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
379	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
298	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
161	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	UNKNOWN
361	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
120	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
371	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
355	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
399	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
357	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
418	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
354	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
392	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
391	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
404	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
405	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
424	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
394	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
425	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
415	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
426	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
427	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
428	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
431	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
430	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
432	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
433	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
436	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
437	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
439	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
440	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
441	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
96	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
51	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
41	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
63	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
88	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
14	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
178	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
185	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
89	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
251	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
270	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
280	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
289	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
297	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
172	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
391	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
424	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
394	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
425	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
415	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
426	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	UNKNOWN
427	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
428	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
431	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
430	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
432	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
433	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
436	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
437	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	UNKNOWN
439	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
440	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
441	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
79	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
334	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
210	4472ab7f-b7e0-4901-9271-fe74aee3f570	UNKNOWN
188	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
168	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
272	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
161	4472ab7f-b7e0-4901-9271-fe74aee3f570	UNKNOWN
302	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
304	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
305	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
172	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
307	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
309	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
310	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
120	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
314	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
323	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
327	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
96	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
329	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
330	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
331	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
116	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
332	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
337	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
339	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
159	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
340	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
343	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
373	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
166	4472ab7f-b7e0-4901-9271-fe74aee3f570	UNKNOWN
360	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
389	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
393	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
51	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
374	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
348	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
414	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
411	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
419	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
370	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
371	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
188	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
376	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
396	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
386	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
383	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
390	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
410	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
347	56589903-f505-4b43-8c46-afc000bc9c5a	YES
366	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
363	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
388	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
376	56589903-f505-4b43-8c46-afc000bc9c5a	NO
379	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
346	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
387	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
299	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
417	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
361	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
355	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
399	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
357	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
418	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
354	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
392	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	UNKNOWN
404	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
405	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
420	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
347	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
353	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
306	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
312	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
328	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
333	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
341	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
395	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
358	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	UNKNOWN
349	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
378	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
403	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
367	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
153	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
167	4472ab7f-b7e0-4901-9271-fe74aee3f570	NO
168	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
178	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
21	4472ab7f-b7e0-4901-9271-fe74aee3f570	NO
211	4472ab7f-b7e0-4901-9271-fe74aee3f570	UNKNOWN
110	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
182	4472ab7f-b7e0-4901-9271-fe74aee3f570	NO
144	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
198	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
89	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
154	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
250	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
261	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
264	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
270	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
271	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
272	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
277	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
278	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
280	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
283	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
285	4472ab7f-b7e0-4901-9271-fe74aee3f570	NO
287	4472ab7f-b7e0-4901-9271-fe74aee3f570	NO
289	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
293	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
294	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
296	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
298	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
299	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
302	4472ab7f-b7e0-4901-9271-fe74aee3f570	NO
304	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
305	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
306	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
307	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
309	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
310	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
312	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
314	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
323	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
327	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
328	4472ab7f-b7e0-4901-9271-fe74aee3f570	NO
329	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
330	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
331	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
333	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
337	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
339	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
341	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
340	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
343	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
373	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
395	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
360	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
369	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
389	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
393	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
347	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
374	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
348	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
414	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
353	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
419	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
370	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
371	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
358	4472ab7f-b7e0-4901-9271-fe74aee3f570	UNKNOWN
376	4472ab7f-b7e0-4901-9271-fe74aee3f570	NO
396	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
386	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
349	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
383	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
390	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
410	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
378	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
366	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
363	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
388	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
403	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
379	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
346	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
387	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
367	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
361	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
40	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
41	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
44	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
49	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
53	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
63	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
65	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
6	4472ab7f-b7e0-4901-9271-fe74aee3f570	NO
83	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
98	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
106	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
11	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
14	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
149	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
426	4472ab7f-b7e0-4901-9271-fe74aee3f570	UNKNOWN
415	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
427	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
428	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
431	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
430	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
432	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
433	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
436	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
437	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
439	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
440	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
441	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
79	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
334	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
399	56589903-f505-4b43-8c46-afc000bc9c5a	YES
433	56589903-f505-4b43-8c46-afc000bc9c5a	YES
41	e623fb98-5a74-4a95-b84e-afc600e97860	NO
21	e623fb98-5a74-4a95-b84e-afc600e97860	NO
278	e623fb98-5a74-4a95-b84e-afc600e97860	NO
283	e623fb98-5a74-4a95-b84e-afc600e97860	NO
302	e623fb98-5a74-4a95-b84e-afc600e97860	UNKNOWN
339	e623fb98-5a74-4a95-b84e-afc600e97860	YES
358	e623fb98-5a74-4a95-b84e-afc600e97860	UNKNOWN
355	e623fb98-5a74-4a95-b84e-afc600e97860	YES
432	e623fb98-5a74-4a95-b84e-afc600e97860	NO
170	671a8430-57d0-4694-b1d4-b01c00718828	UNKNOWN
41	671a8430-57d0-4694-b1d4-b01c00718828	NO
98	671a8430-57d0-4694-b1d4-b01c00718828	YES
248	671a8430-57d0-4694-b1d4-b01c00718828	NO
298	671a8430-57d0-4694-b1d4-b01c00718828	NO
332	671a8430-57d0-4694-b1d4-b01c00718828	YES
422	671a8430-57d0-4694-b1d4-b01c00718828	YES
417	671a8430-57d0-4694-b1d4-b01c00718828	YES
424	671a8430-57d0-4694-b1d4-b01c00718828	YES
120	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
88	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
100	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
297	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
333	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
337	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
393	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
388	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	YES
394	1b5ef9db-1562-45ea-9ebd-f85e30e2e81d	NO
172	53a79b77-c31c-4326-81a7-f83d333f2600	YES
83	53a79b77-c31c-4326-81a7-f83d333f2600	YES
154	53a79b77-c31c-4326-81a7-f83d333f2600	YES
248	53a79b77-c31c-4326-81a7-f83d333f2600	YES
280	53a79b77-c31c-4326-81a7-f83d333f2600	YES
314	53a79b77-c31c-4326-81a7-f83d333f2600	YES
393	53a79b77-c31c-4326-81a7-f83d333f2600	YES
363	53a79b77-c31c-4326-81a7-f83d333f2600	YES
161	1f5d832f-d31b-49b8-a26d-28487662b835	UNKNOWN
120	1f5d832f-d31b-49b8-a26d-28487662b835	NO
41	1f5d832f-d31b-49b8-a26d-28487662b835	NO
21	1f5d832f-d31b-49b8-a26d-28487662b835	YES
278	1f5d832f-d31b-49b8-a26d-28487662b835	NO
312	1f5d832f-d31b-49b8-a26d-28487662b835	NO
369	1f5d832f-d31b-49b8-a26d-28487662b835	YES
410	1f5d832f-d31b-49b8-a26d-28487662b835	YES
366	1f5d832f-d31b-49b8-a26d-28487662b835	YES
355	1f5d832f-d31b-49b8-a26d-28487662b835	UNKNOWN
432	1f5d832f-d31b-49b8-a26d-28487662b835	NO
40	b0d54477-9760-4595-97bf-afc801062891	NO
178	b0d54477-9760-4595-97bf-afc801062891	YES
277	b0d54477-9760-4595-97bf-afc801062891	YES
310	b0d54477-9760-4595-97bf-afc801062891	YES
314	b0d54477-9760-4595-97bf-afc801062891	YES
337	b0d54477-9760-4595-97bf-afc801062891	YES
371	b0d54477-9760-4595-97bf-afc801062891	UNKNOWN
430	b0d54477-9760-4595-97bf-afc801062891	YES
170	cb5d45e0-f093-474b-b1ee-afc801068164	UNKNOWN
168	cb5d45e0-f093-474b-b1ee-afc801068164	NO
21	cb5d45e0-f093-474b-b1ee-afc801068164	YES
248	cb5d45e0-f093-474b-b1ee-afc801068164	YES
298	cb5d45e0-f093-474b-b1ee-afc801068164	YES
332	cb5d45e0-f093-474b-b1ee-afc801068164	NO
422	cb5d45e0-f093-474b-b1ee-afc801068164	NO
417	cb5d45e0-f093-474b-b1ee-afc801068164	YES
431	cb5d45e0-f093-474b-b1ee-afc801068164	UNKNOWN
432	cb5d45e0-f093-474b-b1ee-afc801068164	YES
120	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
88	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
100	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
297	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
333	29790ba8-4ae9-497a-93b3-afc801079cc1	YES
370	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
355	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
399	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
357	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
418	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
354	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
392	4472ab7f-b7e0-4901-9271-fe74aee3f570	UNKNOWN
391	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
404	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
405	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
420	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
424	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
394	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
425	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
366	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
306	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
309	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
392	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
420	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
343	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
373	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
153	0775eb08-d871-4e20-aefd-af2000d463d9	YES
426	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
420	29790ba8-4ae9-497a-93b3-afc801079cc1	NO
427	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
248	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
251	4472ab7f-b7e0-4901-9271-fe74aee3f570	NO
166	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
424	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
167	0775eb08-d871-4e20-aefd-af2000d463d9	YES
440	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
411	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
79	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
264	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
211	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	UNKNOWN
88	bc2d5201-991f-49cd-928c-add700b29b20	UNKNOWN
307	e623fb98-5a74-4a95-b84e-afc600e97860	NO
6	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
441	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
170	ad989cee-de35-4fde-b2d1-0b0d190d861d	UNKNOWN
40	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
270	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
306	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
116	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
65	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
348	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
170	4c300ecb-2939-46b0-abd9-afbf010d74b8	UNKNOWN
309	e623fb98-5a74-4a95-b84e-afc600e97860	NO
415	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
159	66e16f07-36f4-4fc7-ba98-7168df9e9995	YES
297	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
332	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
210	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
422	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
388	d938eee3-7755-4da0-8494-0887ac618422	YES
403	d938eee3-7755-4da0-8494-0887ac618422	YES
417	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
11	ba4a1c99-48d7-40da-86ea-0c77f3797150	YES
355	671a8430-57d0-4694-b1d4-b01c00718828	YES
166	66e16f07-36f4-4fc7-ba98-7168df9e9995	UNKNOWN
289	1523a63a-0f8d-43bc-b567-adfe00bafc91	UNKNOWN
298	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
299	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
369	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	YES
424	53a79b77-c31c-4326-81a7-f83d333f2600	UNKNOWN
426	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
414	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
427	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
431	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
353	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
419	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
422	94a9ebba-2ea2-449a-a7e4-2da09a5585e6	NO
161	b0d54477-9760-4595-97bf-afc801062891	UNKNOWN
110	bc2d5201-991f-49cd-928c-add700b29b20	YES
144	dc549f88-6735-4539-bc44-afb7007d5be6	NO
83	bc2d5201-991f-49cd-928c-add700b29b20	YES
170	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
361	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
88	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
96	b0d54477-9760-4595-97bf-afc801062891	NO
347	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
185	4472ab7f-b7e0-4901-9271-fe74aee3f570	NO
116	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
159	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
302	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
354	dfea9a26-ef3d-48ec-bb78-299f3c1201df	YES
144	190c19ef-be90-45bf-b9c6-afc700ee176a	NO
304	1523a63a-0f8d-43bc-b567-adfe00bafc91	YES
305	1523a63a-0f8d-43bc-b567-adfe00bafc91	NO
323	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
88	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
170	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
116	b0d54477-9760-4595-97bf-afc801062891	YES
361	b0d54477-9760-4595-97bf-afc801062891	YES
379	dfea9a26-ef3d-48ec-bb78-299f3c1201df	NO
100	4472ab7f-b7e0-4901-9271-fe74aee3f570	YES
333	e37e8e4d-0b45-40ba-a340-b0230080f7e0	YES
6	95b5667c-6138-42f0-b8a2-af2000d5b73f	YES
166	ad989cee-de35-4fde-b2d1-0b0d190d861d	YES
153	443eaa3b-b04e-4043-8f3e-21cd4f1ff32a	YES
332	e37e8e4d-0b45-40ba-a340-b0230080f7e0	NO
294	e2c7af9b-2788-406b-b382-afc500e2de5a	NO
399	d938eee3-7755-4da0-8494-0887ac618422	YES
357	d938eee3-7755-4da0-8494-0887ac618422	YES
328	93ee3ae9-69b2-4273-b9bf-afc700f5e381	NO
329	93ee3ae9-69b2-4273-b9bf-afc700f5e381	YES
\.


--
-- Data for Name: Party; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Party" (id, "shortName", "fullName") FROM stdin;
1	FDP	Freisinnig-Demokratische Partei
2	GLP	Grünliberale Partei
3	SP	Sozialdemokratische Partei
4	Grüne	Grüne Partei der Schweiz
5	SVP	Schweizerische Volkspartei
6	EVP	Evangelische Volkspartei
7	CVP	Christlichdemokratische Volkspartei
8	BDP	Bürgerlich-Demokratische Partei
9	MCG	Mouvement Citoyens Romands
10	Lega	Lega dei Ticinesi
11	CSP	Christlich-soziale Partei
12	CSPO	Christlichsoziale Volkspartei Oberwallis
13	PdA	Partei der Arbeit
14	LPS	Liberale Partei der Schweiz
15	BastA	Basels starke Alternative
16	LDP	Liberal-Demokratische Partei
17	PPS	Piratenpartei Schweiz
18	CVPO	CVP Oberwallis
19	EDU	Eidgenössisch-Demokratische Union
20	ALG	Alternative - die Grünen Zug
21	EàG	Ensemble à Gauche
22	M	Die Mitte
\.


--
-- Data for Name: _CommitteeToParliamentarian; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."_CommitteeToParliamentarian" ("A", "B") FROM stdin;
27	6
1	6
60	6
1	11
1	14
38	14
11	21
9	40
21	40
27	40
39	41
1	41
21	41
11	41
37	41
11	44
1	44
11	49
64	49
3	51
11	53
30	60
39	60
17	60
42	60
3	63
17	63
62	63
5	65
7	65
35	65
38	66
63	66
21	66
53	66
52	66
54	66
58	66
59	66
48	76
54	76
20	76
35	76
53	76
11	79
15	83
13	83
7	88
62	88
42	88
39	88
60	88
30	89
31	89
17	89
35	89
3	96
13	98
15	100
39	100
53	101
55	101
57	101
47	102
51	102
40	102
57	102
11	106
1	110
27	116
42	116
40	116
20	116
7	120
5	120
38	120
55	125
50	125
53	125
38	125
54	125
13	144
3	144
52	147
53	147
55	147
11	149
21	149
20	153
3	153
27	153
40	153
3	154
20	154
27	154
3	159
17	161
37	161
59	161
39	161
13	166
60	166
17	166
32	166
5	167
1	168
18	170
5	170
44	170
44	171
50	171
52	171
17	172
35	172
11	178
13	182
5	182
19	185
13	185
32	185
17	188
63	188
37	188
21	190
53	190
54	190
57	190
20	192
57	192
62	192
63	192
52	192
21	192
37	192
44	192
54	192
55	192
39	198
3	198
60	198
3	210
13	210
11	211
19	211
47	219
48	219
52	219
63	219
55	219
53	223
49	223
48	223
58	223
59	223
52	227
37	227
42	227
32	227
47	227
55	227
49	228
47	228
50	228
30	228
31	228
54	242
52	242
20	242
31	242
48	242
44	242
37	248
17	248
11	250
37	250
11	251
7	261
15	261
35	261
15	264
21	264
42	264
63	264
17	264
11	270
15	270
20	270
62	270
15	271
21	271
11	272
27	272
18	273
49	273
52	273
32	273
35	273
48	273
18	275
44	275
48	275
55	275
3	277
11	278
38	280
19	280
17	280
1	283
13	283
51	284
41	284
49	284
50	284
17	285
38	285
60	285
27	287
7	287
3	289
5	289
15	293
5	293
20	293
11	294
1	296
60	296
13	297
15	297
15	298
19	298
29	298
17	299
62	299
39	299
59	299
60	299
40	301
35	301
41	301
50	301
52	301
57	301
58	301
64	301
1	302
9	302
27	304
7	304
41	304
19	305
5	305
13	306
15	306
15	307
41	307
60	307
7	307
7	309
27	309
32	309
38	310
27	310
62	310
17	310
7	312
32	312
27	314
5	314
31	314
47	315
49	315
50	315
57	315
56	316
18	316
64	316
47	316
52	316
47	317
52	317
56	317
43	317
48	318
55	318
37	318
47	318
21	319
55	319
56	319
54	319
48	319
50	321
49	321
52	321
64	321
11	323
39	323
17	327
42	327
1	328
19	329
29	330
1	330
1	331
39	331
18	331
29	331
17	332
63	332
7	332
3	333
13	333
31	333
27	334
5	334
30	335
47	335
51	335
5	337
13	339
39	339
1	339
15	340
39	340
11	340
3	341
31	343
17	343
20	343
55	345
56	345
37	345
48	345
51	345
11	346
15	347
19	347
17	348
19	348
39	348
5	349
7	349
47	351
53	351
56	351
54	352
57	352
20	352
21	352
53	352
1	353
5	353
18	354
19	354
17	355
47	356
56	356
30	356
31	356
49	356
53	356
1	357
9	358
5	360
3	360
3	361
21	361
60	361
30	361
3	363
27	363
32	364
50	364
53	364
57	364
13	366
11	366
32	366
39	366
11	367
30	367
64	367
9	369
21	369
31	369
3	370
27	370
19	371
7	371
13	373
1	373
19	374
44	374
9	376
19	376
3	378
5	378
3	379
17	379
49	380
41	380
50	380
53	380
56	380
47	381
51	381
42	381
56	381
32	382
52	382
59	382
49	382
56	382
58	382
64	382
3	383
20	384
48	384
51	384
43	384
49	384
56	384
1	386
60	386
27	386
3	387
42	388
39	388
5	388
19	388
15	389
3	390
9	390
29	390
19	391
3	391
60	392
7	392
41	392
19	393
5	393
7	394
9	394
7	395
9	395
18	396
20	396
13	396
44	396
20	398
47	398
49	398
56	398
11	399
60	399
55	400
51	400
54	400
50	402
49	402
29	402
57	402
62	402
29	403
5	403
13	403
15	404
13	405
18	405
44	405
17	405
18	406
51	406
42	406
57	406
49	406
1	410
27	411
9	411
1	414
30	414
7	415
59	415
39	415
20	416
35	416
50	416
55	416
57	416
9	417
5	417
5	418
30	418
18	419
5	419
19	419
5	420
18	420
27	420
44	420
54	421
48	421
57	421
17	422
37	422
62	422
15	424
32	424
9	425
27	425
1	426
19	426
3	427
64	427
11	428
27	428
51	429
55	429
62	429
38	429
54	429
15	430
20	430
21	430
9	431
13	432
27	432
15	433
21	433
27	436
13	437
27	437
29	438
48	438
18	438
51	438
54	438
58	438
9	439
27	439
27	440
29	440
19	441
7	441
31	441
\.


--
-- Data for Name: _InterestGroupToLobbyOrganization; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."_InterestGroupToLobbyOrganization" ("A", "B") FROM stdin;
63	4
16	118
57	61
107	2
74	12
98	17
8	22
59	42
63	3
58	60
56	119
44	122
84	121
51	11
18	62
106	43
75	79
26	8
12	123
59	9
25	18
3	124
81	40
4	64
108	63
3	24
3	23
3	25
3	13
5	125
81	41
3	66
12	126
4	98
6	65
12	127
68	128
33	69
6	129
70	67
33	68
68	70
53	130
43	71
49	132
54	131
131	131
1	133
12	72
41	135
65	135
12	73
54	134
4	74
59	136
3	14
68	16
4	15
33	77
53	76
78	138
105	138
54	137
53	78
25	139
25	165
12	164
15	164
50	140
67	141
122	191
15	166
52	143
44	192
19	142
27	167
43	168
53	194
59	145
41	169
54	169
60	144
7	195
63	170
19	146
99	147
3	19
4	171
6	172
45	173
13	199
4	20
9	150
59	149
41	197
6	174
44	202
3	200
59	148
27	218
6	175
63	201
68	220
79	220
66	152
27	221
78	151
44	176
89	153
33	177
50	223
3	181
50	229
44	274
15	230
31	182
1	158
12	159
146	159
2	250
41	231
13	183
5	232
65	160
27	184
51	275
41	161
12	233
3	186
41	162
3	251
66	251
29	234
131	187
26	163
52	235
27	206
62	276
131	188
66	277
51	236
60	278
33	190
44	237
3	252
35	279
58	238
4	302
3	322
2	239
35	281
3	207
12	303
38	240
39	240
5	282
44	208
5	304
62	283
33	241
63	305
13	284
60	242
42	306
1	285
59	243
70	287
33	244
18	307
18	308
42	246
57	246
4	323
15	309
9	247
27	324
9	248
1	288
15	310
1	343
8	325
41	325
95	311
2	289
27	326
83	312
23	209
59	344
4	327
40	290
12	253
4	328
12	210
146	314
19	345
3	329
19	315
84	291
5	346
59	346
30	211
63	316
98	347
19	332
42	332
27	212
6	254
57	292
15	317
48	333
18	349
68	348
19	213
19	318
51	318
42	334
68	293
1	255
42	335
10	214
27	214
18	350
52	319
59	336
65	294
66	294
60	215
57	338
4	295
6	353
105	256
57	339
5	320
42	370
62	216
71	341
104	258
59	363
5	260
18	299
18	300
41	426
17	458
18	457
3	419
59	472
53	49
87	480
42	490
42	106
51	497
12	58
15	82
5	30
12	97
2	429
42	506
58	520
26	535
44	550
19	544
123	554
26	561
57	588
82	595
59	620
54	611
53	638
54	637
3	652
74	654
26	682
86	683
53	675
92	678
63	719
59	725
29	758
51	759
52	759
3	773
104	776
38	802
18	799
13	815
33	815
13	817
57	831
78	837
27	851
78	851
32	860
42	875
33	884
56	896
23	912
70	924
23	927
48	946
56	964
49	951
3	985
42	978
72	997
54	996
19	1024
41	1021
65	1032
29	1039
59	1067
111	1065
33	1108
123	1121
26	1127
51	1152
15	1130
36	1161
6	1182
60	1196
12	1208
111	1215
87	1237
16	1240
42	1248
20	1249
77	1300
96	1300
32	1268
56	1308
27	1289
85	1289
29	1343
30	1343
120	1345
19	1320
27	1366
12	1333
146	1333
15	1362
32	1390
54	1408
31	1395
44	1340
68	1427
12	1181
125	1444
13	1466
14	1466
84	1450
18	1493
12	1494
51	1516
107	1517
38	1533
78	1530
60	1538
61	1550
19	1585
53	1575
78	1595
111	1609
92	1619
82	1632
18	1640
41	1558
98	1657
12	1670
103	1670
28	1669
58	1697
41	1693
25	1717
12	1728
12	1736
73	1757
52	1768
66	1772
111	1772
55	1796
80	1796
85	1803
41	1818
63	1818
53	1828
78	1847
125	1847
60	1857
65	1866
42	1859
63	1887
18	1893
59	1928
13	1923
61	1944
92	1932
58	1981
93	1981
16	1951
87	1991
31	1993
29	2030
107	2031
107	2034
19	2050
107	2038
89	2062
136	2062
16	2112
85	2066
14	2084
102	2120
47	2123
19	2103
107	2103
71	2166
54	2127
5	2173
23	2138
85	2222
103	2222
36	2179
20	2227
20	2228
141	2256
18	2208
19	2262
12	2274
19	2278
121	2281
44	2395
3	2333
41	2368
13	2369
26	2369
63	2349
23	2345
125	2382
19	2355
63	2406
33	2391
27	2413
28	2413
43	2460
56	2503
47	2470
135	2425
70	2508
25	2482
44	352
68	340
57	377
60	5
12	387
16	459
77	462
26	448
54	104
26	501
59	501
108	27
3	422
47	523
50	547
29	553
38	598
5	610
6	630
12	648
90	680
19	705
2	745
33	753
41	798
126	810
19	821
50	832
18	852
3	890
23	908
23	931
48	945
52	974
59	974
106	1003
65	1030
2	1056
51	1093
57	1066
12	1126
146	1126
29	1148
18	1133
12	1200
52	1218
62	1256
13	1232
133	1285
19	1323
94	1292
13	1365
44	1365
54	1381
145	1381
18	1397
32	1402
13	1429
126	1446
51	1476
20	1491
78	1522
66	1545
26	1568
102	1594
23	1608
18	1624
98	1656
15	1671
79	1671
10	1706
12	1715
23	1740
106	1765
19	1794
33	1820
23	1845
27	1870
33	1902
66	1902
2	1912
85	1912
19	1915
51	1915
59	1974
66	1953
58	1979
101	2046
13	2026
94	2026
71	2094
143	2094
62	2069
85	2069
12	2160
23	2146
35	2131
10	2176
116	2245
105	2230
108	2210
85	2216
60	2270
132	2364
29	2343
12	2401
33	2388
31	2411
23	2466
78	2466
97	2466
32	2423
18	2543
44	2518
60	2440
122	2553
146	2607
54	2663
53	2673
19	2636
107	2636
19	2762
67	2814
70	2781
20	2789
40	2745
106	2826
12	2881
78	2881
27	2844
7	2903
26	2862
20	2967
76	2977
24	2957
19	3008
107	3008
60	2997
52	3123
50	3018
94	3024
30	3111
52	3197
14	3175
58	3217
126	3192
58	3195
20	3287
65	3057
78	2589
42	2016
20	3303
15	3337
44	3348
33	3368
60	3368
41	3380
63	3425
92	3442
88	3455
70	3480
40	3501
66	3525
111	3525
19	3576
13	3540
136	3540
42	3626
146	3637
12	3659
42	3684
143	3567
56	3708
51	3701
15	3750
139	3781
71	3788
44	3826
139	3856
19	3911
27	3895
16	3935
68	3964
67	3983
48	3878
26	4003
108	4015
67	4067
12	4092
85	4108
41	4103
16	4142
19	4165
66	4186
135	4204
18	4217
62	4217
12	4251
146	4251
55	4277
148	4292
29	4324
29	4336
60	4353
36	4375
79	4398
58	4425
85	4453
144	4466
98	4480
92	4510
94	4538
1	4559
26	4579
46	4579
85	4609
86	4634
86	4655
85	4672
82	4692
18	321
16	296
36	296
19	376
50	394
52	394
55	403
23	450
26	446
5	101
15	105
79	108
33	83
53	83
51	369
57	529
122	539
3	565
7	596
60	606
12	633
23	656
91	679
29	694
30	694
59	723
33	751
57	750
35	779
41	814
27	830
78	848
29	874
23	900
35	893
24	937
52	968
18	990
78	1012
78	1007
52	1033
107	1105
49	1109
68	1134
33	1118
36	1118
12	1185
48	1141
12	1193
94	1206
35	1227
96	1304
44	1341
33	1349
121	1371
25	1375
31	1401
66	1420
56	909
32	1472
31	1480
18	1518
42	1539
41	1555
26	1583
138	1605
23	1564
79	1655
2	1674
27	1695
67	1707
28	1737
60	1737
38	1755
16	1775
78	1775
27	1799
12	1816
33	1844
130	1869
40	1890
13	1929
106	1929
51	1924
85	1924
23	1973
121	1960
100	2021
108	2047
99	2061
29	2079
23	2118
25	2162
57	2149
16	2154
40	2177
78	2182
98	2273
26	2275
52	2277
139	2329
2	2293
56	2347
125	2383
120	2491
51	2459
5	2469
44	2475
21	2516
40	2436
140	2550
116	2602
3	2661
48	2618
52	2629
58	2685
19	2767
20	2718
38	2729
20	2736
75	2751
102	2828
58	2922
19	2846
55	2856
35	2915
23	2936
23	2944
35	2955
126	3037
126	3115
52	3122
61	3150
10	3130
44	3130
44	3167
32	3171
10	3091
32	1822
96	3248
88	3257
128	3282
107	3221
35	2586
41	2569
20	3304
20	3331
20	3358
14	3369
23	3375
41	3416
78	3435
94	3435
18	3467
41	3479
53	3479
98	3503
43	3527
108	3599
23	3541
62	3628
52	3598
42	3642
78	3678
17	3682
41	3700
58	3731
36	3757
102	3795
1	3811
2	3794
54	3844
73	3729
41	3920
103	3920
19	3910
15	3962
10	3980
139	3859
47	4000
125	4000
58	4022
140	4044
24	4061
12	4085
103	4085
41	4124
99	4139
35	4159
28	4175
42	4175
126	4190
65	4191
66	4191
18	4253
44	4282
70	4282
68	4280
29	4325
52	4339
107	4363
79	4390
95	4406
116	4406
63	4449
41	4460
32	4474
102	4499
82	4525
54	4541
20	4565
10	4597
85	4618
41	4647
77	4670
96	4687
101	4731
3	4715
15	4776
26	4796
59	351
6	354
65	406
3	261
67	404
19	455
18	464
26	447
16	52
42	488
26	110
81	34
12	90
18	516
16	548
50	548
46	560
13	582
6	623
68	634
6	662
2	686
88	716
59	721
12	765
92	782
13	808
20	808
60	826
51	828
91	863
102	891
48	899
48	943
19	961
58	961
3	988
27	988
18	1010
78	1031
49	1038
12	1091
86	1099
51	1116
19	1132
107	1132
5	1164
51	1167
78	1238
13	1231
35	1266
18	1271
60	1274
38	1314
19	1322
10	1383
66	1337
111	1337
38	1422
39	1422
66	1443
111	1443
13	1457
60	1487
50	1506
54	1506
28	1529
31	1548
108	1569
33	1596
51	1616
51	1637
74	1662
18	1684
23	1708
102	1726
10	1750
59	1770
16	1791
41	1814
5	1853
70	1889
121	1916
85	1918
60	1969
69	1965
12	2019
123	2044
85	2058
29	2080
123	2080
23	2119
57	2143
19	2163
38	2156
27	2220
10	2196
59	2196
103	2231
51	2261
85	2267
18	2327
3	2292
125	2375
54	2403
16	2390
12	2415
6	2416
92	2473
13	2544
27	2522
41	2522
56	2534
4	2645
60	2612
55	2672
41	2679
19	2700
47	2707
106	2715
16	2727
63	2792
18	2748
18	2830
58	2830
13	2837
19	2848
19	2912
32	2966
26	2975
79	2982
95	3036
25	3043
67	3070
12	3126
12	3023
23	3027
94	3027
44	3078
102	3202
111	3134
28	3245
85	3256
139	3277
46	3052
35	3062
38	2590
25	3222
58	3294
143	3294
71	3318
80	3350
92	3350
12	3324
44	3391
102	3411
61	3424
126	3424
29	3448
102	3456
19	3490
60	3492
23	3529
18	3602
20	3615
19	3636
18	3547
51	3658
10	3458
103	3458
122	3691
102	3714
71	3737
10	3766
139	3783
42	3818
18	3793
35	3846
107	3890
68	3923
66	3942
10	3963
131	3982
36	3864
121	4011
40	4030
139	4064
71	4072
131	4072
7	4100
117	4125
63	4147
19	4167
70	4183
66	4189
19	4219
41	4242
10	4276
108	4310
60	4293
29	4335
89	4355
122	4379
132	4403
68	4411
27	4429
3	4437
26	4482
138	4504
66	4522
42	4549
115	4570
20	4599
85	4620
85	4629
86	4657
85	4671
3	4716
85	4737
5	203
63	217
15	407
47	414
35	435
27	445
52	474
13	454
20	454
12	489
39	112
13	432
36	433
27	531
50	545
35	563
124	593
38	601
6	628
143	643
5	653
82	699
27	718
42	735
29	762
30	762
103	796
104	775
63	825
74	850
29	873
10	886
32	922
47	947
20	920
54	989
131	989
30	1006
84	1036
2	1055
29	1050
12	1080
41	1145
51	1159
126	1159
54	1184
121	1166
18	1235
21	1264
66	1283
96	1303
47	1327
48	1316
85	1316
33	1368
63	1384
93	1399
93	1413
66	1442
111	1442
51	1459
93	1485
2	1498
57	1498
44	1526
41	1552
36	1563
18	1599
78	1599
106	1574
129	1638
106	1673
18	1689
89	1705
99	1729
16	1752
126	1781
12	1798
33	1819
47	1846
78	1846
136	1856
121	1874
126	1933
12	1920
53	1971
19	1989
34	1999
103	1999
146	1999
20	2004
42	2057
85	2057
71	2093
29	2083
16	2076
23	2183
116	2183
67	2170
4	2139
18	2139
40	2193
60	2200
42	2235
51	2263
20	2360
52	2289
73	2295
125	2377
35	2384
132	2389
33	2457
6	2417
3	2426
60	2432
71	2547
38	2443
23	2601
52	2610
52	2619
18	2631
80	2631
19	2701
89	2711
25	2779
96	2731
4	2795
4	2807
16	2755
19	2755
132	2893
19	2852
19	2908
32	2876
102	2941
54	2950
60	2950
111	3006
7	2993
18	3012
19	3099
66	3021
54	3161
36	3113
88	3185
18	3205
10	3095
53	3239
128	3259
44	3278
14	2578
52	3220
32	2593
19	3050
44	3314
67	3345
49	3366
88	3386
107	3401
115	3401
15	3429
79	3429
123	3445
18	3468
103	3495
9	3535
33	3558
12	3539
146	3539
124	3584
63	3635
36	3641
140	3651
79	3571
99	3663
89	3738
36	3755
89	3791
1	3809
85	3836
54	3850
27	3885
140	3916
59	3927
12	3946
18	3970
79	3987
82	3834
58	4012
52	4032
67	4060
53	4075
73	4075
41	4087
2	4130
63	4146
116	4156
102	4136
135	4202
3	4244
12	4243
58	4265
41	4291
29	4326
52	4344
103	4360
21	4382
95	4405
116	4405
27	4445
18	4462
53	4486
12	4492
54	4533
4	4551
107	4578
139	4594
85	4621
20	4645
35	228
12	355
13	364
14	364
3	384
20	438
106	438
58	268
48	270
10	103
16	59
54	91
13	368
43	527
13	519
20	519
19	538
20	581
6	614
6	616
60	669
31	661
51	706
91	728
26	770
20	794
60	811
56	824
19	842
33	867
12	895
53	911
23	928
136	960
19	977
59	977
30	1009
78	1020
66	1037
118	1063
33	1119
36	1119
58	1146
29	1160
123	1160
44	1165
12	1190
44	1204
28	1263
123	1281
96	1302
31	1330
15	1348
98	1354
50	1386
51	1386
126	1386
31	1407
29	1415
20	1437
50	1447
51	1478
138	1509
27	1528
78	1528
41	1557
78	1591
20	1613
82	1633
128	1659
79	1679
12	1672
25	1718
41	1735
78	1761
54	1777
15	1806
79	1806
39	1821
47	1850
78	1850
33	1877
32	1906
85	1906
13	1936
16	1957
48	1987
100	2020
123	2045
103	2007
16	2110
39	2068
57	2142
59	2147
16	2155
19	2158
103	2226
60	2201
108	2211
139	2211
46	2218
85	2218
16	2284
44	2397
14	2342
12	2350
89	2310
79	2456
4	2418
20	2511
23	2433
18	2439
36	2536
21	2605
24	2662
103	2662
58	2624
54	2681
44	2706
107	2772
60	2782
16	2735
66	2800
12	2810
18	2834
27	2894
94	2926
13	2913
58	2968
26	2943
106	3032
79	3038
103	3045
66	3121
78	3148
63	3104
42	3110
16	3186
139	3090
20	3135
54	3139
26	3266
12	3281
85	2557
63	3060
13	3226
56	3292
20	3307
48	3352
15	3334
20	3403
41	3417
26	3431
10	3460
98	3470
62	3519
21	3528
26	3589
126	3607
92	3595
108	3595
78	3640
65	3657
42	3685
66	3690
27	3712
15	3735
2	3758
78	3758
12	3785
1	3805
44	3829
67	3740
13	3901
132	3907
42	3936
95	3936
53	3967
54	3981
60	3981
85	3831
117	4004
116	4021
85	3830
24	4062
67	4062
5	4095
85	4123
63	4140
4	4149
35	4164
54	4203
79	4225
103	4225
18	4260
70	4286
76	4304
63	4313
74	4313
61	4343
60	4368
111	4383
85	4400
58	4427
60	4456
49	4481
103	4497
66	4526
67	4543
77	4567
26	4592
23	4615
86	4639
25	4665
77	4673
84	4706
61	4735
92	4735
101	4735
15	4770
66	4770
6	180
27	257
48	378
1	411
6	411
24	449
21	452
10	478
85	273
38	502
39	502
59	116
10	88
59	521
27	532
4	572
21	591
6	622
65	649
93	670
89	677
12	717
6	715
12	771
16	777
35	805
2	742
133	835
57	855
10	887
79	905
18	942
48	948
107	970
59	993
23	1019
102	1042
29	1069
123	1069
2	1058
25	1089
79	1135
36	1162
66	1176
111	1176
54	1213
78	1239
122	1224
33	1267
96	1305
36	1312
122	1295
81	1355
27	1363
31	1400
50	1405
41	1432
23	1451
19	1475
2	1499
57	1499
59	1519
66	1546
65	1566
66	1566
13	1587
59	1601
60	1622
63	1641
12	1664
18	1690
42	1713
68	1713
33	1732
93	1732
19	1769
18	1795
85	1807
4	1843
27	1868
130	1868
33	1899
66	1899
19	1927
60	1938
23	1972
23	1988
103	2001
12	2049
132	2039
19	2113
18	2073
19	2107
57	2150
33	2187
53	2187
70	2178
48	2225
52	2272
12	2214
33	2322
16	2285
18	2366
125	2371
3	2301
31	2387
32	2387
40	2493
52	2499
103	2541
63	2480
24	2519
68	2519
120	2490
133	2446
106	2649
51	2615
19	2693
19	2633
58	2686
19	2764
39	2719
12	2784
44	2740
20	2750
20	2811
20	2839
59	2925
70	2857
91	2864
19	2999
26	2976
20	2954
12	2992
12	3068
146	3068
51	3124
107	3128
66	3073
67	3073
139	3168
106	3081
61	3208
20	3136
13	3141
41	3269
129	3269
39	3241
8	2575
41	2575
65	2010
66	2010
27	3223
18	2571
140	3312
35	3343
60	3364
16	3378
40	3384
108	3384
60	3423
100	3423
20	3440
12	3463
146	3463
41	3481
139	3484
45	3523
53	3588
105	3588
60	3608
66	3608
12	3543
146	3543
12	3621
20	3548
107	3667
100	3569
51	3710
73	3734
67	3746
63	3790
1	3820
85	3839
26	3855
90	3855
130	3898
41	3905
129	3905
19	3931
6	3948
66	3978
139	3860
60	4001
23	4027
12	4035
53	4035
53	4040
12	4083
146	4083
20	4088
103	4088
74	4117
20	4120
1	4172
78	4172
2	4134
63	4214
62	4227
23	4262
91	4288
33	4303
31	4328
52	4345
92	4372
74	4394
20	4410
57	4428
59	4461
23	225
48	374
19	379
60	401
19	456
6	463
52	475
42	487
42	503
33	32
41	424
43	524
29	555
48	573
72	594
69	617
12	632
18	658
60	676
2	689
108	727
5	760
29	767
19	792
58	790
108	834
131	857
10	888
23	907
26	930
48	954
49	954
27	972
12	991
19	1014
54	1046
23	1070
12	1078
2	1060
127	1153
29	1171
93	1198
20	1202
19	1246
60	1246
35	1278
96	1297
38	1310
54	1293
85	1293
35	1377
44	1385
42	1234
31	1412
59	1440
78	1464
20	1492
57	1500
63	1535
117	1553
78	1592
20	1600
82	1621
19	1648
2	1675
18	1688
146	1688
42	1714
68	1714
60	1733
16	1760
95	1783
111	1783
15	1800
92	1826
19	1848
94	1892
130	1907
29	1942
60	1956
48	1986
78	1967
107	2042
48	2052
49	2052
70	2096
85	2099
72	2087
18	2148
10	2136
117	2189
10	2197
65	2234
63	2213
18	2264
20	2362
127	2362
63	2365
107	2372
27	2402
60	2402
139	2316
20	2454
41	2461
47	2471
58	2476
35	2483
78	2483
18	2438
19	2438
92	2445
51	2646
76	2659
111	2659
107	2621
19	2695
25	2642
52	2769
66	2722
143	2788
20	2744
60	2824
38	2833
60	2891
19	2900
19	2928
32	2874
54	2940
12	2951
120	2958
10	2963
10	3096
123	3143
116	3155
144	3155
42	3164
3	3131
19	3132
107	3212
19	3246
20	3240
13	3275
42	3290
46	3054
1	3063
4	3063
13	3065
15	3297
41	3326
67	3346
12	3336
40	3379
68	3407
117	3426
29	3447
70	3471
70	3496
44	3532
49	3449
122	3605
139	3617
60	3634
42	3647
20	3665
28	3675
58	3675
79	3692
53	3713
5	3732
128	3764
122	3786
42	3819
85	3837
2	3866
41	3887
20	3892
32	3909
15	3958
29	3874
30	3874
63	3858
55	3993
108	4014
54	4043
66	4068
67	4068
3	4076
139	4101
30	4138
85	4153
28	4174
143	4187
77	4221
18	4248
66	4264
92	4309
29	4318
20	4334
108	4354
132	4354
92	4374
108	4404
5	4419
66	4455
106	4469
62	4493
48	4507
55	4539
1	4560
115	4560
41	4581
133	4589
85	4631
77	4668
85	4688
92	4733
35	4742
15	4765
55	4787
97	204
102	360
53	298
67	415
34	436
31	420
53	50
87	272
52	496
54	81
52	495
81	35
26	528
43	526
41	567
135	589
54	590
15	627
42	655
5	688
42	703
23	701
3	730
27	730
46	781
33	807
123	819
107	841
72	868
78	868
53	878
23	913
102	936
52	959
68	981
20	1000
40	1026
53	1044
59	1076
1	1112
51	1151
51	1149
123	1175
94	1214
9	1222
62	1261
12	1282
146	1282
52	1306
60	1342
27	1351
60	1361
32	1389
50	1410
68	1428
5	956
57	1470
51	1469
49	1501
31	1534
85	1560
54	1578
54	1588
94	1588
42	1631
130	1642
35	1681
55	1703
60	1723
89	1751
135	1771
40	1790
68	1813
12	1838
47	1851
78	1851
13	1898
85	1921
133	1931
60	1968
58	1976
107	1995
69	2041
48	2053
107	2040
129	2116
43	2121
59	2129
5	2174
66	2221
13	2249
13	2203
74	2260
18	2268
25	2288
29	2341
20	2298
56	2304
53	2452
65	2414
66	2414
26	2502
60	2502
20	2510
42	2481
106	2520
38	2444
47	2603
7	2611
63	2670
41	2680
19	2698
86	2708
19	2773
59	2785
18	2820
10	2804
5	2832
51	2886
10	2902
131	2906
32	2868
19	2935
107	2947
60	3004
12	2990
146	2990
87	3011
106	3015
121	3019
13	3159
60	3076
19	3188
23	3177
29	3215
20	3251
19	3233
35	3280
25	3181
66	2561
35	3061
117	3291
127	3305
20	3341
21	3365
20	3371
12	3389
16	3381
41	3381
24	3404
44	3451
10	3482
139	3516
19	3538
58	3575
85	3591
66	3614
92	3596
108	3596
10	3587
12	3652
79	3572
2	3705
5	3742
26	3761
90	3761
12	3784
1	3804
36	3827
75	3851
139	3900
28	3906
95	3938
54	3957
68	3975
18	3990
19	3999
108	4016
24	4036
41	4079
3	4078
20	4116
63	4144
12	4170
16	4180
41	4180
135	4194
41	4224
16	4256
53	4256
25	4284
44	4290
74	4308
62	4338
66	4359
19	4378
13	4388
58	4424
102	4454
14	4470
3	4491
82	4509
54	4537
1	4555
115	4555
77	4574
23	4607
86	4633
23	4648
124	4683
107	4695
96	4713
15	4769
41	4778
39	4754
26	4804
61	4804
107	4827
59	4844
16	4870
19	4860
27	205
72	388
19	380
13	385
14	443
85	45
100	45
29	51
27	55
26	499
59	499
3	29
16	95
2	509
41	549
33	580
60	599
12	608
2	621
57	621
12	640
67	659
12	698
146	698
59	724
103	754
104	774
4	788
51	816
33	836
44	853
12	876
56	914
30	918
16	919
42	934
6	994
111	1035
93	1053
2	1057
14	1098
18	1137
46	1170
128	1197
59	1142
18	1241
88	1276
123	1253
19	1273
36	1313
23	1352
43	1373
54	1398
118	1398
78	1404
123	1435
25	1448
49	1474
18	1503
78	1521
51	1547
52	1547
65	1565
66	1565
78	1593
82	1614
44	1635
68	1658
87	1678
27	1709
78	1709
94	1724
138	1747
26	1773
74	1792
12	1817
4	1842
44	1858
63	1886
54	1922
26	1943
18	1963
15	1952
79	1952
102	1952
100	1998
107	2033
107	2037
16	2115
58	2101
19	2108
60	2184
12	2153
54	2140
81	2194
14	2252
6	2236
88	2242
121	2282
19	2338
29	2344
6	2354
56	2354
90	2386
20	2455
32	2500
19	2472
70	2428
18	2485
48	2530
43	2448
25	2609
43	2666
89	2676
20	2641
18	2763
19	2763
52	2774
19	2726
102	2822
12	2801
32	2878
132	2892
139	2895
23	2858
27	2858
20	2930
79	2969
51	2945
126	3034
66	3040
87	3047
19	3098
48	3127
20	3105
42	3165
51	1839
35	3176
15	3218
79	3252
19	3196
85	3286
85	2555
10	3064
44	2014
20	3299
4	3325
16	3356
7	3323
30	3394
115	3394
18	3413
60	3434
96	3452
12	3477
106	3518
16	3537
59	3562
60	3612
6	3544
41	3646
42	3643
12	3679
146	3679
143	3566
51	3702
59	3702
44	3717
18	3753
41	3774
53	3774
1	3803
88	3792
54	3843
18	3912
68	3924
58	3940
26	3873
90	3873
59	3876
1	3817
115	4010
108	4025
12	4038
14	4073
54	4045
60	4045
24	4104
85	4152
69	4173
59	4137
68	4208
67	4247
27	4258
143	4278
49	4213
35	4317
61	4340
103	4361
61	4385
60	4412
19	4426
27	4458
59	4458
59	4472
91	4472
102	4478
2	4516
63	4542
27	4564
78	4591
85	4613
86	4640
82	4663
32	4675
85	4675
3	4718
3	4720
41	4745
143	4745
26	4791
41	154
101	297
64	259
18	6
5	417
16	461
18	466
51	271
42	491
4	80
59	115
80	87
53	508
26	536
29	559
67	584
93	584
54	576
51	619
50	647
52	647
44	672
15	695
3	714
58	755
2	747
38	803
83	786
59	722
10	843
10	871
27	871
6	889
99	921
88	941
51	967
41	986
78	1013
53	1041
64	1062
71	1064
60	1079
66	1079
13	1114
20	1114
26	1158
89	1158
5	1163
12	1207
15	1207
92	1219
52	1258
33	1250
85	1286
19	1325
15	1346
54	1367
60	1367
33	1372
85	1406
32	1416
31	1436
51	1436
51	1461
123	1471
41	1502
78	1523
41	1559
117	1586
146	1611
57	1630
19	1647
16	1677
104	1700
10	1698
60	1749
132	1749
78	1774
134	1797
60	1805
20	1840
57	1867
27	1897
70	1891
130	1934
107	1948
20	1983
57	1997
94	2023
100	2027
148	2092
19	2117
1	2075
120	2167
6	2157
68	2157
18	2243
20	2251
85	2257
3	2241
19	2359
10	2396
101	2296
12	2300
13	2300
88	2309
12	2408
116	2495
36	2537
89	2509
74	2430
23	2487
35	2487
18	2549
4	2643
76	2658
54	2671
60	2671
42	2696
18	2702
19	2770
12	2816
33	2732
60	2741
12	2802
19	2756
3	2923
24	2923
19	2850
18	2911
35	2919
102	2971
102	2980
79	3035
20	2964
12	3069
146	3069
59	3101
99	3022
61	3108
88	3184
60	3199
61	3211
89	3138
85	3250
58	3270
85	3242
16	3056
4	2012
100	2015
15	3295
70	3319
15	3347
56	3330
115	3395
120	3410
20	3415
93	3441
139	3464
20	3489
38	3521
139	3485
9	3600
85	3582
41	3618
136	3639
78	3660
58	3676
58	3574
4	3699
10	3716
41	3716
20	3718
86	3762
86	3798
12	3807
85	3840
20	3880
19	3899
27	3922
12	3933
78	3961
99	3875
27	3815
31	3723
78	4020
66	4052
41	4041
53	4041
70	4094
66	4047
85	4105
126	4154
70	4158
19	4192
65	4192
67	4198
34	4252
49	4212
51	4296
29	4320
19	4346
29	4364
122	4364
66	4389
92	4415
27	4442
82	4442
79	4464
3	4487
82	4506
12	4527
146	4527
2	4514
111	4563
58	4580
133	4588
85	4622
137	4642
10	3814
6	178
19	372
116	390
4	383
43	265
14	44
6	100
46	53
52	493
59	493
52	31
57	117
59	423
20	517
26	542
35	564
5	578
19	604
3	612
78	650
92	673
2	691
70	635
48	740
2	746
31	784
27	812
70	827
42	846
10	870
35	894
23	903
1	923
97	923
48	949
4	979
68	979
44	1001
23	1025
29	1051
59	1071
16	1122
51	1115
52	1115
44	1131
60	1138
10	1216
35	1229
27	1225
18	1252
80	1307
31	1329
19	1318
55	1379
30	1387
31	1393
16	1419
40	1434
40	1455
32	1479
19	1508
60	1527
31	1549
79	1561
12	1573
27	1573
57	1628
106	1654
41	1666
4	1686
44	1711
20	1727
74	1754
41	1787
54	1808
60	1808
93	1833
105	1864
18	1883
42	1911
85	1911
31	1914
19	1950
19	1966
42	2018
102	2048
47	2056
16	2078
29	2082
122	2082
1	2122
97	2122
44	2168
5	2172
117	2190
116	2246
103	2232
92	2212
51	2266
44	2328
139	2336
128	2398
23	2351
19	2357
82	2357
12	2393
36	2538
72	2540
106	2429
35	2486
28	2595
19	2688
51	2613
102	2669
62	2677
20	2684
5	2813
19	2717
20	2728
44	2739
18	2747
19	2757
74	2841
24	2924
106	2904
20	2916
66	2937
19	2979
52	2984
14	2961
41	3116
12	3125
130	3152
20	3106
3	3028
19	3187
65	3174
42	3214
32	3244
26	3265
14	3276
60	3276
12	2556
63	3219
66	2009
4	2572
41	2572
107	3309
15	3327
12	3351
60	3372
115	3397
41	3414
66	3427
10	3459
103	3459
20	3488
66	3512
19	3551
58	3551
139	3487
60	3610
42	3625
103	3620
42	3644
107	3666
26	3653
102	3693
51	3709
66	3745
18	3765
49	3796
1	3810
85	3838
2	3868
125	3728
28	3903
18	3926
27	3959
12	3976
46	3991
41	3883
108	4013
131	4034
10	4066
53	4091
39	4110
41	4115
18	4143
35	4163
18	4184
103	4200
41	4223
102	4241
3	4281
32	4294
48	4307
125	4332
19	4350
12	4367
85	4397
12	4423
146	4423
19	4451
70	4433
53	4488
116	4488
82	4508
44	4535
1	4557
115	4557
58	4577
44	4552
54	4632
85	4612
12	4598
20	4598
92	4727
105	4741
41	4746
27	249
10	356
12	405
73	263
3	264
12	264
59	469
52	473
2	484
52	494
4	28
7	85
23	39
58	522
47	557
73	577
9	597
69	618
32	636
12	644
66	684
48	707
51	704
33	752
60	752
13	800
20	800
19	804
46	829
44	847
12	858
20	879
42	897
1	933
19	962
52	962
3	982
65	1004
78	1015
12	1054
53	1092
105	1092
13	1111
35	1154
111	1154
51	1150
116	1008
82	1212
26	1203
126	1203
13	1230
66	1284
2	1288
85	1288
31	1328
32	1350
54	1380
42	1179
32	1394
12	1418
59	1441
50	1454
51	1460
78	1513
58	1531
50	1562
82	1579
123	1580
51	1620
126	1651
28	1668
35	1680
102	1720
38	1730
19	1763
126	1780
85	1804
94	1804
19	1832
92	1860
103	1872
2	1910
85	1910
41	1935
23	1947
23	1958
51	1994
13	2022
44	2006
40	2091
29	2081
19	2102
44	2169
40	2175
71	2175
85	2192
10	2199
27	2199
13	2205
18	2238
13	2321
4	2331
52	2290
12	2373
59	2353
26	2311
70	2492
14	2462
4	2419
54	2477
60	2477
23	2484
54	2529
55	2529
122	2552
58	2650
26	2664
19	2694
73	2697
57	2765
15	2777
19	2783
59	2794
23	2749
19	2831
44	2831
20	2840
70	2898
120	2927
55	2867
79	2970
19	2946
71	2956
129	3009
92	3044
23	3071
67	3071
38	3151
146	3158
20	3166
48	1831
105	1831
60	3178
59	3216
57	3249
79	3258
58	3271
122	2554
41	3247
5	2588
32	2570
12	3301
48	3320
58	3320
66	3357
18	3355
102	3390
94	3419
20	3405
10	3462
103	3494
41	3515
107	3550
12	3577
146	3577
60	3609
63	3627
23	3619
66	3585
19	3664
42	3686
4	3695
53	3715
54	3739
60	3739
36	3756
18	3773
42	3801
96	3797
2	3867
35	3847
19	3915
32	3925
12	3945
12	3953
18	3877
2	3865
26	4002
58	4028
66	4054
139	4063
3	4077
18	4114
60	4141
116	4155
47	4176
89	4206
26	4231
139	4271
10	4267
18	4295
58	4295
29	4319
32	4341
92	4366
106	4380
108	4408
10	4432
63	4465
19	4473
106	4500
2	4513
68	4530
1	4561
115	4561
133	4590
23	4616
86	4638
148	4654
85	4677
12	224
13	358
20	358
62	409
7	402
16	460
29	269
42	481
12	56
36	504
54	92
30	94
2	511
50	543
41	566
54	602
131	602
6	624
41	646
8	663
20	681
3	713
51	729
18	749
68	778
35	809
65	696
129	840
72	869
78	869
35	892
8	917
33	938
60	938
103	955
88	980
116	980
23	1017
32	1034
93	1034
54	1045
60	1045
28	1090
93	1090
49	1110
62	1144
66	1168
108	1195
26	1201
50	1221
49	1262
1	1280
19	1287
85	1287
96	1311
15	1347
18	1369
25	1374
51	1391
32	1417
20	1438
40	1456
13	1458
41	1504
136	1524
65	1542
66	1542
65	1567
66	1567
19	1584
51	1584
82	1615
12	1634
4	1661
133	1685
107	1692
66	1722
111	1722
18	1746
31	1764
54	1764
79	1793
41	1815
44	1827
78	1855
111	1896
85	1909
12	1919
143	1946
20	1982
58	1978
123	2043
19	2054
85	2054
33	2064
60	2064
57	2070
148	2088
54	2165
55	2165
60	2186
16	2181
3	2229
18	2206
78	2206
26	2276
26	2323
20	2363
4	2337
128	2400
125	2378
56	2385
19	2409
36	2539
86	2424
20	2478
66	2545
82	2442
4	2598
41	2598
74	2689
52	2617
5	2625
28	2637
36	2703
36	2712
85	2712
66	2723
44	2787
67	2743
12	2803
35	2920
19	2884
19	2899
19	2910
20	2932
12	2974
20	2953
59	2987
12	3041
59	3013
13	3146
16	3156
48	3162
23	3080
32	3198
87	3210
10	3235
19	3194
12	3273
55	3289
33	2576
50	2013
42	2583
8	2566
44	3311
15	3332
128	3362
91	3383
68	3409
60	3421
123	3446
78	3465
70	3497
79	3491
35	3530
35	3603
60	3611
102	3633
72	3586
99	3670
42	3688
12	3694
57	3721
128	3763
63	3776
1	3802
40	3813
5	3741
12	3870
40	3893
4	3908
18	3960
4	3974
36	3863
55	3994
70	4017
103	4017
3	4058
12	4089
49	4098
32	4048
78	4118
35	4160
74	4168
78	4193
63	4230
18	4261
62	4261
94	4274
27	4305
59	4305
31	4323
123	4347
19	4371
26	4396
12	4413
12	4446
68	4434
63	4483
103	4501
63	4532
139	4548
82	4571
116	4571
18	4596
1	4554
115	4554
86	4635
86	4656
53	4678
85	4678
3	227
79	342
5	391
6	262
3	427
59	468
10	476
2	486
12	57
96	113
13	33
42	421
19	515
50	546
5	551
79	586
60	605
6	629
3	665
1	666
47	702
59	726
15	748
78	732
111	801
65	793
66	793
108	833
16	859
60	880
23	904
12	926
4	944
32	969
41	987
78	1016
66	1027
111	1027
67	1061
23	1104
36	1120
26	1143
121	1147
44	1187
15	1189
58	1228
49	1257
68	1265
80	1301
19	1324
15	1344
19	1321
93	1233
31	1396
51	1396
66	1339
111	1339
13	1431
29	1445
122	1445
79	1477
32	1505
49	1520
61	1551
33	1570
19	1598
84	1603
10	1636
4	1660
18	1682
6	1710
102	1725
116	1766
121	1789
40	1788
20	1830
49	1863
48	1881
125	1881
55	1875
31	1930
50	1930
19	1949
23	1964
46	1961
107	2032
107	2036
29	2077
48	2067
85	2067
51	2085
135	2144
12	2130
5	2171
123	2141
23	2224
63	2224
13	2202
18	2258
12	2280
5	2283
60	2339
12	2374
19	2356
35	2453
79	2394
27	2468
71	2468
116	2507
65	2479
15	2546
71	2548
54	2451
89	2651
12	2616
65	2623
66	2638
18	2705
52	2771
106	2817
125	2734
66	2799
12	2809
20	2882
68	2843
19	2851
131	2860
20	2931
12	2938
118	2948
60	3007
38	3010
66	3118
13	3144
31	3144
15	3154
53	3163
23	3170
32	3201
59	3204
18	3237
19	3230
60	3234
44	3274
20	3180
79	3059
42	2582
53	2582
18	2565
79	3300
56	3333
136	3360
33	3370
10	3392
78	3402
27	3382
79	3450
12	3469
20	3504
13	3553
118	3531
99	3604
20	3624
67	3597
42	3648
106	3671
42	3687
5	3703
66	3736
44	3751
143	3779
146	3800
42	3821
58	3854
79	3888
121	3894
28	3929
18	3947
68	3973
93	3988
39	3992
12	3997
146	3997
12	4018
139	4065
41	4080
25	4096
23	4122
5	4049
10	4121
54	4177
135	4195
53	4220
138	4220
12	4255
102	4255
78	4287
35	4315
78	4315
102	4301
52	4351
59	4351
19	4370
58	4370
59	4392
91	4392
12	4409
4	4440
55	4448
32	4485
103	4502
38	4528
27	4547
23	4575
20	4593
18	4617
85	4614
77	4667
86	4682
60	4680
43	179
19	375
67	408
74	413
5	434
35	451
76	365
2	485
2	500
59	26
106	93
2	428
12	534
29	556
4	571
41	575
6	626
18	645
3	668
1	667
48	708
57	744
83	761
100	761
27	769
41	813
65	697
61	838
108	838
100	854
20	877
56	910
4	925
49	952
42	966
26	998
66	998
18	1011
32	1048
12	1095
105	1095
122	1100
23	1128
46	1169
57	1194
14	1210
18	1236
49	1259
1	1279
51	1254
42	1290
85	1290
65	1294
98	1353
51	1178
66	1336
111	1336
85	1421
41	1433
23	1453
51	1465
122	1465
53	1507
61	1525
29	1541
123	1541
68	1572
27	1612
38	1617
29	1646
29	1676
18	1691
53	1719
35	1739
13	1758
31	1785
41	1812
78	1837
12	1861
33	1876
15	1888
107	1941
85	1925
18	1959
33	1996
20	2003
42	2059
16	2114
33	2074
36	2074
1	2124
97	2124
20	2151
10	2133
139	2133
29	2219
116	2248
71	2253
57	2215
33	2269
29	2335
2	2294
13	2299
33	2305
102	2407
33	2494
16	2501
13	2542
14	2515
106	2521
66	2551
138	2647
12	2614
52	2620
41	2678
58	2760
135	2709
49	2775
7	2818
20	2791
54	2805
32	2877
13	2835
61	2896
23	2905
18	2929
41	2933
107	2978
130	3005
54	2988
66	2996
139	3120
29	3147
47	3147
12	3157
79	3075
3	3182
43	3133
25	1825
18	3236
105	3142
146	3260
58	3051
102	2559
54	2585
135	2594
58	3293
67	3316
4	3344
19	3361
60	3373
115	3399
29	3420
87	3436
5	3454
54	3475
41	3502
44	3526
106	3559
59	3563
67	3563
59	3564
67	3564
60	3632
13	3650
41	3650
20	3672
66	3570
56	3707
73	3730
54	3752
19	3768
51	3770
1	3812
27	3848
13	3869
28	3902
36	3871
42	3937
95	3937
35	3965
26	3984
85	3832
121	4006
40	4031
63	4037
41	4081
85	4111
2	4131
85	4107
42	4171
16	4181
49	4215
144	4245
18	4250
63	4285
60	4311
29	4329
65	4348
78	4369
126	4391
26	4417
103	4443
59	4447
49	4477
103	4498
80	4529
2	4515
14	4566
33	4566
27	4605
85	4624
49	4652
77	4664
96	4689
84	4707
96	4707
4	4760
13	4696
26	4794
85	4752
65	157
13	361
27	382
74	416
30	442
3	465
20	453
42	482
42	107
14	367
35	367
38	431
19	477
41	533
56	537
73	568
12	579
60	607
6	631
8	613
41	671
89	671
88	692
57	700
42	734
18	772
87	795
85	785
117	818
5	844
29	856
5	881
1	916
2	916
3	916
23	932
5	957
48	976
66	1002
13	1029
29	1052
79	1102
94	1107
32	1124
49	1155
82	1172
29	1199
122	1199
90	1220
51	1205
1	1277
77	1299
96	1299
85	1309
29	1331
19	1317
18	1378
41	1388
66	1338
111	1338
58	1424
85	1424
71	1439
51	1462
60	1497
60	1514
96	1514
135	1536
122	1556
53	1576
33	1610
60	1610
57	1629
19	1650
12	1663
18	1696
68	1712
26	1734
60	1753
116	1753
17	1776
86	1802
137	1823
26	1854
13	1852
14	1852
103	1905
36	1913
19	1962
20	1984
105	1954
103	2002
47	2051
71	2090
26	2098
48	2086
12	2145
60	2185
10	2137
36	2180
4	2198
23	2233
38	2233
133	2233
4	2240
126	2326
19	2287
14	2340
56	2346
23	2381
107	2405
44	2496
33	2467
19	2474
4	2514
23	2437
42	2597
8	2644
12	2660
47	2622
96	2632
54	2683
79	2710
86	2716
38	2730
14	2742
7	2746
18	2829
23	2838
19	2901
63	2855
68	2914
31	2934
56	3001
130	3003
44	2991
42	3046
13	3014
41	3020
135	3025
19	3169
59	3203
44	3093
41	3227
79	3253
94	3267
4	2573
41	2573
12	2558
65	2011
66	2011
31	2564
20	3298
53	3328
20	3342
117	3321
107	3396
115	3396
16	3376
26	3433
35	3444
54	3473
40	3499
12	3522
26	3561
66	3561
42	3590
41	3542
23	3546
41	3655
60	3680
12	3616
63	3711
60	3727
44	3719
91	3767
19	3769
1	3808
27	3849
18	3881
25	3914
28	3921
73	3932
10	3952
66	3979
117	3724
103	4008
108	4024
53	4057
20	4090
12	4099
93	4099
52	4126
85	4106
3	4150
10	4185
44	4201
15	4226
139	4270
62	4279
78	4314
32	4327
29	4337
20	4356
72	4377
38	4402
26	4418
12	4452
33	4467
3	4490
60	4512
12	4534
1	4556
77	4572
85	4610
85	4628
18	4651
77	4661
82	4693
96	4710
5	4763
15	4775
2	155
57	155
18	389
53	381
81	412
59	440
41	444
16	48
68	102
42	492
57	111
59	114
5	96
53	507
43	525
31	558
52	558
54	583
41	600
6	625
54	639
20	657
32	674
131	674
2	709
15	733
35	766
52	791
18	797
19	822
87	839
54	865
3	872
29	915
106	939
48	953
70	935
143	935
61	992
42	1018
79	1040
32	1049
63	1103
29	1113
63	1101
33	1156
41	1183
87	1191
42	1247
60	1275
48	1298
85	1298
49	1272
31	1332
39	1319
75	1382
54	1364
31	1411
12	1430
31	1449
29	1481
19	1510
16	1540
65	1544
66	1544
32	1581
123	1581
12	1589
81	1623
12	1652
4	1665
6	1701
106	1694
33	1731
19	1762
117	1782
12	1801
33	1824
44	1824
4	1841
75	1871
13	1903
23	1903
12	1917
85	1917
33	1945
59	1975
29	1992
29	2029
19	2005
25	2060
103	2060
146	2097
18	2071
148	2089
38	2128
128	2134
23	2191
63	2247
111	2247
23	2254
3	2239
58	2265
18	2286
32	2291
10	2297
103	2302
126	2312
20	2412
5	2498
6	2498
52	2505
41	2512
140	2512
4	2434
38	2531
4	2600
41	2600
138	2690
66	2667
32	2628
54	2682
107	2768
125	2776
12	2786
26	2738
85	2825
78	2880
102	2885
19	2847
19	2909
32	2875
139	2972
111	3002
59	2986
93	2965
144	2965
12	3117
146	3117
78	3016
135	3149
20	3107
12	3112
146	3112
139	3089
14	3094
65	3094
24	3029
12	3255
27	3272
102	3058
33	3055
53	2580
63	2580
42	3067
12	3302
4	3322
15	3340
44	3367
10	3393
10	3385
26	3430
60	3443
132	3443
106	3472
70	3498
52	3534
13	3556
94	3556
66	3579
20	3592
15	3545
42	3649
41	3669
102	3654
4	3696
63	3726
67	3747
63	3777
1	3806
1	3825
32	3845
52	3897
41	3917
18	3928
20	3955
93	3972
68	3816
32	3989
121	4019
52	4033
48	4039
27	4082
85	4109
56	4129
63	4145
35	4162
70	4179
53	4197
12	4218
67	4249
27	4263
28	4268
20	4316
78	4316
76	4302
52	4349
60	4349
54	4358
122	4381
44	4399
143	4438
4	4459
19	4471
12	4494
103	4494
2	4517
122	4540
1	4562
77	4573
65	156
66	156
53	373
52	393
6	398
41	398
13	437
20	437
48	267
66	99
102	54
52	498
99	366
53	86
53	36
53	518
26	552
6	569
38	592
12	609
67	642
3	641
2	687
2	690
12	741
29	764
92	787
58	789
19	823
29	849
4	864
60	882
23	906
59	929
48	950
42	971
4	999
111	1023
32	1047
138	1068
10	1106
52	1123
36	1117
82	1173
12	1188
33	1217
18	1223
23	1226
27	1226
49	1270
39	1291
58	1296
85	1296
79	1177
12	1335
146	1335
32	1409
32	1425
52	963
50	1473
56	1495
108	1515
78	1532
65	1543
66	1543
20	1590
78	1597
57	1625
58	1653
41	1667
12	1699
102	1699
18	1721
44	1741
40	1759
117	1784
18	1809
4	1829
13	1849
14	1849
26	1884
78	1884
119	1895
27	1940
85	1940
85	1926
58	1977
13	1955
20	1955
13	2024
12	2008
42	2063
53	2063
23	2100
19	2105
19	2109
63	2152
15	2188
31	2223
26	2250
60	2255
85	2255
59	2259
53	2217
3	2334
41	2370
125	2376
16	2379
23	2379
35	2379
19	2358
60	2392
107	2392
88	2497
12	2504
85	2427
67	2517
63	2528
32	2599
30	2608
19	2691
33	2675
136	2635
3	2812
12	2815
21	2780
20	2733
57	2797
18	2808
32	2879
41	2842
19	2853
107	2907
20	2918
12	2939
98	2949
16	2959
19	2962
65	3049
66	3072
67	3072
12	3153
41	3153
44	3153
26	3160
82	3077
42	3082
61	3209
52	3238
19	3193
19	3268
49	3283
33	2577
20	3031
132	2592
8	2017
18	3306
24	3317
41	3317
139	3353
67	3315
79	3388
35	3408
13	3432
3	3453
33	3478
146	3517
9	3536
139	3486
60	3606
13	3583
4	3631
146	3623
13	3668
42	3689
56	3706
40	3743
12	3754
53	3775
51	3771
1	3824
85	3842
12	3882
146	3882
60	3891
36	3872
12	3944
71	3956
63	3977
139	3862
61	3996
58	4026
32	4053
24	4069
24	4093
52	4046
2	4132
54	4148
61	4169
41	4182
12	4216
41	4232
41	4259
125	4209
51	4297
66	4300
61	4342
19	4365
132	4384
44	4416
75	4439
63	4457
32	4475
49	4496
103	4496
38	4524
126	4524
54	4544
60	4544
77	4568
119	4586
68	2431
12	2488
54	2535
111	2606
19	2692
65	2674
66	2674
63	2639
18	2761
20	2714
39	2725
10	2793
15	2823
102	2754
87	2890
19	2845
38	2854
39	2854
54	2863
44	2998
25	2942
106	2983
54	2989
122	1649
44	3097
20	3017
48	3129
60	3109
3	3183
47	3173
28	3190
13	3228
56	3231
66	3261
146	3261
54	2584
67	2579
41	3243
121	2568
26	3262
12	3313
28	3339
132	3363
41	3377
35	3406
49	3428
87	3438
10	3461
122	3493
71	3500
19	3552
58	3552
106	3560
85	3580
92	3594
108	3594
136	3638
103	3656
123	3683
66	3573
5	3704
117	3722
36	3759
79	3772
143	3787
1	3822
42	3822
85	3841
51	3749
27	3889
41	3886
60	3934
67	3969
44	3985
85	3833
58	4005
40	4029
79	4056
98	4070
41	4086
42	4128
20	4119
116	4157
2	4135
43	4207
15	4246
41	4257
12	4283
27	4283
136	4306
136	4312
29	4333
14	4357
88	4376
58	4401
56	4407
27	4441
66	4430
70	4430
6	4489
82	4511
54	4536
46	4550
20	4576
13	4606
60	4606
85	4630
137	4641
122	4644
145	4644
85	4685
84	4709
96	4709
105	4740
15	4780
77	4699
96	4757
17	4819
108	4819
18	4832
38	4853
38	4879
60	4899
20	4926
67	4926
128	4945
51	4961
53	4980
39	4892
25	5006
23	5055
20	5068
78	5126
20	5137
146	5185
18	5235
20	5272
79	5206
106	5217
3	5334
42	5420
105	5420
15	5427
79	5427
21	5399
103	5399
10	5356
48	5461
103	5461
40	5282
49	5287
20	5487
65	5545
18	5584
28	5584
78	5107
41	5559
143	5559
136	5360
59	5635
106	5676
4	5574
57	5712
46	5603
53	5174
91	5736
20	5769
126	5800
14	5824
60	5824
60	5852
100	5852
3	5908
103	5919
129	5919
12	5818
10	5895
18	5895
60	5895
13	5964
38	5980
86	5980
51	5997
107	5997
13	6012
48	5758
20	5756
78	5756
2	5764
21	6030
44	6039
15	6062
139	6062
15	6104
66	6111
140	6129
82	6141
67	6170
67	6190
13	6200
70	6200
10	6231
66	6256
111	6256
19	6264
92	6292
76	6320
27	6365
10	6417
54	6408
12	6452
65	6457
13	6358
146	6500
44	6538
41	6575
32	6579
18	2489
56	2533
19	2687
59	2653
10	2668
52	2630
19	2699
12	2766
100	2766
44	2778
57	2819
66	2796
54	2806
85	2827
26	2883
19	2849
54	2861
35	2917
57	2973
63	2952
20	2985
31	2994
81	2994
19	3048
19	3100
19	3102
12	3026
126	1779
79	3200
78	3189
19	3191
12	3254
26	3264
16	3285
51	3053
65	2562
19	2591
2	2567
107	3310
68	3329
12	3359
79	3387
115	3398
33	3422
60	3422
56	3439
59	3466
43	3476
102	3505
94	3555
111	3578
59	3613
146	3629
123	3645
107	3661
60	3677
131	3568
35	3698
33	3748
36	3760
41	3780
60	3789
12	3828
146	3852
12	3884
27	3918
16	3930
70	3954
94	3971
20	3861
85	3835
58	4009
12	4042
14	4059
73	4074
20	4112
139	4127
5	4051
19	4166
52	4151
18	4196
6	4229
79	4228
12	4272
63	4289
12	4299
29	4331
66	4352
20	4362
96	4393
63	4420
59	4450
60	4450
35	4435
93	4484
103	4503
2	4518
56	4523
19	4569
85	4569
46	4582
85	4611
49	4650
82	4662
82	4585
4	4717
96	4711
15	4764
15	4781
66	4781
6	4759
29	4321
61	4816
31	4833
78	4833
69	4866
125	4891
103	4920
6	4936
41	4951
15	4989
26	4801
54	5005
106	5037
62	5045
28	5077
41	5077
129	5088
79	5146
79	5198
128	5198
41	5306
20	5210
44	5220
103	5220
68	5338
2	5382
66	5398
18	5403
58	5403
48	5409
13	5508
16	5518
48	5285
61	5538
54	5499
65	5505
122	5555
32	5629
59	5629
20	5601
42	5671
20	5573
103	5246
65	5602
27	5730
68	5730
26	5607
60	5607
44	5614
60	5614
100	5614
29	5726
40	5874
106	5367
68	5804
91	5914
28	5924
126	5924
19	5943
53	5943
58	5830
52	5835
51	5989
52	5989
105	6007
134	6018
60	5859
100	5859
44	5864
94	5864
78	5792
33	6034
95	6064
121	6094
40	6114
140	6125
67	6157
19	6173
31	6173
68	6194
102	6194
106	6225
65	6236
66	6236
20	6267
104	6282
94	6307
26	6346
66	6336
54	6407
78	6427
25	6376
103	6376
106	6357
41	6526
16	6534
23	6549
45	6549
85	6555
66	6596
106	6596
146	6628
93	6638
41	6663
10	6609
63	6609
106	6710
139	4479
51	4505
60	4520
54	4531
43	4546
133	4587
52	4619
49	4653
26	4583
33	4583
85	4690
74	4732
5	4761
41	4761
15	4774
26	4792
41	4725
53	4725
46	4807
26	4810
59	4838
136	4881
99	4901
48	4916
42	4938
33	4965
56	4987
52	5002
91	5031
111	5060
36	5052
69	5052
59	5085
61	5085
20	5096
12	5189
20	5238
146	5302
59	5278
102	5278
103	5322
18	5226
69	5390
97	5390
13	5431
59	5431
65	5442
103	5407
104	5511
102	5522
19	5533
6	5543
86	5549
78	5106
60	5622
103	5622
87	5628
136	5157
51	5571
62	5245
33	5716
70	5725
20	5639
12	5709
65	5612
60	5843
100	5843
15	5253
82	5904
133	5904
10	5258
50	5920
126	5920
19	5819
23	5947
27	5947
5	5957
41	5957
6	5839
20	5375
27	6000
53	6000
103	5858
40	5972
51	5269
85	6040
20	6059
20	6079
122	6119
48	6133
13	6154
111	6176
71	6192
19	6214
18	6245
52	6275
65	6283
66	6283
5	6309
20	6347
66	6401
66	6443
2	6448
35	6470
67	6470
65	6510
12	6528
19	6434
12	6552
74	6578
49	6481
93	6629
59	6618
20	6621
117	6690
85	6712
94	6649
44	6739
120	6765
19	6768
35	6804
54	6825
78	6840
43	6858
60	6858
82	6892
24	6896
139	6932
10	6945
12	6378
20	6995
48	6985
4	7034
44	7056
79	7076
117	7090
44	7110
52	6381
10	7147
18	7178
51	7195
20	7206
66	7223
133	7243
18	7266
106	6835
146	7300
48	7311
18	7307
56	7387
24	7417
103	7417
41	7431
1	7478
49	7499
18	7532
33	7540
12	7558
146	7558
7	7507
15	7507
60	7507
19	7631
50	7702
116	7702
5	7641
49	7641
93	7746
52	7644
20	7688
139	7729
19	7799
60	7799
12	7804
59	7735
23	7569
115	7569
36	7880
74	7896
78	7578
107	7578
41	7744
23	7977
67	7977
46	8010
46	8029
38	8065
38	8069
38	8078
45	8107
38	8116
1	8119
106	7987
67	8053
78	8167
81	8189
106	8208
104	8231
71	8252
12	8269
5	8291
19	8291
25	8336
44	8353
66	8314
10	8362
82	8398
74	8450
54	8300
3	8489
12	8489
20	8493
16	8521
79	8544
27	8482
20	8607
35	8634
56	8673
32	8707
85	4608
27	4646
108	4646
86	4659
85	4679
102	4679
130	4729
35	4739
41	4747
26	4797
124	4704
26	4811
59	4840
60	4862
40	4876
41	4904
60	4928
12	4947
67	4947
102	4978
20	4994
20	5021
27	5014
146	5063
111	5074
53	5128
4	5093
40	5150
12	5200
28	5310
126	5319
12	5222
41	5336
40	5347
20	5437
67	5439
101	5411
6	5512
12	5479
13	5289
38	5491
39	5491
28	5582
41	5582
146	5506
13	5593
48	5627
51	5632
28	5666
15	5113
19	5164
51	5164
59	5692
13	5170
59	5732
38	5738
107	5738
60	5611
51	5720
16	5873
10	5880
28	5372
23	5813
4	5929
65	5937
51	5832
15	5985
27	5985
29	5998
58	5647
103	5752
40	5971
78	5790
5	6033
12	6057
18	6105
40	6115
18	6138
45	6138
20	6163
12	6183
27	6205
35	6227
65	6239
129	6270
121	6287
18	6304
60	6344
10	6334
21	6440
42	6411
19	6355
74	6461
31	6466
33	6545
33	6546
48	6590
33	6580
19	6616
26	6642
20	6667
25	6624
79	6711
92	6650
41	6720
10	6752
54	6776
106	6813
20	6832
26	6838
67	6853
74	6894
78	6894
106	6914
58	6937
20	6952
12	6977
60	6491
4	7033
25	7058
27	7058
79	7077
20	7001
14	7114
18	7137
19	7156
20	7183
39	6387
146	7226
71	7230
139	7230
92	7247
78	7272
58	7279
58	7290
54	7337
18	7339
78	7341
35	7415
48	7415
103	7415
23	7430
41	7435
70	7435
40	7447
4	7553
107	7543
18	7486
38	7518
9	7663
68	7698
103	7698
82	7672
48	7722
111	7683
140	7778
23	7600
53	7730
19	7828
107	7828
49	7567
146	7868
20	7881
74	7895
106	7904
13	7913
20	7950
26	7928
33	7928
12	7982
46	8006
46	8037
28	8089
38	8108
1	8124
67	8145
96	8163
12	8050
9	8171
20	8202
5	8217
38	8238
44	8262
81	8284
32	8332
60	8328
26	8357
18	8374
18	8397
18	8440
20	8466
85	8421
20	8429
120	8514
12	8577
29	8582
31	8610
92	8616
66	8639
106	8680
35	8716
76	8716
118	8716
18	8743
35	8750
41	8750
70	8750
56	8826
10	8833
25	8855
53	8898
20	8955
32	8906
14	8911
36	8890
64	9011
103	9049
52	9042
19	8794
74	9115
85	4623
1	4649
86	4643
86	4660
96	4686
96	4712
41	4743
15	4779
26	4799
46	4817
78	4842
69	4857
115	4857
62	4888
18	4897
10	4935
59	4956
67	4956
139	4979
41	4999
71	5008
31	5058
106	5067
106	5125
51	5089
111	5141
27	5154
15	5303
54	5315
128	5324
2	5380
94	5388
106	5395
65	5443
66	5443
32	5451
9	5358
51	5475
27	5530
135	5530
16	5490
33	5497
85	5103
8	5590
19	5561
79	5660
19	5158
20	5679
19	5166
52	5695
41	5638
131	5641
70	5772
4	5801
3	5867
65	5881
98	5909
32	5915
48	5264
27	5944
28	5944
60	5944
10	5941
3	5961
41	6001
105	6014
106	6014
139	5751
13	5776
21	5779
103	5749
74	6052
103	6072
40	6108
41	6112
93	6112
20	6130
38	6155
47	6171
78	6171
4	6102
20	6223
67	6251
4	6273
7	6297
93	6322
40	6371
59	6418
19	6351
5	6313
10	6498
58	6513
39	6361
121	6537
146	6476
27	6594
53	6594
10	6583
18	6636
41	6636
41	6569
98	6643
54	6694
102	6728
41	6652
29	6743
20	6778
12	6799
20	6818
46	6573
20	6856
24	6872
85	6895
20	6920
12	6946
58	6960
60	6980
139	6494
33	7037
96	6986
13	6990
12	7004
143	7121
58	7144
79	7170
20	7194
20	7207
16	6392
66	7238
108	7245
139	6675
106	7295
41	7324
62	7346
71	7346
18	7340
33	7340
94	7390
138	7390
66	7440
41	7459
55	7406
81	7406
111	7463
67	7395
42	7539
54	7516
16	7616
20	7628
10	7695
67	7669
146	7643
23	7681
28	7775
10	7689
4	7647
78	7825
52	7834
9	7866
18	7866
138	7840
19	7892
106	7905
3	7927
92	7951
139	7964
41	7579
92	8058
80	8067
38	8072
38	8076
48	7606
146	8136
47	8143
29	8161
123	8161
46	8039
46	8000
111	8193
116	8201
60	8227
12	8244
93	8258
73	8276
12	8322
135	8337
66	8369
85	8392
20	8405
38	8432
20	8456
106	8461
18	8515
123	8549
89	8508
20	8525
31	8603
74	8603
78	8603
107	8500
107	8627
19	8646
58	8712
27	8694
44	8694
122	8694
44	8746
63	8746
33	8805
53	8845
138	8822
79	8863
20	8939
18	8905
82	8932
61	8948
67	8896
25	9036
19	4666
77	4684
92	4728
13	4748
105	4748
6	4773
13	4697
26	4798
2	4133
59	4826
78	4848
16	4867
38	4885
61	4887
79	4912
102	4949
60	4967
3	4991
35	5001
32	5010
146	5062
69	5053
84	5124
20	5139
106	5147
68	5234
103	5234
15	5274
98	5311
10	5323
60	5323
12	5228
93	5345
12	5428
59	5434
81	5434
32	5452
20	5417
40	5280
54	5527
84	5527
60	5485
145	5485
85	5495
35	5550
102	5550
93	5108
64	5597
43	5659
91	5659
20	5664
20	5673
143	5244
12	5690
66	5699
18	5733
66	5739
84	5768
4	5802
39	5875
60	5853
100	5853
67	5807
71	5807
62	5811
3	5928
103	5828
66	5956
23	5962
67	6003
102	5648
70	5785
10	5782
107	6046
12	6056
18	6074
31	6089
32	6085
139	6122
140	6122
44	6150
20	6174
82	6207
10	6230
12	6247
146	6247
9	6271
63	6286
139	6286
18	6303
106	6342
66	6396
36	6403
57	6446
33	6455
60	6455
20	6509
19	6514
71	6541
44	6474
15	6577
143	6565
20	6584
94	6640
20	6668
139	6671
20	6709
102	6734
20	6741
32	6773
20	6782
12	6801
32	6571
46	6571
58	6841
43	6870
122	6884
60	6902
100	6902
20	6916
35	6916
14	6940
4	6967
94	6489
20	7022
108	7044
12	6993
8	7084
73	7084
15	7097
79	7097
41	7127
85	7127
93	7127
57	7153
61	7153
102	7173
12	7130
66	6388
13	7227
54	7242
12	7261
85	7074
35	7280
18	7323
20	7354
12	7333
41	7378
18	7426
18	7421
25	7407
18	7512
70	7550
106	7401
48	7515
88	7515
23	7620
10	7633
41	7633
20	7700
116	7522
80	7717
100	7717
44	7756
7	7687
27	7793
60	7800
9	7650
65	7837
20	7872
131	7654
20	7766
4	7660
20	7943
27	7963
6	7581
46	8019
46	8021
46	8038
59	8101
78	8101
38	8113
35	8133
19	8141
16	7994
40	8054
57	8054
18	8176
103	8200
54	8221
25	8236
71	8257
79	8271
94	8295
35	8310
62	8313
20	8371
10	8375
93	8411
94	8467
51	8426
27	8513
123	8548
135	8572
27	8581
95	8598
20	8486
20	8632
58	8656
26	8711
12	8742
103	8742
18	8762
31	8812
102	8834
67	8838
58	8869
20	8956
20	8887
96	4691
108	4734
5	4762
15	4766
85	4700
3	4724
59	4823
130	4831
38	4865
46	4883
4	4911
12	4925
26	4942
41	4952
6	4972
57	4997
54	5030
20	5057
20	5071
35	5122
82	5132
12	5142
8	5197
102	5197
35	5276
68	5215
10	5332
106	5344
119	5348
20	5438
12	5448
103	5460
1	5472
115	5283
44	5484
67	5296
66	5500
82	5586
53	5595
64	5595
59	5630
20	5662
12	5670
18	5572
19	5572
101	5572
20	5575
20	5248
20	5718
93	5734
36	5608
116	5797
70	5823
29	5851
24	5257
103	5257
13	5855
100	5855
60	5918
44	5892
7	5935
19	5940
74	5836
107	5991
29	5646
15	6026
15	5754
85	5761
39	5766
78	6037
12	6073
4	6103
107	6086
4	6126
6	6126
30	6148
62	6168
125	6168
53	6191
88	6211
26	6232
78	6258
88	6258
1	6277
102	6298
146	6310
1	6331
65	6421
12	6441
103	6451
10	6497
139	6523
51	6535
146	6435
12	6589
12	6595
27	6598
140	6598
103	6656
66	6669
67	6645
12	6648
15	6703
20	6748
58	6761
12	6784
60	6807
103	6828
38	6855
83	6855
92	6855
12	6871
74	6899
82	6899
63	6923
15	6943
61	6943
12	6962
19	6968
66	7009
66	7024
12	7054
106	7054
66	7061
14	7082
14	7103
67	7116
42	7151
13	7166
20	7188
143	7203
66	7219
41	7224
25	7256
58	7277
58	7284
128	7291
103	7329
80	7364
63	7373
7	7359
55	7351
20	7457
41	7436
111	7462
59	7449
72	7559
78	7559
41	7489
58	7489
56	7623
9	7661
20	7701
63	7713
48	7723
12	7589
19	7645
66	7728
111	7728
60	7797
116	7841
19	7835
74	7871
19	7877
41	7877
10	7897
96	7932
103	7946
74	7979
46	8012
107	8030
18	8068
18	8086
135	8103
10	7609
41	7609
19	8117
20	8159
63	7992
54	7998
85	8178
20	8204
135	8232
41	8247
146	8268
139	8289
15	8331
60	8326
102	8379
10	8361
20	8388
92	8415
136	8465
58	8424
40	8503
75	8503
20	8550
12	8575
92	8585
126	8585
36	8590
89	8511
148	8633
58	8703
80	8721
93	8721
47	8798
41	8808
107	8829
140	8853
18	8876
28	8880
12	8926
89	8888
12	8965
51	8969
89	8973
62	4694
81	4738
15	4771
85	4784
77	4701
48	4803
38	4820
59	4849
116	4869
61	4893
20	4915
67	4915
12	4933
71	4955
53	4983
86	4783
139	5007
20	5034
106	5064
111	5075
38	5086
4	5098
67	5192
106	5202
18	5155
135	5317
146	5218
98	5230
103	5346
74	5351
34	5446
20	5456
23	5509
78	5509
20	5478
26	5482
59	5482
27	5293
35	5293
102	5293
33	5498
136	5551
60	5620
20	5562
9	5361
18	5672
35	5672
20	5680
94	5689
28	5697
78	5702
26	5606
60	5606
19	5610
60	5610
21	5363
139	5643
62	5369
44	5806
98	5809
60	5925
41	5894
59	5894
74	5954
41	5959
46	5996
52	6005
66	5649
57	5762
20	5780
4	5796
68	5796
68	6053
18	6075
35	6096
103	6096
65	6084
35	6143
45	6143
35	6147
51	6180
70	6193
102	6221
103	6221
66	6244
60	6266
59	6285
13	6315
19	6341
82	6395
27	6349
35	6426
33	6454
12	6377
56	6531
30	6518
41	6576
4	6557
63	6581
51	6633
52	6633
18	6605
12	6608
48	6608
66	6610
20	6724
19	6733
20	6719
146	6754
58	6790
12	6806
18	6572
13	6851
59	6851
60	6861
23	6879
89	6912
41	6927
58	6956
59	6486
44	6994
41	7019
66	7040
44	7057
13	7081
61	7096
4	7117
15	7139
85	7139
102	7163
15	7191
97	7199
139	7212
41	7233
92	7258
4	7276
41	7276
40	7282
72	7297
78	7297
58	7317
27	7366
41	7366
20	7357
20	7414
29	7382
60	7382
69	7477
108	7513
48	7500
65	7538
102	7563
123	7617
62	7629
23	7637
49	7712
5	7677
36	7758
126	7758
6	7786
52	7646
58	7819
92	7803
107	7803
59	7864
89	7761
3	7574
50	7888
74	7888
24	7918
41	7936
10	7966
46	8004
20	8027
107	8022
18	8070
19	8099
126	8120
148	8137
1	8150
19	8160
5	8052
58	8174
18	8182
49	8220
12	8245
44	8267
12	8278
41	8335
20	8352
66	8368
69	8390
80	8406
19	8418
52	8458
135	8476
12	8504
53	8520
92	8522
139	8580
106	8602
78	8615
139	8643
92	8681
20	8701
54	8695
95	8761
115	8761
30	8806
65	8818
106	8849
103	8840
18	8735
56	8735
107	8735
63	8903
25	8886
74	8963
52	8971
38	4726
1	4719
3	4722
4	4782
1	4749
26	4802
125	4829
47	4847
116	4875
16	4855
12	4922
33	4941
58	4962
35	4968
59	4837
32	5023
68	5023
14	5036
68	5046
12	5120
51	5087
23	5140
41	5140
65	5152
66	5241
19	5277
35	5321
12	5227
6	5426
103	5392
46	5401
85	5401
56	5357
111	5418
63	5516
50	5481
20	5486
20	5298
44	5502
41	5591
20	5558
79	5658
14	5567
26	5570
60	5570
35	5116
15	5247
41	5721
70	5721
106	5729
121	5740
7	5744
19	5579
51	5579
42	5644
146	5902
6	5856
53	5812
59	5820
62	5946
79	5955
18	5981
70	5981
41	5373
111	5373
53	6011
12	5650
40	5974
66	5789
111	5789
43	6045
61	6045
111	6041
13	6071
86	6081
14	6100
42	6100
48	6134
70	6153
102	6186
19	6197
18	6226
93	6226
18	6250
60	6272
103	6293
60	6321
66	6370
65	6400
77	6311
2	6447
20	6430
126	6462
106	6522
12	6517
20	6520
10	6558
103	6614
57	6567
12	6661
92	6670
49	6647
20	6732
12	6759
73	6745
78	6792
106	6809
18	6678
25	6677
52	6878
138	6878
7	6907
36	6919
80	6936
41	6958
54	6958
20	6983
10	7007
20	7021
57	7043
15	7068
20	7092
41	7115
32	6383
106	7169
26	7128
18	7198
41	7225
132	7241
94	7254
78	7267
20	6680
53	7299
35	7326
80	7365
146	7388
10	7385
44	7456
1	7476
13	7498
78	7393
106	7552
33	7586
20	7504
9	7664
63	7639
66	7642
20	7674
78	7753
81	7593
106	7788
33	7801
60	7801
32	7833
49	7568
65	7762
111	7889
72	7767
78	7767
108	7923
106	7952
10	7978
46	8003
46	8017
38	8066
46	8025
6	8091
15	7605
102	8132
121	8140
12	7844
58	7996
32	8172
107	8183
58	8214
60	8214
146	8233
3	8249
124	8285
9	8294
139	8297
51	8355
66	8315
49	8404
47	8414
60	8444
93	8471
92	8518
92	8494
106	8568
106	8579
20	8601
96	8487
146	8638
74	8677
78	8677
107	8727
95	8757
92	8802
6	8814
7	8821
32	8857
33	8857
107	8857
62	8900
66	8904
20	8959
18	8912
51	8968
4	9032
33	9055
93	9067
70	9087
16	8796
126	9007
32	9198
51	8980
31	9018
85	4680
130	4730
12	4772
80	4785
124	4705
85	4676
16	4821
38	4845
47	4871
26	4894
108	4894
78	4905
20	4932
10	4950
25	4971
67	5016
48	5029
20	5040
52	5070
1	5083
139	5133
52	5145
12	5194
146	5301
103	5312
102	5216
102	5335
2	5381
102	5393
23	5355
25	5459
27	5464
51	5476
126	5476
96	5529
20	5489
12	5496
85	5102
13	5592
102	5560
29	5565
126	5565
20	5568
57	5243
85	5687
103	5687
65	5168
51	5701
128	5706
139	5711
10	5747
19	5580
51	5580
26	5825
60	5900
10	5884
116	5857
59	5262
19	5933
18	5951
16	5978
60	5993
20	6010
103	6010
19	6023
15	5759
12	5786
78	5795
81	5795
12	6035
20	6061
60	6090
106	6118
139	6123
140	6123
3	6149
1	6172
125	6164
71	6201
58	6234
49	6252
33	6274
59	6299
20	6339
12	6372
26	6422
18	6409
70	6414
12	6471
106	6521
63	6540
13	6550
80	6436
4	6599
107	6566
16	6641
42	6641
33	6507
56	6507
94	6692
44	6723
20	6731
41	6750
10	6753
10	6781
12	6798
123	6817
20	6673
38	6854
83	6854
92	6854
57	6863
19	6887
35	6900
103	6900
41	6925
53	6925
44	6944
60	6965
10	6972
25	7013
42	7035
41	7017
79	7078
78	7002
140	7112
13	7141
82	7160
41	7190
78	7190
39	6386
62	6390
25	6394
18	7253
10	7274
58	7278
60	7285
45	7327
102	7331
63	7375
39	7403
107	7403
12	7419
103	7419
35	7461
103	7483
108	7514
1	7471
44	7398
63	7398
20	7488
50	7517
78	7517
1	7662
41	7494
18	7523
53	7497
44	7725
68	7777
65	7813
54	7822
10	7850
20	7859
103	7869
27	7879
10	7894
47	7894
74	7894
120	7577
9	7842
41	7842
51	7945
94	7945
74	7930
46	8026
51	7908
38	8071
38	8075
38	8115
19	8130
18	8151
20	7991
20	7999
68	8186
12	8205
20	8219
78	8239
71	8256
84	8286
102	8319
48	8351
18	8342
1	8401
107	8401
107	8409
18	8451
74	8451
116	8436
19	8474
35	8477
104	8536
41	8530
117	8523
144	8597
92	8613
20	8620
41	8640
12	8671
107	8718
63	8748
103	8748
20	8753
35	8731
71	8731
148	8731
33	8854
58	8877
60	4681
85	4681
3	4714
15	4768
26	4788
3	4723
59	4812
23	4825
18	4856
23	4877
61	4877
13	4900
12	4921
94	4934
51	4960
48	4988
41	5018
73	5018
41	5028
41	5061
20	5072
66	5129
4	5097
12	5190
66	5240
111	5240
111	5270
59	5316
128	5325
12	5339
2	5383
20	5436
65	5441
66	5441
78	5413
81	5413
66	5455
107	5474
95	5528
12	5294
146	5294
62	5546
44	5504
143	5554
59	5626
53	5631
106	5665
106	5111
56	5682
20	5691
12	5722
102	5722
20	5704
58	5179
60	5615
65	5615
67	5642
24	5878
66	5370
14	5885
18	5889
125	5889
94	5893
56	5948
70	5967
10	5986
35	6004
3	5750
79	5750
68	5755
66	5778
16	6044
19	6042
92	6067
139	6082
94	6128
93	6145
128	6145
78	6166
15	6187
79	6187
40	6208
12	6229
65	6237
125	6269
121	6288
53	6317
35	6327
41	6333
111	6423
75	6352
65	6429
66	6429
66	6432
25	6527
146	6501
63	6563
12	6478
7	6626
102	6634
41	6662
14	6687
20	6697
85	6716
58	6756
20	6770
106	6789
108	6808
107	6830
13	6848
42	6859
52	6886
20	6915
43	6934
12	6953
20	6970
54	6492
65	7031
66	7031
12	7041
146	7041
60	6987
78	7089
54	7101
139	7101
20	7119
42	7149
53	7149
102	7172
49	7193
15	7205
79	7205
38	7220
133	7246
135	7263
54	6681
66	7294
45	7325
103	7330
54	7362
80	7362
78	7377
96	7439
41	7444
65	7444
26	7424
32	7424
12	7511
41	7511
44	7396
19	7560
23	7611
106	7618
43	7625
44	7697
12	7670
125	7721
66	7684
15	7598
78	7810
33	7731
60	7731
65	7734
12	7566
1	7652
16	7763
63	7763
3	7900
51	7909
67	7909
20	7944
49	7970
26	8011
115	8009
38	8064
65	7770
66	7770
38	8097
96	8097
10	7610
94	8127
136	8156
66	8164
106	8046
66	8177
111	8192
60	8226
13	8242
20	8266
93	8290
139	8296
60	8329
35	8367
103	8373
107	8412
56	8434
20	8470
19	8475
41	8464
20	8519
74	8569
115	8587
92	8483
19	8501
58	8501
58	8631
12	8653
10	8705
74	8705
18	8744
47	8744
102	8799
120	8819
66	8839
18	8734
119	8734
29	8882
82	8928
96	4708
3	4721
15	4777
26	4789
96	4751
74	4813
59	4822
108	4850
38	4872
15	4903
41	4923
12	4939
14	4959
106	4959
26	4793
53	5017
62	5009
12	5038
20	5069
117	5079
59	5090
61	5090
20	5143
101	5232
57	5309
141	5214
44	5326
1	5340
102	5422
59	5433
35	5440
41	5440
103	5406
101	5416
69	5514
82	5525
51	5537
67	5297
116	5585
18	5619
53	5599
24	5600
35	5600
103	5600
28	5667
42	5677
44	5118
128	5118
18	5719
20	5637
60	5605
39	5767
19	5773
20	5250
89	5254
55	5883
102	5805
53	5810
28	5921
126	5921
103	5827
125	5939
12	5979
52	5990
33	5841
116	6021
40	5969
21	5783
21	6027
12	6049
12	6069
4	6068
12	6110
125	6121
12	6146
15	6146
63	6167
60	6189
41	6210
94	6228
72	6248
20	6260
121	6291
20	6318
41	6366
44	6348
106	6424
62	6428
55	6483
53	6511
44	6539
66	6548
143	6587
42	6559
146	6504
23	6586
59	6620
121	6623
73	6708
60	6718
20	6749
5	6744
41	6769
12	6800
13	6821
122	6849
19	6876
74	6898
82	6898
116	6911
98	6939
44	6973
12	6978
43	7010
106	7030
58	7051
25	6988
53	6998
63	6998
41	7098
56	7126
68	7148
66	7165
111	7165
12	7189
146	7189
24	7131
41	7210
53	7210
20	7228
92	7244
133	7244
58	7275
78	7275
14	7080
35	7301
5	7321
36	7361
63	7372
39	7402
20	7441
50	7441
106	7432
65	7480
106	7465
18	7536
65	7400
65	7487
78	7508
125	7508
20	7691
5	7521
58	7671
12	7749
23	7755
18	7597
60	7795
72	7832
4	7651
91	7570
148	7570
74	7882
27	7885
100	7887
54	7921
35	7939
41	7961
46	8001
107	8018
46	8031
80	8083
38	8098
96	8098
27	8121
68	8139
65	8158
18	7774
58	7774
42	8041
70	8188
107	8184
58	8218
78	8185
63	8260
41	8288
60	8288
16	8333
126	8298
20	8366
91	8383
41	8396
26	8399
106	8455
20	8460
20	8463
54	8565
54	8574
135	8574
40	8594
58	8612
20	8617
35	8641
18	8682
54	8682
40	8715
61	8767
95	8767
148	8749
58	8827
47	8872
19	8865
52	8922
41	8927
18	8909
106	8892
44	9016
10	9054
10	9061
41	4744
96	4698
96	4702
26	4805
38	4828
61	4846
108	4859
61	4886
59	4919
62	4943
117	4943
33	4963
67	4986
49	4998
41	5027
13	5059
28	5076
41	5076
15	5130
29	5099
79	5193
12	5271
31	5307
20	5209
44	5219
1	5376
9	5376
41	5376
42	5386
66	5350
66	5444
81	5410
20	5469
41	5517
56	5483
65	5539
54	5548
18	5507
26	5621
36	5621
144	5654
70	5109
54	5159
54	5681
67	5636
107	5696
129	5696
76	5728
111	5728
78	5737
28	5746
60	5746
18	5364
59	5364
69	5365
20	5366
6	5907
54	5259
68	5817
28	5945
16	5831
41	5960
50	5988
52	5988
44	6002
106	6002
19	5862
102	5862
108	5757
60	5781
19	5268
12	6038
103	6038
51	6076
121	6092
40	6116
115	6137
41	6162
78	6162
46	6179
23	6204
58	6204
44	6218
59	6249
44	6262
38	6281
86	6281
41	6308
56	6328
13	6399
135	6406
25	6353
12	6485
51	6463
35	6515
66	6547
65	6475
20	6593
41	6597
93	6597
3	6602
59	6655
9	6622
143	6691
23	6699
25	6717
14	6742
58	6760
79	6783
3	6795
20	6819
12	6843
24	6866
82	6891
3	6910
58	6942
12	6959
19	6959
26	6969
60	7015
60	7028
12	7049
95	7064
116	7064
143	7000
129	7111
54	7123
85	7123
6	7159
20	7185
15	7133
43	7218
38	7240
85	7240
20	7231
58	7271
41	7281
143	7281
44	7304
63	7322
13	7368
63	7368
20	7358
41	7379
78	7379
93	7443
94	7443
10	7434
41	7434
18	7409
66	7448
125	7554
107	7561
60	7615
71	7451
66	7635
18	7705
107	7709
58	7750
66	7685
106	7596
19	7794
33	7798
60	7798
100	7854
94	7838
5	7653
63	7898
70	7742
3	7954
51	7910
35	7985
46	8043
51	7768
20	8085
20	8102
38	8112
3	7916
1	8149
115	8149
82	7846
43	7997
48	7997
38	8110
66	8197
41	8222
67	8241
63	8259
91	8272
89	8318
52	8325
33	8340
38	8382
139	8386
44	8422
116	8457
20	8473
39	8534
139	8478
26	8480
33	8480
135	8576
18	8510
18	8651
10	8700
95	8758
44	8786
103	8824
83	8820
13	8874
66	8878
47	8803
58	8908
66	8966
77	8991
28	9033
67	9056
79	9046
12	9081
18	9086
15	4767
82	4755
130	4815
59	4839
23	4864
97	4874
54	4906
92	4889
27	4948
24	4973
41	4973
3	4992
54	5020
53	5013
58	5042
66	5066
78	5078
59	5091
40	5183
32	5196
57	5308
26	5320
35	5225
99	5225
33	5343
20	5421
21	5396
20	5405
27	5414
38	5414
20	5471
106	5521
10	5288
70	5540
145	5494
27	5503
20	5618
105	5623
27	5359
35	5359
102	5359
146	5300
2	5161
19	5683
67	5693
9	5724
138	5175
23	5177
57	5770
20	5774
79	5850
20	5256
60	5854
100	5854
43	5808
51	5816
101	5821
59	5949
66	5949
51	5833
115	5987
47	5999
106	6020
40	5968
20	5787
63	6028
129	6036
96	6065
65	6095
18	6117
82	6135
146	6159
15	6184
79	6184
12	6198
35	6217
102	6235
59	6259
75	6279
20	6300
117	6324
61	6373
66	6402
66	6410
54	6354
59	6460
80	6433
39	6362
20	6551
20	6556
16	6561
23	6561
26	6631
67	6657
32	6666
46	6666
29	6693
54	6725
13	6702
85	6707
39	6772
92	6785
93	6785
24	6802
32	6823
33	6839
41	6852
87	6852
138	6852
65	6883
15	6901
65	6901
66	6933
41	6955
79	6955
41	6966
82	7006
102	7025
5	7042
18	7063
4	7066
44	7109
41	7122
78	7146
18	7177
20	7187
41	7202
12	7217
26	7235
33	7235
63	7260
14	6672
20	7283
74	7313
66	7336
102	7336
60	7369
42	7389
18	7427
1	7473
107	7479
78	7410
27	7531
51	7541
71	7549
18	7506
89	7630
20	7667
66	7640
68	7678
103	7678
44	7565
100	7595
94	7602
107	7648
65	7805
106	7858
16	7870
74	7870
12	7890
66	7886
12	7912
72	7912
32	7957
44	7929
46	8007
38	8057
38	8062
38	8073
38	8077
13	7607
103	8129
92	8146
19	7773
106	8048
80	8179
20	8207
51	8230
71	8248
19	8279
27	8292
10	8308
33	8338
38	8380
20	8363
118	8389
56	8443
16	8445
57	8427
66	8539
91	8566
116	8566
107	8495
106	8593
31	8608
32	8608
67	8626
78	8644
25	8678
93	8678
128	8704
54	8709
12	8747
103	8747
18	8752
74	8752
18	8825
44	8848
89	8861
19	8868
41	8924
82	8931
19	8947
78	8990
104	9017
54	9058
19	9082
49	9088
71	9109
83	4786
85	4758
26	4808
38	4836
18	4851
58	4873
13	4895
68	4918
40	4931
94	4958
20	4982
71	4996
29	5025
20	5033
85	5044
111	5073
16	5084
20	5138
60	5149
13	5233
20	5233
12	5304
20	5211
103	5221
57	5379
58	5379
14	5391
35	5435
10	5447
15	5457
79	5457
103	5457
105	5510
33	5281
130	5532
6	5541
28	5581
41	5581
20	5587
122	5557
19	5563
10	5566
103	5669
40	5114
20	5119
20	5717
30	5727
70	5735
78	5742
103	5616
29	5847
10	5872
14	5903
60	5903
20	5910
47	5916
18	5265
125	5938
91	5965
13	5837
60	5837
39	5876
60	5876
20	6013
104	6022
60	5861
15	5866
10	6029
42	6043
20	6078
12	6098
146	6098
94	6127
23	6140
1	6169
60	6188
13	6199
70	6199
20	6222
4	6257
1	6276
27	6296
12	6338
45	6329
59	6419
27	6439
78	6374
65	6456
27	6472
55	6472
32	6467
16	6363
12	6554
146	6554
19	6592
98	6612
93	6635
66	6619
45	6683
60	6695
41	6726
56	6737
20	6740
59	6763
33	6779
103	6803
20	6827
29	6850
44	6867
23	6903
14	6924
25	6938
12	6964
54	6984
20	7012
4	7032
12	7055
63	7072
4	7094
140	7113
67	7124
15	7168
79	7168
141	7180
67	7208
18	7221
92	7248
133	7248
108	7268
44	6929
3	7296
74	7316
12	7353
60	7370
50	7342
132	7342
19	7418
20	7433
66	7437
7	7464
20	7470
57	7556
60	7556
16	7587
35	7505
20	7509
10	7696
12	7706
13	7714
10	7680
19	7757
36	7784
54	7603
94	7603
2	7649
34	7851
12	7857
54	7760
2	7878
4	7878
3	7899
38	7741
96	7741
78	7967
47	7969
49	7969
63	7931
52	8042
46	8033
39	8092
20	8088
41	8106
93	8125
12	8154
107	8166
77	7995
41	8173
66	8198
51	8215
54	8237
40	8254
63	8275
41	8334
43	8311
66	8343
88	8299
18	8410
58	8433
18	8446
25	8488
103	8488
20	8430
41	8540
41	8531
88	8531
51	8591
27	8604
78	8499
20	8630
20	8654
18	8702
4	8693
10	8770
95	8766
44	8729
53	8851
107	8841
18	8879
19	8923
18	8907
89	8889
56	8687
82	8690
8	9035
20	8954
12	8793
139	9111
60	9098
99	9216
19	9231
92	9231
41	9021
26	4795
72	4750
60	4809
115	4834
92	4852
74	4868
38	4890
85	4913
23	4929
35	4929
92	4957
24	4977
41	4993
15	5004
66	5004
66	5035
82	5047
64	5082
1	5134
111	5144
14	5237
23	5156
20	5207
12	5331
146	5331
20	5342
42	5387
21	5394
103	5394
66	5353
44	5408
75	5468
126	5519
20	5531
122	5488
146	5299
10	5104
51	5594
53	5594
135	5594
19	5653
58	5633
41	5110
2	5162
14	5686
66	5694
66	5700
35	5640
102	5640
107	5609
7	5748
106	5846
139	5877
60	5368
5	5912
58	5814
3	5930
108	5936
24	5942
51	5983
138	5983
20	5374
53	6008
105	6008
20	6019
40	5970
76	5788
111	5788
88	6031
102	6054
20	6070
106	6091
33	6087
12	6142
20	6160
103	6181
75	6209
5	6216
41	6216
66	6243
66	6254
12	6284
60	6305
2	6345
20	6335
53	6404
5	6312
41	6375
18	6356
44	6524
103	6524
3	6542
121	6364
91	6591
70	6613
12	6603
59	6506
20	6684
65	6611
86	6727
131	6738
10	6751
103	6774
20	6788
2	6816
57	6816
139	6676
66	6844
33	6873
52	6885
28	6909
60	6935
120	6957
23	6637
78	6490
41	7020
94	7047
4	7071
102	6992
13	7106
63	7106
44	7135
85	7135
28	7161
106	7182
65	7201
102	7213
139	7213
20	7249
106	7269
68	7067
68	7288
107	7319
54	7345
55	7349
24	7335
35	7428
41	7460
65	7484
57	7530
86	7535
126	7535
39	7399
24	7548
47	7622
20	7452
5	7666
71	7710
102	7747
86	7588
126	7588
91	7782
20	7811
65	7821
20	7824
35	7860
9	7873
25	7738
4	7576
4	7907
41	7938
49	7971
46	8002
46	8028
46	8023
133	8084
12	8090
38	8114
35	8135
10	8147
102	8147
41	7772
73	7772
66	8049
96	8175
103	8190
44	8212
144	8234
40	8251
66	8283
78	8304
18	8324
91	8339
106	8385
106	8364
10	8417
44	8459
19	8439
78	8516
68	8551
20	8532
32	8592
136	8485
12	8621
35	8621
71	8621
78	8647
41	8699
66	8725
27	8756
35	8756
18	8763
78	8763
95	8763
59	8811
44	8852
107	8843
49	8899
18	8902
106	8962
95	8946
20	8989
18	9012
54	8949
137	9068
16	8997
19	9114
86	4703
26	4800
23	4824
10	4843
125	4863
48	4884
129	4884
67	4914
13	4930
41	4953
85	4976
20	4975
15	5003
103	5032
41	5043
1	5054
1	5127
6	5094
13	5151
32	5201
46	5275
141	5213
66	5330
111	5330
4	5378
16	5424
12	5429
46	5400
32	5450
5	5462
8	5462
41	5462
107	5473
54	5526
41	5536
128	5536
67	5547
56	5552
136	5552
24	5596
27	5596
20	5656
44	5362
19	5112
19	5684
12	5167
13	5698
51	5698
1	5703
41	5703
140	5178
102	5182
143	5182
126	5799
15	5251
65	5255
47	5905
13	5887
59	5887
50	5923
126	5923
58	5266
12	5963
15	5963
135	5977
46	5994
33	5842
66	6024
41	5860
35	5777
35	5763
54	6050
12	6077
78	6109
40	6120
57	6139
18	6165
53	6182
20	6195
74	6220
20	6255
106	6268
41	6289
12	6316
35	6325
44	6398
19	6350
62	6450
12	6484
35	6464
135	6532
71	6543
18	6553
41	6437
12	6600
12	6482
19	6604
65	6658
44	6625
83	6715
139	6736
135	6747
20	6767
41	6794
78	6794
12	6812
51	6820
19	6847
51	6875
107	6881
14	6918
20	6941
44	6963
20	6971
65	7011
51	7039
42	7046
140	6989
138	7088
41	7100
19	7091
42	7150
106	7162
20	7184
43	7134
93	7134
20	7216
13	7234
18	7252
87	7273
72	7086
19	7303
41	7292
106	7347
93	7334
16	7413
146	7455
20	7405
102	7510
19	7468
107	7468
63	7537
3	7562
14	7503
103	7624
19	7692
41	7694
58	7708
18	7718
20	7752
32	7592
60	7787
103	7816
18	7411
25	7853
59	7862
107	7571
58	7883
94	7906
41	7935
53	7935
12	7949
62	7976
115	8008
46	8015
38	8063
38	8082
41	8100
60	8105
20	8128
79	8131
102	8131
82	8162
46	8040
67	7843
107	8187
20	8203
60	8229
54	8246
10	8265
12	8282
18	8306
111	8347
85	8354
10	8360
18	8403
10	8413
12	8419
5	8447
78	8491
89	8535
35	8507
79	8533
60	8588
18	8496
20	8618
78	8649
19	8672
18	8741
125	8741
18	8759
117	8751
12	8816
27	8847
27	8859
20	8870
44	8942
33	8910
66	8986
62	8689
60	9041
66	9075
62	9083
29	9096
18	9004
44	9236
8	8976
12	9323
39	4756
125	4818
51	4835
61	4854
38	4880
56	4898
59	4924
67	4924
44	4944
75	4954
62	4981
53	4985
25	5024
1	5056
20	5065
59	5123
72	5092
68	5186
84	5195
40	5305
41	5313
139	5327
102	5337
102	5419
66	5349
20	5352
41	5449
106	5415
19	5513
102	5523
21	5534
82	5295
20	5100
98	5105
122	5556
70	5655
51	5634
18	5569
52	5163
41	5688
54	5688
100	5688
12	5723
19	5173
40	5176
70	5743
12	5798
60	5844
100	5844
60	5879
132	5879
20	5803
19	5886
12	5261
33	5931
40	5829
41	5829
70	5829
40	5973
24	5840
141	6006
54	6017
59	5775
78	5791
78	5793
32	6047
20	6063
94	6080
74	6099
20	6136
60	6151
60	6177
32	6196
101	6219
147	6238
14	6261
38	6280
60	6280
94	6302
32	6343
66	6415
146	6438
10	6444
52	6468
12	6496
20	6359
135	6533
26	6473
146	6477
23	6560
102	6615
9	6568
58	6607
4	6689
67	6713
41	6730
53	6730
79	6758
43	6766
12	6777
13	6810
31	6822
51	6822
44	6842
49	6865
89	6889
59	6908
93	6922
94	6948
102	6975
103	6487
20	7029
58	7052
6	7070
12	6991
78	7099
86	7095
108	6384
120	7176
59	7152
61	7152
80	7197
115	7197
20	7222
20	7250
12	7265
146	7265
12	7075
32	7298
63	7320
80	7363
55	7350
39	7404
102	7454
18	7422
74	7422
20	7408
13	7475
32	7555
25	7557
103	7557
52	7613
41	7492
51	7520
18	7703
58	7716
74	7524
2	7754
139	7686
42	7815
96	7815
18	7802
92	7855
66	7867
41	7572
72	7572
16	7765
7	7934
15	7934
35	7959
18	7980
46	8013
46	8020
38	8081
39	8095
75	7924
38	8118
18	8155
20	7990
20	8047
85	8169
33	8199
87	8213
32	8235
71	8253
60	8270
10	8316
66	8346
4	8312
41	8312
59	8381
38	8400
85	8420
67	8452
61	8437
107	8437
32	8462
121	8526
27	8529
135	8573
12	8481
10	8605
47	8498
78	8642
57	8713
18	8737
56	8737
107	8737
18	8760
78	8760
95	8765
78	8828
103	8846
53	8871
12	8925
82	8930
16	8937
12	8791
120	9031
63	8950
19	9044
52	8994
18	9110
107	9127
99	9222
67	9125
89	9125
60	8984
107	8984
83	4753
46	4806
60	4841
18	4858
33	4882
59	4896
54	4908
55	4908
15	4940
23	4966
54	4990
6	5019
53	5012
12	5041
19	5051
23	5080
28	5080
1	5095
33	5191
20	5236
59	5273
41	5314
59	5314
62	5224
106	5341
79	5389
13	5432
26	5432
65	5445
82	5454
3	5463
40	5279
12	5524
65	5535
5	5544
94	5501
28	5588
102	5624
14	5657
68	5663
71	5663
2	5160
130	5115
13	5576
20	5169
78	5731
138	5707
2	5181
65	5617
29	5848
59	5826
82	5901
108	5901
133	5901
91	5913
13	5890
59	5890
7	5932
10	5897
125	5897
68	5975
10	5838
33	5992
107	5992
13	6015
66	6015
4	5652
87	5863
103	5765
103	6032
3	6055
86	6055
116	6066
32	6106
148	6113
10	6124
38	6152
1	6178
23	6203
88	6215
71	6246
19	6263
41	6290
103	6290
35	6306
27	6326
10	6416
135	6405
2	6445
57	6445
139	6469
8	6459
108	6360
54	6536
5	6564
15	6480
54	6627
12	6617
106	6606
8	6688
66	6646
63	6735
12	6653
35	6653
20	6764
60	6786
10	6797
63	6797
106	6833
103	6834
57	6857
14	6882
20	6904
66	6921
31	6947
14	6954
59	6979
94	7016
60	7027
42	7045
8	7069
12	6997
53	6997
33	7105
60	6380
60	7142
12	7164
43	7192
44	7200
140	7214
98	7236
102	7236
18	7259
20	6679
10	7286
51	7314
20	7355
20	7308
85	7343
65	7380
67	7383
65	7481
19	7529
8	7534
12	7450
25	7450
91	7564
65	7614
16	7626
9	7665
18	7495
27	7496
98	7748
129	7748
107	7719
12	7727
23	7812
65	7796
18	7412
66	7836
74	7839
93	7839
75	7876
78	7655
88	7655
19	7903
4	7658
107	7658
54	7955
53	7962
74	7962
46	8005
32	7585
38	8060
39	8096
38	8111
20	7915
57	8126
78	8153
32	7847
10	8148
3	8181
106	8206
60	8223
71	8255
41	8273
12	8321
66	8321
72	8327
93	8356
12	8391
72	8387
78	8387
12	8431
18	8454
20	8438
18	8492
41	8528
79	8571
10	8524
27	8524
20	8600
38	8497
102	8637
116	8625
18	8714
16	8696
12	8801
20	8755
28	8850
21	8860
18	8920
26	8788
12	8944
32	8987
10	8893
18	8688
60	9050
82	9064
135	8993
18	4814
18	4830
19	4861
61	4878
54	4907
33	4927
10	4946
31	4946
98	4970
70	5000
16	5026
36	5015
70	5048
89	5121
39	5131
19	5188
48	5153
56	5204
61	5208
66	5329
131	5231
15	5425
13	5430
41	5430
36	5404
38	5412
68	5465
33	5520
52	5480
3	5292
12	5493
28	5583
41	5583
18	5589
48	5625
44	5564
66	5242
44	5675
35	5117
59	5714
14	5249
60	5604
100	5604
95	5741
18	5745
18	5822
29	5849
55	5882
62	5371
103	5371
19	5917
44	5917
59	5891
79	5934
102	5934
20	5953
23	5976
46	5995
33	6009
66	6025
79	5753
12	5865
27	5865
78	5794
144	6048
78	6058
65	6107
66	6083
51	6131
38	6156
18	6175
47	6161
70	6202
12	6241
12	6253
19	6278
20	6301
29	6340
4	6332
41	6420
35	6425
103	6453
86	6431
52	6465
91	6544
19	6574
46	6574
63	6479
35	6562
102	6562
52	6632
42	6660
20	6686
12	6722
63	6705
27	6654
20	6771
19	6787
13	6814
58	6829
58	6837
60	6860
12	6890
146	6890
59	6897
120	6917
20	6951
14	6570
35	6493
52	7026
19	7053
10	7060
13	7060
12	6999
53	6999
60	7107
12	7125
106	7157
102	7181
78	7196
63	7211
68	7229
15	7255
60	7270
67	6928
67	7305
103	7328
55	7348
56	7386
15	7416
70	7420
111	7392
12	7446
146	7446
20	7527
33	7551
106	7502
46	7547
52	7490
51	7519
18	7636
58	7707
10	7676
29	7526
51	7526
94	7779
106	7690
42	7820
33	7829
42	7863
20	7874
74	7893
4	7657
91	7925
20	7956
18	7960
102	7584
46	8014
115	8032
38	8094
10	7771
41	7608
53	8134
59	8142
65	7989
38	8056
78	8170
59	8191
5	8216
69	8250
125	8280
18	8305
82	8345
42	8330
8	8350
41	8394
15	8377
4	8449
12	8423
59	8302
19	8517
123	8547
13	8570
61	8545
90	8545
31	8611
32	8611
26	8623
74	8650
126	8650
33	8683
24	8706
78	8745
95	8764
52	8844
3	8732
8	8732
60	8875
18	8733
56	8733
107	8733
20	8941
20	8961
48	8790
103	8790
51	8972
14	9034
20	8952
52	9065
35	8995
19	9113
18	9009
10	9024
32	9340
48	4917
103	4917
12	4937
16	4964
35	4974
103	4995
20	5011
40	5039
36	5049
23	5081
28	5081
20	5136
102	5184
63	5199
66	5205
103	5318
93	5223
102	5377
20	5423
82	5397
46	5354
73	5458
102	5466
16	5515
125	5284
3	5291
100	5492
77	5101
16	5553
42	5598
51	5598
52	5598
66	5661
116	5668
122	5678
20	5685
19	5578
135	5172
139	5705
68	5710
17	5771
96	5845
75	5252
60	5898
35	5911
58	5260
4	5927
60	5896
85	5966
107	5984
29	5645
80	6016
20	5651
85	5760
70	5784
52	5267
91	6051
20	6060
56	6097
29	6088
74	6144
35	6158
3	6185
34	6206
41	6206
128	6206
20	6224
18	6240
20	6265
20	6295
45	6295
13	6337
13	6369
78	6369
12	6397
60	6442
12	6413
32	6458
135	6458
146	6499
102	6516
67	6519
103	6502
26	6503
146	6630
16	6639
42	6639
27	6664
10	6644
47	6698
102	6729
12	6757
59	6762
14	6791
20	6805
32	6824
20	6836
52	6874
12	6893
146	6893
20	6905
139	6931
139	6961
44	6982
55	6488
6	7023
6	7048
13	7062
94	7062
6	7085
60	7104
66	7120
31	7143
18	7155
20	7186
91	7204
31	6391
43	7237
41	7232
44	7073
66	7287
70	7315
55	7352
14	7356
65	7391
121	7442
2	7472
56	7485
18	7467
13	7533
19	7533
78	7545
102	7612
20	7621
29	7632
19	7638
20	7711
92	7720
58	7682
67	7776
51	7792
131	7817
106	7827
42	7856
12	7736
24	7573
16	7764
42	7764
71	7739
20	7933
32	7958
52	7958
125	7972
52	7582
46	8044
46	8035
38	8074
38	8079
12	8122
53	7917
93	8152
9	7845
41	7845
25	8051
41	8168
60	8196
60	8225
111	8243
12	8261
18	8293
58	8348
12	8378
12	8393
60	8376
18	8416
18	8453
76	8425
10	8490
20	8527
79	8479
13	8578
2	8599
5	8599
41	8609
20	8619
74	8648
126	8648
56	8655
54	8708
55	8708
80	8708
35	8724
76	8724
118	8724
78	8771
18	8736
56	8736
107	8736
35	8730
41	8832
33	8837
102	8866
79	8901
120	8943
41	8945
33	8891
12	8792
89	9037
20	8953
10	9069
66	9095
18	9123
108	9183
18	9101
108	8981
61	9107
135	6579
106	6601
146	6505
10	6659
93	6685
20	6696
14	6701
8	6706
141	6721
12	6775
12	6793
20	6815
10	6831
66	6845
107	6864
60	6888
26	6906
63	6926
44	6949
44	6976
10	7008
67	6495
3	7038
27	6981
79	7079
12	7005
146	7005
19	6379
29	6382
51	7154
60	7179
32	6385
62	6389
78	6393
10	7251
102	7251
15	7262
106	6682
41	7293
60	7310
132	7306
102	7332
12	7376
14	7425
20	7458
20	7474
61	7466
132	7397
19	7544
20	7528
10	7619
10	7453
80	7668
79	7715
12	7724
146	7724
67	7726
15	7594
102	7806
12	7826
146	7826
66	7852
102	7865
10	7737
88	7575
3	7656
78	7926
106	7745
49	7968
66	7981
38	8059
46	8036
39	8093
20	8104
38	8109
18	8138
117	8157
32	8165
80	8055
116	8180
111	8195
62	8228
111	8210
10	8263
31	8274
42	8344
27	8349
35	8370
106	8402
26	8408
5	8441
42	8435
33	8301
67	8428
78	8546
8	8543
17	8596
20	8606
35	8614
41	8629
19	8652
12	8657
35	8728
40	8728
16	8697
12	8823
10	8817
135	8835
10	8864
105	8921
20	8957
63	8789
52	8970
25	8895
36	8951
16	9066
79	9073
16	9000
19	9182
18	9230
32	9230
12	8915
82	8985
41	6651
92	6755
73	6746
12	6796
126	6811
79	6826
14	6846
98	6869
74	6880
20	6913
63	6930
106	6950
44	6974
12	6996
32	7018
4	7036
100	7059
18	7065
44	7003
20	7118
58	7138
20	7171
67	7129
83	7209
139	7215
38	7239
85	7239
7	7264
139	7014
20	7289
74	7302
67	7344
13	7338
52	7374
88	7360
35	7381
67	7381
26	7423
32	7482
18	7469
19	7469
41	7501
52	7542
38	7546
28	7491
41	7491
44	7493
20	7699
82	7673
139	7525
41	7590
58	7783
68	7814
13	7818
10	7830
59	7759
146	7875
26	7891
20	7901
4	7659
107	7659
20	7942
19	7965
60	7583
46	8016
38	8061
19	8024
66	8087
38	8080
1	8123
93	8144
60	7848
139	7849
26	8045
111	8194
60	8224
12	8211
93	8264
6	8281
10	8307
10	8309
27	8341
65	8384
79	8407
56	8442
94	8468
5	8448
6	8448
18	8303
78	8303
12	8537
12	8541
41	8583
116	8595
18	8509
107	8509
35	8628
78	8645
78	8692
107	8692
19	8723
61	8769
95	8769
89	8807
106	8754
117	8836
85	8897
12	8881
20	8958
82	8929
79	8964
18	8512
65	9030
13	9051
23	9051
33	9060
55	9070
35	8998
67	9116
79	9116
20	9210
79	9126
16	8978
132	8913
16	8717
56	8717
61	8768
8	8787
102	8810
58	8830
52	8873
19	8867
53	8940
18	8885
79	8934
53	8988
85	8894
92	9039
85	9076
28	8996
66	9106
111	9106
57	9207
86	9207
107	9124
8	8975
66	9023
18	8938
71	8883
20	8960
106	8936
3	8804
59	9015
111	9038
41	9062
53	9062
24	9079
103	8795
14	9118
20	9209
58	9120
69	9027
60	8933
65	8992
78	8691
91	9057
67	9077
19	9085
117	9112
85	9090
146	9233
41	8917
4	9234
82	8935
51	8967
32	9013
106	9052
117	9063
55	9072
54	8999
126	8999
41	9089
91	9089
19	9010
18	9300
67	9020
89	8974
82	9047
19	9043
41	9084
66	9074
6	9203
44	9228
52	9121
69	9026
13	9022
106	9053
44	9045
19	9078
89	9003
19	9006
66	9094
41	9108
20	9029
56	9059
18	9080
47	9080
41	9104
18	9005
32	9197
12	9238
19	8979
55	9071
60	9097
33	9128
79	9232
79	8914
18	8919
14	9103
61	9103
25	9117
20	9213
35	9213
7	9100
106	9025
52	9122
10	9093
18	9102
24	9019
27	9019
18	9091
74	9099
125	9099
52	8983
64	9119
64	9008
18	9235
18	8982
19	9301
99	9217
35	9239
4	9028
79	9014
92	337
19	371
59	362
125	410
41	425
35	266
85	47
18	479
42	483
36	505
5	84
40	430
2	510
51	541
3	562
54	585
54	603
4	615
29	651
54	664
84	693
59	720
30	743
19	736
31	783
26	780
107	820
92	845
27	866
54	866
33	883
23	902
2	940
52	958
59	973
49	1005
23	1028
54	1043
131	1043
71	1094
2	1059
32	1136
19	1157
19	1174
60	1139
59	1192
62	1260
93	1251
65	1255
31	1326
96	1315
26	1376
12	1334
146	1334
25	1392
19	1423
116	1180
52	1463
111	1486
18	1512
107	1537
41	1554
53	1577
78	1602
92	1618
18	1639
66	1683
9	1704
53	1716
3	1738
49	1756
12	1778
107	1811
16	1834
79	1862
136	1873
32	1908
85	1908
10	1937
56	1970
44	1990
103	1990
55	1980
147	1980
100	2025
13	2028
27	2111
18	2072
19	2106
128	2126
35	2132
102	2132
44	2159
111	2244
116	2244
129	2271
53	2237
12	2279
26	2330
19	2367
35	2399
103	2303
87	2404
12	2410
143	2464
23	2506
12	2513
79	2513
66	2435
69	2441
98	2449
58	2652
139	2665
36	2626
108	2626
63	2640
46	2704
20	2713
77	2724
70	2790
42	2798
44	2752
36	2921
10	2836
41	2836
70	2897
122	2859
78	2869
130	3000
102	2981
92	2960
12	3042
10	3119
70	3145
132	3103
79	3074
20	3114
49	3172
106	3092
61	3213
13	3229
26	3263
15	3279
59	3179
67	2560
27	2581
53	2581
49	2563
20	3308
15	3338
18	3354
12	3349
107	3400
115	3400
62	3412
87	3437
102	3457
72	3474
20	3520
13	3554
85	3554
108	3601
111	3581
12	3630
20	3622
19	3549
23	3674
41	3565
88	3697
60	3725
10	3720
27	3778
59	3799
44	3823
6	3744
61	3857
12	3913
58	3896
95	3939
54	3966
84	3966
79	3986
49	3879
16	4007
78	4023
86	4055
71	4071
54	4097
30	4102
47	4050
35	4161
85	4178
135	4205
15	4222
16	4269
58	4269
85	4266
12	4298
125	4330
29	4322
1	4373
13	4387
60	4387
111	4422
103	4444
51	4463
18	4476
103	4495
60	4521
100	4545
1	4558
115	4558
59	4595
115	4553
86	4636
86	4658
96	4674
35	4694
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
6ea227ef-e4c5-48e7-a041-8d9a46567d21	c90aa94e37b9e86446051973f149b1ba393ffabb79a187222a8e2bec75deab33	2023-12-20 22:10:34.879389+00	20231218221212_	\N	\N	2023-12-20 22:10:34.779027+00	1
09609737-9ad3-4969-a873-f6834304c77d	c2d5222938427f670ec89e794309189b993cee5b26ce3ded397b0aba006fd3eb	2023-12-20 22:10:34.883886+00	20231219195741_	\N	\N	2023-12-20 22:10:34.880587+00	1
2ece610b-bec8-473f-97d6-0479f5112d01	76abf96b5d67cb57c5c7358138c74ef193a4869fa08d9f3ebba0bc5eb8ddd3ee	2023-12-20 22:10:42.286596+00	20231220221042_	\N	\N	2023-12-20 22:10:42.239003+00	1
\.


--
-- Name: Bill Bill_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Bill"
    ADD CONSTRAINT "Bill_pkey" PRIMARY KEY (id);


--
-- Name: Canton Canton_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Canton"
    ADD CONSTRAINT "Canton_pkey" PRIMARY KEY (id);


--
-- Name: Committee Committee_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Committee"
    ADD CONSTRAINT "Committee_pkey" PRIMARY KEY (id);


--
-- Name: InterestGroup InterestGroup_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."InterestGroup"
    ADD CONSTRAINT "InterestGroup_pkey" PRIMARY KEY (id);


--
-- Name: LobbyOrganization LobbyOrganization_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."LobbyOrganization"
    ADD CONSTRAINT "LobbyOrganization_pkey" PRIMARY KEY (id);


--
-- Name: ParliamentarianRelatedToOrganization ParliamentarianRelatedToOrganization_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."ParliamentarianRelatedToOrganization"
    ADD CONSTRAINT "ParliamentarianRelatedToOrganization_pkey" PRIMARY KEY ("parliamentarianId", "organizationId");


--
-- Name: ParliamentarianVote ParliamentarianVote_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."ParliamentarianVote"
    ADD CONSTRAINT "ParliamentarianVote_pkey" PRIMARY KEY ("parliamentarianId", "billId");


--
-- Name: Parliamentarian Parliamentarian_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Parliamentarian"
    ADD CONSTRAINT "Parliamentarian_pkey" PRIMARY KEY (id);


--
-- Name: Party Party_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Party"
    ADD CONSTRAINT "Party_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Canton_shortName_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX "Canton_shortName_key" ON public."Canton" USING btree ("shortName");


--
-- Name: _CommitteeToParliamentarian_AB_unique; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX "_CommitteeToParliamentarian_AB_unique" ON public."_CommitteeToParliamentarian" USING btree ("A", "B");


--
-- Name: _CommitteeToParliamentarian_B_index; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "_CommitteeToParliamentarian_B_index" ON public."_CommitteeToParliamentarian" USING btree ("B");


--
-- Name: _InterestGroupToLobbyOrganization_AB_unique; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX "_InterestGroupToLobbyOrganization_AB_unique" ON public."_InterestGroupToLobbyOrganization" USING btree ("A", "B");


--
-- Name: _InterestGroupToLobbyOrganization_B_index; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "_InterestGroupToLobbyOrganization_B_index" ON public."_InterestGroupToLobbyOrganization" USING btree ("B");


--
-- Name: Bill Bill_sponsorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Bill"
    ADD CONSTRAINT "Bill_sponsorId_fkey" FOREIGN KEY ("sponsorId") REFERENCES public."Parliamentarian"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ParliamentarianRelatedToOrganization ParliamentarianRelatedToOrganization_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."ParliamentarianRelatedToOrganization"
    ADD CONSTRAINT "ParliamentarianRelatedToOrganization_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."LobbyOrganization"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ParliamentarianRelatedToOrganization ParliamentarianRelatedToOrganization_parliamentarianId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."ParliamentarianRelatedToOrganization"
    ADD CONSTRAINT "ParliamentarianRelatedToOrganization_parliamentarianId_fkey" FOREIGN KEY ("parliamentarianId") REFERENCES public."Parliamentarian"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ParliamentarianVote ParliamentarianVote_billId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."ParliamentarianVote"
    ADD CONSTRAINT "ParliamentarianVote_billId_fkey" FOREIGN KEY ("billId") REFERENCES public."Bill"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ParliamentarianVote ParliamentarianVote_parliamentarianId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."ParliamentarianVote"
    ADD CONSTRAINT "ParliamentarianVote_parliamentarianId_fkey" FOREIGN KEY ("parliamentarianId") REFERENCES public."Parliamentarian"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Parliamentarian Parliamentarian_cantonId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Parliamentarian"
    ADD CONSTRAINT "Parliamentarian_cantonId_fkey" FOREIGN KEY ("cantonId") REFERENCES public."Canton"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Parliamentarian Parliamentarian_partyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Parliamentarian"
    ADD CONSTRAINT "Parliamentarian_partyId_fkey" FOREIGN KEY ("partyId") REFERENCES public."Party"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: _CommitteeToParliamentarian _CommitteeToParliamentarian_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."_CommitteeToParliamentarian"
    ADD CONSTRAINT "_CommitteeToParliamentarian_A_fkey" FOREIGN KEY ("A") REFERENCES public."Committee"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _CommitteeToParliamentarian _CommitteeToParliamentarian_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."_CommitteeToParliamentarian"
    ADD CONSTRAINT "_CommitteeToParliamentarian_B_fkey" FOREIGN KEY ("B") REFERENCES public."Parliamentarian"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _InterestGroupToLobbyOrganization _InterestGroupToLobbyOrganization_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."_InterestGroupToLobbyOrganization"
    ADD CONSTRAINT "_InterestGroupToLobbyOrganization_A_fkey" FOREIGN KEY ("A") REFERENCES public."InterestGroup"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _InterestGroupToLobbyOrganization _InterestGroupToLobbyOrganization_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."_InterestGroupToLobbyOrganization"
    ADD CONSTRAINT "_InterestGroupToLobbyOrganization_B_fkey" FOREIGN KEY ("B") REFERENCES public."LobbyOrganization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: admin
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

