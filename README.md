superstijl
==========

The Superstijl is a party Concept from the Netherlands.

The music during the party changes it's style every 15 minutes.

The party people can vote for the next musical style between a choice of three, every 15 minutes.
They do this using their smartphones by connecting to a wifi network.

This Ruby on Rails webapp allows you to setup such a party !

Installation
------------

Configure the root path of your music in the config/config.yml file

Organize the music like this :
party name/style name/song.mp3

Start the webapp like any rails webapp
The application will scan the music folder when starting up

Create an Ad-hoc wifi on your laptop named "Superstijl"

Go to http://localhost:3000/ and get the party started !