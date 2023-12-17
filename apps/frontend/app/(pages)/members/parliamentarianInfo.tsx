import { Parliamentarian } from "./council";
import { AvatarImage, AvatarFallback, Avatar } from "@/components/ui/avatar"
import { Badge } from "@/components/ui/badge"
import { CardContent, Card } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { TabsTrigger, TabsList, TabsContent, Tabs } from "@/components/ui/tabs"
import Link from "next/link"
import { FC } from "react";

export type ParliamentarianProps = {
  parliamentarian: Parliamentarian;
};

export const ParliamentarianInfo: FC<ParliamentarianProps> = ({ parliamentarian }) => {
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
          <p className="text-gray-500 dark:text-gray-400">
            {parliamentarian.canton}
          </p>
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
          <div className="mb-4">
            <h3 className="text-lg font-semibold">Organization 1</h3>
            <p className="text-sm text-gray-500 dark:text-gray-400">
              Details about Organization 1's lobbying activities.
            </p>
            <Link className="text-blue-500 underline" href="#">
              Learn More
            </Link>
          </div>
          <TabsContent className="p-1" value="votes">
            <div className="mb-4">
              <h3 className="text-lg font-semibold">Vote 1</h3>
              <p className="text-sm text-gray-500 dark:text-gray-400">Details about Vote 1.</p>
              <Link className="text-blue-500 underline" href="#">
                Learn More
              </Link>
            </div>
            <TabsContent className="p-1" value="committees">
              <div className="mb-4">
                <h3 className="text-lg font-semibold">Committee 1</h3>
                <p className="text-sm text-gray-500 dark:text-gray-400">Details about Committee 1.</p>
                <Link className="text-blue-500 underline" href="#">
                  Learn More
                </Link>
              </div>
            </TabsContent>
          </TabsContent>
        </TabsContent>
      </Tabs>
    </section>
  </main>;
};
