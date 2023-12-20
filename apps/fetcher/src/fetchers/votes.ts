import { VoteStatus, db } from "@votewatch/database";
import * as swissparl from "swissparl";

export default async function fetchVotes() {
  const acceptedStates = [3, 20, 36];
  const deniedStates = [22, 56, 63];

  const placeholderParlamentarian = await db.parliamentarian.findFirst({});

  const data = await swissparl.fetchCollection<swissparl.Session>(
    swissparl.Collection.Session,
    {
      filter: { eq: [{ LegislativePeriodNumber: 52 }] },
      expand: ["Votes"],
    },
  );

  const voteIds = data
    // @ts-expect-error The typings of the API wrapper are incorrect, we need to access the result attribute to really get the data
    .flatMap((session) => session.Votes?.results)
    .map((vote) => vote?.ID);

  console.log(voteIds);
  // console.log(
  //   "Filters",
  //   voteIds.map((id) => ({ ID: id as number })),
  // );

  // Refetch so we can get the actual "votings" objects

  let count = 0;
  for (const id of voteIds) {
    const votes = await swissparl.fetchCollection<swissparl.Vote>(
      swissparl.Collection.Vote,
      {
        // top: 1,
        filter: {
          eq:
            // [ { ID: 6843 } ]
            [{ ID: id }, { Language: "DE" }],
        },
        expand: ["Votings"],
      },
    );

    const parliamentarianVotes = (votes[0].Votings as any)
      .results as swissparl.Voting[];

    // console.log(`======= ${id} =========`);
    // console.log(votes);
    // console.log("----");
    // console.log(votes[0].Votings?.results.length);

    const bills = await swissparl.fetchCollection<swissparl.Bill>("Bill", {
      filter: {
        eq: [
          { BusinessNumber: votes[0].Votings?.results[0].BusinessNumber },
          { Language: "DE" },
        ],
      },
      expand: ["BillStates", "Resolutions"],
    });

    const bill = bills[0];

    // This keeps track of if the bill got accepted or denied
    // @ts-ignore

    console.log(bill.Resolutions?.results);
    // @ts-ignore
    if (!bill.Resolutions?.results || bill.Resolutions.results.length === 0) {
      continue;
    }

    // @ts-ignore
    const resolutionId = bill.Resolutions.results.find(
      // @ts-ignore
      (x) =>
        acceptedStates.includes(x.ResolutionId) ||
        deniedStates.includes(x.ResolutionId),
    )?.ResolutionId;

    const resolution = acceptedStates.includes(resolutionId) ? "YES" : "NO";

    console.log("Resolution is", resolution);

    if (!resolution) {
      continue;
    }

    await db.bill.upsert({
      where: {
        id: bill.ID,
      },
      update: {
        id: bill.ID!,
        title: bill.Title!,
        billText: "",
        // TODO: FIND THIS SOMEWHERE IN THE DATA
        sponsorId: placeholderParlamentarian?.id,
        voteResult: resolution,
      },
      create: {
        id: bill.ID!,
        title: bill.Title!,
        billText: "",
        // TODO: FIND A WAY TO REPLACE THIS???
        sponsorId: placeholderParlamentarian?.id,
        voteResult: resolution,
      },
    });

    for (const parliamentarianVote of parliamentarianVotes!) {
      // Fetch parliamentarian with name
      const parlamentarian = await db.parliamentarian.findFirst({
        where: {
          firstName: parliamentarianVote.FirstName,
          lastName: parliamentarianVote.LastName,
        },
      });

      if (parlamentarian === null) {
        continue;
      }

      await db.bill.update({
        where: {
          id: bill.ID,
        },
        data: {
          votes: {
            connectOrCreate: {
              where: {
                parliamentarianId_billId: {
                  billId: bill.ID!,
                  parliamentarianId: parlamentarian!.id,
                },
              },
              create: {
                parliamentarianId: parlamentarian!.id,
                voteStatus:
                  parliamentarianVote.DecisionText === "Ja"
                    ? "YES"
                    : parliamentarianVote.DecisionText === "Nein"
                      ? "NO"
                      : "UNKNOWN",
              },
            },
          },
        },
      });
    }
  }

  if (!data) {
    throw Error("⛔️ Failed to fetch bills and votes");
  }

  console.log(`🟢 Finished fetching bills and votes`);
}
