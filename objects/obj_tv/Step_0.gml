var player = obj_jogador;
var perto = false;

if (instance_exists(player))
{
    if (place_meeting(x, y, player))
        perto = true;
}



// ESTADO NORMAL

if (estado == 0)
{
    image_speed = 0;

    if (perto)
        sprite_index = spr_tv_outline;
    else
        sprite_index = spr_tv;

    if (perto && keyboard_check_pressed(ord("E")))
    {
        estado = 1;
        timer = duracao_anim;
		obj_hud.mostrar_texto("sem sinal", 2);
        sprite_index = spr_tv_aberto;
        image_index = 0;
        image_speed = 1;     
    }
}



// ESTADO ASSISTINDO


if (estado == 1)
{
	    timer -= delta_time / 1000000;

	    if (timer <= 0)
	    {
	        estado = 0;
	        image_speed = 0;

	}
}