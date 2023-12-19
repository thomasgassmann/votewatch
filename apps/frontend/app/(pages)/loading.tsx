import { PageHeader } from "../../components/header"
import { ListItem } from "../../components/list-item"
import { PageShell } from "../../components/shell"

export default function AppLoading() {
  return (
    <PageShell>
      <PageHeader heading="" text="" />
      <div className="divide-border-200 divide-y rounded-md border">
        <ListItem.Skeleton />
        <ListItem.Skeleton />
        <ListItem.Skeleton />
        <ListItem.Skeleton />
        <ListItem.Skeleton />
      </div>
    </PageShell>
  )
}
