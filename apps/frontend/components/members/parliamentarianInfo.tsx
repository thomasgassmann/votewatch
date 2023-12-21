import { Parliamentarian } from "./council";
import { AvatarImage, AvatarFallback, Avatar } from "@/components/ui/avatar"
import { Badge } from "@/components/ui/badge"
import { CardContent, Card, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { TabsTrigger, TabsList, TabsContent, Tabs } from "@/components/ui/tabs"
import Link from "next/link"
import { FC } from "react";
import { OrganizationEntry, ParliamentarianEntry } from "./parliamentarians";
import LobbyStrengthExplaination from "./lobby-strength-explaination";

export type ParliamentarianProps = {
  parliamentarian: Parliamentarian;
  entry: ParliamentarianEntry | null;
};

const influenceLevelToNumeric = (level: Pick<OrganizationEntry, 'influenceLevel'>['influenceLevel']): number => {
  switch (level) {
    case 'HOCH':
      return 3;
    case 'MITTEL':
      return 2;
    case 'TIEF':
      return 1;
    case 'UNKNOWN':
    default:
      return 0;
  }
}

const influenceLevelToColor = (level: Pick<OrganizationEntry, 'influenceLevel'>['influenceLevel']): string => {
  switch (level) {
    case 'HOCH':
      return '#FF5733';
    case 'MITTEL':
      return '#3498DB';
    case 'TIEF':
      return '#27AE60';
    case 'UNKNOWN':
    default:
      return '#848484';
  }
}

export const ParliamentarianInfo: FC<ParliamentarianProps> = ({ parliamentarian, entry }) => {
  return <main className="lg:flex lg:space-x-10">
    <aside className="lg:w-1/4">
      <Card className="mb-6">
        <CardContent className="p-6">
          <div className="mb-6 flex items-center space-x-4">
            <Avatar className="h-20 w-20">
              <AvatarImage alt={parliamentarian.name} src={parliamentarian.imageUrl} />
              <AvatarFallback>PN</AvatarFallback>
            </Avatar>
            <div>
              <h2 className="text-xl font-bold">{parliamentarian.name}</h2>
              <Badge className="mt-2" style={{
                backgroundColor: parliamentarian.groupColor
              }}>{parliamentarian.groupName}</Badge>
            </div>
          </div>
          {entry && <p className="text-gray-500 dark:text-gray-400">
            {entry.canton} - {entry.partyFullName}
          </p>}
          {!entry && <p className="text-gray-500 dark:text-gray-400">
            Lobbywatch does not have any information for this councilor.
          </p>}
        </CardContent>
      </Card>
      <Link href={parliamentarian.infoUrl}>
        <Button className="w-full" size="lg" variant="outline">
          More Information
        </Button>
      </Link>
    </aside>
    <section className="lg:w-3/4">
      <Tabs className="flex flex-col items-start gap-2" defaultValue="lobbying">
        <TabsList className="w-full justify-start border-b">
          <TabsTrigger value="lobbying">Lobbying Organizations</TabsTrigger>
          <TabsTrigger value="votes">Votes</TabsTrigger>
          <TabsTrigger value="committees">Committees</TabsTrigger>
        </TabsList>
        <TabsContent className="p-1" value="lobbying">
          {
            entry && <div className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3">
              {
                entry.organizations
                  .sort((a, b) => influenceLevelToNumeric(b.influenceLevel) - influenceLevelToNumeric(a.influenceLevel))
                  .map(x =>
                    <div key={x.name} className="mb-4">
                      <Card className="rounded-md bg-white p-4 shadow-sm dark:bg-gray-900">
                        <CardHeader className="flex items-center space-x-4">
                          <div>
                            <h3 className="text-lg font-semibold">{x.name}</h3>
                            <p className="text-sm text-gray-500 dark:text-gray-400">{x.rechtsform}{x.position ? `, ${x.position}` : ''}</p>
                          </div>
                        </CardHeader>
                        <CardContent className="mt-2 space-y-2">
                          <Badge style={{ backgroundColor: influenceLevelToColor(x.influenceLevel) }}>
                            {x.influenceLevel}
                          </Badge>
                          <p className="mt-2 text-sm">
                            <LobbyStrengthExplaination />
                          </p>
                          {x.vergueting && <p className="text-gray-700 dark:text-gray-300">Vergütung: {x.vergueting}</p>}
                        </CardContent>
                      </Card>
                    </div>)
              }
            </div>
          }
          {
            (!entry || entry.organizations.length === 0) && <p className="text-center">No information for this councilor.</p>
          }
        </TabsContent>
        <TabsContent className="p-1" value="votes">
          {
            entry && <ul className="grid gap-6"> {entry.bills.map(x =>
              <li key={x.title}>
                <Card>
                  <CardHeader>
                    <CardTitle>{x.title}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div>
                      Councilor Vote:{" "}
                      {x.voteResult === 'YES' && <Badge className="bg-green-200 text-green-800" variant="outline">
                        Yes
                      </Badge>}
                      {x.voteResult === 'NO' && <Badge className="bg-red-200 text-red-800" variant="outline">
                        No
                      </Badge>}
                      {x.voteResult === 'UNKNOWN' && <Badge className="bg-red-200 text-red-800" variant="outline">
                        Unknown
                      </Badge>}
                    </div>
                    <div>
                      Final Vote:{" "}
                      {x.finalVoteResult === 'YES' && <Badge className="bg-green-200 text-green-800" variant="outline">
                        Yes
                      </Badge>}
                      {x.finalVoteResult === 'NO' && <Badge className="bg-red-200 text-red-800" variant="outline">
                        No
                      </Badge>}
                      {x.finalVoteResult === 'UNKNOWN' && <Badge className="bg-red-200 text-red-800" variant="outline">
                        Unknown
                      </Badge>}
                    </div>
                  </CardContent>
                </Card>
              </li>)}
            </ul>
          }
          {
            (!entry || entry.bills.length === 0) && <p className="text-center">No information for this councilor.</p>
          }
        </TabsContent>
        <TabsContent className="p-1" value="committees">
          {
            entry && entry.committees.map(x => <ul className="m-3 list-disc" key={x.name}>
              <li className="text-lg">{x.name}</li>
            </ul>)
          }
          {
            (!entry || entry.organizations.length === 0) && <p className="text-center">No information for this councilor.</p>
          }
        </TabsContent>
      </Tabs>
    </section>
  </main>;
};
