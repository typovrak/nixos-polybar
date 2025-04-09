{ config, pkgs, ... }:

let
	username = "typovrak";
	group = config.users.users.${username}.group or "users";
	home = config.users.users.${username}.home;
in {
	system.activationScripts.polybar = ''
		mkdir -p ${home}/.config
		chown ${username}:${group} ${home}/.config
		chmod 700 ${home}/.config

		rm -rf ${home}/.config/polybar
		mkdir ${home}/.config/polybar
		chown ${username}:${group} ${home}/.config/polybar
		chmod 700 ${home}/.config/polybar

		cp ${./config.ini} ${home}/.config/polybar/config.ini
		chown ${username}:${group} ${home}/.config/polybar/config.ini
		chmod 600 ${home}/.config/polybar/config.ini

		cp ${./mocha.ini} ${home}/.config/polybar/mocha.ini
		chown ${username}:${group} ${home}/.config/polybar/mocha.ini
		chmod 600 ${home}/.config/polybar/mocha.ini

		cp ${./audio.sh} ${home}/.config/polybar/audio.sh
		chown ${username}:${group} ${home}/.config/polybar/audio.sh
		chmod 700 ${home}/.config/polybar/audio.sh

		cp ${./brightnessctl.sh} ${home}/.config/polybar/brightnessctl.sh
		chown ${username}:${group} ${home}/.config/polybar/brightnessctl.sh
		chmod 700 ${home}/.config/polybar/brightnessctl.sh
	'';

	environment.systemPackages = with pkgs; [
		polybar
		brightnessctl
	];
}
