#!/bin/bash

sudo docker build -t www-php:v1 -f ./Dockerfile .
sudo docker build -t cli-php:v1 -f ./DockerfileForCli .
