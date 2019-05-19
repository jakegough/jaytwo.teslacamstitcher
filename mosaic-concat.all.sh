set -ex

default_in_dir="/i/TeslaCam"
in_dir=${1:-$default_in_dir}


find "$in_dir" -type d -type d -name "SavedClips" -exec ./mosaic-concat.savedclips.sh {} \;
