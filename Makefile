deploy: deploy-server deploy-bot

deploy-server:
	(cd build-server && make build && make deploy)

deploy-bot:
	(cd build-bot && make build && make deploy)
