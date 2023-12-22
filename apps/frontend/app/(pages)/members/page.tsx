import { ParliamentarianEntry, Parliamentarians } from "@/components/members";
import { PageHeader } from "../../../components/header"
import { PageShell } from "../../../components/shell"
import { db } from "@votewatch/database"
import Link from "next/link";

export const metadata = {
  title: "Parliamentarians",
  description: "See what the members of the national council have been up to",
}

export default async function MembersPage() {
  // Just an example

  const members = await db.parliamentarian.findMany({
    include: {
      party: true,
      relatedOrganizations: true,
      bills: true,
      votes: {
        include: {
          bill: true,
        }
      },
      committees: true,
      canton: true
    },
  });

  const organizations = await db.lobbyOrganization.findMany();

  const mps = members.map<ParliamentarianEntry>(x => ({
    id: x.id,
    firstName: x.firstName,
    lastName: x.lastName,
    canton: x.canton.name,
    committees: x.committees.map(x => ({
      name: x.name
    })),
    bills: x.votes.map(v => ({
      id: v.billId,
      title: v.bill.title,
      billText: "",
      voteResult: v.voteStatus,
      finalVoteResult: v.bill.voteResult
    })),
    partyFullName: x.party.fullName,
    partyShortName: x.party.shortName,
    organizations: x.relatedOrganizations.map(x => ({
      name: organizations.find(p => p.id === x.organizationId)!.name,
      rechtsform: organizations.find(p => p.id === x.organizationId)!.rechtsform,
      influenceLevel: x.influenceLevel,
      vergueting: x.verguetung,
      position: x.position
    }))
  }));

  return (
    <PageShell>
      <PageHeader
        heading="Parliamentarians"
        text="See what the members of the national council have been up to. Each dot or square represents one member of the national council, the color strength represents the connectedness with various lobbying groups, the color itself represents the parliamentary group."
      />
      <Parliamentarians entries={mps} />
    </PageShell>
  )
}
