if (dinheiro_coletado >= total_dinheiro && total_dinheiro > 0) {
	fase_completadas +=1;
	
	if (fase_completadas >=2) {
		room_goto(Fase_03_invertida);
	}
	else {
		room_goto_next();
	}
}