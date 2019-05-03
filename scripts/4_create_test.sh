#!/bin/bash

N=200
scripts_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
base_dir="$(dirname "$scripts_dir")"
raw_data_dir="$base_dir/raw_data"
class_names=($(ls "$scripts_dir/source_urls"))
data_dir="$base_dir/data"
train_dir="$data_dir/train"
test_dir="$data_dir/test"
mkdir -p "$test_dir"

for cname in "${class_names[@]}"
do
	test_dir_class="$test_dir/$cname"
	mkdir -p "$test_dir_class"
	train_dir_class="$train_dir/$cname"
	ls "$train_dir_class" | shuf -n $N | xargs -I{} mv "$train_dir_class/{}" "$test_dir_class"
done

echo "Number of files per class (train):"
for subdir in $(ls "$train_dir")
do
	echo "$subdir": "$(find "$train_dir/$subdir" -type f | wc -l)"
done

echo "Number of files per class (test):"
for subdir in $(ls "$test_dir")
do
	echo "$subdir": "$(find "$test_dir/$subdir" -type f | wc -l)"
done