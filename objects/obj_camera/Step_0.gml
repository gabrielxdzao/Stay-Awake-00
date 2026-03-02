// Atualiza alvo
if (instance_exists(follow))
{
    xTo = follow.x;
    yTo = follow.y;
}


// MOVIMENTO SUAVE CENTRALIZADO

var target_x = xTo;
var target_y = yTo + offset_y;

// Smooth apenas na posição base
x = lerp(x, target_x, 0.1);
y = lerp(y, target_y, 0.1);


// SHAKE

var final_x = x;
var final_y = y;

if (canShake > 0.1)
{
    canShake = lerp(canShake, 0, 0.1);
    
    final_x += random_range(-canShake, canShake) * canShake_mag;
    final_y += random_range(-canShake, canShake) * canShake_mag;
}

// =============================
// APLICA NA CÂMERA
// =============================
camera_set_view_pos(
    view_camera[0],
    final_x - camera_width * 0.5,
    final_y - camera_height * 0.5
);