// Spawner de cones — cadencia configuravel
spawn_timer = 0;
spawn_intervalo = 90; // frames entre cada cone (90 = ~1.5s a 60fps)
spawn_intervalo_min = 40; // intervalo minimo (fica mais dificil com o tempo)

// Posicao X onde os cones nascem (fora da tela, direita)
spawn_x = room_width + 32;

// Alturas possiveis: chao e teto
// Ajuste esses valores conforme sua Room
chao_y = room_height - 64; // Y do chao (onde os blocos estao)
teto_y = 64;               // Y do teto

// Dificuldade aumenta com o tempo
dificuldade_timer = 0;