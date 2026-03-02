var dt = delta_time / 1000000;

// sanidade
if (!em_transicao && !jogo_bloqueado)
{
    switch (estado)
    {
        case ESTADO_JOGO.LUCIDEZ:
            sanidade -= vel_lucidez * dt;

            if (sanidade <= 0)
            {
                sanidade = sanidade_max;
                estado = ESTADO_JOGO.INSANIDADE;
                em_transicao = true;
                tempo_transicao = tempo_transicao_max;

                if (instance_exists(obj_jogador))
                {
                    var j = obj_jogador;

                    if (j.escondido)
                    {
                        j.escondido = false;

                        if (instance_exists(j.esconderijo_atual))
                            j.esconderijo_atual.estado = 0;

                        j.esconderijo_atual = noone;
                        j.visible = true;
                    }
                }

                with (obj_armario_base)
                {
                    ja_aberto = false;
                    estado = 0;
                    image_index = 0;
                }

                armarios_abertos = 0;

                ds_list_clear(armarios_abertos_ids);
                ds_list_clear(armarios_remedio_ids);
                ds_list_clear(armarios_remedio_tipos);
            }
        break;

        case ESTADO_JOGO.INSANIDADE:
            sanidade -= vel_insanidade * dt;

            if (sanidade <= 0)
                estado = ESTADO_JOGO.COLAPSO;
        break;

        case ESTADO_JOGO.COLAPSO:
        break;
    }
}

// transição de estado
if (em_transicao)
{
    tempo_transicao -= dt;
    obj_camera.canShake = 3;

    if (tempo_transicao <= 0)
    {
        em_transicao = false;
        tempo_transicao = 0;
    }
}

// trava durante fade
jogo_bloqueado = (fade_phase != 0);

// fade system
if (fade_phase == 1) // escurecendo
{
    fade_alpha += fade_speed * dt;

    if (fade_alpha >= 1)
    {
        fade_alpha = 1;
        fade_phase = 2;
    }
}
else if (fade_phase == 2) // preto + troca
{
    fade_delay_timer -= dt;

    if (fade_delay_timer <= 0)
    {
        fade_delay_timer = 0;

        if (room_exists(room_pendente))
        {
            if (instance_exists(obj_jogador))
                obj_jogador.entrada_destino = entrada_pendente;

            var r = room_pendente;
            room_pendente = noone;
            entrada_pendente = "";

            fade_phase = 3;
            room_goto(r);
            exit;
        }
        else
        {
            fade_phase = 0;
            fade_alpha = 0;
        }
    }
}
else if (fade_phase == 3) // clareando
{
    fade_alpha -= fade_speed * dt;

    if (fade_alpha <= 0)
    {
        fade_alpha = 0;
        fade_phase = 0;
    }
}

// criatura spawn
if (criatura_timer > 0)
{
    criatura_timer -= dt;

    if (criatura_timer <= 0)
    {
        if (!instance_exists(obj_criatura))
        {
            var qtd = instance_number(obj_criatura_spawn1);

            if (qtd > 0)
            {
                var escolha = irandom(qtd - 1);
                var spawn = instance_find(obj_criatura_spawn1, escolha);

                if (spawn != noone)
                    instance_create_layer(spawn.x, spawn.y, "top", obj_criatura);
            }
        }

        criatura_timer = -1;
    }
}

// endgame
if (endgame_ativo)
{
    if (endgame_fase == 1)
    {
        endgame_fade += endgame_fade_speed * dt;

        if (endgame_fade >= 1)
        {
            endgame_fade = 1;
            room_goto(rm_quarto_fim);
            endgame_fase = 2;
            endgame_timer = 4;
        }
    }
    else if (endgame_fase == 2)
    {
        endgame_timer -= dt;

        if (endgame_timer <= 0)
            game_end();
    }
}