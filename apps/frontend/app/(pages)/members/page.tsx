import { PageHeader } from "../../../components/header"
import { PageShell } from "../../../components/shell"
import { db } from "@votewatch/database"
import { groupBy } from "rambdax"
import { Parliamentarians } from "./parliamentarians"

export const metadata = {
  title: "Parliamentarians",
  description: "See what the members of the national council have been up to",
}

export default async function MembersPage() {
  // Just an example

  const members = groupBy((e) => `${e.party.fullName} (${e.party.shortName})`, await db.parliamentarian.findMany({
    include: {
      party: true,
    },
  }));

  return (
    <PageShell>
      <PageHeader
        heading="Parliamentarians"
        text="See what the members of the national council have been up to"
      />
      <Parliamentarians />
    </PageShell>
  )
}
