{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    tmux
    vim
    htop
    file
    du-dust
    ripgrep
    fd
  ];
}
