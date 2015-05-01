$(function() {
	$('select#post_category').change(function(e) {
		var id = $(this).parent('.row').parent('form').attr('id');
		if($(this).val() === 'event') {
			$('form#' + id + ' .date').css({'display':'table'});
		} else {
			$('form#' + id + ' .date').css({'display':'none'});
		}
	});


	var max = 300;
	var stackHeight;
	var stackWidth;
	var gap = 4;
	$('.public .image').each(function(i, w) {
		$(w).imagesLoaded(function() {
			$(w).addClass('loaded').css({y: -gap*i, x: gap*i});
		});
	});
	var stackSize = max + ($('.image_wrapper').length * 4);
	$('.public .stack').css({height: stackSize, width: stackSize});


	$('.public .stack').click(function(event) {
		$top = $('.image:last-child');
		$top.insertBefore('.image:first-child');
		$('.image').each(function(i, w) {
			$(w).css({y: -gap*i, x: gap*i});
		});
	});
});