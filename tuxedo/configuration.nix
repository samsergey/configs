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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;  
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable=true;
  
  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp1s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  #i18n.defaultLocale = "ru_RU.UTF-8";
  #console = {
  #   font = "cyr-sun16";
  #   keyMap = "ruwin_alt_sh-UTF-8";
  # };
 
  # Set your time zone.
  time = {
#    timeZone = "Asia/Kamchatka";
    timeZone = "Europe/Moscow";
    hardwareClockInLocalTime = true;
  };
 
  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    autorun = true;
    libinput.enable = true; # touchpad support.
    desktopManager.xfce.enable = true;
    windowManager.i3.enable = true;
    displayManager = {
      defaultSession = "none+i3";
      autoLogin = {
        enable = true;
        user = "sergey";
      };
      lightdm = {
        enable = true;
      };
    };
    xkbModel = "Microsoft";
    xkbOptions = "grp:caps_toggle,grp_led:caps";
    xkbVariant = "winkeys";
    layout = "us,ru";
    xautolock.time = 10000;
  };

  fonts	= {
      fonts = with pkgs; [
        dejavu_fonts
        source-code-pro
        source-sans-pro
        source-serif-pro
        anonymousPro
        cm_unicode
        font-awesome_4
        google-fonts
      ];
      fontconfig = {
        defaultFonts = {
          # monospace = [ "Source Code Pro" ];
        };
      };
    };

 
 # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ 
    emacs
    emacs-all-the-icons-fonts
    numix-icon-theme-circle
    pcmanfm
    vivaldi
#    photoqt
#    vlc
#    gimp
#    inkscape
#    libreoffice
#    evince
#    skypeforlinux
#    zoom-us
    
    axel
    alsaTools
    fish
    lilyterm
    htop
    p7zip
    xarchiver
    feh
    i3blocks
    i3-gaps
    dmenu
    rofi
    usbutils
    git
    unrar
    
#    stack
#    cabal-install
#    hasklig
#    hlint
#    hpack
#    haskellPackages.haskell-lsp
#    pandoc
#    haskellPackages.hindent
    
    gnome3.networkmanagerapplet
    lxqt.lxqt-policykit
    mesa
    audacity
#    ffmpeg
#    mplayer
#    libmpeg2
#    celluloid
    acpi
#    hardinfo
#    lxappearance
#    p7zip
#    scrot
#    shutter
    wpa_supplicant_gui
 #   wxmaxima
    xarchiver
    xorg.xkill
#    youtube-dl
#    yandex-disk
  ];

  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
  };


  services = {
    gvfs.enable = true;
    blueman.enable = true;
    printing.enable = true;
    avahi.enable = true;
    avahi.nssmdns = true;
    emacs.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sergey = {
    isNormalUser = true;
    home = "/home/sergey"; 
    extraGroups = [ "wheel" "networkmanager" "sys" "lp" ]; # Enable ‘sudo’ for the user.
    shell = "/run/current-system/sw/bin/fish";
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
