function clone --description 'Clone git repository into development dir'
    argparse -n=clone -N 1 -X 1 g/github git -- $argv || return $status

    debug "Using $DEV_HOME as development directory"

    if test -n "$_flag_github"
        set -l parts (string split '/' $argv[1])
        set -l user $parts[1]
        set -l repo $parts[2]
        set -l repo_dir "$DEV_HOME/github/$user/$repo"
        info "Cloning $user/$repo into $repo_dir"

        mkdir -p $repo_dir
        gh repo clone $user/$repo $repo_dir || return $status
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
