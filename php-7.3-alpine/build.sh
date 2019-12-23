#!/bin/bash

docker build . --file Dockerfile --tag php73-alpine:1.0
docker build . --file Cli-Dockerfile --tag php73-cli-alpine:1.0