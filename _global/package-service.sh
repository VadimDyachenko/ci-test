
tag_and_push_image() {
  ACCOUNT_NAME='vadimdyachenko'

  echo "building image $1"

  COMMIT_HASH=expr substr $COMMIT 1 10
  DATE=`date +%Y-%m-%d`
  sudo docker build -t $ACCOUNT_NAME/$1:$PULL_REQUEST_BASE_BRANCH_$DATE-$COMMIT_HASH .
  echo "pushing image $1"
  sudo docker push $ACCOUNT_NAME/$1:$PULL_REQUEST_BASE_BRANCH_$DATE-$COMMIT_HASH
}

main() {
	tag_and_push_image "$@"
}

main "$@"