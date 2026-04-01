// Gravidade com limite
ysp = min(ysp + 0.1, 10);

// Movimento horizontal
xsp = 0;
if keyboard_check(ord("A")) xsp = -2;
if keyboard_check(ord("D")) xsp =  2;

// Chão e pulo
if place_meeting(x, y + 1, objeto_bloco_terra)
{
    ysp = 0;
    if keyboard_check(ord("W")) ysp = -5;
}

// Colisão horizontal
if place_meeting(x + xsp, y, objeto_bloco_terra)
{
    while !place_meeting(x + sign(xsp), y, objeto_bloco_terra)
    {
        x += sign(xsp);
    }
    xsp = 0;
}
x += xsp;

// Colisão vertical
if place_meeting(x, y + ysp, objeto_bloco_terra)
{
    while !place_meeting(x, y + sign(ysp), objeto_bloco_terra)
    {
        y += sign(ysp);
    }
    ysp = 0;
}
y += ysp;