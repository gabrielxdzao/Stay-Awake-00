draw_sprite(spr_menu_background, 0, 0, 0);
var t = current_time / 1000;

draw_sprite(spr_menu_monstro, 0, 10 + sin(t) * 5, 0);
draw_sprite(spr_menu_player, 0, 0, 0);

draw_sprite(spr_menu_logo, 0, 0, 0);

// fade preto
if (iniciou)
{
    draw_set_alpha(fade_alpha);
    draw_set_colour(c_black);
    draw_rectangle(0, 0, 512, 288, false);
    draw_set_alpha(1);
}

// texto
if (!escurecendo && iniciou)
{
    draw_set_font(fnt_hud);
    draw_set_colour(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(256, 144, texto_visivel);
}
else if (!iniciou)
{
    draw_set_font(fnt_hud2);
    draw_set_colour(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
	draw_set_color(c_black);
    draw_text(256, 240, "Pressione qualquer tecla");
	draw_set_color(c_white);
	draw_text(254, 242, "Pressione qualquer tecla");
	
	
}
