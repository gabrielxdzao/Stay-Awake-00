image_speed = 0;
remedio_vazio = choose(" esta caixa vazia", "outra caixa vazia","nao sobrou um","estava vazio");
remedio_verdadeiro = choose("uffa","hora de dormir");

// tipo vem do armário
if (!variable_instance_exists(id, "tipo"))
    tipo = 1;


// CRESCIMENTO

image_xscale = 0.2;
image_yscale = 0.2;

escala_alvo = 1;
vel_crescimento = 3;

animando_spawn = true;


// FLUTUAÇÃO

float_amplitude = 2;
float_speed = 2;
float_timer = 0; // importante começar fixo


// BLOQUEIO INPUT

pode_interagir = false;
timer = 0.2;

estado = 0; 
// 0 = normal
// 1 = falso caindo

vsp = 0;
grav = 0.4;

girar = false;
giro = 4;
iniciou_pulo = false;