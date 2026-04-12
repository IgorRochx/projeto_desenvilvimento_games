// Draw GUI - contador de dinheiro no topo centro
if (instance_exists(Objeto_game_controller))
{
    var _texto = string(Objeto_game_controller.dinheiro_coletado) + " / " + string(Objeto_game_controller.total_dinheiro);
    var _w = display_get_gui_width();

    draw_set_halign(fa_center);
    draw_set_valign(fa_top);

    // Sombra
    draw_set_color(c_black);
    draw_text_transformed(_w / 2 + 2, 22, _texto, 2, 2, 0);

    // Texto principal
    draw_set_color(c_yellow);
    draw_text_transformed(_w / 2, 20, _texto, 2, 2, 0);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}