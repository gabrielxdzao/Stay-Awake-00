ja_aberto = false;
estado = 0; // 0 fechado | 1 abrindo | 2 aberto
image_speed = 0;


//frases
armario_vazio = choose("       onde esta","sem remedio","   nada aqui","estava aqui","  vazio","    ...");
armario_vazio2 = choose("preciso achar logo","cade meu remedio","socorro","vazio novamente");
spawn_remedio = choose("finalmente","finalmente remedio","achei","estava aqui");


// Esses sprites serão definidos no filho
spr_fechado = noone;
spr_fechado_outline = noone;
spr_abrindo = noone;
spr_abrindo_outline = noone;
spr_aberto = noone;

// ID único
id_obj = room_get_name(room) + ":" + string(x) + ":" + string(y);

// Persistência
if (instance_exists(obj_jogo))
{
    if (ds_list_find_index(obj_jogo.armarios_abertos_ids, id_obj) != -1)
    {
        ja_aberto = true;
        estado = 2;
    }

    var index = ds_list_find_index(obj_jogo.armarios_remedio_ids, id_obj);

    if (index != -1)
    {
        ja_aberto = true;
        estado = 2;

        var tipo_salvo = obj_jogo.armarios_remedio_tipos[| index];

        var r = instance_create_layer(x+32, y+30, "top", obj_remedio);
        r.tipo = tipo_salvo;
        r.id_origem = id_obj;
    }
}