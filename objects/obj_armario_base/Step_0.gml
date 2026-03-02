var player = obj_jogador;
var perto = false;

if (instance_exists(player))
{
    if (place_meeting(x, y, player))
    {
        // verifica se o centro do player está dentro da largura do armário
        if (player.x > bbox_left && player.x < bbox_right)
        {
            perto = true;
        }
    }
}


// FECHADO

if (estado == 0)
{
    image_speed = 0;

    if (perto)
        sprite_index = spr_fechado_outline;
    else
        sprite_index = spr_fechado;

    if (perto && keyboard_check_pressed(ord("E")))
    {
		if (obj_jogo.em_transicao || obj_jogo.jogo_bloqueado)
		return;
		
        if (!instance_exists(obj_jogo)) exit;
		
			if(obj_jogo.estado == ESTADO_JOGO.LUCIDEZ)
			{
				obj_hud.mostrar_texto(armario_vazio, 0.8);
			
				
				estado = 1;
				image_index = 0;
				image_speed = 1;
				return;
			}
		obj_hud.mostrar_texto(armario_vazio2, 0.8);
        estado = 1;
        image_index = 0;
        image_speed = 1;

        ja_aberto = true;

        if (ds_list_find_index(obj_jogo.armarios_abertos_ids, id_obj) == -1)
            ds_list_add(obj_jogo.armarios_abertos_ids, id_obj);

        obj_jogo.armarios_abertos += 1;

        // SISTEMA DE spawn
        var total = obj_jogo.total_armarios_ciclo;
        var abertos = obj_jogo.armarios_abertos;
        var restantes = total - abertos + 1;

        var spawnar = false;
        var tipo = 0;


        // CICLO 1 → sempre último
        if (obj_jogo.ciclo_atual == 1)
        {
            if (restantes == 1 && !obj_jogo.remedio_spawnado)
            {
                spawnar = true;
                tipo = 1;
            }
        }
        else
        {
            // CICLOS 2+

            if (!obj_jogo.remedio_spawnado)
            {
                // Se for o último, força spawn
                if (restantes == 1)
                {
                    spawnar = true;
                    tipo = 1;
                }
                else
                {
                    // Chance controlável
                    if (irandom(99) < obj_jogo.chance_remedio)
                    {
                        spawnar = true;
                        tipo = 1;
                    }
                }
            }


            // FALSOS
            if (!spawnar &&
                obj_jogo.permitir_falso &&
                obj_jogo.falsos_spawnados < obj_jogo.max_falsos_ciclo &&
                irandom(99) < obj_jogo.chance_falso)
            {
                spawnar = true;
                tipo = 2;
                obj_jogo.falsos_spawnados += 1;
				obj_hud.mostrar_texto(spawn_remedio, 0.8);
            }
        }

        // CRIAR ITEm
        if (spawnar)
        {
            var r = instance_create_layer(x+32, y+30, "top", obj_remedio);
            r.tipo = tipo;
            r.id_origem = id_obj;

            ds_list_add(obj_jogo.armarios_remedio_ids, id_obj);
            ds_list_add(obj_jogo.armarios_remedio_tipos, tipo);

            if (tipo == 1)
                obj_jogo.remedio_spawnado = true;
				obj_hud.mostrar_texto(spawn_remedio, 0.8);
        }
    }
}



// ABRINDO
if (estado == 1)
{
    var frame = image_index;

    if (perto)
        sprite_index = spr_abrindo_outline;
    else
        sprite_index = spr_abrindo;

    image_index = frame;

    if (image_index >= image_number - 1)
    {
        estado = 2;
        image_speed = 0;
    }
}



// ABERTO
if (estado == 2)
{
    sprite_index = spr_aberto;
    image_speed = 0;
}