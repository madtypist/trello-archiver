#trello-archiver

##Summary
Simple ruby scripts that you can run to manually or automatically create Excel backups of your Trello boards

##Install
- Download project
- run 
	bundle install
- rename config.example.yml to config.yml and enter your own Trello credentials

##More info
There are two main scripts you can run. *backup.rb* is a command line program that allows you to print a single board at a time from a list of your current boards. *autoarchive.rb* can be used to automatically backup all boards you own at once. You can choose to ignore certain boards by setting their ids into the ignore field in *config.yml*