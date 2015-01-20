title: On the Epistemology of Statistics
type: post
date: 2014-09-19
summary: articles that changed my thinking on what/how we can learn from data
tags: [Statistics]

All of these articles have substantially changed how I think about the topic to which the authors speak. Together also make nearly all of the important ideas in [one](http://github.com/zmjones/datamining/) of my working papers. The details are important though! The articles are in no particular order. If you have an article like this [email](mailto:zmj@zmjones.com) it to me or link to it on [Twitter](https://twitter.com/JonesZM/status/513064153775620097).

"[To Explain or to Predict](http://arxiv.org/pdf/1101.0891.pdf)," [Galit Shmueli](http://galitshmueli.com/), *Statistical Science* (2010)

![](/static/images/process.png)

<p class = "project-summary">
There are (arguably) three main types of modeling you can do with statistics (machine learning is statistics imo), explanation (causal), prediction, and description/exploration. There is a difference between explanation and prediction, which is due to the disparity between the mapping of concepts to measurements, and the fact that the function that maps the explanatory variables to the response "best" often differs depending on the goal. Causal explanation is dominant in the social sciences, though it is mostly done inappropriately (e.g., associations discovered/estimated by model, causal story comes from theory). Prediction is common in some fields, and description/exploration is mostly done by statisticians (c.f. Gelman's work). These goals imply different things about how predictors are selected for inclusion, what sorts of models should be used, how missingness should be dealt with, etc. Both predictive and descriptive/exploratory modeling should be more common in political science. There was an interesting discussion of this article on <a href="https://stats.stackexchange.com/questions/1194/practical-thoughts-on-explanatory-vs-predictive-modeling">CrossValidated</a> as well.
</p>

"[Statistical Modeling: The Two Cultures](http://projecteuclid.org/download/pdf_1/euclid.ss/1009213726)," [Leo Breiman](http://www.stat.berkeley.edu/~breiman/), *Statistical Science* (2001)

![](/static/images/algorithmic.png)

<p class = "project-summary">
Data modeling is where you assume a stochastic model and then use data to infer values of the parameters of said model. Algorithmic modeling instead attempts to predict the data without an assumed stochastic model. The focus of the two "camps" (not really camps anymore imo) is inference versus prediction. The latter's importance is *hugely* under-appreciated in political science. He also discusses ways to use "black-box" models (algorithmc models that result in complex, not-directly-interpretable fits) to understand the explore the data as well (which was a major inspiration for this <a href="http://github.com/zmjones/datamining">project</a>). <a href="http://www.cs.berkeley.edu/~jordan/">Michael Jordan</a>'s AMA <a href="https://www.reddit.com/r/MachineLearning/comments/2fxi6v/ama_michael_i_jordan/ckelmtt">link to the relevant answer</a> on reddit brings up the (lack of) difference between statistics and machine learning as well.
</p>

"[Statistical Inference: The Big Picture](http://www.stat.cmu.edu/~kass/papers/bigpic.pdf)," [Robert Kass](http://www.stat.cmu.edu/~kass/), *Statistical Science* (2011)

![](/static/images/big_picture.png)

<p class="project-summary">
Despite the historical frequentist/Bayesian divide, most of statistics is now more pragamatic, and which methods are applied depend more on data analytic concerns than adherence to one camp or the other. Whether frequentist or Bayesian, a stochastic model applied to real data is connecting things from the theoretical world (random variables) to things in the real world (observed data). Inference in both cases is contingent on the closeness of the mapping between the data and the stochastic model. The notion of sampling from an infinite population where that is clearly not possible (which is most of the time) is not such a big deal, since random variables exist in the theoretical world. Although not discussed here a great deal, this is related to the often ignored fact that utilizing the frequentist thought experiment <em>does not</em> mean that you are obliged to talk about tail probabilities (Neyman-Pearson null-hypothesis significance testing). Obviously, then, thinking in this way (imagining repeated sampling from the dgp) in no way should associate you with the misuse of NHST (e.g. dumb null hypotheses, overinterpretation of tail probabilities, multiple testing problems), despite what <a href="http://jpr.sagepub.com/content/51/2/287.abstract">some people</a> say about this. If everyone were Bayesian in political science we'd still mostly have the same problems. Kass has a bit more about his views on statistical philosophy <a href="http://www.stat.cmu.edu/~kass/philo.html">here</a>.
</p>

"[Causal Inference in Statistics: An Overview](http://projecteuclid.org/download/pdfview_1/euclid.ssu/1255440554)," <a href="http://bayes.cs.ucla.edu/jp_home.html">Judea Pearl</a>, *Statistical Surveys* (2009)

![](/static/images/dag.png)

<p class="project-summary">
"[B]ehind any causal conclusion there must be some causal assumption, untested in observational studies." Statistics alone can't get you to causality, hence Pearl's development of the structural causal model (SCM). Confounding, for example, is not a variable that is correlated with the variable of interest and the outcome, it is a <em>cause</em> of both. It has historically been the case that causal inference was treated casually (heh) in political science. I think this is changing (probably thanks to the credibility revolution in economics), such that now people talk about the "<a href="http://www.econjobrumors.com/topic/we-are-the-endogeneity-taliban">endogeneity taliban</a>."
"Morgan and Winship's book "<a href="http://www.amazon.com/Counterfactuals-Causal-Inference-Principles-Analytical/dp/0521671930">Counterfactuals and Causal Inference</a> is an excellent introduction to causal inference generally, and Pearl's approach to it specifically. I think that it is a pretty easy to understand that, given the necessary conditions for causal identification and the apparent complexity of social systems, causal inference in many cases (not all) is not really a possibility. I'm looking at you comparative politics and international relations.
</p>
