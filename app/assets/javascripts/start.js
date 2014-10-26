function initialize() {
	$('textarea').editable({inlineMode: false});
}

$(document).on('ready, page:load', initialize);

$(document).on('ready', initialize);