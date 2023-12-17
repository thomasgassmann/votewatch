'use client';

import { useState } from "react";
import { Council, Parliamentarian } from "./council";
import { ParliamentarianInfo } from "./parliamentarianInfo";

export const Parliamentarians = () => {
  const [selected, setSelected] = useState<Parliamentarian | null>(null);
  return <>
    <Council onSelect={setSelected} />
    {selected && <ParliamentarianInfo parliamentarian={selected} />}
  </>
};
