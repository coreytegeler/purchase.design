var initGradients = function() {
	$('.block svg').each(function(){
		fill(this, '#fff');
	});

	$('input[type="file"]').on('change', function(event) {
		var parent = $(this).parent('.drop');
		$(parent).css({'background-image':''});

		if($(parent).has('svg')) {
			$(parent).children('svg').remove();
		}

		var position = $(this).attr('data-position');
		var input = $(this);
	    var files = event.target.files;
	    var file = files[0]
	    var reader = new FileReader();
	    reader.onload = function(file) {
			var src = file.target.result;
			var image = new Image();
			image.src = src;
			$(input).parent('.drop').css({'backgroundImage' : 'url('+src+')'});
			$('form#'+position).addClass('can_save');
	    }
	    reader.readAsDataURL(file);
	});
}

$(initGradients);
$(document).on('page:load', initGradients);