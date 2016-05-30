#Logger
Das Logger Plugin dient zum anzeigen des App Logs.
###Verwendung
Beim Aufruf des Loggers werden die letzten 50000 verfügbaren chars des Logs angezeigt.
Die einzelnen Log Einträge sind chronlologisch aufsteigend, ähnlich wie in Xcode, geordnet.
Refreshed wird duch erneutes aufrufen des Loggers.

###Anmerkungen
Der Logger hat eine Dependency auf das [CocoaLumberjack Pod](https://cocoapods.org/pods/CocoaLumberjack)