{ config, pkgs, lib, dotfilesPath, ... }:

let
  basePath = "${dotfilesPath}/base";
  link = file: config.lib.file.mkOutOfStoreSymlink "${basePath}/${file}";
in
{
  home.file = {
    ".xresources".source = link ".xresources";
    ".xmodmap".source = link ".xmodmap";
    ".xinitrc".source = link ".xinitrc";
    ".xbindkeysrc".source = link ".xbindkeysrc";
    ".xprofile".source = link ".xprofile";
    ".i3blocks.conf".source = link ".i3blocks.conf";
  };

  xdg.configFile = {
    "i3".source = link ".config/i3";
    "kitty".source = link ".config/kitty";
    "dunst".source = link ".config/dunst";
    "redshift.conf".source = link ".config/redshift.conf";
    "gtk-3.0".source = link ".config/gtk-3.0";
  };

  home.packages = [
  ];

  systemd.user.services.check-nix-update = {
    Unit = {
      Description = "Check if NixOS configuration is stale";
    };
    Service = {
      Type = "oneshot";
      ExecStart =
        let
          script = pkgs.writeShellScript "check-update" ''
            FLAKE_LOCK="${dotfilesPath}/nix/flake.lock"
            if [ -f "$FLAKE_LOCK" ]; then
               # Check if file is older than 30 days (2592000 seconds)
               if [ $(($(date +%s) - $(stat -c %Y "$FLAKE_LOCK"))) -gt 2592000 ]; then
                  ${pkgs.libnotify}/bin/notify-send "System Update" "Your system configuration is over 30 days old. Please consider running an update." -u normal
               fi
            fi
          '';
        in
        "${script}";
    };
  };

  systemd.user.timers.check-nix-update = {
    Unit = {
      Description = "Periodically check for NixOS updates";
    };
    Timer = {
      OnBootSec = "15m";
      OnUnitActiveSec = "1d";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
