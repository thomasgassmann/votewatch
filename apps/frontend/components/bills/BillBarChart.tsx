'use client'
import * as d3 from "d3";
import { Vote } from "lucide-react";
import { range } from "rambdax";
import { useEffect, useRef } from "react";
import { Bar, BarChart, Legend, ResponsiveContainer, XAxis, YAxis } from "recharts";

interface BillBarChartProps {
  votes: {
    yesVotes: number;
    noVotes: number;
    unknownVotes: number;
  }
}

export default function BillBarChart({ votes }: BillBarChartProps) {

    const { yesVotes, noVotes, unknownVotes } = votes;
    const totalVotes = yesVotes + noVotes + unknownVotes;

    // Data for the pie chart
    const data = [
        { label: "Vote", ...votes},
    ];

    // Colors for the pie chart
    const colors = ["#4CAF50", "#B0BEC5", "#FF5252"]; // Green, Gray, Red


    return (
        <ResponsiveContainer height={25} width={"100%"}>
          <BarChart
            layout="vertical"
            data={data}
            stackOffset="expand"
          >
            <XAxis hide type="number" />
            <YAxis
              hide
              type="category"
              dataKey="label"
            />
              <Bar name="Yes" dataKey={"yesVotes"} fill={colors[0]} stackId="a" radius={[20, 0, 0, 20]} />
              <Bar name="Other" dataKey={"unknownVotes"} fill={colors[1]} stackId="a" />
              <Bar name="No" dataKey={"noVotes"} fill={colors[2]} stackId="a" radius={[0, 20, 20, 0]} />
          </BarChart>
        </ResponsiveContainer>
    );
};
