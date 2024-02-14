function ffmpeg --wraps ffmpeg
    command ffmpeg -hide_banner $argv
end

function ffprobe --wraps ffprobe
    command ffprobe -hide_banner $argv
end
