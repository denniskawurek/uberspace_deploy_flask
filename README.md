# Deploy flask to uberspace

A small executable bash-script to deploy your flask application fast (mainly intended for APIs).

## How to use

1. Upload your flask application to your uberspace server
2. Upload the deploy_flask.sh to your uberspace server and make it executable
3. In the terminal install the flask and flup6 with the commands:

```
pip3 install flask --user
pip3 install flup6 --user
```

4. Execute deploy_flask.sh and follow the instructions

```
./deploy_flask.sh
```

You can reach your flask application in the path /fcgi-bin/your_application_name.fcgi

## ToDos

- Implement rewrite rules for a more beautiful URL
- Don't exit the script after every false input - ask again for
- Test on Uberspace V7
- Clean the code



## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
