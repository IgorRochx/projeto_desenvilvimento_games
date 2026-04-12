if (place_meeting(x, y, objeto_personagem)) {
    Objeto_game_controller.dinheiro_coletado += 1;
    instance_destroy();
}