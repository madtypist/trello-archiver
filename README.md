#trello-archiver

Simple ruby scripts that you can run to manually or automatically create Excel backups of your [Trello](https://trello.com/) boards. 

##Install
- Download project
- run 
	bundle install
- rename config.example.yml to config.yml and enter your own Trello credentials

##More info
There are two main scripts you can run. *backup.rb* is a command line program that allows you to print a single board at a time from a list of your current boards. *autoarchive.rb* can be used to automatically backup all boards you own at once. You can choose to ignore certain boards by setting their ids into the ignore field in *config.yml*

##Shoutouts
Thanks to Jeremy Tregunna for writing the [ruby-trello library](https://github.com/jeremytregunna/ruby-trello) which made my life a lot easier.

##Feedback?
Hit me up at mad_typist[at]yahoo[dot]com
