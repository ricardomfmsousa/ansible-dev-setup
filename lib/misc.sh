# Misc utility functions

# $1: directory to add to path
add-to-path() {
  # Only add if not in $PATH already
  [[ ":$PATH:" == *":$1:"* ]] && return 0
  echo 'if [ -d "'$1'" ]; then PATH="'$1':$PATH"; fi' >>$HOME/.profile &&
    sleep 1 &&
    source $HOME/.profile
}

# $1: App/script name
# $2: App/script path
add-to-startup() {
  AUTO_START_DIR="$HOME/.config/autostart"
  AUTO_START_PATH="$AUTO_START_DIR/$1.desktop"
  mkdir -p "$AUTO_START_DIR" &&
    echo "\
[Desktop Entry]
Type=Application
X-GNOME-Autostart-enabled=true
Name=$1
Exec=$2
" >"$AUTO_START_PATH" &&
    echo "[$1] added to $AUTO_START_PATH"
}

# $1: tar file url
# $2: folder to unpack to
download-untar() {
  rm -rf $2 &&
    mkdir -p $2 &&
    echo "Downloading from $1, unpacking to $2" &&
    wget -q -O - $1 | tar xz -C $2
}

# $1: app to launch path
# $2: launcher script path
create-launcher-script() {
  mkdir -p $(dirname $2) &&
    echo -e '#!/bin/bash\n'$1 >$2 &&
    chmod +x $2
}
