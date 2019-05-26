set -ex

out_size="640x480"
scale="320x240"
pts_scale="0.04" #2.0 means half speed, 0.5 means double speed
output_file="2019-05-13_21-19-04.mp4"

ffmpeg \
  -c:v h264_mmal \
	-i /home/pi/TeslaCam/SavedClips/2019-05-13_21-19-04/2019-05-13_21-09-left_repeater.mp4 \
  -i /home/pi/TeslaCam/SavedClips/2019-05-13_21-19-04/2019-05-13_21-09-front.mp4 \
  -i /home/pi/TeslaCam/SavedClips/2019-05-13_21-19-04/2019-05-13_21-09-right_repeater.mp4 \
	-filter_complex "\
		color=size=$out_size:color=black [base]; \
		[0:v] setpts=PTS-STARTPTS, scale=$scale [left]; \
    [1:v] setpts=PTS-STARTPTS, scale=$scale [center]; \
    [2:v] setpts=PTS-STARTPTS, scale=$scale [right]; \
    [base][center] overlay=shortest=1:x=0 [mosaic_c]; \
		[mosaic_c][right] overlay=shortest=1:y=h [mosaic_cr]; \
    [mosaic_cr][left] overlay=shortest=1:x=w:y=h [mosaic_crl]; \
    [mosaic_crl] setpts=$pts_scale*PTS
	" \
  -y \
	-c:v h264_omx "$output_file"
