if (room == rm_quarto_fim)
{
    if (instance_exists(obj_jogador))
    {
        var j = obj_jogador;

        j.cutscene_final = true;
        j.visible = false;
        j.hsp = 0;
        j.vsp = 0;
    }
	return;
}


remedios_restantes = instance_number(obj_armario_base);

fade_alpha = 1;
fade_phase = 3;   // já começa clareando

// Só tenta spawnar se estiver em INSANIDADE ou COLAPSO
if (estado == ESTADO_JOGO.INSANIDADE || estado == ESTADO_JOGO.COLAPSO)
{
    
    if (!instance_exists(obj_criatura))
    {
        var spawn = instance_find(obj_criatura_spawn1, 0);

        if (spawn != noone)
        {
            var spawnar = false;

           
            if (estado == ESTADO_JOGO.COLAPSO)
            {
                if (irandom(99) < 50)
				spawnar = true;
            }
            else
            {
               

                var porcentagem = sanidade / sanidade_max;

                // Quanto menor a sanidade, maior a chance
                // 0 = 100% chance
                // 1.0 = chance mínima

                var chance_min = 30;  // quando quase cheio
                var chance_max = 50;  // quando quase zerando

                var chance_atual = lerp(chance_max, chance_min, porcentagem);

                if (irandom(99) < chance_atual)
                    spawnar = true;
            }

            
            if (spawnar)
            {
                instance_create_layer(spawn.x, spawn.y, "top", obj_criatura);
            }
        }
    }
}