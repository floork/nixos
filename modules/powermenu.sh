#!/bin/sh

# Define the paths to the required binaries
coreutils_path="/path/to/coreutils"
rofi_path=$(whereis -b rofi | awk '{print $2}')

# Define the options for the power menu
options=("lock" "logout" "suspend" "hibernate" "reboot" "shutdown")

# Prompt the user to select an option
selected_option=$(printf '%s\n' "${options[@]}" | "$rofi_path" -dmenu -p "Power Menu:")

# Convert the user input to lowercase using 'tr'
selected_option=$(echo "$selected_option" | tr '[:upper:]' '[:lower:]')

# Handle the selected option
matched_option=""
for option in "${options[@]}"; do
  # Convert each option to lowercase for case-insensitive comparison
  option_lc=$(echo "$option" | tr '[:upper:]' '[:lower:]')

  # Check if the input matches any of the options
  if [ "$option_lc" = "$selected_option" ]; then
    matched_option="$option"
    break
  fi
done

if [ -n "$matched_option" ]; then
  case "$matched_option" in
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
  esac
else
  echo "Invalid option"
fi
