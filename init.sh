#!/bin/bash
#if no input is used script, exit immediately. else, run entirety
if [[ -z "$1" ]]; then
  echo -e "No project name provided.  Exiting."
  exit
elif [[ -z $(pip list | grep Django) ]]; then
  echo -e "Please install Django or load virtual environment. Exiting."
  exit
elif [[ $1 == "test" ]] || [[ $1 == "new" ]]; then
  echo -e "Invalid app/project name.  Please use a different name."
  exit
fi
###ALL COMMANDS ARE RUNNING FROM INIT.SH DIRECTORY PRIOR TO GIT
#saves current working directory for later use
currentdir=$(pwd)
proj=$1
projroot=$currentdir/$1

#starts project, wait 3 seconds to create folder then make apps folder
echo -e "Starting project..."
django-admin startproject $proj
sleep 3
mkdir $projroot/apps
sed -i "" "16s|$|, include|" $projroot/$proj/urls.py
sed -i "" "20s|admin/||;20s|admin.site.urls|include('apps."$proj".urls', namespace = 'main')|" $projroot/$proj/urls.py
#----------------------------------------------REMEMBER TO EDIT SETTINGS.PY

#creates .gitignorefile
echo $'*.pyc\nvenv/' > $projroot/.gitignore

#changing directory to project/apps
echo -e "Starting app..."
cd $projroot/apps
touch __init__.py
django-admin startapp $proj
sleep 3
#--------------------------------------------REMEMBER TO FINISH EDITTING VIEWS.PY
sed -i "" "1s|$|, redirect|" $projroot/apps/$proj/views.py
# sed -i $projroot/apps/$proj/views.py -e "" "$ a def index(request):;$ a    return render(request, '"$proj"/index.html')"

#making static and template folders under
echo -e "Creating additional files..."
for name in {static,templates}; do
  mkdir $projroot/apps/$proj/$name
  mkdir $projroot/apps/$proj/$name/$proj
done

#copy index and url files to respective folders
cp $currentdir/urls.py $projroot/apps/$proj
cp $currentdir/index.html $projroot/apps/$proj/templates/$proj/
cp $currentdir/styles.css $projroot/apps/$proj/static/$proj
sed -i "" "6s|appname|"$proj"|" $projroot/apps/$proj/templates/$proj/index.html

###SWAPPING TO PROJECT FOLDER
echo -e "Saving pip requirements and initializing GIT repo..."
cd $projroot

#Saving pip requirements
pip freeze > requirements.txt

#initializing GIT repository for project
git init
git add .
git commit -m "First Commit"

echo -e "Complete"
