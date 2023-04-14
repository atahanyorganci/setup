function doc_functions -d "Generate markdown documentation for all user-defined functions"
    if test (pwd) != $__fish_config_dir
        echo "You should be in '$__fish_config_dir' to run this command"
        return 1
    end
    printf "# Functions\n\n"
    for fn in (functions)
        set -l fn_path (functions -D $fn)
        if not string match -q $__fish_config_dir'/*' $fn_path
            continue
        end
        if git check-ignore -q $fn_path
            continue
        end
        set -l src (functions $fn)
        string match -qr '.*((description)|d)( |=)("|\')(?<desc>[^"\']*)\4.*' $src
        string match -qr '.*((wraps)|w)( |=)("|\')(?<wrap>[^"\']*)\4.*' $src
        echo -ne "- `$fn`"
        if test -n "$wrap"
            echo -ne " (`$wrap`)"
        end
        if test -n "$desc"
            echo ": $desc"
        else
            echo
        end
    end
end
