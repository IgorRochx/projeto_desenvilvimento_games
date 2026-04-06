// Cooldown do dash
if (cooldown_timer > 0) cooldown_timer--;

// Gravidade com limite, so aplicada fora do dash
if (!is_dashing)
{
    ysp = clamp(ysp + (0.3 * grav), -10, 10);
}

// Movimento horizontal
xsp = 0;
if (keyboard_check(ord("A"))) { xsp = -2; dir_dash = -1; }
if (keyboard_check(ord("D"))) { xsp =  2; dir_dash =  1; }

// Chao/teto e pulo (respeita direcao da gravidade)
var on_ground = place_meeting(x, y + grav, objeto_bloco_terra);

if (on_ground)
{
    ysp = 0;
    dash_in_air = false;
    can_double_jump = true;
    if keyboard_check_pressed(ord("W")) ysp = -7 * grav;
}
else
{
    // Pulo duplo no ar
    if keyboard_check_pressed(ord("W")) && can_double_jump
    {
        ysp = -5 * grav;
        can_double_jump = false;
    }
}

// Dash com Z
if keyboard_check_pressed(ord("Z")) && cooldown_timer == 0 && !is_dashing
{
    var can_dash = on_ground || !dash_in_air;

    if (can_dash)
    {
        is_dashing = true;
        dash_timer = dash_duration;
        cooldown_timer = cooldown_max;
        ysp = 0;
        xsp = 0;
        if (!on_ground) dash_in_air = true;
    }
}

// Executar dash
if (is_dashing)
{
    xsp = dash_speed * dir_dash;
    dash_timer--;
    if (dash_timer <= 0)
    {
        is_dashing = false;
        xsp = 0;
    }
}

// Colisao horizontal
if place_meeting(x + xsp, y, objeto_bloco_terra)
{
    while !place_meeting(x + sign(xsp), y, objeto_bloco_terra)
    {
        x += sign(xsp);
    }
    xsp = 0;
    is_dashing = false;
}
x += xsp;

// Colisao vertical
if place_meeting(x, y + ysp, objeto_bloco_terra)
{
    while !place_meeting(x, y + sign(ysp), objeto_bloco_terra)
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

// Virar sprite de cabeca pra baixo quando gravidade invertida
image_yscale = grav;