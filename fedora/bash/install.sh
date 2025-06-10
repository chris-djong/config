#!/bin/bash

if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc_old
fi

ln -s "$(realpath ./bashrc)" ~/.bashrc
ln -s "$(realpath ./aliases)" ~/.bash_aliases
ln -s "$(realpath ./proxy)" ~/.bash_proxy
ln -s "$(realpath ./prompt)" ~/.bash_prompt
