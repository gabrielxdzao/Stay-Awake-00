audio_master_gain(0.3);
audio_play_sound(snd_lucido, 1, true); 
display_set_gui_size(512, 288);
snd_lucido_played = false; // Para controlar se o som já foi tocado
texto_intro = "Sua narcolepsia esta piorando, procure seus remedios e MANTENHA-SE ACORDADO!";

texto_visivel = "";

indice_letra = 0;
vel_texto = 0.04;
timer_texto = 0;

iniciou = false;
terminou = false;

fade_alpha = 0;
fade_speed = 2.5;
escurecendo = false;