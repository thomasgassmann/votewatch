"use client";

import { range } from "rambdax";
import { User, Paperclip} from "lucide-react";
import { Command, CommandEmpty, CommandGroup, CommandInput, CommandItem, CommandList, CommandSeparator } from "./ui/command";

export default function SearchBox() {
  return             <Command className="rounded-lg border shadow-md">
  <CommandInput placeholder="Search a bill or organization" />
  <CommandList>
    <CommandEmpty>No results found.</CommandEmpty>
    <CommandGroup heading="Categories">
      <CommandItem>
        <User className="mr-2 h-4 w-4" />
        <span>People</span>
      </CommandItem>
      <CommandItem>
        <User className="mr-2 h-4 w-4" />
        <span>Organizations</span>
      </CommandItem>
      <CommandItem>
        <User className="mr-2 h-4 w-4" />
        <span>Bills</span>
      </CommandItem>
    </CommandGroup>
    <CommandSeparator />
    <CommandGroup heading="Bills">
      {range(1, 4).map((i) => (
        <CommandItem>
          <Paperclip className="mr-2 h-4 w-4" />
          <span>Bill #{i}</span>
        </CommandItem>
      ))}
    </CommandGroup>
  </CommandList>
</Command>
}
