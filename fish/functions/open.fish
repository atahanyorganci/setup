function open --description 'Open file in its default application'
    if test (count $argv) -eq 0
        command xdg-open .
    else
        command xdg-open $argv
    end
end
