{ config, pkgs, ... }:
{
  # google drive rclone
  systemd.user.tmpfiles.rules = [
    "d /home/pakin/gdrive 0755 pakin users -"
  ];

  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "Mount Google Drive via rclone";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
      StartLimitIntervalSec = "600";
      StartLimitBurst = "5";
    };
    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount gdrive: /home/pakin/gdrive \
          --vfs-cache-mode full \
          --vfs-cache-max-size 50G \
          --buffer-size 1G \
          --vfs-read-ahead 512M
      '';
      Restart = "on-failure";
      RestartSec = "5";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
