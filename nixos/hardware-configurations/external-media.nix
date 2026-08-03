{ config, pkgs, ... }:
{

  # auto mounting External ssd : Contain Music and Calibre Library

  fileSystems."/mnt/External" = {
    device = "/dev/disk/by-uuid/140477de-4561-49e5-865c-a301905d0a78";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.automount"
      "x-systemd.device-timeout=2s"
    ];

  };

}
