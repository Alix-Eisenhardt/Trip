var i = 0;

$(document).ready(function() {
	var images = $(".photo");
	images.hide();
	images.each(function() {	
		$(this).css({
			"margin-left": ($(window).width()/2 - $(this).width()/2) + "px"
		});
		console.log($(this).width());
	});
	images.eq(i).show();

	$("img").click(function() {
		images.hide();
		images.eq(++i%$(".photo").length).show();
	});
});