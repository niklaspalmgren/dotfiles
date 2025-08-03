# If you come from bash you might have to change your $PATH.
export PATH=${PATH}:${HOME}/.local/bin

# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
 
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Add .NET Core SDK tools
export PATH="$PATH:/home/np/.dotnet/tools"

# Electron wayland
export ELECTRON_OZONE_PLATFORM_HINT=wayland

# Tell SSH clients where to find the running SSH agent's socket
export SSH_AUTH_SOCK="/run/user/1000/ssh-agent.socket"
