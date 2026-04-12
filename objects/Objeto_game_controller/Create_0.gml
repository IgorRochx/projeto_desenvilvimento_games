// se já existe outro controller, destrói esse
if (instance_number(Objeto_game_controller) > 1) {
    instance_destroy();
    exit;
}

total_dinheiro = instance_number(objeto_dinheiro);
dinheiro_coletado = 0;
fase_completada = false;
fase_completadas = 0;