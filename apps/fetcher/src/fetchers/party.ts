import { db } from "@votewatch/database";
import { fetchFromLobbyWatch } from "../utils/fetchFromLobbyWatch";

type LobbyWatchPartei = {
  id: string;
  abkuerzung: string;
  name: string;
};

export async function fetchParties() {
  const data = await fetchFromLobbyWatch<LobbyWatchPartei[]>({
    apiUrl:
      "https://cms.lobbywatch.ch/de/data/interface/v1/json/table/partei/flat/list?limit=none",
  });

  if (!data) {
    throw Error("⛔️ Failed to fetch party list");
  }

  for (const party of data) {
    await db.party.upsert({
      where: {
        id: party.id,
      },
      update: {},
      create: {
        id: party.id,
        fullName: party.name,
        shortName: party.abkuerzung,
      },
    });
  }

  console.log(`🟢 Fetched ${data.length} parties`);
}
