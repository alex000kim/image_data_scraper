# Image Data Scraper

## Description

This is a set of scripts that allows for an automatic collection of labelled images from websited supported by the [Ripme](https://github.com/RipMeApp/ripme) application.
For illustration purposes, the default categories are: `dogs`, `cats` and `cows`.
See `scripts/source_urls/`.
For your particular task, you will need to replace the plain text files in that directory with your own: give them approprite names (i.e. names of your classes/categories) and copy urls of image albums that belong to that class into each text file.

Here is what each script (located under `scripts` directory) does:
- `1_get_urls.sh` - iterates through text files under `scripts/source_urls` downloading URLs of images for each of class/category. The Ripme application performs all the heavy lifting. The source URLs are mostly links to various subreddits, but could be any website [supported](https://github.com/ripmeapp/ripme/wiki/Supported-Sites) by Ripme.
- `2_download_from_urls.sh` - downloads image files from urls found in text files in `raw_data` directory.
- `3_create_train.sh` - creates `data/train` directory and copies all `*.jpg` and `*.jpeg` files into it from `raw_data`. Also removes corrupted images.
- `4_create_test.sh` - creates `data/test` directory and moves `N=200` random files for each class from `data/train` to `data/test` (change this number inside the script if you need a different train/test split). Alternatively, you can run it multiple times, each time it will move `N` images for each class from `data/train` to `data/test`.

## Prerequisites

- Java runtime environment:
   - debian and ubuntu:`sudo apt-get install default-jre`
- Linux command line tools: `wget`, `convert` (`imagemagick` suite of tools), `rsync`, `shuf`

## How to run
Change working directory to `scripts` and execute each script in the sequence indicated by the number in the file name, e.g.:
```bash
$ bash 1_get_urls.sh
$ find ../raw_data -name "urls_*.txt" -exec sh -c "echo Number of URLs in {}: ; cat {} | wc -l" \;
Number of URLs in ../raw_data/cows/urls_cows.txt:
739
Number of URLs in ../raw_data/dogs/urls_dogs.txt:
5884
Number of URLs in ../raw_data/cats/urls_cats.txt:
7446
$ bash 2_download_from_urls.sh
$ bash 3_create_train.sh
$ bash 4_create_test.sh
$ cd ../data
$ ls train
cats cows dogs
$ ls test
cats cows dogs
```
