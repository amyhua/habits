function initialize() {
	$('textarea').editable({inlineMode: false});

	$(document).on('click', '.read-more', function() {
		$(this).parent().addClass('expand');
	});
}

$(document).on('ready, page:load', initialize);

$(document).on('ready', initialize);