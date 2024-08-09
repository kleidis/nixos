{ config, pkgs, ... }:

{
    services.picom = {
        enable = true;
        shadow = false;
        backend = "glx";
        fade = true;
        fadeDelta = 10;
        inactiveOpacity = 0.95;
        menuOpacity = 1.0;
        vSync = true;
        wintypes = {
            tooltip = { fade = true; shadow = true; opacity = 0.75; focus = true; full-shadow = false; };
            dock = { shadow = false; clip-shadow-above = true; };
            dnd = { shadow = false; };
        };
    };
}