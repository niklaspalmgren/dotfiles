export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode auto
HIST_STAMPS="yyyy-mm-dd"

plugins=(
    git
    fzf
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Plugins from system install
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Custom config
source ~/.config/zsh/exports.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/functions.zsh
source ~/.config/zsh/zoxide.zsh
source ~/.config/zsh/hsb.zsh

# Base16 theme
source ~/.config/themes/generated/zsh/gruvbox-material-dark-hard.zsh

# Prompt
eval "$(starship init zsh)"
