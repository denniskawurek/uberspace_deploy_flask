# Flask auf Uberspace

[English version here.](README.md)

Eine kleines Basch-Script, um deine Flask Anwendung schnell auf deinem Uberspace zum Laufen zu bringen.

## Features

* Prüft ob Abhängigkeiten (Flask und flup6) installiert sind
* Überschreibt deine URLs für einen schöneren Zugriff
* Schreibt in die .htaccess den Zugriff per HTTPS
* Interaktiver Modus und Ausführung mit Paramtern

## Anleitung

1. Lade deine Flask Anwendung auf deinen Uberspace Server hoch
2. Lade das Bash-Sript auf deinen Uberspace hoch und mach es ausführbar
3. Führe deploy_flask.sh aus und folge den Anweisungen

```
./deploy_flask.sh
```
Alternativ kannst Du das Script für einen schnelleren Zugriff auch mit Parametern aufrufen:

```
./deploy_flask UBERSPACE_NAME FLASK_LOCATION FLASK_MODULE_NAME FLASK_APP_NAME API_URL
UBERSPACE_NAME          Dein Uberspace username
FLASK_LOCATION          Das Verzeichnis deiner Flask-Anwendung (voller Pfad)
FLASK_MODULE_NAME       Name von deinem Flask Modul (ohne .py)
FLASK_APP_NAME          Name deiner Flask Anwendung
API_NAME                Name der API unter dem deine Anwendung erreichbar sein soll
```

Du kannst deine Anwendung unter 
https://domain.com/API_NAME aufrufen

## Uberspace 7

Laut dem Team von Uberspace gibt es zur Zeit keine Unterstützung für FCGI und es ist noch nicht klar ob sich dies in Zukunft ändern wird.

## Hinweise

Erhältst Du eine Fehlermeldung vom Typ "/bin/bash^M: bad interpreter", führe folgendes Kommando aus:

```
sed -i -e 's/\r$//' deploy_flask.sh
```

## Quellen
[Offizielle Flask Dokumentation](http://flask.pocoo.org/docs/0.10/deploying/fastcgi/)

## Lizenz

Lizensiert unter der MIT License - für mehr siehe [LICENSE](LICENSE).
