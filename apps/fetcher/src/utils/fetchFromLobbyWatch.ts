const PARLIAMENTARIANS_ENDPOINT =
  "https://cms.lobbywatch.ch/de/data/interface/v1/json/query/parlament-partei/aggregated/list?limit=none";

type LobbyWatchResponse<T> = {
  success: boolean;
  count: number;
  data: T;
};

interface FetchFromLobbyWatchArgs {
  apiUrl: string;
}

export async function fetchFromLobbyWatch<T>({
  apiUrl,
}: FetchFromLobbyWatchArgs) {
  try {
    const response = await fetch(apiUrl);
    const body = (await response.json()) as LobbyWatchResponse<T>;

    if (body && body.success && body.data) {
      return body.data as T;
    }
  } catch (err) {
    throw err;
  }
}
