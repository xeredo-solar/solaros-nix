{ config, lib, pkgs, ... } @ args:

with (import ../lib args);

mkFeatureFlag { name = "printing"; desc = "printing and scanning support"; enabled = true; } {
  services.system-config-printer.enable = true;
  environment.systemPackages = with pkgs; [ system-config-printer ];

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;

    drivers = with pkgs; [
      gutenprint
      gutenprintBin
      cups-googlecloudprint
    ];

    # this enables avahi+browsed autodiscover
    # TODO: rework, this was mostly written "catch-all" style
    browsing = true;
    defaultShared = true;
    extraConf = ''
BrowseDNSSDSubTypes _cups,_print
BrowseLocalProtocols all
BrowseRemoteProtocols all
CreateIPPPrinterQueues All
    '';
    browsedConf = ''
BrowseDNSSDSubTypes _cups,_print
BrowseLocalProtocols all
BrowseRemoteProtocols all
CreateIPPPrinterQueues All

BrowseProtocols all
    '';
  };

  # Cups network printing
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # And sane to scan
  hardware.sane.enable = true;
}
