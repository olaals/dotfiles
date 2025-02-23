function uvsh
    set -l venv_path ./.venv/bin/activate.fish

    if not test -f $venv_path
        echo (set_color red)"Error: Virtual environment not found!"(set_color normal)
        echo (set_color yellow)"Run 'uv venv .venv' to create one."(set_color normal)
        return 1
    end

    source $venv_path # Activate virtual environment
    env UVSHELL="uv:"(basename (pwd) | string trim) uv run fish --init-command "source .venv/bin/activate.fish"
    deactivate
end
