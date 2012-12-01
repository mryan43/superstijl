# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
update_votes = (data) ->
  for id,num of JSON.parse data.votes
    $("#votes-"+id).html num
    $("#bar-"+id).data "votes", num
  
PrivatePub.subscribe "/votes/update", (data,channel) -> 
  update_votes data
  define_heights()

max_vote = () ->
  votes = 0
  $(".bars div").each ->
    if $(this).data("votes") > votes
      votes = $(this).data "votes" 
  return votes;
  
get_percent = (biggest, current) ->
  if biggest == current
    return 100
  return (current * 100) / biggest

define_heights = () ->
  biggest = max_vote()
  $(".bars div").each ->
    $(this).height "#{get_percent(biggest, $(this).data("votes"))}%"

$ ->
  define_heights()