{ config, pkgs, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "${config.home.homeDirectory}/Music/playlists";
   # dbFile = "${config.xdg.configHome}/mpd/database";
   # dataDir = "${config.xdg.configHome}/mpd";
    extraConfig = ''
      auto_update "yes"

      audio_output {
          type        "pipewire"
          name        "PipeWire Output"
      }

      audio_output {
          type        "fifo"
          name        "my_fifo"
          path       "/tmp/mpd.fifo"
          format      "44100:16:2"
      }
    '';
  };
}
