## setup

SNAPSHOT='{"application":"konflux-arm64-test-demo","components":[{"name":"arm64-test-demo","containerImage":"quay.io/redhat-user-workloads/brianwcook-tenant/konflux-arm64-test-demo/arm64-test-demo@sha256:54ac9587a8e1e5d6f29eb9bbb3fc45610b60af50ef46adfbc01d128654f82e0b","source":{"git":{"url":"https://github.com/brianwcook/konflux-arm64-test-demo","revision":"c0d2e38987b4d094fbe77e9a0e8c6d271d50dd23"}}}],"artifacts":{}}'
###

echo "Snapshot:\n"
echo ${SNAPSHOT} | jq "."
# extract image pullspec here
IMAGE=$(echo ${SNAPSHOT} | jq '.components.[] | select(.name=="arm64-test-demo")'| jq .containerImage | tr -d '"')

# Run custom tests for the given Snapshot here
# After the tests finish, record the overall result in the RESULT variable
 
echo running test
if podman run --rm --entrypoint="/hello-world.sh" $IMAGE | grep -Fxq 'Hello World!'; then
  RESULT="SUCCESS"
  echo $RESULT
fi

# Output the standardized TEST_OUTPUT result in JSON form
#TEST_OUTPUT=$(jq -rc --arg date $(date +%s) --arg RESULT "${RESULT}" --null-input \
#  '{result: $RESULT, timestamp: $date, failures: 0, successes: 1, warnings: 0}')
#echo -n "${TEST_OUTPUT}" | tee $(results.TEST_OUTPUT.path)