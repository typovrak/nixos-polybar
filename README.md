# 🎨 NixOS Polybar

> NixOS module for Catppuccin mocha green themed Polybar with helper scripts and OBS indicator.

## 📦 Features

- 🔒 **Secure config directory :** Creates and protects ```~/.config/polybar``` with ```700``` permissions and proper ownership.

- 🎨 **Catppuccin mocha green theme :** Applies a cohesive Catppuccin mocha green color scheme across your bar.

- 📁 **Config & scripts deployment :** Installs ```config.ini```, ```mocha.ini``` plus helper scripts ```audio.sh```, ```brightnessctl.sh``` and ```obs.sh```) with correct modes.

- 🚨 **OBS indicator :** If OBS is running, the right-most module turns bright red.

- 🔄 **Idempotent :** Cleans and recreates the config folder on each rebuild for consistent state.

- ⚙️ **Zero-friction setup :** No manual file copying, just import and rebuild.

- 📦 **Dependency handling :** Ensures ```polybar``` and ```brightnessctl``` are in ```environment.systemPackages```.

- 💾 **Backup guidance :** Documentation includes commands to back up any existing Polybar configs.

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

## 🚀 Installation
Fetch the module directly in your main nixos configuration at ```/etc/nixos/configuration.nix``` using fetchGit
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

## ❤️ Support

If this module saved you time, please ⭐️ the repo and share feedback.  
You can also support me on ☕ [Buy me a coffee](https://www.buymeacoffee.com/typovrak).

## 📝 License

Distributed under the [MIT license](LICENSE.md).

## 📜 Code of conduct

This project maintains a [code of conduct](.github/CODE_OF_CONDUCT.md) to ensure a respectful, inclusive and constructive community.

## 🛡️ Security

To report vulnerabilities or learn about supported versions and response timelines, please see our [security policy](.github/SECURITY.md).

---

<p align="center"><i>Made with 💜 by typovrak</i></p>
