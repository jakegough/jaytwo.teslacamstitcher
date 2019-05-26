set -ex

in_dir="$1"

find "$in_dir" -type d -name '*_*' -exec ./mosaic-concat.sh {} \;
