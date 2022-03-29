# Nix config

`home-manager` configuration for Nix language environment control on macOS. 

To install Nix, run `curl -L https://nixos.org/nix/install | sh`.
To setup and install `home-manager`, use the manual [here](https://rycee.gitlab.io/home-manager/). 

### TODO
- Add `nix-darwin` for system configuration support
- Add `nix-flakes` to manage dependencies cleanly (and update fully to new Nix syntax)
- check out [this method](https://github.com/vic/mk-darwin-system//) which might make the above simpler.
- add `yabai` window manager via nix
    - set up Spaces with `yabai`
- add Homebrew (for casks only) via nix config
- install kitty (and kitty.conf) via nix
- add conda via nix? probably necessary for bioinformatics stuff



