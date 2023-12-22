import { db } from "@votewatch/database";
import { fetchFromLobbyWatch } from "../utils/fetchFromLobbyWatch";

type LobbyWatchInterestGroups = {
  id: string;
  anzeige_name: string;
  beschreibung: string;
  alias_names: string | null;
  branche: string;
};

export async function fetchInterestGroups() {
  const data = await fetchFromLobbyWatch<LobbyWatchInterestGroups[]>({
    apiUrl:
      "https://cms.lobbywatch.ch/de/data/interface/v1/json/table/interessengruppe/flat/list?limit=none",
  });

  if (!data) {
    throw Error("⛔️ Failed to fetch list of interest groups");
  }

  for (const interestGroup of data) {
    await db.interestGroup.upsert({
      where: {
        id: interestGroup.id,
      },
      update: {},
      create: {
        id: interestGroup.id,
        name: interestGroup.anzeige_name,
        description: interestGroup.beschreibung,
        aliasNames: interestGroup.alias_names || "",
        branche: interestGroup.branche
      },
    });
  }

  console.log(`🟢 Fetched ${data.length} interest groups`);
}
