if (waiting_speed_factor != speed_down_factor_goal) {
	waiting_speed_factor += speed_down_factor_goal - waiting_speed_factor;
}

var stable = true;

if (!speed_down_counter) {
	array_foreach(balls, function(ball) {
		ball.stable = true;
	});

	stable = update(balls, 1);
	
	if (!stable && ok_count < 200) {
	    ok_count = 0;
	}

	if (stable) {
	    ++ok_count;
	}

	if (waiting_speed_factor) {
	    speed_down_factor = waiting_speed_factor;
	}
	
	speed_down_counter = speed_down_factor;
}

update_pos(balls, speed_down_factor);
center_of_mass = new Vector2(0, 0);
  
array_foreach(balls, function(ball) {
	var stable_ratio = (ok_count > 199) ? 1 : min(1, ball.stable_count / 255)
	var color = stable_color.mult(stable_ratio).add(unstable_color.mult(1 - stable_ratio));
	var radius = ball.radius;

	if (speed_down_factor > 1) {
		radius = ball.radius;
	}

	center_of_mass = center_of_mass.add(ball.position);
	ball.color = color;
});

center_of_mass = center_of_mass.divi(array_length(balls));
iterations++;

#region Key Events
if (keyboard_check_pressed(vk_space)) {
	speed_down_factor_goal = (speed_down_factor == 1) ? 10 : 1;
}

if (keyboard_check_pressed(ord("S"))) {
	save_pos();
}

if (keyboard_check_pressed(ord("L"))) {
	load_pos();
}
#endregion