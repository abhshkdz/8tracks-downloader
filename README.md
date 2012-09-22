#8tracks-downloader

A bash script to download playlists from 8tracks. It's a very hackish way of doing it, but works for me.

##Usage

	./script.sh <mix-url> <play-token>

##Requirements 
* [Underscore-CLI](https://github.com/ddopson/underscore-cli) for parsing JSON
* [Axel](http://axel.alioth.debian.org/) for downloading tracks

##Steps

1. Go to an 8tracks mix page (like [this](http://8tracks.com/sundeepbhat/travel-read-experience)) in a new incognito window and open up Chrome developer tools (basically none of the tracks should have been played earlier).
2. Copy the url. This is the ***mix-url*** in the command above.
3. Get the ***play-token*** from the console (you may need to enable XHR logging) or the network tab, where it typically appears as `.../sets/<play-token>/...`
4. Execute the above command and tracks from the mix are downloaded in a new folder with the same name as the mix.

![](https://raw.github.com/abhshkdz/8tracks-downloader/master/doc/1.png)
![](https://raw.github.com/abhshkdz/8tracks-downloader/master/doc/2.png)

