// Timer de spawn
spawn_timer += 1;

// Aumenta dificuldade a cada 10 segundos (reduz intervalo)
dificuldade_timer += 1;
if (dificuldade_timer >= 600) // 10s a 60fps
{
    dificuldade_timer = 0;
    spawn_intervalo = max(spawn_intervalo - 5, spawn_intervalo_min);
}

// Spawnar cone quando timer bate
if (spawn_timer >= spawn_intervalo)
{
    spawn_timer = 0;

    // Escolhe aleatoriamente: chao ou teto
    var _pos = choose(chao_y, teto_y);

    // Cria o cone
    var _cone = instance_create_layer(spawn_x, _pos, "Instances", objeto_cone);

    // Se cone no teto, vira de cabeca pra baixo
    if (_pos == teto_y)
    {
        _cone.image_yscale = -1;
    }
}