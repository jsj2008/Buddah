function setCookie(c_name, c_value, expire) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate()+expire);

	c_name = escape(c_name);
	c_value = escape(c_value);
	document.cookie = c_name + "=" + c_value +
		(expire==null ? "" : ";expires="+exdate.toGMTString());
}

function getCookie(c_name) {
	var i, e, d, k, v;
	var cookies = document.cookie.split("; ");

	for (i = 0; i < cookies.length; i++) {
		e = cookies[i];
		d = e.indexOf("=");
		k = e.substr(0, d);
		v = e.substr(d+1);

		console.log(e);
		if (c_name == k)
			return unescape(v);
	}
	return null;
}

