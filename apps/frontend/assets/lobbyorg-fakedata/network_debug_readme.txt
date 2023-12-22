Concerning 'influence_strength' attribute of the '*_idtrees' elements.

e.g. have a look at network_debug.json @ party2parl_idtrees.

children_id and influence_strength have the same length, 
elements from both lists at the same index are coupled in terms of edge and influence_strength.
e.g. link from node 17 to node 12 has influence_strength 0, similarly
     link from node 18 to node 12 has influence_strength 1,
     link from node 19 to node 12 has influence_strength 2.

Here is the mapping from value (as found in lobbywatch) to its corresponding numeric representation
 0 - low
 1 - mid
 2 - high
-1 - anything else


Concerning 'influence_strength' attribute of the 'branch2party_edges' element.

Since the edges from organisation to parliamentarians basically go through (the bipartite) bottleneck (with the aim to improve the visual clarity of all the connections), One has to decided which influence_strength the edges from the middle part get.

Most naturally occurs to me the median of the data, which is described in the pseudo code below.
First consider the following setting:

we have branch B with organisations a, b, c, d
and a party X with parliamentarians x, y, z.

then the influence_strength from B to X can be computed as follows.

```
// all edges from any organisation to any parliamentarian (from lobbywatch)
edges = [
  ...
  { org_id, parl_id, influence_strength }
  ...
]

influence_strength(B, X) = {

  // ids for each of the organisation of branch b
  orgs = [a, b, c, d]

  // ids for each of the parliamentarians of party X
  parls = [x, y, z]

  // filter relevant orgs, i.e. only retain orgs that have any connection to either x, y or z
  filt_orgs = orgs.filter((o) => exists_connection_from_to(o, parls, edges))

  // list of edges for each of the organisation in filt_orgs
  filt_edges = edges.filter((e) => filt_orgs.includes(e.org_id))

  // get the corresponding influence_strengths for each of the filt_orgs
  influences = filt_edges.map((e) => e.influence_strength)

  // compute the most frequently occuring element
  m = median(influences)

  return m
}


// helper
exists_connection_from_to(org_id, parl_ids, edges) {

  current = false
  result = false

  // all edges that have their origin in organisation with id org_id
  edges_from_o = edges.filter((e) => e.org_id == org_id)

  for parl_id in parl_ids:
    // list of edges from org with org_id to parliamentarian with parl_id
    edges_from_o_to_p = edges_from_o.filter((e) => e.parl_id == parl_id)

    // check if non-empty
    current = edges_from_o_to_p != []

    // update result, i.e. have we already seen any existing edges?
    result = result || current

    if result:
      return true

    // else continue searching in the loop

  // end of loop mean we didnt encounter any edges
  return false

}
```

