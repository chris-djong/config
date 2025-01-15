#!/bin/bash

# Function to create a symlink
_create_symlink() {
    local TARGET="$1"
    local LINK="$2"

    # Check if the target file exists
    if [[ ! -f "$TARGET" ]]; then
        echo "Error: Target file $TARGET does not exist. Aborting."
        return 1
    fi

    # Check if the symlink or file exists at the link location
    if [[ -e "$LINK" || -L "$LINK" ]]; then
        return 0
    fi

    # Create the symlink
    sudo ln -s "$TARGET" "$LINK"
    return 0
}

_unlink() {
  local LINK=$1
  if [[ -e "$LINK" || -L "$LINK" ]]; then
    sudo unlink "$LINK" 2>/dev/null || rm -f "$LINK"
  fi
  return 0
}

set_proxy() {
  _create_symlink "/etc/apt/apt.conf-proxy" "/etc/apt/apt.conf"
  _create_symlink "/etc/docker/daemon.json-proxy" "/etc/docker/daemon.json"
  _create_symlink "/home/entourage/.ssh/config_proxy" "/home/entourage/.ssh/config"

  export http_proxy="http://10.56.4.40:8080"
  export HTTP_PROXY="http://10.56.4.40:8080"
  export https_proxy="http://10.56.4.40:8080"
  export HTTPS_PROXY="http://10.56.4.40:8080"
  export no_proxy="localhost"
}


unset_proxy() {
  _unlink "/etc/apt/apt.conf"
  _unlink "/home/entourage/.ssh/config"
  _unlink "/etc/docker/daemon.json"

  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset HTTPS_PROXY
  unset no_proxy
}


