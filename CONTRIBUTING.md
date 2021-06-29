# Contributing to *the KCNI School Lessons Repo*

Welcome to the *kcni-school-lessons* repository!
We're excited you're here and want to contribute.

**Imposter's syndrome disclaimer**[^1]: We want your help. No, really.

There may be a little voice inside your head that is telling you that
you're not ready to be an open-source contributor; that your skills
aren't nearly good enough to contribute. What could you possibly offer a
project like this one?

We assure you - the little voice in your head is wrong. If you can
write code at all, you can contribute code to open-source. Contributing
to open-source projects is a fantastic way to advance one's coding
skills. Writing perfect code isn't the measure of a good developer (that
would disqualify all of us!); it's trying to create something, making
mistakes, and learning from those mistakes. That's how we all improve,
and we are happy to help others learn.

Being an open-source contributor doesn't just mean writing code, either.
You can help out by writing documentation, tests, or even giving
feedback about the project (and yes - that includes giving feedback
about the contribution process). Some of these contributions may be the
most valuable to the project as a whole, because you're coming to the
project with fresh eyes, so you can see the errors and assumptions that
seasoned contributors have glossed over.

## Practical guide to submitting your contribution

These guidelines are designed to make it as easy as possible to get involved.
If you have any questions that aren't discussed below,
please let us know by opening an [issue][link_issues]! Or checking our the project Q & A in the [Discussions][link_discussions].

Before you start, you'll need to set up a free [GitHub][link_github] account and sign in.
Here are some [instructions][link_signupinstructions].

Already know what you're looking for in this guide? Jump to the following sections:

