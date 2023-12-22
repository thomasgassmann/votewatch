import { Bill, InfluenceLevel, Parliamentarian, ParliamentarianVote, db } from "@votewatch/database";
import BillPie from "./BillPieChart";
import { Card, CardContent, CardHeader } from "../ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "../ui/avatar";
import { Badge } from "../ui/badge";
import seats from '../members/seats.json';

interface BillVoteResultsProps {
  bill: Bill & { votes: (ParliamentarianVote & { parliamentarian: Parliamentarian })[]}

}
export async function BillVoteInterests({ bill }: BillVoteResultsProps) {
  const votes = {
    yesVotes: bill.votes.filter(vote => vote.voteStatus === 'YES'),
    noVotes: bill.votes.filter(vote => vote.voteStatus === 'NO'),
    unknownVotes: bill.votes.filter(vote => vote.voteStatus === 'UNKNOWN')
  }

  const parlamentarianCount = await db.parliamentarian.count();
  const avgMap = await generateOrgScores(parlamentarianCount);
  const averageScoreAmount = avgMap.totalScore; // / parlamentarianCount;

  const yesVotesScores = await generateOrgScores(votes.yesVotes.length, votes.yesVotes.map(v => v.parliamentarianId))

  var yesVotersClassification = "Low";
  if (yesVotesScores.totalScore > (averageScoreAmount + avgMap.highestScore) / 2) {
    yesVotersClassification = "High";
  } else if (yesVotesScores.totalScore > averageScoreAmount * 0.667) {
    yesVotersClassification = "Medium";
  }

  const top3Yes = Array.from(Array.from(yesVotesScores.scores.entries()).sort((a, b) => (b[1] - (avgMap.scores.get(b[0]) ?? 0)) - a[1] - (avgMap.scores.get(a[0]) ?? 0)).map(e => e[0])).slice(0,3);

  const noVotesScores = await generateOrgScores(votes.noVotes.length, votes.noVotes.map(v => v.parliamentarianId))

  var noVotersClassification = "Low";
  if (noVotesScores.totalScore > (averageScoreAmount + avgMap.highestScore) / 2) {
    noVotersClassification = "High";
  } else if (yesVotesScores.totalScore > averageScoreAmount * 0.667) {
    noVotersClassification = "Medium";
  }

  const top3No = Array.from(Array.from(noVotesScores.scores.entries()).sort((a, b) => (b[1] - (avgMap.scores.get(b[0]) ?? 0)) - a[1] - (avgMap.scores.get(a[0]) ?? 0)).map(e => e[0])).slice(0,3);


  const yesOrganizations = await db.lobbyOrganization.findMany({
    where: {
      id: {
        in: top3Yes
      }
    }
  })

  const noOrganizations = await db.lobbyOrganization.findMany({
    where: {
      id: {
        in: top3No
      }
    }
  })


  return (
    <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
          <Card>
            <CardHeader>
              <h2 className="text-5xl font-bold text-green-800 mt-5">
                Ja
              </h2>
            </CardHeader>
            <CardContent>
                <div className="mb-2 flex items-center space-x-6">
                  <div className="shrink-0 flex-1">
                    <p className="font-semibold">Special interest influences</p>
                    <Badge>{yesVotersClassification}</Badge>
                  </div>
                  <div className="col-span-1 self-start">
                    <ul className="mt-2 list-inside list-disc">
                      { yesOrganizations.map(org => <li>{ org.name }</li>)}
                    </ul>
                  </div>
                </div>
                <div className="flex flex-wrap w-full gap-2 mt-16">
                  { votes.yesVotes.map(vote =>
                  <Link href={`/members/?id=${vote.parliamentarianId}`}>
                  <Avatar className="h-12 w-12 border border-gray-300 rounded-full shadow">
                    <AvatarImage alt={vote.parliamentarian.firstName + " " + vote.parliamentarian.lastName} src={parliamentarianFromSeatsInformation(getSeatNumberFromName(`${vote.parliamentarian.lastName} ${vote.parliamentarian.firstName}`)).imageUrl} />
                    <AvatarFallback><UserIcon /></AvatarFallback>
                  </Avatar>
                  </Link>
                  )}
                </div>
            </CardContent>
          </Card>
          <Card>
            <CardHeader>
              <h2 className="text-5xl font-bold text-red-800 text-end mt-5">
                Nein
              </h2>
            </CardHeader>
            <CardContent>
                <div className="mb-2 flex items-center space-x-6">
                  <div className="shrink-0 flex-1">
                    <p className="font-semibold">Special interest influences</p>
                    <Badge>{noVotersClassification}</Badge>
                  </div>
                  <div className="col-span-1 self-start">
                    <ul className="mt-2 list-inside list-disc">
                    { noOrganizations.map(org => <li>{ org.name }</li>)}
                    </ul>
                  </div>
                </div>
                <div className="flex flex-wrap w-full gap-2 mt-16">
                  { votes.noVotes.map(vote =>
                  <Link href={`/members/?id=${vote.parliamentarianId}`}>
                    <Avatar className="h-12 w-12 border border-gray-300 rounded-full shadow">
                      <AvatarImage alt={vote.parliamentarian.firstName + " " + vote.parliamentarian.lastName} src={parliamentarianFromSeatsInformation(getSeatNumberFromName(`${vote.parliamentarian.lastName} ${vote.parliamentarian.firstName}`)).imageUrl} />
                      <AvatarFallback><UserIcon /></AvatarFallback>
                    </Avatar>
                  </Link>)}
                </div>
            </CardContent>
          </Card>
        </div>
  )


  /*const sponsorScore = await totalScore([sponsorId]);
  const sponsormap = await scoreParliamentarian(sponsorId);
  var sponsorClassification = "Low";
  if (sponsorScore >(averagescore+ averagemapping.maxTotalScore)/2){
      sponsorClassification = "High";
  } else if (sponsorScore > averagescore* 0.667 ){
      sponsorClassification = "Medium";
  }
  const sponsorAnomaly = computeanomaly(sponsormap, averagemap);
  //PUT THE first 3 in the sponsorTop3
  const sponsorTop3 = [...sponsorAnomaly.keys()].slice(0, 3);
*/
}


