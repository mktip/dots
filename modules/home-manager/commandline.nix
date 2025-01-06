{ ... }: {

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings

      atuin init fish --disable-up-arrow | source
      direnv hook fish | source
      source {$GHOSTTY_RESOURCES_DIR}/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish
    '';

    shellAliases = {
      ls = "ls --color --group-directories-first";
      grep = "grep --color";
    };

    shellAbbrs = {
      vim = "nvim";
      hm-switch =
        "home-manager switch --flake $HOME/docs/dots/machines/asus-ga401#mktips@jassas";
      nixos-switch =
        "sudo nixos-rebuild switch --flake $HOME/docs/dots/machines/asus-ga401#jassas";
    };

    functions = { goto = "cd (here $argv)"; };

    shellInit = ''
      set -gx SHELL $(which fish)
      set -gx EDITOR nvim
      set -gx BROWSER chromium
      set -gx GOPATH $HOME/proj/go/
      set -gx PNPM_HOME $HOME/.config/share/pnpm

      # luarocks --lua-version 5.1 path | source

      fish_add_path -p $PNPM_HOME
      fish_add_path -p $HOME/.local/bin
      fish_add_path -p $HOME/.config/pear/bin
      fish_add_path -p $GOPATH/bin
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
    flags = [ "--disable-up-arrow" ];
  };
}
