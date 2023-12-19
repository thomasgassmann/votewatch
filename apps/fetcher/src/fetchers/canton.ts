import { db } from "@votewatch/database";
import { fetchFromLobbyWatch } from "../utils/fetchFromLobbyWatch";

type Canton = {
  id: string;
  anzeige_name: string;
  abkuerzung: string;
}[];

export async function fetchCantons() {
  const data = await fetchFromLobbyWatch<Canton>({
    apiUrl:
      "https://cms.lobbywatch.ch/de/data/interface/v1/json/table/kanton/flat/list?limit=none",
  });

  if (!data) {
    throw Error("⛔️ Failed to fetch Cantons list");
  }

  for (const canton of data) {
    await db.canton.upsert({
      where: {
        id: canton.id,
      },
      update: {},
      create: {
        id: canton.id,
        name: canton.anzeige_name,
        shortName: canton.abkuerzung,
      },
    });
  }

  console.log(`🟢 Fetched ${data.length} cantons`);
}
