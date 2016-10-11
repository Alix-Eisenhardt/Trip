$(document).ready(function() {
	var kCode = ['ArrowUp','ArrowUp','ArrowDown','ArrowDown', 'ArrowLeft','ArrowRight', 'ArrowLeft', 'ArrowRight', 'b', 'a', 'Enter'];
	var n = 0;
	$(document).keydown(function(e) {
		if(e.key == kCode[n++]) {
			if(n == kCode.length) {
				konami();
				n=0;
			}
		} else {
			n = 0;
		}
	});
	var source = "http://www.blogcdn.com/blog.games.com/media/2011/12/banana-boy-worm-from-worms-2992.png";
	function konami() {
		for(var i=0; i++<20;) {
			var image = $("<img/>");
			image.attr("src", source);
			$("#main").append(image);
			image.css({
				"position": "absolute",
				"left": Math.random()*($(window).width()-image.width()) + "px",
				"top": Math.random()*($(window).height()-image.height()) + "px"
			});
		}
	}
});