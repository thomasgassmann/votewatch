/* eslint-disable tailwindcss/classnames-order */
import { Paperclip, User } from "lucide-react"
import { range } from "rambdax"

import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
  CommandSeparator,
} from "@/components/ui/command"
import SearchBox from "@/components/search-box"

import { PageShell } from "../../components/shell"
import { getAllParliamentarians } from "@/components/getbills"
import { db } from "@votewatch/database"

export const metadata = {
  title: "Dashboard",
}

export default async function HomePage() {

  const parliamentarians = await getAllParliamentarians();
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
      <section className="space-y-6 pb-8 pt-6 md:pb-12 md:pt-10 lg:py-32">
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
    </PageShell>
  )
}
