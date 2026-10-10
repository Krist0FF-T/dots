#!/usr/bin/env bash

# taken from the dev himself: https://github.com/mierak/dotfiles/blob/241ad4bde5b407e1348d3e5ac8726e48a13b50d2/dot_config/rmpc/scripts/executable_ytsearch

song=$(rmpc song --path "$SELECTED_SONGS" | head -n 1)
query=$(echo "$song" | jq -r '@uri "\(.metadata.artist)%20\(.metadata.title)"')

notify-send "searching" "$query"
xdg-open "https://www.youtube.com/results?search_query=$query"

