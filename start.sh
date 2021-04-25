#!/bin/bash

CMD="docker-compose \
  --env-file .env \
  -p nashli \
  -f ./docker-compose/docker-compose.be.yml \
  -f ./docker-compose/docker-compose.fe.yml \
  -f ./docker-compose/docker-compose.mongo.yml"

function build()
{
  eval "$1" build --parallel
}

function run()
{
  eval "$1" up --remove-orphans
}

function menu()
{
  PS3="Please select which option > "
  COLUMNS=30
  options=("Run" "Build and Run" "Quit")
  select yn in "${options[@]}"; do
    case $yn in
      "Run" )           run "$1"; break;;
      "Build and Run" ) build "$1"; run "$1"; break;;
      "Quit" )          exit;;
    esac
  done
}

menu "$CMD";