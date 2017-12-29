#!/bin/bash -e

detect_changed_services() {
 echo "----------------------------------------------"
 echo "detecting changed folders for this commit"

 changed_folders="$(git diff --name-only $SHIPPABLE_COMMIT_RANGE | grep / | awk 'BEGIN {FS="/"} {print $1}' | uniq)"
 echo "$(git for-each-ref | grep ^$(git rev-parse MERGE_HEAD))"
 echo "changed folders: "$changed_folders

 changed_services=()
 for folder in $changed_folders
 do
     echo "Adding $folder to list of services to build"
     changed_services+=("$folder")
 done

 for service in "${changed_services[@]}"
 do
   echo "-------------------Running packaging for $service---------------------"
   cp package-service.sh $service
   pushd "$service"
   if [ -f "Dockerfile" ];
    then ./package-service.sh "$service"
    else echo "Dockerfile not present in $service. Packaging skipped"
   fi
   popd
 done
}

detect_changed_services