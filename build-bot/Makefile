build: check-env \
	clean \
	bot-build

bot-build:
	(cd ../chatty-server && CGO_ENABLED=0 go build  -o "../build-bot/build/bot" "./bin/bot/main.go")

docker-build: check-env
	 docker build --build-arg BOT_USERNAME=${BOT_USERNAME} --build-arg BOT_PASSWORD=${BOT_PASSWORD} --build-arg BOT_URL=${BOT_URL} -t chatty-bot .

run:
	docker run -it chatty-bot

deploy: check-env
	heroku config:set BOT_USERNAME=${BOT_USERNAME} BOT_PASSWORD=${BOT_PASSWORD} BOT_URL=${BOT_URL} && \
		heroku container:push worker && \
		heroku container:release worker && \
		heroku ps:scale worker=1

log:
	heroku logs --tail

clean:
	rm -rf build

check-env:
ifndef BOT_USERNAME
	$(error BOT_USERNAME is undefined)
endif
ifndef BOT_PASSWORD
	$(error BOT_PASSWORD is undefined)
endif
ifndef BOT_URL
	$(error BOT_URL is undefined)
endif
