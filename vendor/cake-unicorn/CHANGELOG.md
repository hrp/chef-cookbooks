# CHANGELOG for cake-unicorn

This file is used to list changes made in each version of cake-unicorn.

## 0.2.1

* Update paths for rbenv

## 0.2.0

* Convert to using rbenv instead of rvm

## 0.1.7

* Set HOME environment variable in the init.d script file. HOME is often not set
  via SSH or Capistrano and a nil HOME will cause rb-readline to crash

## 0.1.6

* Add unicorn to rvm-aware global gemset
* Add rvm wrapper for unicorn (cake_unicorn -> unicorn)
* Update init.d template to handle new binary path

## 0.1.5:

* Add current_path to Unicorn init script

## 0.1.4:

* Correct file permissions and restart nginx

## 0.1.3:

* Remove symlinks in nginx site-enabled dir

## 0.1.2:

* Fix instance variables

## 0.1.1:

* Initial release of cake-unicorn

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
