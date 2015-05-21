var initPublic = function() {
	$('main').addClass('fadeIn');
	fillSvgs();
	setUpSide();
	size();

	if( $('.masonry').length ) {
		var blockWidth = parseInt($('.masonry .block').eq(0).css('width'));
		$('.masonry').masonry({
			itemSelector: '.block',
			columnWidth: blockWidth,
			gutterWidth: 40,
			isFitWidth: true,
			isResizable: true
		});
	}

	var aboutEase = 'cubic-bezier(0.750, 0.750, 0.285, 0.950)';
	$('#logo').click(function() {
		$('#about').css({'display':'block'}).transition({'y': '-100%' }, 400, aboutEase, function() {
			$('#border').css({'overflow':'hidden'});
		});
	});

	$('#about .buffer').click(function() {
		$('#about').transition({'y':'0'}, 400, aboutEase).transition({'display':'none'}, function() {
			$('#border').css({'overflow':'scroll'});
		});
	});

	$('.swapper .block .row a').hover(function() {
		$(this).parent('.row').addClass('hover');
		$(this).parent('.row').siblings('.row').each(function(i, r) {
			$(this).addClass('hover');
		});
	}, function() {
		$(this).parent('.row').removeClass('hover');
		$(this).parent('.row').siblings('.row').each(function(i, r) {
			$(this).removeClass('hover');
		});
	});

	$(window).resize(function() {
		size();
	});

	$(window).on('hashchange', function() {
		fillSvgs();
	});

}

function fillSvgs() {
	$primary = $('#hiddenPalette').attr('data-primary');
	$secondary = $('#hiddenPalette').attr('data-secondary');
	$('.secondary_fill').each(function() {
		fill($(this).children(), $secondary);
	});
	$('.primary_fill').each(function() {
		fill($(this).children(), $primary);
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

	$sideBar = $('#side_bar');
	var padding = border + notice;
	$sideBar.css({
		height:h() - border - notice
	});	
}

function setUpSide() {
	$('.method').click(function(){
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
			$(this).children('.swappee').each(function() {
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


$(initPublic);
$(document).on('page:load', initPublic);
$(document).on('page:fetch', function() {
    $('main').addClass('fadeOut');
});