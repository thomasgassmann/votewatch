"use server"
import { db } from "@votewatch/database";

export async function loadbills() {
  "use server";
    const bills = await db.bill.findMany({
      include: {
        sponsor: {
          include: {
            party: true,
          },
        },
      },
    });
  
    return bills;
  }

  
    export async function loadBillById(id: string) {
      "use server";
        const bill = await db.bill.findUnique({
          where: { id: id.toString() },
          include: {
              sponsor: true,
              votes : true,
          },
      });
    return bill;
    }



//load bill yes no abstain counts by id

export async function loadBillVoteresbyid(id: string) {
    const bill = await db.bill.findUnique({
      where: { id: id },
      include: {
        votes: {
          include: {
            parliamentarian: true,
          },
        },
      },
    });
    
    if (!bill) {
      throw new Error(`Bill with id ${id} not found.`);
    }
  
    const yesVotersIds = bill.votes.filter(vote => vote.voteStatus === 'YES').map(vote => vote.parliamentarianId);
    const noVotersIds = bill.votes.filter(vote => vote.voteStatus === 'NO').map(vote => vote.parliamentarianId);
    const abstainVotersIds = bill.votes.filter(vote => vote.voteStatus === 'UNKNOWN').map(vote => vote.parliamentarianId);
    return [yesVotersIds, noVotersIds, abstainVotersIds];
}


export async function getAllParliamentarians(){
  return await db.parliamentarian.findMany();
}

export async function getParliamentarianById(id: string){
  return db.parliamentarian.findUnique({
    where: { id: id.toString() },
    include: { relatedOrganizations: true },
  })
};