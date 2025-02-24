function set_profile
    source "$HOME/.local/bin/env.fish"
    echo "UV profile applied"
end

function unset_profile
    set -e HOME
    echo "UV profile removed"
end
