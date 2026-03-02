if (!instance_exists(obj_jogo)) exit;

if (obj_jogo.estado != ESTADO_JOGO.INSANIDADE && obj_jogo.estado != ESTADO_JOGO.COLAPSO)
{
    instance_destroy();
    exit;
}

var dt = delta_time / 1000000;

// fase spawn
if (estado_criatura == 0)
{
    if (image_index >= image_number - 1)
    {
        estado_criatura = 1;
        sprite_index = sprite_idle;
        image_index = 0;
        image_speed = 1;
    }
    exit;
}

// fase ataque
if (estado_criatura == 2)
{
    hsp = 0;
    vsp = 0;

    if (!ja_deu_dano && instance_exists(obj_jogador))
    {
        obj_jogador.tomar_dano();
        ja_deu_dano = true;
    }

    if (image_index >= image_number - 1)
    {
        instance_destroy();
    }

    exit;
}

// colisão com player inicia ataque
if (instance_exists(obj_jogador))
{
    var j = obj_jogador;

    if (place_meeting(x, y, j))
    {
        if (j.escondido)
        {
            if (variable_instance_exists(j, "sair_esconderijo_forcado"))
                j.sair_esconderijo_forcado();
        }

        estado_criatura = 2;
        sprite_index = sprite_attack;
		audio_play_sound(snd_attack, 1, false);
        image_index = 0;
        image_speed = 1;
        exit;
    }
}

// gravidade
if (!place_meeting(x,y+1,obj_solido))
{
    vsp += grav;
    if (vsp > vel_max_queda) vsp = vel_max_queda;
}
else if (vsp > 0) vsp = 0;

if (!place_meeting(x,y+vsp,obj_solido)) y += vsp;
else vsp = 0;

// movimento tile
if (tempo_pausa > 0)
{
    tempo_pausa -= dt;
    hsp = 0;
}
else
{
    if (passo_restante <= 0)
    {
        passo_restante = tile_dist;
        tempo_pausa = tempo_pausa_max;
        hsp = 0;
    }

    if (instance_exists(obj_jogador))
    {
        var dir = sign(obj_jogador.x - x);
        if (dir != 0) direcao = dir;

        hsp = direcao * vel;

        if (!place_meeting(x+hsp,y,obj_solido))
        {
            x += hsp;
            passo_restante -= abs(hsp);
        }
        else
        {
            passo_restante = 0;
            tempo_pausa = tempo_pausa_max;
            hsp = 0;
        }
    }
}
if (abs(hsp) > 0 && !audio_is_playing(snd_criatura_walk))
    audio_play_sound(snd_criatura_walk, 1, true);
else if (abs(hsp) == 0 && audio_is_playing(snd_criatura_walk))
    audio_stop_sound(snd_criatura_walk);
// sprites movimento
if (abs(hsp) > 0)
{
    if (sprite_index != sprite_walk)
    {
        sprite_index = sprite_walk;
        image_index = 0;
    }
}
else
{
    if (sprite_index != sprite_idle)
    {
        sprite_index = sprite_idle;
        image_index = 0;
    }
}

image_xscale = direcao;


