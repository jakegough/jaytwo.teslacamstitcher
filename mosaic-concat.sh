set -ex

in_dir="D:\TeslaCam Backups\SavedClips\2019-05-13_21-19-04"

clip_timestamp_raw=$(basename "$in_dir")
clip_timestamp_readable_date=$(echo $clip_timestamp_raw | sed 's/_/ /g' | awk '{print $1}')
clip_timestamp_readable_time=$(echo $clip_timestamp_raw | sed 's/[_]/ /g' | awk '{print $2}' | sed 's/[-]/:/g')
clip_timestamp_readable_datetime=${clip_timestamp_readable_date}T${clip_timestamp_readable_time}
clip_timestamp_without_seconds=$(date --date "$clip_timestamp_readable_datetime" +"%Y-%m-%dT%H:%M")

clip_start_time_unixtime=$(date -u --date "$clip_timestamp_readable_datetime 10 minutes ago" +"%s")

clip_timestamp_minus_0=$clip_timestamp_without_seconds
clip_timestamp_minus_1=$(date --date "$clip_timestamp_without_seconds 1 minute ago" +'%Y-%m-%dT%H:%M')
clip_timestamp_minus_2=$(date --date "$clip_timestamp_without_seconds 2 minutes ago" +'%Y-%m-%dT%H:%M')
clip_timestamp_minus_3=$(date --date "$clip_timestamp_without_seconds 3 minutes ago" +'%Y-%m-%dT%H:%M')
clip_timestamp_minus_4=$(date --date "$clip_timestamp_without_seconds 4 minutes ago" +'%Y-%m-%dT%H:%M')
clip_timestamp_minus_5=$(date --date "$clip_timestamp_without_seconds 5 minutes ago" +'%Y-%m-%dT%H:%M')
clip_timestamp_minus_6=$(date --date "$clip_timestamp_without_seconds 6 minutes ago" +'%Y-%m-%dT%H:%M')
clip_timestamp_minus_7=$(date --date "$clip_timestamp_without_seconds 7 minutes ago" +'%Y-%m-%dT%H:%M')
clip_timestamp_minus_8=$(date --date "$clip_timestamp_without_seconds 8 minutes ago" +'%Y-%m-%dT%H:%M')
clip_timestamp_minus_9=$(date --date "$clip_timestamp_without_seconds 9 minutes ago" +'%Y-%m-%dT%H:%M')
clip_timestamp_minus_10=$(date --date "$clip_timestamp_without_seconds 10 minutes ago" +'%Y-%m-%dT%H:%M')

clip_date_format="%Y-%m-%d_%H-%M"
clip_file_date_1=$(date --date "$clip_timestamp_minus_10" +"$clip_date_format")
clip_file_date_2=$(date --date "$clip_timestamp_minus_9" +"$clip_date_format")
clip_file_date_3=$(date --date "$clip_timestamp_minus_8" +"$clip_date_format")
clip_file_date_4=$(date --date "$clip_timestamp_minus_7" +"$clip_date_format")
clip_file_date_5=$(date --date "$clip_timestamp_minus_6" +"$clip_date_format")
clip_file_date_6=$(date --date "$clip_timestamp_minus_5" +"$clip_date_format")
clip_file_date_7=$(date --date "$clip_timestamp_minus_4" +"$clip_date_format")
clip_file_date_8=$(date --date "$clip_timestamp_minus_3" +"$clip_date_format")
clip_file_date_9=$(date --date "$clip_timestamp_minus_2" +"$clip_date_format")
clip_file_date_10=$(date --date "$clip_timestamp_minus_1" +"$clip_date_format")
clip_file_date_11=$(date --date "$clip_timestamp_minus_0" +"$clip_date_format")

base_file1="$in_dir/$clip_file_date_1"
left_file1="$base_file1-left_repeater.mp4"
center_file1="$base_file1-front.mp4"
right_file1="$base_file1-right_repeater.mp4"

