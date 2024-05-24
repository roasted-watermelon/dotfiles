#!/usr/bin/env bash

# reset everything
gsettings list-schemas | xargs -n 1 gsettings reset-recursively