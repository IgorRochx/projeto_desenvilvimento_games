// Cooldown do dash
if (cooldown_timer > 0) cooldown_timer--;

// Gravidade com limite, so aplicada fora do dash
if (!is_dashing)
{
    ysp = clamp(ysp + (0.3 * grav), -10, 10);
}

// Movimento horizontal
xsp = 0;
if (keyboard_check(ord("A"))) { xsp = -2; dir_dash = -1; image_xscale = -1; }
if (keyboard_check(ord("D"))) { xsp =  2; dir_dash =  1; image_xscale =  1; }

// Chao/teto e pulo (respeita direcao da gravidade)
var on_ground = place_meeting(x, y + grav, objeto_bloco_terra) || place_meeting(x, y + grav, Objeto_predio);

if (on_ground)
{
    ysp = 0;
    dash_in_air = false;
    can_double_jump = true;
    if keyboard_check_pressed(ord("W")) ysp = -8.5 * grav;
}
else
{
    // Pulo duplo no ar
    if keyboard_check_pressed(ord("W")) && can_double_jump
    {
        ysp = -6.5 * grav;
        can_double_jump = false;
    }
}

// Dash com Z
if keyboard_check_pressed(vk_space) && cooldown_timer == 0 && !is_dashing
{
    var can_dash = on_ground || !dash_in_air;

    if (can_dash)
    {
        is_dashing = true;
        dash_timer = dash_duration;
        cooldown_timer = cooldown_max;

        // Captura direcao do dash baseado nas teclas pressionadas
        var dash_dx = 0;
        var dash_dy = 0;
        if (keyboard_check(ord("A"))) dash_dx = -1;
        if (keyboard_check(ord("D"))) dash_dx =  1;
        if (keyboard_check(ord("W"))) dash_dy = -1 * grav;
        if (keyboard_check(ord("S"))) dash_dy =  1 * grav;

        // Se nenhuma direcao pressionada, usa a ultima direcao horizontal
        if (dash_dx == 0 && dash_dy == 0) dash_dx = dir_dash;

        // Normaliza para manter velocidade consistente na diagonal
        var dash_len = sqrt(dash_dx * dash_dx + dash_dy * dash_dy);
        dash_dir_x = dash_dx / dash_len;
        dash_dir_y = dash_dy / dash_len;

        ysp = 0;
        xsp = 0;
        if (!on_ground) dash_in_air = true;
    }
}

// Executar dash
if (is_dashing)
{
    xsp = dash_speed * dash_dir_x;
    ysp = dash_speed * dash_dir_y;
    dash_timer--;
    if (dash_timer <= 0)
    {
        is_dashing = false;
        xsp = 0;
        ysp = 0;
    }
}

// Colisao horizontal (bloco + muro)
if (place_meeting(x + xsp, y, objeto_bloco_terra) || place_meeting(x + xsp, y, Objeto_predio))
{
    while (!place_meeting(x + sign(xsp), y, objeto_bloco_terra) && !place_meeting(x + sign(xsp), y, Objeto_predio))
    {
        x += sign(xsp);
    }
    xsp = 0;
    is_dashing = false;
}
x += xsp;

// Colisao vertical (bloco + muro)
if (place_meeting(x, y + ysp, objeto_bloco_terra) || place_meeting(x, y + ysp, Objeto_predio))
{
    while (!place_meeting(x, y + sign(ysp), objeto_bloco_terra) && !place_meeting(x, y + sign(ysp), Objeto_predio))
    {
        y += sign(ysp);
    }
    ysp = 0;
}
y += ysp;

// Morte: tocou no cone = reinicia fase
if place_meeting(x, y, objeto_cone)
{
    room_restart();
}

// Morte: caiu fora da tela (abaixo ou acima)
if (y > room_height + 64 || y < -64)
{
    room_restart();
}

// Portal: vai para proxima room
if place_meeting(x, y, objeto_portal)
{
    room_goto_next();
}

// Animacao: parado vs correndo
if (xsp == 0)
{
    sprite_index = sprite_heroi;
    image_speed = 0;
}
else
{
    sprite_index = sprite_heroi_correndo;
    image_speed = 1;
}

// Virar sprite de cabeca pra baixo quando gravidade invertida
image_yscale = grav;