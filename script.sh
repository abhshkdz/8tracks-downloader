#!/bin/bash
url=$1
play_token=$2
number_of_tracks=`curl -s $url | egrep -o [0-9]+\ tracks | cut -d ' ' -f1`
mix_id=`curl -s $url | egrep -o mixes/[0-9]+ -m1 | cut -d '/' -f2`
mix_name=`echo $url | cut -d '/' -f5`
next_url="http://8tracks.com/sets/$play_token/next?mix_id=$mix_id&reverse=true&format=jsonh"
tracks_played_url="http://8tracks.com/sets/$play_token/tracks_played?mix_id=$mix_id&reverse=true&format=jsonh"
echo "mix=$mix_name"
echo "mix_id=$mix_id"
echo "tracks=$number_of_tracks"
echo "tracks_played=$tracks_played_url"
mkdir $mix_name
cd $mix_name
for ((i=1; i<$number_of_tracks; i++)); do
    curl -s $next_url > last.json
done
curl -s $tracks_played_url > $mix_name.json
cat $mix_name.json | underscore select .track_file_stream_url --outfmt text | xargs -l1 axel
cat last.json | underscore select .track_file_stream_url --outfmt text | xargs axel
rm last.json
cd ..
