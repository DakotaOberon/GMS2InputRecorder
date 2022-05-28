if (input_check_pressed("record")) {
	if (not recording) {
		playing_back = false;
		recording = true;
		replay_start_recording(stream_ids);
	} else {
		recording = false;
		replay_stop_recording(stream_ids);
	}
}

if (input_check_pressed("playback")) {
	if (not playing_back) {
		recording = false;
		playing_back = true;
		replay_start_playback(stream_ids);
	} else {
		playing_back = false;
		replay_stop_playback(stream_ids);
	}
}

if (not playing_back) {
	move_left = input_check("move_left");
	move_right = input_check("move_right");
	move_up = input_check("move_up");
	move_down = input_check("move_down");
}

x += (move_right - move_left);
y += (move_down - move_up);

