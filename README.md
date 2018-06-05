# Data Analysis: Do figure skating judges score their home countries more favorably?

A closer look at the data, code, and methodologies supporting the BuzzFeed News article, "[The Edge](http://www.buzzfeed.com/johntemplon/the-edge)," published February 8, 2018. Please read that article, which contains important context, before proceeding.

## Glossary

This repository uses the following definitions:

- __ISU__: The abbreviation for the [International Skating Union](http://www.isu.org/), the group that runs figure skating's highest-level international competitions.
- __Protocol PDF__: The final score sheet released at the end of each competition. ([Example](http://www.isuresults.com/results/season1718/gpf1718/gpf2017_protocol.pdf?).)
- __Program__: One segment of a figure skating competition. International figure skating competitions are divided into Short and Free programs.
- __Elements__: The individual technical pieces of a program, such as jumps and spins. Each judge provides a score for each individual element known as a "Grade of Execution."
- __Components__: For each performance, each judge provides scores for five "components": Skating Skills, Transitions, Performance, Composition, and Interpretation. 
- __Aspect__: This is the term used by this analysis to refer to an individual component or element.
- __Scale of Values__: The ISU's conversion table between the "Grade of Execution" and the points awarded for each type of element. See below for more details.
- __Home country__: The country the judge or skater represents in competition. _Note:_ This is not necessarily a judge or skater's country of birth.
- __Home-country preference__: The difference in the number of points a judge awards to skaters from their home country versus those from other countries. Higher home-country scores do not in and of themselves show a judge is deliberately trying to raise a compatriot’s standing; the scores could reflect a preference for a regional style of skating, for example, or an inclination toward skaters the judge has taken special note of, or even just patriotism.

## Data

### Raw Scoring Data

The raw data for this project was collected from the protocol PDFs for every major international competition from October 2016 through December 2017. You can find a list of those 17 competitions below.

The raw data is contained in the following three "[tidy](http://vita.had.co.nz/papers/tidy-data.html)" CSV files:

- `performances.csv`: Metadata about each performance.

- `judged-aspects.csv`: Metadata about the elements and components of each performance.

- `judge-scores.csv`: Each judge's score for each element and component of each performance.

You can find a list of all the fields and their definitions, as well as the scripts used to extract the data from the PDFs, in [`github.com/BuzzFeedNews/figure-skating-scores`](https://github.com/BuzzFeedNews/figure-skating-scores).

### Competitions Included

2016–17 season:

- ISU GP 2016 Progressive Skate America (Oct. 20-23, 2016)
- ISU GP 2016 Skate Canada International (Oct. 27-30, 2016)
- ISU GP Rostelecom Cup 2016 (Nov. 4-6, 2016)
- ISU GP Trophee de France 2016 (Nov. 11-13, 2016)
- ISU GP Audi Cup of China 2016 (Nov. 17-20, 2016)
- ISU GP NHK Trophy 2016 (Nov. 25-27, 2016)
- ISU Grand Prix of Figure Skating Final 2016 (Dec. 8-11, 2016)
- ISU European Figure Skating Championships 2017 (Jan. 23-29, 2017)
- ISU Four Continents Championships 2017 (Feb. 14-19, 2017)
- ISU World Figure Skating Championships 2017 (Mar. 27 - Apr. 2, 2017)

2017–18 season:

- ISU GP Rostelecom Cup 2017 (Oct. 20-22, 2017)
- ISU GP 2017 Skate Canada International (Oct. 27-29, 2017)
- ISU GP Audi Cup of China 2017 (Nov. 3-5, 2017)
- ISU GP NHK Trophy 2017 (Nov. 10-12, 2017)
- ISU GP Internationaux de France de Patinage 2017 (Nov. 17-19, 2017)
- ISU GP 2017 Bridgestone Skate America (Nov. 24-26, 2017)
- Grand Prix Final 2017 Senior and Junior (Dec. 7-10, 2017)

### Processed Data

#### Translations of "Grades of Execution"

The protocol PDFs include a rating for each element, between `-3` and `+3`, given by each judge. This **Grade of Execution** is translated by the **Scale of Values** to the actual number of points awarded for that element. (More difficult elements receive more points for the same Grade of Execution.) The [`translate-goe` notebook](./notebooks/translate-goe.ipynb) includes the code BuzzFeed News used to translate each Grade of Execution for each element. That notebook produces the [`judge-goe.csv`](data/processed/judge-goe.csv) file, which contains the translated values for each score.

Each season of figure skating and ice dancing uses a slightly different Scale of Values, which are documented in a series of PDFs published by the ISU. For easier analysis, BuzzFeed News converted these PDFs to CSV files:

- 2016-17 Figure Skating: [PDF](http://www.isu.org/docman-documents-links/isu-files/documents-communications/isu-communications/459-2000-sptc-sov-and-goe-2016-2017-revised-july-14/file), [CSV](./data/processed/figure-skating-goe-adj-2016-17.csv)
- 2017-18 Figure Skating: [PDF](http://www.isu.org/docman-documents-links/isu-files/documents-communications/isu-communications/14352-isu-communication-2089/file), [CSV](./data/processed/figure-skating-goe-adj-2017-18.csv)
- 2016-17 Ice Dancing: [PDF](http://isu.org/docman-documents-links/isu-files/documents-communications/isu-communications/476-isu-communication-2015/file), [CSV](./data/processed/ice-dancing-goe-adj-2016-17.csv)
- 2017-18 Ice Dancing: [PDF](http://www.isu.org/docman-documents-links/isu-files/documents-communications/isu-communications/589-isu-communication-2094/file), [CSV](./data/processed/ice-dancing-goe-adj-2017-18.csv)

#### Judge Names and Home Countries

The ISU posts the names of each judge (for each program) on a series of HTML pages on its website. BuzzFeed News collected all of the judge names from those pages and standardized that data. You can find the results in [`judges.csv`](data/processed/judges.csv).

On the ISU's website, judges are often labeled simply as members of the ISU instead of their home country. BuzzFeed News used the ISU's lists of officials for [the 2017-18 season](https://www.isu.org/communications/12127-isu-communication-2111/file) and [the 2016-17 season](https://www.isu.org/docman-documents-links/isu-files/documents-communications/isu-communications/490-2027-list-officials-fs-id-sys-2016-2017-updated-oct-6-rev/file) to identify each judge's home country. You can find the results in [`judge-country.csv`](data/processed/judge-country.csv).

## Analyses

The analysis of home-country preference can be found in [this Jupyter Notebook](./notebooks/home-country-preference-analysis.ipynb). The notebook takes a reader through the process of:

- Loading the data
- Calculating the total points awarded by each judge
- Calculating the difference between a judge's total points and the average total points awarded by the other judges for the same performance
- Calculating that judges have a roughly 3.4-point home-country preference, overall, and that the difference is statistically significant
- Calculating overall home-country preferences by country
- Finding that 27 individual judges exhibit a highly statistically significant home-country preference

In developing the methodology, BuzzFeed News consulted with three statisticians. Two — [Jay Emerson (Yale)](http://www.stat.yale.edu/~jay/) and [Eric Zizewitz (Dartmouth)](https://www.dartmouth.edu/~ericz/) — have worked closely with figure skating data in the past. The third, [Abraham Wyner (Penn)](https://statistics.wharton.upenn.edu/profile/ajw/), has extensive experience applying similar analyses to data from other sports.

In addition to the home-country preference analysis, BuzzFeed News also recreated the ISU's "Deviation Points" system for identifying outlier judgments, the rules for which can be found in [ISU Communication 2098](http://www.isu.org/communications/593-isu-communication-2098/file). That code can be found in [the `isu-deviation-points` notebook](./notebooks/isu-deviation-points.ipynb).

A fourth notebook — [`progressive-skate-america-2016-example`](./notebooks/progressive-skate-america-2016-example.ipynb) — provides details about Maira Abasova's scores at the ISU GP Progressive Skate America 2016.

_Update, February 18, 2018:_ This repository now also includes a fifth notebook — [`ice-dance-team-scoring`](./notebooks/ice-dance-team-scoring.ipynb) — supporting a second BuzzFeed News article, "[In Bitter Ice Dancing Rivalry Judges Favor Their Own](https://www.buzzfeed.com/johntemplon/in-bitter-ice-dancing-rivalry-judges-favor-their-own)." That notebook uses the same data, and much of the same code, as the analyses above.

## Technical Notes

All of the analyses above are coded in Python 3, using the libraries listed in [`requirements.txt`](./requirements.txt).

The individual-judge analysis in the [`home-country-preference-analysis` notebook](./notebooks/home-country-preference-analysis.ipynb) uses bootstrapping to test for statistical significance. Depending on your computer's processing power, this step could take at least a few hours to run. If you would like to run it more quickly, you can change the number of simulations in `find_judge_prob`, but doing so will decrease the accuracy of those calculations.

## Licensing

All code in this repository is available under the [MIT License](https://opensource.org/licenses/MIT). All data files are available under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/) (CC BY 4.0) license.

## Questions / Feedback

Contact John Templon at [john.templon@buzzfeed.com](mailto:john.templon@buzzfeed.com).

Looking for more from BuzzFeed News? [Click here for a list of our open-sourced projects, data, and code.](https://github.com/BuzzFeedNews/everything)