import { env } from "./env";
import { db } from "@votewatch/database";
import fetchVotes from "./fetchers/votes";
import { fetchCantons } from "./fetchers/canton";
import { fetchParties } from "./fetchers/party";
import { fetchParliamentarians } from "./fetchers/parlamentarian";
import { fetchInterestGroups } from "./fetchers/interestGroups";
import { fetchLobbyOrganizations } from "./fetchers/organizations";

async function fetch() {
  await fetchCantons();
  await fetchParties();
  await fetchParliamentarians();
  await fetchInterestGroups();
  await fetchLobbyOrganizations();
  await fetchVotes();
}

async function main() {
  console.log("✨ Starting fetcher script");

  const results = await fetch();

  console.log("✅ Fetcher script completed!");
}

main();
