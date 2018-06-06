initLogos = ->
  $('.block svg').each ->
    fill this, '#fff'
    return
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
    return
  return

$ initLogos
$(document).on 'page:load', initLogos