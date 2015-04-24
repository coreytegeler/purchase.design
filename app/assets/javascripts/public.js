$(function() {
	fillSvgs();
	setUpSide();
	size();
	$(window).on('hashchange', function() {
		fillSvgs();
	});
	$('.masonry').masonry({
		itemSelector: '.block',
		columnWidth: 280,
		gutterWidth: 40
	});
});

$(window).resize(function() {
	size();
	$('.masonry').masonry('reload');
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
	$('#buttons .button.method').click(function(){
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

	$('#buttons .button.swap').click(function() {
		var id = $(this).attr('id');
		$('.swapper .block').each(function() {
			$(this).children('.text').each(function() {
    			var hidden = $(this).hasClass('hidden');
    			var show = $(this).hasClass(id);
    			if(show) {
    				$(this).removeClass('hidden');
    			} else if (!hidden) {
    				$(this).addClass('hidden');
    			}
    		});
		});
		$('.masonry').masonry('reload');
	});
	
}