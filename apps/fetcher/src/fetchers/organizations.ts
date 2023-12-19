import { db } from "@votewatch/database";
import { fetchFromLobbyWatch } from "../utils/fetchFromLobbyWatch";

type LobbyWatchOrganization = {
  id: string;
  anzeige_name: string;
  rechtsform: string;
  beschreibung: string;
  interessengruppe_id: string | null;
  interessengruppe2_id: string | null;
  interessengruppe3_id: string | null;
};

export async function fetchLobbyOrganizations() {
  const data = await fetchFromLobbyWatch<LobbyWatchOrganization[]>({
    apiUrl:
      "https://cms.lobbywatch.ch/de/data/interface/v1/json/table/organisation/flat/list?limit=none",
  });

  if (!data) {
    throw Error("⛔️ Failed to fetch list of lobby organizations");
  }

  Promise.all(
    data.map((organisation) => {
      const interestGroups = [];

      if (organisation.interessengruppe_id)
        interestGroups.push({
          id: organisation.interessengruppe_id,
        });

      if (organisation.interessengruppe2_id)
        interestGroups.push({
          id: organisation.interessengruppe2_id,
        });

      if (organisation.interessengruppe3_id)
        interestGroups.push({
          id: organisation.interessengruppe3_id,
        });

      return db.lobbyOrganization.upsert({
        where: {
          id: organisation.id,
        },
        update: {},
        create: {
          id: organisation.id,
          name: organisation.anzeige_name,
          rechtsform: organisation.rechtsform,
          interestsGroups: {
            connect: interestGroups,
          },
        },
      });
    }),
  );

  console.log(`🟢 Fetched ${data.length} lobby organizations`);
}
