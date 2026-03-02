if (animando)
{
    image_speed = 1;

    if (image_index >= image_number - 1)
    {
        obj_jogo.endgame_ativo = true;
        obj_jogo.endgame_fase = 1;
        instance_destroy();
    }

    exit;
}

if (place_meeting(x,y,obj_jogador))
{
    if (keyboard_check_pressed(ord("E")))
    {
        animando = true;
        image_index = 0;
        image_speed = 1;
    }
}

