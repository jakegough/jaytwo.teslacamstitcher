set -ex

in_dir=$1

front_clips=(`find $in_dir -type f -name "*front.mp4"`)
left_clips=(`find $in_dir -type f -name "*left_repeater.mp4"`)
right_clips=(`find $in_dir -type f -name "*right_repeater.mp4"`)
clip_timestamps=(`find $in_dir -type f -name "*front.mp4" -printf '%f\n' | awk -F'-front' '{print $1}'`)

# TODO: validate counts line up
front_clips_count=${#front_clips[*]}
left_clips_count=${#left_clips[*]}
right_clips_count=${#right_clips[*]}

first_clip_timestamp=${clip_timestamps[0]}
first_clip_timestamp_datetime="$(echo $first_clip_timestamp | sed 's/_/ /g' | awk '{print $1}')T$(echo $first_clip_timestamp | sed 's/[_]/ /g' | awk '{print $2}' | sed 's/[-]/:/g'):00"
first_clip_timestamp_unixtime=$(date -u --date "$first_clip_timestamp_datetime" +"%s")

folder_timestamp_raw=$(basename "$in_dir")
folder_timestamp_datetime="$(echo $folder_timestamp_raw | sed 's/_/ /g' | awk '{print $1}')T$(echo $folder_timestamp_raw | sed 's/[_]/ /g' | awk '{print $2}' | sed 's/[-]/:/g')"

x264_preset="fast" # ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo
x264_tune="zerolatency" # film, animation, grain, stillimage, psnr, ssim, fastdecode, zerolatency
x264_crf=23 # 0-51: where 0 is lossless, 23 is default, and 51 is worst possible
out_size="640x480"
scale="320x240"
pts_scale="0.0625" #2.0 means half speed, 0.5 means double speed
output_file="$folder_timestamp_raw.mp4"

input_files_list=""
for ((i=0;i<$front_clips_count;i++)) do input_files_list="$input_files_list -i ${left_clips[$i]} -i ${front_clips[$i]} -i ${right_clips[$i]}"; done

filter_input_stream_cursor=0
filter_input_streams=""
for ((i=0;i<$front_clips_count;i++)) do filter_input_streams="$filter_input_streams [$((filter_input_stream_cursor++)):v] setpts=PTS-STARTPTS, scale=$scale [left_$i]; [$((filter_input_stream_cursor++)):v] setpts=PTS-STARTPTS, scale=$scale [center_$i]; [$((filter_input_stream_cursor++)):v] setpts=PTS-STARTPTS, scale=$scale [right_$i]; "; done

filter_concat_streams_left=""
for ((i=0;i<$front_clips_count;i++)) do filter_concat_streams_left="$filter_concat_streams_left[left_$i]"; done
filter_concat_streams_left="$filter_concat_streams_left concat=n=$front_clips_count [left];"

filter_concat_streams_right=""
for ((i=0;i<$front_clips_count;i++)) do filter_concat_streams_right="$filter_concat_streams_right[right_$i]"; done
filter_concat_streams_right="$filter_concat_streams_right concat=n=$front_clips_count [right];"

filter_concat_streams_center=""
for ((i=0;i<$front_clips_count;i++)) do filter_concat_streams_center="$filter_concat_streams_center[center_$i]"; done
filter_concat_streams_center="$filter_concat_streams_center concat=n=$front_clips_count [center];"

ffmpeg \
	$input_files_list \
	-filter_complex "\
		color=size=$out_size:color=black [base]; \
		$filter_input_streams \
    $filter_concat_streams_left \
    $filter_concat_streams_right \
    $filter_concat_streams_center \
		[base][center] overlay=shortest=1:x=0 [mosaic_c]; \
		[mosaic_c][right] overlay=shortest=1:y=h [mosaic_cr]; \
    [mosaic_cr][left] overlay=shortest=1:x=w:y=h [mosaic_crl]; \
    [mosaic_crl] drawtext=\
      fontfile=Roboto-Regular.ttf: \
      text='%{pts\:gmtime\:$first_clip_timestamp_unixtime\:%Y-%m-%dT%H\\\\\:%M\\\\\:%S}': \
      fontcolor=white: \
      fontsize=24: \
      box=1: \
      boxcolor=black@0.5: \
      boxborderw=5: \
      x=(w/2)+((w/2)-text_w)/2: \
      y=((h/2)-text_h)/2 [mosaic_crlt]; \
    [mosaic_crlt] setpts=$pts_scale*PTS
	" \
  -y \
	-c:v libx264 -preset $x264_preset -tune $x264_tune -crf $x264_crf "$output_file"
