{ config, pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  imports =
    [ 
      ./hardware-configuration.nix
    ];

  networking.extraHosts = ''
    10.129.58.26   thetoppers.htb
    10.129.58.26   s3.thetoppers.htb
    
    10.10.11.130   internal-administration.goodgames.htb
    10.10.11.242   devvortex.htb dev.devvortex.htb

    10.10.11.143   office.paper chat.office.paper
    10.10.11.189   precious.htb
    10.10.11.11    board.htb crm.board.htb
    
  '';

  networking.firewall.allowedTCPPorts = [ 9010 9011 389 1389 8000 80 ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";

  services.spice-vdagentd.enable = true;

  # Enable i3 as the window manager.
  services.xserver.windowManager.i3.enable = true;

  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "no";
    variant = "mac";
    options = "lv3:lalt_switch,lv3:ralt_switch";
  };

  console.keyMap = "no";

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.sessionVariables = {
    IBUS_ENABLE_SYNC_MODE = "1";
  };


  users.users.quack = {
    isNormalUser = true;
    description = "quack";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  services.xserver = {
    enable = true;
  };

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [
    # GENERAL
    vim
    git
    fish
    alacritty
    neovim
    wget
    tmux
    chromium
    firefox
    nodejs_22
    stow
    ripgrep
    unzip
    docker
    tmuxinator
    xclip
    xorg.xdpyinfo
    file
    gcc
    feh # bg image
    # PYTHON
    uv
    python312
    python312Packages.typer
    python312Packages.requests
    python312Packages.fastapi
    python312Packages.cryptography
    python312Packages.httpx
    python312Packages.impacket
    # OFFSEC
    metasploit
    openvpn
    john
    sqlmap
    ffuf
    nmap
    awscli
    tcpdump
    gobuster
    samba # smbclient
    evil-winrm
    burpsuite
    php
    wireshark # analyze network layer
    nssTools
    gospider
    lftp # ftp command
    sqlite
    tcpdump
    jdk23
    maven
    hashid
    exploitdb
    mitmproxy
    hurl
    exiftool
  ];

  environment.shellAliases = {
    vim = "nvim";
  };

  environment.variables = {
    TERMINAL="alacritty";
  };


  virtualisation.docker.enable = true;



  system.stateVersion = "24.11";
}

