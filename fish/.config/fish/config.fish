if status is-interactive
end

# set -gx ENVIRONMENT Development
set -gx FISH_PROFILE default

source $HOME/.config/fish/profiles/default.fish

# Setting PATH
set -gx PATH $HOME/bin /usr/local/bin $PATH
set -gx PATH $PATH $HOME/projects/cli-tools
set -gx PATH $PATH $HOME/cli-tools
set -gx PATH /opt/homebrew/opt/node@16/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH

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
set -gx PATH "$HOME/.cargo/bin" $PATH

bind \cj accept-autosuggestion

set fish_greeting


set -g fish_color_command white
set -g fish_color_param white
set -g fish_color_quote white



set -Ux LSCOLORS Exfxcxdxbxegedabagacad









# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/OALST/miniconda3/bin/conda
    eval /Users/OALST/miniconda3/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<
#
#
if not set -q TMUX
    tmux new-session
end

fish_vi_key_bindings
