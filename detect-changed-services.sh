#!/bin/bash -e

detect_changed_services() {
 echo "----------------------------------------------"
 echo "detecting changed folders for this commit"

 # get a list of all the changed folders only
 changed_folders="$(git diff --name-only $SHIPPABLE_COMMIT_RANGE | grep / | awk 'BEGIN {FS="/"} {print $1}' | uniq)"
 echo "changed folders: "$changed_folders

 changed_services=()
 for folder in $changed_folders
 do
#   if [ "$folder" == '_global' ]; then
#     echo "common folder changed, building and publishing all microservices"
#     changed_services="$(find . -maxdepth 1 -type d -not -name '_global' -not -name 'shippable' -not -name '.git' -not -path '.' | sed 's|./||')"
#     echo "list of microservice "$changed_services
#     break
#   else
     echo "Adding $folder to list of services to build"
     changed_services+=("$folder")
#   fi
 done

 echo "${changed_services[@]}"

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