base_file2="$in_dir/$clip_file_date_2"
left_file2="$base_file2-left_repeater.mp4"
center_file2="$base_file2-front.mp4"
right_file2="$base_file2-right_repeater.mp4"

base_file3="$in_dir/$clip_file_date_3"
left_file3="$base_file3-left_repeater.mp4"
center_file3="$base_file3-front.mp4"
right_file3="$base_file3-right_repeater.mp4"

base_file4="$in_dir/$clip_file_date_4"
left_file4="$base_file4-left_repeater.mp4"
center_file4="$base_file4-front.mp4"
right_file4="$base_file4-right_repeater.mp4"

base_file5="$in_dir/$clip_file_date_5"
left_file5="$base_file5-left_repeater.mp4"
center_file5="$base_file5-front.mp4"
right_file5="$base_file5-right_repeater.mp4"

base_file6="$in_dir/$clip_file_date_6"
left_file6="$base_file6-left_repeater.mp4"
center_file6="$base_file6-front.mp4"
right_file6="$base_file6-right_repeater.mp4"

base_file7="$in_dir/$clip_file_date_7"
left_file7="$base_file7-left_repeater.mp4"
center_file7="$base_file7-front.mp4"
right_file7="$base_file7-right_repeater.mp4"

base_file8="$in_dir/$clip_file_date_8"
left_file8="$base_file8-left_repeater.mp4"
center_file8="$base_file8-front.mp4"
right_file8="$base_file8-right_repeater.mp4"

base_file9="$in_dir/$clip_file_date_9"
left_file9="$base_file9-left_repeater.mp4"
center_file9="$base_file9-front.mp4"
right_file9="$base_file9-right_repeater.mp4"

base_file10="$in_dir/$clip_file_date_10"
left_file10="$base_file10-left_repeater.mp4"
center_file10="$base_file10-front.mp4"
right_file10="$base_file10-right_repeater.mp4"

base_file11="$in_dir/$clip_file_date_11"
left_file11="$base_file11-left_repeater.mp4"
center_file11="$base_file11-front.mp4"
right_file11="$base_file11-right_repeater.mp4"

output_file="$clip_timestamp_raw.mp4"

x264_preset="fast" # ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo
x264_tune="zerolatency" # film, animation, grain, stillimage, psnr, ssim, fastdecode, zerolatency
x264_crf=23 # 0-51: where 0 is lossless, 23 is default, and 51 is worst possible
out_size="640x480"
scale="320x240"
pts_scale="0.0625" #2.0 means half speed, 0.5 means double speed

