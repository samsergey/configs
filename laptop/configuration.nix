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

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable=true;
  # networking.wireless = 
  # { enable = true;  # Enables wireless support via wpa_supplicant.
  #   userControlled.enable = true;
  #   networks = { 
  #     Vulkanarium = {
  #       psk = "vulkanextra";
  #     };
  #     MikroTik = {
  #     	psk = "2012Index1112";
  #     };
  #     "Mi Note 10 Lite" = {
  #       psk = "spcb7464";
  #     };
  #     "Oecumene" = {
  #       psk = "eucumene34!";
  #     };
  #     "photel" = {
  #       psk = "21017";
  #     };  
  #   };
  # };
  

  fileSystems."/home" = 
  { device = "/dev/disk/by-label/home";
    fsType = "ext4";
  };

  fileSystems."/mnt/share" = {
    device = "//WORK060/Сетевая папка";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };


  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  time = {
    timeZone = "Asia/Kamchatka";
    hardwareClockInLocalTime = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ 
    emacs
    numix-icon-theme
    pcmanfm
    chromium
    photoqt
    vlc
    gimp
    inkscape
    libreoffice
    evince
    okular
    skypeforlinux
    zoom-us
    
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
    
    stack
    cabal-install
    hasklig
    hlint
    hpack
    tabnine
    haskellPackages.fingertree
    haskellPackages.hspec
    haskellPackages.haskell-lsp
    
    gnome3.networkmanagerapplet
    lxqt.lxqt-policykit
    mesa
    audacity
    ffmpeg
    mplayer
    libmpeg2
    celluloid
    acpi
    hardinfo
    lxappearance
    p7zip
    scrot
    shutter
    wpa_supplicant_gui
    wxmaxima
    xarchiver
    xorg.xkill
    youtube-dl
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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

  services = {
    gvfs.enable = true;
    blueman.enable = true;
  };

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sergey = {
    isNormalUser = true;
    home = "/home/sergey"; 
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = "/run/current-system/sw/bin/fish";
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

  nixpkgs.config.allowUnfree = true;
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

