# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.device = "/dev/sdb";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
	hostName = "ssb"; # Define your hostname.
	networkmanager.enable = true;
	useDHCP = false;
	interfaces.enp3s0.useDHCP = true;
  };

  
  # Set your time zone.
  time.timeZone = "Asia/Kamchatka";
  time.hardwareClockInLocalTime = true;
  
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    alsaTools
    emacs
    # vscode
    numix-icon-theme
    
    # utils
    usbutils
    binutils
    busybox
    axel
    dmenu
    rofi
    i3blocks
    i3-gaps
    compton
    feh
    htop
    p7zip
    udevil # automounting usb drives  
    xorg.xkill
    xtitle
    zlib
    vlc
    playerctl

    # office
    libreoffice
    evince
    aspell
    aspellDicts.ru

    # desktop
    lilyterm
    pcmanfm
    chromium
    xarchiver
    photoqt
    inkscape
    gimp
    zoom-us
    skypeforlinux
    
    # programming
    ghc
    stack
    cabal-install
    hasklig
    haskellPackages.hlint
    haskellPackages.ghcide
    haskellPackages.happy
    haskellPackages.primes
    
    ghcid
    hasklig
    haskellPackages.hindent
    
    # programming
    jetbrains.clion
    gcc
    cmake
    gitkraken
    gnumake
    playerctl
    tree
    zlib
        
    # math
    maxima
    wxmaxima
    gnuplot

    # utils
    axel
    git
    youtube-dl
    shutter
    #fontconfig   
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    pulseaudio = true;
    require-sigs = true;
  };

  programs = {
    fish.enable = true;
  };


  fileSystems."/home/sergey/archive" = 
  {
    device = "/dev/disk/by-uuid/7e62ab11-ed1e-4a1d-a993-87c7201772ff";
    fsType = "ext4";
  };

  # List services that you want to enable:
  services = {
   

   #  udisks2.enable = true;
     chrony.enable = true;


    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      desktopManager.xfce.enable = true;
      #windowManager.xmonad.enable = true;
      #displayManager.defaultSession = "none+xmonad";
      windowManager.i3.enable = true;
#      displayManager.defaultSession = "none+i3";#
      displayManager.defaultSession = "xfce";

      xkbModel = "microsoft";
      layout = "us,ru(winkeys)";
      xkbOptions = "grp:caps_toggle,grp_led:caps";
      xkbVariant = "winkeys";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers = {
    sergey = {
      isNormalUser = true;
      home = "/home/sergey";
      extraGroups = ["wheel" "audio" "video" "networkmanager"];
      shell = "/run/current-system/sw/bin/fish";
    };
  };

  hardware = {
    pulseaudio.enable = true;
  };

  sound.enable = true; 

  fonts = {
      fonts = with pkgs; [
        dejavu_fonts
        source-code-pro
#        source-sans-pro
#        source-serif-pro
        cm_unicode
        font-awesome_4
      #  google-fonts
      ];
      fontconfig = {
        enable = true;
#        defaultFonts = {
#          monospace = [ "Source Code Pro" ];
#        };
      };
  };

}
