'use client'
// vim: sw=2
import * as d3 from "d3";
import { useEffect, useState, useRef } from "react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog"
import { useTheme } from "next-themes"

let mouseX, mouseY = 0;

if (typeof window !== 'undefined') {
  document.addEventListener('mousemove', (e) => {
    mouseX = e.pageX;
    mouseY = e.pageY;
  });
}

export function LobbyOrg({ lobbyOrgData, orgs }) {

  const { resolvedTheme } = useTheme();

  const [selected, setSelected] = useState(null);
  const highlighted_nodes = useRef([]);
  const highlighted_leaves = useRef([]);

  useEffect(() => {

    // THEMING ----------------------------------------------------------------

    const darkMode = resolvedTheme === 'dark'; // dark native :^)

    const colorLight = '#FFF';
    const colorDark = '#000';
    const colorLightInactive = "#555"
    const colorLightActive = "#DD3333"
    const colorDarkInactive = "#aaa"
    const colorDarkActive = "#22aaff"

    const colorFG = darkMode ? colorLight : colorDark;
    const colorBG = darkMode ? colorDark : colorLight;
    const colorActive = darkMode ? colorDarkActive : colorLightActive;
    const colorInactive = darkMode ? colorDarkInactive : colorLightInactive;

    // PARAMETERS -------------------------------------------------------------

    const margin = { top: 25, right: 25, bottom: 25, left: 25 };
    const width = 500;
    const height = 500;

    const linkMinWidth = 0.05 
    const bulletRadius = 1;
    const bulletPadding = 7;
    const linkOpacity = 0.75;
    const duration = 250;
    const fontStyle = '14px sans-serif';
    const borderStyle = `0px solid ${colorFG}`;

    const dx = 45;
    const dy = Math.max(width / 3, 45);
    const horizontalIndentationBranch2org = (3 / 5) * width;
    const horizontalIndentationParty2parl = (2 / 5) * width;

    const zoomScaleMin = 0.01;
    const zoomScaleMax = 10.0;

    // DO NOT CHANGE  ---------------------------------------------------------

    const dummyRootId = -1;
    const dummyRootName = 'dummyRoot';
    const dummyRootCategory = 'dummy';

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
          -margin.left, -margin.bottom, width + margin.right, height + margin.top
        ]);

      const gSvg = svg.append('g');

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
          // by default do not expan and of the branch nodes
          // (because of the amount of organizations)
          if (d.data.category === 'branch' || d.data.category === 'party') {
            d.children = null;
          }
        })

        // grow tree to left if necessary
        tree(root).each((node) => node.y = (growLeft ? -1 : 1) * node.y);

        const gLink = gSvg
          .append('g')
          .attr('fill', 'none')
          .attr('stroke', colorInactive)
          .attr('stroke-opacity', linkOpacity)
          .attr('stroke-width', bulletRadius)
          .attr('transform', `translate(${origin.x},${origin.y})`);

        const gNode = gSvg
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
          // const left = d3.min(root.descendants(), (node) => node.x);
          // const right = d3.max(root.descendants(), (node) => node.x);
          // const height = right.x - left.x + margin.top + margin.bottom;

          const transition = gSvg
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
            .on('click', (_, d) => {
              const id = d.data.id;
              // ids of clicked node and all nodes directly linked to clicked node
              let leaves = [];
              gSvg
                .selectAll('path.branch2party')
                .filter((l) => l.source === id || l.target === id)
                .each((l) => leaves.push(id === l.source ? l.target : l.source));

              if (!highlighted_nodes.current.includes(id)) {
                // add id to highlighted
                highlighted_nodes.current = [...highlighted_nodes.current, id];
                highlighted_leaves.current = [highlighted_leaves.current, ...leaves]
              } else {
                // remove id from highlighted
                highlighted_nodes.current = highlighted_nodes.current.filter((i) => i !== id);
                highlighted_leaves.current = highlighted_leaves.current.filter((i) => !leaves.includes(i));
              }
            })
            .on('mouseover', (_, d) => {
              const id = d.data.id;
              gSvg
                .selectAll('path.branch2party')
                .filter((l) => l.source === id || l.target === id)
                .attr('stroke', colorActive);
            })
            .on('mouseout', (_, d) => {
              const id = d.data.id;
              // node with id has not been clicked
              if (!highlighted_nodes.current.includes(id)) {
                // all links associated with node with id
                const links = gSvg
                  .selectAll('path.branch2party')
                  .filter((l) => l.source === id || l.target === id);

                // reset all links
                links.attr('stroke', colorInactive);

                // highlight only the remembered ones
                links
                  .filter((l) => highlighted_nodes.current.includes(id === l.source ? l.target : l.source))
                  .attr('stroke', colorActive);
              } // node with id has been clicked, do nothing
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
            .attr('fill', colorFG)
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
            .data(links, (d) => d.target.id);

          // enter any new links at the parent's previous position
          const linkEnter = link
            .enter()
            .append('path')
            .attr('class', (d) => {
              const [x, y] = [d.source.depth, d.target.depth].sort();
              return (x === 1 && y === 2) ? nodeLabel : null;
            })
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
              const t = { x: d.target.x, y: d.target.y };
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

        const gLink = gSvg
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
            const s = { x: leftOrigin.y + lc.x, y: leftOrigin.x + lc.y };
            const t = { x: rightOrigin.y + rc.x, y: rightOrigin.x + rc.y };
            return diagonal({ source: s, target: t });
          })
          .attr('fill', 'none')
          .attr('stroke', colorInactive)
          .attr('stroke-width', (d) => linkMinWidth + d.influence_strength)
          .each((d) => {
            const linkIds = [d.source, d.target];
            const branchNode = gSvg.selectAll('g.branch').filter((n) => linkIds.includes(n.id)).datum();
            const partyNode = gSvg.selectAll('g.party').filter((n) => linkIds.includes(n.id)).datum();
            d.reachable = {
              'org': branchNode.children_id,
              'parl': partyNode.children_id
            };
            return d;
          })
          .on('click', (_, d) => {
            setSelected(d);
          })
          .on('mouseover', (e) => {
            highlightLinkReachable(e, colorActive);
          })
          .on('mouseout', (e) => {
            const link = d3.select(e.target).datum();
            const source = link.source;
            const target = link.target;
            const isHighlighted = (s, t) =>
              (highlighted_nodes.current.includes(s) && highlighted_leaves.current.includes(t));

            if (!(isHighlighted(source, target) || isHighlighted(target, source))) {
              highlightLinkReachable(e, colorInactive);
            }
          });

        // increases z-order, i.e. do not paint over circles TODO: does not work?
        const circles = gSvg.selectAll('circle');
        circles.raise();

      }; // END drawLinks

      // SETUP ----------------------------------------------------------------

      // nodes
      const getNodesByCategory = (c) => data.nodes.filter((n) => n.category === c);
      const branches = getNodesByCategory('branch'); // branch of organizations
      const organizations = getNodesByCategory('org');    // lobby organizations
      const parties = getNodesByCategory('party');  // political parties
      const parls = getNodesByCategory('parl');   // parliamentarians

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
        x: horizontalIndentationBranch2org, y: height / 2
      };

      const originParty2parl = {
        x: horizontalIndentationParty2parl, y: height / 2
      }

      // DRAW -----------------------------------------------------------------

      drawTree(treeRepBranch2org, originBranch2org, dx, dy, 'left', 'branch', 'org');
      drawTree(treeRepParty2parl, originParty2parl, dx, dy, 'right', 'party', 'parl');

      const branchCircles = gSvg.selectAll('circle.branch');
      const partyCircles = gSvg.selectAll('circle.party');

      drawLinks(branch2party, originBranch2org, originParty2parl, branchCircles, partyCircles, 'branch2party');

      // UPDATE ---------------------------------------------------------------

      // add SVG to container
      const container = d3.select('#container');
      // Remove the existing SVG element
      container.selectAll('svg').remove();
      // Append the updated SVG element
      container.append(() => svg.node());

      // Create a zoom behavior
      const zoom = d3.zoom()
        .scaleExtent([zoomScaleMin, zoomScaleMax])
        .on('zoom', (e) => d3.select('svg g').attr('transform', e.transform));

      // Call the zoom behavior on the SVG
      svg.call(zoom);

      // HELPER & HANDLER -----------------------------------------------------

      // calculates text width dynamically
      function getTextDimensions(text) {
        const offScreenSvg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        document.body.appendChild(offScreenSvg);
        const dummyText = d3.select(offScreenSvg).append("text").text(text).style('font', fontStyle).node();
        const width = dummyText.getBBox().width;
        const height = dummyText.getBBox().height;
        offScreenSvg.remove();
        return [width, height];
      }

      function highlightLinkReachable(e, color) {
        const link = d3.select(e.target).attr('stroke', color).datum();
        gSvg.selectAll('path.branch')
          .filter((l) =>
            link.reachable['org'].includes(l.source.id) ||
            link.reachable['org'].includes(l.target.id)
          )
          .attr('stroke', color);
        gSvg.selectAll('path.party')
          .filter((l) =>
            link.reachable['parl'].includes(l.source.id) ||
            link.reachable['parl'].includes(l.target.id)
          )
          .attr('stroke', color);
      }

    } // END drawVisualization

    drawVisualization(lobbyOrgData);
  }, [lobbyOrgData, setSelected, resolvedTheme]);

  return (
    <>
      {selected && <Dialog open={selected !== null} onOpenChange={open => {
        if (!open) {
          setSelected(null);
        }
      }}>
        <DialogContent className="mb-6">
          <DialogHeader>
            <DialogTitle>{lobbyOrgData.nodes.find(x => x.id === selected.source)?.name} - {lobbyOrgData.nodes.find(x => x.id === selected.target)?.name}</DialogTitle>
            <DialogDescription>
              Rrelative strength of {selected.influence_strength.toFixed(3)}
            </DialogDescription>
          </DialogHeader>
          <div style={{ paddingLeft: '20px', maxHeight: '60vh', overflowY: 'scroll' }}>
            <ul className="list-disc">
              {orgs
                .filter(x => x.branchIds.indexOf(selected.source) > -1 && x.partyIds.indexOf(selected.target) > -1)
                .map(x => <li key={x.id}>{x.name}</li>)}
            </ul>
          </div>
        </DialogContent>
      </Dialog>}
      <div id='container' />
    </>
  )
}

// export default LobbyOrg;
