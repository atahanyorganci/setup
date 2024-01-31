function clone --description 'Clone git repository into development dir'
    argparse -n=clone -N 1 -X 1 g/github -- $argv || return $status

    gum log -l debug "Using $DEV_HOME as development directory"

    if test -n "$_flag_github"
        set -l parts (string split '/' $argv[1])
        set -l user $parts[1]
        set -l repo $parts[2]
        set -l repo_dir "$DEV_HOME/github/$user/$repo"
        gum log -l debug "Cloning $user/$repo into $repo_dir"

        mkdir -p $repo_dir
        gh repo clone $user/$repo $repo_dir || return $status
    else
        gum log -l fatal "No backend specified!" && return 1
    end
end
