{config, pkgs, ... }:

{
  programs.dconf.enable = true;

  users.users.kleidis.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

systemd.tmpfiles.rules = [
  "f /dev/shm/looking-glass 0660 kleidis qemu-libvirtd -"
];
}
