main() {
  ACCOUNT_NAME='vadimdyachenko'

  echo "building image $1"
  echo "building commit $COMMIT"

  COMMIT_HASH="$(expr substr $COMMIT 1 10)"
  DATE="$(date +%Y-%m-%d)"
  sudo docker build -t $ACCOUNT_NAME/$1:$BRANCH.$DATE-$COMMIT_HASH .
  echo "pushing image $1"
  sudo docker push $ACCOUNT_NAME/$1:$BRANCH.$DATE-$COMMIT_HASH
}

main "$@"