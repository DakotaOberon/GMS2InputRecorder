stream_ids = ["player_move_left", "player_move_right", "player_move_up", "player_move_down"];

recording = false;
playing_back = false;

move_left_func = function (val) {
	oPlayer.move_left = val;
}

move_right_func = function (val) {
	oPlayer.move_right = val;
}

move_up_func = function (val) {
	oPlayer.move_up = val;
}

move_down_func = function (val) {
	oPlayer.move_down = val;
}

replay_add_stream("player_move_left", input_check, "move_left", oPlayer.move_left_func);
replay_add_stream("player_move_right", input_check, "move_right", oPlayer.move_right_func);
replay_add_stream("player_move_up", input_check, "move_up", oPlayer.move_up_func);
replay_add_stream("player_move_down", input_check, "move_down", oPlayer.move_down_func);

trail_surface = surface_create(room_width, room_height);

