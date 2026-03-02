if (!instance_exists(obj_jogo)) exit;

if (obj_jogo.ciclo_atual >= 3 && obj_jogo.estado == ESTADO_JOGO.COLAPSO)
{
    ativa = true;
    visible = true;
}
else
{
    ativa = false;
    visible = false;
}






