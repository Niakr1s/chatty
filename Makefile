build: check-env \
	server-pull \
	client-pull \
	clean \
	server-build \
	copy-config \
	client-build \
	docker-build

server-pull:
	if [ -d "chatty-server" ]; then (cd chatty-server && git pull); else git clone https://github.com/niakr1s/chatty-server; fi

client-pull:
	if [ -d "chatty-client" ]; \
	then (cd chatty-client && git pull); \
	else git clone https://github.com/niakr1s/chatty-client && (cd chatty-client && npm install); \
	fi

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

clean:
	rm -rf build

check-env:
ifndef SECRET_KEY
	$(error SECRET_KEY is undefined)
endif