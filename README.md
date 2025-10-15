# submission Reminder App
This a shell project contain script to create and track assignment using command-line environment.

This contain two file script
* **create_environment.sh** : This will init the directory structure, create all the required file with content. This the first step of setting this project 
* **copilot_shell_script** : This script used to modifiy the content of the assignment to new one.

# Feature 
* Automated: create the directory structure, with the configuration steup.
* Simple execution: use the startup.sh to run the reminder app.
* Easy update: Make the user to updated the assignment to add new one assignment without editing manually the configuration file.
* track student assignment: easy to run and track how day left for the assignment.

# How to use

1. Created the environment structure
run create_environment.sh to make the structure this will ask for name that will created the directory app with this name
```
./create_environment.sh
```
2. Updated the assignment
this will modifiy the assignment and add new one and in first will ask for the name to check if the directory is exist with that name.
```
./copilot_shell_script.sh
```

3. Then it will ask for the new assignment to make the modifiy.

# File structure
```
submission_reminder_{name}
    app/
        reminder.sh => contain the check of the assignment
    assets/
        submission.txt => have a sample to test the app when created
    modules/
        functions.sh => this contain the main function for the app to work
startup.sh => this will run the reminder app
```

