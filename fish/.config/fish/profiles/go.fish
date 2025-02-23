function set_profile
    set -gx PATH $HOME/.goenv/bin $PATH
    status --is-interactive; and source (goenv init - | psub)
    echo "Go profile applied"
end

function unset_profile
    set -gx PATH (string replace "$HOME/.goenv/bin" "" $PATH)
    echo "Go profile removed"
end
