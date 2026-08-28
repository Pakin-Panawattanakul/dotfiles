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
    mpv
    imv
    cava

    vesktop
    spotify
    synology-drive-client

    ncspot
    libreoffice
    thunderbird
    bitwarden-desktop
    #gnome keyring
    seahorse
  ];

}
