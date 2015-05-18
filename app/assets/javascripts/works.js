var initWorks = function() {
	if($('body').is('.public')) {
		//GET DYNAMIC NUMBERS
		var maxWidth = 602;
		var maxHeight = 456;
		var stackHeight;
		var stackWidth;
		var gap = 5;

		$('#stack').ready(function() {
			$('#stack .work').each(function(i, w) {
				$(w).addClass('loaded').css({y: -gap*i, x: gap*i});
				if(!$(w).children('.designer').length) {
					$(w).children('.mousepad').css({'cursor':'pointer'});
				}
			});
		});

		$('#stack').ready(function() {
			var gaps = ($('.media_wrapper').length * gap - gap);
			$('.public #stack').css({height: maxHeight + gaps, width: maxWidth + gaps});
		});

		$('#stack .work').click(function(e) {
			var oldTop = $('.work:last-child');
			var oldTopPosition = $(oldTop).data('position');
			$(oldTop).insertBefore('.work:first-child');
			var oldTooltip = $('.designer[data-position='+oldTopPosition+']');
			$(oldTooltip).css({'display' : 'none'});

			// var newTop = $('.work:last-child');
			// var newTopPosition = $(newTop).data('position');
			// var newTooltip = $('.designer#'+newTopPosition);

			$('.work').each(function(i, w) {
				$(w).css({y: -gap*i, x: gap*i});
				if($(w).is('.video')) {
					if($(w).is(':last-child')) {
						$(w).children('.media_wrapper').children('video')[0].play();
					} else {
						$('.work:last-child .media_wrapper video').stop();
					}
				}
			});
			
			
		});
	} else {
		$('select#work_media_type').change(function(e) {
			var form = $(this).parent('.row').parent('form');
			if($(this).val() === 'video') {
				$(form).attr('data-media', 'video');
			} else {
				$(form).attr('data-media', 'image');
			}
		});
	}

	$('#stack .work .mousepad').mousemove(function(e) {
		if($(this).parent('.work').is(':last-child')) {
			var position = $(this).parent('.work').data('position');
			var tooltip = $('#stack .designer[data-position='+position+']');
			var top = e.offsetY - $(tooltip).height()/2;
			var left = e.offsetX - $(tooltip).width()/2;
			$(tooltip).css({
				'top' : top,
				'left' : left
			});
		}
	}).mouseover(function(e) {
		if($(this).parent('.work').is(':last-child')) {
			var position = $(this).parent('.work').data('position');
			var tooltip = $('#stack .designer[data-position='+position+']');
			var top = e.offsetY - $(tooltip).height()/2;
			var left = e.offsetX - $(tooltip).width()/2;
			$(tooltip).css({
				'display' : 'table',
				'top' : top,
				'left' : left
			});
		}
	}).mouseleave(function() {
		if($(this).parent('.work').is(':last-child')) {
			var position = $(this).parent('.work').data('position');
			var tooltip = $('#stack .designer[data-position='+position+']');
			$(tooltip).css({
				'display' : 'none'
			});
		}
	});
}

$(initWorks);
$(document).on('page:load', initWorks);