function fish_prompt
    # Set profile color
    set profile_color cyan  # Default color

    # Display FISH_PROFILE dynamically
    if test -n "$FISH_PROFILE"
        set profile_indicator (set_color $profile_color)"[$FISH_PROFILE]"(set_color normal)" "
    else
        set profile_indicator ""
    end

    # Display profile, username, and hostname
    set_color blue
    echo -n $profile_indicator(whoami)@(hostname)
    set_color normal

    # Display full path in yellow
    set_color yellow
    echo -n " " (pwd)
    set_color normal

    # Show Git branch in magenta
    set -l git_branch (git branch --show-current 2>/dev/null)
    if test -n "$git_branch"
        set_color magenta
        echo -n " " "($git_branch)" " "
        set_color normal
    end

    # New line for readability
    echo

    # Display only the current directory in cyan
    set_color cyan
    echo -n (basename (pwd))
    set_color normal
    echo " "

end
