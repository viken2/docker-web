#!/bin/bash
# @author viken
# @date 2018-04-11

trap 'ComposeStop; exit' SIGINT SIGTERM

function ComposeStop()
{
    sudo docker-compose down
}

sudo docker-compose down >/dev/null 2>&1 
sudo chmod 777 -R ./www
sudo docker-compose up
