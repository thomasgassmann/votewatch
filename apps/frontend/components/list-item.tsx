import Link from "next/link"

import { Skeleton } from "./ui/skeleton"

interface ListItemProps {
  name: string
  description?: string
}

export function ListItem({ name, description }: ListItemProps) {
  return (
    <div className="flex items-center justify-between p-4">
      <div className="grid gap-1">
        <Link href={`/`} className="font-semibold">
          {name}
        </Link>
        <div>
          <p className="text-sm text-muted-foreground">{description}</p>
        </div>
      </div>
    </div>
  )
}

ListItem.Skeleton = function ListItemSkeleton() {
  return (
    <div className="p-4">
      <div className="space-y-3">
        <Skeleton className="h-5 w-2/5" />
        <Skeleton className="h-4 w-4/5" />
      </div>
    </div>
  )
}
