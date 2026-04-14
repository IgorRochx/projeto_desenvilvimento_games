if (room == Fase_01) {
    room_goto(Fase_02);
    
} else if (room == Fase_02) {
    if (global.fase_completadas >= 2) {
        room_goto(Fase_03_invertida);
    } else {
        room_goto(Final_Ruim);
    }
    
} else if (room == Fase_03_invertida) {
    room_goto(Final_Bom);
}