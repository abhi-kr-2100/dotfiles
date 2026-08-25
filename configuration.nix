{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "box";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_DK.UTF-8";
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
    "fs.inotify.max_user_watches" = 10485760;
  };

  users.users.abhi = {
    isNormalUser = true;
    description = "Abhishek Kumar";
    shell = pkgs.nushell;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;

  programs.dconf.enable = true;

  programs.chromium = {
    enable = true;
    extensions = [
      "ddkjiahejlhfcafbddmgiahcphecmpfh;https://clients2.google.com/service/update2/crx" # uBlock Origin Lite
    ];
  };

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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.extraOptions = "!include /home/abhi/.dotfiles/secrets/nix.conf";

  environment.gnome.excludePackages = (
    with pkgs;
    [
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
    ]
  );
}
