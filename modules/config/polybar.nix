{ config, pkgs, ... }:


{
  services.polybar = {
    enable = true;
    script = ''
      ${pkgs.polybar}/bin/polybar main &
    '';
    settings = {
      "bar/main" = {
        font-0 = "Roboto Mono:style=Regular:pixelsize=12:antialias=true;2";
        font-1 = "Font Awesome 6 Free:pixelsize=11;2";
        font-2 = "Font Awesome 6 Free Solid:pixelsize=11;2";
        font-3 = "Font Awesome 6 Brands:pixelsize=11;2";

        background = "#1e1e2e";
        foreground = "#fff";
        radius = "10";
        width = "99%";
        line-size = 1;
        line-color = "#f00";
        border-size = 1;
        border-color = "#313244";
        padding = 2;
        module-margin = 1;

        height = 40;
        padding-left = 1;
        padding-right = 1;
        offset-x = "0.5%";
        offset-y = 10;
        modules-left = "power workspaces clock";
        modules-center = "current-window";
        modules-right = "cpu memory temperature battery wifi bluetooth pulseaudio tray";
      };

      "module/workspaces" = {
        type = "internal/xworkspaces";
        wrapping-scroll = false;
        pin-workspaces = false;
        label-active = "%icon%";
        label-active-background = "#89b4fa";
        label-active-foreground = "#1e1e2e";
        label-active-padding = "13px";
        label-active-font = 4;
        label-occupied = "%icon%";
        label-empty = "%icon%";
        label-occupied-padding = "13px";
        label-empty-padding = "13px";
        icon-0 = "1;";
        icon-1 = "2;";
        icon-2 = "3;";
        icon-3 = "4;";
        icon-4 = "5;";
        icon-5 = "6;";
        icon-6 = "7;";
        icon-7 = "8;";
        icon-8 = "9;";
      };

      "module/current-window" = {
        type = "internal/xwindow";
        label = "%title%";
        label-maxlen = 50;
        label-empty = "No Window";
        label-empty-foreground = "#9399b2";
      };

      "module/clock" = {
        type = "internal/date";
        interval = 5;
        time = "%I:%M";
        label = "| %{T7}%{T-} %{T1}%time%";
        label-padding = 0;
        label-foreground = "#89b4fa";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        label = " %percentage%%";
        label-padding = 0;
        label-background = "#1e1e2e";
        label-foreground = "#f9e2af";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        label = " %mb_used%";
        label-padding = 0;
        label-background = "#1e1e2e";
        label-foreground = "#fab387";
      };

      "module/temperature" = {
        type = "internal/temperature";
        thermal-zone = 0;
        interval = 10;
        label = " %temperature-c%";
        label-padding = 0;
        label-background = "#1e1e2e";
        label-foreground = "#f38ba8";
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT1";
        adapter = "ACAD";
        full-at = 95;
        interval = 30;
        label-charging = "%{T1}%{T-} %percentage%%  | ";
        label-discharging = "%{T1}%{T-} %percentage%%  | ";
        label-full = "%{T1}%{T-} %percentage%%  | ";
        label-padding = 0;
        label-background = "#1e1e2e";
        label-foreground = "#f5e0dc";
      };

      "module/wifi" = {
        type = "internal/network";
        interface = "wlo1";
        interval = 3.0;
        format-connected = "%{T-3} On";
        format-connected-foreground = "#a6e3a1";
        format-disconnected = "%{T-3} Off%{T-}";
        format-disconnected-foreground = "#f38ba8";
        click-left = "nm-connection-editor";
      };

      "module/bluetooth" = {
        type = "custom/script";
        exec = "echo $(bluetoothctl show | grep 'Powered: yes' > /dev/null && echo ' On' || echo ' Off')";
        interval = 5;
        format-prefix = " ";
        format-prefix-foreground = "#89b4fa";
        format-foreground = "#89b4fa";
        click-left = "blueman-manager";
      };

      "module/pulseaudio" = {
        type = "custom/script";
        tail = true;
        format-underline = "#94e2d5";
        label-padding = 2;
        label-foreground = "#94e2d5";
        exec = "pulseaudio-control --autosync --icon-muted  --icons-volume ,, --volume-max 100 listen";
        click-right = "pavucontrol";
        click-left = "pulseaudio-control togmute";
        click-middle = "pulseaudio-control --node-blacklist \"alsa_output.pci-0000_01_00.1.hdmi-stereo-extra2\" next-node";
        scroll-up = "pulseaudio-control up";
        scroll-down = "pulseaudio-control down";
      };

      "module/tray" = {
        type = "internal/tray";
        format = "<tray>";
        tray-spacing = "2px";
        tray-padding = "2px";
        tray-size = "40%";
        tray-background = "#1e1e2e";
        tray-foreground = "#cdd6f4";
      };

      "module/power" = {
        type = "custom/script";
        exec = "echo '|  |'";
        click-left = "echo 'awesome.quit()' | awesome-client";
        format-padding = 0;
        format-background = "#1e1e2e";
        format-foreground = "#f38ba8";
      };
    };
  };
}