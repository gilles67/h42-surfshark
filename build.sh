#!/usr/bin/env bash
set -x

docker image rm h42-surfshark
docker build -t h42-surfshark .
