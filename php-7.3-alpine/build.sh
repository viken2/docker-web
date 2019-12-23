#!/bin/bash

build . --file Dockerfile --tag php73-alpine:1.0
build . --file Cli-Dockerfile --tag php73-cli-alpine:1.0