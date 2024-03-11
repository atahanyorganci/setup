function __clone_github
    set -f user $argv[1]
    set -f repo $argv[2]
    set -f repo_dir "$DEV_HOME/github/$user/$repo"
    info "Cloning $user/$repo into $repo_dir"

    mkdir -p $repo_dir
    gh repo clone $user/$repo $repo_dir || return $status
end

function clone --description 'Clone git repository into development dir'
    argparse -n=clone -N 1 -X 1 g/github git -- $argv || return $status

    debug "Using $DEV_HOME as development directory"

    if string match -q -r 'https?:\/\/github.com\/(?<user>.+)\/(?<repo>.+)(\.git)?' $argv[1]
        debug "GitHub repository detected as $user/$repo"
        __clone_github $user $repo || return $status
    else if test -n "$_flag_github"
        if string match -q -r '(?<user>.+)\/(?<repo>.+)' $argv[1]
            debug "User: $user, Repo: $repo"
            __clone_github $user $repo || return $status
        else
            fatal "Invalid GitHub repository!" && return 1
        end
    else if test -n "$_flag_git"
        set -l parts (string split '/' $argv[1])
        set -l name (string replace '.git' '' $parts[-1])
        set -l repo_dir "$DEV_HOME/git/$name"

        info "Cloning $name into $repo_dir"
        mkdir -p $repo_dir
        git clone $argv[1] $repo_dir || return $status
    else
        fatal "No backend specified!" && return 1
    end
end
