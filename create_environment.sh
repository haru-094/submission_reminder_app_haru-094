#!/bin/bash

# first prompt the user for their name then create the main directory and subdirectory
read -p "enter your name:" myName

# check if the user enter and is not empty
if [ -z	"$myName" ]; then
	echo "You need to enter a name for the app to work"
	exit 1
fi

submission_dir="submission_reminder_$myName"
mkdir -p "$submission_dir/config" "$submission_dir/modules" "$submission_dir/app" "$submission_dir/assets"

## create the main files inside the Subdirectory and insert the content into the files

# config file

cat > "$submission_dir/config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# function files
cat > "$submission_dir/modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}

EOF

# reminder file

cat > "$submission_dir/app/reminder.sh" << 'EOF'

#!/bin/bash
current_dir_reminder=$(dirname "$0")

source "$current_dir_reminder/../config/config.env"
source "$current_dir_reminder/../modules/functions.sh"

submissions_file="$current_dir_reminder/../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# submisssion file

cat > "$submission_dir/assets/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
EOF

## End of creating files

# Implement the startup file
cat > "$submission_dir/startup.sh" << EOF
#!/bin/bash
bash "$submission_dir/app/reminder.sh"
EOF

# make all the file with extinsion .sh executable to run the program
chmod +x $submission_dir/app/reminder.sh $submission_dir/modules/functions.sh $submission_dir/startup.sh

# run the startup
bash $submission_dir/startup.sh

