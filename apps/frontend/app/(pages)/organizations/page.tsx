import { range } from "rambdax"

import { SidebarNav } from "@/components/nav"

import { PageHeader } from "../../../components/header"
import { PageShell } from "../../../components/shell"

import { Card } from "../../../components/ui/card"
import { Button } from "../../../components/ui/button"



import { db } from '@votewatch/database';

import { LobbyOrg } from "../../../components/organizations/lobbyorg"

export const metadata = {
  title: "Organizations",
  description: "Explore different lobby organizations",
}

export type NetworkNode = {
  id: number;
  name: string;
  category: 'party' | 'branch' | 'org' | 'parl';
};

export type NetworkGraph = {
  nodes: NetworkNode[];
  party2parl_idtrees: {
    root_id: number;
    children_id: number[];
  }[];
  branch2org_idtrees: {
    root_id: number;
    children_id: number[];
  }[];
  branch2party_edges: {
    source: number;
    target: number;
  }[];
};

export default async function OrganizationsPage() {
  const parliamentarians = await db.parliamentarian.findMany({
  });
  const parties = await db.party.findMany({
    include: {
      members: true
    }
  });
  const branches = await db.interestGroup.findMany();
  const organizations = await db.lobbyOrganization.findMany();

  let id = 0;
  const parliamentarianIds = new Map<string, number>();
  for (const parliamentarian of parliamentarians) {
    parliamentarianIds.set(parliamentarian.id, id++);
  }

  const partyIds = new Map<string, number>();
  for (const party of parties) {
    partyIds.set(party.id, id++);
  }

  const graph: NetworkGraph = {
    nodes: parliamentarians.map<NetworkNode>(x => ({
      id: parliamentarianIds.get(x.id)!,
      name: x.firstName + ' ' + x.lastName,
      category: 'parl'
    })).concat(parties.map<NetworkNode>(x => ({
      id: partyIds.get(x.id)!,
      name: x.fullName,
      category: 'party'
    }))),
    party2parl_idtrees: parties.map(x => ({
      root_id: partyIds.get(x.id)!,
      children_id: x.members.map(p => parliamentarianIds.get(p.id)!)
    })),
    branch2org_idtrees: [],
    branch2party_edges: []
  };

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
          <LobbyOrg lobbyOrgData={graph} />
        </main>
      </div>
    </PageShell>
  )
}
