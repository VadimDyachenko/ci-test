main() {
  ACCOUNT_NAME='vadimdyachenko'

  echo "building image: $1"
  echo "building commit: $COMMIT"
  echo "Head branch: $HEAD_BRANCH"

  declare -A SERVICES
  SERVICES=(
  [clients]=clients-img
  [orders]=orders-img
  )

  COMMIT_HASH="$(expr substr $COMMIT 1 10)"
  DATE="$(date +%Y-%m-%d)"
  sudo docker run --name=gradle -u root --rm --volumes-from $SHIPPABLE_CONTAINER_NAME -w /build romach007/gradle-build:1.0 gradle clean assemble --stacktrace
  sudo docker build -t $ACCOUNT_NAME/${SERVICES[$1]}:$BRANCH.$DATE-$COMMIT_HASH .
  echo "pushing image $1"
  sudo docker push $ACCOUNT_NAME/${SERVICES[$1]}:$BRANCH.$DATE-$COMMIT_HASH
}

main "$@"