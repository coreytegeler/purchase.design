initPosts = ->
  $('.remove').each ->
    fill this, '#fff'
    return
  maxWidth = 400
  maxHeight = 350
  gap = 4
  $('.post').each (i, post) ->
    stack = $(post).children('.stack')
    stackSize = $(stack).children('.image').length
    gaps = stackSize * gap - gap
    stackWidth = maxWidth + gaps + gap * 2
    stackHeight = maxHeight + gaps + gap * 2
    $(stack).children('.image').each (i, img) ->
      $(img).imagesLoaded ->
        $(img).addClass('loaded').css
          y: -gap * i
          x: gap * i
        return
      return
    $(stack).css
      width: stackWidth
      height: stackHeight
    $(post).css width: stackWidth + 100
    return
  $('.public .stack').click ->
    $top = $(this).children('.image:last-child')
    $top.insertBefore $(this).children('.image:first-child')
    $(this).children('.image').each (i, img) ->
      $(img).css
        y: -gap * i
        x: gap * i
      return
    return
  return

$ initPosts
$(document).on 'page:load', initPosts