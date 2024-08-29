function c --description "Visiual Studio Code" --wraps code
    if test (count $argv) -gt 0
        command code $argv
    else
        command code .
    end
end
