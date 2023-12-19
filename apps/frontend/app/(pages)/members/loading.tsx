import { PageShell } from "@/components/shell"

import { CardSkeleton } from "../../../components/card-skeleton"
import { PageHeader } from "../../../components/header"

export default function ParliamentariansPageLoading() {
  return (
    <PageShell>
      <PageHeader
        heading="Parliamentarians"
        text="See what the members of Parliament have been up to"
      />
      <div className="grid gap-10">
        <CardSkeleton />
      </div>
    </PageShell>
  )
}
