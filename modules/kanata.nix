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
            caps lalt
          )
          (defvar
            tap-time 180
            hold-time 200
          )

          (defalias
            a (tap-hold $tap-time $hold-time a lmet)
            s (tap-hold $tap-time $hold-time s lalt)
            d (tap-hold $tap-time $hold-time d lctl)
            f (tap-hold $tap-time $hold-time f lsft)
            j (tap-hold $tap-time $hold-time j rsft)
            k (tap-hold $tap-time $hold-time k rctl)
            l (tap-hold $tap-time $hold-time l lalt)
            ; (tap-hold $tap-time $hold-time ; rmet)
            cap_esc (tap-hold-release $tap-time $hold-time esc (layer-while-held arrownav))
            lalt-nav (layer-while-held arrownav)
          )

          (deflayer base
            q    w    e    r    t    y    u    i    o    p
            @a   @s   @d   @f   g    h    @j   @k   @l   @;
            z    x    c    v    b    n    m    ,    .    /
            esc  @lalt-nav
          )

          (deflayer arrownav
            _    _    _    _    _    _    _    _    _    _
            _    lmet lalt lctl lsft left down up   right _
            _    _    _    _    _    _    _    _    _    _
            _    _
          )
        '';
      };
    };
  };
}
