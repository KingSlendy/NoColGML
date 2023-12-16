stable_color = new Vector3(0, 255, 0);
unstable_color = new Vector3(255, 0, 0);

min_scale = 0.1;
wheel_pos = 0.1;
scale = 0.35;
max_scale = 3;
last_distance = undefined;

speed_down_factor = 1;
speed_down_counter = 1;
waiting_speed_factor = 1;
speed_down_factor_goal = 1;

var num_balls = 20;
var min_size = 5;
var max_size = 70;

iterations = 0;

spawn_range_factor = 0.5;
balls = [];
max_history = 100;

for (var i = 0; i < num_balls; i++) {
	var angle = random(2 * pi);
	var rad = 350.0;

	var start_x = rad * cos(angle);
	var start_y = rad * sin(angle);
	
	array_push(balls, instance_create_layer(0, 0, "Instances", objBall, {
		position: new Vector2(start_x + room_width * 0.5, start_y + room_height * 0.5),
		radius: random_range(min_size, max_size - 1)
	}));
}

ok_count = 0;

function update_scale(pos) {
	wheel_pos = clamp(wheel_pos + pos, 0, 1);
	scale = wheel_pos * (max_scale - min_scale) + min_scale
}

function update(balls, spd) {
	var stable = true;

	var num_balls = array_length(balls);
	var attraction_force_bug = 0.01;
	var center_position = new Vector2(room_width * 0.5, room_height * 0.5);

	for (var i = 0; i < num_balls; i++) {
		var current_ball = balls[i];
		
		// Attraction to center
		var to_center = center_position.sub(current_ball.position);
		current_ball.velocity = current_ball.velocity.add(to_center.mult(attraction_force_bug));

		for (var j = i + 1; j < num_balls; j++) {
		    var collider = balls[j];
		    var collide_vec = current_ball.position.sub(collider.position);
		    var dist = sqrt(collide_vec.x * collide_vec.x + collide_vec.y * collide_vec.y);
		    var min_dist = current_ball.radius + collider.radius;

		    if (dist < min_dist) {
			    stable = false;

			    current_ball.stable = false;
			    collider.stable = false;

			    var collide_axe = collide_vec.divi(dist);

			    current_ball.position = current_ball.position.add(collide_axe.mult(0.5 * (min_dist - dist)));
			    collider.position = collider.position.sub(collide_axe.mult(0.5 * (min_dist - dist)));
		    }
		}
	}

	for (var i = 0; i < num_balls; i++) {
		var current_ball = balls[i];
		
		if (current_ball.stable) {
			current_ball.stable_count++;
		} else {
			current_ball.stable_count = 0;
		}
	}

	return stable;
}

function update_pos(balls, speed_down_factor) {
	dt = 0.016;

	array_foreach(balls, function(ball) {
		ball.position = ball.position.add(ball.velocity.mult(dt / speed_down_factor));
	});

	speed_down_counter--;
}