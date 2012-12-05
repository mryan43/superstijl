$ ->
  if $("#song").length > 0
    PrivatePub.subscribe "/party/next_song", (data,channel) -> 
      window.location.reload()
    PrivatePub.subscribe "/party/next_style", (data,channel) -> 
      window.location.reload()
    jwplayer("player").setup
      autoplay:true
      flashplayer: "/player.swf" 
      file: "/songs/"+$("#song").attr("data-song-id")
      provider: "sound"
      dock:false
      plugins: 
        "viral-2":
          oncomplete:'False'
          onpause:'False'
          functions:'All' 
    jwplayer("player").onReady ->
      jwplayer("player").play true
      #jwplayer("player").seek 10
    jwplayer("player").onComplete ->
      $.ajax "/parties/#{$('#song').attr('party-id')}/next_song",
            type: 'GET'
            dataType: 'json'
            success: (data, textStatus, jqXHR) ->
              
    