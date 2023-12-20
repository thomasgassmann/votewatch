'use client'
import * as d3 from "d3";
import { useEffect, useRef } from "react";

export const BillPie = ({data}) => {
    const svgRef = useRef<SVGSVGElement>(null);
    
    useEffect(() => {
        if (svgRef.current) {
            d3.select(svgRef.current).selectAll('*').remove();
            // SVG dimensions
            const width = 150; // Updated width
            const height = 150; // Updated height
            const radius = Math.min(width, height) / 2;
            
            const svg = d3.select(svgRef.current)
                .append('svg')
                .attr('width', width) // Set the width
                .attr('height', height) // Set the height
                .attr('viewBox', `0 0 ${width} ${height}`) // Set the viewBox to maintain aspect ratio
                .append('g') // Append a group element for centering
                .attr('transform', `translate(${width / 2}, ${height / 2})`); // Center the group element
            
            // Calculate total votes
            const yeslength = data[0].length;
            const nolength = data[1].length;
            const abstainlength = data[2].length;


            const totalVotes = yeslength + nolength + abstainlength;

            // Data for the pie chart
            const pieData = [
                { label: 'Yes', value: yeslength },
                { label: 'No', value: nolength},
                { label: 'Abstain', value: abstainlength },
            ];

            // Colors for the pie chart
            const colors = ['#4CAF50', '#FF5252', '#B0BEC5']; // Green, Red, Grey

            

            // Create a pie chart
            const pie = d3.pie().value(d => d.value);
            const arc = d3.arc().innerRadius(0).outerRadius(radius);

            // Add pie slices
            svg.selectAll('path')
                .data(pie(pieData))
                .enter()
                .append('path')
                .attr('d', arc)
                .attr('fill', (d, i) => colors[i])
                .attr('stroke', 'white')
                .style('stroke-width', '2px');

            // Add vote count labels
            svg.selectAll('text')
                .data(pie(pieData))
                .enter()
                .append('text')
                .attr('transform', d => `translate(${arc.centroid(d)})`)
                .attr('dy', '0.35em')
                .attr('text-anchor', 'middle')
                .text(d => d.data.value);
        }
    }, [data]);
    
    return <svg ref={svgRef} />;
};
