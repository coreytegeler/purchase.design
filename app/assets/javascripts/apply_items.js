var initApply = function() {
	$('.box').click(function(){
		$(this).toggleClass('checked');
	});
}

$(initApply);
$(document).on('page:load', initApply);