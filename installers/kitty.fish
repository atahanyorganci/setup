#!/usr/bin/env fish

function die
    gum log -l fatal $argv
    exit 1
end

set -l dest $XDG_DATA_HOME/kitty

set -l latest (gh release view -R kovidgoyal/kitty --json tagName | jq -r '.tagName' | cut -c 2-)
set -l arch (uname -m)
if test "$arch" = x86_64 -o "$arch" = amd64
    set -l arch x86_64
else
    die "Unsupported architecture: $arch"
end

gum log -l info "Downloading kitty version $latest for $arch"

set -l download_url "https://github.com/kovidgoyal/kitty/releases/download/v$latest/kitty-$latest-$arch.txz"
set -l download_dir (mktemp -d "/tmp/kitty-install-XXXXXXXXXXXX")
set -l archive "$download_dir/kitty.txz"

gum log -l debug "Downloading: $download_url"
gum log -l debug "Download directory: $download_dir"

curl -fsSL "$download_url" >"$archive" || die "Failed to download $download_url"
gum log -l info "Downloaded executable archive to $download_dir/kitty.txz"

mkdir -p "$download_dir/mp"
tar -C "$download_dir/mp" -xJof "$archive" || die "Failed to extract $archive"
gum log -l debug "Extracted archive to $download_dir/mp"


rm -rf $dest || die "Failed to remove old version at $dest"
mv "$download_dir/mp" "$dest"
gum log -l debug "Copied files to $dest"

set -l desktop_files $dest/share/applications/*.desktop
sd "Icon=kitty" "Icon=$dest/share/icons/hicolor/256x256/apps/kitty.png" $desktop_files
sd "Exec=kitty" "Exec=$dest/bin/kitty" $desktop_files
gum log -l debug "Updated .desktop files"

ln -sf "$dest/bin/kitty" "$HOME/.local/bin/kitty"
ln -sf "$dest/bin/kitten" "$HOME/.local/bin/kitten"
gum log -l debug "Created symlinks for executables"

cp -f $desktop_files "$XDG_DATA_HOME/applications/"
gum log -l debug "Copied .desktop files to $XDG_DATA_HOME/applications/"

gum log -l info "Installed kitty version $latest to $dest. DONE!"
