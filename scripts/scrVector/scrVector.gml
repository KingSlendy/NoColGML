function Vector3(x, y, z) constructor {
	self.x = x;
	self.y = y;
	self.z = z;
	
	static add = function(v) {
		return new Vector3(self.x + v.x, self.y + v.y, self.z + v.z);
	}
	
	static sub = function(v) {
		return new Vector3(self.x - v.x, self.y - v.y, self.z - v.z);
	}
	
	static mult = function(v) {
		return new Vector3(self.x * v, self.y * v, self.z * v);
	}
	
	static divi = function(v) {
		return new Vector3(self.x / v, self.y / v, self.z / v);
	}
	
	static to_rgb = function() {
		draw_set_color(make_color_rgb(self.x, self.y, self.z));
	}
	
	static save = function() {
		var data = {x: self.x, y: self.y, z: self.z};
		return data;
	}
	
	static load = function(data) {
		self.x = data.x;
		self.y = data.y;
		self.z = data.z;
		return self;
	}
}

function Vector2(x, y) constructor {
	self.x = x;
	self.y = y;
	
	static add = function(v) {
		return new Vector2(self.x + v.x, self.y + v.y);
	}
	
	static sub = function(v) {
		return new Vector2(self.x - v.x, self.y - v.y);
	}
	
	static mult = function(v) {
		return new Vector2(self.x * v, self.y * v);
	}
	
	static divi = function(v) {
		return new Vector2(self.x / v, self.y / v);
	}
	
	static save = function() {
		var data = {x: self.x, y: self.y};
		return data;
	}
	
	static load = function(data) {
		self.x = data.x;
		self.y = data.y;
		return self;
	}
}

function dot(v1, v2) {
	return v1.x * v2.x + v1.y * v2.y;
}

function length(v) {
	return sqrt(v.x * v.x + v.y * v.y);
}

function normalize(v) {
	return v.divi(length(v));
}