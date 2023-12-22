import { Bill, ParliamentarianVote, db } from "@votewatch/database";
import BillPie from "./BillPieChart";
import BillBarChart from "./BillBarChart";

interface BillVoteResultsProps {
  bill: Bill & { votes: ParliamentarianVote[]}
}
export async function BillVoteResults({ bill }: BillVoteResultsProps) {
  const votes = {
    yesVotes: bill.votes.filter(vote => vote.voteStatus === 'YES').length,
    noVotes: bill.votes.filter(vote => vote.voteStatus === 'NO').length,
    unknownVotes: bill.votes.filter(vote => vote.voteStatus === 'UNKNOWN').length
  }

  return (bill && <div className="w-flex w-full">
    <BillBarChart votes={votes} />
    <legend className="flex w-full justify-between px-1">
      <p className="text-3xl font-bold text-green-800">
        Ja <span className="font-base text-sm text-gray-700 ml-3">{votes.yesVotes} votes</span>
      </p>

      <p className="text-3xl font-bold text-red-800">
        <span className="font-base text-sm text-gray-700 mr-3">{votes.noVotes} votes</span> Nein
      </p>
    </legend>
    </div>)
  //return (bill && <BillPie votes={votes} />);
}
