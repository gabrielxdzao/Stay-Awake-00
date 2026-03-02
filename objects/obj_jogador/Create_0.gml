

colisor = obj_solido;

entrada_destino = "";
ultimo_spawn = "";


// MOVIMENTO HORIZONTAL
vel_andar = 1.5;
//vel_andar = 5;
acel = 0.35;
atrito = 0.25;

hsp = 0;
vsp = 0;

no_chao = false;
direcao = 1;


// FÍSICA (SEM PULO)

grav = 0.35;
vel_max_queda = 9;


// VIDA

vida = 2;

em_hit = false;
tempo_hit = 0;
tempo_hit_max = 0.25;

knockback_forca = 4;
knockback_vertical = 5;

morto = false;

invencivel = false;
tempo_invencivel = 0;
tempo_invencivel_max = 1;


// ESTAMINA

stamina_max = 100;
stamina = stamina_max;

gasto_corrida = 50;
regen_andando = 10;
regen_parado  = 25;

correndo = false;
exausto = false;


// ESCONDERIJO
escondido = false;
esconderijo_atual = noone;




// SPRITES

spr_idle   = spr_jogador_idle;
spr_run    = spr_jogador_run;
spr_morto  = spr_jogador_morto;
spr_insane = spr_jogador_insane_animation;
spr_hit    = spr_jogador_hit;




// Verifica se o jogador apertou E
// e está em cima de uma porta
verificar_interacao = function()
{
    if (!keyboard_check_pressed(ord("E"))) return;

    // Procura uma porta na mesma posição
    var porta = instance_place(x, y, obj_porta);

    if (porta != noone)
    {
        // Chama a função da porta
        porta.interagir(id);
    }
};

atualizar_estamina = function(_movendo)
{
    var dt = delta_time / 1000000;

    // verifica se está pressionando contra a parede
    var contra_parede =
        (keyboard_check(vk_right) || keyboard_check(ord("D"))) && place_meeting(x + 1, y, colisor)
        ||
        (keyboard_check(vk_left) || keyboard_check(ord("A"))) && place_meeting(x - 1, y, colisor);

    if (exausto)
    {
        if (_movendo)
            stamina += regen_andando * dt;
        else
            stamina += regen_parado * dt;

        stamina = clamp(stamina, 0, stamina_max);

        if (stamina >= stamina_max)
            exausto = false;

        correndo = false;
        return;
    }

    var segurando_corrida = keyboard_check(vk_shift);
    correndo = false;

    if (segurando_corrida && _movendo && stamina > 0 && !contra_parede)
    {
        correndo = true;
        stamina -= gasto_corrida * dt;

        if (stamina <= 0)
        {
			obj_hud.mostrar_texto("melhor eu descansar", 3);
            stamina = 0;
            exausto = true;
            correndo = false;
        }
    }
    else
    {
        if (_movendo)
            stamina += regen_andando * dt;
        else
            stamina += regen_parado * dt;

        stamina = clamp(stamina, 0, stamina_max);
    }
};

esta_no_chao = function()
{
    return place_meeting(x, y + 1, colisor);
};

aplicar_gravidade = function()
{
    if (!esta_no_chao())
    {
        vsp += grav;

        if (vsp > vel_max_queda)
            vsp = vel_max_queda;
    }
    else if (vsp > 0)
    {
        vsp = 0;
    }
};

ler_input = function()
{
    var move = 0;

    move += keyboard_check(vk_right);
    move -= keyboard_check(vk_left);
    move += keyboard_check(ord("D"));
    move -= keyboard_check(ord("A"));

    move = clamp(move, -1, 1);

    if (move != 0)
        direcao = sign(move);

    return move;
};

atualizar_horizontal = function(_move)
{
    var velocidade_base = vel_andar;

    if (exausto)
        velocidade_base *= 0.6;
    else if (correndo)
        velocidade_base *= 1.6;

    var alvo = _move * velocidade_base;

    hsp = lerp(hsp, alvo, acel);

    if (_move == 0 && no_chao)
    {
        hsp = lerp(hsp, 0, atrito);
        if (abs(hsp) < 0.05)
            hsp = 0;
    }
};

mover_e_colidir = function()
{
    var dx = hsp;

    if (place_meeting(x + dx, y, colisor))
    {
        var step = sign(dx);
        while (step != 0 && !place_meeting(x + step, y, colisor))
            x += step;
        hsp = 0;
    }
    else
        x += dx;

    var dy = vsp;

    if (place_meeting(x, y + dy, colisor))
    {
        var stepy = sign(dy);
        while (stepy != 0 && !place_meeting(x, y + stepy, colisor))
            y += stepy;
        vsp = 0;
    }
    else
        y += dy;
};

