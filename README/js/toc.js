/*
<nav role="navigation" class="table-of-contents">
  <h2>On this page:</h2>
	  <ul>
		<li><a href="#question-one">Question One</a></li>
	  </ul>
</nav>
*/

var ToC =
	"<nav role='navigation' class='table-of-contents'>" +
		"<h3><center>Table of Contents</center></h3>" +
			"<ul>";
	
var newLine, el, title, link;

$(document).ready(function() 
{
	foo($("ul"));
	
	/*$("li").each(function() {

		el = $(this);
		title = el.text();
		link = "#" + el.attr("id");
		
		newLine =
		"<li>" +
			"<a href='" + link + "'>" +
				title +
			"</a>" +
		"</li>";

		ToC += newLine;
		
		$(this).children("li").each(function() {

			el = $(this);
			title = el.text();
			link = "#" + el.attr("id");
			
			newLine =
			"<ul>" +
				"<li>" +
					"<a href='" + link + "'>" +
						title +
					"</a>" +
				"</li>" +
			"</ul>";

			ToC += newLine;
			
			$(this).children("li").each(function() {

				el = $(this);
				title = el.text();
				link = "#" + el.attr("id");
				
				newLine =
				"<ul>" +
					"<li>" +
						"<a href='" + link + "'>" +
							title +
						"</a>" +
					"</li>" +
				"</ul>";

				ToC += newLine;

			});

		});

	});

	ToC +=
			"</ul>" +
		"</nav>";*/
		
	$(".main_container").prepend(ToC);

});

function foo(parent)
{
	$.each(parent, function() {
		el = $(this);
		title = el.text();
		link = "#" + el.attr("id");
		
		newLine =
		"<li>" +
			"<a href='" + link + "'>" +
				title +
			"</a>" +
		"</li>";

		ToC += newLine;
		
		$(this).children("li").each(function(child) {
			foo(child);
		});
	});
}