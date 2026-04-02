// Move pra esquerda (auto-scroll)
x -= scroll_speed;

// Destroi quando sai da tela
if (x < -64)
{
    instance_destroy();
}