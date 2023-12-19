import { PageShell } from "@/components/shell"

import { CardSkeleton } from "../../../components/card-skeleton"
import { PageHeader } from "../../../components/header"

export default function BillsPageLoading() {
  return (
    <PageShell>
      <PageHeader
        heading="Bills"
        text="Explore different bills and their lobby influences"
      />
      <div className="grid gap-10">
        <CardSkeleton />
      </div>
    </PageShell>
  )
}
