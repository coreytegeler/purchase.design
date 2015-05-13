var initPosts = function() {

	$('.remove').each(function(){
		fill(this, '#fff');
	});


	var max = 400;
	var stackHeight;
	var stackWidth;
	var gap = 4;

	$('.post').each(function(i, post) {
		stack = $(post).children('.stack');
		$(stack).children('.image').each(function(i, img) {
			$(img).imagesLoaded(function() {
				$(img).addClass('loaded').css({y: -gap*i, x: gap*i});
			});
		});
		var stackSize = max + ($(this).children('.image').children('.image_wrapper').length * 4);
		$(stack).css({height: stackSize, width: stackSize});
		$(post).css({width: stackSize + 100});
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