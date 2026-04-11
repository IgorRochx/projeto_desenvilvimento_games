if (place_meeting(x, y, obj_player)) { // checa se o player tocou na moeda
    
    obj_game_controller.coins_collected += 1;
    
    instance_destroy();
}