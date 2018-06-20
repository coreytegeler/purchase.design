@.initPublic = ->
	$('main').addClass 'fadeIn'
	fillSvgs()
	setUpSide()
	size()
	$('.masonry').each (i, container) ->
		if $block = $(container).find('.block').eq(0)
			gutter = parseInt($block.css('marginBottom'))
			$(container).masonry
				itemSelector: '.block'
				columnWidth: '.block:first-child'
				gutter: gutter
				isFitWidth: true
				isResizable: true
				transitionDuration: 0
			.imagesLoaded () ->
	      $(container).masonry()

	aboutEase = 'cubic-bezier(0.750, 0.750, 0.285, 0.950)'
	$('#logo').click ->
		$('#about').addClass 'opened'
		$('#about .content').animate { scrollTop: 0 }, 0
		return
	$('#about .buffer').click ->
		$('#about').removeClass 'opened'
		return
	$('.swapper .block .row a').hover (->
		$(this).parent('.row').addClass 'hover'
		$(this).parent('.row').siblings('.row').each (i, r) ->
			$(this).addClass 'hover'
			return
		return
	), ->
		$(this).parent('.row').removeClass 'hover'
		$(this).parent('.row').siblings('.row').each (i, r) ->
			$(this).removeClass 'hover'
			return
		return
	$(window).resize ->
		size()
		return
	$(window).on 'hashchange', ->
		fillSvgs()
		return
	return

@.fillSvgs = ->
	primary = $('#hiddenPalette').attr('data-primary')
	secondary = $('#hiddenPalette').attr('data-secondary')
	$('.secondary_fill').each ->
		fill $(this).children(), secondary
		return
	$('.primary_fill').each ->
		fill $(this).children(), primary
		return
	return

@.size = ->
	$border = $('#border')
	paddingTop = parseInt($border.css('paddingTop'))
	paddingBottom = parseInt($border.css('paddingBottom'))
	border = parseInt($border.css('borderWidth')) * 2
	notice = $('.notice').innerHeight()
	padding = paddingTop + paddingBottom + border + notice
	$border.css height: h() - padding
	$sideBar = $('#side_bar')
	padding = border + notice
	$sideBar.css height: h() - border - notice
	return

setUpSide = ->
	$('.method').click ->
		method = $(this).attr('data-method')
		$.ajax
			type: 'POST'
			url: method
			success: (result) ->
				return
			error: (xhr, status, error) ->
				console.log xhr, status, error
	$('#buttons .button.swap').click ->
		id = $(this).attr('id')
		$('.swapper .block').each ->
			$(this).children('.swappee').each ->
				hidden = $(this).hasClass('hidden')
				show = $(this).hasClass(id)
				if show
					$(this).removeClass 'hidden'
				else if !hidden
					$(this).addClass 'hidden'

		$('.masonry').masonry()


initWorks = ->
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

	$('#stack .work .mousepad').mousemove((e) ->
		if $(this).parent('.work').is(':last-child')
			position = $(this).parent('.work').data('position')
			tooltip = $('#stack .designer[data-position=' + position + ']')
			top = e.offsetY - ($(tooltip).height() / 2)
			left = e.offsetX - ($(tooltip).width() / 2)
			$(tooltip).css
				'top': top
				'left': left

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

	).mouseleave ->
		if $(this).parent('.work').is(':last-child')
			position = $(this).parent('.work').data('position')
			tooltip = $('#stack .designer[data-position=' + position + ']')
			$(tooltip).css 'display': 'none'

initCourses = ->
	# $('.course .name').click () ->
	# 	$(this).parents('.course').toggleClass('open')

initPosts = ->
	$('.remove').each ->
		fill this, '#fff'

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

		$(stack).css
			width: stackWidth
			height: stackHeight

		$(post).css width: stackWidth + 100

	$('.public .stack').click ->
		$top = $(this).children('.image:last-child')
		$top.insertBefore $(this).children('.image:first-child')
		$(this).children('.image').each (i, img) ->
			$(img).css
				y: -gap * i
				x: gap * i

initApply = ->
	$('.box').click ->
		$(this).toggleClass 'checked'

$(window).resize () ->
	$('.masonry').each () ->
		$(this).masonry()


$(document).on 'turbolinks:load', () ->
	initPublic()
	initWorks()
	initCourses()
	initPosts()
	initApply()

# $(document).on 'turbolinks:fetch', ->
	# $('main').addClass 'fadeOut'