#!/bin/bash

# Global Variables
KERNEL_VERSION=$(uname -r)
ALPINE_VERSION=$(cat /etc/alpine-release)
BUILD_DATE_TIME=$(cat /etc/docker-tools-build)

#HELM_VERSION=$(helm version --template='{{.Version}}')

# Global Functions
function box()
{
  local s=("$@") b w
  for l in "${s[@]}"; do
    ((w<${#l})) && { b="$l"; w="${#l}"; }
  done
  echo -e "\e[33m+-${b//?/-}-+"
  for l in "${s[@]}"; do
    printf '| %s%*s%s |\n' "$(echo -e "\e[0m")" "-$w" "$l" "$(echo -e "\e[33m")"
  done
  echo -e "\e[33m+-${b//?/-}-+\e[0m"
}

echo
echo -e "\e[36m▒█▀▀▄ █▀▀█ █▀▀ █░█ █▀▀ █▀▀█\e[0m 　 \e[33m▀▀█▀▀ █▀▀█ █▀▀█ █░░ █▀▀ \e[0m"
echo -e "\e[36m▒█░▒█ █░░█ █░░ █▀▄ █▀▀ █▄▄▀\e[0m 　 \e[33m░▒█░░ █░░█ █░░█ █░░ ▀▀█ \e[0m"
echo -e "\e[36m▒█▄▄▀ ▀▀▀▀ ▀▀▀ ▀░▀ ▀▀▀ ▀░▀▀\e[0m 　 \e[33m░▒█░░ ▀▀▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀ \e[0m"
echo
echo "      https://github.com/glenndehaan/docker-tools      "
echo

# Output container/tools versions
echo -e "\e[36m>> Container <<\e[0m"
box "Linux Kernel: $KERNEL_VERSION" "Alpine Linux: $ALPINE_VERSION" "Build:        $BUILD_DATE_TIME"
echo
#echo -e "\e[36m>> Tools <<\e[0m"
#box "Helm:      $HELM_VERSION"
#echo
