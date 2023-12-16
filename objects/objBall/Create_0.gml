velocity = new Vector2(random_range(-4, 4), random_range(-4, 4));
color = new Vector3(0, 0, 0);
position_history = [];
current_idx = 0;

for (var i = 0; i < objMain.max_history; i++) {
	array_push(position_history, new Vector2(x, y));
}

stable = false;
stable_count = 0;

function save() {
	position_history[current_idx] = position;
    current_idx = ++current_idx % objMain.max_history;
}

function get_va() {
	var va = [];
	
	for (var i = 0; i < objMain.max_history; i++) {
		var actual_idx = (i + current_idx) % objMain.max_history;
		var ratio = i / objMain.max_history;
		va[i].position = position_history[actual_idx];
		va[i].color = new Vector3(0, ratio * 255, 0);
	}

	return va;
}