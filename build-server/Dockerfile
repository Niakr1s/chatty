FROM alpine:latest

ADD build app

ARG SECRET_KEY=1234567890
ENV SECRET_KEY=$SECRET_KEY

WORKDIR /app

CMD ["./server", "-config=./config.toml", "-loglevel=trace"]
