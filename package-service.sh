
tag_and_push_image() {
  ACCOUNT_NAME='vadimdyachenko'

  echo "building image $1"
  echo "building commit $2"
  echo "building pullrequest $3"

  COMMIT_HASH="$(expr substr $2 1 10)"
  DATE="$(date +%Y-%m-%d)"
  sudo docker build -t $ACCOUNT_NAME/$1:$3.$DATE-$COMMIT_HASH .
  echo "pushing image $1"
  sudo docker push $ACCOUNT_NAME/$1:$3.$DATE-$COMMIT_HASH
}

main() {
	tag_and_push_image "$@"
}

main "$@"