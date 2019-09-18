#!/bin/bash

### This script used to delete from App Engine services 
### older/unused versions of flexible app (only STOPPED versions)

echo "Service name : "
read SERVICE
echo "How much versions you want to keep? "
read N

VERSIONS=$(gcloud app versions list --service $SERVICE --sort-by '~version' --filter="version.servingStatus='STOPPED'" --format 'value(version.id)' | sort -r | tail -n +$N)

echo "Keeping the $N latest versions of the $SERVICE service"
echo -e "These versions will be deleted :\n$VERSIONS "

while true; do
    read -p "Do you wish to delete these all? (Y/n) " yn
    case $yn in
        [Yy]* ) gcloud app versions delete --service $SERVICE $VERSIONS; echo "DELETED!"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done