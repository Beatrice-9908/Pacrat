#!/bin/bash

#Set home variable to sudo_user home directory
USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)

#Make config and set default directory
config() {
  if [[ ! -d /etc/pacrat/ ]]; then
    mkdir -p /etc/pacrat/
  fi

  if [[ ! -f /etc/pacrat/pacratconf ]]; then
    touch /etc/pacrat/pacratconf
    echo "[Path] = $USER_HOME" >/etc/pacrat/pacratconf
  fi

  dir=$(awk '{print $3}' /etc/pacrat/pacratconf)
}

#Call config function
config

#Check for no path or root path set in config
if [[ -z "${dir// /}" ]] || [[ $dir == "/" ]]; then
  printf "Pacrat: Save path has been incorrectly set\nNo pkglists have been created\nEdit config in /etc/pacrat/pacratconf to set save path\n"
  exit 1

fi

#Create files and directories if they doesnt exist; populate files
if [[ -d "$dir/pacrat/" ]]; then
  pacman -Qqen >"$dir"/pacrat/images/pkglist_current
  pacman -Qqem >"$dir"/pacrat/aurimages/foreignpkglist_current
else
  mkdir -p "$dir"/pacrat/images/
  chmod 755 "$dir"/pacrat/
  mkdir -m 755 "$dir"/pacrat/aurimages/
  touch "$dir"/pacrat/images/pkglist_current
  chmod 644 "$dir"/pacrat/images/pkglist_current
  touch "$dir"/pacrat/aurimages/foreignpkglist_current
  chmod 644 "$dir"/pacrat/aurimages/foreignpkglist_current
  pacman -Qqen >"$dir"/pacrat/images/pkglist_current
  pacman -Qqem >"$dir"/pacrat/aurimages/foreignpkglist_current
fi
