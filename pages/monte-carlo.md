title: Monte Carlo for Teaching Applied Statistics
date: 2014-12-10
type: post
tags: [Statistics, Education]
summary: real data is overused in applied statistics classes in political science

Nearly all of the political methodology (applied statistics) courses I have taken rely almost exclusively on real data taken from political science or a cognate discipline. I think we should make much more use of simulated data. [Monte Carlo simulation](https://en.wikipedia.org/wiki/Monte_Carlo_method) has a number of advantages and using real data has a number of disadvantages.

Monte Carlo simulation is the process of using a deterministic machine (computer) to generate psuedo-random numbers which can be used for some sort of numerical analysis. Often this means simulating from probability models and then studying the behavior of different sorts of estimators for the parameters of said model. Monte Carlo simulation is  an application probability theory.[^probability]

[^probability]: [This](http://www.stochas.org/) seems like a nice way to teach basic probability theory.

### Real Data

Real data is messy, especially in social science. Students cannot (generally) do a careful analysis of a real data set in a reasonable amount of time (for a homework). Additionally it is rare that students know enough about the data (even in their own field) to do a really careful job. The result is either an exorbitant amount of time spent on homework, or, more commonly, a more or less dumb approach to homework with real data wherein the student pays little attention to what is going on in the data and applies whatever method was learned in class. When data is used just for pedagogical purposes[^purpose] it functions like simulated data would (there is no substantive content) except students (and the professor) don't know the correct answer, little is learned about the properties of the method in question, students are implicitly taught that it is OK to analyze data in this casual manner, and it can be quite tedious. Real data typically comes with many warts (missingness, coding errors, inconsistent naming conventions, etc.). This is a simlar point to the one I made about [examples in methods papers](/examples/). The example set by methods professors is emulated by others in the field. I think that assigning what amounts to bad data analysis in homework is going to have ill effects on students generally (though probably not a huge effect).

[^purpose]: There is often no real substantive question, which in any case is not possible if the data is not something the student is already very familiar with.

Arguably, an upside of using real data is that students learn better the unglamorous parts of data analysis: data munging (cleaning, manipulating, etc.). I don't think this is a good justification for at least two reasons. One is that it is too much to ask students to learn all of the technical statistical material in a class as well as best-practices for data manipulation. The latter is almost never discussed in class, and so students are [left to their own devices as far as computing is concerned](/computing/). The second reason is that most methodologists are awful programmers (me too, though it is all relative). Doing reliable data munging is non-trivial and it would be best learned from [experts](http://vita.had.co.nz/papers/tidy-data.pdf). This is important for replicability as [Reinhart and Rogoff](https://en.wikipedia.org/wiki/Growth_in_a_Time_of_Debt) must now know! Adding the extra work of data munging takes away from learning the material the class is centered on and delivers little in return.

### Simulated Data

Creating probability models, simulating data from them, and then studying the behavior of various methods using this data is enormously important in statistics. Theory often lags behind practice and simulation is a vital way to study the properties of estimators. This is perhaps especially true in statistical learning and Markov Chain Monte Carlo.[^theory] Monte Carlo simulation makes understanding methods easier. Hypothesis testing is a particularly good example of this. I think many students find it unintuitive and end up leaving with a foggy understanding of what tests do. With simulation I don't think it is so hard to explain since you can easily show confidence interval coverage, error rates, power, etc. In addition to this simulation allows students to answer questions that don't have answers from theory or the published literature. This is an enormously powerful thing! 

[^theory]: The former case is true in my experience and the latter is from [Murali Haran](http://sites.stat.psu.edu/~mharan/).

There are a few other perhaps less important advantages of using simulated data. There is a correct answer, so it is clear when something is up with the method under study. I think simulating data also provides a very clear understanding of what the probability model assumes, which sometimes is obscure (depending on your background of course) when the probability model is only defined mathematically.
