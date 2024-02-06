function __gum_log_to_int --argument-names level --description "Convert log level to integer"
    switch $level
        case debug
            echo 0
        case info
            echo 1
        case warn
            echo 2
        case error
            echo 3
        case fatal
            echo 4
        case off
            echo 5
        case ''
            echo 1
        case '*'
            gum log -l fatal "Unknown log level $level" && exit 1
    end
end

function log --description "Log message using gum"
    set -l config (__gum_log_to_int $GUM_LOG_LEVEL || exit 1)
    set -l level (__gum_log_to_int $argv[1])
    if test $level -ge $config
        gum log -t timeonly -l $argv[1] $argv[2..-1]
    end
end

function debug --description "Log debug message"
    log debug $argv
end

function info --description "Log info message"
    log info $argv
end

function warn --description "Log warning message"
    log warn $argv
end

function error --description "Log error message"
    log error $argv
end

function fatal --description "Log fatal message"
    log fatal $argv
end
