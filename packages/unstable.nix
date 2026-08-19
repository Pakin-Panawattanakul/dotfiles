{
  config,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs-unstable; [
    opencode
    #ffmpeg # install by yazi dep
    cantata
    deno
    spotdl
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
}
