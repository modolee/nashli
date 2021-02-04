#!/bin/bash

CMD="docker-compose \
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
  options=("Build and Run" "Run" "Quit")
  select yn in "${options[@]}"; do
      case $yn in
          "Build and Run" ) build "$1"; run "$1"; break;;
          "Run" )           run "$1"; break;;
          "Quit" )          exit;;
      esac
  done
}

menu "$CMD";