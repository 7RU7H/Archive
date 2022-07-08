#!/bin/bash

recon_dir=$(pwd)
active_recon_fst=$(ls $recon_dir/Active-Information-Gathering/ | grep ".md")
active_recon_snd=$(ls $recon_dir/Active-Information-Gathering/* | grep ".md" | cut -d "/" -f 2 | grep -v "home")
passive_recon_fst=$(ls $recon_dir/Passive-Information-Gathering/ | grep ".md")
passive_recon_snd=$(ls $recon_dir/Passive-Information-Gathering/* | grep ".md" | cut -d "/" -f 2 | grep -v "home")

# Active Recon Hub Stub
echo "# Active Recon 
This is a hub page for linking all of a specific directory structure.

## Contents


" > $recon_dir/Active-Information-Gathering/Active-Recon.md

# Passive Recon Hub Stub
echo "# Passive Recon 
This is a hub page for linking all of a specific directory structure.

## Contents


" > $recon_dir/Passive-Information-Gathering/Passive-Recon.md

for fst_ar_list in $active_recon_fst; do
	echo "[[$fst_ar_list]]" >> $recon_dir/Active-Information-Gathering/Active-Recon.md
done

for snd_ar_list in $active_recon_snd; do
	echo "[[$snd_ar_list]]" >> $recon_dir/Active-Information-Gathering/Active-Recon.md
done


for fst_pr_list in $passive_recon_fst; do
	echo "[[$fst_pr_list]]" >> $recon_dir/Passive-Information-Gathering/Passive-Recon.md
done

for snd_pr_list in $passive_recon_snd; do
	echo "[[$snd_pr_list]]" >> $recon_dir/Passive-Information-Gathering/Passive-Recon.md
done
