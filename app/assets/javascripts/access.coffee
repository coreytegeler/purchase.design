initAccess = ->
  size()
  columnWidth = $('.masonry .block:first-child').width()
  $('.masonry').masonry
    itemSelector: '.block'
    columnWidth: columnWidth
    gutterWidth: 40
    isFitWidth: true
    isResizable: true
  $('select').change (e) ->
    if $(this).val() == ''
      $(this).css 'opacity': 0.7
    else
      $(this).css 'opacity': 1
  imagePreview()

size = ->
  $border = $('#border')
  paddingTop = parseInt($border.css('paddingTop'))
  paddingBottom = parseInt($border.css('paddingBottom'))
  border = parseInt($border.css('borderWidth')) * 2
  notice = $('.notice').innerHeight()
  padding = paddingTop + paddingBottom + border + notice
  $border.css height: h() - padding

initLogos = ->
  $('.block svg').each ->
    fill this, '#fff'

  $('input[type="file"]').on 'change', (event) ->
    parent = $(this).parent('.drop')
    $(parent).css 'background-image': ''
    if $(parent).has('svg')
      $(parent).children('svg').remove()
    if $(parent).has('img')
      $(parent).children('img').remove()
    position = $(this).attr('data-position')
    input = $(this)
    files = event.target.files
    file = files[0]
    reader = new FileReader

    reader.onload = (file) ->
      src = file.target.result
      image = new Image
      image.src = src
      $(input).parent('.drop').append image
      $('form#' + position).addClass 'can_save'
      return

    reader.readAsDataURL file

initGradients = ->
  $('.block svg').each ->
    fill this, '#fff'

  $('input[type="file"]').on 'change', (event) ->
    parent = $(this).parent('.drop')
    $(parent).css 'background-image': ''
    if $(parent).has('svg')
      $(parent).children('svg').remove()
    position = $(this).attr('data-position')
    input = $(this)
    files = event.target.files
    file = files[0]
    reader = new FileReader
    console.log file
    reader.onload = (file) ->
      src = file.target.result
      image = new Image
      image.src = src
      $(input).parent('.drop').css('backgroundImage': 'url(' + src + ')')
      console.log $(input)
      $('form#' + position).addClass('can_save')
      return

    reader.readAsDataURL file

initWorks = ->
  $('select#work_media_type').change (e) ->
    form = $(this).parent('.row').parent('form')
    if $(this).val() == 'video'
      $(form).attr 'data-media', 'video'
    else
      $(form).attr 'data-media', 'image'

imagePreview = ->
  $('input[type="file"]:not(.no_bg)').each ->
    $(this).on 'change', (event) ->
      drop = $(this).parent('.drop')
      position = $(this).attr('data-position')
      input = $(this)
      files = event.target.files
      if files.length
        file = files[0]
        type = file.type
        if $(drop).hasClass('image')
          if type.match('image/jpg') or type.match('image/jpeg') or type.match('image/png') or type.match('image/gif')
            reader = new FileReader

            reader.onload = (file) ->
              img = file.target.result
              $(drop).css 'background-image': 'url(' + img + ')'
              $('form#' + position).addClass 'can_save'
              return

            if file != undefined
              reader.readAsDataURL file
          else
            console.log type
        else if $(drop).hasClass('video')
          if type.match('video/mp4')
            $(drop).css 'background-image': ''
            $('form#' + position).addClass 'can_save'
          else
            console.log type
      else
        $(drop).css 'background-image': ''
        $('form#' + position).removeClass 'can_save'

$(initAccess)
$(initLogos)
$(initGradients)
$(initWorks)

$(document).on 'turbolink:load', () ->
  initAccess()
  initLogos()
  initGradients()
  initWorks()