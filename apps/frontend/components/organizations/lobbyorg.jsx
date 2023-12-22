'use client'
// vim: sw=2
import * as d3 from "d3";
import { useEffect } from "react";

import dummyData from "../../assets/lobbyorg-fakedata/network_debug.json";
import { useTheme  } from "next-themes"

export function LobbyOrg() {

  const { resolvedTheme  } = useTheme();
  const darkMode = resolvedTheme === 'dark'; // dark native :^)

  const colorLight         = '#FFF';
  const colorDark          = '#000';
  const colorLightInactive = "#555"
  const colorLightActive   = "#DD3333"
  const colorDarkInactive  = "#aaa"
  const colorDarkActive    = "#22aaff"

  const colorFG       = darkMode ? colorLight        : colorDark;
  const colorBG       = darkMode ? colorDark         : colorLight;
  const colorActive   = darkMode ? colorDarkActive   : colorLightActive;
  const colorInactive = darkMode ? colorDarkInactive : colorLightInactive;

  useEffect(() => {

    // PARAMETERS -------------------------------------------------------------

    const margin = { top: 25, right: 25, bottom: 25, left: 25 };
    const width = 500;
    const height = 500;

    const bulletRadius = 1;
    const bulletPadding = 7;
    const linkOpacity = 0.75;
    const duration = 250;
    const fontStyle = '14px sans-serif';
    const borderStyle = `3px solid ${colorFG}`;

    const dx = 45;
    const dy = Math.max(width / 3, 45);
    const horizontalIndentationBranch2org = (3 / 5) * width;
    const horizontalIndentationParty2parl = (2 / 5) * width;

    // DO NOT CHANGE  ---------------------------------------------------------

    const dummyRootId = -1;
    const dummyRootName = 'dummyRoot';
    const dummyRootCategory = 'dummy';

    const container = d3.select('#container');
    const diagonal = d3.linkHorizontal().x((d) => d.y).y((d) => d.x);

    // DEFINITIONS ------------------------------------------------------------

    const drawVisualization = (data) => {

      const svg = d3.create("svg")
        .attr('width', '100%')
        .attr('height', '83vh')
        .style('font', fontStyle)
        .style('border', borderStyle)
        .style('user-select', 'none')
        .attr('viewBox', [
          -margin.left, -margin.bottom, width+margin.right, height+margin.top
        ]);

      // DEF: drawNodes -------------------------------------------------------

      // const drawNodes = (nodes, offsetX, alignment, circleClassName) => {
      //   const rightAlignment = alignment === 'right';

      //   // TODO: maybe supply as argument similar to offsetX
      //   // Calculate the vertical space between text elements
      //   const verticalSpace = Math.min(Math.max(height / nodes.length, minSpace), maxSpace);

      //   // Create a group for the text elements
      //   const textGroup = svg.append("g");

      //   // Bind data to text elements
      //   const textElements = textGroup.selectAll("g")
      //     .data(nodes)
      //     .enter().append("g")
      //     .attr("transform", (d, i) =>
      //       `translate(${offsetX},${i * verticalSpace})`
      //     )
      //     .on("click", (e, d) => handleClick(d))
      //     .on("mouseover", (e, d) => handleMouseOver(d))
      //     .on("mouseout", (e, d) => handleMouseOut(d));

      //   // Append circles to the left
      //   const leftCircles = textElements.append("circle")
      //     .attr('class', rightAlignment ? null : circleClassName)
      //     .attr('r', bulletRadius)
      //     .attr('cy', 0)
      //     .attr('cx', (d) => {
      //       const width = getTextDimensions(d.name)[0];
      //       return rightAlignment ? -(bulletPadding + width) : -bulletPadding
      //     })
      //     // TODO: there must be a better way than repeating the above code...
      //     .datum((d, i) => {
      //       const width = getTextDimensions(d.name)[0];
      //       return ({
      //         cx: (rightAlignment ? -(bulletPadding + width) : -bulletPadding),
      //         cy: 0,
      //         id: d.id,
      //         tx: offsetX,
      //         ty: i * verticalSpace
      //       });
      //     });

      //   // Append text elements
      //   textElements.append("text")
      //     .text(d => d.name)
      //     // Adjust horizontal position
      //     .attr("x", 0)
      //     // Adjust vertical position for centering
      //     .attr("y", (d) => getTextDimensions(d.name)[1] / 4)
      //     // color of text
      //     .attr('fill', colorFG)
      //     // Alignment of the text
      //     .style("text-anchor", rightAlignment ? 'end' : 'start');

      //   // Append circles to the right
      //   const rightCircles = textElements.append("circle")
      //     .attr('class', rightAlignment ? circleClassName : null)
      //     .attr("r", bulletRadius)
      //     .attr("cy", 0)
      //     .attr("cx", (d) => {
      //       const width = getTextDimensions(d.name)[0];
      //       return rightAlignment ?  bulletPadding : bulletPadding + width
      //     })
      //     // TODO: there must be a better way than repeating the above code...
      //     .datum((d, i) => {
      //       const width = getTextDimensions(d.name)[0];
      //       return ({
      //         cx: (rightAlignment ? bulletPadding : bulletPadding + width),
      //         cy: 0,
      //         id: d.id,
      //         tx: offsetX,
      //         ty: i * verticalSpace
      //       });
      //     });

      //   // Additional styling if needed
      //   textElements.selectAll('circle')
      //     .style("fill", colorInactive)
      //     .style("opacity", 0)

      //   // Click event handler
      //   function handleClick(d) {
      //     const circles = rightAlignment ? leftCircles : rightCircles;
      //     const selectedCircle = circles.filter((c) => c.id === d.id);

      //     selectedCircle.transition()
      //       .duration(duration)
      //       // Toggle opacity give the current opacity
      //       .style("opacity", function () {
      //         return d3.select(this).style("opacity") === "0" ? 1 : 0;
      //       });
      //   }

      //   // Mouseover event handler
      //   function handleMouseOver(d) {
      //     // Change the color on hover
      //     d3.selectAll('path.branch2party')
      //       .filter((c) => c.branch === d.id || c.party === d.id)
      //       .attr('stroke', colorActive)
      //     d3.select(this).selectAll("circle")
      //       .style("fill", colorActive);
      //     d3.select(this).selectAll("text")
      //       .style("font-weight", "bold");
      //   }

      //   // Mouseout event handler
      //   function handleMouseOut(d) {
      //     // Restore the color on mouseout
      //     d3.selectAll('path.branch2party')
      //       .filter((c) => c.branch === d.id || c.party === d.id)
      //       .attr('stroke', colorInactive)
      //     d3.select(this).selectAll("circle")
      //       .style("fill", colorInactive);
      //     d3.select(this).selectAll("text")
      //       .style("font-weight", "normal");
      //   }
      // }; // END drawNodes

      // DEF: constructTreeRepresentation -------------------------------------

      const constructTreeRepresentation = (
        rootId, rootName, rootCat, id_trees, nodes, leaves
      ) => {
        return ({
          // level-0: dummy root
          "id": rootId,
          "name": rootName,
          "category": rootCat,
          // construct actual subtrees with objects instead of ids as nodes
          "children": id_trees.map((id_tree) => {
            const [node] = nodes.filter((n) => n.id === id_tree.root_id);
            return ({
              // level-1: node (i.e. branch or party)
              "id": node.id,
              "name": node.name,
              "category": node.category,
              // level-2: leaves affiliated with nodes (i.e. orgs/parls for branch/party)
              "children": leaves.filter(
                (leaf) => id_tree.children_id.includes(leaf.id)
              )
            });
          })
        });
      }; // END constructTreeRepresentation

      // DEF: drawTree --------------------------------------------------------

      const drawTree = (data, origin, dx, dy, growDirection, nodeLabel, leafLabel) => {
        const growLeft = growDirection === 'left';

        const tree = d3.tree().nodeSize([dx, dy]);
        const root = d3.hierarchy(data);
        root.sort((a, b) => a.data.name.localeCompare(b.data.name));

        root.x0 = origin.x;
        root.y0 = origin.y;
        root.descendants().reverse().forEach((d) => {
          d.id = d.data.id;
          d._children = d.children;
           // NOTE: dont get confused with height, its from tree, TODO rename to txtWidth
          d.width = getTextDimensions(d.data.name)[0];
          d.children_id = d.children ? d.children.map((c) => c.id) : [];
        })

        // grow tree to left if necessary
        tree(root).each((node) => node.y = (growLeft ? -1 : 1) * node.y);

        const gLink = svg
          .append('g')
          .attr('fill', 'none')
          .attr('stroke', colorInactive)
          .attr('stroke-opacity', linkOpacity)
          .attr('stroke-width', bulletRadius)
          .attr('transform', `translate(${origin.x},${origin.y})`);

        const gNode = svg
          .append('g')
          .attr('cursor', 'pointer')
          .attr('pointer-events', 'all')
          .attr('transform', `translate(${origin.x},${origin.y})`);

        update(root);

        function update(source) {

          const nodes = root
            .descendants()
            .reverse()
            .filter((d) => d.id !== root.id)

          const links = root
            .links()
            .filter((l) => ![l.source.id, l.target.id].includes(root.id));

          // compute new tree layout
          const left = d3.min(root.descendants(), (node) => node.x);
          const right = d3.max(root.descendants(), (node) => node.x);

          // const height = right.x - left.x + margin.top + margin.bottom;

          const transition = svg
            .transition()
            .duration(duration);

          const node = gNode
            .selectAll('g')
            .data(nodes, (d) => d.id)

          // Enter any new nodes at the parent's previous position.
          const nodeEnter = node
            .enter()
            .append('g')
            .attr('transform', (d) => {
              const offset = (growLeft ? -1 : 1) * (2 * bulletPadding + source.width);
              return `translate(${source.y + offset},${source.x})`;
            })
            // make invisible first
            .attr('fill-opacity', 0)
            .attr('stroke-opacity', 0)
            .attr('class', (d) =>
              d.depth === 1 ? nodeLabel : d.depth === 2 ? leafLabel : null
            )
            .on('click', (event, d) => {
              if (d.depth !== 1) return;
              d.children = d.children ? null : d._children;
              update(d);
            });

          // inner circles
          nodeEnter
            .append('circle')
            .filter((d) => d.depth !== 0) // do not add inner circles to roots
            .attr('class', (d) => d.depth === 1 ? nodeLabel : null)
            .attr('r', bulletRadius)
            .attr('fill', colorFG)
            .attr('stroke-width', bulletRadius);

          // labels
          nodeEnter
            .append('text')
            .text((d) => d.data.name)
            .attr('text-anchor', growLeft ? 'end' : 'start')
            // TODO: add txtHeight to d, also adapt width to txtWidth
            .attr('dy', (d) => getTextDimensions(d.data.name)[1] / 4)
            .attr('dx', (growLeft ? -1 : 1) * bulletPadding)
            .clone(true)
            .lower()
            .attr('stroke-linejoin', 'round')
            .attr('stroke-width', bulletRadius)
            .attr('stroke', colorBG);

          // outer circle
          nodeEnter
            .append('circle')
            // do not add outer circles to leaves
            .filter((d) => d.depth !== 2) 
            // do not add outer circles to leaves or nodes without children
            .filter((d) => !(d.data.children !== null && d.data.children.length === 0))
            .attr('r', bulletRadius)
            .attr('cx', (d) => (growLeft ? -1 : 1) * (2 * bulletPadding + d.width))
            .attr('fill', colorFG)
            .attr('stroke-width', bulletRadius);

          // transition nodes to their new position
          node
            .merge(nodeEnter)
            .transition(transition)
            .attr('transform', (d) => `translate(${d.y},${d.x})`)
            // make visible on enter
            .attr('fill-opacity', 1)
            .attr('stroke-opacity', 1);

          // transition exiting nodes to the parent's new position
          node
            .exit()
            .transition(transition)
            .remove()
            .attr('transform', (d) => {
              const offset = (growLeft ? -1 : 1) * (2 * bulletPadding + source.width);
              return `translate(${source.y + offset},${source.x})`;
            })
            // make invisivble on exit
            .attr('fill-opacity', 0)
            .attr('stroke-opacity', 0);

          // Update the links…
          const link = gLink
            .selectAll('path')
            .data(links, (d) => d.target.id)
            .attr('class', (d) => {
              const [x, y] = [d.source.depth, d.target.depth].sort();
              return (x === 1 && y === 2) ? `${nodeLabel}2${leafLabel}Link` : null;
            });

          // enter any new links at the parent's previous position
          const linkEnter = link
            .enter()
            .append('path')
            .attr('d', (d) => {
              const offset = (growLeft ? -1 : 1) * (2 * bulletPadding + source.width);
              const o = { x: source.x, y: source.y + offset };
              return diagonal({ source: o, target: o });
            });

          // transition links to their new position
          link
            .merge(linkEnter)
            .transition(transition)
            .attr('d', (d) => {
              const offset = (growLeft ? -1 : 1) * (2 * bulletPadding + d.source.width);
              const s = { x: d.source.x, y: d.source.y + offset };
              const t = { x: d.target.x, y: d.target.y          };
              return diagonal({ source: s, target: t });
            });

          // transition exiting nodes to parent's new position
          link
            .exit()
            .transition(transition)
            .remove()
            .attr('d', (d) => {
              const offset = (growLeft ? -1 : 1) * (2 * bulletPadding + source.width);
              const o = { x: source.x, y: source.y + offset };
              return diagonal({ source: o, target: o });
            });

          // stash old positions for transition
          root.eachBefore((d) => { d.x0 = d.x; d.y0 = d.y; });

        } // END update
      }; // END drawTree

      // DEF: drawEdges -------------------------------------------------------

      const drawLinks = (links, leftOrigin, rightOrigin, leftCircles, rightCircles, linkClass) => {

        const gLink = svg
          .append('g')
          .attr('fill', 'none')
          .attr('stroke', colorInactive)
          .attr('stroke-opacity', linkOpacity)
          .attr('stroke-width', bulletRadius);

        const link = gLink
          .selectAll('path')
          .data(links, (d) => d.target.id);

        const linkEnter = link
          .enter()
          .append('path')
          .attr('class', linkClass)
          .attr('d', (d) => {
            const lc = leftCircles.filter((c) => c.data.id === d.source).datum();
            const rc = rightCircles.filter((c) => c.data.id === d.target).datum();
            const s = { x: leftOrigin.y  + lc.x, y: leftOrigin.x  + lc.y };
            const t = { x: rightOrigin.y + rc.x, y: rightOrigin.x + rc.y };
            return diagonal({ source: s, target: t });
          })
          .attr('fill', 'none')
          .attr('stroke', colorInactive)
          .attr('stroke-width', bulletRadius)
          .each((d) => {
            const linkIds = [d.source, d.target];
            const branchNode = svg.selectAll('g.branch').filter((n) => linkIds.includes(n.id)).datum();
            const partyNode = svg.selectAll('g.party').filter((n) => linkIds.includes(n.id)).datum();
            d.reachable = {
              'org': branchNode.children_id,
              'parl': partyNode.children_id
            };
            return d;
          })
          .on('mouseover', (e, d) => {
            const prev = d3.select(e.target).attr('stroke');
            d3.select(e.target).attr('stroke', prev === colorInactive ? colorActive : colorInactive);
            // const link = svg.selectAll(`path.${linkClass}`).filter((l) => l.id === e.target.id);
            console.log(e); 
            // const link = svg.selectAll(`path.${linkClass}`)
            //   .filter((l) => l.id === d.id);
            //   .style('stroke', function () {
            //       return d3.select(this).style("opacity") === "0" ? 1 : 0;
            //   });
            // console.log(link);
          })
          .on('mouseout', (e, d) => {
            const prev = d3.select(e.target).attr('stroke');
            d3.select(e.target).attr('stroke', prev === colorInactive ? colorActive : colorInactive);
          });

      }; // END drawLinks

      // SETUP ----------------------------------------------------------------

      // nodes
      const getNodesByCategory = (c) => data.nodes.filter((n) => n.category === c);
      const branches      = getNodesByCategory('branch'); // branch of organizations
      const organizations = getNodesByCategory('org');    // lobby organizations
      const parties       = getNodesByCategory('party');  // political parties
      const parls         = getNodesByCategory('parl');   // parliamentarians

      // edge data
      const branch2party = data.branch2party_edges;

      const treeRepBranch2org = constructTreeRepresentation(
        dummyRootId, dummyRootName, dummyRootCategory,
        data.branch2org_idtrees, branches, organizations
      );

      const treeRepParty2parl = constructTreeRepresentation(
        dummyRootId, dummyRootName, dummyRootCategory,
        data.party2parl_idtrees, parties, parls
      );

      // tree origins
      const originBranch2org = { 
        x:  horizontalIndentationBranch2org, y: height / 2
      };

      const originParty2parl = {
        x:  horizontalIndentationParty2parl, y: height / 2
      }

      // DRAW -----------------------------------------------------------------


      drawTree(treeRepBranch2org, originBranch2org, dx, dy, 'left', 'branch', 'org');
      drawTree(treeRepParty2parl, originParty2parl, dx, dy, 'right', 'party', 'parl');

      const branchCircles = svg.selectAll('circle.branch');
      const partyCircles = svg.selectAll('circle.party');

      drawLinks(branch2party, originBranch2org, originParty2parl, branchCircles, partyCircles, 'branch2party');

      // UPDATE ---------------------------------------------------------------

      // Remove the existing SVG element
      container.selectAll('svg').remove();
      // Append the updated SVG element
      container.append(() => svg.node());

    } // END drawVisualization

    // HELPER -----------------------------------------------------------------

    // Function to calculate text width dynamically
    function getTextDimensions(text) {
      const offScreenSvg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
      document.body.appendChild(offScreenSvg);
      const dummyText = d3.select(offScreenSvg).append("text").text(text).style('font', fontStyle).node();
      const width = dummyText.getBBox().width;
      const height = dummyText.getBBox().height;
      offScreenSvg.remove();
      return [width, height];
    }

    drawVisualization(dummyData);
  }, []);

  return (
    <div id='container' />
  )
}

// export default LobbyOrg;
