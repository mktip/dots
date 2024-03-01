{
  params,
  pkgs,
  ...
}: {
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = params.username;
  };

  # Needed for autologin for now
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # The below is for GPG pinentry with gnome 3
  services.dbus.packages = [pkgs.gcr];

  # For locate and updatedb
  services.locate = {
    enable = true;
    localuser = null;
  };

  services.openssh = {
    enable = false;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}
