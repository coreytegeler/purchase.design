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

		$('.public #stack').click(function(event) {
			$top = $('.work:last-child');
			$top.insertBefore('.work:first-child');
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
}

$(initWorks);
$(document).on('page:load', initWorks);