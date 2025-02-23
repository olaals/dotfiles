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
  '';

  networking.firewall.allowedTCPPorts = [ 9010 9011 ];


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
    vim
    alacritty
    neovim
    wget
    git
    tmux
    chromium
    uv
    python313
    nodejs_22
    stow
    john
    sqlmap
    seclists
    ffuf
    gcc
    nmap
    openvpn
    ripgrep
    awscli
    tcpdump
    xclip
    fish
    gobuster
    samba # smbclient
    feh # bg image
  ];

  environment.shellAliases = {
    vim = "nvim";
  };

  environment.variables = {
    TERMINAL="alacritty";
  };





  system.stateVersion = "24.11";
}

