[![NixOS 24.11+](https://img.shields.io/badge/NixOS-24.11%2B-a6e3a1?labelColor=45475a)](https://nixos.org/)
[![License MIT](https://img.shields.io/badge/License-MIT-cba6f7.svg?labelColor=45475a)](LICENSE.md)
[![Buy me a coffee](https://img.shields.io/badge/Buy%20me%20a%20coffee-☕-fab387?labelColor=45475a)](https://typovrak.tv/coffee)
[![Portal](https://img.shields.io/badge/Portal-typovrak.tv%2Fnixos-eba0ac?labelColor=45475a)](https://typovrak.tv/nixos)
[![Discord join us](https://img.shields.io/badge/Discord-Join%20us-74c7ec?labelColor=45475a&logo=discord&logoColor=white)](https://typovrak.tv/discord)

# 🎨 NixOS Polybar

> NixOS module for Catppuccin mocha green themed Polybar with helper scripts and OBS indicator.

## 🧩 Part of the Typovrak NixOS ecosystem

This module is part of ```Typovrak NixOS```, a fully modular and declarative operating system configuration built entirely with :

- 🧱 **30+ standalone modules :** Each managing a specific tool, feature or aesthetic like ```zsh```, ```i3```, ```lighdm```, ```polybar```, ```gtk``` and more.
- 🎨 **Catppuccin Mocha :** The default theme across terminal, GUI, and login interfaces.
- 🛡️ **100% FOSS compliant :** No proprietary software included unless explicitly chosen.
- 🧑‍💻 **Built for developers :** Optimized for speed, keyboard-centric workflows and expressive CLI tooling.

*Explore the full system : 👉 [github.com/typovrak/nixos](https://github.com/typovrak/nixos)*

> [!CAUTION]
> This module is opinionated, it may **override**, **replace**, or **remove** files and settings **without** prompt. To avoid unexpected changes, **back up** your existing files or **fork** this module to take full control. **Follow this documentation** to avoid any of this problem.

## 📦 Features

- 🔒 **Secure config directory :** Creates and protects ```~/.config/polybar``` with ```700``` permissions and proper ownership.
- 🎨 **Catppuccin mocha green theme :** Applies a cohesive Catppuccin mocha green color scheme across your bar.
- 📁 **Config & scripts deployment :** Installs ```config.ini```, ```mocha.ini``` plus helper scripts ```audio.sh```, ```brightnessctl.sh``` and ```obs.sh```) with correct modes.
- 🚨 **OBS indicator :** If OBS is running, the right-most module turns bright red.
- 🔄 **Idempotent :** Cleans and recreates the config folder on each rebuild for consistent state.
- ⚙️ **Zero-friction setup :** No manual file copying, just import and rebuild.
- 📦 **Dependency handling :** Ensures ```polybar``` and ```brightnessctl``` are in ```environment.systemPackages```.
- 💾 **Backup guidance :** Documentation includes commands to back up any existing Polybar configs.

## 📂 Repository structure

```bash
❯ tree -a -I ".git*"
.
├── audio.sh          # audio volume control module
├── brightnessctl.sh  # brightness control module
├── config.ini        # main polybar configuration
├── configuration.nix # module configuration
├── LICENSE.md        # MIT license
├── mocha.ini         # catppuccin mocha green theme
├── obs.sh            # OBS studio status indicator
└── README.md         # this documentation

1 directory, 8 files
```

## ⚙️ Prerequisites

### 1. NixOS version
Requires NixOS 24.11 or newer.

### 2. User validation
the target user must be defined in ```config.username```. See [typovrak main nixos configuration](https://github.com/typovrak/nixos) for more details.

### 3. Backup
Before proceeding, back up existing configuration if needed
```bash
cp ~/.config/polybar{,.bak}
```

## ⬇️ Installation

### 🚀 Method 1 : Out-of-the-box

Fetch the module directly in your [main nixos configuration](https://github.com/typovrak/nixos) at ```/etc/nixos/configuration.nix``` using fetchGit
```nix
# /etc/nixos/configuration.nix

let
  nixos-polybar = fetchGit {
    url = "https://github.com/typovrak/nixos-polybar.git";
    ref = "main";
    rev = "44e2aedb84c5f724d18b99625f6eb7f2daa17788"; # update to the desired commit
  };
in
{
  imports = [
    /etc/nixos/hardware-configuration.nix # system hardware settings
    /etc/nixos/variables.nix # defines config.username and other variables, see https://github.com/typovrak/nixos for more details
    (import "${nixos-polybar}/configuration.nix")
  ];
}
```

Once imported, rebuild your system to apply changes
```bash
sudo nixos-rebuild switch
```

### 🍴 Method 2 : Fork

Want to **personalize** this module ?

Fork it and add this custom module in your [main nixos configuration](https://github.com/typovrak/nixos) at ```/etc/nixos/configuration.nix``` using fetchGit
```nix
let
  nixos-polybar = fetchGit {
    url = "https://github.com/<YOUR_USERNAME>/nixos-polybar.git";
    ref = "main";
    rev = "<COMMIT>"; # see below
  };
in {
  imports = [
    /etc/nixos/hardware-configuration.nix # system hardware settings
    /etc/nixos/variables.nix # defines config.username and other variables, see https://github.com/typovrak/nixos for more details
    (import "${nixos-polybar}/configuration.nix")
  ];
}
```

Get the latest commit hash by executing
```bash
git clone https://github.com/<YOUR_USERNAME>/nixos-polybar.git &&
cd nixos-polybar &&
git log -1 --pretty=format:"%H"
```

## 🎬 Usage

Test this polybar configuration with
```bash
polybar --reload main
```

Add to your session startup, ```~/.xsession``` or Window Manager configuration like ```~/.config/i3/config``` for i3
```bash
exec_always --no-startup-id polybar --reload main
```

When OBS Studio is running, the OBS module on the far right glows red.

## 📚 Learn more

- 🧠 [Polybar wiki](https://github.com/polybar/polybar/wiki) : Official documentation for module formatting and customizations.
- 🎨 [Catppuccin polybar theme](https://github.com/catppuccin/polybar) : Theme repository with color presets and showcase.
- 🛠️ [Polybar GitHub repository](https://github.com/polybar/polybar) : Source code and latest development updates.

## 🌐 Discover my NixOS system portal

Dive into [typovrak.tv/nixos](https://typovrak.tv/nixos) Catppuccin mocha green themed **gateway** to my GitHub and NixOS setup.

Browse **every module**, example and config in a sleek with an interactive interface that feels just like your desktop.

## ❤️ Support

If this module saved you time, please ⭐️ the repo and share feedback.  
You can also support me on ☕ [Buy me a coffee](https://typovrak.tv/coffee)

## 💬 Join the Typovrak community on Discord 🇫🇷

If you've ever ```rm -rf```ed your config by mistake or rebuilt for the 42nd time because a semicolon was missing…

You're not alone, **Welcome home !**

🎯 [Join us on Discord »](https://typovrak.tv/discord)

🧭 What you’ll find is :

- ```💻 #nixos-setup``` - get help with modules, rebuilds and configs.
- ```🌐 #web-dev``` - talk JS, TypeScript, React, Node and more.
- ```🧠 #open-source``` - share your repos, contribute to others and discuss FOSS culture.
- ```⌨️ #typing``` - layouts, mechanical keyboards and speed goals.
- ```🎨 #ricing``` - dotfiles, theming tips and desktop screenshots.

*Everyone's welcome no matter how many times you've broken your system ~~(except for Windows users)~~ 😄*

---

<p align="center"><i>Made with 💜 by <a href="https://typovrak.tv">typovrak</a></i></p>
