var initWorks = function() {
	var max = 400;
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
		});
	});

}

$(initWorks);
$(document).on('page:load', initWorks);