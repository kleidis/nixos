#!/bin/bash

echo "Select a host configuration:"
select host in $(ls ~/nixos/hosts); do
    break
done
switch="sudo nixos-rebuild switch --flake ~/nixos/#$host"
echo $switch
