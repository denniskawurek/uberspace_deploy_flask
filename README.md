# Deploy flask to uberspace

A small executable bash-script to deploy your flask application fast (mainly intended for APIs).

## How to use

1. Upload your flask application to your uberspace server
2. Upload the deploy_flask.sh to your uberspace server and make it executable
3. Execute deploy_flask.sh and follow the instructions

```
./deploy_flask.sh
```

You can reach your flask application in the path /fcgi-bin/your_application_name.fcgi

## ToDos

- Implement rewrite rules for a more beautiful URL
- Call the script with paramters
- Test on Uberspace V7

## Hints

If you get an error like "/bin/bash^M: bad interpreter", execute the following command:

```
sed -i -e 's/\r$//' deploy_flask.sh
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
