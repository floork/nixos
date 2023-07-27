#!/bin/sh

# Define the paths to the required binaries
coreutils_path="/path/to/coreutils"
rofi_path=$(whereis -b rofi | awk '{print $2}')

# Define the options for the power menu
options=("Lock" "Logout" "Suspend" "Hibernate" "Reboot" "Shutdown")

# Prompt the user to select an option
selected_option=$(printf '%s\n' "${options[@]}" | "$rofi_path" -dmenu -p "Power Menu:")

# Handle the selected option
case "$selected_option" in
  "Lock")
    i3-msg exec "i3lock"
    ;;
  "Logout")
    i3-msg exit
    ;;
  "Suspend")
    i3-msg exec "systemctl suspend"
    ;;
  "Hibernate")
    i3-msg exec "systemctl hibernate"
    ;;
  "Reboot")
    i3-msg exec "systemctl reboot"
    ;;
  "Shutdown")
    i3-msg exec "systemctl poweroff"
    ;;
  *)
    echo "Invalid option"
    ;;
esac
