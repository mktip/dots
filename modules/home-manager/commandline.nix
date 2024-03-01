{
  params,
  pkgs,
  ...
}: {
  programs.foot = {
    enable = true;
    server = {
      enable = true;
    };
    settings = {
      main = {
        shell = "${pkgs.${params.shell}}/bin/${params.shell}";
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
      theme.sh one-light
      watch-colors &
      disown
    '';

    shellAliases = {
      vim = "nvi";
      nvim = "nvi";
    };

    shellInit = ''
      set -gx SHELL ${pkgs.fish}/bin/fish

      set -gx EDITOR nvim
      set -gx GOPATH $HOME/proj/go/
      set -gx ZK_NOTEBOOK_DIR $HOME/docs/vault/

      fish_add_path -p $HOME/bin
      fish_add_path -p $HOME/.local/bin
    '';
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    settings = {
      search_mode = "fuzzy";
      style = "compact";
      inline_height = 10;
    };
    flags = [
      "--disable-up-arrow"
    ];
  };
}
