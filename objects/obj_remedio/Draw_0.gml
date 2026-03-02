var offset = 0;

if (!animando_spawn)
    offset = sin(float_timer) * float_amplitude;

draw_sprite_ext(
    sprite_index,
    image_index,
    x,
    y + offset,
    image_xscale,
    image_yscale,
    image_angle,
    image_blend,
    image_alpha
);