# Vote Watch

[[_TOC_]]

## Team Members

1. Marc Andriu Carigiet
2. Thomas Gassmann
3. Nick Ciardiello
4. Thierry Meier

## Project Description

Have a look at the project [pitch](pitch.md)

### Project Goals

Besides the high-level goals defined in [pitch](pitch.md), we aim to implement the four subtasks as defined in [Tasks](#tasks).

### Data Sources

See the [references section](pitch.md#references) of pitch.

### Tasks

#### Bill-By-Bill (Visualization)

**high-level idea:** Uncover the lobbies and how they vote with respect to each bill. Bills are sorted by some property, which results in a searchable list the user can interact with.

**primarily responsible:** Marc

#### Lobbying Dynamics (Visualization)

**high-level idea:** Visualize the lobbying organizations as network diagram. That is visualizing the influence that organizations have on each other as well as on the different political parties.

**primarily responsible:** Thierry

**points to note:**

- incorporate information about
  - the political parties
  - the degree of influence on (other organizations | the different parties)
    - possible encodings: color, edge weight
- given a bill, visualize the organizations and their influence on the parliamentary voters
  - this could be a useful extension to the Bill-By-Bill subtask

#### Parliamentarian Pie (Visualization)

**high-level idea:** Visualize the (seating | political party) arrangement of the parliament as half-disk. The user should be able to interact with the elements of this chart. When an element is clicked, it should display various statistics. E.g. if the element is a parliamentarian, statistics could include trivia such as the name and the party but also other information regarding lobbying, e.g. what connection an individual has to an organization (e.g. position) and how it governs their relationship.

**primarily responsible:** Thomas

**points to note:**

- the important parts about the displayed statistics of a parliamentarian are the incoming/outgoing connections to special interest agents
  - there is a lot of freedom in what statistics are to be reported
- if the visualization works for selecting a single element, one could extend the functionality to select two elements and compare their individual and mutual connections.

#### Front- & Backend (Organization)

**high-level idea:** This subtask is involved with the design of the frontend and how to user interacts between the three previously described visualizations. That is providing a unifying and coherent user experience/interface, which allows the user to explore the different interactive visualizations. Furthermore, this role encompasses the design of the backend which allows to efficiently cache and conveniently retrieve all the data needed by the visualizations through a well-defined interface.

**primarily responsible:** Nick

**points to note:**

- each of the visualization subtasks are required to bring forth the data they essentially need to simplify the design of the backend.
- preliminary idea for frontend
  - search bar/list for the bills with the possibility to switch between the 3 tabs (i.e. one for each visualization)

## Requirements

Write here all instructions to build the environment and run your code.\
**NOTE:** If we cannot run your code following these requirements we will not be able to evaluate it.

We are using a monorepo based on `turbo`. As a package manager we're using `pnpm`. A `postgres` database is required to store the imported data which is aggregated from LobbyWatch and the Swiss parliament.

## How to Run

Write here **DETAILED** instructions on how to run your code.\
**NOTE:** If we cannot run your code following these instructions we will not be able to evaluate it.

### Docker

This repo is configured to be built with Docker. To build all apps in this repo:

```bash
docker build . -t votewatch
```

To run the built image:

````bash
docker run -it votewatch
````

Upon running the app, the database will be initialized by the fetcher (`apps/fetcher`).

Open http://localhost:5173.

### Local Development

1. Run `pnpm install` in the root directory.
2. Run `docker compose up` in a separate terminal to start the database. All `.env` files should have already been configured.
3. Run `pnpm run db:generate` as well as `pnpm run db:push` in  `packages/database` to generate the database schema.
4. Run `pnpm run start` in `apps/fetcher` to execute the fetcher script against the database. This will populate the database with data aggregated from LobbyWatch and the Swiss parliament.
5. Run `pnpm run dev` in `apps/frontend` to start the NextJS development server.

## Milestones

Document here the major milestones of your code and future planned steps.\

- [x] Milestone 1
  - [x] mockup: bill-by-bill
  - [x] mockup: lobbying dynamics
  - [x] mockup: parliamentarian pie
  - [x] mockup: frontend
- [x] Milestone 2
  - [x] data requirements: bill-by-bill requirements
  - [x] data requirements: lobbying dynamics mockup
  - [x] data requirements: parliamentarian pie mockup
  - [x] design: backend
- [x] Milestone 3
  - [x] preliminary implementation: bill-by-bill
  - [x] preliminary implementation: lobbying dynamics
  - [x] preliminary implementation: parliamentarian pie
  - [x] preliminary implementation: backend
- [x] Milestone 4
  - [x] integration: backend with bill-by-bill
  - [x] integration: backend with lobbying dynamics
  - [x] integration: backend with parliamentarian pie
  - [x] implementation: frontend
- [x] Milestone 5
  - [x] integration: frontend with bill-by-bill
  - [x] integration: frontend with lobbying dynamics
  - [x] integration: frontend with parliamentarian pie
- [x] Milestone 6
  - [x] finalize

Create a list subtask.\
Open an issue for each subtask. Once you create a subtask, link the corresponding issue.\
Create a merge request (with corresponding branch) from each issue.\
Finally accept the merge request once issue is resolved. Once you complete a task, link the corresponding merge commit.\
Take a look at [Issues and Branches](https://www.youtube.com/watch?v=DSuSBuVYpys) for more details.

This will help you have a clearer overview of what you are currently doing, track your progress and organise your work among yourselves. Moreover it gives us more insights on your progress.

## Weekly Summary

Write here a short summary with weekly progress, including challanges and open questions.\
We will use this to understand what your struggles and where did the weekly effort go to.

### Week 1 (Semester Week 10)

Meeting was held (approx. 60 minutes) discussing details of the app (i.e. visualizations) and how to split the work.

### Week 2 (Semester Week 11)

Milestones 1 & 2 should be completed by Friday, 1st of December, 13:00

### Week 3 (Semester Week 12)

Milestones 1 & 2 are finished. Furhter steps were disucssed:

- Using Gitlab milestones and Gitlab issues for development tasks form now on, also work with merge requests
- Using [shadcn](https://ui.shadcn.com/) as a component library
- Using [Prisma ORM](https://github.com/prisma/prisma) for data access
- Signed up for status update meeting on 14th of December
- Discussed data requirements, preliminary data access should be implemented by the end of this week

### Week 4 (Semester Week 13)

- Initial work on frontend and infrastructure
- Project progress meeting was held on 14th of December
- Data schema created, postgres database and data access up and running

### Week 5

- Worked on the visualizations
- Data import and aggregation
- Integrate different visualizations into app
