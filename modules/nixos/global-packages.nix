{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # essential
    git
    wget
    curl
    tmux
    vim

    # archives
    gnutar
    zip
    zstd
    xz

    # utils
    ripgrep
    du-dust
    jq
    fd

    # networking tools
    dnsutils
    nmap
    tcpdump

    # misc
    sl
    lolcat
    cowsay
    file
    which
    tree
    gnused
    gawk
    gnupg

    # monitoring
    htop
    iotop
    iftop
    strace
    ltrace
    lsof
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
  ];
}
