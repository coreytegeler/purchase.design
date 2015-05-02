$(initAccess);
$(document).on('page:load', initAccess);

var initAccess = function() {
	size();

	var columnWidth = $('.masonry .block:first-child').width();
	
	$('.masonry').masonry({
		itemSelector: '.block',
		columnWidth: columnWidth,
		gutterWidth: 40,
		isFitWidth: true
	});

	$(window).resize(function() {
		$('.masonry').masonry('reload');
	});

	$('select').change(function(e) {
		if($(this).val() === '') {
			$(this).css({'opacity':0.7});
		} else {
			$(this).css({'opacity':1});
		}
	});
}

function size() {
	$border = $('#border');
	var paddingTop = parseInt($border.css('paddingTop'));
	var paddingBottom = parseInt($border.css('paddingBottom'));
	var border = parseInt($border.css('borderWidth'))*2;
	var notice = $('.notice').innerHeight();

	var padding = paddingTop + paddingBottom + border + notice;
	$border.css({
		height:h() - padding
	});
}