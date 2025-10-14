#!/bin/bash

# ask the user for there username to updated the path of file later
read -p "Enter your username that used for the submission reminder: " userName

# Get the path for submission_reminder
dir_name="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#echo $dir_name

# change the path to thee submission_reminder directory
submission_dir="$dir_name/submission_reminder_${userName}"
#echo $submission_dir

if [ -d $submission_dir ]; then
        echo "directory exist with the path: $submission_dir"
else
        echo "directory not found on the path :$submission_dir"
        exit 1
fi

# ask the user for the new assignment then implement into the config file
read -p "Enter the new assignment: " Add_Assignment

# check if the user type and is not empty
if [ -z "$Add_Assignment" ]; then
	echo "You need to enter an assignemnt and can\`t be empty"
	exit 1
fi

# get the path to the config file to make the adjustment
config_path="$submission_dir/config/config.env"

# check the config file is created by create_environment.sh and it's exist
if [ ! -f "$config_path" ]; then
	echo "config file is not exist at this path: $config_path"
	exit 1
fi

# also check if the startup.sh is exist
if [ ! -f "$submission_dir/startup.sh" ]; then
	echo "startup.sh is not exist at this path: $submission_dir/startup.sh"
fi

# make the update for assignment in the config file
echo "Everything is working let update the assignement"
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$Add_Assignment\"/" "$config_path"

echo "Updated made successfully your adding new assginment: $Add_Assignment"

# run the startup again to check for the update assignment that add by the config.env
bash "$submission_dir/startup.sh"

echo "Sucessfully rerun the startup to check if it updated"
