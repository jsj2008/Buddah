/* done:
 * 
 * not done:
 * getDeals
 * getDealsResult
 * rating
 * posting
 * viewUserRating
 * viewUserRatingResult
 */


function getDealsInit() {
	$('#sq2').click( function() {
		$.ajax({
			type: "POST",
			url: baseUrl + "/getDeals",
			data: JSON.stringify({userToken: get_userToken(),
									username: get_username(),
									xOffset: "x",
									yOffset: "y",
									position: {latitude: 47,
												longitude: -122}
							}),
			success: function (data) {
				console.log("guid is " + data);
			},
			error: function() {
				console.log("fuckburgers");
			},
			dataType: 'json',
			contentType: 'application/json; charset=utf-8'
		});
		return false;
	});
}

function getDealsResultInit() {
	$('#getDealsResultRequest').submit( function() {
		$.ajax({
			type: "POST",
			url: baseUrl + "/getDealsResult",
			data: JSON.stringify($("#getDealsResultRequest").serialize()),
			success: function (data) {
				console.log("success" + data);
			},
			error: function() {
				console.log("fuckburgers");
			},
			dataType: 'json',
			contentType: 'application/json; charset=utf-8'
		});
		return false;
	});
}

function ratingInit() {
	$('#ratingRequest').submit( function() {
		$.ajax({
			type: "POST",
			url: baseUrl + "/rating",
			data: JSON.stringify($("#ratingRequest").serialize()),
			success: function (data) {
				console.log("success" + data);
			},
			error: function() {
				console.log("fuckburgers");
			},
			dataType: 'json',
			contentType: 'application/json; charset=utf-8'
		});
		return false;
	});
}

function postingInit() {
	$('#postingRequest').submit( function() {
		$.ajax({
			type: "PUT",
			url: baseUrl + "/posting",
			data: JSON.stringify($("#postingRequest").serialize()),
			success: function (data) {
				console.log("success" + data);
			},
			error: function() {
				console.log("fuckburgers");
			},
			dataType: 'json',
			contentType: 'application/json; charset=utf-8'
		});
		return false;
	});
}

function viewUserRatingInit() {
	$('#viewUserRatingRequest').submit( function() {
		$.ajax({
			type: "POST",
			url: baseUrl + "/viewUserRating",
			data: JSON.stringify($("#viewUserRatingRequest").serialize()),
			success: function (data) {
				console.log("success" + data);
			},
			error: function() {
				console.log("fuckburgers");
			},
			dataType: 'json',
			contentType: 'application/json; charset=utf-8'
		});
		return false;
	});
}

function viewUserRatingResultInit() {
	$('#viewUserRatingResultRequest').submit( function() {
		$.ajax({
			type: "POST",
			url: baseUrl + "/viewUserRatingResult",
			data: JSON.stringify($("#viewUserRatingResultRequest").serialize()),
			success: function (data) {
				console.log("success" + data);
			},
			error: function() {
				console.log("fuckburgers");
			},
			dataType: 'json',
			contentType: 'application/json; charset=utf-8'
		});
		return false;
	});
}