async function generateOrgScores(amountOfVoters: number, voters?: string[]) {
  "use server";
  console.log(voters);

  const organizations = await db.lobbyOrganization.findMany({
    include: {
      connectionsToParliament: voters !== undefined ? {
        where: {
          parliamentarianId: {
            in: voters
          }
        }
      } : true
    }
  });

  let highestScore = 0;

  const scores = new Map<string, number>();
  for (const org of organizations) {
    const val = org.connectionsToParliament.map((rel) => mapInfluenceLevel(rel.influenceLevel)).reduce((sum,curr) => sum + curr, 0);
    highestScore = Math.max(highestScore, val /* / amountOfVoters*/);
    scores.set(org.id, val / amountOfVoters); // might even remove /voters.length
  }

  let totalScore = Array.from(scores.values()).reduce((sum, curr) => sum + curr, 0);

  return { scores, totalScore, highestScore};
}

function mapInfluenceLevel(level: InfluenceLevel) {
  return level === "TIEF" || level === "UNKNOWN" ? 1 : level === "MITTEL" ? 2 : 3;
}




import data from '../members/seats.json';
import { ParliamentarianEntry } from "../members";
import { Separator } from "@radix-ui/react-separator";
import { UserIcon } from "lucide-react";
import Link from "next/link";
const getSeatNumberFromName = (name: string): number => {
  return data.find(x => x.councilorName === name)!.number;
}

const parliamentarianFromEntry = (entry: ParliamentarianEntry) => {
  const seatNumber = getSeatNumberFromName(entry.lastName + ' ' + entry.firstName);
  return parliamentarianFromSeatsInformation(seatNumber);
};


const parliamentarianFromSeatsInformation = (number: number) => {
  const member = data.find(x => x.number === number)!;

  return {
    number,
    name: member.councilorName,
    imageUrl: 'https://www.parlament.ch/' + member.councilorPhotoUrl,
    groupName: member.parlGroupName,
    groupColor: member.parlGroupColour,
    infoUrl: 'https://www.parlament.ch' + member.councilorDetailUrl,
    canton: member.councilorCanton
  };
};
