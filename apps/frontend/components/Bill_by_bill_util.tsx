//@ts-nocheck
import { $Enums, PrismaClient } from '@prisma/client';
import React, { useEffect, useRef } from 'react';
import {loadBillVoteresbyid, loadBillById, getAllParliamentarians, getParliamentarianById} from './getbills';
import * as d3 from 'd3';


const prisma = new PrismaClient();

async function scoreParliamentarian(parliamentarianId: string): Promise<Map<string, number>> {
    try {
        const parliamentarian = await getParliamentarianById(parliamentarianId);

        const scoreMap = new Map<string, number>();

        if (parliamentarian) {
            const orgs = parliamentarian.relatedOrganizations;
            
            orgs.forEach(org => {
                const organization = org.organizationId;
                const influencemod = org.influenceLevel === "TIEF" || org.influenceLevel === "UNKNOWN" ? 1 : org.influenceLevel === "MITTEL" ? 2 : 3;
                const score = influencemod;
                scoreMap.set(organization, score);
            });
        }

        return scoreMap;
    } catch (error) {
        console.error('Error scoring Parliamentarian:', error);
        throw error;
    }
}

async function totalScore(parliamentarianIds: string[]): Promise<number> {
    let total = 0;

    for (const parliamentarianId of parliamentarianIds) {
        const scoreMap = await scoreParliamentarian(parliamentarianId);

        for (const score of scoreMap.values()) {
            total += score;
        }
    }

    return total;
}


async function calculateBillScores(billId: string): Promise<[number, number, number, string[], string[]]> {
    const bill = await loadBillById(billId);

    if (!bill) {
        throw new Error(`Bill with id ${billId} not found.`);
    }
    const yesVotersIds = bill.votes.filter(vote => vote.voteStatus === 'YES').map(vote => vote.parliamentarianId);
    const noVotersIds = bill.votes.filter(vote => vote.voteStatus === 'NO').map(vote => vote.parliamentarianId);
    const sponsorId = bill.sponsor.id;
    const sponsorScore = await totalScore([sponsorId]);
    const yesVotersScore = await totalScore(yesVotersIds);
    const noVotersScore = await totalScore(noVotersIds);
    return [sponsorScore, yesVotersScore, noVotersScore, yesVotersIds, noVotersIds];
}

async function calculateBillmaps(billId: string): Promise<[Map<string, number>, Map<string, number>]> {
    const bill = await loadBillById(billId);

    if (!bill) {
        throw new Error(`Bill with id ${billId} not found.`);
    }
    const yesVotersIds = bill.votes.filter(vote => vote.voteStatus === 'YES').map(vote => vote.parliamentarianId);
    const noVotersIds = bill.votes.filter(vote => vote.voteStatus === 'NO').map(vote => vote.parliamentarianId);
    const sponsorId = bill.sponsor.id;
    //compute the average maps for the yes and no voters
    const yesVotersScoremap = new Map<string, number>();
    const noVotersScoremap = new Map<string, number>();
    
    for (const parliamentarianId of yesVotersIds) {
        const scoreMap = await scoreParliamentarian(parliamentarianId);
        for (const [organization, score] of Array.from(scoreMap.entries())) {
            if (yesVotersScoremap.has(organization) && yesVotersScoremap.get(organization) != null) {
                const currentscore = yesVotersScoremap.get(organization);
                yesVotersScoremap.set(organization, currentscore + score);
            } else {
                yesVotersScoremap.set(organization, score);
            }
        }
    }
    for (const parliamentarianId of noVotersIds) {
        const scoreMap = await scoreParliamentarian(parliamentarianId);
        for (const [organization, score] of Array.from(scoreMap.entries())) {
            if (noVotersScoremap.has(organization)) {
                const currentscore = noVotersScoremap.get(organization);
                noVotersScoremap.set(organization, currentscore + score);
            } else {
                noVotersScoremap.set(organization, score);
            }
        }
    }
    return [yesVotersScoremap, noVotersScoremap];
}

interface BarVisualizationProps {
    data: number[]; // Input data for the bar visualization
    isVoteVisualization: boolean; // Flag indicating whether it's a vote visualization
}

