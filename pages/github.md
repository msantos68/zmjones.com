title: Git and GitHub Tutorial
type: page

This tutorial is a draft of sorts. Issue a pull request or open an issue when something doesn't work as I describe it, you get confused, or I skip important steps. This page is on GitHub [here](https://github.com/zmjones/zmjones.com/tree/master/pages/github.md).

In the below text `>` indicates a command to be executed in a terminal. Monospaced text in codeblocks that is not prefaced with this character is output from the terminal.

<hr/>

I am going to start with a few value statements about social science research. Your work should be transparent. It should be easy to see everything you did to get from an idea to a finished paper. This means you should use open-source software (not STATA, SPSS, SAS, MATLAB). Nobody should have to buy software to verify that your code produces what you say that it produces. Your data should be available online in the most easily accessible format (i.e., not a proprietary binary format produced by one of the above types of software). Nobody should have to request your data. Any data manipulation should be written in an open-source language as well (no Excel). This should be the transparency standard.

<hr/>

## Contents

 - [Git](#git)
 - [Alternatives](#alt)
 - [Installing Git](#install_git)
 - [Using Git](#using_git)
    + [Creating a Git Repository](#create_git)
    + [Adding and Committing Files to a Git Repository](#git_add_commit)
	+ [Undoing Things](#git_undoing)
    + [Branching and Merging](#git_branch_merge)
 - [Open a GitHub Account](#open_github)
 - [Using GitHub](#using_github)
 - [Resources](#resources)

<hr/>

## <a name="git">Git</a>

Git is command line program that handles revision control. It was designed by Linus Torvalds, among many others, to manage the very large code base that is the Linux kernal. There are many people that work on that project and it is very complex. People must be able to work asynchronously on versions of the kernal, there has to always be a master version that is useable, they need the ability to go backwards and forwards in the history of the code, and they need documentation for every change made, so that people other than the original author can understand why said change was made. Git solves these problems. It is good for academic work for the same reasons. Your research code of course will not be nearly as complex, but writing manuscripts with collaborators sometimes results in difficulties (conflicted copies in Dropbox, or, *shudder*, email). With Git you have a record of every change you've ever made to the files in your project folder (code, manuscript, and data), and you can go backwards and forwards in time as needed.

GitHub is a hosting service for Git repositories. It takes your local repositories and puts them online where you can let other people view them (the entire revision history) and work on them with you. This is nice for scholarly work because you should be completely transparent about your work, at the very least after it is published. I wrote a short paper about why this is a good thing for the [Political Methodologist](http://zmjones.com/static/papers/git_tpm.pdf), and my [own work](http://github.com/zmjones/eeesr/) is done in this manner. If you keep a project in revision control from the beginning *all* of your changes are visible to anyone that wants to take the time to look at them. GitHub makes this much easier than directly distributing your actual repository.

## <a name="alt">Alternatives</a>

It is worth noting that the [Open Science Framework](https://osf.io/), which also uses Git (though it is hidden from the user mostly) is a friendlier (but more limiting in some ways) way to do this. It is gaining traction in psychology (one of the leaders/founders of OSF is [Brian Nosek](http://projectimplicit.net/nosek/), who is also involved with the [Reproducibility Project](https://osf.io/ezcuj/wiki/home/) in psychology).

Another important tool is the [Dataverse](http://thedata.org/), which allows you to deposit data in their archive and get a digital object identifier (DOI), which is unique and persistent. Git and GitHub aren't ideal for archiving data, especially large data or binary (i.e., non-text) data, so you should use the Dataverse as well.

<hr/>

## <a name="install_git">Installing Git</a>

Installing Git differs depending on your platform. Windows is not a Unix based system and so it is a little bit more of a pain. On OSX you can install it from the command line, which I recommend if you'd like to learn more than the absolute minimum. To do this you need to first install a couple of other things. Follow the [homebrew section](http://zmjones.com/mac-setup/#Homebrew) of my "Setting up OSX for Data Analysis" page.

If you just want the basics you should use [GitHub's application](https://mac.github.com/). This works like any other OSX application install. [Download](https://central.github.com/mac/latest) the file, unzip it (OSX should have an unarchive utility that does this automatically by double clicking on the .zip file). Then drag `GitHub.app` to your applications folder. Then open the application, input your GitHub username and password.

You will want to use [RStudio](http://www.rstudio.com/products/RStudio/), which is a nice integrated development environment (IDE) for R. [Download it](http://www.rstudio.com/products/rstudio/download/), double click on the .dmg file to mount it, and then drag it to your Applications folder and eject the mounted disk. RStudio integrates with Git using "projects" which are just folders with some metadata stored in a `.Rproj` file. If you've installed Git via one of the above ways RStudio should detect your installation and be able to interact with Git.

If you are on Windows you can install Git a couple of different ways. If you want to use a GUI to interact with Git/GitHub, install [GitHub for Windows](https://windows.github.com/). You can also use the [Git binary](http://git-scm.com/download/win), which will install a Bash shell as well.

## <a name="using_git">Using Git</a>

I'm going to start by describing the workflow of using Git at the command line (CLI = command line interface). Even if you intend on using one of the GUIs, you should pay attention to the logic of this workflow so you know what the GUI is doing. You will probably screw something up at some point and have to use the CLI.

### <a name="create_git">Creating a Git Repository</a>

First, create a folder. On my machine I have a "projects" folder in my home folder but here we'll just create a new folder in the home folder (this is the one with your username). Say the project names is "bloop". I open the `Terminal.app`, which by default opens in the home folder. I am going to first change directory (`cd`) to the projects folder, and then make a new directory (`mkdir`). You can do this with `Finder.app` too.

	:::bash
	> mkdir bloop
	> cd bloop

Now we have a folder "bloop" which is now the present working directory (`pwd` always gives you the current path). Suppose we had an R script we were working on called `data.R`. Since this is just to teach you the basics of Git we'll create an empty file that is a placeholder for a real script. `touch` creates an empty file with its name and extension as the first argument. `ls` (list) will list all the files in the directory, so after we've "touched" `data.R` we will verify it is there.

	:::bash
	> touch data.R
	> ls
	data.R

Now suppose we've done some things with `data.R`: imported some data and cleaned it for example; we've verified that it works as expected also. Now we want to check this file into the revision control system: Git. First we have to initialize a Git repository. We invoke Git commands with `git` followed by a space and the name of the command you want to use. Note that you can look at the manpage (a sort of manual) for Git with `man git`.

	:::bash
	> git init
	Initialized empty Git repository in ~/bloop/.git/
	> git status
	On branch master

	Initial commit

	Untracked files:
	  (use "git add <file>..." to include in what will be committed)

		data.R

nothing added to commit but untracked files present (use "git add" to track)

`git status`, unsurprisingly, tells you what the status of your Git repo is. The first line tells you that you are on branch "master". Branches are versions of the files in the local repo. You can create as many branches as you like. We'll talk more about branching later.

We can see that `data.R` is listed as an untracked file: Git is not versioning it. You can have untracked files in a folder that has a Git repo. In fact, you can make it so that some files don't even show up in the output from `git status` by creating a file called `.gitignore` (just a text file with no extension, the dot on the front indicates that it is a hidden file which will by default not show up in the Finder), and adding the file names that you don't want to see (one per line). You can use patterns in this as well to ignore arbitrarily matched files (don't worry if you don't know what this means).

### <a name="git_add_commit">Adding and Committing Files to a Git Repository</a>

We want to track `data.R`, so we'll add it to the repo.

	:::bash
	> git add data.R
	> git status
	On branch master

	Initial commit

	Changes to be committed:
	  (use "git rm --cached <file>..." to unstage)

		new file:   data.R

Now `data.R` is staged. This means that we've taken `data.R` at this point in time and prepared it to be added to Git. As `git status` says, it has been cached in the staging area. If we made more changes to `data.R` now, they would not be in the staging area. If you open a text editor (`TextEdit.app` will do, Microsoft Word will not) and added a line like `print("Hello World!")`, saved the file, and re-ran `git status` you'd see (I am using `echo` here to make the tutorial automatic):

	:::bash
	> echo 'print("Hello World!")' >> data.R
	> git status
	On branch master

	Initial commit

	Changes to be committed:
	  (use "git rm --cached <file>..." to unstage)

		new file:   data.R

	Changes not staged for commit:
	  (use "git add <file>..." to update what will be committed)
	  (use "git checkout -- <file>..." to discard changes in working directory)

		modified:   data.R

The original file is staged but the modifications are not. We will check in the original file now. This is called "committing." Unsurprisingly the command for this is `git commit`. If we just typed this command into the terminal it would prompt us to add a commit message, that is, a message describing the changes we've made to the repo. How we edit this message depends on an environment variable called `EDITOR`. I am not going to bother with describing what environment variables are but if you are curious you can see what yours is by entering `echo $EDITOR`. We will instead use a flag. Flags are things that come before or after the command name and have a dash or two dashes in front of them and modify what the command does in some way. We will use `-m` to tell Git that we are going to pass an argument to `git commit` that is the commit message, which we will enclose in quotes so that the terminal knows there is one argument (a string) rather than a series of arguments.

	:::bash
	> git commit -m 'first commit. yay!'
	[master (root-commit) 3d4d889] first commit. yay!
	 1 file changed, 0 insertions(+), 0 deletions(-)
	 create mode 100644 data.R
	> git status
	On branch master
	Changes not staged for commit:
	  (use "git add <file>..." to update what will be committed)
	  (use "git checkout -- <file>..." to discard changes in working directory)

		modified:   data.R

	no changes added to commit (use "git add" and/or "git commit -a")

As you can see we committed the original file, but the changes we made are still unstaged. Another flag we can use in adding files to the staging area is `-A` which tells Git to add all the files that are not ignored via `.gitignore`.

	:::bash
	> git add -A
	> git commit -m 'second commit. wamp wamp'
	[master baa9e9d] second commit. wamp wamp
    1 file changed, 1 insertion(+)

We could skip the adding step by using `git -am commit 'second commit. wamp wamp'`. This combines the `a` flag, which commits all tracked files, that is, all files you have added at some previous point but have since made changes to but have not yet committed. If/when you write commit messages using a GUI or an editor it is best to write a one line description of the changes the commit makes followed by one blank line, and then a longer (but not too long) description of the changes.


### <a name="git_undoing">Undoing Things</a>

Sometimes you commit some changes, and then make some more changes that you wish you could have included in the last commit (usually an organizational thing). You can fix this by ammending the last commit with these new changes. Suppose we add a new line to `data.R`: `print("this is a lame example zach!")` (I am going to use `echo` and a pipe to do this, but that is just to make this tutorial fully automated). To add this to the previous commit:

	:::bash
	> echo 'print("this is a lame example zach!")' >> data.R
	> git add -A
	> git commit --amend -m 'new commit message for 2nd commit'
	[master 5a3d0a6] new commit message for 2nd commit
    1 file changed, 2 insertions(+)

Now if we want to look at the commit history, which we can do with `git log`, we see we have only two commits, the second of which (shown at the top, is the result of the first change we made after creating `data.R` and the change that we ammended the second commit with, along with the new commit message).

	:::bash
	> git log
	commit c023d41e6e70c1452b1787430f8d0c8aadc9f1ce
	Author: Zachary M. Jones <zmj@zmjones.com>
	Date:   Mon Jan 19 11:16:51 2015 -0500

		new commit message for 2nd commit

	commit 3d4d88963ce52a6ded8293669eb9218f38c7b920
	Author: Zachary M. Jones <zmj@zmjones.com>
	Date:   Mon Jan 19 11:14:04 2015 -0500

		first commit. yay!

Another common error is staging a file before you should (i.e., before you are done making the changes you want to commit). Say we created a new file `analysis.R`, and accidentally added that to the staging area (say by executing `git add *`, where `*` is a wildcard operator that adds all files). We can remove `analysis.R` from the staging area by:

	:::bash
	touch analysis.R
	git add *
	git reset HEAD analysis.R

In this case removing `analysis.R` from the staging area also means that it is no longer tracked, since we never committed it. We can just delete it now: `rm analysis.R`.

If, instead of simply unstaging a file, you want to *discard* all the changes you've made to a file since the last commit, we can use `git checkout`. Again, this is *discarding* your changes. You won't be able to get them back. Say we delete a line from `data.R`, but now we wish we had not. The line below "checks out" (like a library book) the copy of the file as it was at the last commit in the branch that you are in (this last part will be explained in the next section). In this case it means that `data.R` will revert to the last previous version in branch `master`.

	:::bash
	> echo 'you smell bad' >> data.R
	> git checkout -- data.R
	> cat data.R
	print("Hello World!")
	print("this is a lame example zach!")

As you can see from the output of `cat`, which just prints the contents of the file, "you smell bad" is gone since we never committed that change.

### <a name="git_branch_merge">Branching and Merging</a>

A branch is a copy of the Git repository made at a particular time which operates independently of other branches. As previously mentioned by default there is one branch: `master`. To list the current branches use `git branch`. Branches are useful for working on discrete chunks of a project. With a large software project, for example, there are often any number of bugs at one time, and/or features to be added. A branch would be committed for each discrete task. Then someone would work on said task until it was complete and they had verified that it works. Then the branch would be merged back into the master branch. This is useful because in completing each of these discrete tasks there are often many intermediate stages where the task is not complete, and it would be inappropriate to treat it (at that stage) as complete. This is sometimes less relevant for academic work which isn't being actively used by other people during its development, but, if you do develop academic software (R packages for example), this may be the case, and so it is important to have a master branch that is always working.

Let's create a new branch called "newbranch" and then switch so that we are in that branch rather than master.

	:::bash
	> git branch newbranch
	> git branch
	* master
	  newbranch
	> git checkout newbranch
	Switched to branch 'newbranch'

As you can no doubt guess, `*` indicates the current branch.


<hr/>

## <a name="open_github">Open a GitHub Account</a>

Request a [free student account](https://education.github.com/discount_requests/new). Choose a professional sounding username and a password.

<hr/>

## <a name="using_github">Using GitHub</a>

[GitHub's help](https://help.github.com/) is helpful. Check it out. I am just going to describe the basics.

As I said before, GitHub hosts Git repositories that you have on your local machine. There are public repositories and private repositories. You generally have to pay for the latter but the educational account gives you 5 free private repositories for 2 years. The private repos are nice for keeping things under wraps, though I don't think that there are generally any consequences to sharing work in progress. The chances you are going to get scooped are grossly overstated IMO. Most of my projects have failed and were public and I don't think I have suffered any consequences from that (other than mild angst about it).

You can create a repository on GitHub by clicking the "new repository" button on the right panel. This prompts you to input a repo name (use the same name as your project folder). Then you will see a page that tells you how to add the correct remote to an existing local repository, or to create one and add the correct remote.

Forking is when you take someone else's Git repo hosted on GitHub and make a copy of it on your own GitHub account.

Cloning is when you copy a Git repository hosted on GitHub and download it to your local machine. You can clone repositories in your own account and repos in other people's accounts. So you can clone a forked repository. Cloning gives you the entire repo: all branches and the entire commit history.

<hr/>

## <a name="resources">Resources</a>

My [computing](/computing/#Git) page has a section on Git that lists many of the resources I find helpful. The most important is definitely [Pro Git](http://git-scm.com/book/en/v2).
