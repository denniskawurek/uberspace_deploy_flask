#!/bin/bash

check_and_install_dependencies() {
        echo "Checking if dependencies (flask & flup6) are installed."
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

interactive_mode() {
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
}

create_script() {
        # create the fcgi script
        cd /home/$UBERSPACE_NAME/fcgi-bin

        if [[ $? -eq 1 ]]; then
                echo -e "Error: Couldn't reach the fcgi path.\nIs your uberspace name right?\nAre you running on an Uberspace 6?"
                exit 1
        fi
        
        SCRIPT_NAME=$API_URL.fcgi
        
        if [[ -f SCRIPT_NAME ]]; then
                echo "Error: The API-URL already exists. Please check the corresponding file ($SCRIPT_NAME) in your /fcgi-bin folder"
                exit 1
        fi

        touch $SCRIPT_NAME

        if [[ $? -eq 1 ]]; then
                echo "Error: Couldn't create fcgi-script."
                exit 1
        fi

/bin/cat <<EOM >$SCRIPT_NAME
#!/usr/bin/env python3
import sys

sys.path.insert(0, "$FLASK_LOCATION")
from $FLASK_MODULE import $FLASK_NAME

from flup.server.fcgi_fork import WSGIServer
WSGIServer($FLASK_NAME).run()
EOM

        chmod +x $SCRIPT_NAME

        if [[ $? -eq 1 ]]; then
                echo "Error: Couldn't set execution permissions for fcgi-script."
                exit 1
        fi

        echo "Well done! You can reach your flask application under domain.com/fcgi-bin/$SCRIPT_NAME"
        exit 0
}

check_and_install_dependencies
if [[ $# -ne 5 ]]; then
        echo "Starting interactive mode."
        interactive_mode
        create_script
elif [[ $1 =~ 'help' ]] || [[ $1 =~ '-h' ]]; then
        echo -e "Call the script without arguments for the interactive mode.
        Or with arguments (take care of the positions):
        deploy_flask UBERSPACE_NAME FLASK_LOCATION FLASK_MODULE_NAME FLASK_APP_NAME API_URL
        UBERSPACE_NAME          Your uberspace username
        FLASK_LOCATION          The location of your flask application
        FLASK_MODULE_NAME       Name of your flask main module (without .py)
        FLASK_APP_NAME          Name of your flask application
        API_NAME                The name part of the URL where your APP shall be executable."
else
        UBERSPACE_NAME=$1
        FLASK_LOCATION=$2
        FLASK_MODULE=$3
        FLASK_NAME=$4
        API_URL=$5

        create_script
fi