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
  # allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set your time zone.
  time.timeZone = "Asia/Bangkok";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.steam.enable = true;

  # for setting theme
  programs.dconf.enable = true;
  programs.nix-ld.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pakin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  # wayland compositor
  hardware.graphics.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.displayManager.ly.enable = true;
  security.pam.services.ly.enableGnomeKeyring = true;
  programs.mangowc.enable = true;
  programs.mangowc.package = pkgs-unstable.mango;

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
  environment.systemPackages = with pkgs; [
    vim
    curl
    solaar
  ];

  #hardware.logitech.wireless.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    #noto-fonts-cjk
  ];

  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';

  # for vesktop
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "26.05";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # programs.dwl = {
  #   enable = true;
  #   package =
  #     (pkgs.dwl.override {
  #       configH = ../config/.config/dwl/config.h;
  #     }).overrideAttrs
  #       (oldAttrs: {
  #         src = ../build/dwl;
  #         buildInputs = oldAttrs.buildInputs or [ ] ++ [
  #           pkgs.fcft
  #           pkgs.libdrm
  #         ];
  #       });
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  #services.libinput.enable = true;

}
