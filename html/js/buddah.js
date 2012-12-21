/*
function httpRequest(params) {
	var xmlHttp = new XMLHttpRequest();

	xmlhttp.onreadystatechange = function () {

	} 

	xmlHttp.open(params[method], params[url], params[async]);
	xmlHttp.send(params[send]);
}
*/
var baseUrl = "http://buddah.herokuapp.com/services";

function initForms() {
	initiateRegisterInit();
	getDealsInit();
}

function initiateRegisterInit() {
	$('#initiateRegisterRequest').submit( function() {
		$.ajax({
			type: "PUT",
			url: baseUrl + "/initiateRegister",
			data: $("#initiateRegisterRequest").serialize(),
			success: function (data) {
				console.log("success" + data);
			},
			error: function(a, b, c) {
				console.log("fuckburgers");
				console.log(a.toString());
				console.log(a + b + c + "");
			},
			dataType: 'json'
			
		});

		return false;
	});

}

function getDealsInit() {
	$('#sq2').click( function() {
		$.ajax({
			type: "POST",
			url: baseUrl + "/getDeals",
			data: 	{userId: "heinanana",
				position: { longitude: -121, latitude: 37},
				xOffset: 1.1,
				yOffset: 2.2},
			success: function (data) {
				console.log("get deals success" + data);
			},
			error: function(a, b, c) {
				console.log("deals fuckburgers");
				console.log(a.toString());
				console.log(a + b + c + "");
			},
			dataType: 'json'
			
		});

		return false;
	});

}
