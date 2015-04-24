$(function(){
	$('.masonry').masonry({
		itemSelector: '.block',
		columnWidth: 280,
		gutterWidth: 40
	});
	
	$('#border').css({
		height:h() - 163
	});
});