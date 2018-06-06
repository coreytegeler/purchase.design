initApply = ->
  $('.box').click ->
    $(this).toggleClass 'checked'
    return
  return

$ initApply
$(document).on 'page:load', initApply