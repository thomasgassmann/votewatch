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

export const metadata = {
  title: "Dashboard",
}

export default async function HomePage() {
  return (
    <PageShell>
      <section className="space-y-6 pb-8 pt-6 md:pb-12 md:pt-10 lg:py-32">
        <div className="container flex max-w-[64rem] flex-col items-center gap-4 text-center">
          <h1 className=" font-sans text-2xl font-bold sm:text-5xl md:text-6xl lg:text-7xl">
            Keep an eye on politics
          </h1>
          <p className="max-w-[42rem] leading-normal text-muted-foreground sm:text-xl sm:leading-8">
            With VoteWatch you can uncover all the lobby influences in Swiss
            Parliament and view details on specific bills and organizations.
          </p>
          <div className="mt-6 w-96 space-x-4">
            <SearchBox></SearchBox>
          </div>
        </div>
      </section>
    </PageShell>
  )
}
