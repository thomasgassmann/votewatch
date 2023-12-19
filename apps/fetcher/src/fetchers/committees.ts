import { InfluenceLevel, db } from "@votewatch/database";
import { fetchFromLobbyWatch } from "../utils/fetchFromLobbyWatch";

type LobbyWatchCommitteeRelation = {
  kommission_id: string;
  //name: string;
  kommission_name: string;
  parlamentarier_id: string;
  funktion: string; // Currently unused
  parliament_committee_function_name: string; // Currently unused
};

export async function fetchCommittees() {
  const data = await fetchFromLobbyWatch<LobbyWatchCommitteeRelation[]>({
    apiUrl:
      "https://cms.lobbywatch.ch/de/data/interface/v1/json/table/in_kommission/flat/list?limit=none",
  });

  if (!data) {
    throw Error("⛔️ Failed to fetch list of committees of parliamentarians");
  }

  var skipped = 0;

  for (const connection of data) {
    // LobbyWatch API returns over 10k interest connections, many of which are about parlamentarians/organizations that we don't get any data about so we need to filter these out before trying to update our database records
    const shouldSkip =
      (await db.parliamentarian.findUnique({
        where: { id: connection.parlamentarier_id },
      })) === null;

    if (shouldSkip) {
      skipped++;
      continue;
    }
    await db.committee.upsert({
      where: {
        id: connection.kommission_id,
      },
      create: {
        id: connection.kommission_id,
        name: connection.kommission_name,
        parliamentarians: {
          connect: [
            {
              id: connection.parlamentarier_id,
            },
          ],
        },
      },
      update: {
        parliamentarians: {
          connect: [
            {
              id: connection.parlamentarier_id,
            },
          ],
        },
      },
    });
  }

  console.log(
    `🟢 Fetched ${data.length} connections between parliament and committees, skipped ${skipped} outdated records`,
  );
}
