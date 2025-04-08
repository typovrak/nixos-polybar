{ config, pkgs, ... }:

let
	username = "typovrak";
	group = config.users.users.${username}.group or "users";
	home = config.users.users.${username}.home;
in {
	system.activationScripts.polybar = ''
		mkdir -p ${home}/.config
		chown ${username}:${group} ${home}/.config
		chmod 755 ${home}/.config

		rm -rf ${home}/.config/polybar
		mkdir ${home}/.config/polybar
		chown ${username}:${group} ${home}/.config/polybar
		chmod 755 ${home}/.config/polybar

		cp ${home}/.config/polybar/config.ini
		chown ${username}:${group} ${home}/.config/polybar/config.ini
		chmod 644 ${home}/.config/polybar/config.ini

		cp ${home}/.config/polybar/mocha.ini
		chown ${username}:${group} ${home}/.config/polybar/mocha.ini
		chmod 644 ${home}/.config/polybar/mocha.ini

		cp ${home}/.config/polybar/audio.sh
		chown ${username}:${group} ${home}/.config/polybar/audio.sh
		chmod 755 ${home}/.config/polybar/audio.sh

		cp ${home}/.config/polybar/brightnessctl.sh
		chown ${username}:${group} ${home}/.config/polybar/brightnessctl.sh
		chmod 755 ${home}/.config/polybar/brightnessctl.sh
	'';

	environment.systemPackages = with pkgs; [
		polybar
	];
}
