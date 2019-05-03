#!/bin/bash

scripts_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
base_dir="$(dirname "$scripts_dir")"
raw_data_dir="$base_dir/raw_data"
class_names=($(ls "$scripts_dir/source_urls"))

for cname in "${class_names[@]}"
do
	urls_file="$raw_data_dir/$cname/urls_$cname.txt"
	images_dir="$raw_data_dir/$cname/IMAGES"
	mkdir -p "$images_dir"
	echo "Class: $cname. Total # of urls: $(cat $urls_file | wc -l)"
	echo "Downloading images..."
	wget -nc -q --timeout=5 --tries=2 -i "$urls_file" -P "$images_dir"
done
