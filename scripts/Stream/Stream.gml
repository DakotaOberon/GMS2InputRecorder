function replay_tick() {
	var rep_str = global.__replay_streams;
	var names = variable_struct_get_names(rep_str);

	for (var i = 0; i < array_length(names); i++) {
		var item = rep_str[$ names[i]];

		if (item.recording) {
			item.record_frame(global.replay_frame);

			continue;
		}

		if (item.playing_back) {
			item.playback_frame(global.replay_frame);

			continue;
		}
	}

	global.replay_frame += 1;
}

function Stream(__input_function, __verb, __playback_function) constructor {
	log("Creating stream with verb:", __verb);
	input_func = __input_function;
	verb = __verb;
	playback_func = __playback_function;

	recording = false;
	playing_back = false;

	frame_offset = 0;

	length = 0;

	data = replay_stream_initialize();

	start_recording = function () {
		self.stop_playback();
		self.data = replay_stream_reset(self.data);
		self.frame_offset = global.replay_frame;
		self.recording = true;
	}

	stop_recording = function () {
		self.length = global.replay_frame - self.frame_offset;
		self.recording = false;
	}

	start_playback = function () {
		self.frame_offset = global.replay_frame;
		self.playing_back = true;
	}

	stop_playback = function () {
		self.playing_back = false;	
	}

	record_frame = function (frame) {
		replay_write_buffer(self.data, frame - frame_offset, self.input_func(self.verb));
		return;
	}

	playback_frame = function (frame) {
		var actual_frame = frame - frame_offset;
		if (actual_frame >= self.length) {
			self.playing_back = false;
			oPlayer.playing_back = false;
			return;
		}

		self.playback_func(replay_read_buffer(self.data, frame - frame_offset));
	}

	clean_up = function () {
		buffer_delete(self.data);
	}
}

function delete_stream(stream_id) {
	if (typeof(stream_id) == "array") {
		for (var i = 0; i < array_length(stream_id); i++) {
			delete_stream(stream_id[i]);
		}

		return;
	}

	var stream = global.__replay_streams[$ stream_id]

	stream.clean_up();

	variable_struct_remove(global.__replay_streams, stream_id);

	delete stream;
}

function replay_start_recording(stream_id) {
	if (typeof(stream_id) == "array") {
		for (var i = 0; i < array_length(stream_id); i++) {
			replay_start_recording(stream_id[i]);
		}

		return;
	}

	global.__replay_streams[$ stream_id].start_recording();
}

function replay_stop_recording(stream_id) {
	if (typeof(stream_id) == "array") {
		for (var i = 0; i < array_length(stream_id); i++) {
			replay_stop_recording(stream_id[i]);
		}

		return;
	}

	global.__replay_streams[$ stream_id].stop_recording();
}

function replay_start_playback(stream_id) {
	if (typeof(stream_id) == "array") {
		for (var i = 0; i < array_length(stream_id); i++) {
			replay_start_playback(stream_id[i]);
		}

		return;
	}

	global.__replay_streams[$ stream_id].start_playback();
}

function replay_stop_playback(stream_id) {
	if (typeof(stream_id) == "array") {
		for (var i = 0; i < array_length(stream_id); i++) {
			replay_stop_playback(stream_id[i]);
		}

		return;
	}

	global.__replay_streams[$ stream_id].stop_playback();
}

function replay_get_random_id() {
	global.__last_id += 1;
	return "replay_stream_" + global.__last_id;
}

function replay_add_stream(__name, __input_function, __verb, __playback_function) {
	var stream = new Stream(__input_function, __verb, __playback_function);
	variable_struct_set(global.__replay_streams, __name, stream);

	return stream;
}

global.replay_frame = 0;

global.__last_id = 0;

global.__replay_streams = {};

