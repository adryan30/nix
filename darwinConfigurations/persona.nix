{inputs, ...} @ flakeContext: let
  darwinModule = {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [
      inputs.home-manager.darwinModules.home-manager
      inputs.self.homeConfigurations.potato.nixosModule
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
    config = {
      documentation = {
        enable = true;
      };
      nixpkgs = {
        config = {allowUnfree = true;};
      };
      programs = {
        zsh = {
          enable = true;
        };
      };
      homebrew = {
        enable = true;
        brews = [
          "ruby"
          "opentofu"
        ];
        casks = [
          "steam"
          "parsec"
          "bruno"
        ];
      };
      services = {
        nix-daemon = {
          enable = true;
        };
        yabai = {
          enable = false;
          config = {
            focus_follows_mouse = "autoraise";
            mouse_follows_focus = "off";
            window_placement = "second_child";
            window_opacity = "off";
            top_padding = 36;
            bottom_padding = 10;
            left_padding = 10;
            right_padding = 10;
            window_gap = 10;
          };
        };
      };
      system = {
        stateVersion = 4;
      };
      security = {
        pam = {
          enableSudoTouchIdAuth = true;
        };
      };
    };
  };
in
  inputs.nix-darwin.lib.darwinSystem {
    modules = [
      darwinModule
    ];
    system = "aarch64-darwin";
  }
