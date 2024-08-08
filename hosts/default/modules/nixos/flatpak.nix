{ config, pkgs, inputs, ... }:
{
  # flatpak
  services.flatpak.enable = true;
  services.flatpak.update.onActivation = true;
  services.flatpak = {
    packages = [
      "com.github.tchx84.Flatseal"
      "com.brave.Browser"
      "it.mijorus.gearlever"
      "org.qbittorrent.qBittorrent"
      "org.kde.KStyle.Kvantum/x86_64/5.15-22.08"
      "org.kde.KStyle.Kvantum/x86_64/5.15-23.08"
      "org.kde.KStyle.Kvantum/x86_64/6.5"
      "org.kde.KStyle.Kvantum/x86_64/6.6"
      "org.kde.KStyle.Kvantum/x86_64/5.15"
      "org.kde.KStyle.Kvantum/x86_64/5.15-21.08"
    ];
    overrides = {
      global = {
        Environment = {
          "QT_STYLE_OVERRIDE" = "kvantum";
        };
        Context = {
          filesystems = [
            "/run/media/kleidis"
            "xdg-data/themes:ro"
            "xdg-data/icons:ro"
            "xdg-config/gtkrc:ro"
            "xdg-config/gtkrc-2.0:ro"
            "xdg-config/gtk-2.0:ro"
            "xdg-config/gtk-3.0:ro"
            "xdg-config/gtk-4.0:ro"
            "xdg-config/Kvantum:ro"
            "xdg-run/.flatpak/com.xyz.armcord.ArmCord:create"
            "xdg-run/discord-ipc-*"
            "xdg-config/MangoHud:ro"
            "/nix"
          ];
        };
      };
    };
  };
}