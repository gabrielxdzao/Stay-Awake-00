var dt = delta_time / 1000000;


if (!iniciou)
{
    if (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_left))
    {
        iniciou = true;
        escurecendo = true;

        
        if (!snd_lucido_played)
        {
            snd_lucido_played = true;
            audio_play_sound(snd_lucido, 1, true); 
        }
    }

    exit;
}


if (escurecendo)
{
    fade_alpha += fade_speed * dt;

    if (fade_alpha >= 1)
    {
        fade_alpha = 1;
        escurecendo = false;
    }

    exit;
}


if (!terminou)
{
    timer_texto += dt;

    if (timer_texto >= vel_texto)
    {
        timer_texto = 0;

        if (indice_letra < string_length(texto_intro))
        {
            indice_letra++;
            texto_visivel = string_copy(texto_intro, 1, indice_letra);
        }
        else
        {
            terminou = true;
            alarm[0] = room_speed * 1;
        }
    }
}