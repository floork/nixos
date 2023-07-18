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
    i3exit lock
    ;;
  "Logout")
    i3exit logout
    ;;
  "Suspend")
    i3exit suspend
    ;;
  "Hibernate")
    i3exit hibernate
    ;;
  "Reboot")
    i3exit reboot
    ;;
  "Shutdown")
    i3exit shutdown
    ;;
  *)
    echo "Invalid option"
    ;;
esac
