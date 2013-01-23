/*
 * sort of done:
 * initiateRegister
 * confirmRegister
 * login
 *
 */

var userToken = "userToken";
var username = "username";

function get_userToken() {
	return getCookie("userToken");
}
function get_username() {
	return username;
}

var baseUrl = "http://buddah.herokuapp.com/services";

function initForms() {
	initiateRegisterInit();
	confirmRegisterInit();
	loginInit();
}

function toJSON(arr) {
	var o = {};
	$.each(arr, function() {
		if (o[this.name] !== undefined) {
			if (!o[this.name].push) {
				o[this.name] = [o[this.name]];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return JSON.stringify(o);
}

function initiateRegisterInit() {
	$('#initiateRegisterRequest').submit( function() {
		//validate here
		$.ajax({
			type: "PUT",
			url: baseUrl + "/initiateRegister",
			data: toJSON($("#initiateRegisterRequest").serializeArray()),
			success: function (data) {
				console.log("success" + data);
			},
			error: function(a, b, c) {
				console.log("fuckburgers");
				console.log(a.toString());
				console.log(a + b + c + "");
			},
			dataType: 'json',
			contentType: 'application/json; charset=utf-8'
		});
		return false;
	});

}

function confirmRegisterInit() {
	$('#confirmRegisterRequest').submit( function() {
		$.ajax({
			type: "POST",
			url: baseUrl + "/confirmRegister",
			data: toJSON($("#confirmRegisterRequest").serializeArray()),
			success: function (data) {
				setCookie("userToken", data.token);
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


function loginData() {
				var o = $("#loginRequest").serializeArray();
				var t = {name: "userToken", value: get_userToken()};
				o.push(t);
				return toJSON(o);

}
function loginInit() {
	$('#loginRequest').submit( function() {
		if (get_userToken() == null) {
			console.log("no userToken");
		}
		$.ajax({
			type: "POST",
			url: baseUrl + "/login",
			data: loginData(),
			success: function (data) {
				console.log("success" + data);
			window.location.href = "map.html"
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
