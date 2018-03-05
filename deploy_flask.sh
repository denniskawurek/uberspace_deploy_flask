#!/bin/bash

echo "Your Uberspace username?"
read UBERSPACE_NAME

if [ -z UBERSPACE_NAME ]; then
        echo "Uberspace name must not be empty."
        exit
fi

echo "Location of your Flask application? (Type in full location path e.g. /home/username/flaskapplication)"
read FLASK_LOCATION

if [ -z FLASK_LOCATION ]; then
        echo "Location of Flask application must not be empty."
        exit
fi

echo "Name of the file where your entry point of the application is (without .py)?"
read FLASK_MODULE

if [ -z FLASK_MODULE ]; then
        echo "MODULE of Flask application must not be empty."
        exit
fi

echo "Name of your Flask application?"
read FLASK_NAME

if [ -z FLASK_NAME ]; then
        echo "Location of Flask application must not be empty."
        exit
fi

echo "Identifier of your application? (e.g. if https://www.site.de/api you need to write 'api')"
read API_URL

if [ -z API_URL ]; then
        echo "The."
        exit
fi

cd /home/$UBERSPACE_NAME/fcgi-bin

if [ -e $API_URL.fcgi ]; then
        echo "The API-URL already exists. Please check the corresponding $API_URL.fcgi file in your /fcgi-bin folder"
        exit
fi

touch $API_URL.fcgi

/bin/cat <<EOM >$API_URL.fcgi
#!/usr/bin/env python3
import sys

sys.path.insert(0, "$FLASK_LOCATION")
from $FLASK_MODULE import $FLASK_NAME

from flup.server.fcgi_fork import WSGIServer
WSGIServer($FLASK_NAME).run()
EOM

chmod +x $API_URL.fcgi

echo "Well done! You can reach your flask application under domain.com/fcgi-bin/$API_URL.fcgi"
exit 0