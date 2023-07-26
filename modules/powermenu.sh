#!/bin/sh

# Define the paths to the required binaries
coreutils_path="/path/to/coreutils"
rofi_path=$(whereis -b rofi | awk '{print $2}')

# Define the options for the power menu
options=("lock" "logout" "suspend" "hibernate" "reboot" "shutdown")

# Prompt the user to select an option
selected_option=$(printf '%s\n' "${options[@]}" | "$rofi_path" -dmenu -p "Power Menu:")

# Handle the selected option
case "$selected_option" in
  "lock")
    i3-msg exec "i3lock"
    ;;
  "logout")
    i3-msg exit
    ;;
  "suspend")
    i3-msg exec "systemctl suspend"
    ;;
  "hibernate")
    i3-msg exec "systemctl hibernate"
    ;;
  "reboot")
    i3-msg exec "systemctl reboot"
    ;;
  "shutdown")
    i3-msg exec "systemctl poweroff"
    ;;
  *)
    echo "Invalid option"
    ;;
esac
