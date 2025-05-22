# ~/.zshrc file for zsh interactive shells.

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

# Use vi keybindings
bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

# Aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Set default editors
export EDITOR='nvim-lazy'
export VISUAL='nvim-lazy'

# Path modifications
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Add Zsh syntax highlighting and autosuggestions if available
# These need to be installed via apt or manually
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Load custom configuration files if they exist
if [ -d $HOME/.zsh ]; then
  for file in $HOME/.zsh/*.zsh; do
    source $file
  done
fi

# User customizations can be added to ~/.zshrc.local
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# Oh-My-Zsh configuration if installed
if [ -d ~/.oh-my-zsh ]; then
    # Defer to .zshrc.local for theme and plugin customization
    # but set reasonable defaults if nothing is found there
    if [ ! -f ~/.zshrc.local ] || ! grep -q "ZSH_THEME" ~/.zshrc.local; then
        ZSH_THEME="robbyrussell"
    fi

    # Default plugins
    plugins=(git docker sudo extract)
    
    source ~/.oh-my-zsh/oh-my-zsh.sh
fi
