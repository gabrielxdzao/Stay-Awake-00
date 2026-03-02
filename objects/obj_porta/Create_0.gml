// IDs possíveis da sala destino
entradas_possiveis = ["corredor", "cozinha", "sala", "escritorio", "banheiro"];

interagir = function(_jogador)
{
	audio_play_sound(snd_porta_abrindo, 1, false);
    if (!instance_exists(obj_jogo)) return;

    var usar_random = false;

    if (obj_jogo.portas_random_ativas)
    {
        usar_random = (irandom(99) < obj_jogo.chance_random_porta);
    }

    // =========================
    // RANDOM
    // =========================
    if (usar_random)
    {
        var rooms = obj_jogo.rooms_random;

        if (array_length(rooms) <= 0) return;

        var destino_room = rooms[irandom(array_length(rooms) - 1)];

        // Evita cair na mesma room atual
        var tentativas = 0;
        while (destino_room == room && tentativas < 20)
        {
            destino_room = rooms[irandom(array_length(rooms) - 1)];
            tentativas++;
        }

        obj_jogo.trocar_room(destino_room, "RANDOM");
        return;
    }

    // =========================
    // NORMAL
    // =========================
    if (room_destino != noone)
    {
        obj_jogo.trocar_room(room_destino, id_spawn);
    }
};