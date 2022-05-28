function replay_read_buffer(buffer, step_index) {
	log("Read Step Index: ", step_index);

	var byte_offset = floor(step_index / 8);

	// Get bit offset on current byte
	var bit_offset = 7 - (step_index % 8);

	var bit_alignment = byte_offset * 8;

	// Get to beginning of byte index
	buffer_seek(buffer, buffer_seek_start, bit_alignment);
	var data = buffer_read(buffer, buffer_u8);
	
	var val = (data >> bit_offset) & 1;

	return val;
}

function replay_write_buffer(buffer, step_index, value) {
	log("Write Step Index:", step_index);

	var byte_offset = floor(step_index / 8);

	// Get bit offset on current byte
	var bit_offset = 7 - (step_index % 8);

	var bit_alignment = byte_offset * 8;

	// Get to beginning of byte index
	buffer_seek(buffer, buffer_seek_start, bit_alignment);

	try {
		var data = buffer_read(buffer, buffer_u8);
	} catch (_e) {
		show_debug_message("Creating new data");
		var data = 0;
	}

	// Write bit to it byte
	buffer_seek(buffer, buffer_seek_start, bit_alignment);
	buffer_write(buffer, buffer_u8, data | (value << bit_offset));

	return true;
}

function replay_stream_initialize() {
	return buffer_create(0, buffer_grow, 1);
}

function replay_stream_reset(buffer) {
	buffer_delete(buffer);
	return replay_stream_initialize();
}
