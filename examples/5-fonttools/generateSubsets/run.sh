#!/usr/bin/env bash

rm "`dirname $0`"/../fonts-subsets/*

cd "`dirname $0`"

for filename in originalFonts/*.ttf ; do
 pyftsubset ${filename} --text-file=./glyphs.txt --verbose --flavor=woff2 --output-file=../fonts-subsets/$(basename "$filename" .ttf).woff2;
done

for filename in originalFonts/*.ttf ; do
 pyftsubset ${filename} --text-file=./glyphs.txt --verbose --output-file=../fonts-subsets/$(basename "$filename" .ttf).ttf;
done

cd ../fonts-subsets

# https://remarkablemark.org/blog/2017/09/24/rename-file-with-md5-hash/
find . -type f -exec bash -c 'mv "$1" "${1%.*}-$(md5 -q "$1" | cut -c1-8).${1##*.}"' bash {} \;
