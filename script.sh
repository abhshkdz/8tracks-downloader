#!/bin/bash
url=$1
play_token=$2
number_of_tracks=`curl -s $url | egrep -o [0-9]+\ tracks | awk '{ print $1 }'`
mix_id=`curl -s $url | egrep -o mixes/[0-9]+ -m1 | awk -F'/' '{ print $2 }'`
mix_name=`echo $url | awk -F'/' '{ print $5 }'`
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
cat $mix_name.json | underscore select .name --outfmt text > names.txt && cat last.json | underscore select .name --outfmt text >> names.txt
cat $mix_name.json | underscore select .performer --outfmt text > artists.txt && cat last.json | underscore select .performer --outfmt text >> artists.txt
cat $mix_name.json | underscore select .release_name --outfmt text > albums.txt && cat last.json | underscore select .release_name --outfmt text >> albums.txt
cat $mix_name.json  | underscore select .track_file_stream_url --outfmt text > files.txt && cat last.json  | underscore select .track_file_stream_url --outfmt text >> files.txt
echo "Filename / Song / Artist / Album" > tracklist.txt && paste -d '|' files.txt names.txt artists.txt albums.txt >> tracklist.txt 
sed 1d tracklist.txt | while read line
do
    axel "`echo $line | awk -F'|' '{ print $1 }'`" -o "`echo $line | awk -F'|' '{ print $2,$3,$4 }'`.m4a"
done
rm *.json files.txt names.txt artists.txt albums.txt
cd ..
