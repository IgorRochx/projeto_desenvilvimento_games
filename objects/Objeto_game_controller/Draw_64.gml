// Draw GUI - contador de dinheiro no topo centro
var _texto = "$ " + string(dinheiro_coletado) + " / " + string(total_dinheiro);
var _w = display_get_gui_width();

draw_set_halign(fa_center);
draw_set_valign(fa_top);

// Sombra
draw_set_color(c_black);
draw_text_transformed(_w / 2 + 3, 23, _texto, 3, 3, 0);

// Texto principal
draw_set_color(c_yellow);
draw_text_transformed(_w / 2, 20, _texto, 3, 3, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);