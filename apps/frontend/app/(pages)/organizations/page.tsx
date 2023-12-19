import { range } from "rambdax"

import { SidebarNav } from "@/components/nav"

import { PageHeader } from "../../../components/header"
import { PageShell } from "../../../components/shell"

export const metadata = {
  title: "Organizations",
  description: "Explore different lobby organizations",
}

export default async function OrganizationsPage() {
  return (
    <PageShell>
      <PageHeader
        heading="Organiziations"
        text="Explore different Lobby Organizations"
      />
      <div className="grid gap-10">
        <div className=" grid flex-1 gap-12 md:grid-cols-[200px_1fr]">
          <aside className="hidden w-[200px] flex-col md:flex">
            <SidebarNav
              items={range(1, 10).map((i) => ({
                title: "Organization " + i,
                icon: "page",
                href: "/",
              }))}
            />
          </aside>

          <main className="flex w-full flex-1 flex-col overflow-hidden">
            Visualization here
          </main>
        </div>
      </div>
    </PageShell>
  )
}
