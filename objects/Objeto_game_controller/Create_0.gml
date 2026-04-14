// Persistência entre rooms
persistent = true;

// Se já existe outro controller (veio da room anterior), destrói esse novo
if (instance_number(Objeto_game_controller) > 1) {
    instance_destroy();
    exit;
}

// Inicializa só na primeira vez
global.fase_completadas = 0;
total_dinheiro    = 0;
dinheiro_coletado = 0;
fase_completada   = false;