{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      spotify

      # for yt-dlp
      ffmpeg # install by yazi dep
      deno

      spotdl
      spotify

      # for mpd
      # rmpc
      # cava
      # cantata
    ]
    ++ [
      pkgs-unstable.ncspot
    ];

  programs.yt-dlp = {
    enable = true;
    settings = {
      cookies-from-browser = "firefox";
      extract-audio = true;
      audio-quality = 0;
      audio-format = "mp3";
      parse-metadata = "%(artists.0)s:(?P<artist>.+)";
      embed-metadata = true;
      embed-thumbnail = true;
      no-overwrites = true;
      output = "%(artist)s - %(title)s.%(ext)s";
    };
  };

  #  services.mpd = {
  #    enable = true;
  #    musicDirectory = "${config.home.homeDirectory}/Music";
  #    playlistDirectory = "${config.home.homeDirectory}/Music/playlists";
  #   # dbFile = "${config.xdg.configHome}/mpd/database";
  #   # dataDir = "${config.xdg.configHome}/mpd";
  #    extraConfig = ''
  #      auto_update "yes"

  #      audio_output {
  #          type        "pipewire"
  #          name        "PipeWire Output"
  #      }

  #      audio_output {
  #          type        "fifo"
  #          name        "my_fifo"
  #          path       "/tmp/mpd.fifo"
  #          format      "44100:16:2"
  #      }
  #    '';
  #  };
}
