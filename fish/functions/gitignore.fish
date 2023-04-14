function gitignore --description 'Choose and copy .gitignore from github/gitignore'
    argparse -n gitignore i/init u/update l/list d/dest= -- $argv

    # github/gitignore should be locally available
    set -l data_dir $HOME/.local/share
    set -l repo $data_dir/gitignore

    # Initialize `gitignore` by cloning github/gitignore to $HOME/.local/share/gitignore
    if test -n "$_flag_init"
        printf "Downloading github/gitignore to %s..." $repo
        mkdir -p $repo && git clone "https://github.com/github/gitignore" $repo >/dev/null 2>&1
        if test $status -eq 0
            printf " DONE!\n"
            return
        else
            printf " FAILED!\n"
            echo "run gitignore --init to try again"
            return 1
        end
    end

    # If $HOME/.local/share/gitignore isn't a directory, exit with error
    if test ! -d $repo
        echo "github/gitignore not found in $repo"
        echo "run gitignore --init to download it"
        return 1
    end

    # Update `gitignore` by pulling latest changes from github/gitignore
    if test -n "$_flag_update"
        printf "Updating github/gitignore in %s..." $repo
        set -l last $PWD
        cd $repo && git pull >/dev/null 2>&1
        set -l pull $status
        cd $last
        if test $pull -eq 0
            printf " DONE!\n"
            return
        else
            printf " FAILED!\n"
            echo "run gitignore --update to try again"
            return 1
        end
    end

    if test -n "$_flag_dest"
        set -f dest "$_flag_dest"
    else
        set -f dest ".gitignore"
    end

    set -l list (ll $repo/*.gitignore | awk '{ n = split($7, a, "/"); print a[n]; }')
    if test -n "$_flag_list"
        echo "Available gitignore files:"
        printf "%s\n" $list
    else
        if test (count $argv) = 1
            set -f file $argv[1]
        else
            set -f file ""
        end
        set -l ignore (printf "%s\n" $list | fzf --query="$file" --preview="bat $repo/{} -l gitignore ")
        echo "Copying '$ignore' to $dest"
        if test -z "$ignore"
            return 1
        else
            cp $repo/$ignore $dest
        end
    end
end