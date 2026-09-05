{ config, pkgs, ... }:
{
  boot.kernelModules = [ "uinput" ];
  hardware.uinput.enable = true;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  users.groups.uinput = { };

  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
            q w e r t y u i o p
            a s d f g h j k l ;
            z x c v b n m , . /
            caps
          )
          (defvar
            tap-time 180
            hold-time 200
          )

          (defalias
            norepeat kana
            a (multi @norepeat (tap-hold $tap-time $hold-time a lmet))
            s (multi @norepeat (tap-hold $tap-time $hold-time s lalt))
            d (multi @norepeat (tap-hold $tap-time $hold-time d lctl))
            f (multi @norepeat (tap-hold $tap-time $hold-time f lsft))
            j (multi @norepeat (tap-hold $tap-time $hold-time j rsft))
            k (multi @norepeat (tap-hold $tap-time $hold-time k rctl))
            l (multi @norepeat (tap-hold $tap-time $hold-time l lalt))
            ; (multi @norepeat (tap-hold $tap-time $hold-time ; rmet))
            cap_esc (multi @norepeat (tap-hold $tap-time $hold-time esc caps))
          )

          (deflayer base
            q    w    e    r    t    y    u    i    o    p
            @a   @s   @d   @f   g    h    @j   @k   @l   @;
            z    x    c    v    b    n    m    ,    .    /
            @cap_esc
          )

          (deflayer arrownav
            _    _    _    _    _    _    _    _    _    _
            lmet lalt lctl lsft _   left down up   right _
            _    _    _    _    _    _    _    _    _    _
            _
          )
        '';
      };
    };
  };
}
