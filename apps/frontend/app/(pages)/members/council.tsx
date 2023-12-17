'use client';

import * as d3 from "d3";
import { FC, useEffect, useRef } from "react";

import meta from './meta.json';
import data from './seats.json';

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
};

export const Council: FC<CouncilProps> = ({ onSelect }) => {
  const svgRef = useRef<SVGSVGElement>(null);
  const svgContainer = useRef<HTMLDivElement>(null);

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

      let members = data.sort((a, b) => a.number - b.number);
      while (members[0].number < meta.pieFrom) {
        members.shift();
      }

      let rowNumber = 0;
      for (const row of meta.rows) {
        const angleDistance = Math.PI / (50 + rowNumber * 10);
        const group1AngleFrom = -Math.PI / 2;
        const group1AngleTo = -Math.PI / 4 - angleDistance;
        const group2AngleFrom = -Math.PI / 4 + angleDistance;
        const group2AngleTo = -angleDistance;
        const group3AngleFrom = angleDistance;
        const group3AngleTo = Math.PI / 4 - angleDistance;
        const group4AngleFrom = Math.PI / 4 + angleDistance;
        const group4AngleTo = Math.PI / 2;
        const memberAngleDistance = angleDistance / 2;

        const drawGroup = (fromAngle: number, toAngle: number, currentMembers: number[]) => {
          const area = toAngle - fromAngle;
          const perMember = (area - (currentMembers.length - 1) * memberAngleDistance) / currentMembers.length;
          let currentAngle = fromAngle;
          for (const memberNumber of currentMembers) {
            const member = data.find(x => x.number === memberNumber)!;

            const arc = d3.arc()
              .innerRadius(currentRow)
              .outerRadius(currentRow + rowThickness)
              .startAngle(currentAngle)
              .endAngle(currentAngle + perMember);

            const currentId =  `member-${memberNumber}`;
            halfCircleGroup.append('text')
              .append('textPath')
              .style('font-size', '10px')
              .attr('xlink:href', '#' + currentId)
              .text(memberNumber.toString());

            halfCircleGroup.append('path')
              .attr('id', currentId)
              .attr('d', arc)
              .style('fill', member.parlGroupColour)
              .style('cursor', 'pointer')
              .on('mouseover', function (d, i) {
                d3.select(this).transition()
                     .duration(50)
                     .style('fill-opacity', '.7')
              })
              .on('mouseout', function (d, i) {
                d3.select(this).transition()
                     .duration(50)
                     .style('fill-opacity', '1')
              })
              .on('click', () => onSelect({
                number: member.number,
                name: member.councilorName,
                imageUrl: 'https://www.parlament.ch/' + member.councilorPhotoUrl,
                groupName: member.parlGroupName,
                groupColor: member.parlGroupColour,
                infoUrl: 'https://www.parlament.ch' + member.councilorDetailUrl,
                canton: member.councilorCanton
              }));

            currentAngle += perMember + memberAngleDistance;
          }
        };

        const group12 = members.filter(x => x.number % 2 == 1).slice(0, row.firstGroup + row.secondGroup);
        const group34 = members.filter(x => x.number % 2 == 0).slice(0, row.thirdGroup + row.forthGroup);

        const group1 = group12.splice(0, row.firstGroup);
        const group2 = group12;
        const group3 = group34.splice(0, row.secondGroup);
        const group4 = group34;

        drawGroup(group1AngleFrom, group1AngleTo, group1.map(x => x.number));
        drawGroup(group2AngleFrom, group2AngleTo, group2.map(x => x.number));
        drawGroup(group3AngleFrom, group3AngleTo, group3.map(x => x.number));
        drawGroup(group4AngleFrom, group4AngleTo, group4.map(x => x.number));

        members = members.filter(x => !group1.includes(x) && !group2.includes(x) && !group3.includes(x) && !group4.includes(x));

        currentRow += rowDistance + rowThickness;
        rowNumber++;
      }
    }
  }, [onSelect]);

  return <div ref={svgContainer} className="h-[450px] w-full">
    <svg ref={svgRef} />
  </div> ;
};