const createPieChart = (yes, no, abstain) => {
  // Calculate total votes
  const totalVotes = yes + no + abstain;

  // Data for the pie chart
  const data = [
    { label: 'Yes', value: yes },
    { label: 'No', value: no },
    { label: 'Abstain', value: abstain },
  ];

  // Colors for the pie chart
  const colors = ['#4CAF50', '#FF5252', '#B0BEC5']; // Green, Red, Grey

  // SVG dimensions
  const width = 300;
  const height = 300;
  const radius = Math.min(width, height) / 2;

  // Create a pie chart
  const pie = d3.pie().value(d => d.value);
  const arc = d3.arc().innerRadius(0).outerRadius(radius);

  // Create SVG container
  const svg = d3.create('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
    .attr('transform', `translate(${width / 2},${height / 2})`);

  // Add pie slices
  svg.selectAll('path')
    .data(pie(data))
    .enter()
    .append('path')
    .attr('d', arc)
    .attr('fill', (d, i) => colors[i])
    .attr('stroke', 'white')
    .style('stroke-width', '2px');

  // Convert the SVG to a string
  return svg
};

export const createBarChartFromBillId = async (billId: string) => {
  const votes = await loadBillVoteresbyid(billId);
  const yesVotersIds = votes[0];
  const noVotersIds = votes[1];
  const abstainVotersIds = votes[2];
  const yesVoterslen = yesVotersIds.length;
  const noVoterslen = noVotersIds.length;
  const abstainVoterslen = abstainVotersIds.length;
  const svgString = createPieChart(yesVoterslen, noVoterslen, abstainVoterslen);
  return svgString;
}

const BarVisualization = ({ data, isVoteVisualization }) => {
  // Set up dimensions
  const width = 750;
  const height = 100; // Increased height to accommodate annotations
  const margin = { top: 20, right: 20, bottom: 40, left: 20 };
  const innerWidth = width - margin.left - margin.right;
  const innerHeight = height - margin.top - margin.bottom;

  // Create scales
  const xScale = d3.scaleLinear()
    .domain([0, d3.max(data)])
    .range([0, innerWidth]);

  const yScale = d3.scaleBand()
    .domain(['Bar']) // Updated domain to a single value
    .range([0, innerHeight])
    .padding(0.1);

  // Create SVG string
  let svgString = `<svg width="${width}" height="${height}">`;

  // Create segmented horizontal bar
  svgString += `<g>`;
  svgString += `<rect x="${margin.left}" y="${margin.top}" width="${innerWidth}" height="${yScale.bandwidth()}" fill="lightgray" rx="5" ry="5" />`;

  svgString += `<rect x="${margin.left}" y="${margin.top}" 
    width="${xScale(data[0])}" height="${yScale.bandwidth()}" 
    fill="${isVoteVisualization ? 'green' : 'darkgray'}" rx="5" ry="5" />`; // Single bar with variable width

  svgString += `</g>`;

  // Add number at the end of the segment
  svgString += `<g>`;
  if (data[0] !== 0) {
    const textX = margin.left + xScale(data[0]) - 5; // Adjusted x-coordinate for text
    svgString += `<text x="${textX}" 
      y="${margin.top + yScale('Bar') + yScale.bandwidth() / 2}" 
      text-anchor="end" fill="${isVoteVisualization ? 'white' : 'white'}">${data[0]}</text>`;
  }
  svgString += `</g>`;

  // Add annotations for the segment
  if (isVoteVisualization) {
    svgString += `<g>`;
    if (data[0] !== 0) {
      svgString += `<text x="${margin.left + innerWidth + 10}" y="${margin.top + yScale('Bar') + yScale.bandwidth() / 2}" fill="green">Bar</text>`;
    }
    svgString += `</g>`;
  }

  // Add margins for text placement
  svgString += `<g>`;
  svgString += `<text x="${margin.left}" y="${height - margin.bottom + 20}" fill="black">Yes</text>`;
  svgString += `<text x="${width - margin.right}" y="${height - margin.bottom + 20}" text-anchor="end" fill="black">No</text>`;
  svgString += `<text x="${width / 2}" y="${height - 10}" text-anchor="middle" fill="black">Abstain</text>`;
  svgString += `</g>`;

  // Close the SVG tag
  svgString += `</svg>`;

  return svgString;
};


//compute average score of any parliamentarian, cache it 
let averageMappingCache: { averagemap: Map<string, number>, maxTotalScore: number } | null = null;

export async function getaveragemapping(): Promise<{ averagemap: Map<string, number>, maxTotalScore: number }> {
  if (averageMappingCache) {
    return averageMappingCache;
  }

  const parliamentarians = await getAllParliamentarians();
  const averagemap = new Map<string, number>();
  let maxTotalScore = 0; // Initialize max total score variable

  for (const parliamentarian of parliamentarians) {
    const parliamentarianId = parliamentarian.id;
    const scoreMap = await scoreParliamentarian(parliamentarianId);
    let totalScore = 0; // Initialize total score for each parliamentarian

    // go through the score map, and add the scores to the average map
    for (const [organization, score] of Array.from(scoreMap.entries())) {
      if (averagemap.has(organization)) {
        const currentscore = averagemap.get(organization);
        averagemap.set(organization, currentscore + score);
      } else {
        averagemap.set(organization, score);
      }
      totalScore += score; // Add score to total score
    }

    // Update max total score if necessary
    if (totalScore > maxTotalScore) {
      maxTotalScore = totalScore;
    }

    // divide all the scores by the number of parliamentarians
    for (const [organization, score] of Array.from(averagemap.entries())) {
      averagemap.set(organization, score / parliamentarians.length);
    }
  }

  averageMappingCache = { averagemap, maxTotalScore }; // Cache the result

  return averageMappingCache;
}

export function computeanomaly(VotersScoremap: Map<string, number>, averagemap: Map<string, number>, ){
    // do the anomaly computation
    const anomaly = new Map<string, number>();
    var anomalyvalue = 0;
    for (const [organization, score] of Array.from(VotersScoremap.entries())) {
        const average = averagemap.get(organization);
        if (!average) {
            anomalyvalue = 0;
        }else{
          anomalyvalue = score - average;
        }
        anomaly.set(organization, anomalyvalue);
    }

    //sort the anomaly map
    const sortedanomaly = new Map([...Array.from(anomaly.entries())].sort((a, b) => b[1] - a[1]));
    //return the anomaly map
    return sortedanomaly;    
}

export async function getallTop3(sponsorId: string, yesVotersIds: string[], noVotersIds: string[]){
    const averagemapping = await getaveragemapping()
    const averagemap =  averagemapping.averagemap;
    var averagescore =0;
    for (const [organization, score] of Array.from(averagemap.entries())) {
        averagescore += score;
    }
    averagescore = averagescore/averagemap.size;

    const sponsorScore = await totalScore([sponsorId]);
    const sponsormap = await scoreParliamentarian(sponsorId);
    var sponsorClassification = "Low";
    if (sponsorScore >(averagescore+ averagemapping.maxTotalScore)/2){
        sponsorClassification = "High";
    } else if (sponsorScore > averagescore* 0.667 ){
        sponsorClassification = "Medium";
    }
    const sponsorAnomaly = computeanomaly(sponsormap, averagemap);
    //PUT THE first 3 in the sponsorTop3
    const sponsorTop3 = [...sponsorAnomaly.keys()].slice(0, 3);


    const yesVotersMap = new Map<string, number>();
    for (const voterId of yesVotersIds) {
      const voterMap = await scoreParliamentarian(voterId);
      for (const [organization, score] of Array.from(voterMap.entries())) {
        if (yesVotersMap.has(organization)) {
          const currentScore = yesVotersMap.get(organization);
          yesVotersMap.set(organization, currentScore + score);
        } else {
          yesVotersMap.set(organization, score);
        }
      }
    }
    //divide the yesVotersMap by the number of yesVoters
    for (const [organization, score] of Array.from(yesVotersMap.entries())) {
      yesVotersMap.set(organization, score / yesVotersIds.length);
    }
    //calculate the total score of yesVoters by iterating through the yesVotersMap
    var yesVotersScore = 0;
    for (const [organization, score] of Array.from(yesVotersMap.entries())) {
      yesVotersScore += score;
    }
    var yesVotersClassification = "Low";
    if (yesVotersScore > (averagescore + averagemapping.maxTotalScore) / 2) {
      yesVotersClassification = "High";
    } else if (yesVotersScore > averagescore * 0.667) {
      yesVotersClassification = "Medium";
    }
    const constyesVotersAnomaly = computeanomaly(yesVotersMap, averagemap);
    //PUT THE first 3 in the yesVotersTop3
    const yesVotersTop3 = [...constyesVotersAnomaly.keys()].slice(0, 3);

    const noVotersMap = new Map<string, number>();
    for (const voterId of noVotersIds) {
      const voterMap = await scoreParliamentarian(voterId);
      for (const [organization, score] of Array.from(voterMap.entries())) {
        if (noVotersMap.has(organization)) {
          const currentScore = noVotersMap.get(organization);
          noVotersMap.set(organization, currentScore + score);
        } else {
          noVotersMap.set(organization, score);
        }
      }
    }
    //divide the yesVotersMap by the number of yesVoters
    for (const [organization, score] of Array.from(noVotersMap.entries())) {
      yesVotersMap.set(organization, score / yesVotersIds.length);
    }
    //calculate the total score of yesVoters
    var noVotersScore = 0;
    for (const [organization, score] of Array.from(noVotersMap.entries())) {
      noVotersScore += score;
    }
    
    var noVotersClassification = "Low";
    if (noVotersScore >(averagescore+ averagemapping.maxTotalScore)/2){
        noVotersClassification = "High";
    } else if (noVotersScore > averagescore* 0.667 ){
        noVotersClassification = "Medium";
    }
    const constnoVotersAnomaly = computeanomaly(noVotersMap, averagemap);
    //PUT THE first 3 in the noVotersTop3
    const noVotersTop3 = [...constnoVotersAnomaly.keys()].slice(0, 3);

    return [sponsorClassification, sponsorTop3, yesVotersClassification, yesVotersTop3, noVotersClassification, noVotersTop3];

}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 


// function that gets the list of votes for a bill and returns the bar chart, takes in tuple of yes, no, abstain lists
export async function makevotesbar(billId: string): Promise<string> {
    const votes = await loadBillVoteresbyid(billId);
    const yesVotersIds = votes[0];
    const noVotersIds = votes[1];
    const abstainVotersIds = votes[2];
    const yesVoterslen = yesVotersIds.length;
    const noVoterslen = noVotersIds.length;
    const abstainVoterslen = abstainVotersIds.length;
    const data = [yesVoterslen, noVoterslen, abstainVoterslen];
    const svgString = BarVisualization({ data, isVoteVisualization: true });
    return svgString;
  }
  
  export async function makesponsorbar(billId: string): Promise<string> {
    const scores = await calculateBillScores(billId);
    const sponsorScore = scores[0];
    const a = await getaveragemapping();
    const maxTotalScore = a.maxTotalScore;
    const data = [sponsorScore, maxTotalScore];
    const svgString = BarVisualization({ data, isVoteVisualization: false });
    return svgString;
  }
  
  export async function makeyesbar(billId: string): Promise<string> {
    const maps = await calculateBillmaps(billId);
    const yesVotersScoremap = maps[0];
    const a = await getaveragemapping();
    const averagemap = a.averagemap;
    const anomalymap = computeanomaly(yesVotersScoremap, averagemap);
    let sum = 0;
    let i = 0;
    for (const [organization, score] of Array.from(anomalymap.entries())) {
      if (i < 5) {
        sum += score;
      }
      i++;
    }
    let total = 0;
    for (const [organization, score] of Array.from(anomalymap.entries())) {
      total += Math.abs(score);
    }
    const data = [sum, total];
    const svgString = BarVisualization({ data, isVoteVisualization: false });
    return svgString;
  }
  
  export async function makenobar(billId: string): Promise<string> {
    const maps = await calculateBillmaps(billId);
    const noVotersScoremap = maps[1];
    const a = await getaveragemapping();
    const averagemap = a.averagemap;
    const anomalymap = computeanomaly(noVotersScoremap, averagemap);
    let sum = 0;
    let i = 0;
    for (const [organization, score] of Arrays.from(anomalymap.entries())) {
      if (i < 5) {
        sum += score;
      }
      i++;
    }
    let total = 0;
    for (const [organization, score] of Arrays.from(anomalymap.entries())) {
      total += Math.abs(score);
    }
    const data = [sum, total];
    const svgString = BarVisualization({ data, isVoteVisualization: false });
    console.log(svgString);
    return svgString;
  }