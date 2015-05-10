var initWorks = function() {
	if($('body').is('.public')) {
		var max = 450;
		var stackHeight;
		var stackWidth;
		var gap = 4;
		$('.public .work').each(function(i, w) {
			$(w).imagesLoaded(function() {
				$(w).addClass('loaded').css({y: -gap*i, x: gap*i});
			});
		});
		var stackSize = max + ($('.image_wrapper').length * 4);
		$('.public #stack').css({height: stackSize, width: stackSize});
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
		$('select').change(function(e) {
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