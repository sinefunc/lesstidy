Lesstidy
========

A CSS tidying tool.

Installation (for text editors)
-------------------------------

 - For VIM users: http://github.com/sinefunc/lesstidy-vim
 - For Textmate users: http://github.com/sinefunc/lesstidy-textmate

Installation (command line)
---------------------------

To use the `lesstidy` command, type `gem install lesstidy --pre`.

Usage
-----

General usage is `lesstidy <input> [<output>]`.

Type `lesstidy --help` for tweaks.

.lesstidyopts file
------------------

Want to impose a LessTidy options standard to your project? Put a file called 
`.lesstidyopts` in your project's folder. Whenever lesstidy is used without
any style options, it finds this file (relative to the current directory).
Put each option in it's own line.

Example:

    # .lesstidyopts
    --preset=column
    --wrap-width=140

Even the text editor plugins (vim, textmate, etc) will refer to this file.

Examples
--------

    lesstidy --preset=compact input.css

To do
-----

 - More types
   - Mixin declarations
   - Var declarations
   - import lines
 - .lesstidyopts

Done:

 - Presets
 - bin/lesstidy
 - blackbox testing
 - Comments
 - recursive wrapping

