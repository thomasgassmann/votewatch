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

export type Branch2PartyEdge = {
  source: number;
  target: number;
  influence_strength: number;
};

export type NetworkGraph = {
  nodes: NetworkNode[];
  party2parl_idtrees: {
    root_id: number;
    children_id: number[];
    influence_strength: number[];
  }[];
  branch2org_idtrees: {
    root_id: number;
    children_id: number[];
    influence_strength: number[];
  }[];
  branch2party_edges: Branch2PartyEdge[];
};

export default async function OrganizationsPage() {
  const parliamentarians = await db.parliamentarian.findMany({
    include: {
      relatedOrganizations: true
    }
  });
  const parties = await db.party.findMany({
    include: {
      members: true
    }
  });
  const interestGroups = await db.interestGroup.findMany({
    include: {
      lobbyOrganizations: true
    }
  });
  const organizations = await db.lobbyOrganization.findMany({
    include: {
      interestsGroups: true
    }
  });

  let id = 0;
  const parliamentarianIds = new Map<string, number>();
  for (const parliamentarian of parliamentarians) {
    parliamentarianIds.set(parliamentarian.id, id++);
  }

  const partyIds = new Map<string, number>();
  for (const party of parties) {
    partyIds.set(party.id, id++);
  }

  const organizationIds = new Map<string, number>();
  for (const organization of organizations) {
    organizationIds.set(organization.id, id++);
  }

  const branchId = new Map<string, number>();
  const branchOrgs = new Map<string, number[]>();
  for (const interestGroup of interestGroups) {
    branchId.set(interestGroup.branche, id++);

    if (!branchOrgs.has(interestGroup.branche)) {
      branchOrgs.set(interestGroup.branche, []);
    }

    const current = branchOrgs.get(interestGroup.branche)!;
    branchOrgs.set(interestGroup.branche, [
      ...current,
      ...interestGroup.lobbyOrganizations.map(x => organizationIds.get(x.id)!)
    ]);
  }

  const branch2Party = new Map<number, Set<number>>();
  const branch2PartyStrength = new Map<number, Map<number, number>>();
  let maxStrength = 0;
  for (const parliamentarian of parliamentarians) {
    for (const organization of parliamentarian.relatedOrganizations) {
      const org = organizations.find(x => x.id === organization.organizationId)!;
      const branches = new Set<string>(org.interestsGroups.map(x => x.branche));
      for (const branch of Array.from(branches.values())) {
        const currentBranchId = branchId.get(branch)!;
        const partyId = partyIds.get(parliamentarian.partyId)!;
        const r = branch2Party.get(currentBranchId) ?? new Set<number>();
        branch2Party.set(currentBranchId, new Set<number>([...Array.from(r.values()), partyId]));
        if (!branch2PartyStrength.has(currentBranchId)) {
          branch2PartyStrength.set(currentBranchId, new Map<number, number>());
        }

        const currentValue = (branchOrgs.get(branch)?.length ?? 0) +
        (parties.find(x => x.id === parliamentarian.partyId)?.members.length ?? 0);
        maxStrength = Math.max(currentValue, maxStrength);
        branch2PartyStrength.get(currentBranchId)!.set(partyId, currentValue);
      }
    }
  }

  const graph: NetworkGraph = {
    nodes: parties.map<NetworkNode>(x => ({
      id: partyIds.get(x.id)!,
      name: x.fullName,
      category: 'party'
    })).concat(Array.from(branchId.keys()).map<NetworkNode>(x => ({
      id: branchId.get(x)!,
      category: 'branch',
      name: x
    }))),
    party2parl_idtrees: parties.map(x => ({
      root_id: partyIds.get(x.id)!,
      children_id: [],
      influence_strength: []
    })),
    branch2org_idtrees: Array.from(branchId.keys()).map(x => {
      return {
        root_id: branchId.get(x)!,
        children_id: [],
        influence_strength: []
      };
    }),
    branch2party_edges: Array.from(branch2Party.keys()).flatMap<Branch2PartyEdge>(x =>
      Array.from(branch2Party.get(x)!.values()).map<Branch2PartyEdge>(p => ({
        source: x,
        target: p,
        influence_strength: (branch2PartyStrength.get(x)?.get(p) ?? 0) / maxStrength
      })))
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
