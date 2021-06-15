#!/usr/bin/env bash

for fileName in *.sfp; do 
	cp $fileName tmp.sfp
	sed '/^ *$/d' tmp.sfp | head -n 67 > $fileName
done
