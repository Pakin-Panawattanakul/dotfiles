{
  config,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs-unstable; [
    opencode

    spotiflac
    # spotdl and dep
    spotdl
    #ffmpeg # install by yazi dep
    deno

    yt-dlp
  ];

}
