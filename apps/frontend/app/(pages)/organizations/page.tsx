import { range } from "rambdax"

import { SidebarNav } from "@/components/nav"

import { PageHeader } from "../../../components/header"
import { PageShell } from "../../../components/shell"
import { Card } from "../../../components/ui/card"

import { LobbyOrg } from "../../../components/organizations/lobbyorg"

export const metadata = {
  title: "Organizations",
  description: "Explore different lobby organizations",
}

export default async function OrganizationsPage() {

// <svg id="fullscreen-svg">
//   <!-- Your SVG content goes here -->
//   <rect x="50" y="50" width="100" height="100" fill="#e74c3c" />
// </svg>

  //   <div className=" grid flex-1 gap-12 md:grid-cols-[1fr_150px]">
  //     <main className="flex w-full flex-1 flex-col">
  //       <LobbyOrg />
  //     </main>
  //     <aside className="hidden w-[150px] flex-col md:flex">
  //       <Card>
  //         <span>
  //         Here comes information abou thte user selected entity (i.e. an Organization or a Parlamentarian)
  //         </span>
  //       </Card>
  //     </aside>
  //   </div>
  return (
    <PageShell>
      <PageHeader
        heading="Organiziations"
        text="Explore different Lobby Organizations"
      />
      <div className="grid gap-10">
        <main className="flex w-full flex-1 flex-col">
          <LobbyOrg />
        </main>
      </div>
    </PageShell>
  )
}
