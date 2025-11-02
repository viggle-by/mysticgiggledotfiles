if status is-interactive
    # Commands to run in interactive sessions can go here
end
function prompt_path
    set path (pwd)
    set home $HOME
    set win_home "C:\\Users\\(whoami)"

    if string match -r "^$home" $path
        set path (string replace -r "^$home" $win_home $path)
    else
        set path "C:\\(string replace -r '^/' '' $path)"
    end

    # Replace / with \
    set path (string replace "/" "\\" $path)
    echo $path
end

function git_branch
    set branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
    if test -n "$branch"
        echo " (set_color yellow)[$branch](set_color normal)"
    end
end

function fish_prompt
    set_color blue
    echo -n "PS "
    set_color cyan
    echo -n (prompt_path)
    echo -n (git_branch)
    set_color normal
    echo -n "> "
end
