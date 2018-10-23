#!/bin/bash

echo -e "\nConverting X-platform to generic Calabash folder"

FILE_PATH=$PWD
mkdir $PWD/../calabash-generic 2>/dev/null
cd $PWD/../calabash-generic || { echo 'Could not CD to generic path' ; exit 1; }
GENERIC_PATH=$PWD
cd ${FILE_PATH}


rm -rf ${GENERIC_PATH}/* 2>/dev/null

INCLUDE=('features')
# INCLUDE=('features' 'Gemfile' 'debug.keystore')
EXC_FILES=${#INCLUDE[@]}

function convert {
	platform=$1
	echo -e "\n\n. . . working on $platform:\n"

	mkdir ${GENERIC_PATH}/$platform 2>/dev/null
	cp -r ${FILE_PATH}/* ${GENERIC_PATH}/$platform

	FILES=${GENERIC_PATH}/$platform/*
	for f in ${FILES}; do
		delete=true
		for (( i=0;i<$EXC_FILES;i++)); do
			f_exc="${GENERIC_PATH}/$platform/"${INCLUDE[${i}]}
	    	if [ $f == $f_exc ]; then
	    		delete=false
	    		break
	    	fi
		done
		if [ "$delete" == true ]; then
			echo -e "Removing unrelated files: $f"
			rm -rf $f
		fi
	done

	# remove other platform
	if [ "$platform" == "android" ]; then
		rm -rf ${GENERIC_PATH}/android/features/ios
	else
		rm -rf ${GENERIC_PATH}/ios/features/android
	fi

	mv ${GENERIC_PATH}/$platform/features/$platform/support/* ${GENERIC_PATH}/$platform/features/support/
	rm -rf ${GENERIC_PATH}/$platform/features/$platform/support

	mv ${GENERIC_PATH}/$platform/features/$platform/* ${GENERIC_PATH}/$platform/features
	rm -rf ${GENERIC_PATH}/$platform/features/$platform

}

convert "android"
convert "ios"

echo -e "\n\n - Generic project created, now creating .zip files.\n"
cd ${GENERIC_PATH}/android
ditto -c -k --rsrc --sequesterRsrc . ${GENERIC_PATH}/android.zip

cd ${GENERIC_PATH}/ios
ditto -c -k --rsrc --sequesterRsrc . ${GENERIC_PATH}/ios.zip


tput setaf 2; echo -e "\n\n - - -   FINISHED   - - -\nTo submit to the project to Device Farm go to LINK and submit one of the .zip file:"
tput setaf 1; echo -e "\nLINK: https://signin.aws.amazon.com/console"
tput setaf 4; echo -e " - ${GENERIC_PATH}/ios.zip\n - ${GENERIC_PATH}/android.zip\n\n"
