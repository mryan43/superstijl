superstijl
==========

The Superstijl is a party Concept from the Netherlands.

The music during the party changes it's style every 15 minutes.

The party people can vote for the next musical style between a choice of three, every 15 minutes.
They do this using their smartphones by connecting to a wifi network.

This Ruby on Rails webapp allows you to setup such a party !

Features
--------

- Music folder scanning
- Push updates of votes for maximum interactivity
- Big ass countdown timer
- Music player in the browser
- Incredible animations when switching music style (TODO : implement)

Installation
------------

Configure the path to your music in the config/config.yml file

Configure the external address of your server in config/private_pub.yml

Organize the music in configured folder like this :
"party name"/"style name"/"song.mp3"

Start the webapp like any rails webapp : ```rails s```

Start the push server : ```rackup private_pub.ru -s thin -E production```

Create a wifi named "Superstijl" redirecting all http traffic to your server (for example, use DD-WRT feature : http://www.dd-wrt.com/wiki/index.php/HTTPRedirect)

Go to http://localhost:3000/ and get the party started !

Let your wild party people connect to the wifi and start voting like mad !

