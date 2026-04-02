// Inverter gravidade com Espaco (so quando tocando superficie)
if keyboard_check_pressed(vk_space) && place_meeting(x, y + grav, objeto_bloco_terra)
{
    grav = -grav;
    ysp = 0;
}

// Pulo com W (so quando tocando superficie)
if keyboard_check_pressed(ord("W")) && place_meeting(x, y + grav, objeto_bloco_terra)
{
    ysp = -5 * grav;
}

// Gravidade com limite (respeita direcao)
ysp = clamp(ysp + (0.3 * grav), -10, 10);

// Movimento horizontal
xsp = 0;
if keyboard_check(ord("A")) xsp = -2;
if keyboard_check(ord("D")) xsp =  2;

// Colisao horizontal
if place_meeting(x + xsp, y, objeto_bloco_terra)
{
    while !place_meeting(x + sign(xsp), y, objeto_bloco_terra)
    {
        x += sign(xsp);
    }
    xsp = 0;
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

// Virar sprite de cabeca pra baixo quando gravidade invertida
image_yscale = grav;