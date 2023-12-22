"use client";

import { range } from "rambdax";
import { User, Paperclip, UserIcon, Building} from "lucide-react";
import { Command, CommandEmpty, CommandGroup, CommandInput, CommandItem, CommandList, CommandSeparator } from "./ui/command";
import { useRouter } from "next/navigation";
import { Bill, LobbyOrganization, Parliamentarian } from "@votewatch/database";
import { useEffect, useRef } from "react";

interface SearchBoxProps {
  parlamentarians: Parliamentarian[],
  bills: Pick<Bill, 'id' | 'title'>[],
  lobbyOrganizations: Pick<LobbyOrganization, 'id' | 'name'>[]
}
export default function SearchBox({ parlamentarians, bills, lobbyOrganizations}: SearchBoxProps) {

  const router = useRouter();

  const ref = useRef<HTMLInputElement>(null);

  useEffect(() => {
    if (ref) ref.current?.focus()
  }, [ref])

  return  (<Command className="rounded-lg border shadow-md" >
  <CommandInput placeholder="Search a person, organization or bill" ref={ref} />
  <CommandList>
    <CommandEmpty>No results found.</CommandEmpty>
    <CommandGroup heading="Categories">
      <CommandItem onSelect={() => router.push('/organizations') }>
        <Building className="mr-2 h-4 w-4" />
        <span>Organizations</span>
      </CommandItem>
      <CommandItem onSelect={() => router.push('/members') }>
        <User className="mr-2 h-4 w-4" />
        <span>Parlamentarians</span>
      </CommandItem>
      <CommandItem onSelect={() => router.push('/bills') }>
        <Paperclip className="mr-2 h-4 w-4" />
        <span>Bills</span>
      </CommandItem>
    </CommandGroup>
    <CommandSeparator />
    <CommandGroup heading="Parlamentarians">
      {parlamentarians.map((p) => (
        <CommandItem onSelect={() => router.push(`/members?id=${p.id}`)}>
          <UserIcon className="mr-2 h-4 w-4" />
          <span>{ p.firstName + " " + p.lastName}</span>
        </CommandItem>
      ))}
    </CommandGroup>
    <CommandGroup heading="Bills">
      {bills.map((bill) => (
        <CommandItem onSelect={() => router.push(`/bills/${bill.id}`)}>
        <Paperclip className="mr-2 h-4 w-4" />
          <span>{bill.title}</span>
        </CommandItem>
      ))}
    </CommandGroup>
  </CommandList>
</Command>)
}
