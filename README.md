superstijl
==========

The Superstijl is a party Concept from the Netherlands.

The music during the party changes it's style every 15 minutes.

The party people can vote for the next musical style between a choice of three, every 15 minutes.
They do this using their smartphones by connecting to a wifi network.

This Ruby on Rails webapp allows you to setup such a party !

DISCLAIMER : This open-source software should only be used for free parties ! The authors of this software are not responsible for anything (at all). 

Features
--------

- Music folder scanning
- Push updates of votes for maximum interactivity
- Big ass countdown timer
- Music player in the browser
- Incredible animations when switching music style (TODO : implement)

Installation
------------

- Make sure you have ruby/gem/bundler installed (we recommend installing with rbenv)
- Configure the path to your music in the config/config.yml file
- Organize the music in configured folder like this :
  "party name"/"style name"/"song.mp3"
- Configure the external address of your server in config/private_pub.yml
- Install libraries : ```bundle```
- Create your database : ```rake db:migrate```
- Start the webapp : ```rails s```
- Start the push server : ```rackup private_pub.ru -s thin -E production```
- Create a wifi named "Superstijl" redirecting all http traffic to your server (for example, use DD-WRT feature : http://www.dd-wrt.com/wiki/index.php/HTTPRedirect)
- Go to http://localhost:3000/ and get the party started ! (Don't even think of using this with IE)
- Let your wild party people connect to the wifi and start voting like mad !

Compatibility
-------------

- Works on IE9, FF, Chrome, IPhone, Android, Windows Phone
- IF you have dumbphone users, set up a public laptop or ipad somewhere with ?multiple=true in the url. This particular device will be able to vote multiple times (but not more than once every 5 seconds).
