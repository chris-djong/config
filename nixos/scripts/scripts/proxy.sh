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

_create_apt_conf_proxy() {
  if [[ ! -d /etc/apt ]]  ||  [[ -f /etc/apt/apt.conf-proxy ]]; then
    return 0
  fi
  local proxy=$1
  echo "Acquire::http::Proxy \"$proxy\";" > /etc/apt/apt.conf-proxy
  echo "Acquire::https::Proxy \"$proxy\";" >> /etc/apt/apt.conf-proxy
}

_create_docker_conf_proxy() {
  if [[ ! -d /etc/docker ]]  ||  [[ -f /etc/docker/daemon.json-proxy ]]; then
    return 0
  fi
  local proxy=$1
  echo "{
  \"proxies\": {
  \"http-proxy\": \"$proxy\",
    \"https-proxy\": \"$proxy\",
    \"no-proxy\": \"\"
  }
}" > /etc/docker/daemon.json-proxy
}

_create_ssh_conf_proxy() {
  if [[ ! -d ~/.ssh ]] || [[ -f ~/.ssh/config_proxy ]]; then
    return 0
  fi
  local proxy=$1
  echo "Host ssh.dev.azure.com
       HostName ssh.dev.azure.com
       IdentityFile ~/.ssh/id_rsa
       IdentitiesOnly yes
       ProxyCommand nc -X connect -x $proxy %h %p
Host github.com
       HostName github.com
       IdentityFile ~/.ssh/id_rsa
       IdentitiesOnly yes
       ProxyCommand nc -X connect -x $proxy %h %p
}

set_proxy() {
  local proxy=$1

  # Validate if proxy is provided
  if [ -z "$proxy" ]; then
    echo "Please provide a proxy first. Exiting..."
    return 1
  fi

  _create_apt_conf_proxy $proxy
  _create_docker_conf_proxy $proxy
  _create_ssh_conf_proxy $proxy

  if [ -d /etc/apt ]; then
    _create_symlink /etc/apt/apt.conf-proxy /etc/apt/apt.conf
  else 
    echo "/etc/apt does not exist. Skipping proxy setup.."
  fi
  if [ -d /etc/docker ]; then
    _create_symlink /etc/docker/daemon.json-proxy /etc/docker/daemon.json
  else 
    echo "/etc/docker does not exist. Skipping proxy setup.."
  fi
  if [ -d ~/.ssh ]; then
  _create_symlink ~/.ssh/config_proxy ~/.ssh/config
  else 
    echo "~/.ssh does not exist. Skipping proxy setup.."
  fi

  export http_proxy="$proxy"
  export HTTP_PROXY="$proxy"
  export https_proxy="$proxy"
  export HTTPS_PROXY="$proxy"
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


