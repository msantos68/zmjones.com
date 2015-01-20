title: Computing
type: page

Computing is enormously important in modern social science, but little attention is paid to teaching researchers how to do it efficiently and reliably; even in highly quantitative fields. So we are often left to our own devices. Below are some of my thoughts about the uses of various tools and some ideas about how to become proficient in their use.

If you are on OSX check out my setup [tutorial](/mac-setup/), which covers R, Python, and Emacs, among other things.

 - [R](#R)
 - [Python](#Python)
 - [Emacs](#Emacs)
 - [Git](#Git)

<hr/>

### <a name="R">R</a>

R is great for cleaning, manipulating, exploring, modeling, and visualizing data, which is what social scientists spend most of their time doing. There are a huge number of libraries available, many of which are very high quality. It is often quite slow (though there are things like [Rcpp](http://www.rcpp.org/)) and the syntax is [a bit inconsistent](http://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf). It is not a very good general purpose language (by statisticians for statisticians). You can be fantastically productive in this language though.

For an introduction to R with no programming background

 - [Google's R Class](http://www.youtube.com/playlist?list=PLOU2XLYxmsIK9qQfztXeybpHvru-TrqAP)
 - [Impatient R](http://www.burns-stat.com/documents/tutorials/impatient-r/) by [Patrick Burns](http://www.burns-stat.com/)
 - the [Official Tutorial](http://cran.r-project.org/doc/manuals/R-intro.pdf)
 - [learnR](http://renkun.me/learnR/) by [Ken Run](http://renkun.me)

There are a number of books that are both an introduction to statistics and an introduction to R. I haven't read any of these books, but I've heard good things about [Dalgaard's book](http://www.amazon.com/Introductory-Statistics-R-Computing/dp/0387790535). [Cosma Shalizi](http://vserver1.cscs.lsa.umich.edu/~crshalizi/)'s [statistical computing](http://vserver1.cscs.lsa.umich.edu/~crshalizi/weblog/cat_statcomp.html) class is pretty sweet too.

If you are either not new to R, or not new to programming

 - [Writing R Extensions](http://cran.us.r-project.org/doc/manuals/r-release/R-exts.pdf)
 - [R Language Definition](http://cran.us.r-project.org/doc/manuals/r-release/R-lang.pdf)
 - the [R Inferno](http://www.burns-stat.com/pages/Tutor/R_inferno.pdf) by [Patrick Burns](http://www.burns-stat.com/)
 - [Advanced R Programming](http://adv-r.had.co.nz/) by [Hadley Wickham](http://had.co.nz/)
 - the [Art of R Programming](http://amzn.to/1bb8V9t) by [Norman Matloff](http://matloff.wordpress.com/)

Getting help should entail the use of [StackOverflowR](http://stackoverflow.com/tags/r) (read [this](http://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example) before asking a question) and/or the [R Mailing Lists](http://www.r-project.org/mail.html). Also worth checking out is the R subreddit: [/r/rstats](http://reddit/r/rstats).

There are a ton of statistics books that use R. See, e.g., the [Chapman & Hall's R series](http://www.crcpress.com/browse/series/crctherser), Springer's [Use R!](http://www.springer.com/series/6991?detailsPage=titles) series, and [O'Reilly's books on R](http://shop.oreilly.com/category/browse-subjects/programming/r.do?intcmp=il-prog-books-videos-cat-intsrch_r_search_ct) (there are a number of others as well).

One of the nice things about R is that there are so many useful things already implemented. Be sure to check out the [CRAN Task Views](http://cran.r-project.org/web/views/), which are curated lists of packages organized by task (e.g. [econometrics](http://cran.r-project.org/web/views/Econometrics.html), [spatial](http://cran.r-project.org/web/views/Spatial.html), [bayes](http://cran.r-project.org/web/views/Bayesian.html), [nlp](http://cran.r-project.org/web/views/NaturalLanguageProcessing.html)). [CRANberries](http://dirk.eddelbuettel.com/cranberries/about/) and [R-bloggers](http://www.r-bloggers.com/) are good ways to keep up with development news.

There are a couple of packages that are "must-haves" for data analysis:

 - [ggplot2](http://docs.ggplot2.org/current/), a plotting system based on the [grammar of graphics](http://amzn.to/1cpBITc) (check out [the book](http://amzn.to/1cpBn2O))
 - [dplyr](https://github.com/hadley/dplyr), implements [split-apply-combine](http://www.jstatsoft.org/v40/i01/paper)

If you don't have a pre-existing preference for a particular text editor I'd highly recommend [R-Studio](http://www.rstudio.com/).

<hr/>

### <a name="Python">Python</a>

Python is a general purpose language (as opposed to a domain specific language) that is great for getting data in its various forms (scraping data from the web, interacting with relational data bases, parsing text files, etc.), manipulating said data, doing analysis, and visualizing data. The Python data analysis stack consists of (my opinion, not canonical):

 - [Numpy](http://www.numpy.org/) (numerical arrays)
 - [SciPy](http://scipy.org/) (linear algebra, optimization, etc.)
 - [pandas](http://pandas.pydata.org/) (DataFrames)
 - [IPython](http://ipython.org/) (Python REPL)
 - [Matplotlib](http://matplotlib.org/) (plotting)
 - [Statsmodels](http://statsmodels.sourceforge.net/) (statistical models)
 - [scikit-learn](http://scikit-learn.org/stable/) (machine learning)

There are vastly more resources for learning Python than there are for R. For a general introduction to the language [Learn Python the Hard Way](http://learnpythonthehardway.org/) is a good place to start. Google also has a [python course](https://developers.google.com/edu/python/). The [official tutorial](http://docs.python.org/2/tutorial/index.html) is also pretty good. IPython notebooks can be viewed (rendered) on [nbviewer](http://nbviewer.ipython.org/). Below are a number of other excellent resources.

 - [Python for Data Analysis](http://shop.oreilly.com/product/0636920023784.do)
 - [Python for Econometrics](http://www.kevinsheppard.com/Python_Course)
 - [Scientific Python lecture notes](http://scipy-lectures.github.io/)
 - [Python Programming for the Humanities](http://fbkarsdorp.github.io/python-course/)
 - [Hitchiker's Guide to Python](http://docs.python-guide.org/en/latest/)
 - [/r/python](http://reddit.com/r/python) and [/r/learnpython](http://reddit.com/r/learnpython) (Reddit + Python)

Help should of course start with you using your google-fu, [RTFM](https://en.wikipedia.org/wiki/RTFM), followed by [StackOverflow](http://stackoverflow.com/questions/tagged/python) (which has lots of great answers related to [pandas](http://stackoverflow.com/questions/tagged/pandas)).

<hr/>

### <a name="Emacs">Emacs</a>

I do not recommend Emacs if you are new to programming. If you are planning on spending a lot of time coding though (like most quantitative social scientists do) it is worth investing (your time) in an editor, though, perhaps it is wise to keep [this](https://xkcd.com/1319/) in mind as well.

[Neal Stephenson](http://www.nealstephenson.com/) has a cool essay on Emacs: "[In The Beginning Was the Command Line](/static/data/command.txt)." Like most of his stuff, it is worth reading, despite its length.

On a Mac the best way to install it is using the [OSX specific binary](http://emacsformacosx.com/) or [Homebrew](http://brew.sh/) (I have [a tutorial](/mac-setup/) covering the latter option). Once you've installed things start with the built in tutorial (`C-h t`, read  `control h, t`).

The [Emacs Wiki](http://www.emacswiki.org/emacs/) is huge (and messy, though, not as bad as it used to be). Other things to check out:

 - [Mastering Emacs](http://www.masteringemacs.org/)
 - Bozhidar Batsov's' [Ultimate Collection of Emacs Resources](http://batsov.com/articles/2011/11/30/the-ultimate-collection-of-emacs-resources/)
 - [Planet Emacsen](http://planet.emacsen.org/) (an Emacs blog aggregator)
 - StackExchage questions ([1](http://unix.stackexchange.com/questions/6170/what-are-some-excellent-emacs-utter-beginner-resources), [2](http://stackoverflow.com/questions/311221/what-to-teach-a-beginner-in-emacs), [3](http://stackoverflow.com/questions/269812/how-to-quickly-get-started-at-using-and-learning-emacs))
 - [/r/emacs](http://reddit.com/r/emacs) (Reddit + Emacs, also, the [side-bar thread](http://www.reddit.com/r/emacs/comments/1eq5vr/while_were_at_it_lets_improve_our_sidebar_suggest/))
 - [Emacs Rocks!](http://emacsrocks.com/) (self-explanatory)
 - [What the emacs.d?](http://whattheemacsd.com/) (blog about configuring Emacs)

Must have packages for social scientists include:

 - [Emacs Speaks Statistics](http://ess.r-project.org/) (REPL for R, S, SAS, STATA, etc.)
 - [AucTeX](https://www.gnu.org/software/auctex/) (a great TeX mode)
 - [Org-Mode](http://orgmode.org/) (organize your life with plain-text)
 - [Elpy](https://github.com/jorgenschaefer/elpy) (REPL with IPython)
 - [Magit](http://magit.github.io/) (interact with Git)

<hr/>
 
### <a name="Git">Git</a>

[Git](http://git-scm.com/) is a distributed revision control application. I've [written some](/git/) about why you should be using Git and [GitHub](http://github.com) if you are a quantitative social scientist. GitHub is a hosting service for Git repositories that makes collaboration and a variety of other tasks a lot easier. GitHub gives [free private repositories](https://education.github.com/) to college students/professors for 2 years.

The Git [documentation](http://git-scm.com/documentation) is awesome, and so is [Pro Git](http://git-scm.com/book). The Git website also has a [blog](http://git-scm.com/blog) and a nice list of external [resources](http://git-scm.com/doc/ext). [Try-Git](http://try.github.io/) is probably the best way to start if you are new to all of this.

GitHub's [help pages](https://help.github.com/) are also good for setting up Git, as well as (shocking I know) getting started with GitHub. They also have a set of [guides](http://guides.github.com/) for a variety of common tasks.

While there aren't many people writing exclusively about Git (other than people working at GitHub and such) there is lots of good community content out there. [/r/git](http://www.reddit.com/r/git) gets a fair bit of it.
