function initialize() {
	$('textarea').editable({inlineMode: false});

	$(document).on('click', '.read-more', function() {
		$(this).parent().addClass('expand');
	});

	// tags input
	$('.tags-input').tagsInput({
		'width':'100%',
		'height': 'auto',
		'defaultText': 'add more tags',
		'autocomplete_url':'/historiesjson.json',
	  'autocomplete': {selectFirst:true,width:'100px',autoFill:true}


	});

	// log history
	$('#log-history-btn').click(function() {
		$('#myModal').modal('hide') 
		// TODO: Add to localStorage, to preserve PER DAY tags
	});

	// visualize history
	drawHistoriesBubbleGraph();
	redrawHistoriesBubbleGraph();


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

function drawHistoriesBubbleGraph() {
	if ($("#histories-bubble-graph").length === 0) {
		return;
	}

	var diameter = 660,
    format = d3.format(",d"),
    color = d3.scale.category20c();

	var bubble = d3.layout.pack()
	    .sort(null)
	    .size([diameter, diameter])
	    .padding(1.5);

	if ($("#histories-bubble-graph svg").length === 0) {
		var svg = d3.select("#histories-bubble-graph")
					.append("svg")
					.attr('id', 'histories-bubble-graph-svg');
	} else {
		var svg = d3.select("#histories-bubble-graph-svg");
	}

	svg
		.attr("width", diameter)
	    .attr("height", diameter)
	    .attr("class", "bubble");

	d3.json("/api/histories/last-week/bubble.json", function(error, root) {
	  var node = svg.selectAll(".node")
	      .data(bubble.nodes(classes(root))
	      .filter(function(d) { return !d.children; }))
	    .enter().append("g")
	      .attr("class", "node")
	      .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });

	  node.append("title")
	      .text(function(d) { return d.className + ": " + format(d.value); });

	  node.append("circle")
	      .attr("r", function(d) { return d.r; })
	      .style("fill", function(d) { return color(d.packageName); });

	  node.append("text")
	      .attr("dy", ".3em")
	      .style("text-anchor", "middle")
	      .text(function(d) { return d.className.substring(0, d.r / 3); });
	});

	// Returns a flattened hierarchy containing all leaf nodes under the root.
	function classes(root) {
	  var classes = [];

	  function recurse(name, node) {
	    if (node.children) node.children.forEach(function(child) { recurse(node.name, child); });
	    else classes.push({packageName: name, className: node.name, value: node.size});
	  }

	  recurse(null, root);
	  return {children: classes};
	}

	d3.select(self.frameElement).style("height", diameter + "px");
}

function redrawHistoriesBubbleGraph() {
	$('#log-history-page-btn').on('click', function() {
		drawHistoriesBubbleGraph();	
	});
}