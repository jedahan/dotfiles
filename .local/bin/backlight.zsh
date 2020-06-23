#!/bin/env zsh

steps=(0% 1% 20% 50% 80% 100%)

brightness=$(brightnessctl info -m | cut -d',' -f4)
direction=${1:-up}

index=${steps[(I)$brightness]}

if [[ -z "$index" ]]; then return; fi

[[ "$direction" = "up" ]] && (( index += 1 ))
[[ "$direction" = "down" ]] && (( index -= 1 ))
[[ "$index" -lt 1 ]] && (( index = 1 ))
[[ "$index" -gt $#steps ]] && (( index = $#steps ))

newbrightness=${steps[$index]}

printf "backlight moving %s from %s to %s\n" "$direction" "$brightness" "$newbrightness"
brightnessctl set "$newbrightness" >/dev/null
