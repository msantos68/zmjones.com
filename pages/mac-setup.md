title: Setting up OSX for Data Analysis
type: post
date: 2013-06-05
summary: set up Emacs, R, Python, and Julia with Homebrew
tags: [Computing]

Setting up software for data analysis (i.e. statistical computing) on OSX can be a major pain. I have a pretty clean, maintainable setup now, which perhaps merits sharing so that others can avoid spending as much time as I have setting things up. I will try to keep this updated so that it doesn't become one of the other 1000 setup posts that worked when it was written but is unworkable by the time some frustrated person finds it. Without further ado...

To give a general overview, I run all my command line software through homebrew rather than downloading binaries. I think it makes it much easier to keep software up to date. The specific tools I'll cover setting up are:

 - [Homebrew](#Homebrew)
 - [Emacs](#Emacs) (with [AucTeX](https://www.gnu.org/software/auctex/) and [Magit](http://magit.github.io/documentation.html))
 - [R](#R) (with [ESS](http://ess.r-project.org/))
 - [Python](#Python)
 - [Julia](#Julia)
 - [Other Tools](#Other)

I've tried [R-Studio](http://www.rstudio.com/) (and it is generally quite nice). I think Emacs/ESS is better (for me at least) because you can navigate text faster, send commands to R faster, and, if you are so inclined, modify it to your heart's content. It also works works with just about every language there is, which is great if you use a variety of different tools.

### <a name="Homebrew">Homebrew</a>

The first thing to do is to install Apple's command line tools. You can do this one of two ways: install Xcode from the App Store, go to *preferences*, *downloads*, and then install the command line tools, or you can install them directly with the [package](https://developer.apple.com/downloads/index.action) provided by Apple (you'll need to set up an Apple developer account to do the latter). In OSX 10.9, you can install them from the command line with `xcode-select --install`. Next you need to install [XQuartz](http://xquartz.macosforge.org/landing/) which is the replacement for `X11.app` and (as you might be able to guess from the name) is a port (correct term?) of `X.org` to OSX.

After the command line tools and XQuartz are installed we can get going with homebrew. To install [homebrew](http://mxcl.github.io/homebrew/) (which requires Ruby of course), open Terminal.app (or whatever terminal emulator you might be using) and enter:

	:::bash
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

Now we can go ahead and start installing the base packages we need. Make sure we have the latest homebrew version (which we should), the latest formulas (also should), and that our system is setup correctly. You can check the dependencies of any particular formula with `brew deps <formula name>`. You can see all of the available formulas on [GitHub](https://github.com/mxcl/homebrew/tree/master/Library/Formula).

	:::bash
	brew update && brew upgrade
	brew doctor #should say "Your system is ready to brew."
	# it used to say "Your system is raring to brew!" which is more excitng.

Before moving on to actually installing software, we should use it to make sure the `PATH` environment variable is setup correctly. Specifically we want to make sure that `/usr/local/bin` comes before `/usr/bin/` (this ensures that command line software that ships with your Mac is replaced by stuff in Homebrew if there are duplicates) and that the compilers and such we installed via the command line tools package (either from Xcode or from Apple directly) are available. Assuming you are using `bash` (the default shell on OSX), `PATH` is set in `/etc/paths`. To see what is going on there open up `nano` (or `vim`) from your home directory `sudo nano /etc/paths` and add (and save) the following (if it doesn't look like this already).

	:::bash
	/usr/local/bin
	/usr/bin
	/bin
	/usr/sbin
	/sbin

You'll need to restart your computer to refresh the `PATH`. Note that you can set the `PATH` environment variable in a way that is specific to your terminal by modifying the relevant config file (e.g. `.bashrc` for bash, or `.zshrc` for zsh, but this is not system wide in the same way).

Now we can install some software. Hooray!

	:::bash
	brew install git

Homebrew and Git should be good to go now.

### <a name="Emacs">Emacs</a>

First we need to install [Emacs](http://www.gnu.org/software/emacs/) (the Apple supplied version is 22.1.1, which is *old*). I want the graphical version, but not the pre-built binaries from [emacsformacosx](http://emacsformacosx.com), which, while nice, means you have to download a new binary every time Emacs updates (which, admittedly, is not super often).

	:::bash
	brew install emacs --cocoa

Be sure to symlink Emacs to `/Applications` if you want it to be accessible from the dock. The homebrew formula you just executed should spit out a nicely formatted symlink for you to execute, or you can use `brew linkapps`.

First, check that the Emacs that is being pointed to in your PATH environment variable is the one installed by homebrew.

	:::bash
	emacs --version #should be 24.3.1 or greater
	which emacs #should be /usr/local/bin/emacs

Go ahead and open the emacs and navigate to your `.emacs` file, using `C-x C-f` to open "find file" in the minibuffer. For the uninitiated, `C` meants `control` so `C-x C-f` is `control-x control-f`.

	:::bash
	open -a emacs

First, I set up the package management system, using the [melpa](http://melpa.milkbox.net/), [marmalade](http://marmalade-repo.org/), and [gnu](http://elpa.gnu.org/packages/) package repositories. Since version 24, the package package has shipped with Emacs, so you shouldn't need to install it. Just add this to your `.emacs`.

	:::elisp
	(require 'package)
	(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
							 ("marmalade" . "http://marmalade-repo.org/packages/")
							 ("melpa" . "http://melpa.milkbox.net/packages/")))
	(package-initialize)
	(when (not package-archive-contents) (package-refresh-contents))

This will, by default, install packages to `~/.emacs.d/`, so I add this folder (and its subfolders recursively) to my load-path.

	:::elisp
	(let ((default-directory "~/.emacs.d/elpa/"))
		(normal-top-level-add-to-load-path '("."))
		(normal-top-level-add-subdirs-to-load-path))

You can either restart emacs after this, or just evaluate the buffer (`M-x eval-buffer`, `M` is the `option` or `meta` key on a Mac). Then type `M-x package-list` and `package.el` should fetch a list of the available packages listed in the repositories we listed. All you have to do to install a package is mark the package you want to install with `i` (upgrades are marked using `u`) and then execute all the installs with `x`.

The first thing to do is to make sure Emacs recognizes your environment variables correctly (particularly `$PATH`). So first install the package `exec-path-from-shell` and add the following to your `.emacs`.

	:::elisp
	(require 'exec-path-from-shell)
	(when (memq window-system '(mac ns))
		  (exec-path-from-shell-initialize))


This will ensure that the problem the package author identifies (below) doesn't happen to you!

> On OSX, an Emacs instance started from the graphical user interface will have a different environment than a shell in a terminal window, because OS X does not run a shell during the login. Obviously this will lead to unexpected results when calling external utilities like make from Emacs.

This shouldn't be a problem, however, if all the relevant environment variables are set in `/etc/paths/` as described above.

The basic ones I install for working with R, Python, Git, and LaTeX are [ESS](http://ess.r-project.org/) (Emacs Speaks Statistics, also on [GitHub](https://github.com/emacs-ess/ESS)), [AucTeX](http://www.gnu.org/software/auctex/), [Elpy](https://github.com/jorgenschaefer/elpy) (Emacs Python Development Environment), and [Magit](http://magit.github.io/magit/). All of which are quite awesome.

Magit doesn't require much configuration (or at least I don't use much). Adding the following to `.emacs` should be enough to get you into trouble.

	:::elisp
	(require 'magit)
	(global-set-key (kbd "C-x g") 'magit-status)

For TeX I go with [MacTeX](http://tug.org/mactex/) but alternatively you can install [BasicTeX](http://www.tug.org/mactex/morepackages.html) and install packages as needed. It is a big file. After it is all installed add `/usr/texbin/` to your `PATH` (in the same manner described above). Now we can set up AucTeX in Emacs. For my simple configuration (using XeLaTeX) just add the following to your `.emacs`.

	:::elisp
	(load "auctex.el" nil t t)
	(setq TeX-engine 'xetex) ;; if you prefer xetex that is, the default is pdftex
	(setq TeX-PDF-mode t)

Now when you open a `.tex` file you should be able to compile it using XeLaTeX with a quick `C-c C-c`.

### <a name="R">R</a> (with [ESS](http://ess.r-project.org/))

To install R execute:

	:::bash
	brew tap homebrew/science #the R formula has been moved here
	brew install r --with-openblas

Be sure to symlink `R.framework`  to `/Library/Frameworks`, which is where R-Studio expects to find all your packages and such. Homebrew should give you a symlink to do this at the end of the install process. [OpenBLAS](http://www.openblas.net/) is a faster basic linear algebra subprogram that is faster than the one that R is noramlly built with on OSX. If, for some reason, you cannot install R from source (there are sometimes difficulties with this, as it has a number of dependencies), you can always install the R binary, which won't be as fast, but will work. You can either download that from [CRAN]() or use [brew-cask](), e.g. `brew install caskroom/cask/brew-cask && brew cask install r`.

If you have Bayesian tendencies it is worth noting that there is a `jags` formula (though not a `stan` formula quite yet). While R is installing we can set up ESS which is a great way to interact with the R interpreter. My ESS setup is relatively simple. You can do all sorts of fancy stuff with ESS later (this *is* Emacs after all). 

	:::elisp
	;ess-mode configuration
	(setq ess-ask-for-ess-directory nil) 
	(setq inferior-R-program-name "/usr/local/bin/R") 
	(setq ess-local-process-name "R") 
	(setq ansi-color-for-comint-mode 'filter) 
	(setq comint-scroll-to-bottom-on-input t) 
	(setq comint-scroll-to-bottom-on-output t) 
	(setq comint-move-point-for-output t)
	(setq ess-eval-visibly-p nil)
	(require 'ess-site)

It is worth noting that there are a whole bunch of minor modes that I am not loading. You can find those in `~/.emacs.d/elpa/ess-revision/lisp`, where `revision` is whatever revision of ESS happens to be current. Notably there are modes for JAGS and BUGS (a Stan major mode is also available through the package manager, though it isn't available in ESS at the moment).

### <a name="Python">Python</a> (with [Elpy](https://github.com/jorgenschaefer/elpy))

Onwards to Python. You can install Python with homebrew. I do not do so anymore though! I setup a folder in my home directory where I installed [Anaconda](https://store.continuum.io/cshop/anaconda/) which is unobtrusive and is less of a pain than using `pip`. See [here](http://www.reddit.com/r/Python/comments/1vled5/anaconda_seems_to_have_a_nicely_set_up_library/) for a discussion of why that might be a good idea. Using Anaconda doesn't require much in the way of help, so only directons for install python via homebrew are below.

Install Python (2.7.x) via homebrew (which obviates the need for a few hurdles such as `PYTHONPATH`). Also you can install Python 3 this way (`brew install python3`). Homebrew installs Python modules installed via `pip` to `/usr/local/bin/` so you can delete everything in `/usr/local/share/python` and `/usr/local/share/python3` except for the symlinked `Extras` folder if you please.

	:::bash
	brew install python

Homebrew Python comes with `pip` so we can do this:

	:::bash
	pip install --upgrade distribute
	pip install --upgrade pip

I defer to others on further details of setting up Emacs for proprer development in Python. Some good posts for that follow:

 - [Python Programming in Emacs](http://www.emacswiki.org/emacs/PythonProgrammingInEmacs)
 - [Emacs for Python](https://github.com/gabrielelanaro/emacs-for-python) (a collection of nice tools)
 - [Emacs as a Python IDE](http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/)

Anyways, I am sure you can use your Google-Fu to find plenty more.

### <a name="Julia">Julia</a>

[Julia](http://julialang.org/), a new, wicked-fast technical computing language, can be installed via homebrew as well, by tapping [this](https://github.com/staticfloat/homebrew-julia) repository.

	:::bash
	brew tap staticfloat/julia
	brew install --HEAD --64bit julia

You can then link `julia` from its home in `/usr/local/bin` by setting the variable `inferior-julia-program-name` in your `.emacs` to the correct location.

### <a name="Other">Other Tools</a>

Lastly here is a list of cool Emacs (and non-Emacs) stuff you might want to look at (that I didn't cover here)

 - [autopair](https://github.com/capitaomorte/autopair) (really quite fantastic). [smartparens](https://github.com/Fuco1/smartparens) is probably better, but doesn't work very well with ESS out of the box.
 - [autocomplete](http://cx4a.org/software/auto-complete/) which now integrates with ESS out of the box, is super nice. [Here](http://www.emacswiki.org/emacs/ESSAuto-complete) are some tips on how to set it up with ESS
 - ispell (you can install aspell via homebrew btw) (use it in emacs with `(setq ispell-program-name "/usr/local/bin/aspell")`)
 - Adobe's [Source Code Pro](http://sourceforge.net/projects/sourcecodepro.adobe/files/) is an awesome font for programming (just drag it to the fontbook) use it in Emacs with `(set-face-attribute 'default nil :foundry "apple" :family "Source Code Pro")`
 - you should obviously be using [Alfred](http://www.alfredapp.com/)
 - you can install [pandoc](http://johnmacfarlane.net/pandoc/) by first installing the haskell framework (via homebrew) and then using `cabal`
 - [gdal](http://www.gdal.org/) and [igraph](http://igraph.sourceforge.net/) are also available via homebrew (the latter is in the `homebrew/science` repository, you'll need to `tap` it.)
 - [Mathias' dotfiles](https://github.com/mathiasbynens/dotfiles?source=c) "sensible hacker defaults"
 - [Emacs Starter Kit for the Social Sciences](http://www.kieranhealy.org/resources/emacs-starter-kit.html): not really my style, but a good start. There are a few other Emacs starter kit type things out there as well.
 - [ZSH](http://www.zsh.org/) is pretty boss (also available via homebrew).

I have entirely too much of this stuff. It is truly a wonder I get anything done. Eventually I'll automate all this like a proper developer. [Email](mailto:zmj@zmjones.com) me if I've made any mistakes (well obviously I've made some, but if you find them...) or any glaring ommissions. I'll see myself out.
