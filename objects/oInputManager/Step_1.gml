input_tick();
replay_tick();

//Bind keyboard controls to verbs
input_default_key(ord("A"),  "move_left");
input_default_key(ord("D"), "move_right");
input_default_key(ord("W"), "move_up");
input_default_key(ord("S"), "move_down");
input_default_key(vk_space, "record");
input_default_key(vk_return, "playback");

input_player_source_set(INPUT_SOURCE.KEYBOARD_AND_MOUSE);

