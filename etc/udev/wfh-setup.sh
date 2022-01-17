#!/bin/bash
# /etc/udev/wfh-setup.sh

MY_USER="nbleuzen"
MY_USER_ID=$(id -u ${MY_USER})
LOG_PREFIX=$(date)

function log() {
    echo "${LOG_PREFIX}" "$@" >> /tmp/udev.log
}

function execute_as_user() {
    sudo -u ${MY_USER} DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/${MY_USER_ID}/bus $@
}

function display_connection() {
    log "display_connection for ${MY_USER}"
    # When connecting to the Work From Home setup, set the Gnome text scaling to
    # 1.5 to have something readable on a 4K screen without using display scaling
    execute_as_user gsettings set org.gnome.desktop.interface text-scaling-factor 1.5
    # Set the screen to go drak after 15 minutes of inactivity and lock the
    # session 30 minutes after that
    execute_as_user gsettings set org.gnome.desktop.session idle-delay 900
    execute_as_user gsettings set org.gnome.desktop.screensaver lock-delay 1800
}

function display_disconnection() {
    log "display_disconnection for ${MY_USER}"
    # When disconnecting from the WFH setup reset Gnome's text scaling value to 1
    execute_as_user gsettings reset org.gnome.desktop.interface text-scaling-factor
    # Set the screen to go drak after 3 minutes of inactivity and lock the session
    execute_as_user gsettings set org.gnome.desktop.session idle-delay 180
    execute_as_user gsettings set org.gnome.desktop.screensaver lock-delay 0
}

ACTION="${1}"

# Debug logs
log ${ACTION}
execute_as_user xrandr | grep -E "^DP-." >> /tmp/udev.log

if [ "${ACTION}" == "add" ]; then
    # If a 4k display is connected on DisplayPort, configure the WFH setup
    # Could grep on "^DP-. connected.* 3840x2160" to make sure we're dealing
    # with a 4K display but at this time the resolution is not yet set in xrandr
    execute_as_user xrandr | grep -qE "^DP-. connected" && display_connection || log "No display connected"
    # Configure keyboard to use function keys (FXX) by default instead of media ones
    echo 0 > /sys/module/hid_apple/parameters/fnmode
elif [ "${ACTION}" == "remove" ]; then
    # If no 4k display is connected on DisplayPort, reset the WFH setup
    execute_as_user xrandr | grep -qE "^DP-. connected" && log "Display still connected" || display_disconnection
else
    log "Un-supported udev action ${ACTION}"
fi
