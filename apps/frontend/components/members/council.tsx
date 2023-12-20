'use client';

import * as d3 from "d3";
import type { Selection } from 'd3';
import { FC, useEffect, useRef, useState } from "react";

import meta from './meta.json';
import data from './seats.json';
import { Card, CardContent, CardFooter } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarImage } from "@radix-ui/react-avatar";
import { Badge } from "@/components/ui/badge";
import { ParliamentarianEntry } from "./parliamentarians";

export type Parliamentarian = {
  number: number;
  name: string;
  imageUrl: string;
  groupName: string;
  groupColor: string;
  infoUrl: string;
  canton: string;
}

export type CouncilProps = {
  onSelect(parliamentarian: Parliamentarian): void;
  entries: ParliamentarianEntry[];
};

let mouseX, mouseY = 0;

if (typeof window !== 'undefined') {
  document.addEventListener('mousemove', (e) => {
    mouseX = e.pageX;
    mouseY = e.pageY;
  });
}

export const getSeatNumberFromName = (name: string): number => {
  return data.find(x => x.councilorName === name)!.number;
}

export const parliamentarianFromEntry = (entry: ParliamentarianEntry): Parliamentarian => {
  const seatNumber = getSeatNumberFromName(entry.lastName + ' ' + entry.firstName);
  return parliamentarianFromSeatsInformation(seatNumber);
};

export const entryFromParliamentarian = (entries: ParliamentarianEntry[], parl: Parliamentarian): ParliamentarianEntry | null => {
  return entries.find(x => x.lastName + ' ' + x.firstName === parl.name) ?? null;
}

export const parliamentarianFromSeatsInformation = (number: number): Parliamentarian => {
  const member = data.find(x => x.number === number)!;

  return {
    number: member.number,
    name: member.councilorName,
    imageUrl: 'https://www.parlament.ch/' + member.councilorPhotoUrl,
    groupName: member.parlGroupName,
    groupColor: member.parlGroupColour,
    infoUrl: 'https://www.parlament.ch' + member.councilorDetailUrl,
    canton: member.councilorCanton
  };
};

const countInfluence = (entry: ParliamentarianEntry): number => {
  let total = 0;
  for (const org of entry.organizations) {
    switch (org.influenceLevel) {
      case 'HOCH':
        total += 5;
        break;
      case 'MITTEL':
        total += 3;
        break;
      case 'TIEF':
        total += 1;
      case 'UNKNOWN':
      default:
        total += 1;
    }
  }

  return total;
}

const calculateRelativeInfluenceScore = (entries: ParliamentarianEntry[], entry: ParliamentarianEntry): number => {
  const highest = Math.max(...entries.map(x => countInfluence(x)));
  return (countInfluence(entry) / highest) * 0.7 + 0.3;
};

