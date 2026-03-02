var player = obj_jogador;
show_debug_message("estado: " + string(estado));
// Se não estiver em insanidade → fica bloqueado
if (instance_exists(obj_jogo))
{
    if (obj_jogo.estado != ESTADO_JOGO.INSANIDADE)
    {
		if(obj_jogo.estado == ESTADO_JOGO.LUCIDEZ)
		{
		image_speed = 0;
        sprite_index = spr_livre;
		}else
		{
		image_speed = 1;
        sprite_index = spr_bloqueado;	
		}
        return;
    }
}

// LIVRE
if (estado == 0)
{
    image_speed = 0;

    if (place_meeting(x, y, player))
	{
		obj_hud.mostrar_texto("Posso me esconder aqui", 0.10);
        sprite_index = spr_livre_outline;
	}
    else
	{
        sprite_index = spr_livre;
	}
}

// OCUPADO
else if (estado == 1)
{
    sprite_index = spr_ocupado;
    image_speed = 1;
}