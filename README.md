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
- incorporate direnv with conda environments i.e. keep conda as an option for projects that need it, and add conda env layer automatically as well
- nixify conda activation scripts (that are in $CONDA_PREFIX/etc/conda/activate.d). Conda seems to have no mechanism to add these declaratively via the env.yaml. See nectar access repo for example situation where this is required.
- julia via nix? Both julia and conda require FHS setup I think (see [here](https://github.com/olynch/scientific-fhs) for details
- set up dtach for lightweight detachable environments (i.e. main benefit of tmux without the glug)

