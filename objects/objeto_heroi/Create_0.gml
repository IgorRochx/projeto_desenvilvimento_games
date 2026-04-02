window_set_size(1280, 720)

xsp=0;
ysp=0;
grav=1; // 1 = gravidade normal (pra baixo), -1 = invertida (pra cima)

// Dash (colega)
dash_speed = 8;
dash_duration = 12;
dash_timer = 0;
is_dashing = false;
dir_dash = 1; // 1 = direita, -1 = esquerda

cooldown_max = 40;
cooldown_timer = 0;

dash_in_air = false;