{ config, pkgs, ... }:
let

##set up custom vim plugins
customPlugins = {
    onedark = pkgs.vimUtils.buildVimPlugin {
        name = "onedark";
        src = pkgs.fetchgit {
            url = "https://github.com/joshdick/onedark.vim";
            rev = "7db2ed5b825a311d0f6d12694d4738cf60106dc8";
            sha256 = "sha256-HdeZkzWcfIh5egXnGTatCfofOv29R7O548APJFf1tks";
        };
        meta = {
            homepage = https://github.com/joshdick/onedark.vim;
            maintainers = [ "joshdick" ];
        };
    };
    doom-one =pkgs.vimUtils.buildVimPlugin {
        name = "doom-one";
        src = pkgs.fetchgit {
            url = "https://github.com/romgrk/doom-one.vim";
            rev = "208cb28ed1d81d9207509f7254f436335822ec93";
            sha256 = "sha256-7KUC4hYfcyTXc28btP5q5ngiNHduZl2hYsmd9qdWLbU";
        };
        meta = {
            homepage = https://github.com/romgrk/doom-one.vim;

            maintainers = [ "romgrk" ];
        };
    };
};
allPlugins = pkgs.vimPlugins // customPlugins;


in
{
	# Home Manager needs a bit of information about you and the
	# paths it should manage.
	home.username = "osbornejr";
	home.homeDirectory = "/Users/osbornejr";
        
        #home.sessionVariables.EDITOR = "vim";
	#Packages that are installed for user profile
	home.packages = with pkgs; [
		htop
		thefuck
		dtach
		ripgrep
		m-cli
	];
	# This value determines the Home Manager release that your
	# configuration is compatible with. This helps avoid breakage
	# when a new Home Manager release introduces backwards
	# incompatible changes.
	#
	# You can update Home Manager without changing this value. See
	# the Home Manager release notes for a list of state version
	# changes in each release.
	home.stateVersion = "22.05";

        #enable xdg directories
        #xdg.enable = true;
        #xdg.configFile."toto".text = ''
        #  hello world
        #'';

        #xdg.configFile = "~
	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;


        ##automatically enter shell.nix envs in directories
        programs.direnv = {
          enable = true;
          nix-direnv.enable = true;
        };



	# manage zsh shell
	programs.zsh = {
		enable = true;
		autocd = true;
		dotDir = ".config/zsh";
		enableAutosuggestions = true;
		enableCompletion = true;
		shellAliases = {

			ll = "ls -lh";
			la = "ls -lha";
			update = "home-manager switch";
			enix = "vim ~/.config/nixpkgs/home.nix";
			szsh = ". ~/.config/zsh/.zshrc";
		};
		history = {
			size = 10000;
			path = ".config/zsh/history";
		};


		# zsh plugin management
		#oh-my-zsh = {
		#	enable = true;
		#	plugins = [ "git" "thefuck" ];
		#	custom =
		#	theme = "common";
		#};
		zplug = {
			enable = true;
                        ##TODO this doesn't work properly atm as (on mac at least) this needs to be loaded in .zprofile not .zshrc. manually added to .zprofile for now
                        zplugHome = toString ../zsh;
			plugins = [
			{name = "plugins/git"; tags = [from:oh-my-zsh]; }
			{name = "plugins/thefuck"; tags = [from:oh-my-zsh]; }
			{name = "zsh-users/zsh-history-substring-search"; }
			#{ name = "zsh-users/zsh-autosuggestions"; }
			# Installations with additional options. For the list of options, please refer to Zplug README.
			{ name = "jackharrisonsherlock/common"; tags = [ as:theme depth:1 ]; }
			];
		};

                initExtra =
                        ''
                        #hook for direnv
                        eval "$(direnv hook zsh)"
                        #make direnv execute quietly when entering/leaving dirs
                        export DIRENV_LOG_FORMAT=
                        #Keybindings
			bindkey '^[[A' history-substring-search-up
                        bindkey '^[[B' history-substring-search-down
                        #Window title (in kitty at least)
                        #precmd () {print -Pn "\e]0;%~\a"}
                        ## enable brew command TODO install brew via nix
                        eval "$(/opt/homebrew/bin/brew shellenv)"
                        export HOMEBREW_NO_GITHUB_API=1
                        '';
	};
        programs.vim = {
            enable = true;
            packageConfigurable = pkgs.vim_configurable.override {
              python = pkgs.python3;
              guiSupport = "no";
              darwinSupport = true;
            };
            plugins = with allPlugins; [
                vim-airline
                vim-airline-themes
                vim-dispatch
                vim-fugitive
                julia-vim
                vim-nix
                vim-slime
                onedark
                doom-one

            ];
            settings = {
                backupdir = ["~/.config/vim/backup//"];
                directory = ["~/.config/vim/swap//"];
                undodir   = ["~/.config/vim/undo//"];
                undofile = true;
                number = true;
                #allow terminal buffers to hide
                hidden = true;
                #configure tab characters
                shiftwidth = 4;
                expandtab = true;
            };
            extraConfig = ''
              "continue to configure tab characters
              set viminfo+=n~/.config/vim/viminfo
              set smarttab
              "load colorschemes
              packloadall
              "set background to terminal colour
              let g:onedark_color_overrides = { "background": { "gui": "#242730", "cterm": "235", "cterm16": "0" }} 
              set termguicolors
              colorscheme onedark
              "line settings
              set cursorline
              hi CursorLine   cterm=NONE ctermbg=black
              hi CursorLineNR cterm=bold ctermbg=black
              highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
              "set comment color manually (TODO not working at present... need to set up full custom colorscheme?)
              hi Comment ctermfg=DarkGray
              "better way to set this (and all vim config)?
              "global buffer list
              nnoremap gb :ls<CR>:b<Space>
              "switch to previous buffer
              nnoremap fb :b#<CR>
              " hack to get everything working for now
              so ~/.vim/vimrc
            '';
        };

        ##fuzzy search (necessary?)
	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};

        #improved cat
        programs.bat = {
          enable = true;
          config = {
            theme = "GitHub";
            italic-text = "always";
          };
        };

        # manage git
        programs.git = {
          enable = true;
          userName = "osbornejr";
          userEmail = "joelwilliamrobertson@gmail.com";
          ignores = [
            ".direnv"
            ];
        };

}

