{ pkgs, ... }:

{
  # Boot (Graphics) - Common for laptops with iGPUs
  boot.initrd.availableKernelModules = [ "i915" ];

  # Networking (Laptops usually need NM)
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.targets.network.wantedBy = [ "multi-user.target" ];

  # Services - Hardware/Power
  services.fwupd.enable = true;
  services.fprintd.enable = true;
  services.thermald.enable = true;
  services.upower.enable = true;

  # Power Management
  services.logind.lidSwitch = "suspend";

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
    };
  };

  # Auth
  security.pam.services.login.fprintAuth = true;
  security.pam.services.sudo.fprintAuth = true;

  # Backlight control
  programs.light.enable = true;

  environment.systemPackages = with pkgs; [
    upower
  ];
}
