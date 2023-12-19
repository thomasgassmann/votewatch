import { db } from "@votewatch/database";
import { fetchFromLobbyWatch } from "../utils/fetchFromLobbyWatch";

type LobbyWatchParliamentarian = {
  id: string;
  vorname: string;
  nachname: string;
  kanton_id: string;
  partei_id: string;
};

export async function fetchParliamentarians() {
  const data = await fetchFromLobbyWatch<LobbyWatchParliamentarian[]>({
    apiUrl:
      "https://cms.lobbywatch.ch/de/data/interface/v1/json/table/parlamentarier/flat/list?limit=none",
  });

  if (!data) {
    throw Error("⛔️ Failed to fetch list of parliamentarians");
  }

  for (const parliamentarian of data) {
    await db.parliamentarian.upsert({
      where: {
        id: parliamentarian.id,
      },
      update: {},
      create: {
        id: parliamentarian.id,
        name: `${parliamentarian.vorname} ${parliamentarian.nachname}`,
        cantonId: parliamentarian.kanton_id,
        partyId: parliamentarian.partei_id,
      },
    });
  }

  console.log(`🟢 Fetched ${data.length} parliamentarians`);
}
