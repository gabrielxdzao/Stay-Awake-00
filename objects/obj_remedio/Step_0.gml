var dt = delta_time / 1000000;


// CRESCER

if (animando_spawn)
{
    image_xscale = lerp(image_xscale, escala_alvo, vel_crescimento * dt);
    image_yscale = image_xscale;

    if (abs(image_xscale - escala_alvo) < 0.01)
    {
        image_xscale = escala_alvo;
        image_yscale = escala_alvo;
        animando_spawn = false;
    }
}
else if (estado == 0)
{
    float_timer += float_speed * dt;
}


// LIBERAR INPUT

if (!pode_interagir)
{
    timer -= dt;
    if (timer <= 0)
        pode_interagir = true;
}


// BORDA

if (estado == 0)
{
    if (place_meeting(x, y, obj_jogador) && pode_interagir)
        image_index = 0; // com borda
    else
        image_index = 1; // normal
}


// INTERAÇÃO

if (estado == 0 && pode_interagir && place_meeting(x, y, obj_jogador))
{
    if (keyboard_check_pressed(ord("E")))
    {
        if (tipo == 1)
{
	obj_hud.mostrar_texto(remedio_verdadeiro, 0.8);
    if (instance_exists(obj_jogo))
    {
        var index = ds_list_find_index(obj_jogo.armarios_remedio_ids, id_origem);

        if (index != -1)
        {
            ds_list_delete(obj_jogo.armarios_remedio_ids, index);
            ds_list_delete(obj_jogo.armarios_remedio_tipos, index);
        }

        obj_jogo.sanidade = obj_jogo.sanidade_max;
        obj_jogo.iniciar_novo_ciclo();

        // Spawn na cama
        obj_jogador.entrada_destino = "cama";
        obj_jogo.trocar_room(rm_quarto, "cama");
    }

    instance_destroy();
}
        else
        {
            // FALSO

    if (instance_exists(obj_jogo))
    {
        var index = ds_list_find_index(obj_jogo.armarios_remedio_ids, id_origem);

        if (index != -1)
        {
            ds_list_delete(obj_jogo.armarios_remedio_ids, index);
            ds_list_delete(obj_jogo.armarios_remedio_tipos, index);
        }
    }

    estado = 1;
        }
    }
}


// FALSO CAINDO

if (estado == 1)
{
	
	obj_hud.mostrar_texto(remedio_vazio, 0.8);
    // Inicializa pulo apenas uma vez
    if (!iniciou_pulo)
    {
        vsp = -6;         
        giro = choose(-4,4);
        girar = true;
        iniciou_pulo = true;
    }

    // ROTACIONA
    if (girar)
        image_angle += giro;

    // GRAVIDADE
    vsp += grav;

    if (vsp > 7)
        vsp = 7;

    // MOVIMENTO
    y += vsp;

    // TOCOU NO CHÃO
    if (vsp > 0 && place_meeting(x, y + 1, obj_solido))
    {
        vsp = 0;
        girar = false;

        // Começa desaparecer
        image_alpha -= 0.05;

        if (image_alpha <= 0)
        {
            instance_destroy();
        }
    }
}