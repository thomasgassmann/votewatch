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

**points to note:**

- ...

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

## How to Run

Write here **DETAILED** instructions on how to run your code.\
**NOTE:** If we cannot run your code following these instructions we will not be able to evaluate it.

### Docker

This repo is configured to be built with Docker, and Docker compose. To build all apps in this repo:

TODO: Add missing instructions

```
# Create a network, which allows containers to communicate
# with each other, by using their container name as a hostname
docker network create app_network

# Build prod using new BuildKit engine
COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose -f docker-compose.yml build

# Start prod in detached mode
docker-compose -f docker-compose.yml up -d
```

Open http://localhost:3000.

To shutdown all running containers:

```
# Stop all running containers
docker kill $(docker ps -q) && docker rm $(docker ps -a -q)
```

--- OLD INSTRUCTIONS ---
As an example here are the instructions to run the Dummy Project:
To run the Dummy project you have to:

- clone the repository;
- open a terminal instance and using the command `cd` move to the folder where the project has been downloaded;
- then run:

### Local Development

Only change files inside the `src` directory.

**Client side**

All client side files are located in the `src/client` directory.

**Server side**

All server side files are located in the `src/server` directory.

### Local Testing

**run container for local testing**

```bash
docker build -t my-webapp .

docker run -it --rm -p 5173:5173 my-webapp
```

Open a browser and connect to <http://localhost:5173>

**run bash in interactive container**

```bash
docker build -t my-webapp src/.

docker run -it --rm -p 5173:5173 my-webapp bash
```

---

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
- [ ] Milestone 3
  - [ ] preliminary implementation: bill-by-bill
  - [ ] preliminary implementation: lobbying dynamics
  - [ ] preliminary implementation: parliamentarian pie
  - [ ] preliminary implementation: backend
- [ ] Milestone 4
  - [ ] integration: backend with bill-by-bill
  - [ ] integration: backend with lobbying dynamics
  - [ ] integration: backend with parliamentarian pie
  - [ ] implementation: frontend
- [ ] Milestone 5
  - [ ] integration: frontend with bill-by-bill
  - [ ] integration: frontend with lobbying dynamics
  - [ ] integration: frontend with parliamentarian pie
- [ ] Milestone 6
  - [ ] finalize

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

## Versioning

Create stable versions of your code each week by using gitlab tags.\
Take a look at [Gitlab Tags](https://docs.gitlab.com/ee/topics/git/tags.html) for more details.

Then list here the weekly tags. \
We will evaluate your code every week, based on the corresponding version.

Tags:

- Milestone 1: ...
- Milestone 2: ...
- Milestone 3: ...
- ...
