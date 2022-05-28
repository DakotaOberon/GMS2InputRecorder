surface_set_target(trail_surface);

draw_sprite(sTrail, 0, x, y);

surface_reset_target();

draw_surface(trail_surface, 0, 0);

draw_self();

var sub = 2;
if (recording) {
	sub = 1;
} else if (playing_back) {
	sub = 0;
}

draw_sprite(sTestSprite, sub, 32, 32);

