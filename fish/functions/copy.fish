function copy --description 'Copy piped STDIN or arguments into the clipboard'
    if test (count $argv) = 0
        command xclip
    else
        command echo $argv | xclip
    end
end
