#!/bin/bash

echo "--------------------------"
echo "      Building Image      "
echo "--------------------------"

docker build -t docker-tools:test .

echo "--------------------------"
echo "      Starting Image      "
echo "--------------------------"

docker run --rm -it docker-tools:test /bin/sh

echo "--------------------------"
echo "      Removing Image      "
echo "--------------------------"

docker rmi docker-tools:test
