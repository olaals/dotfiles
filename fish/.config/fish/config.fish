if status is-interactive
end

fish_vi_key_bindings
bind -M insert \cj accept-autosuggestion

# set -gx ENVIRONMENT Development
set -gx FISH_PROFILE default

source $HOME/.config/fish/profiles/default.fish

# Setting PATH
set -gx PATH $HOME/bin /usr/local/bin $PATH
set -gx PATH $PATH $HOME/projects/cli-tools
set -gx PATH $PATH $HOME/cli-tools
set -gx PATH $PATH $HOME/tools/cli-tools
set -gx PATH /opt/homebrew/opt/node@16/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx SECLISTS $HOME/tools/SecLists

switch (uname)
    case Darwin
        # echo "Running on Macos"
        source "$HOME/.local/bin/env.fish"
        set -gx PATH $PATH $HOME/tools/cli-tools/macos
    case Linux
        # echo "Running on Linux"
        set -gx PATH $PATH $HOME/tools/cli-tools/linux
    case '*'
        echo "Unknown OS"
end

alias azlogin="env BROWSER='/Applications/Safari.app/Contents/MacOS/Safari' az login"

alias chromium-burp="chromium --proxy-server='http://127.0.0.1:8080' --user-data-dir=(mktemp -d)"

# Aliases
alias openvpn='/opt/homebrew/opt/openvpn/sbin/openvpn'
alias sp='switch_profile'
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
alias devc="/Users/OALST/projects/nvim-devc/devc"
alias marktext="open -a 'MarkText'"
alias chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
alias vim="nvim"
alias ca="conda activate"
alias l="ls -1"
alias sl="ls -1"
#alias ls="ls -1"
if test (uname) = Darwin # MAC OS
    alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
end
#
git config --global alias.lg "log --graph --pretty=tformat:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --decorate=full"

alias k="kubectl"
alias godot-voxel="/Users/OALST/dev/godot-voxel/bin/godot.macos.editor.arm64.mono"

alias startollama='OLLAMA_FLASH_ATTENTION="1" OLLAMA_KV_CACHE_TYPE="q8_0" /opt/homebrew/opt/ollama/bin/ollama serve'
set -gx PATH "$HOME/.cargo/bin" $PATH

set fish_greeting

set -g fish_color_command white
set -g fish_color_param white
set -g fish_color_quote white

set -Ux LSCOLORS Exfxcxdxbxegedabagacad

if test -d "$HOME/.local/bin"
    if not contains "$HOME/.local/bin" $PATH
        set -gx PATH $PATH $HOME/.local/bin
    end
end

if test -d "$HOME/apps"
    if not contains "$HOME/apps" $PATH
        set -gx PATH $PATH $HOME/apps
    end
end

if not set -q TMUX
    tmux new-session
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/OALST/Downloads/google-cloud-sdk/path.fish.inc' ]
    . '/Users/OALST/Downloads/google-cloud-sdk/path.fish.inc'
end
