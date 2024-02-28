{ inputs, ... }@flakeContext:
let
  homeModule = { config, lib, pkgs, ... }: {
    config = {
      home = {
        file = {
          ".zshrc" = {
            text = ''
              export PATH="''$BUN_INSTALL/bin:''$PATH"
              export PATH="''$HOME/.krew/bin:''$PATH"
              export PATH="''$PATH:`go env GOPATH`/bin"
              export PATH="''$PATH:/opt/homebrew/opt/libpq/bin"
            '';
          };
        };
        homeDirectory = {
          _type = "override";
          content = /Users/potato;
          priority = 1;
        };
        packages = [
          pkgs.kubectx
          pkgs.kubectl
          pkgs.krew
          pkgs.operator-sdk
          pkgs.cowsay
          pkgs.fortune
          pkgs.eza
          pkgs.zoxide
          pkgs.go
          pkgs.nodejs_20
          pkgs.ngrok
          pkgs.neovim
          pkgs.ripgrep
          pkgs.delta
          pkgs.entr
          pkgs.lazygit
          pkgs.fd
          pkgs.kail
          pkgs.rustup
          pkgs.sl
          pkgs.elixir
          
          (pkgs.nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
          pkgs.monocraft

          pkgs.discord
          pkgs.spotify
          pkgs.monitorcontrol
          pkgs.iina
          pkgs.iterm2
          pkgs.stats
        ];
        sessionVariables = {
          EDITOR = "nvim";
          BUN_INSTALL = "$HOME/.bun";
          KUBECONFIG = "$HOME/.kube/config";
          NODE_ENV = "development";
          TERM = "xterm-256color";
          MAGIC_ENTER_GIT_COMMAND = "git status -u .";
          MAGIC_ENTER_OTHER_COMMAND = "ls -lh .";
        };
        stateVersion = "23.11";
        username = "potato";
      };
      programs = {
        bat = {
          enable = true;
          extraPackages = [
            pkgs.bat-extras.batdiff
            pkgs.bat-extras.batman
            pkgs.bat-extras.batgrep
            pkgs.bat-extras.batwatch
          ];
          config = {
            theme = "Enki-Tokyo-Night";
          };
        };
        fzf = {
          enable = true;
          enableZshIntegration = true;
        };
        git = {
          enable = true;
          userEmail = "adryan1990@gmail.com";
          userName = "Adryan Almeida";
        };
        home-manager = {
          enable = true;
        };
        kitty = {
          enable = true;
          font = {
            name = "JetBrainsMono Nerd Font Mono";
            size = 16;
          };
          theme = "Tokyo Night Moon";
          settings = {
            cursor_shape = "block";
            disable_ligatures = "never";
          };
          shellIntegration = {
            enableZshIntegration = true;
          };
        };
        starship = {
          enable = true;
          enableZshIntegration = true;
        };
        zsh = {
          antidote = {
            enable = true;
            plugins = [
              "zsh-users/zsh-autosuggestions"
              "zsh-users/zsh-completions"
              "zsh-users/zsh-syntax-highlighting"
              "MichaelAquilina/zsh-you-should-use"
              "ohmyzsh/ohmyzsh path:plugins/git"
              "ohmyzsh/ohmyzsh path:plugins/aws"
              "ohmyzsh/ohmyzsh path:plugins/azure"
              "ohmyzsh/ohmyzsh path:plugins/cp"
              "ohmyzsh/ohmyzsh path:plugins/docker-compose"
              "ohmyzsh/ohmyzsh path:plugins/kubectl"
              "ohmyzsh/ohmyzsh path:plugins/macos"
              "ohmyzsh/ohmyzsh path:plugins/npm"
              "ohmyzsh/ohmyzsh path:plugins/operator-sdk"
              "ohmyzsh/ohmyzsh path:plugins/ssh"
              "ohmyzsh/ohmyzsh path:plugins/sudo"
              "ohmyzsh/ohmyzsh path:plugins/yarn"
              "ohmyzsh/ohmyzsh path:plugins/brew"
              "ohmyzsh/ohmyzsh path:plugins/zoxide"
              "ohmyzsh/ohmyzsh path:plugins/magic-enter"
            ];
            useFriendlyNames = true;
          };
          enable = true;
          enableAutosuggestions = true;
          initExtraFirst = "autoload -U +X compinit && compinit";
          shellAliases = {
            asso = "aws sso login --profile default";
            cat = "bat";
            grep = "rg";
            hms = "home-manager switch";
            rebuild = "darwin-rebuild switch --flake ~/.config/nix-darwin";
            ls = "eza -l";
            man = "batman";
            cd = "z";
          };
        };
      };
    };
  };
  nixosModule = { ... }: {
    home-manager.users.potato = homeModule;
  };
in
(
  (
    inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        homeModule
      ];
      pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
    }
  ) // { inherit nixosModule; }
)
