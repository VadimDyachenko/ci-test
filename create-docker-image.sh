#!/bin/bash -e

create-docker-image() {
 echo "----------------------------------------------"
 echo "detecting changed folders for this commit"

 for folder in */
 do
   echo "-------------------Running packaging for $folder---------------------"
   cp package-service.sh $folder
   pushd "$folder"
   if [ -f "Dockerfile" ];
    then ./package-service.sh ${folder%%/}
    else echo "Dockerfile not present in ${folder%%/}. Packaging skipped"
   fi
   popd
 done
}

create-docker-image