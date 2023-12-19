'use client';

import { FC, useEffect, useState } from "react";
import { Council, Parliamentarian, getSeatNumberFromName, parliamentarianFromSeatsInformation } from "./council";
import { ParliamentarianInfo } from "./parliamentarianInfo";
import { useRouter } from "next/router";

export type CommitteeEntry = {
  name: string;
};

export type BillEntry = {
  title: string;
  billText: string;
  voteResult: 'YES' | 'NO' | 'UNKNOWN'
};

export type OrganizationEntry = {
  name: string;
  rechtsform: string;
  influenceLevel: 'TIEF' | 'MITTEL' | 'HOCH' | 'UNKNOWN',
  vergueting: string | null;
  position: string;
};

export type ParliamentarianEntry = {
  id: string;
  name: string;
  canton: string;
  committees: CommitteeEntry[];
  bills: BillEntry[];
  partyFullName: string;
  partyShortName: string;
  organizations: OrganizationEntry[];
};

export type ParliamentariansProps = {
  entries: ParliamentarianEntry[];
};

export const Parliamentarians: FC<ParliamentariansProps> = ({ entries }) => {
  const [selected, setSelected] = useState<Parliamentarian | null>(null);
  const router = useRouter();

  useEffect(() => {
    if (!router.query.id) {
      return;
    }

    const selectedEntry = entries.find(x => x.id === router.query.id)!;
    const seatNumber = getSeatNumberFromName(selectedEntry.name);
    const parliamentarian = parliamentarianFromSeatsInformation(seatNumber);
    setSelected(parliamentarian);
  }, [entries, router.query.id, setSelected]);

  return <>
    <Council onSelect={setSelected} />
    {selected && <ParliamentarianInfo parliamentarian={selected} />}
  </>
};
