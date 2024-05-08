function ffmpeg --wraps ffmpeg --description "FFmpeg with no banner"
    command ffmpeg -hide_banner $argv
end

function ffprobe --wraps ffprobe --description "FFprobe with no banner"
    command ffprobe -hide_banner $argv
end
