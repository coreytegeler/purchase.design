var initLogos = function() {
	$('.block svg').each(function(){
		fill(this, '#fff');
	});
}

$(initLogos);
$(document).on('page:load', initLogos);