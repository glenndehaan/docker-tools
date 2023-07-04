#!/bin/bash

# Output motd before command
motd

# Check current environment
if [[ -n "$CI" ]]; then
    echo -e "[\e[32mENTRYPOINT\e[0m] Running as: CI/CD Tool"
    exec /bin/sh
else
    echo -e "[\e[32mENTRYPOINT\e[0m] Running as: Shell"
    exec "$@"
fi
