FROM alpine:3.14
RUN apk update && apk add bash

WORKDIR /app
COPY . .

ENTRYPOINT ./job.sh