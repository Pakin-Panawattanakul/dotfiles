#!/bin/sh

if [ -n "$(rmpc queue)" ]; then
    # Queue is not empty
    queue_empty=0

    printf '%s\n' "$SELECTED_SONGS" |
        xargs -d '\n' rmpc add --position 1
else
    # Queue is empty
    queue_empty=1

    printf '%s\n' "$SELECTED_SONGS" |
        xargs -d '\n' rmpc add
fi

if [ "$queue_empty" -eq 1 ]; then
    mpc shuffle
fi

song_count=$(printf '%s\n' "$SELECTED_SONGS" | wc -l)

if [ "$song_count" -eq 1 ]; then
    rmpc remote status "Added 1 item to the queue"
else
    rmpc remote status "Added $song_count items to the queue"
fi
