import { ListItem } from "@/components/list-item"

import { PageHeader } from "../../../components/header"
import { PageShell } from "../../../components/shell"
import { db } from "@votewatch/database"
import { groupBy } from "rambdax"

export const metadata = {
  title: "Parliamentarians",
  description: "See what the members of Parliament have been up to",
}

export default async function BillsOverviewPage() {
  // Just an example

  const members = groupBy((e) => `${e.party.fullName} (${e.party.shortName})`, await db.parliamentarian.findMany({
    include: {
      party: true,
    },
  }))

  return (
    <PageShell>
      <PageHeader
        heading="Parliamentarians"
        text="See what the members of Parliament have been up to"
      />
      <div className="grid gap-10">
        <div className="rounded-md border">
          {Object.entries(members).map(entry => <div>
            <h3>{entry[0]}</h3>
            <div className="flex w-full divide-x overflow-auto">
          {entry[1].map((member) => (
            <ListItem
              key={member.id}
              name={member.firstName + ' ' + member.lastName}
              description={`${member.party.fullName || member.party.shortName}`}
            />
          ))}
          </div></div>)}
        </div>
      </div>
      <pre className="font-mono">{JSON.stringify(members, null, 2)}</pre>
    </PageShell>
  )
}
