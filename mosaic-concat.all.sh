set -ex

in_dir="$1"

find "$in_dir" -type d -type d -name "SavedClips" -exec ./mosaic-concat.savedclips.sh {} \;
