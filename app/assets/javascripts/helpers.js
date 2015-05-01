function h() {
	return window.innerHeight;
}

function w() {
	return window.innerWidth;
}

function fill(child, color) {
	if($(child).children()) {
	    $(child).children().each(function(){
	        $(this).css({fill:color});
	        fill(this, color);
	    });
	}
}