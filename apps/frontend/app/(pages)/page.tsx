/* eslint-disable tailwindcss/classnames-order */
import { Building, PaperclipIcon, User2Icon } from "lucide-react"
import SearchBox from "@/components/search-box"

import { PageShell } from "../../components/shell"
import { db } from "@votewatch/database"
import Link from "next/link"

export const metadata = {
  title: "Dashboard",
}

export default async function HomePage() {

  const parliamentarians = await db.parliamentarian.findMany();
  const bills = await db.bill.findMany({ select: {
    id: true,
    title: true
  }})
  const organizations = await db.lobbyOrganization.findMany({
    select: {
      id: true,
      name: true
    },
    take: 20 // limit to 20 to keep search performant, usually we should perform search querys on the server instead of client side filtering.....
  })

  return (
    <PageShell>
      <section className="space-y-6 pb-5 pt-6 md:pb-12 md:pt-10 lg:pt-16">
        <div className="container flex max-w-[64rem] flex-col items-center gap-4 text-center">
          <h1 className=" font-sans text-2xl font-bold sm:text-5xl md:text-6xl lg:text-7xl">
            Keep an eye on politics
          </h1>
          <p className="text-muted-foreground max-w-[42rem] leading-normal sm:text-xl sm:leading-8">
            With VoteWatch you can uncover all the lobby influences in Swiss
            Parliament and view details on specific bills and organizations.
          </p>
          <div className="mt-6 w-96 space-x-4">
            <SearchBox parlamentarians={parliamentarians} bills={bills} lobbyOrganizations={organizations}></SearchBox>
          </div>
        </div>
      </section>

      <section className="container space-y-6 bg-slate-50 py-3 dark:bg-transparent md:py-12 lg:py-16 rounded-3xl">
        <div className="mx-auto flex max-w-[58rem] flex-col items-center space-y-4 text-center">
          <p className="max-w-[85%] leading-normal text-muted-foreground sm:text-lg sm:leading-7">
            Explore three different visualizations that give you an insight how lobby organizations influence members of Swiss parliament and their voting habits.
          </p>
        </div>
        <div className="mx-auto grid justify-center gap-4 sm:grid-cols-2 md:max-w-[64rem] md:grid-cols-3">

          <Link href="/organizations">
            <div className="relative overflow-hidden rounded-lg border bg-background p-2 hover:bg-secondary transition-all">
              <div className="flex h-[180px] flex-col justify-between rounded-md p-6">
                <Building />
                <div className="space-y-2">
                  <h3 className="font-bold">Organizations</h3>
                  <p className="text-sm text-muted-foreground">
                    Visually explore and uncover lobbying influences from organisations to parliamentarians.
                  </p>
                </div>
              </div>
            </div>
          </Link>

          <Link href="/members">
            <div className="relative overflow-hidden rounded-lg border bg-background p-2 hover:bg-secondary transition-all">
              <div className="flex h-[180px] flex-col justify-between rounded-md p-6">
                <User2Icon />
                <div className="space-y-2">
                  <h3 className="font-bold">Parliamentarians</h3>
                  <p className="text-sm text-muted-foreground">
                  Explore how connected different members of the national council are to various lobbying organizations
                  </p>
                </div>
              </div>
            </div>
          </Link>

          <Link href="/bills">
            <div className="relative overflow-hidden rounded-lg border bg-background p-2 hover:bg-secondary transition-all">
              <div className="flex h-[180px] flex-col justify-between rounded-md p-6">
                <PaperclipIcon />
                <div className="space-y-2">
                  <h3 className="font-bold">Bills</h3>
                  <p className="text-sm text-muted-foreground">
                    View the levels of special influence present on the involved parties for any bill that has been voted recently
                  </p>
                </div>
              </div>
            </div>
          </Link>
        </div>
      </section>
    </PageShell>
  )
}
