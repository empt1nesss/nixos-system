#! /usr/bin/env sh

# set to same value as layout.gap config
GAP=8

WIDTH=$(niri msg -j focused-output | jq	 ".logical.width")
echo $WIDTH

FOCUSED_WORKSPACE=$(niri msg -j workspaces | jq 'map(select(.is_focused == true))[0].id')
echo $FOCUSED_WORKSPACE

WIN_COUNT=$(niri msg -j windows | jq "map(select(.workspace_id == ${FOCUSED_WORKSPACE})) | map(select(.layout.pos_in_scrolling_layout[1] == 1)) | length")
echo $WIN_COUNT

DIV_WIDTH=$(expr $WIDTH / $WIN_COUNT)
NEW_WIDTH=$(expr $DIV_WIDTH - $GAP - $GAP)
echo $NEW_WIDTH


WINDOWS=$(niri msg -j windows | jq -r "map(select(.workspace_id == $FOCUSED_WORKSPACE)) | map(select(.layout.pos_in_scrolling_layout[1] == 1)) | map(.id) | \"\(.[])\" ")
echo $WINDOWS

for i in $WINDOWS; do
  niri msg action focus-window --id $i
  niri msg action set-column-width "$NEW_WIDTH"
done
niri msg action focus-column-first

