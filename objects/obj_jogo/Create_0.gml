
audio_master_gain(0.8);

 #region

persistent = true;
depth = -1000;


//portas
portas_random_ativas = false;
chance_random_porta = 0; // 0 a 100


//// ENUM ESTADOS


enum ESTADO_JOGO { LUCIDEZ, INSANIDADE, COLAPSO }

estado = ESTADO_JOGO.LUCIDEZ;




// SANIDADE

sanidade_max = 100;
sanidade = sanidade_max;

vel_lucidez = 5;
vel_insanidade = 1;



/// TRANSIÇÃO


em_transicao = false;
tempo_transicao = 0;
tempo_transicao_max = 2;
vinheta_surface = 100;


//fade porta
fade_alpha = 1;
fade_speed = 2; // velocidade do clarear (por segundo)
fade_phase = 0; 
fade_delay = 0;       //tempo para ficar tela preta ajustado no room start
fade_delay_timer = 0;
room_pendente = noone;
entrada_pendente = "";

// trava o jogo durante fade
jogo_bloqueado = false;


/// SISTEMA DE REMÉDIOS

ciclo_atual = 1;
chance_remedio = 10;
chance_falso = 80;
max_falsos_ciclo = 0;

permitir_falso = false;

remedio_spawnado = false;

armarios_abertos = 0;
armarios_remedio_ids = ds_list_create();
armarios_remedio_tipos = ds_list_create();
armarios_abertos_ids = ds_list_create();

total_armarios_ciclo = 11; // ciclo 1

// lista simples de rooms possíveis
rooms_random = [rm_corredor, rm_cozinha, rm_sala, rm_escritorio, rm_banheiro];


// CONTROLE DA CRIATURA
criatura_timer = -1; // -1 significa inativo
chance_spawn_criatura = 50;
delay_spawn_min = 1;
delay_spawn_max = 2;

// endgame
endgame_ativo = false;
endgame_fade = 0;
endgame_fade_speed = 0.8;
endgame_fase = 0;
endgame_timer = 0;


#endregion

reiniciar_run = function()
{
    estado = ESTADO_JOGO.LUCIDEZ;
    sanidade = sanidade_max;

    em_transicao = false;
    jogo_bloqueado = false;

    criatura_existe = false;

    room_goto(rm_quarto);
};

trocar_room = function(_room, _entrada)
{
    if (fade_phase != 0) return;
    if (!room_exists(_room)) return;

    room_pendente = _room;
    entrada_pendente = _entrada;

    fade_alpha = 0;
    fade_delay_timer = fade_delay;

    fade_phase = 1;
};


iniciar_novo_ciclo = function()
{

    // RESET BÁSICO
    remedio_spawnado = false;
    armarios_abertos = 0;
    falsos_spawnados = 0;
    ciclo_atual += 1;
	rooms_random = [rm_corredor, rm_cozinha, rm_sala, rm_escritorio, rm_banheiro];

    // ESCALA DE DIFICULDADE
	estado = ESTADO_JOGO.LUCIDEZ;
	sanidade = sanidade_max;
    permitir_falso = true;


    // CONTROLE MANUAL DE FALSOS TOTAL DE ARMÁRIOS POR CICLO


    if (ciclo_atual == 1)
{
	//remedio_spawnado = false;
   // max_falsos_ciclo = 0;
   // total_armarios_ciclo = 9;
    //portas_random_ativas = false;
	rooms_random = [rm_corredor, rm_cozinha, rm_sala, rm_escritorio, rm_banheiro];
}
else if (ciclo_atual == 2)
{
	vel_lucidez = 10;
	vel_insanidade = 3;
    max_falsos_ciclo = 3;
    total_armarios_ciclo = 11;
    portas_random_ativas = true;
	chance_random_porta = 50;
	//rooms_random = [rm_corredor, rm_corredor, rm_corredor];
}
else if (ciclo_atual == 3)
{
	vel_lucidez = 20;
	vel_insanidade = 5;
    max_falsos_ciclo = 10;
    total_armarios_ciclo = 20;
    portas_random_ativas = true;
	chance_random_porta = 80;
}

    // LIMPA LISTAS GLOBAIS
 

    ds_list_clear(armarios_abertos_ids);
    ds_list_clear(armarios_remedio_ids);
    ds_list_clear(armarios_remedio_tipos);

    
    // RESET VISUAL DOS ARMÁRIOS NA ROOM ATUAL


    with (obj_armario_base)
    {
        ja_aberto = false;
        image_index = 0;
    }
};
