# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
update_votes = (data) ->
  for id,num of JSON.parse data.votes
    $("#votes-"+id).html num
  
PrivatePub.subscribe "/votes/update", (data,channel) -> 
  update_votes data
