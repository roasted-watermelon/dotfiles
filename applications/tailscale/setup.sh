#!/usr/bin/env bash

source <(cat ../../.common/*)

common_setup "../../packages" "applications/tailscale"

sudo systemctl enable --now tailscaled

sudo tailscale set --operator=$USER