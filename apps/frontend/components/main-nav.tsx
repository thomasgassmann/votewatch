"use client"

import * as React from "react"
import Link from "next/link"
import { useRouter, useSelectedLayoutSegment } from "next/navigation"

import { MainNavItem } from "../types"
import { Icons } from "./icons"
import { MobileNav } from "./mobile-nav"
import {
  NavigationMenu,
  NavigationMenuLink,
  NavigationMenuList,
  navigationMenuTriggerStyle,
} from "./ui/navigation-menu"
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from "./ui/tooltip"
import { Separator } from "./ui/separator"
import { InfoIcon } from "lucide-react"

interface MainNavProps {
  items?: MainNavItem[]
  children?: React.ReactNode
}

export function MainNav({ items, children }: MainNavProps) {
  const segment = useSelectedLayoutSegment()
  const [showMobileMenu, setShowMobileMenu] = React.useState<boolean>(false)

  const explanations = {
    "Organizations": "Visually explore and uncover lobbying influences from organisations to parliamentarians. Simply hover over a parliamentarian to see from which organisations he/she is being influenced. Vice versa, hover over an organisation to explore its influence on all the different political entities.",
    "Parliamentarians": "The parliamentarians view allows you to view the connectedness of different members of the national council to various lobbying organizations. You can furthermore see bills the selected councilor has voted on as well as committees they are in.",
    "Bills": "The Bill view allows you to view the levels of special influence present on the involved parties for any bill that has been voted on in the past legislature"
  }

  const router = useRouter();

  return (
    <div className="flex w-full gap-6 md:gap-10">
      <Link href="/" className="hidden items-center space-x-2 md:flex">
        <Icons.logo />
        <span className="hidden font-bold sm:inline-block">VoteWatch</span>
      </Link>
      <div className="flex w-full justify-center">
        <NavigationMenu>
          <NavigationMenuList>
            {items?.map((item, index) => (
              <TooltipProvider key={index}>
                <Tooltip>

                    <Link
                      href={item.disabled ? "#" : item.href}
                      legacyBehavior
                      passHref
                    >
                      <TooltipTrigger asChild>

                      <NavigationMenuLink
                        className={navigationMenuTriggerStyle()}
                        active={item.href.startsWith(`/${segment}`)}
                        >
                        {item.title}
                      </NavigationMenuLink>
                        </TooltipTrigger>
                    </Link>
                  <TooltipContent>
                    <div className="flex max-w-xs flex-col p-3">
                      <h3 className="mb-2 inline-flex items-center gap-2 text-lg">{item.title} <InfoIcon className="h-4 w-4" /></h3>
                      <p>{explanations[item.title]}</p>
                    </div>
                  </TooltipContent>
                </Tooltip>
              </TooltipProvider>
            ))}
          </NavigationMenuList>
        </NavigationMenu>
      </div>

      { /* Lazy/quick way to implement search, just link back to homepage. It'd be better to render an popup container instead */}
      <button className="border-input text-muted-foreground hover:bg-accent hover:text-accent-foreground focus-visible:ring-ring relative inline-flex h-9 w-full items-center justify-start whitespace-nowrap rounded-md border bg-transparent px-4 py-2 text-sm font-medium shadow-sm transition-colors focus-visible:outline-none focus-visible:ring-1 disabled:pointer-events-none disabled:opacity-50 sm:pr-12 md:w-40 lg:w-64" onClick={() => router.push('/')}>
        <span className="inline-flex">Search...</span>
        <kbd className="bg-muted pointer-events-none absolute right-1.5 top-1.5 hidden h-5 select-none items-center gap-1 rounded border px-1.5 font-mono text-[10px] font-medium opacity-100 sm:flex">
          <span className="text-xs">⌘</span>K
        </kbd>
      </button>
      <button
        className="flex items-center space-x-2 md:hidden"
        onClick={() => setShowMobileMenu(!showMobileMenu)}
      >
        {showMobileMenu ? <Icons.close /> : <Icons.menu />}
        <span className="font-bold">Menu</span>
      </button>
      {showMobileMenu && items && (
        <MobileNav items={items}>{children}</MobileNav>
      )}
    </div>
  )
}
