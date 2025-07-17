#!/usr/bin/env bash

# Launch a new kitty terminal with a custom window class "updatescratch" to run the update script
kitty --class=updatescratch -e bash -c '
  # Define ANSI color codes for output styling
  GREEN="\033[1;32m"
  RED="\033[1;31m"
  YELLOW="\033[1;33m"
  BLUE="\033[1;34m"
  RESET="\033[0m"

  # Notify user that update is starting
  echo -e "${YELLOW}󰚰 Running nala update...${RESET}"
  sudo nala update
  echo

  # Count how many packages are upgradable (excluding header and blank lines)
  count=$(nala list --upgradable | grep -vE "Package|Listing|^$" | wc -l)

  # If no updates are available, inform user and wait for Enter key to exit
  if [ "$count" -eq 0 ]; then
    echo -e "${GREEN}✔ Everything is up to date!${RESET}"
    echo
    read -rp "🟢 Press Enter to exit..."
    exit 0
  else
    # Otherwise, list the upgradable packages and ask for confirmation to upgrade
    echo -e "${BLUE}⬆ $count packages can be upgraded:${RESET}"
    echo
    nala list --upgradable
    echo
    read -rp "Proceed with upgrade? [y/N] " ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
      echo -e "${YELLOW}󰞷 Running upgrade...${RESET}"
      sudo nala upgrade
    else
      echo -e "${RED}✘ Upgrade cancelled.${RESET}"
    fi
    echo
    # Wait for Enter key before closing the terminal
    read -rp "Press Enter to exit..."
  fi
' &

# Small delay to allow kitty window to launch, then show the scratchpad window in i3 with class "updatescratch"
sleep 0.3
i3-msg '[class="updatescratch"] scratchpad show'
