function Searcher(postURL, inputID, outputID){
	$("#"+inputID).keyup(function(event){
		$.ajax({
			url: "find_objects",
			type: "GET",
			data: {search: $("#"+inputID).val()},
			success: function(msg) {
				console.log(msg);
				$("#"+outputID).html(msg);
			}
		});
	});
}