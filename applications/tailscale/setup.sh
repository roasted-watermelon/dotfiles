#!/usr/bin/env bash

cd ..
./.common_setup.sh "tailscale"

sudo systemctl enable --now tailscaled