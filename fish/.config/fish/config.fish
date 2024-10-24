if status is-interactive
end


# Setting PATH
set -gx PATH $HOME/bin /usr/local/bin $PATH
set -gx PATH $PATH $HOME/projects/cli-tools
set -gx PATH /opt/homebrew/opt/node@16/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH

set -gx PATH $HOME/.goenv/bin $PATH


status --is-interactive; and source (goenv init - | psub)


# Aliases
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




function fish_prompt
    # Display username and hostname in cyan
    set_color blue
    echo -n (whoami)@(hostname)
    set_color normal

    # Display full path in blue
    set_color yellow
    echo -n " " (pwd)
    set_color normal


    set -l git_branch (git branch --show-current 2>/dev/null)
    if test -n "$git_branch"
        set_color magenta
        echo -n " " "($git_branch)" " "
    end

    # New line
    echo

    # Display only the current directory in green
    set_color cyan
    echo -n (basename (pwd))
    set_color normal
    echo " "

    # Display Git branch in red if in a Git repository

end





# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/OALST/miniconda3/bin/conda
    eval /Users/OALST/miniconda3/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<
#
#

ca py311
