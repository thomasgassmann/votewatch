import { PageHeader } from "../../../components/header"
import { PageShell } from "../../../components/shell"

export const metadata = {
  title: "Settings",
  description: "Manage account settings.",
}

export default async function SettingsPage() {
  return (
    <PageShell>
      <PageHeader heading="Settings" text="Some settings here" />
      <div className="grid gap-10">Test</div>
    </PageShell>
  )
}
