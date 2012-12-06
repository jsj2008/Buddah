/*
	TODO: delete objects when necessary for js memory management magic.
*/

var map;
var markers;
var activeInfoWindow;
var mockArr = [
				{lat: 47.64, lng: -122.12, infoId: 665},
				{lat: 47.63, lng: -122.13, infoId: 666},
				{lat: 47.63, lng: -122.125, infoId: 667},
				{lat: 47.60, lng: -122.16, infoId: 'wheres hein?'},
				{lat: 47.65, lng: -122.135, infoId: 668}];



function initMap() {
	markers = [];
	activeInfoWindow = null;

	var mapOptions = {
		center: new google.maps.LatLng(47.63967, -122.12836),
		zoom: 10,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	map = new google.maps.Map(document.getElementById("map_canvas"),
		mapOptions);


	//test
	createMarkers(mockArr);
}

/*
	On click, do a get request to look up description.
	This can be cached.  We do not want to upload all the data at once.
*/
function showInfoWindow() {
	if (!this.infoWindow) {
		this.infoWindow = new google.maps.InfoWindow({
			content: '<img src="http://upload.wikimedia.org/wikipedia/commons/a/a8/Cannabis_leaf.svg" width="32" height="32">' +
					'<div>this id:'+this.infoId+'</div>' +
					'<div>some rating:3.5</div>' +
					'<div>some mad discounted price: dime for a dime</div>'
		});
	}

	if (activeInfoWindow)
		activeInfoWindow.close();

	activeInfoWindow = this.infoWindow;
	activeInfoWindow.open(map, this);
}

/*
	Backend should send an array of coordinates for markers.
	should readjust for zoom and w.e
*/
function createMarkers(arr) {
	if (!arr || arr.length == 0)
		return;

	for (var i in arr) {
		var e = arr[i];
		var marker = new google.maps.Marker({
			position: new google.maps.LatLng(e.lat, e.lng),
			map: map
		});

		marker.infoId = e.infoId;

		google.maps.event.addListener(marker, 'click', showInfoWindow);
	}
}





var activeContent = null;
function showContent(ctx) {
	var div = document.getElementById("content_"+ctx.id);

	if (div == activeContent)
		return;
	
	div.style.display = "block";
	if (activeContent)
		activeContent.style.display = "none";
	activeContent = div;
}



function windowResize(divId) {
	var height = window.innerHeight;
	var e = document.getElementById(divId);
	e.style.height = (height - 29) + "px";
}
