window.h = ->
  window.innerHeight

window.w = ->
  window.innerWidth

window.fill = (child, color) ->
  if $(child).children()
    $(child).children().each ->
      $(this).css fill: color
      fill this, color
      return
  return