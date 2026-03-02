var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var hud_offset_x = 0;
var hud_offset_y = 0;

var bg_w = sprite_get_width(spr_background_hud);
var bg_h = sprite_get_height(spr_background_hud);

var hud_x = hud_offset_x;
var hud_y = gui_h - bg_h + hud_offset_y;

// fundo
draw_sprite(spr_background_hud,0,hud_x,hud_y);
draw_sprite(spr_moldura_hud,0,hud_x,hud_y);

// foto
var foto_offset_x = 7;
var foto_offset_y = 7;

var foto_x = hud_x + foto_offset_x;
var foto_y = hud_y + foto_offset_y;

draw_sprite(spr_foto_jogador_moldura,0,foto_x,foto_y);
draw_sprite(spr_retrato_atual,0,foto_x,foto_y);

// vida
if (instance_exists(obj_jogador))
{
    var j = obj_jogador;

    var vida_offset_x = 200;
    var vida_offset_y = 2;

    var vida_x = hud_x + vida_offset_x;
    var vida_y = hud_y + vida_offset_y;

    var spr_vida;

    if (j.vida >= 2) spr_vida = spr_vida_cheia;
    else if (j.vida == 1) spr_vida = spr_vida_metade;
    else spr_vida = spr_vida_vazia;

    draw_sprite(spr_vida,floor(current_time/120) mod sprite_get_number(spr_vida),vida_x,vida_y);
}

// barra stamina
var stamina_offset_x = 290;
var stamina_offset_y = 15;

var stamina_x = hud_x + stamina_offset_x;
var stamina_y = hud_y + stamina_offset_y;

draw_sprite(spr_barra_stamina_moldura,0,stamina_x,stamina_y);

// barra sanidade
var sanidade_offset_x = 280;
var sanidade_offset_y = 33;

var sanidade_x = hud_x + sanidade_offset_x;
var sanidade_y = hud_y + sanidade_offset_y;

if (obj_jogo.estado == ESTADO_JOGO.LUCIDEZ) draw_sprite(spr_barra_lucidez_moldura,0,sanidade_x,sanidade_y);
else if (obj_jogo.estado == ESTADO_JOGO.INSANIDADE) draw_sprite(spr_barra_insanidade_moldura,0,sanidade_x,sanidade_y);
else draw_sprite(spr_colapso_moldura,0,sanidade_x,sanidade_y);

// preenchimento barras
if (instance_exists(obj_jogador) && instance_exists(obj_jogo))
{
    var j = obj_jogador;

    var pct_stamina = clamp(j.stamina / j.stamina_max,0,1);
    var bar_w = sprite_get_width(spr_barra_stamina);
    var bar_h = sprite_get_height(spr_barra_stamina);
    draw_sprite_part(spr_barra_stamina,0,0,0,bar_w*pct_stamina,bar_h,stamina_x,stamina_y);

    if (obj_jogo.estado != ESTADO_JOGO.COLAPSO)
    {
        var pct_san = clamp(obj_jogo.sanidade / obj_jogo.sanidade_max,0,1);
        var spr_barra = (obj_jogo.estado == ESTADO_JOGO.LUCIDEZ) ? spr_barra_lucidez : spr_barra_insanidade;
        var san_w = sprite_get_width(spr_barra);
        var san_h = sprite_get_height(spr_barra);
        draw_sprite_part(spr_barra,0,0,0,san_w*pct_san,san_h,sanidade_x,sanidade_y);
    }
}

// texto barras
draw_set_font(fnt_hud);
draw_set_valign(fa_bottom);
draw_set_halign(fa_center);

if (instance_exists(obj_jogador))
{
    var j = obj_jogador;
    var centro_stamina = stamina_x + sprite_get_width(spr_barra_stamina_moldura)*0.5;

    if (j.exausto && floor(current_time/150) mod 2 == 0) draw_set_colour(c_red);
    else draw_set_colour(c_white);

    draw_text(centro_stamina,stamina_y-2,"Folego");
}

var texto_estado = "";
var cor_estado = c_white;
var tremor_x = 0;
var tremor_y = 0;

if (obj_jogo.estado == ESTADO_JOGO.LUCIDEZ)
{
    texto_estado = "Sono";
    cor_estado = c_white;
}
else if (obj_jogo.estado == ESTADO_JOGO.INSANIDADE)
{
    texto_estado = "Pesadelo";
    cor_estado = c_red;
}
else
{
    texto_estado = "Colapso";
    cor_estado = c_white;
    tremor_x = irandom_range(-1,1);
    tremor_y = irandom_range(-1,1);
}

var largura_moldura = (obj_jogo.estado == ESTADO_JOGO.COLAPSO) ? sprite_get_width(spr_colapso_moldura) : sprite_get_width(spr_barra_lucidez_moldura);
var centro_sanidade = sanidade_x + largura_moldura*0.5;

draw_set_colour(cor_estado);
draw_text(centro_sanidade+tremor_x,sanidade_y-2+tremor_y,texto_estado);

// balao
var balao_offset_x = 74;
var balao_offset_y = 6;

var balao_x = hud_x + balao_offset_x;
var balao_y = hud_y + balao_offset_y;

if (mostrar_fala)
{
    draw_sprite(spr_balao_fala_jogador,0,balao_x,balao_y);
    var pad_x = 8;
    var pad_y = 4;
    var texto_w = sprite_get_width(spr_balao_fala_jogador)-pad_x;
    draw_set_colour(c_black);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text_ext(balao_x+pad_x,balao_y+pad_y,fala_atual,15,texto_w);
}