ffmpeg \
	-i "$left_file1" \
  -i "$center_file1" \
  -i "$right_file1" \
  -i "$left_file2" \
  -i "$center_file2" \
  -i "$right_file2" \
  -i "$left_file3" \
  -i "$center_file3" \
  -i "$right_file3" \
  -i "$left_file4" \
  -i "$center_file4" \
  -i "$right_file4" \
  -i "$left_file5" \
  -i "$center_file5" \
  -i "$right_file5" \
  -i "$left_file6" \
  -i "$center_file6" \
  -i "$right_file6" \
  -i "$left_file7" \
  -i "$center_file7" \
  -i "$right_file7" \
  -i "$left_file8" \
  -i "$center_file8" \
  -i "$right_file8" \
  -i "$left_file9" \
  -i "$center_file9" \
  -i "$right_file9" \
  -i "$left_file10" \
  -i "$center_file10" \
  -i "$right_file10" \
  -i "$left_file11" \
  -i "$center_file11" \
  -i "$right_file11" \
	-filter_complex "\
		color=size=$out_size:color=black [base]; \
		[0:v] setpts=PTS-STARTPTS, scale=$scale [left1]; \
		[1:v] setpts=PTS-STARTPTS, scale=$scale [center1]; \
		[2:v] setpts=PTS-STARTPTS, scale=$scale [right1]; \
    [3:v] setpts=PTS-STARTPTS, scale=$scale [left2]; \
		[4:v] setpts=PTS-STARTPTS, scale=$scale [center2]; \
		[5:v] setpts=PTS-STARTPTS, scale=$scale [right2]; \
    [6:v] setpts=PTS-STARTPTS, scale=$scale [left3]; \
		[7:v] setpts=PTS-STARTPTS, scale=$scale [center3]; \
		[8:v] setpts=PTS-STARTPTS, scale=$scale [right3]; \
    [9:v] setpts=PTS-STARTPTS, scale=$scale [left4]; \
		[10:v] setpts=PTS-STARTPTS, scale=$scale [center4]; \
		[11:v] setpts=PTS-STARTPTS, scale=$scale [right4]; \
    [12:v] setpts=PTS-STARTPTS, scale=$scale [left5]; \
		[13:v] setpts=PTS-STARTPTS, scale=$scale [center5]; \
		[14:v] setpts=PTS-STARTPTS, scale=$scale [right5]; \
    [15:v] setpts=PTS-STARTPTS, scale=$scale [left6]; \
		[16:v] setpts=PTS-STARTPTS, scale=$scale [center6]; \
		[17:v] setpts=PTS-STARTPTS, scale=$scale [right6]; \
		[18:v] setpts=PTS-STARTPTS, scale=$scale [left7]; \
		[19:v] setpts=PTS-STARTPTS, scale=$scale [center7]; \
		[20:v] setpts=PTS-STARTPTS, scale=$scale [right7]; \
    [21:v] setpts=PTS-STARTPTS, scale=$scale [left8]; \
		[22:v] setpts=PTS-STARTPTS, scale=$scale [center8]; \
		[23:v] setpts=PTS-STARTPTS, scale=$scale [right8]; \
    [24:v] setpts=PTS-STARTPTS, scale=$scale [left9]; \
		[25:v] setpts=PTS-STARTPTS, scale=$scale [center9]; \
		[26:v] setpts=PTS-STARTPTS, scale=$scale [right9]; \
    [27:v] setpts=PTS-STARTPTS, scale=$scale [left10]; \
		[28:v] setpts=PTS-STARTPTS, scale=$scale [center10]; \
		[29:v] setpts=PTS-STARTPTS, scale=$scale [right10]; \
    [30:v] setpts=PTS-STARTPTS, scale=$scale [left11]; \
		[31:v] setpts=PTS-STARTPTS, scale=$scale [center11]; \
		[32:v] setpts=PTS-STARTPTS, scale=$scale [right11]; \
    [left1][left2][left3][left4][left5][left6][left7][left8][left9][left10][left11] concat=n=11 [left]; \
    [center1][center2][center3][center4][center5][center6][center7][center8][center9][center10][center11] concat=n=11 [center]; \
    [right1][right2][right3][right4][right5][right6][right7][right8][right9][right10][right11] concat=n=11 [right]; \
		[base][center] overlay=shortest=1:x=0   [mosaic_c]; \
		[mosaic_c][right]  overlay=shortest=1:y=h     [mosaic_cr]; \
    [mosaic_cr][left]   overlay=shortest=1:x=w:y=h [mosaic_crl]; \
    [mosaic_crl] drawtext=\
      fontfile=Roboto-Regular.ttf: \
      text='%{pts\:gmtime\:$clip_start_time_unixtime\:%Y-%m-%dT%H\\\\\:%M\\\\\:%S}': \
      fontcolor=white: \
      fontsize=24: \
      box=1: \
      boxcolor=black@0.5: \
      boxborderw=5: \
      x=(w/2)+((w/2)-text_w)/2: \
      y=((h/2)-text_h)/2 [mosaic_crlt]; \
    [mosaic_crlt_pts] setpts=$pts_scale*PTS
	" \
	-c:v libx264 -preset $x264_preset -tune $x264_tune -crf $x264_crf "$output_file"
