var porcentagem = sanidade / sanidade_max;
// EFEIO DE VINHETA SE A SANIDADE ESTIVER BAIXA
if (estado == ESTADO_JOGO.LUCIDEZ && porcentagem < 0.5) // Se a sanidade for menor que 50%
{
    var intensidade = (0.5 - porcentagem) / 0.5; // Calcula a intensidade do escurecimento
    intensidade = clamp(intensidade, 0, 1); // Limita a intensidade entre 0 e 1

    var w = display_get_gui_width(); // Largura da tela
    var h = display_get_gui_height(); // Altura da tela

    // Se a surface da vinheta não existe ou mudou de tamanho, recria
    if (!surface_exists(vinheta_surface) || surface_get_width(vinheta_surface) != w || surface_get_height(vinheta_surface) != h)
    {
        if (surface_exists(vinheta_surface)) surface_free(vinheta_surface); // Libera a surface anterior
        vinheta_surface = surface_create(w, h); // Cria uma nova surface para a vinheta
    }

    surface_set_target(vinheta_surface); // Define a surface para desenhar
    draw_clear_alpha(c_black, 0); // Limpa a surface com transparência

    // Desenha um escurecimento gradativo na tela
    draw_set_colour(c_black);
    draw_set_alpha(intensidade * 0.85); // Ajusta a intensidade do escurecimento
    draw_rectangle(0, 0, w, h, false); // Desenha o fundo escuro

    // Posição do jogador na tela (para o efeito de vinheta radial)
    var cam = view_camera[0];
    var px = (obj_jogador.x - camera_get_view_x(cam)) * (w / camera_get_view_width(cam));
    var py = (obj_jogador.y - 32 - camera_get_view_y(cam)) * (h / camera_get_view_height(cam));

    var raio = lerp(600, 10, intensidade); // Ajusta o raio do efeito dependendo da intensidade

    // Desenha um degradê radial
    draw_set_alpha(1);
    draw_primitive_begin(pr_trianglefan); // Inicia a primitiva para o degradê radial
    draw_vertex_colour(px, py, c_black, 0); // Ponto central do degradê

    var passos = 40; // Quantidade de segmentos do degradê
    for (var i = 0; i <= passos; i++) // Desenha os pontos do degradê
    {
        var ang = i / passos * 360; // Ângulo para o ponto
        var xx = px + lengthdir_x(raio, ang); // Calcula a posição X
        var yy = py + lengthdir_y(raio, ang); // Calcula a posição Y
        draw_vertex_colour(xx, yy, c_black, intensidade); // Desenha o ponto
    }

    draw_primitive_end(); // Finaliza a primitiva

    surface_reset_target(); // Reseta a surface para o normal

    draw_surface(vinheta_surface, 0, 0); // Desenha a surface da vinheta na tela
}



/// HUD TRANSIcaO — EFEITOS DE TRANSICAO
if (em_transicao) // Se estiver em transição
{
    var t = tempo_transicao / tempo_transicao_max; // Calcula a porcentagem da transição

    // Fade escuro (escurece a tela conforme a transição)
    //draw_set_colour(c_black);
    draw_set_alpha(1 - t); // Quanto mais o tempo passa, menos escuro
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

    // Flash branco rápido no início da transição
    if (t > 0.7)
    {
        draw_set_colour(c_black);
        draw_set_alpha((t - 0.7) * 5); // Intensifica o flash conforme o tempo
        draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    }

    draw_set_alpha(1); // Reseta a transparência
}


if (fade_alpha > 0)
{
    draw_set_alpha(fade_alpha);
    draw_set_colour(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
}

if (endgame_ativo)
{
    draw_set_colour(c_white);
    draw_set_alpha(endgame_fade);
    draw_rectangle(0,0,display_get_gui_width(),display_get_gui_height(),false);
    draw_set_alpha(1);
}