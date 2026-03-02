
// --- TAMANHO LÓGICO DA CÂMERA (MUNDO) ---
//camera_width = 640; // Largura da área visível no mundo
//camera_height = 360; // Altura da área visível no mundo

camera_width = 512; // Largura da área visível no mundo
camera_height = 288; // Altura da área visível no mundo

//camera_width = 384; // Largura da área visível no mundo
//camera_height = 216; // Altura da área visível no mundo

//camera_width = 256; // Largura da área visível no mundo
//camera_height = 144; // Altura da área visível no mundo



offset_y = -50; // Valor negativo sobe a câmera (aumente para subir mais)

// --- OBJETO SEGUIDO ---
follow = obj_jogador; // Objeto que a câmera irá seguir



// --- POSIÇÃO INICIAL ---
if (instance_exists(follow)) { x = follow.x; y = follow.y; xTo = x; yTo = y; }
else { x = 0; y = 0; xTo = 0; yTo = 0; }



// --- SHAKE ---
canShake = 0; // Intensidade atual do shake
canShake_mag = 1; // Multiplicador do shake



// --- CRIA A CÂMERA ---
cam = camera_create_view(0, 0, camera_width, camera_height, 0, noone, -1, -1, camera_width * 0.5, camera_height * 0.5);



// --- ATIVA VIEWPORT ---
view_enabled = true;
view_visible[0] = true;
view_camera[0] = cam;



// --- VIEWPORT OCUPA A TELA TODA ---
view_wport[0] = window_get_width();
view_hport[0] = window_get_height();
view_xport[0] = 0;
view_yport[0] = 0;



// --- FORÇA POSIÇÃO INICIAL (EVITA FRAME ERRADO) ---
camera_set_view_pos(cam, x - camera_width * 0.5, y - camera_height * 0.5);