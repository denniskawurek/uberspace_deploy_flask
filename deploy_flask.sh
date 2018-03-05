#!/bin/bash

check_and_install_dependencies() {
        FOUND_FLASK=$(pip3 list | grep -c -w 'Flask')
        FOUND_FLUP=$(pip3 list | grep -c -w 'flup6')

        if [[ FOUND_FLASK -eq 1 ]]; then
                echo "Found Flask: $(pip3 list | grep -w 'Flask')"

        else
                pip3 install flask --user
        fi

        if [[ FOUND_FLUP -eq 1 ]]; then
                echo "Found flup6: $(pip3 list | grep -w 'flup6')"
        else
                pip3 install flup6 --user
        fi
}

set_var() {
        echo -e $1 #question
        while read ASKING; do
                if [[ -z "$ASKING" ]]; then
                        echo -e $2 # error message
                else
                        eval $3=$ASKING # store in variable
                        break
                fi
        done
}

check_and_install_dependencies

# uberspace username
set_var "Your Uberspace username?" "Uberspace name must not be empty." UBERSPACE_NAME
# location of flask application
set_var "Location of your Flask application?\n(Type in full location path e.g. /home/username/flaskapplication)\nHint: To find out the location type the 'pwd' command in your application folder." "Location of Flask application must not be empty." FLASK_LOCATION
# name of flask module
set_var "Name of the file where your entry point of the application is (without .py)?" "MODULE of Flask application must not be empty." FLASK_MODULE
# name of flask application
set_var "Name of your Flask application?" "Location of Flask application must not be empty." FLASK_NAME
# identifier of application
set_var "Identifier of your application? (e.g. if https://www.site.de/api you need to write 'api')" "The identifier must not be empty." API_URL

# create the fcgi script
cd /home/$UBERSPACE_NAME/fcgi-bin

SCRIPT_NAME=$API_URL.fcgi

if [[ -e SCRIPT_NAME ]]; then
        echo "The API-URL already exists. Please check the corresponding file ($SCRIPT_NAME) in your /fcgi-bin folder"
        exit
fi

touch $SCRIPT_NAME

/bin/cat <<EOM >$SCRIPT_NAME
#!/usr/bin/env python3
import sys

sys.path.insert(0, "$FLASK_LOCATION")
from $FLASK_MODULE import $FLASK_NAME

from flup.server.fcgi_fork import WSGIServer
WSGIServer($FLASK_NAME).run()
EOM

chmod +x $SCRIPT_NAME

echo "Well done! You can reach your flask application under domain.com/fcgi-bin/$SCRIPT_NAME"
exit 0