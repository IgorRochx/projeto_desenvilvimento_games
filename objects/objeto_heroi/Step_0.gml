
if (cooldown_timer > 0) cooldown_timer--;


// Gravidade com limite, so aplicada fora do dash
if (!is_dashing){
	ysp = min(ysp + 0.1, 10);
}
// Movimento horizontal
xsp = 0;
if (keyboard_check(ord("A"))) { xsp = -2; dir_dash =-1;}
if (keyboard_check(ord("D"))) {xsp =  2; dir_dash =+1;}

// Chão e pulo

var on_ground = place_meeting(x, y + 1, objeto_bloco_terra) //ve se ta no chao

if (on_ground) {
    ysp = 0; //cancela queda ao pousar
	dash_in_air = false; // libera o dash no ar para proximo salto
    if keyboard_check(ord("W")) ysp = -5; //pulo
}

if keyboard_check_pressed(ord("Z")) and cooldown_timer == 0 and !is_dashing {
	
	var can_dash = on_ground || !dash_in_air; //permite dash se tiver no chao ou no ar, se nao dashou no salto aual
	
	if (can_dash) {
		is_dashing = true; // ativa o estado de dash
        dash_timer     = dash_duration;// inicia contagem da duração
        cooldown_timer = cooldown_max; // inicia cooldown
        ysp = 0;// cancela queda atual para o dash sair reto
        xsp = 0;// limpa velocidade horizontal antes de aplicar o dash

        if (!on_ground) dash_used_in_air = true; // marca que usou o dash no ar
    }
}

if (is_dashing) {
    xsp = dash_speed * dir_dash; // aplica velocidade alta na direção salva

    dash_timer--;
    if (dash_timer <= 0) {
        is_dashing = false; // encerra o dash quando a duração esgota
        xsp        = 0;     // para o personagem ao sair do dash
    }
}
	
	
// Colisão horizontal
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