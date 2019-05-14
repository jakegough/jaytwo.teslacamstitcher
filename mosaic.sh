set -ex

in_dir="C:\Users\jakeg\Desktop\TeslaCam\SavedClips\2019-05-12_12-09-23"
base_file="$in_dir/2019-05-12_12-00"
left_file="$base_file-left_repeater.mp4"
center_file="$base_file-front.mp4"
right_file="$base_file-right_repeater.mp4"
output_file="mosaic.mp4"

x264_preset="ultrafast" # ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo
x264_tune="zerolatency" # film, animation, grain, stillimage, psnr, ssim, fastdecode, zerolatency
x264_crf=23 # 0-51: where 0 is lossless, 23 is default, and 51 is worst possible

ffmpeg \
	-i "$left_file" \
  -i "$center_file" \
  -i "$right_file" \
	-filter_complex "\
		color=size=1280x960:color=black [base]; \
		[0:v] setpts=0.125*PTS, scale=640x480 [left]; \
		[1:v] setpts=0.125*PTS, scale=640x480 [center]; \
		[2:v] setpts=0.125*PTS, scale=640x480 [right]; \
		[base][center] overlay=shortest=1:x=320  [tmp1]; \
		[tmp1][right]  overlay=shortest=1:y=480 [tmp2]; \
    [tmp2][left]   overlay=shortest=1:x=640:y=480  \
	" \
	-c:v libx264 -preset $x264_preset -tune $x264_tune -crf $x264_crf "$output_file"
