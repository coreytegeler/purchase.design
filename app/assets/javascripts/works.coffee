initWorks = ->
  if $('body').is('.public')
    $('#stack').ready ->
      maxWidth = 525
      maxHeight = 450
      gap = 5
      stackSize = $('#stack .work').length
      gaps = stackSize * gap - gap
      stackWidth = maxWidth + gaps + gap * 2
      stackHeight = maxHeight + gaps + gap * 2
      $('.public #stack').css
        height: stackHeight
        width: stackWidth
      $('#stack .work').each (i, w) ->
        $(w).addClass('loaded').css
          y: gap * -i
          x: gap * i
        if !$(w).children('.designer').length
          $(w).children('.mousepad').css 'cursor': 'pointer'
        return
      return
    $('#stack .work').click (e) ->
      oldTop = $('.work:last-child')
      oldTopPosition = $(oldTop).data('position')
      $(oldTop).insertBefore '.work:first-child'
      oldTooltip = $('.designer[data-position=' + oldTopPosition + ']')
      $(oldTooltip).css 'display': 'none'
      gap = 5
      $('.work').each (i, w) ->
        $(w).css
          y: -gap * i
          x: gap * i
        if $(w).is('.video')
          if $(w).is(':last-child')
            $(w).children('.media_wrapper').children('video')[0].play()
          else
            $('.work:last-child .media_wrapper video').stop()
        return
      return
  else
    $('select#work_media_type').change (e) ->
      form = $(this).parent('.row').parent('form')
      if $(this).val() == 'video'
        $(form).attr 'data-media', 'video'
      else
        $(form).attr 'data-media', 'image'
      return
  $('#stack .work .mousepad').mousemove((e) ->
    if $(this).parent('.work').is(':last-child')
      position = $(this).parent('.work').data('position')
      tooltip = $('#stack .designer[data-position=' + position + ']')
      top = e.offsetY - ($(tooltip).height() / 2)
      left = e.offsetX - ($(tooltip).width() / 2)
      $(tooltip).css
        'top': top
        'left': left
    return
  ).mouseover((e) ->
    if $(this).parent('.work').is(':last-child')
      position = $(this).parent('.work').data('position')
      tooltip = $('#stack .designer[data-position=' + position + ']')
      top = e.offsetY - ($(tooltip).height() / 2)
      left = e.offsetX - ($(tooltip).width() / 2)
      $(tooltip).css
        'display': 'table'
        'top': top
        'left': left
    return
  ).mouseleave ->
    if $(this).parent('.work').is(':last-child')
      position = $(this).parent('.work').data('position')
      tooltip = $('#stack .designer[data-position=' + position + ']')
      $(tooltip).css 'display': 'none'
    return
  return

$ initWorks
$(document).on 'page:load', initWorks