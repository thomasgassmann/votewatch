import { PageShell } from "@/components/shell"

import { CardSkeleton } from "../../../components/card-skeleton"
import { PageHeader } from "../../../components/header"

export default function OrganizationPageLoading() {
  return (
    <PageShell>
      <PageHeader
        heading="Organiziations"
        text="Explore sectors of the economy, industry and politics that are active in lobbying."
      />
      <div className="grid gap-10">
        <CardSkeleton />
      </div>
    </PageShell>
  )
}