- [Contributing to *the KCNI School Lessons Repo*](#contributing-to-the-kcni-school-lessons-repo)
  - [Practical guide to submitting your contribution](#practical-guide-to-submitting-your-contribution)
  - [Contributing through GitHub](#contributing-through-github)
  - [Making a change to this repo](#making-a-change-to-this-repo)
  - [Licensing](#licensing)
  - [Thank you!](#thank-you)



## Contributing through GitHub

[git][link_git] is a really useful tool for version control.
[GitHub][link_github] sits on top of git and supports collaborative and distributed working.

If you're not yet familiar with `git`, there are lots of great resources to help you *git* started!
Some of our favorites include the [git Handbook][link_handbook] and
the [Software Carpentry introduction to git][link_swc_intro].

On GitHub, You'll use [Markdown][markdown] to chat in issues and pull requests.
You can think of Markdown as a few little symbols around your text that will allow GitHub
to render the text with a little bit of formatting.
For example, you could write words as bold (`**bold**`), or in italics (`*italics*`),
or as a [link][rick_roll] (`[link](https://youtu.be/dQw4w9WgXcQ)`) to another webpage.

GitHub has a really helpful page for getting started with
[writing and formatting Markdown on GitHub][writing_formatting_github].



## Making a change to this repo

We appreciate all contributions to the lesson content, but there's a bunch of us. So we would prefer you follow a workflow similar to the following:
  
1. **[Fork][link_fork] the [kcni-school-lessons][link_kcni-school-lessons] repo to your profile.**<br />
  This is now your own unique copy of *kcni-school-lessons*.
  Changes here won't affect anyone else's work, so it's a safe space to explore edits to the code!
  
1. **[Clone][link_clone] your forked lessons repository to your machine/computer.**<br />
  While you can edit files [directly on github][link_githubedit], sometimes the changes
  you want to make will be complex and you will want to use a [text editor][link_texteditor]
  that you have installed on your local machine/computer.
  (One great text editor is [vscode][link_vscode]).<br />  
  In order to work on the code locally, you must clone your forked repository.<br />  
  To keep up with changes in the kcni-school-lessons repository,
  add the ["upstream" kcni-school-lessons repository as a remote][link_addremote]
  to your locally cloned repository.  
    ```Shell
    git remote add upstream https://github.com/krembilneuroinformatics/kcni-school-lessons.git
    ```
    Make sure to [keep your fork up to date][link_updateupstreamwiki] with the upstream repository.<br />  
    For example, to update your master branch on your local cloned repository:  
      ```Shell
      git fetch upstream
      git checkout master
      git merge upstream/master
      ```

1. **Create a [new branch][link_branches] to develop and maintain the proposed code changes.**<br />
  For example:
    ```Shell
    git fetch upstream  # Always start with an updated upstream
    git checkout -b day3-2021 upstream/master
    ```

2. **Submit a [pull request][link_pullrequest].**<br />
   A member of the development team will review your changes to confirm
   that they can be merged into the main code base.<br /> 
     * For works-in-progress, add the `WIP` tag in addition to the descriptive prefix.
       Pull-requests tagged with `WIP:` will not be merged until the tag is removed.


3. **Have your PR reviewed by the developers team, and update your changes accordingly in your branch.**<br />
   The reviewers will take special care in assisting you address their comments, as well as dealing with conflicts
   and other tricky situations that could emerge from distributed development.


## Licensing

*kcni-school-lessons* materials are licensed under the MIT license.
By contributing to *kcni-school-lessons*,
you acknowledge that any contributions will be licensed under the same terms.

## Thank you!

You're awesome. :wave::smiley:

<br>

*&mdash; Based on contributing guidelines from the [STEMMRoleModels][link_stemmrolemodels] project.*

[^1]: The imposter syndrome disclaimer was originally written by
    [Adrienne Lowe](https://github.com/adriennefriend) for a
    [PyCon talk](https://www.youtube.com/watch?v=6Uj746j9Heo), and was
    adapted based on its use in the README file for the
    [MetPy project](https://github.com/Unidata/MetPy).

[link_github]: https://github.com/
[link_fMRIPrep]: https://github.com/nipreps/fmriprep
[link_kcni-school-lessons]: https://github.com/krembilneuroinformatics/kcni-school-lessons.git
[link_signupinstructions]: https://help.github.com/articles/signing-up-for-a-new-github-account

[link_git]: https://git-scm.com/
[link_handbook]: https://guides.github.com/introduction/git-handbook/
[link_swc_intro]: http://swcarpentry.github.io/git-novice/

[writing_formatting_github]: https://help.github.com/articles/getting-started-with-writing-and-formatting-on-github
[markdown]: https://daringfireball.net/projects/markdown
[rick_roll]: https://www.youtube.com/watch?v=dQw4w9WgXcQ

[link_issues]: https://github.com/krembilneuroinformatics/kcni-school-lessons/fmriprep/issues
[link_discussions]: https://github.com/krembilneuroinformatics/kcni-school-lessons/discussions


[link_pullrequest]: https://help.github.com/articles/creating-a-pull-request-from-a-fork
[link_fork]: https://help.github.com/articles/fork-a-repo/
[link_clone]: https://help.github.com/articles/cloning-a-repository
[link_githubedit]: https://help.github.com/articles/editing-files-in-your-repository
[link_texteditor]: https://en.wikipedia.org/wiki/Text_editor
[link_vscode]: https://code.visualstudio.com/
[link_addremote]: https://help.github.com/articles/configuring-a-remote-for-a-fork
[link_pushpullblog]: https://www.igvita.com/2011/12/19/dont-push-your-pull-requests/
[link_branches]: https://help.github.com/articles/creating-and-deleting-branches-within-your-repository/
[link_add_commit_push]: https://help.github.com/articles/adding-a-file-to-a-repository-using-the-command-line
[link_updateupstreamwiki]: https://help.github.com/articles/syncing-a-fork/
[link_stemmrolemodels]: https://github.com/KirstieJane/STEMMRoleModels
[link_zenodo]: https://github.com/nipreps/fmriprep/blob/master/.zenodo.json
[link_update_script]: https://github.com/nipreps/fmriprep/blob/master/.maintenance/update_zenodo.py

