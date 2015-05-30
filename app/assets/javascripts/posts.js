var initPosts = function() {

	$('.remove').each(function(){
		fill(this, '#fff');
	});

	var maxWidth = 400;
	var maxHeight = 350;
	var gap = 4;

	$('.post').each(function(i, post) {
		var stack = $(post).children('.stack');
		var stackSize = $(stack).children('.image').length;
		var gaps = stackSize * gap - gap;
		var stackWidth = maxWidth + gaps + gap*2;
		var stackHeight = maxHeight + gaps + gap*2;
		$(stack).children('.image').each(function(i, img) {
			$(img).imagesLoaded(function() {
				$(img).addClass('loaded').css({y: -gap*i, x: gap*i});
			});
		});
		$(stack).css({width: stackWidth, height: stackHeight});
		$(post).css({width: stackWidth + 100});
	});

	$('.public .stack').click(function() {
		$top = $(this).children('.image:last-child');
		$top.insertBefore($(this).children('.image:first-child'));
		$(this).children('.image').each(function(i, img) {
			$(img).css({y: -gap*i, x: gap*i});
		});
	});
}

$(initPosts);
$(document).on('page:load', initPosts);