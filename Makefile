build: check-env \
	clean \
	server-build \
	client-build \
	copy-config

server-build:
	(cd chatty-server && CGO_ENABLED=0 go build  -o "../build/server" "./bin/server/main.go")

client-build:
	(cd chatty-client && npm run-script build && cp -ar build ../build/static)

docker-build: check-env
	docker build --build-arg SECRET_KEY=${SECRET_KEY} -t chatty .

copy-config:
	cp config.toml build/config.toml

run:
	docker run -p 8080:8080 -it chatty

deploy:
	heroku container:push web && heroku container:release web && heroku ps:scale web=1

log:
	heroku logs --tail

clean:
	rm -rf build

check-env:
ifndef SECRET_KEY
	$(error SECRET_KEY is undefined)
endif