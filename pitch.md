# Title: Vote Watch

# What is the need or problem? For whom?

Swiss politics is rife with lobbying. Even for people invested in Swiss politics, it can a formidable challenge to understand the intricate web of special interest influences on specific votes. For individuals with low to moderate levels of awareness about Swiss politics, the need for comprehensive research to gauge these influences can be daunting.

# What resources are (not) available (input)?

## Swiss Parliament

The Swiss Parliament has a pretty extensive API through which a large amount of information is available. Most importantly for us, one can retrieve the status of every bill, a bill's sponsors, and the individual votes from each parliamentarian for each vote.
There exists a [Python wrapper](https://github.com/metaodi/swissparlpy) through which this data is more easily accessible. The referencing table for which can be found [here](https://github.com/metaodi/swissparlpy/blob/develop/docs/swissparAPY_diagram.pdf).

The following is a short overview of the parts of the database (i.e. which tables) we will reference to gain the information we need for the respective tasks.

- For the parliamentarians' information, we will need
    - the Person, Party and MemberParty tables.
- For single votes, we will need to reference 
    - the Session, Business, Vote, Voting and LegislativePeriod Tables.
- For committee bias analysis we will need
    - the Committee, MemberComittee LegislativePeriod Tables.

This list is by no means exhaustive and we very well might need to use larger parts of the database.

## Lobby Watch
The non-profit organisation LobbyWatch maintains a database of special interest entanglements of Swiss parliamentarians.
We will utilize the following part of their data, which is readily available as a CSV.

- For every parliamentarian
    - All organisations they are a part of as well as their role in every  organisation
    - The degree of influence the organisations have on the parliamentarian
    - The two designated Keyholders of the parliamentarian and their affiliation.
- For all organisations:
    - The interests they represent
    - Their connections to other organisations.

## Other

We have not yet found a source of data for a single parliamentarian seat in parliament / the committees, Thus if we choose to make visualisations involving the parliament seating we'd either need some degree of hardcoding, find a source for this data or scrape it from a site like [this](https://www.parlament.ch/en/organe/national-council/groups-chamber-nc).

# What is your goal for the project?

We want to provide users with an innovative platform that allows for anyone to learn about the influences of special interest groups on Swiss politics.

We want to offer a way through which our users can discover the biases of Swiss parliamentary commissions. As well as a way to grasp the special interest involvement in bills they are personally invested in.

Our platform should present the findings in these areas through highly informative visualisations.

# What would be different if the problem was solved?

If this problem is solved effectively, we would offer our users an easy way to gain deep and valuable insights into political influence. Offering them a fresh perspective on the influence of parliament. Furthermore, we would enable them to gather information themselves on this matter, through legislation that matters to them.

Additionally, this tool could serve as an invaluable resource for journalists to identify any special interest engagement in certain bills that may have eluded their awareness. This could be especially beneficial for publications with limited resources, providing a focused lens on “Bundesbern” without the need for dedicated experts.

# What are the approaches to solving the problem? Which ones have you already tried?  

The approach we see for solving this encompasses the creation of an interactive dashboard, on which we will present multiple engaging visualisations. Offering insights into special interest involvements in different parts of the Swiss parliament.
This entails the creation of a backend which will both query our data sources and do data analysis. And a frontend, which will visualize the gained insights in interesting ways.

We will explain how these work together using, as an example, one visualisation we aim to implement: a bill-by-bill analysis of the special interest influence in the lower house of parliament. In which the following groups of parliamentarians are analysed: Bill sponsors, yes-voters, and no-voters.
The backend would pre-compute the average amount of connections parliamentarians have to special interest groups of each sector.
When the user selects a bill on our site, he wants to analyze, the backend fetches what parliamentarians are in each of the aforementioned groups for this bill. It then computes the average amount of connections in all of those groups. Through an anomaly detection algorithm, it then detects whether any special interest group or sector is overrepresented in any of the groups.
The findings are then handed to the frontend, which then creates an interactive visualisation with them.
We have not yet tried this approach but are fairly confident that it should work.
What we have tried is to look up manually the special interests behind a parliamentary vote. As described in the problem statement, this is a pretty laborious and daunting task.

# What are the limitations? What do you have to pay attention to?  

One very important area we will have to pay attention to is the visualizations. Producing engaging visualisations of the analysis we intend on doing is no simple task and there are many pitfalls to be avoided. One crucial point is to keep the visualisations clear and uncluttered, e.g. when visualizing relationships say as graphs with edges and nodes one mustn't have too many overlapping edges as this can cause more confusion than insight to the user.

Some analysis we might want to do may turn out not to be feasible with the data we can easily access. We will address this by pivoting to a different analysis if that arises, as there are quite a few areas we could analyse.

As we are at the start of a new legislature, new and old votes will have to utilize different datasets. Further, Lobby Watch’s dataset currently only covers the past legislature. Thus we will restrict our projects to votes in the past legislature, at least at first.

Further, we foresee some difficulties with handling the parliamentary presidents. As they change every year and do not partake in some activities, whilst other parliamentarians do. These cases may need special handling.
Undoubtedly, this might also be necessary for other special cases and quirks of parliament, yet unforeseen.

# What is the scope of the project?

The project’s scope involves the creation of an interactive website that displays multiple engaging and interactive visualisations, including the visualisation as described in the approach section.

It encompasses the creation of both the front- and backend as laid out in the approach section.

The project’s scope only extends to the past legislative, as it is the only data we have complete access to.

Once the functionality of this platform is implemented and if Lobby Watch releases the dataset for the new legislature in time, we might update the project accordingly.

# References

- [swissparlpy API wrapper](https://github.com/metaodi/swissparlpy)
- [API referencing table](https://github.com/metaodi/swissparlpy/blob/develop/docs/swissparAPY_diagram.pdf)
- [seating arrangement](https://www.parlament.ch/en/organe/national-council/groups-chamber-nc)
