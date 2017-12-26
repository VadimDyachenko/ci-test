
tag_and_push_image() {
  ACCOUNT_NAME='vadimdyachenko'

  echo "building image $1"
  sudo docker build -t $ACCOUNT_NAME/$1:$BRANCH.$SHIPPABLE_BUILD_NUMBER .
  echo "pushing image $1"
  sudo docker push $ACCOUNT_NAME/$1:$BRANCH.$SHIPPABLE_BUILD_NUMBER

  # We trigger the manifest and subsequently the deploy jobs downstream by posting a new version to the image resource.
  # Since the image resource is an INPUT to the manifest job, the manifest job will get scheduled to run after these steps.
#  echo "posting the version of the image resource for $1"
#  shipctl put_resource_state $1"_img" "SHIPPABLE_BUILD_NUMBER" $SHIPPABLE_BUILD_NUMBER
#  shipctl put_resource_state $1"_img" "versionName" $BRANCH.$SHIPPABLE_BUILD_NUMBER

}

main() {
	tag_and_push_image "$@"
}

main "$@"