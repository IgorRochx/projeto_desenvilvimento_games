// Se morreu pelo guarda, congela tudo
if (morto_por_guarda) exit;

// Cooldown do dash
if (cooldown_timer > 0) cooldown_timer--;

// Gravidade com limite, so aplicada fora do dash
if (!is_dashing)
{
    ysp = clamp(ysp + (0.3 * grav), -10, 10);
}

// Movimento horizontal
xsp = 0;
if (keyboard_check(ord("A"))) { xsp = -2; dir_dash = -1; facing = -1; }
if (keyboard_check(ord("D"))) { xsp =  2; dir_dash =  1; facing =  1; }

// Chao/teto - checa uma faixa fina abaixo/acima dos pes (nao no meio do corpo)
var _y1, _y2;
if (grav > 0) {
    _y1 = bbox_bottom + 1;
    _y2 = bbox_bottom + 2;
} else {
    _y1 = bbox_top - 2;
    _y2 = bbox_top - 1;
}
var _lx = bbox_left + 4;
var _rx = bbox_right - 4;
var _on_bloco = collision_rectangle(_lx, _y1, _rx, _y2, objeto_bloco_terra, false, true);
var _on_predio = collision_rectangle(_lx, _y1, _rx, _y2, Objeto_predio, false, true);
var _on_muro = collision_rectangle(_lx, _y1, _rx, _y2, objeto_muro, false, true);
var on_ground = (_on_bloco != noone) || (_on_predio != noone) || (_on_muro != noone);

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

// Colisao horizontal (bloco + predio + muro)
if (xsp != 0)
{
    if (place_meeting(x + xsp, y, objeto_bloco_terra) || place_meeting(x + xsp, y, Objeto_predio) || place_meeting(x + xsp, y, objeto_muro))
    {
        var _sx = sign(xsp);
        var _i = 0;
        while (_i < 20)
        {
            if (place_meeting(x + _sx, y, objeto_bloco_terra) || place_meeting(x + _sx, y, Objeto_predio) || place_meeting(x + _sx, y, objeto_muro)) break;
            x += _sx;
            _i++;
        }
        xsp = 0;
        is_dashing = false;
    }
}
x += xsp;

// Colisao vertical (bloco + predio + muro)
if (ysp != 0)
{
    if (place_meeting(x, y + ysp, objeto_bloco_terra) || place_meeting(x, y + ysp, Objeto_predio) || place_meeting(x, y + ysp, objeto_muro))
    {
        var _sy = sign(ysp);
        var _j = 0;
        while (_j < 20)
        {
            if (place_meeting(x, y + _sy, objeto_bloco_terra) || place_meeting(x, y + _sy, Objeto_predio) || place_meeting(x, y + _sy, objeto_muro)) break;
            y += _sy;
            _j++;
        }
        ysp = 0;
    }
}
y += ysp;

// Morte: tocou no guarda = guarda bate e reinicia com delay
if (place_meeting(x, y, Objeto_guarda))
{
    var _guarda = instance_nearest(x, y, Objeto_guarda);
    if (_guarda != noone)
    {
        _guarda.sprite_index = sprite_guarda_batendo;
        _guarda.image_speed = 1;
    }
    morto_por_guarda = true;
    xsp = 0;
    ysp = 0;
    visible = false;
    alarm[0] = 30;
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
    sprite_index = sprite_personagem;
    image_speed = 0;
}
else
{
    sprite_index = sprite_personagem_correndo;
    image_speed = 1;
}

// Flip vertical/horizontal agora e feito no Draw event