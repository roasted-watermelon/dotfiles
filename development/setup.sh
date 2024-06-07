#!/usr/bin/env bash

source <(cat ../.common/*)

common_setup "../packages" "development"

set_env_var "JAVA_HOME" "/home/${USER}/android-studio/jbr"
