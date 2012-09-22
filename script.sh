#!/bin/bash
url=$1
play_token=$2
number_of_tracks=`curl -s $url | egrep -o [0-9]{2}\ tracks | cut -d ' ' -f1`
mix_id=`curl -s $url | egrep -o mixes/[0-9]{7} -m1 | cut -d '/' -f2`
next_url="http://8tracks.com/sets/$play_token/next?mix_id=$mix_id&reverse=true&format=jsonh"
tracks_played_url="http://8tracks.com/sets/$play_token/tracks_played?mix_id=$mix_id&reverse=true&format=jsonh"
echo "tracks=$number_of_tracks"
echo "tracks_played=$tracks_played_url"
for ((i=1; i<$number_of_tracks; i++)); do
    curl -s $next_url
done
