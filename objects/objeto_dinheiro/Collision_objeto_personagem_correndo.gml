// objeto_dinheiro — Collision Event com objeto_personagem
var ctrl = instance_find(Objeto_game_controller, 0);
if (ctrl != noone) {
    ctrl.dinheiro_coletado++;
}
instance_destroy();