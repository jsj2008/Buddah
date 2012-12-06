var ctx;

function randomColor() {
	str = 'rgba(' +  (Math.random()*255 | 0) + ',' +
					 (Math.random()*255 | 0) + ',' +
					 (Math.random()*255 | 0) + ',' +
					 .3     + ')';
	console.log(str);
	return str;
}

function divideCanvas(canvas, rows, cols) {
	ctx = canvas.getContext("2d");
	smallWidth = canvas.width/rows;
	smallHeight = canvas.height/cols;

	for (i = 0; i < rows; i++) {
		for (j = 0; j < cols; j++) {
			ctx.fillStyle = randomColor();
			ctx.fillRect(i * smallWidth, j * smallHeight,
						 (i+1) * smallWidth, (j+1) * smallHeight);
		}
	}
}

function getSquare(row, col) {

}

function trackMouse(event) {			
	return;
	console.log('x: ' + (event.pageX - squares_canvas.offsetLeft) +
				'y: ' + (event.pageY - squares_canvas.offsetTop));
}

function initSquare(sq_id, x, y) {
	var square_canvas = document.getElementById(sq_id);

	square_canvas.addEventListener('mousemove', trackMouse, false);
	divideCanvas(square_canvas, x, y);
}



