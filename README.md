# Introduction

This little script makes it super easy to check how many unread tickets you have on UserVoice and mixes great with tools like [Alfred](http://www.alfredapp.com/).

# Features

* Check multiple UserVoice instances;
* Display open tickets via Mountain Lion's built in Notification Center (using [terminal-notifier](https://github.com/alloy/terminal-notifier));
* [Growlnotify](http://growl.info/extras.php#growlnotify) fallback for 10.7 and lower;
* Simple installer.

# Setup

* Run `./install.sh` after cloning the repo;
* [Create a new API key](http://developer.uservoice.com/docs/api/getting-started/) on UserVoice's admin page, make sure you check `Trusted`;
* Rename `sites.yml.example` to `sites.yml` and open it in your favorite text editor;
* Add your details: domain is the part before .uservoice.com ({domain}.uservoice.com), you can leave the callback empty.

# Usage

Run `check_uservoice` and you should see a notification pop-up if you have open tickets.

Run `check_uservoice c` to output to the console instead of a visual notification.

Run `check_uservoice d` to display all sites, regardless if there are open tickets.

# Alfred

* Open Alfred's preferences and select the `Extensions` tab;
* Add a new `Script` and enter some details to identify your script;
* Under `keyword` enter the keyword that you want to trigger check_uservoice;
* Check `Silent`;
* Under Command enter this:
```
source ~/.bash_profile && cd "{path to the folder you cloned this repo}" && ./check.rb {query}
```

# Notice

Tested with 10.8, will test with 10.7 and lower.

New BSD License, see `LICENSE` for details.
