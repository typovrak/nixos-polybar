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

		ln -sf ${./polybar} ${home}/.config/polybar
		chown -h ${username}:${group} ${home}/.config/polybar
		chmod -h 755 ${home}/.config/polybar

		chown -h ${username}:${group} ${home}/.config/polybar/config.ini
		chmod -h 644 ${home}/.config/polybar/config.ini

		chown -h ${username}:${group} ${home}/.config/polybar/mocha.ini
		chmod -h 644 ${home}/.config/polybar/mocha.ini

		chown -h ${username}:${group} ${home}/.config/polybar/audio.sh
		chmod -h 755 ${home}/.config/polybar/audio.sh

		chown -h ${username}:${group} ${home}/.config/polybar/brightnessctl.sh
		chmod -h 755 ${home}/.config/polybar/brightnessctl.sh
	'';

	environment.systemPackages = with pkgs; [
		polybar
	];
}
