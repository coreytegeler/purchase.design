var initWorks = function() {
	if($('body').is('.public')) {
		var maxWidth = 602;
		var maxHeight = 456;
		var stackHeight;
		var stackWidth;
		var gap = 5;

		$('#stack').ready(function() {
			$('#stack .work').each(function(i, w) {
				$(w).addClass('loaded').css({y: -gap*i, x: gap*i});
				var width = $(w).outerWidth();
				var height = $(w).outerHeight();
				// if(width > maxWidth) {
				// 	maxWidth = width;
				// }
				// if(height > maxHeight) {
				// 	maxHeight = height;
				// }
			});
		});

		$('#stack').ready(function() {
			var gaps = ($('.media_wrapper').length * gap - gap);
			$('.public #stack').css({height: maxHeight + gaps, width: maxWidth + gaps});
		});

		$('#stack').click(function(event) {
			$top = $('.work:last-child');
			$top.insertBefore('.work:first-child');
			$('.work').each(function(i, w) {
				$(w).children('.designer').css({'display':'none'});
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
			var id = $(this).parent('.work').attr('id');
			var tooltip = $('#stack .designer#'+id);
			var top = e.offsetY;
			var left = e.offsetX;
			$(tooltip).css({
				'top' : top,
				'left' : left
			});
		}
	}).mouseover(function(e) {
		if($(this).parent('.work').is(':last-child')) {
			var id = $(this).parent('.work').attr('id');
			var tooltip = $('#stack .designer#'+id);
			$(tooltip).css({
				'display' : 'table'
			});
		}
	}).mouseleave(function() {
		if($(this).parent('.work').is(':last-child')) {
			var id = $(this).parent('.work').attr('id');
			var tooltip = $('#stack .designer#'+id);
			$(tooltip).css({
				'display' : 'none'
			});
		}
	});
}

$(initWorks);
$(document).on('page:load', initWorks);