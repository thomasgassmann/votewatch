import { PageShell } from "@/components/shell"

import { CardSkeleton } from "../../../components/card-skeleton"
import { PageHeader } from "../../../components/header"

export default function DashboardSettingsLoading() {
  return (
    <PageShell>
      <PageHeader heading="Settings" text="Some settings here" />
      <div className="grid gap-10">
        <CardSkeleton />
      </div>
    </PageShell>
  )
}
