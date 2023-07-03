#
# Define OS
#
FROM alpine:3.18

#
# Basic OS management
#

# Install packages
RUN apk add --no-cache htop mc git whois bind-tools curl wget
