{ config, pkgs, lib, ... }:

{
  home.username = "quack"; # Your username
  home.homeDirectory = "/home/quack"; # Adjust if needed

  # Fetch SecLists and place it in ~/tools/SecLists
  home.file."tools/SecLists" = {
    source = pkgs.fetchFromGitHub {
      owner = "danielmiessler";
      repo = "SecLists";
      rev = "2025.1"; # Use "rev" instead of "tag"
      sha256 = "5df89a39a2c01bc07a2a9bfea326df101818a683bd5e514baa14edcae8faa95d";
    };
    recursive = true;
  };

  # Fetch Impacket and place it in ~/tools/Impacket
  home.file."tools/impacket" = {
    source = pkgs.fetchFromGitHub {
      owner = "fortra";
      repo = "impacket";
      rev = "impacket_0_12_0"; # Tag for Impacket 0.12.0
      sha256 = "0yancqlcav5fam3hn48dsshqvkxb711ljz5v81mqfx40iivkbnsv"; # Replace with actual hash
    };
    recursive = true;
  };

  home.file."tools/php-malware-scanner" = {
    source = pkgs.fetchFromGitHub {
      owner = "scr34m";
      repo = "php-malware-scanner";
      rev = "1.0.27"; # Latest tag as per your request
      sha256 = "1jhh6rf5m3l0v2rip4yapm3pqc360v89jiikxnmvizi5z6kss7hd"; # Replace with actual hash
    };
    recursive = true;
  };

  home.file."tools/webshells" = {
    source = pkgs.fetchFromGitHub {
      owner = "BlackArch";
      repo = "webshells";
      rev = "e8e1a37"; # Specific commit
      sha256 = "1xqic9mzllv86pn2yf26lzzarn7vc5cj5rswqnv64g5cvb06rlbm"; # Replace with actual hash
    };
    recursive = true;
  };



  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}

