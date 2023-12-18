'use client';

import { useState } from "react";
import { Council, Parliamentarian } from "./council";
import { ParliamentarianInfo } from "./parliamentarianInfo";

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
  name: string;
  canton: string;
  committees: CommitteeEntry[];
  bills: BillEntry[];
  partyFullName: string;
  partyShortName: string;
  organizations: OrganizationEntry[];
};

export const Parliamentarians = () => {
  const [selected, setSelected] = useState<Parliamentarian | null>(null);
  return <>
    <Council onSelect={setSelected} />
    {selected && <ParliamentarianInfo parliamentarian={selected} />}
  </>
};
