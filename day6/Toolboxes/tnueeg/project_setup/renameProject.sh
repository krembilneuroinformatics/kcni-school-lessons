#!/bin/bash

OLD="mnket"
NEW="tnueeg"

BPATH="bakup"

mkdir $BPATH

find . -type f -iname '*.m' | while read oldFileName; do 
	cp $oldFileName $BPATH
	newFileName=`echo $oldFileName | sed "s/$OLD/$NEW/g"`
	mv $oldFileName $newFileName
done

sed -i "s/$OLD/$NEW/g" *.m
sed -i "s/$OLD/$NEW/g" */*.m
sed -i "s/$OLD/$NEW/g" */*/*.m


