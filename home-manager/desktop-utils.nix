{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    #dev
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
    #gimp
    jmtpfs
    gnome-clocks

    # Media
    zathura
    mpv
    imv

    vesktop
    #synology-drive-client

    #libreoffice
    thunderbird
    bitwarden-desktop
  ];

}
