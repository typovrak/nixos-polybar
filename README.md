# nixos-polybar

nixos-polybar = fetchGit {
	url = "https://github.com/typovrak/nixos-polybar.git";
	ref = "main";
};

(import "${nixos-polybar}/configuration.nix")
