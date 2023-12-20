"use client";
import { useRouter } from 'next/router';
import { PageShell } from '@/components/shell';
import { PageHeader } from '../../../components/header';
import { getallTop3 } from '../../../components/Bill_by_bill_util';
import { useState, useEffect } from 'react';
import { Bill } from '@prisma/client';
import { loadbills, getParliamentarianById, loadBillVoteresbyid } from '../../../components/getbills';
import { CardHeader, CardContent, Card } from "@/components/ui/card"
import { Avatar } from "@/components/ui/avatar"
import { Badge } from "@/components/ui/badge"
import { BillPie } from '../../../components/drawd3';
import { Button } from '@/components/ui/button';

import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { get } from 'http';


export default function BillsPageLoading() {
  const [bills, setBills] = useState<Bill[]>([]);
  const [selectedBill, setSelectedBill] = useState<Bill | null>(null);
  const [sponsorname, setSponsorname] = useState<string>('');
  const [voters, setVoters] = useState<String[][]>([]);
  const [sponsorTop3, setSponsorTop3] =  useState<String[]>([]);
  const [sponsorclass, setSponsorclass] = useState<String>();
  const [yesTop3, setYesTop3] = useState<String[]>([]);
  const [noTop3, setNoTop3] = useState<String[]>([]);
  const [yesclass, setYesclass] = useState<String>();
  const [noclass, setNoclass] = useState<String>();


  useEffect(() => {
    loadbills().then((data) => {
      setBills(data);
    });
  }, []);

  const handleBillSelect = async (billId: string) => {
    console.log('handleBillSelect called with billId:', billId);
    const selected = bills.find((bill) => bill.id === billId);

    if (selected) {
      const sponsorref = await getParliamentarianById(selected.sponsorId);
      const votersResult = await loadBillVoteresbyid(selected.id);
      if (!sponsorref) {
        throw new Error(`Parliamentarian with id ${selected.sponsorId} not found.`);
      }
      const top3 = getallTop3(sponsorref.id, votersResult[0], votersResult[1])

      setSelectedBill(selected || null);
      setSponsorname(sponsorref.name);
      setVoters(votersResult);
      console.log(top3);
      setSponsorclass(top3[0]);
      setSponsorTop3(top3[1]);
      setYesclass(top3[2]);
      setYesTop3(top3[3]);
      setNoclass(top3[4]);
      setNoTop3(top3[5]);
    }
  };

  useEffect(() => {
    loadbills().then((data) => {
      setBills(data);
    });
  }, []);

  return (
    <PageShell>
      <PageHeader
        heading="Bills"
        text="Explore different bills and their lobby influences"
      />
      <h1 className="font-semibold text-2xl">Bill Data Visualization</h1>
      <form className="flex items-center">
        <div className="grid gap-10">
        </div>
        <Select
          onValueChange={(value) => {
            handleBillSelect(value)
          }}
          value={selectedBill?.id || ''}
        >
          <SelectTrigger>
            <SelectValue>Select a bill</SelectValue>
          </SelectTrigger>
          <SelectContent side="top">
            {bills.map((bill) => (
              <SelectItem key={bill.id} value={bill.id}>
                {bill.title}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </form>

      <main className="p-4 bg-gray-50 min-h-screen">
        <Card className="mb-4">
          <CardHeader>
            <div className="flex items-center">
              <h2 className="text-lg font-semibold">Bill Selected: </h2>
              <Badge className="ml-2">{selectedBill?.title}</Badge>
            </div>
          </CardHeader>
          <CardContent className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <h3 className="text-lg font-semibold mb-2">Voting Results</h3>
              {selectedBill && <BillPie data={voters} />}
            </div>
            <div>
              <h3 className="text-lg font-semibold mb-2">Explaination:</h3>
              <p className="text-base">On this page you can select any bill that has been voted on in parliament in the proceeding legislature.
              The classification of the influence levels of a bill's sponsor, yes or no voters bases itself on a comparison to the median parliamentarian.
              A low level indicates significantly fewer special interest connections while a high level indicates significantly more. 
              The top three standout special interest connections of a parliamentarian are listed in order of how much they influence the given group more 
              than the median parliamentarian. 
                </p>
            </div>
          </CardContent>
        </Card>

        <Card className="mb-4">
          <CardHeader>
            <h2 className="text-lg font-semibold">Bill Sponsor</h2>
          </CardHeader>
          <CardContent className="flex items-center space-x-4">
            <Avatar alt="Bill Sponsor" className="w-12 h-12" src="/placeholder.svg?height=50&width=50" />
            <div>
              <h3 className="font-semibold">{sponsorname}</h3>
              <p className="text-sm">Special Interest Level: {sponsorclass}</p>
            </div>
            <div className="col-span-1 self-start">
              <ul className="list-disc list-inside mt-2">
                <li>{sponsorTop3[0]}</li>
                <li>{sponsorTop3[1]}</li>
                <li>{sponsorTop3[2]}</li>
              </ul>
            </div>
            <div className="flex justify-start col-span-3">
              <Button className="mt-2">More Details</Button>
            </div>
          </CardContent>
        </Card>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <Card>
            <CardHeader>
              <h2 className="text-lg font-semibold">'Yes' Voters</h2>
            </CardHeader>
            <CardContent>
              <ul>
                <li className="flex items-center space-x-4 mb-2">
                  <Avatar className="w-8 h-8" src="/placeholder.svg?height=50&width=50" />
                  <div>
                    <p className="font-semibold">Special interest influences</p>
                    <Badge>{yesclass}</Badge>
                  </div>
                  <div className="col-span-1 self-start">
                    <ul className="list-disc list-inside mt-2">
                      <li>{yesTop3[0]}</li>
                      <li>{yesTop3[1]}</li>
                      <li>{yesTop3[2]}</li>
                    </ul>
                  </div>
                </li>
              </ul>
            </CardContent>
          </Card>
          <Card>
            <CardHeader>
              <h2 className="text-lg font-semibold">'No' Voters</h2>
            </CardHeader>
            <CardContent>
              <ul>
                <li className="flex items-center space-x-4 mb-2">
                  <Avatar alt="Voter 1" className="w-8 h-8" src="/placeholder.svg?height=50&width=50" />
                  <div>
                    <p className="font-semibold">Special interest influences</p>
                    <Badge>{noclass}</Badge>
                  </div>
                  <div className="col-span-1 self-start">
                    <ul className="list-disc list-inside mt-2">
                      <li>{noTop3[0]}</li>
                      <li>{noTop3[1]}</li>
                      <li>{noTop3[2]}</li>
                    </ul>
                  </div>
                </li>
              </ul>
            </CardContent>
          </Card>
        </div>
      </main>
    </PageShell>
  );
}
