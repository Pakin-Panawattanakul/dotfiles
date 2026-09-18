{ config, pkgs, ... }:
{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/plain" = "nvim.desktop";
      "text/markdown" = "nvim.desktop";
      "text/x-cmake" = "nvim.desktop";
      "application/json" = "nvim.desktop";
      "application/x-docbook+xml" = "nvim.desktop";
      "application/x-yaml" = "nvim.desktop";

      "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";

      "image/jpeg" = "imv.desktop";
      "image/png" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/avif" = "imv.desktop";
      "image/bmp" = "imv.desktop";
      "image/heif" = "imv.desktop";

      "audio/mpeg" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/x-flac" = "mpv.desktop";
      "audio/x-wav" = "mpv.desktop";
      "audio/mp4" = "mpv.desktop";
      "audio/aac" = "mpv.desktop";
      "audio/vorbis" = "mpv.desktop";
      "audio/x-vorbis+ogg" = "mpv.desktop";
      "audio/x-mpegurl" = "mpv.desktop";
      "audio/mpegurl" = "mpv.desktop";
      "audio/x-ms-wma" = "mpv.desktop";
      "audio/x-musepack" = "mpv.desktop";
      "audio/x-oggflac" = "mpv.desktop";
      "audio/x-pn-realaudio" = "mpv.desktop";
      "audio/vnd.rn-realaudio" = "mpv.desktop";
      "audio/x-scpls" = "mpv.desktop";
      "audio/x-vorbis" = "mpv.desktop";
      "audio/x-mp3" = "mpv.desktop";

      "inode/directory" = "yazi.desktop";

      "x-scheme-handler/http" = "firefox.desktop";          # or your browser
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/bitwarden" = "Bitwarden.desktop";
      "x-scheme-handler/discord" = "vesktop.desktop";

      # === Email: use aerc instead of Thunderbird ===
      "x-scheme-handler/mailto" = "aerc.desktop";
      "message/rfc822" = "aerc.desktop";  # optional, for .eml files

    };
  };
}
