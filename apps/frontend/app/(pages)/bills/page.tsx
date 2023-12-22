import { PageShell } from '@/components/shell';
import { PageHeader } from '@/components/header';
import { CardHeader, Card, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"

import { db } from '@votewatch/database';
import BillSelector from '@/components/bills/BillSelector';
import { cn } from '@/lib/utils';
import Link from 'next/link';

export default async function BillsPage() {

  const billList = await db.bill.findMany({
    select: {
      id: true,
      title: true,
      voteResult: true
    }
  });

  return (
    <PageShell>
      <PageHeader
        heading="Bills"
        text="Explore different bills and their lobby influences"
      />
      <div className="flex flex-col items-center gap-4">
        { false && <BillSelector bills={billList} /> }
      </div>

      <main className="min-h-screen">


      <ul className="grid gap-2">
        {billList.map(bill =>
          <li key={bill.id}>
            <Link href={`/bills/${bill.id}`}>
              <Card className='hover:bg-secondary'>
                <CardHeader>
                  <CardTitle>{bill.title}  <Badge variant="outline" className={
                    cn("uppercase", {
                      'text-green-800 border-green-800 bg-green-50': bill?.voteResult === 'YES',
                      'text-red-800 border-red-800 bg-red-50': bill?.voteResult === 'NO'
                    })
                  }>
                    { bill?.voteResult === 'YES' ? "Angenommen" : "Abgelehnt"}
                  </Badge></CardTitle>
                </CardHeader>
              </Card>
            </Link>
          </li>
        )}
      </ul>
      </main>
    </PageShell>
  );
}
