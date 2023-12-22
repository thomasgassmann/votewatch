import { PageShell } from '@/components/shell';
import { PageHeader } from '@/components/header';

import { Button, buttonVariants } from '@/components/ui/button';

import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Bill, db } from '@votewatch/database';
import BillSelector from '@/components/bills/BillSelector';
import BillVisualisation from '@/components/bills/BillVisualisation';
import { Badge } from '@/components/ui/badge';
import { cn } from '@/lib/utils';
import Link from 'next/link';
import { Icons } from '@/components/icons';

export default async function BillsPage({ params }: { params: { id: string}}) {
  const bill = await db.bill.findUnique({
    where: {
      id: params.id
    },
    include: {
      votes: {
        include: {
          parliamentarian: {
            include: {
              party: true,
            }
          },
        }
      },
      sponsor: {
        include: {
          party: true,
        },
      },
    },
  })

  const billList = await db.bill.findMany({
    select: {
      id: true,
      title: true
    }
  });

  return (
    <PageShell>
      <div className="flex w-full items-center justify-between -ml-2 -mb-6">
          <Link
            href="/bills"
            className={cn(buttonVariants({ variant: "ghost", size: "sm"}))}
          >
            <>
              <Icons.chevronLeft className="mr-2 h-4 w-4" />
              Back
            </>
          </Link>
      </div>
      <PageHeader
        heading={<>{bill?.title} </>}
        text={
          <Badge variant="outline" className={
            cn("uppercase", {
              'text-green-800 border-green-800 bg-green-50': bill?.voteResult === 'YES',
              'text-red-800 border-red-800 bg-red-50': bill?.voteResult === 'NO'
            })
          }>
            { bill?.voteResult === 'YES' ? "Angenommen" : "Abgelehnt"}
          </Badge>
        }
      />
      {/* <div className="flex items-center">
        <BillSelector selectedBill={params.id} bills={billList} />
      </div> */}

      <main className="min-h-screen">
        { bill && <BillVisualisation bill={bill} />}
        {/* <Card className="mb-4">
          <CardHeader>
            <div className="flex items-center">
              <h2 className="text-lg font-semibold">Bill Selected: </h2>
              <Badge className="ml-2">{bill?.title}</Badge>
            </div>
          </CardHeader>
          <CardContent className="grid grid-cols-1 gap-4 md:grid-cols-2">
            <div>
              <h3 className="mb-2 text-lg font-semibold">Voting Results</h3>
              {bill && <BillPie data={voters} />}
            </div>
            <div>
              <h3 className="mb-2 text-lg font-semibold">Explaination:</h3>
              <p className="text-base">On this page you can select any bill that has been voted on in parliament in the proceeding legislature.
              The classification of the influence levels of a bill&apos;s sponsor, yes or no voters bases itself on a comparison to the median parliamentarian.
              A low level indicates significantly fewer special interest connections while a high level indicates significantly more.
              The top three standout special interest connections of a parliamentarian are listed in order of how much they influence the given group more
              than the median parliamentarian.
                </p>
            </div>
          </CardContent>
        </Card>

        <Card className="mb-4">
          <CardHeader>
            <h2 className="text-lg font-semibold">Bill Sponsor</h2>
          </CardHeader>
          <CardContent className="flex items-center space-x-4">
            <Avatar className="h-12 w-12">
              <AvatarImage alt="Bill Sponsor" src="/placeholder.svg?height=50&width=50" />
            </Avatar>
            <div>
              <h3 className="font-semibold">{sponsorname}</h3>
              <p className="text-sm">Special Interest Level: {sponsorclass}</p>
            </div>
            <div className="col-span-1 self-start">
              <ul className="mt-2 list-inside list-disc">
                <li>{sponsorTop3[0]}</li>
                <li>{sponsorTop3[1]}</li>
                <li>{sponsorTop3[2]}</li>
              </ul>
            </div>
            <div className="col-span-3 flex justify-start">
              <Button className="mt-2">More Details</Button>
            </div>
          </CardContent>
        </Card>

        <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
          <Card>
            <CardHeader>
              <h2 className="text-lg font-semibold">&apos;Yes&apos; Voters</h2>
            </CardHeader>
            <CardContent>
              <ul>
                <li className="mb-2 flex items-center space-x-4">
                  <Avatar className="h-8 w-8">
                    <AvatarImage src="/placeholder.svg?height=50&width=50" />
                  </Avatar>
                  <div>
                    <p className="font-semibold">Special interest influences</p>
                    <Badge>{yesclass}</Badge>
                  </div>
                  <div className="col-span-1 self-start">
                    <ul className="mt-2 list-inside list-disc">
                      <li>{yesTop3[0]}</li>
                      <li>{yesTop3[1]}</li>
                      <li>{yesTop3[2]}</li>
                    </ul>
                  </div>
                </li>
              </ul>
            </CardContent>
          </Card>
          <Card>
            <CardHeader>
              <h2 className="text-lg font-semibold">&apos;No&apos; Voters</h2>
            </CardHeader>
            <CardContent>
              <ul>
                <li className="mb-2 flex items-center space-x-4">
                  <Avatar className="h-8 w-8">
                    <AvatarImage alt="Voter 1" src="/placeholder.svg?height=50&width=50" />
                  </Avatar>
                  <div>
                    <p className="font-semibold">Special interest influences</p>
                    <Badge>{noclass}</Badge>
                  </div>
                  <div className="col-span-1 self-start">
                    <ul className="mt-2 list-inside list-disc">
                      <li>{noTop3[0]}</li>
                      <li>{noTop3[1]}</li>
                      <li>{noTop3[2]}</li>
                    </ul>
                  </div>
                </li>
              </ul>
            </CardContent>
          </Card>
        </div> */}
      </main>
    </PageShell>
  );
}
