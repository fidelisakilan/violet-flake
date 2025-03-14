{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  services.xserver.videoDrivers = ["nvidia"];
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.flatpak.enable = true;
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
  };
  
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  environment.systemPackages = with pkgs; [
  gcc
  gnumake
  wget
  git
  tmux
  neovim
  nnn
  neofetch
  ghostty
  firefox
  protonup-qt
  stow
  btop
  killall
  wl-clipboard
  unzip
  alejandra
  mangohud
  alsa-utils
  playerctl
  brightnessctl
  jq
  gnome-tweaks
  gamescope
  ];
  
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-cove
    font-awesome
    iosevka
    liberation_ttf
    source-code-pro
  ];
  
  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
    autosuggestions.enable = true;
  };
  programs.starship.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [];
  
  networking.hostName = "violet";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  users.users.fidelisakilan = {
    isNormalUser = true;
    description = "Fidelis Akilan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  users.defaultUserShell = pkgs.zsh;
  system.stateVersion = "24.11";
}
