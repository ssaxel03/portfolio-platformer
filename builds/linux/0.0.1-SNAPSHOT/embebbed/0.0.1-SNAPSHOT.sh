#!/bin/sh
echo -ne '\033c\033]0;portfolio-platformer\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/0.0.1-SNAPSHOT.x86_64" "$@"
