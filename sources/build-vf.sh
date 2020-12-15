#!/bin/sh
set -e
#source ../env/bin/activate

fontName="Truculenta"
axes="opsz,wdth,wght"

##########################################

echo ".
GENERATING VARIABLE
."
VF_DIR=../fonts/variable
rm -rf $VF_DIR
mkdir -p $VF_DIR

fontmake -g $fontName.glyphs --family-name "$fontName" -o variable --output-path $VF_DIR/$fontName[$axes].ttf

##########################################

echo ".
POST-PROCESSING VF
."
vfs=$(ls $VF_DIR/*.ttf)
for font in $vfs
do
	gftools fix-font $font
	mv $font.fix $font
done

python gen_stat.py

##########################################

rm -rf instance_ufo/ master_ufo/

echo ".
COMPLETE!
."
