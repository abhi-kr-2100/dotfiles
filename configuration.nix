{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    options = "compose:ins";
    layout = "us";
    variant = "";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
  ];
  environment.shells = [ pkgs.nushell ];

  system.stateVersion = "25.11";

  ###################################################################

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
  };

  users.users.abhi = {
    isNormalUser = true;
    description = "Abhishek Kumar";
    shell = pkgs.nushell;
    extraGroups = [ "networkmanager" "wheel" "docker" "kvm" "libvirtd" ];

    packages = with pkgs; [
    ];
  };

  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  virtualisation.libvirtd.enable = true;

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;

  programs.dconf.enable = true;

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        rightalt = "backspace";
        capslock = "leftshift";
      };
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.extraOptions = "!include /home/abhi/.dotfiles/secrets/nix.conf";

  environment.gnome.excludePackages = (with pkgs; [
    baobab
    cheese
    epiphany
    gedit
    gnome-calendar
    gnome-clocks
    gnome-connections
    gnome-contacts
    gnome-console
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-text-editor
    gnome-tour
    gnome-user-docs
    gnome-weather
    simple-scan
    snapshot
    xterm
  ]) ++ (with pkgs.gnome; [
  ]);
}
