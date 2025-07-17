#!/bin/bash

############################################################
# Script: Fetch and Display Weather Summary                 #
# Purpose: Retrieve current weather condition, temperature, #
#          and humidity from wttr.in, map condition to      #
#          a corresponding icon, and print a formatted line.#
############################################################

# Get weather information from wttr.in (condition, temperature, humidity)
weather=$(curl -sS "wttr.in?format=%C+%t+%h")

# Extract the weather condition (first word(s)) and temperature (e.g. +23°C)
condition=$(echo "$weather" | grep -oE '^[[:alpha:] ]+[[:alpha:]]')
temperature=$(echo "$weather" | grep -oE '[+-]?[0-9]+°C')

# Map weather condition to icon for display
case $condition in
  "Clear"*) icon=" ";;         # Sunny icon (Unicode \uf305)
  "Partly cloudy"*) icon=" ";; # Partly cloudy icon (\uf002)
  "Cloudy"*) icon=" ";;        # Cloud icon (\uf041)
  "Mist"*) icon=" ";;          # Mist/fog icon (\uf74e)
  "Fog"*) icon=" ";;           # Fog icon (\uf74e)
  "Light rain"*) icon=" ";;    # Light rain icon (\ue009)
  "Moderate rain"*) icon=" ";; # Moderate rain icon (\ue009)
  "Heavy rain"*) icon=" ";;    # Heavy rain icon (\uf02d)
  "Overcast"*) icon=" ";;      # Overcast icon (\uf041)
  *) icon=" ";;                # Default warning icon (\u2757)
esac

# Output formatted weather: condition, icon, temperature
echo "$condition $icon$temperature"
