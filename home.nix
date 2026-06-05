{ config, pkgs, lib, ... }:

let
  gvariant = lib.hm.gvariant;
  highlightJs = pkgs.fetchurl {
    url = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/es/highlight.min.js";
    sha256 = "sha256-eGWDmUnwdk2eCiHjEaTixCYz7q7oyl7BJ7hkOFZXMf4=";
  };
in
{
  home.username = "abhi";
  home.homeDirectory = "/home/abhi";

  home.stateVersion = "25.11";

  home.file = {
    ".local/share/copyous@boerdereinar.dev/highlight.min.js" = {
      source = highlightJs;
    };
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;

  ###################################################################

  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [];
      switch-applications-backward = [];

      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        "compose:rctrl"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>period";
      command = "smile";
      name = "Smile Emoji Picker";
    };

    "org/gnome/desktop/break-reminders" = {
      selected-breaks = [ "eyesight" "movement" ];
    };

    "org/gnome/desktop/break-reminders/eyesight" = {
      play-sound = true;
    };

    "org/gnome/desktop/break-reminders/movement" = {
      duration-seconds = gvariant.mkUint32 300;
      interval-seconds = gvariant.mkUint32 1800;
      play-sound = true;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "hibernate";
    };

    "org/gnome/shell" = {
      favorite-apps = [ "microsoft-edge.desktop" "dev.warp.Warp.desktop" "org.gnome.Nautilus.desktop" ];
      last-selected-power-profile = "performance";

      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        copyous.extensionUuid
        smile-complementary-extension.extensionUuid
      ];
    };

    "org/gnome/Showtime/State" = {
      is-maximized = false;
    };
  };

  programs.anki = {
    enable = true;
    language = "en_US";
    reduceMotion = false;
    profiles."User 1" = {
      default = true;
      sync = {
        autoSync = true;
        syncMedia = true;
        username = "abhi.kr.2100@gmail.com";
        keyFile = "${config.home.homeDirectory}/.dotfiles/secrets/anki-sync-key-file";
      };
    };
  };

  programs.antigravity.enable = true;

  programs.chromium = {
    enable = true;
    package = pkgs.microsoft-edge;
  };

  programs.codex = {
    enable = true;
    settings = {
      approval_policy = "never";
      sandbox_mode = "danger-full-access";

      tui.notification_condition = "always";

      projects = {
        "${config.home.homeDirectory}/Projects/CatLauncher".trust_level = "trusted";
        "${config.home.homeDirectory}/Projects/github-mock-api".trust_level = "trusted";
      };
    };
  };

  programs.cursor.enable = true;

  programs.github-copilot-cli.enable = true;

  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        mouse = false;
        default-yank-register = "+";
        soft-wrap.enable = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };

  programs.gh = {
    enable = true;
    hosts = {
      "github.com" = {
        git_protocol = "https";
        user = "abhi-kr-2100";
      };
    };
    settings = {
      editor = "hx";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Abhishek Kumar";
      user.email = "abhi.kr.2100@gmail.com";

      init.defaultBranch = "main";

    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Abhishek Kumar";
        email = "abhi.kr.2100@gmail.com";
      };

      ui.editor = "hx";
    };
  };

  programs.kiro = {
    enable = true;
  };

  programs.obs-studio.enable = true;

  programs.opencode = {
    enable = true;
    web.enable = true;
  };

  programs.ripgrep.enable = true;

  programs.windsurf.enable = true;

  programs.zed-editor = {
    defaultEditor = true;
    enable = true;
    userSettings = {
      helix_mode = true;
    };
    mutableUserDebug = false;
    mutableUserKeymaps = false;
    mutableUserSettings = false;
    mutableUserTasks = false;
  };

  home.packages = with pkgs; [
    gemini-cli
    gnomeExtensions.copyous
    gnomeExtensions.smile-complementary-extension
    lsof
    mistral-vibe
    pokerth
    quickemu
    quickgui
    smile
    warp-terminal
  ];
}
