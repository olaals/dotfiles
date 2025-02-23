{ config, pkgs, lib, ... }:

{
  home.username = "quack"; # Your username
  home.homeDirectory = "/home/quack"; # Adjust if needed

  # Fetch SecLists and place it in ~/.SecLists
  home.file."tools/SecLists" = {
    source = pkgs.fetchFromGitHub {
      owner = "danielmiessler";
      repo = "SecLists";
      tag = "2025.1";
      sha256 = "5df89a39a2c01bc07a2a9bfea326df101818a683bd5e514baa14edcae8faa95d";
    };
    recursive = true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}

