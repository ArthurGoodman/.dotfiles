#!/bin/sh
draw() {
  ~/.config/lf/draw_img.sh "$@"
  exit 1
}

hash() {
  printf '%s/.cache/lf/%s' "$HOME" \
    "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
}

cache() {
  if [ -f "$1" ]; then
    draw "$@"
  fi
}

file="$1"
shift

case "$(file -Lb --mime-type -- "$file")" in
  text/*)
    source-highlight -q --outlang-def=esc.outlang --style-file=esc.style -i "$file" || cat -- "$file"
    exit 0
    ;;
  image/*)
    if [ -n "$FIFO_UEBERZUG" ]; then
      orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file")"
      if [ -n "$orientation" ] && [ "$orientation" != 1 ]; then
        cache="$(hash "$file").jpg"
        cache "$cache" "$@"
        convert -- "$file" -auto-orient "$cache"
        draw "$cache" "$@"
      else
        draw "$file" "$@"
      fi
    fi
    ;;
  video/*)
    if [ -n "$FIFO_UEBERZUG" ]; then
      cache="$(hash "$file").jpg"
      cache "$cache" "$@"
      ffmpegthumbnailer -i "$file" -o "$cache" -s 0
      draw "$cache" "$@"
    fi
    ;;
esac

echo '----- File Type Classification -----'
width="$3"
file -Lb -- "$file" | fold -s -w "$width"

exit 0
