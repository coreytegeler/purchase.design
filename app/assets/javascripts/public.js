$(function() {
	fillSvgs();
	setUpSide();
	size();
	$(window).on('hashchange', function() {
		fillSvgs();
	});
});

$(window).resize(function() {
	size();
});

function fillSvgs() {
	$primary = $('#hiddenPalette').attr('data-primary');
	$secondary = $('#hiddenPalette').attr('data-secondary');
	$('.secondary_fill').each(function() {
		$(this).children('svg').css({fill:$secondary});
		$(this).children('svg').children('path').css({fill:$secondary});
		$(this).children('svg').children('path').css({fill:$secondary});
	});
	$('.primary_fill').each(function() {
		$(this).children('svg').css({fill:$primary});
		$(this).children('svg').children('path').css({fill:$primary});
		$(this).children('svg').children('path').css({fill:$primary});
	});
}

function size() {
	$('aside#side_bar').css({
		height:h() - 18
	});
	$('#border').css({
		height:h() - 163
	});
}

function setUpSide() {
	$('#buttons .button').click(function(){
		var method = $(this).attr('id');
		$.ajax({
			type: "POST",
			url: method,
			success: function(result) {
				window.location.reload();
			},
			error: function(xhr, status, error) {
			}
    	});
	});
}