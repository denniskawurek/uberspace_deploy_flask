# Deploy flask to uberspace

[Deutsche Version hier.](README_GER.md)

A small bash-script to deploy your flask application fast on your uberspace (mainly intended for APIs).

## Features

* Checks if dependencies (Flask and flup6) are installed
* Rewrites your URL for a pretty access
* Rewrites your URL for HTTPS
* Interactive mode and execution via arguments

## How to use

1. Upload your flask application to your uberspace server
2. Upload the deploy_flask.sh to your uberspace server and make it executable
3. Execute deploy_flask.sh and follow the instructions

```
./deploy_flask.sh
```

Alternatively you can call the script with arguments for a faster execution (take care of the positions):

```
./deploy_flask UBERSPACE_NAME FLASK_LOCATION FLASK_MODULE_NAME FLASK_APP_NAME API_URL
UBERSPACE_NAME          Your uberspace username
FLASK_LOCATION          The location of your flask application (full path)
FLASK_MODULE_NAME       Name of your flask main module (without .py)
FLASK_APP_NAME          Name of your flask application
API_NAME                The name part of the URL where your APP shall be executable.
```

You can reach your flask application in the path /your_application_name

## Uberspace 7

As stated from the Uberspace team there is no FCGI support on Uberspace 7, yet and it is not clear if it will be in future.

## Hints

If you get an error like "/bin/bash^M: bad interpreter", execute the following command:

```
sed -i -e 's/\r$//' deploy_flask.sh
```

## Sources
[Official Flask documentation](http://flask.pocoo.org/docs/0.10/deploying/fastcgi/)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
