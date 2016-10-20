Written by S.Chang

Description:
Preps django project and git repo.

Requirements:
- Unix system with BASH (Mac/Linux)
- django

Conducts the following in the same directory as the script:
- create project
- create apps folder
- crete __init__.py file
- create first app with associated project name
- edit project urls.py to point to respective first app
- create url.py in app folder
- create template and static folder
- create initial index file
- create static style.css
- pip freeze requirements
- create git repository
- create git ignore

WARNINGS:
- Works only on systems with bash
- Do not create folder with spaces to either hold the script or for project/app names
- Keep index.html, styles.css, urls.py in the same directory as the script.
These are base files that will be copied into the respective directories

WIP:
- Adding initial app to settings.py
- Adding initial process to views.py

------------------------------------------------------------------------

FIRST RUN:
1. Locate init.sh file.
2. Make script executeable:
chmod +x init.sh

STANDARD USE:
1. Go to folder with init.sh
3. Run command, replacing <PROJECTNAME> with name of choice:
./init.sh <PROJECTNAME>
