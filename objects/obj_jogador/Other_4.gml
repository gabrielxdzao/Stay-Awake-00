
visible = true;


if (!variable_instance_exists(id, "entrada_destino"))
    entrada_destino = "";

if (entrada_destino != "")
{
   
    // SPAWN RANDOM
 
    if (entrada_destino == "RANDOM")
	{
    var lista = [];

    with (obj_ponto_entrada)
    {
        // cria lista de pontos válidos (evita voltar no mesmo id_entrada de onde saiu)
        if (id_entrada != other.ultimo_spawn)
            array_push(lista, id);
    }

    // se não sobrou nenhum (ex: sala só tem 1 ponto), libera qualquer um
    if (array_length(lista) == 0)
    {
        with (obj_ponto_entrada)
            array_push(lista, id);
    }

    if (array_length(lista) > 0)
    {
        var ponto = lista[irandom(array_length(lista) - 1)];
        x = ponto.x;
        y = ponto.y;
    }
}
    else
    {
        // =========================
        // SPAWN NORMAL
        // =========================
        with (obj_ponto_entrada)
        {
            if (id_entrada == other.entrada_destino)
            {
                other.x = x;
                other.y = y;
            }
        }
    }

    entrada_destino = "";
}