# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
{

  imports = [
    ./modules/dwl.nix
    ./modules/udev.nix
  ];

  # allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 3;

  # Set your time zone.
  time.timeZone = "Asia/Bangkok";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
  };

  # dbus: usually already true by default
  services.dbus.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
    gamescope
  ];

  # for setting theme
  programs.dconf.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd

    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pakin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  documentation.man = {
    enable = true;
    cache.enable = true;
  };

  hardware.graphics.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.displayManager.ly.enable = true;
 # security.pam.services.ly.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  users.defaultUserShell = pkgs.bash;
  programs.zsh.enable = true;
  users.users.pakin.shell = pkgs.zsh;

  # thunar
  services.tumbler.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # system packages
  environment.systemPackages =
    with pkgs;
    [
      vim
      curl
      solaar
      file
      libinput
    ]
    ++ [ pkgs-unstable.slang-server ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
  ];
  services.udisks2.enable = true;

  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';

  # for vesktop
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
  hardware.logitech.wireless.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "26.05";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

}
