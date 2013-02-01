/* sort of done:
 * getDeals
 * getDealsResult
 * posting
 * 
 * not done:
 * getUserInfo
 * getUserInfoResult
 * rating
 * viewUserRating
 * viewUserRatingResult
 */

function initBuddah() {
	getDealsInit();
	postingInit();
}

function getDealsInit() {
	$('#sq2').click( function() {
		$.ajax({
			type: "POST",
			url: baseUrl + "/getDeals",
			data: JSON.stringify({userToken: get_userToken(),
									username: get_username(),
									xOffset: 5.0,
									yOffset: 5.0,
									position: {latitude: 47,
												longitude: -122}
							}),
			success: function (data) {
				console.log("guid is " + data.guid);
				getDealsResult(data.guid, 0);
			},
			error: function() {
				console.log("getdeals error");
			},
			dataType: 'json',
			contentType: 'application/json; charset=utf-8'
		});
		return false;
	});
}

function getDealsResult(guid, count) {
		$.ajax({
			type: "POST",
			url: baseUrl + "/getDealsResult",
			data: JSON.stringify({userToken: get_userToken(),
									username: get_username(),
									guid: guid
							}),
			success: function (data) {
				console.log("success" + data);
				if (data.ready == true) {
					console.log("list is here!");
					console.log(data.listings);
				} else {
					if (count < 12)
						setTimeout(function() {getDealsResult(guid, count+1);}, 800);
					else
						console.log("fuck why shit take so long?");
				}
			},
			error: function() {
				console.log("getdealsresults error");
			},
			dataType: 'json',
			contentType: 'application/json; charset=utf-8'
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

function postingData() {
	var o = toRawJSON($("#postingRequest").serializeArray());
	var p = {"latitude": 46, "longitude":-122};
	var u = {"userToken": get_userToken(),"username": get_username()};

	o["position"] = p;
	u["listing"] = o;

	return JSON.stringify(u);
}

function postingInit() {
	$('#postingRequest').submit( function() {
		$.ajax({
			type: "PUT",
			url: baseUrl + "/posting",
			data: postingData(),
			success: function (data) {
				console.log("posting success");
			},
			error: function() {
				console.log("posting error");
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

