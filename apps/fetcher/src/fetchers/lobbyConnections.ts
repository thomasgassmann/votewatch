import { InfluenceLevel, db } from "@votewatch/database";
import { fetchFromLobbyWatch } from "../utils/fetchFromLobbyWatch";

type LobbyWatchInteressenbindung = {
  id: string;
  parlamentarier_id: string;
  organisation_id: string;
  art: string;
  wirksamkeit: string;
};

const influenceLevels: Record<string, InfluenceLevel> = {
  tief: "TIEF",
  mittel: "MITTEL",
  hoch: "HOCH",
};

export async function fetchLobbyConnections() {
  const data = await fetchFromLobbyWatch<LobbyWatchInteressenbindung[]>({
    apiUrl:
      "https://cms.lobbywatch.ch/de/data/interface/v1/json/table/interessenbindung/flat/list?limit=none",
  });

  if (!data) {
    throw Error(
      "⛔️ Failed to fetch list of lobby connections of parliamentarians",
    );
  }

  var skipped = 0;

  for (const connection of data) {
    // LobbyWatch API returns over 10k interest connections, many of which are about parlamentarians/organizations that we don't get any data about so we need to filter these out before trying to update our database records
    const shouldSkip =
      (await db.parliamentarian.findUnique({
        where: { id: connection.parlamentarier_id },
      })) === null ||
      (await db.lobbyOrganization.findUnique({
        where: { id: connection.organisation_id },
      })) === null;

    if (shouldSkip) {
      // console.log(
      //   `Skipping lobby connection for person with ID ${connection.parlamentarier_id} since this is not a current member of parliament`,
      // );
      skipped++;
      continue;
    }

    // // This returns wrong data as it uses yet another ID and not the id of the relation.....
    // const verguetungsData = await fetchFromLobbyWatch<{ verguetung: string }>({
    //   apiUrl: `https://cms.lobbywatch.ch/de/data/interface/v1/json/table/interessenbindung_jahr/flat/id/${connection.id}`,
    // });

    await db.parliamentarianRelatedToOrganization.upsert({
      where: {
        parliamentarianId_organizationId: {
          parliamentarianId: connection.parlamentarier_id,
          organizationId: connection.organisation_id,
        },
      },
      create: {
        parliamentarianId: connection.parlamentarier_id,
        organizationId: connection.organisation_id,
        position: connection.art,
        influenceLevel: influenceLevels[connection.wirksamkeit] ?? "UNKNOWN",
        // verguetung: verguetungsData?.verguetung,
      },
      update: {
        parliamentarianId: connection.parlamentarier_id,
        organizationId: connection.organisation_id,
        position: connection.art,
        influenceLevel: influenceLevels[connection.wirksamkeit] ?? "UNKNOWN",
        // verguetung: verguetungsData?.verguetung,
      },
    });
  }

  console.log(
    `🟢 Fetched ${data.length} lobby connections of parliamentarians, skipped ${skipped} outdated records`,
  );
}
