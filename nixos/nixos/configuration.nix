# Edit this configuration file to define what should be installed on your system.  
# Help is available in the configuration.nix(5) man page and in the NixOS manual 
# (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{ imports =
    [ 
      ./hardware-configuration.nix
      ./packages.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true; boot.loader.efi.canTouchEfiVariables = 
  true;

  networking.hostName = "nixos"; 

  # Garbage collection of nix generations
  nix.gc = { 
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Luxembourg";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = { LC_ADDRESS = "lb_LU"; LC_IDENTIFICATION = "lb_LU"; 
    LC_MEASUREMENT = "lb_LU"; LC_MONETARY = "lb_LU"; LC_NAME = "lb_LU"; LC_NUMERIC = 
    "lb_LU"; LC_PAPER = "lb_LU"; LC_TELEPHONE = "lb_LU"; LC_TIME = "lb_LU";
  };
  console.keyMap = "us-acentos";

  # Wayland session.
  services.xserver = {
    enable = true;
    desktopManager = {
        gnome.enable = true;
    };
    libinput.enable = true;
  };
  services.displayManager.defaultSession = "gnome";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false; security.rtkit.enable = true; 
  services.pipewire = {
    enable = true; alsa.enable = true; alsa.support32Bit = true; pulse.enable = 
    true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chris = { isNormalUser = true; description = "Chris"; extraGroups = [ 
    "networkmanager" "wheel" ]; packages = with pkgs; [ ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.home-manager
  ];

  ni.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11"; # Did you read the comment?

}
