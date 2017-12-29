#!/bin/bash -e

detect_changed_services() {
 echo "----------------------------------------------"
 echo "detecting changed folders for this commit"

 changed_folders="$(git diff --name-only $SHIPPABLE_COMMIT_RANGE | grep / | awk 'BEGIN {FS="/"} {print $1}' | uniq)"
 echo "changed folders: "$changed_folders

 echo "$(git name-rev --name-only MERGE_HEAD)"

 for folder in $changed_folders
 do
   echo "-------------------Running packaging for $folder---------------------"
   cp package-service.sh $folder
   pushd "$folder"
   if [ -f "Dockerfile" ];
    then ./package-service.sh "$folder"
    else echo "Dockerfile not present in $folder. Packaging skipped"
   fi
   popd
 done
}

detect_changed_services