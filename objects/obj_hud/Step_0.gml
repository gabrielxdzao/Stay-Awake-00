var dt = delta_time / 1000000;

if (mostrar_fala)
{
    fala_timer -= dt;
    if (fala_timer <= 0)
    {
        mostrar_fala = false;
        fala_atual = "";
    }
}

if (instance_exists(obj_jogo) && instance_exists(obj_jogador))
{
    var j = obj_jogador;

    if (obj_jogo.estado == ESTADO_JOGO.INSANIDADE)
    {
        spr_retrato_atual = spr_retrato_insano;
    }
    else if (j.correndo && j.stamina < j.stamina_max * 0.3)
    {
        spr_retrato_atual = spr_retrato_correndo;
    }
	else if (j.exausto)
	{
    spr_retrato_atual = spr_retrato_correndo;
	}
    else if (j.morto)
    {
        spr_retrato_atual = spr_retrato_morto;
    }
	else
	{
		spr_retrato_atual = spr_retrato_lucido;
	}
}