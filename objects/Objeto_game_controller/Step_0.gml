if (!fase_completada && total_dinheiro > 0 && dinheiro_coletado >= total_dinheiro) {
    fase_completada = true;
    global.fase_completadas++;
    // sem room_goto aqui — o portal controla isso
}