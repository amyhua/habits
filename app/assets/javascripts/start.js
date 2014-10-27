function initialize() {
	$('textarea').editable({inlineMode: false});

	$(document).on('click', '.read-more', function() {
		$(this).parent().addClass('expand');
	});

	// tags input
	$('.tags-input').tagsInput({
		'width':'100%',
		'height': 'auto',
		'defaultText': 'add more'
	});
}

$(document).on('ready, page:load', initialize);

$(document).on('ready', initialize);