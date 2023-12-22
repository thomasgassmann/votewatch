import { Bill, Parliamentarian, ParliamentarianVote } from "@votewatch/database";
import { Card, CardContent, CardHeader } from "../ui/card";
import { Avatar, AvatarImage } from "../ui/avatar";
import { Button } from "react-day-picker";
import BillPie from "./BillPieChart";
import { Badge } from "../ui/badge";
import { cn } from "@/lib/utils";
import { BillVoteResults } from "./BillVoteResults";
import { BillVoteInterests } from "./BillVoteInterests";
import { Alert, AlertDescription, AlertTitle } from "../ui/alert";
import { InfoIcon } from "lucide-react";

interface BillVisualisationProps {
  bill: Bill & { votes: (ParliamentarianVote & { parliamentarian: Parliamentarian })[]}
}
export default function BillVisualisation({ bill }: BillVisualisationProps) {
  return (
    <>
      <div>
        <Card className="mb-4">
            <CardContent className="flex pt-4">
              <div className="w-full">
                <h3 className="mb-2 text-lg font-semibold">Voting Results</h3>
                <BillVoteResults bill={bill} />
              </div>
            </CardContent>
          </Card>
        <Alert className="mb-4">
            <InfoIcon className='h-4 w-4' />
            <AlertTitle>Explore Bills that have been voted on by parliament</AlertTitle>
            <AlertDescription>
            The classification of the influence levels of a bill&apos;s sponsor, yes or no voters bases itself on a comparison to the median parliamentarian.
                  A low level indicates significantly fewer special interest connections while a high level indicates significantly more.
                  The top three standout special interest connections of a parliamentarian are listed in order of how much they influence the given group more
                  than the median parliamentarian.
            </AlertDescription>
          </Alert>
      </div>


        <BillVoteInterests bill={bill} />
{/*
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
  </div>*/}
      </>
  );
}
