if (place_meeting(x, y, objeto_personagem) || place_meeting(x, y, objeto_personagem_correndo)) { // checa se o player tocou na moeda
    
    Objeto_game_controller.dinheiro_coletado += 1;
    
    instance_destroy();
}