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

PrivatePub.subscribe "/party/next_style", (data,channel) -> 
  next_style(data)

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
  if max_vote() == 0
    $(".bars div").each ->
      $(this).height "1px"
  else
    biggest = max_vote()
    $(".bars div").each ->
      $(this).height "#{get_percent(biggest, $(this).data("votes"))}%"

interval = null

format_countdown = ->
  seconds_remaining = $("#countdown").attr("data-remaining")
  mins = Math.floor(seconds_remaining / 60)
  secs = seconds_remaining - mins*60
  secs = "0"+secs unless secs > 9
  if (seconds_remaining < 0)
    $("#countdown").html("0:00");
    $.ajax "/parties/#{$('#countdown').attr('party-id')}/next_style",
        type: 'GET'
        dataType: 'json'
        success: (data, textStatus, jqXHR) ->
    clearInterval(interval)
  else
    $("#countdown").html("#{mins}:#{secs}");

next_style = (winner) ->
  clearInterval(interval)
  
  
  window.location.reload()

countdown = ->
  format_countdown();
  interval = setInterval(-> 
    $("#countdown").attr("data-remaining", $("#countdown").attr("data-remaining") - 1)
    format_countdown()
  ,1000);

$ ->
  define_heights()
  countdown()