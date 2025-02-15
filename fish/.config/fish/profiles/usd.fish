# USD Profile Settings
function set_profile
    set -gx PYTHONPATH "/Users/OALST/Installs/OpenUSD/lib/python"
    set -gx PATH "$PATH:/Users/OALST/Installs/OpenUSD/bin"
    echo "USD profile applied"
end

function unset_profile
    set -e PYTHONPATH
    set -gx PATH (string replace ":/Users/OALST/Installs/OpenUSD/bin" "" $PATH)
    echo "USD profile removed"
end
