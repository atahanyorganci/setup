function bulk-slugify --description 'Slugify files in bulk'
    if test -z (count $argv)
        echo "Usage: mvs <file>..."
        return 1
    end
    for file in $argv
        set -l slug (slugify --path $file)
        debug "Renaming '$file' to '$slug'"

        # Check if slug is the same as the original file
        if test $file = $slug
            echo "File '$file' is already slugified"
            continue
        else if test -e $slug
            echo "File '$slug' already exists"
            return 1
        end
        mv $file $slug || return $status
    end
end
