# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    inputs.nixvim.homeManagerModules.nixvim

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  fonts.fontconfig.enable = true;

  # TODO: Set your username
  home = {
    username = "mkti";
    homeDirectory = "/home/mkti";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  # programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";


  programs.nixvim.enable = true;

  programs.vscode = {
    enable = true;
  };

  programs.foot = {
    enable = true;
    server = {
      enable = true;
    };
    settings = {
      main = {
        shell = "${pkgs.fish}/bin/fish";
        font = "Iosevka Nerd Font Mono:size=12";
        pad = "15x15center";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      csd = {
        preferred = "none";
      };
      key-bindings = {
        fullscreen = "F11";
      };
    };
  };


  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      # theme.sh one-light
      # watch-colors &
      # disown
    '';

   # shellAliases = {
   #   vim = "nvi";
   #   nvim = "nvi";
   # };

    shellInit = ''
      set -gx EDITOR nvim
      set -gx ZK_NOTEBOOK_DIR ~/docs/vault/
      set -gx GOPATH ~/proj/go/
      set -gx SHELL ${pkgs.fish}/bin/fish

      # set -gx LD_LIBRARY_PATH /usr/local/cuda/lib64 /usr/local/cuda/compat
      # set -gx SNOOPIE_PATH $HOME/proj/snoopie-sanitizer/build/snoopie.so
      fish_add_path -p $HOME/bin
      fish_add_path -p $HOME/.local/bin
      # fish_add_path -p /usr/local/cuda/bin
    '';

  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      search_mode = "fuzzy";
      style = "compact";
      inline_height = 10;
    };
    flags = [
      "--disable-up-arrow"
    ];
  };

  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
      enable = true;
      enableFishIntegration = true;
      pinentryFlavor = "gnome3";
  };

  programs.git = {
    enable = true;
    aliases = {
      co = "checkout";
      st = "status";
      dc = "diff --cached";
      di = "diff";
      br = "branch";
      amend = "commit --amend";
    };
    includes = [
      {
        contents = {
          user = {
            email = "mo.issa.ok@gmail.com";
            name = "Mohammad Issa";
            signingKey = "936DE6C552B5CDAF0A2DBD4428E0696214F6E298";
          };
          commit = {
            gpgSign = true;
          };
	  init = {
	    defaultBranch = "main";
	  };
        };
      }
    ];
  };

  # systemd.user.timers = {
  #   suspend-closed-lid = {
  #     Unit = {
  #       Description = "Suspend if lid is closed";
  #       Documentation = [ ];
  #     };

  #     Timer = {
  #       OnBootSec = "0min";
  #       OnUnitActiveSec = "1min";
  #     };

  #     Install = {
  #       WantedBy = [ "timers.target" ];
  #     };
  #   };
  # };

  # systemd.user.services = {
  #   suspend-closed-lid = {
  #     Unit = {
  #       Description = "Suspend if lid is closed";
  #       Documentation = [ ];
  #     };

  #     Service = {
  #       Type = "oneshot";
  #       ExecStart = "sh -c 'grep closed -q /proc/acpi/button/lid/LID/state && systemctl suspend -i || true'";
  #     };

  #     Install = {
  #       WantedBy = [ "default.target" ];
  #     };
  #   };
  # };

  xdg.userDirs = {
    enable = true;
    documents = "${config.home.homeDirectory}/docs";
    desktop = "${config.home.homeDirectory}/desk";
    download = "${config.home.homeDirectory}/down";
    music = "${config.home.homeDirectory}/media/aud/music";
    pictures = "${config.home.homeDirectory}/media/img";
    videos = "${config.home.homeDirectory}/media/vid";
    templates = "${config.home.homeDirectory}/docs/templates";
    publicShare = "${config.home.homeDirectory}/docs/public";
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  services.mpd = {
    enable = true;
    musicDirectory = "${config.xdg.userDirs.music}";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    firefox
    chromium
    wl-clipboard

    bear
    
    tmux

    inkscape
    gimp

    texlab
    texlive.combined.scheme-full
    pandoc

    rnix-lsp
    nodePackages_latest.typescript-language-server

    zk

    glow
    du-dust
    ripgrep
    hyperfine
    fd
    gron
    zstd

    gnomeExtensions.blur-my-shell

    # Waiting for 273808 github issue merge into 23.11 (if it is to be backborted)
    # pkgs.unstable.supergfxctl
    # pkgs.unstable.asusctl

    (nerdfonts.override { fonts = [ "Iosevka" ]; })

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
