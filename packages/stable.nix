{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    #dev
    gdb
    rclone
    fuse3
    keymapp

    # desktop utils
    bluetui
    wiremix
    brightnessctl
    btop
    aria2
    qalculate-gtk
    gimp
    jmtpfs
    gnome-clocks

    # Media
    zathura
    mpc
    rmpc
    mpv
    imv
    cava

    vesktop
    spotify
    libreoffice
    thunderbird
    bitwarden-desktop
    #gnome keyring
    seahorse
  ];

}
