import { ListItem } from "@/components/list-item"

import { PageHeader } from "../../../components/header"
import { PageShell } from "../../../components/shell"
import { db } from "@votewatch/database"

export const metadata = {
  title: "Bills",
  description: "Explore different bills and their lobby influences",
}

export default async function BillsOverviewPage() {
  // Small Example how one can use Server Components and Prisma
  const acceptedBills = await db.bill.findMany({
    where: {
      voteResult: "YES",
    },
    include: {
      sponsor: {
        include: {
          party: true,
        },
      },
    },
  })

  return (
    <PageShell>
      <PageHeader
        heading="Bills"
        text="Explore different bills and their lobby influences"
      />
      <div className="grid gap-10">
        <div>
          {acceptedBills.map((bill) => (
            <ListItem
              key={bill.id}
              name={bill.title}
              description={`${bill.sponsor.firstName} from ${bill.sponsor.party.shortName} proposed: ${bill.billText}`}
            />
          ))}
        </div>
      </div>
      <pre className="font-mono">{JSON.stringify(acceptedBills, null, 2)}</pre>
    </PageShell>
  )
}
