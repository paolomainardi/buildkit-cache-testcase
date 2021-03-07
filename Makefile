DOCKER_IMAGE_TEST_CI=paolomainardi/buildkit-cache-testcase
CI_COMMIT_REF_SLUG=master

docker:
	docker system prune --all -f || true
	docker rmi ${DOCKER_IMAGE_TEST_CI}:${CI_COMMIT_REF_SLUG} || true
	DOCKER_BUILDKIT=1 BUILDKIT_PROGRESS=plain docker-compose build
	docker push ${DOCKER_IMAGE_TEST_CI}:${CI_COMMIT_REF_SLUG}