//VIDA / DANO
tomar_dano = function()
{
	if (obj_jogo.jogo_bloqueado) return;
    if (invencivel || morto) return;

    vida -= 1;

    if (vida <= 0)
    {
        morto = true;
        hsp = 0;
        vsp = 0;
        return;
    }

    // ativa estado de hit
    em_hit = true;
    tempo_hit = tempo_hit_max;

    // empurra para trás (oposto da direção que está olhando)
    hsp = -direcao * knockback_forca;
    vsp = -knockback_vertical;

    invencivel = true;
    tempo_invencivel = tempo_invencivel_max;
};

atualizar_dano = function()
{
    if (invencivel)
    {
        tempo_invencivel -= delta_time / 1000000;

        if (tempo_invencivel <= 0)
            invencivel = false;
    }
};

entrar_ou_sair_esconderijo = function()
{
    if (!keyboard_check_pressed(ord("E"))) return;
    if (morto || em_hit) return;
    if (!instance_exists(obj_jogo)) return;

    // Só pode usar em INSANIDADE
    if (obj_jogo.estado != ESTADO_JOGO.INSANIDADE)
        return;

    // SAIR
    if (escondido)
    {
        escondido = false;
		obj_hud.mostrar_texto("preciso procurar meu remedio", 1.2);
        if (instance_exists(esconderijo_atual))
            esconderijo_atual.estado = 0;

        esconderijo_atual = noone;
        visible = true;
        return;
    }

    // ENTRAR
    var esc = instance_place(x, y, obj_esconderijo_base);

    if (esc != noone)
    {
		obj_hud.mostrar_texto("que local apertado", 1.2);
        escondido = true;
        esconderijo_atual = esc;

        esconderijo_atual.estado = 1; 

        visible = false;
        hsp = 0;
        vsp = 0;
    }
};
//SPRITES
atualizar_sprite = function()
{
	if (em_hit)
	{
    sprite_index = spr_hit;
    image_speed = 0;
    image_xscale = direcao;
    return;
	}
	
    if (morto)
    {
        sprite_index = spr_morto;
        image_speed = 0.2;
		
        return;
    }

    var apertando =
        keyboard_check(vk_left)  ||
        keyboard_check(vk_right) ||
        keyboard_check(ord("A")) ||
        keyboard_check(ord("D"));

    if (apertando && no_chao)
    {
        sprite_index = spr_run;
        image_speed = keyboard_check(vk_shift) ? 1.6 : 0.8;
    }
    else
    {
        sprite_index = spr_idle;
        image_speed = 0.5;
    }

    image_xscale = direcao;
};

///LOOP PRINCIPAL
atualizar = function() 
{
    atualizar_dano();

    no_chao = place_meeting(x, y + 1, colisor);

    if (em_hit)
    {
        tempo_hit -= delta_time / 1000000;
        if (tempo_hit <= 0)
            em_hit = false;
    }

    var bloqueado = obj_jogo.em_transicao || obj_jogo.jogo_bloqueado || morto || em_hit || escondido;

    var move = 0;

    if (!bloqueado)
        move = ler_input();

    if (!bloqueado)
        atualizar_estamina(move != 0 && no_chao);
    else
        correndo = false;

    if (!bloqueado)
        atualizar_horizontal(move);
    else if (!em_hit)
        hsp = 0;

    if (em_hit)
        hsp = lerp(hsp, 0, 0.08);

    if (!escondido)
    {
        if (!no_chao)
        {
            vsp += grav;
            if (vsp > vel_max_queda)
                vsp = vel_max_queda;
        }
        else if (vsp > 0)
        {
            vsp = 0;
        }

        mover_e_colidir();
    }
    else
    {
        hsp = 0;
        vsp = 0;
    }

    if (obj_jogo.em_transicao)
    {
        sprite_index = spr_insane;
        image_speed = 1;

        if (image_index >= image_number - 1)
            image_speed = 0;
    }
    else if (morto)
    {
        if (sprite_index != spr_morto)
        {
            sprite_index = spr_morto;
            image_index = 0;
        }

        image_speed = 0.2;

        if (image_index >= image_number - 1)
        {
            image_speed = 0;

            if (instance_exists(obj_jogo))
                obj_jogo.player_morreu = true;
        }

        image_xscale = direcao;
    }
    else
    {
        atualizar_sprite();
        entrar_ou_sair_esconderijo();
        verificar_interacao();
    }
};