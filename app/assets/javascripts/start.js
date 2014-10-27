function initialize() {
	$('textarea').editable({inlineMode: false});

	$(document).on('click', '.read-more', function() {
		$(this).parent().addClass('expand');
	});

	// tags input
	$('.tags-input').tagsInput({
		'width':'100%',
		'height': 'auto',
		'defaultText': 'add more tags'
	});

	// log history
	$('#log-history-btn').click(function() {
		$('#myModal').modal('hide') 
	});
}

$(document).on('ready, page:load', initialize);

$(document).on('ready', initialize);

function sendParams(tags){
  $.ajax({
    url: '/histories',
    type: 'post',
    data: { history: { tags: 'tags' } },
    contentType: 'json',
    success: function(data) {
    	alert(data);
    }
  });
}
