$(function(){
	var columnWidth = $('.masonry .block:first-child').width();

	$('.masonry').masonry({
		itemSelector: '.block',
		columnWidth: columnWidth,
		gutterWidth: 40
		// isFitWidth: true
	});

	$(window).resize(function() {
		$('.masonry').masonry('reload');
	});
	
	$('#border').css({
		height:h() - 163
	});

	$('select').change(function(e) {
		if($(this).val() === '') {
			$(this).css({'opacity':0.7});
		} else {
			$(this).css({'opacity':1});
		}
	});
});