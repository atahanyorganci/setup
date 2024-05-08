function doc-functions -d "Generate markdown documentation for all user-defined functions"
    set -l readme $__fish_config_dir/functions/README.md
    debug "Writing functions documentation to $readme"
    printf "# Functions\n\n" >$readme
    for fn in (functions)
        set -l fn_path (functions -D $fn)
        if not string match -q $__fish_config_dir'/*' $fn_path
            continue
        end
        if git check-ignore -q $fn_path
            continue
        end
        set -l src (functions $fn)
        string match -qr '((--description)|(-d))( |=)(("|\')(?<desc>[^\'"]*)\6|(?<d>\w*))' $src
        string match -qr '((--wraps)|(-w))( |=)(("|\')(?<wrap>[^\'"]*)\6|(?<w>\w*))' $src

        echo -ne "- `$fn`" >>$readme
        if test -n "$wrap" -o -n "$w"
            # We don't care to concatenate the two variables here
            # because we know that only one of them will be set
            echo -ne " (`$wrap$w`)" >>$readme
        end
        if test -n "$desc" -o -n "$d"
            # Same here
            echo ": $desc$d" >>$readme
        else
            echo >>$readme
        end
    end
end
