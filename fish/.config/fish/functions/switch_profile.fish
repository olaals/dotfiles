function switch_profile
    set profiles_dir ~/.config/fish/profiles

    # If "list" argument is given, list all profiles
    if test "$argv" = "list"
        echo "Available profiles:"
        for profile in $profiles_dir/*.fish
            echo "  " (basename $profile .fish)
        end
        return
    end

    # Unset the previous profile before switching
    if test -n "$FISH_PROFILE"
        if functions -q unset_profile
            unset_profile
        end
    end

    # Check if the profile exists and switch to it
    if test -f "$profiles_dir/$argv.fish"
        set -gx FISH_PROFILE $argv  # Set new profile
        source "$profiles_dir/$argv.fish"

        # Call set_profile function if it exists
        if functions -q set_profile
            set_profile
        end
    else
        echo "Profile not found: $argv"
    end
end
