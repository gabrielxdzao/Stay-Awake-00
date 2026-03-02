display_set_gui_size(512, 288);

spr_retrato_lucido   = spr_player_retrato_lucido;
spr_retrato_insano   = spr_player_retrato_insano;
spr_retrato_correndo = spr_player_retrato_cansado;
spr_retrato_morto    = spr_player_retrato_morto;

spr_retrato_atual = spr_retrato_lucido;

fala_atual = "";
mostrar_fala = false;
fala_timer = 0;


hud_altura = 120;
margem = 20;

mostrar_texto = function(_texto, _tempo)
{
    fala_atual = _texto;
    mostrar_fala = true;
    fala_timer = _tempo;
};