/*
if (!instance_exists(obj_jogo)) exit;

var dt = delta_time / 1000000;

if (!instance_exists(obj_jogador)) exit;
var j = obj_jogador;


if (estado_criatura == 0)
{
    if (image_index >= image_number - 1)
    {
        estado_criatura = 1;
        sprite_index = sprite_idle;
        image_index = 0;
        image_speed = 1;
    }
    exit;
}

var pode_enxergar = (tempo_cego <= 0);
if (tempo_cego > 0) tempo_cego -= dt;


if (!j.escondido)
{
    if (estado_criatura != 1 && estado_criatura != 4)
    {
        estado_criatura = 1;
        alvo_esconderijo = noone;
        porta_saida = noone;

        passo_restante = 0;
        tempo_pausa = 0;
        hsp = 0;
    }
}

if (pode_enxergar && j.escondido && estado_criatura == 1)
{
    if (point_distance(x, y, j.x, j.y) < 128)
    {
        estado_criatura = 3;
        alvo_esconderijo = j.esconderijo_atual;
        porta_saida = noone;

        passo_restante = 0;
        tempo_pausa = 0;
        hsp = 0;
    }
    else
    {
        estado_criatura = 2;
        alvo_esconderijo = noone;

        if (instance_exists(obj_porta))
        {
            var qtdp = instance_number(obj_porta);
            porta_saida = instance_find(obj_porta, irandom(qtdp - 1));
        }

        passo_restante = 0;
        tempo_pausa = 0;
        hsp = 0;
    }
}


if (!place_meeting(x, y + 1, colisor))
{
    vsp += grav;
    if (vsp > vel_max_queda) vsp = vel_max_queda;
}
else if (vsp > 0)
{
    vsp = 0;
}

if (!place_meeting(x, y + vsp, colisor))
    y += vsp;
else
    vsp = 0;


if (estado_criatura == 1 || estado_criatura == 2 || estado_criatura == 3)
{
    if (tempo_pausa > 0)
    {
        tempo_pausa -= dt;
        hsp = 0;
    }
    else
    {
        if (passo_restante <= 0)
        {
            passo_restante = tile_dist;
            tempo_pausa = tempo_pausa_max;
        }

        var alvo_x = x;

        if (estado_criatura == 1)
            alvo_x = j.x;

        if (estado_criatura == 2 && porta_saida != noone)
            alvo_x = porta_saida.x;

        if (estado_criatura == 3 && alvo_esconderijo != noone)
            alvo_x = alvo_esconderijo.x;

        var dir = sign(alvo_x - x);
        if (dir != 0) direcao = dir;

        hsp = direcao * vel;

        if (!place_meeting(x + hsp, y, colisor))
        {
            x += hsp;
            passo_restante -= abs(hsp);
        }
        else
        {
            passo_restante = 0;
            tempo_pausa = tempo_pausa_max;
            hsp = 0;
        }
    }
}


if (estado_criatura == 3 && alvo_esconderijo != noone)
{
    if (point_distance(x, y, alvo_esconderijo.x, alvo_esconderijo.y) < 10)
    {
        estado_criatura = 4;
        sprite_index = sprite_attack;
        image_index = 0;
        image_speed = 1;
        hsp = 0;
    }
}


if (estado_criatura == 4)
{
    if (image_index >= image_number - 1)
    {
        // se ainda está escondido, puxa e mata
        if (j.escondido)
        {
            j.escondido = false;
            j.visible = true;

            if (instance_exists(alvo_esconderijo))
                alvo_esconderijo.estado = 0;

            j.esconderijo_atual = noone;

            j.vida = 0;
            j.tomar_dano();
			obj_hud.mostrar_texto("Ahhgh", 0.40);

            instance_destroy();
            exit;
        }
        else
        {
            // se ele j saiu do esconderijo, volta a perseguir
            estado_criatura = 1;
            alvo_esconderijo = noone;
            porta_saida = noone;

            passo_restante = 0;
            tempo_pausa = 0;
            hsp = 0;

            sprite_index = sprite_walk;
            image_index = 0;
        }
    }
    image_xscale = direcao;
    exit;
}

if (estado_criatura == 2 && porta_saida != noone)
{
    if (point_distance(x, y, porta_saida.x, porta_saida.y) < 14)
    {
        instance_destroy();
        exit;
    }
}

if (abs(hsp) > 0)
{
    if (sprite_index != sprite_walk)
    {
        sprite_index = sprite_walk;
        image_index = 0;
    }
}
else
{
    if (sprite_index != sprite_idle)
    {
        sprite_index = sprite_idle;
        image_index = 0;
    }
}

image_xscale = direcao;