export const Council: FC<CouncilProps> = ({ onSelect, entries }) => {
  const svgRef = useRef<SVGSVGElement>(null);
  const svgContainer = useRef<HTMLDivElement>(null);
  const cardRef = useRef<HTMLDivElement>(null);

  const [hover, setHover] = useState<Parliamentarian | null>(null);
  const [hoverPos, setHoverPos] = useState<[number, number]>([0, 0]);

  useEffect(() => {
    if (svgRef.current && svgContainer.current) {
      svgRef.current.style.width = svgContainer.current.clientWidth + 'px';
      svgRef.current.style.height = svgContainer.current.clientHeight + 'px';

      d3.select(svgRef.current).selectAll('*').remove();
      const svg = d3.select(svgRef.current)
        .append('svg')
        .attr('width', svgContainer.current.clientWidth)
        .attr('height', svgContainer.current.clientHeight);

      const centerX = svgContainer.current.clientWidth / 2;

      const halfCircleGroup = svg.append('g')
        .attr('transform', `translate(${centerX}, ${svgContainer.current.clientHeight - 75})`);

      const bottomRowGroup = svg.append('g')
        .attr('transform', `translate(${centerX}, ${svgContainer.current.clientHeight})`)

      let currentRow = 50;
      let rowThickness = 35;
      const rowDistance = 10;

      let bottomRow: number[] = [];
      let members = [...data].sort((a, b) => a.number - b.number);
      while (members[0].number < meta.pieFrom) {
        bottomRow.push(members.shift()!.number);
      }

      const setData = (input: Selection<d3.BaseType, unknown, d3.BaseType, unknown>, memberNumber: number) => {
        const member = data.find(x => x.number === memberNumber)!;
        const currentParliamentarian: Parliamentarian = parliamentarianFromSeatsInformation(memberNumber);

        const entry = entryFromParliamentarian(entries, currentParliamentarian);
        const r = input
          .style('fill', member.parlGroupColour)
          .on('mouseover', function (d, i) {
            setHoverPos([mouseX, mouseY]);
            setHover(currentParliamentarian);
          })
          .on('mouseout', function (d, i) {
            if (cardRef.current &&
              cardRef.current.getBoundingClientRect().left <= mouseX && mouseX <= cardRef.current.getBoundingClientRect().right &&
              cardRef.current.getBoundingClientRect().top <= mouseY && mouseY <= cardRef.current.getBoundingClientRect().bottom) {
              return;
            }

            setHover(null);
          })
          .on('click', () => onSelect(currentParliamentarian));

        if (entry) {
          const score = calculateRelativeInfluenceScore(entries, entry);
          r.style('fill-opacity', score);
        }
      };

      let currentX = -16.5 * rowDistance;
      for (const bottomNumber of bottomRow) {
        const c = bottomRowGroup.append('circle')
          .attr('cx', currentX)
          .attr('cy', - rowDistance * 3)
          .attr('r', rowDistance);
        setData(c, bottomNumber);
        currentX += rowDistance * 3;
      }

      let rowNumber = 0;
      for (const row of meta.rows) {
        const angleDistance = Math.PI / (50 + rowNumber * 10);
        let group1AngleFrom = -Math.PI / 2;
        let group1AngleTo = -Math.PI / 4 - angleDistance;
        const group2AngleFrom = -Math.PI / 4 + angleDistance;
        const group2AngleTo = -angleDistance;
        const group3AngleFrom = angleDistance;
        const group3AngleTo = Math.PI / 4 - angleDistance;
        let group4AngleFrom = Math.PI / 4 + angleDistance;
        let group4AngleTo = Math.PI / 2;
        const memberAngleDistance = angleDistance / 2;

        const drawGroup = (fromAngle: number, toAngle: number, currentMembers: number[]) => {
          const area = toAngle - fromAngle;
          const perMember = (area - (currentMembers.length - 1) * memberAngleDistance) / currentMembers.length;
          let currentAngle = fromAngle;
          for (const memberNumber of currentMembers) {

            const arc = d3.arc()
              .innerRadius(currentRow)
              .outerRadius(currentRow + rowThickness)
              .startAngle(currentAngle)
              .endAngle(currentAngle + perMember);

            const r = halfCircleGroup.append('path')
              .attr('d', arc)
              .style('cursor', 'pointer')
              .style('fill-opacity', 0.3);

            setData(r, memberNumber);

            currentAngle += perMember + memberAngleDistance;
          }
        };

        const group12 = members.filter(x => x.number % 2 == 1).slice(0, row.firstGroup + row.secondGroup);
        const group34 = members.filter(x => x.number % 2 == 0).slice(0, row.thirdGroup + row.forthGroup);

        const group1 = group12.splice(0, row.firstGroup);
        const group2 = group12;
        const group3 = group34.splice(0, row.secondGroup);
        const group4 = group34;

        if (rowNumber + 1 === meta.rows.length) {
          group1AngleFrom += Math.PI / 10;
          group4AngleTo -= Math.PI / 10;
        }

        drawGroup(group1AngleFrom, group1AngleTo, group1.map(x => x.number));
        drawGroup(group2AngleFrom, group2AngleTo, group2.map(x => x.number));
        drawGroup(group3AngleFrom, group3AngleTo, group3.map(x => x.number));
        drawGroup(group4AngleFrom, group4AngleTo, group4.map(x => x.number));

        members = members.filter(x => !group1.includes(x) && !group2.includes(x) && !group3.includes(x) && !group4.includes(x));

        currentRow += rowDistance + rowThickness;
        rowNumber++;
      }
    }
  }, [onSelect, setHover, setHoverPos, entries]);

  return <>
    <div ref={svgContainer} className="h-[450px] w-full">
      <svg ref={svgRef} />
    </div>
    {hover !== null && <div style={{ position: 'absolute', top: `${hoverPos[1]}px`, left: `${hoverPos[0]}px` }}>
      <Card ref={cardRef} className="mb-6">
        <CardContent className="p-6">
          <div className="mb-6 flex items-center space-x-4">
            <Avatar className="h-20 w-20">
              <AvatarImage alt={hover.name} src={hover.imageUrl} />
            </Avatar>
            <div>
              <h2 className="text-xl font-bold">{hover.name}</h2>
              <Badge className="mt-2" style={{
                backgroundColor: hover.groupColor
              }}>{hover.groupName}</Badge>
            </div>
          </div>
        </CardContent>
        <CardFooter>
          <Button onClick={() => {
            setHover(null);
            onSelect(hover);
          }}>Show</Button>
        </CardFooter>
      </Card>
    </div>}
  </>;
};
