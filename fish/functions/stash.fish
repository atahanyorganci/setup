function stash --description 'Stash changes in Git repository'
    if test (count $argv) -eq 1
        command git stash -u -m $argv[0] || return 1
    else
        set -l msg (gum input --placeholder="Stash message")
        if test -z "$msg"
            return 1
        end
        command git stash -u -m $msg || return 1
    end
end
