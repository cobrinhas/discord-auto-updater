#!/usr/bin/env bash

last_version=$(wget 'https://discord.com/api/download?platform=linux&format=deb' --method head -S 2>&1 | grep location | sed -r 's/.*discord-(.*)\.deb/\1/')
current_version=$(apt-cache show discord | head | grep Version | tr -d 'Version: ')

if [ "$last_version" != "$current_version" ]; then
	(
		cd $(mktemp -d)
		wget 'https://discord.com/api/download?platform=linux&format=deb' -O discord.deb
		apt-get install ./discord.deb
		notify-send "Discord" "Discord has been updated to version $last_version."
	)
fi
