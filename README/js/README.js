/* ToC Parameters */
$(document).ready(function(){
	$("#toc").tableOfContents(
		null,                        // Default scoping
		{
			startLevel:           2,   // H2
			depth:                3,   // H2 through H4
		}
	);
});

/* Go-To Top Button */
$('.go-top').click(function () 
{
	$("html, body").animate({scrollTop: 0}, 1000);
});

/* On Window Scroll */
$(window).scroll(function()
{
	/* Go To Top Button */
    if ($(this).scrollTop()) {
        $('.go-top').fadeIn();
    } else {
        $('.go-top').fadeOut();
    };
	
	/* ToC Hide */
	/*if ($(this).scroll()) {
        $('#toc').toggleClass('hide');
    };*/
});