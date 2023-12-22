"use client";
import { Bill } from "@votewatch/database";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "../ui/select";
import { useRouter } from "next/navigation";

interface BillSelctorProps {
  selectedBill?: string,
  bills: Pick<Bill, "id" | "title">[]
}

export default function BillSelector({ selectedBill, bills }: BillSelctorProps) {
  const router = useRouter();
  return (
    <Select
      value={selectedBill}
      open={true}
      onValueChange={(value) => {
        router.push(`/bills/${value}`)
      }}
    >
      <SelectTrigger>
        <SelectValue placeholder="Select a bill"></SelectValue>
      </SelectTrigger>
      <SelectContent side="top">
        {bills.map((bill) => (
          <SelectItem key={bill.id} value={bill.id}>
            {bill.title}
          </SelectItem>
        ))}
      </SelectContent>
    </Select>)
}
