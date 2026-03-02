
estado_criatura = 0; // 0 spawn  1 perseguindo 2 indo porta 3 indo esconderijo  4 atacando

// MOVIMENTO
vel = 1.5;
tile_dist = 32;
estado_criatura = 0; // 0 spawn | 1 ativa | 2 ataque

ja_deu_dano = false;

sprite_spawn = spr_criatura_spawn;
sprite_idle  = spr_criatura_idle;
sprite_walk  = spr_criatura_walk;
sprite_attack = spr_criatura_death;

passo_restante = 0;
tempo_pausa = 0;
tempo_pausa_max = 0.4;

hsp = 0;
vsp = 0;

// FÍSICA
grav = 0.4;
vel_max_queda = 8;
colisor = obj_solido;

// DIREÇÃO
direcao = 1;

// "CEGUEIRA" (tempo para o player reagir)
tempo_cego = 0.1; //

// SPRITES
sprite_spawn  = spr_criatura_spawn;
sprite_idle   = spr_criatura_idle;
sprite_walk   = spr_criatura_walk;
sprite_attack = spr_criatura_death;

// EVOLUÇÃO CICLO
if (obj_jogo.ciclo_atual == 1 && obj_jogo.estado == ESTADO_JOGO.COLAPSO)
{
	vel = 1.8;
}

if (obj_jogo.ciclo_atual == 2)
{
	if (obj_jogo.estado == ESTADO_JOGO.COLAPSO)
	{
	vel = 2.4;	
	}else
	{
	 vel = 2;
	}
}
if (obj_jogo.ciclo_atual == 3)
{
	if (obj_jogo.estado == ESTADO_JOGO.COLAPSO)
	{
	vel = 3;
	}else
	{
	 vel = 2.5;
	}
}






// ALVOS
porta_saida = noone;
alvo_esconderijo = noone;

// COMEÇA SPAWNANDO
sprite_index = sprite_spawn;
image_index = 0;
image_speed = 1;