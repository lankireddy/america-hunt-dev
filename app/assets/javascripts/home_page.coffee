$ ->
  video_player = document.getElementById('video-background')
  if(video_player?)
    playlist = JSON.parse(video_player.dataset.playlist)
    loop_index = playlist.length
    video_index = 1 #start from 1 because 0 element is already running
    video_player.addEventListener('ended', ->
      video_index++
      video_index = 0 if(video_index == loop_index)
      video_player.src = playlist[video_index]
    )