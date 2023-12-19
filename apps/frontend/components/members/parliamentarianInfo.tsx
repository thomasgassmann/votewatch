import { Parliamentarian } from "./council";
import { AvatarImage, AvatarFallback, Avatar } from "@/components/ui/avatar"
import { Badge } from "@/components/ui/badge"
import { CardContent, Card, CardHeader } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { TabsTrigger, TabsList, TabsContent, Tabs } from "@/components/ui/tabs"
import Link from "next/link"
import { FC } from "react";
import { OrganizationEntry, ParliamentarianEntry } from "./parliamentarians";

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
            entry && <div className="grid grid-cols-1 gap-6">
              {
                entry.organizations
                .sort((a, b) => influenceLevelToNumeric(a.influenceLevel) - influenceLevelToNumeric(b.influenceLevel))
                .map(x =>
                  <div key={x.name} className="mb-4">
                    <Card className="overflow-hidden rounded-xl shadow-lg">
                      <CardHeader className="flex items-center justify-between bg-gray-100 p-4">
                        <h2 className="text-2xl font-semibold">{x.name}</h2>
                        <Badge className="items-center bg-green-200 text-green-700">
                          {x.rechtsform}
                        </Badge>
                      </CardHeader>
                      <CardContent className="p-4">
                        <div className="grid grid-cols-3 gap-6">
                          <p className="mb-2 text-gray-700">
                            Influence Level: <span className="font-bold">{x.influenceLevel}</span>
                          </p>
                          {x.vergueting && <p className="mb-2 text-gray-700">
                            Potential Salary: <span className="font-bold">{x.vergueting}</span>
                          </p>}
                          {x.position && <p className="mb-4 text-gray-700">
                            Position: <span className="font-bold">{x.position}</span>
                          </p>}
                        </div>
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
          <div className="mb-4">
            <h3 className="text-lg font-semibold">Vote 1</h3>
            <p className="text-sm text-gray-500 dark:text-gray-400">Details about Vote 1.</p>
            <Link className="text-blue-500 underline" href="#">
              Learn More
            </Link>
          </div>
        </TabsContent>
        <TabsContent className="p-1" value="committees">
          {
            entry && entry.committees.map(x => <div className="mb-4">
              <h3 className="text-lg font-semibold">{x.name}</h3>
            </div>)
          }
          {
            (!entry || entry.organizations.length === 0) && <p className="text-center">No information for this councilor.</p>
          }
        </TabsContent>
      </Tabs>
    </section>
  </main>;
};
