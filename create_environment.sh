#!/bin/bash

# first prompt the user for their name then create the main directory and subdirectory
read -p "enter your name:" myName
submission_dir="submission_reminder_$myName"
mkdir -p "$submission_dir/config" "$submission_dir/modules" "$submission_dir/app" "$submission_dir/assets"

