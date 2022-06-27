#!/bin/bash

dir_tree_one_deep=$(ls *  | grep ".md" | cut -d "." -f 1)
dir_tree_two_deep=$(ls */*  | grep ".md" | cut -d "." -f 1 | cut -d "/" -f 2)
dir_tree_three_deep=$(ls */*/*  | grep ".md" | cut -d "." -f 1 | cut -d "/" -f 3 )
dir_tree_four_deep=$(ls */*/*/*  | grep ".md" | cut -d "." -f 1 |  cut -d "/" -f 4 )
#dir_tree_five_deep=$(ls */*/*/*/*  | grep ".md" | cut -d "." -f 1 | cut -d "/" -f 5)

contents=$(echo "$dir_tree_one_deep$dir_tree_two_deep$dir_tree_three_deep$dir_tree_four_deep$dir_tree_five_deep" | sort | uniq)


echo "" > Contents.md
echo "# Archive Contents Page
This more of a test to see whether is worth have a contents page

" >> Contents.md

for node in $contents; do
		echo "[[$node]]" >> Contents.md	
done


