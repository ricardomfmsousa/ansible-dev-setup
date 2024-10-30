# Git utility functions

# $1: repo name
git_read_latest_release() {
  echo $(curl --silent "https://api.github.com/repos/$1/releases/latest" |
    grep -Po '"tag_name": "\K.*?(?=")')
}

# $1: repo name
# $2: folder to clone to
git_clone_latest_release() {
  rm -rf $2 && LATEST_RELEASE=$(git_read_latest_release $1) &&
    git clone -b $LATEST_RELEASE --single-branch "https://github.com/$1" $2
}

# $1: repo name
# $2: folder to unpack to
git_download_latest_release() {
  rm -rf $2 && mkdir -p $2 && LATEST_RELEASE=$(git_read_latest_release $1) &&
    REPO="https://github.com/$1/archive/$LATEST_RELEASE.tar.gz" &&
    echo "Downloading from $REPO, unpacking to $2" &&
    wget -q -O - $REPO | tar xz -C $2
}
