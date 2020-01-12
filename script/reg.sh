#!/usr/bin/env bash

set -e

# Export the sha256sum for verification.
export REG_SHA256="2768ac56ad640e8ee5b74752fc9bbeaf37f37a34c7e1ddcb6d0e384a3096b1c2"

# Download and check the sha256sum.
curl -fSL "https://github.com/genuinetools/reg/releases/download/v0.16.1/reg-darwin-amd64" -o "/usr/local/bin/reg" \
	&& echo "${REG_SHA256}  /usr/local/bin/reg" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/reg"

echo "reg installed!"

# Run it!
reg -h
