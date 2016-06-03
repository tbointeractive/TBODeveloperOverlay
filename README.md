# TBODeveloperOverlay
Das TBODeveloperOverlay ist ein Entwicklungs- und Debugging-Tool, das verschiedene Plugins einbindet, die bei der Entwicklung und der Fehlersuche helfen.

## Hinweise
Das DeveloperOverlay kann in der Development-, Live- und anderen Versionen einer App eingebunden werden.
Gerade in der Live-Version soll der Zugriff auf das Overlay gut versteckt werden, z.B. mehrmaliges Tappen einer View etc.

## Verwendung
Das DeveloperOverlay sollte innerhalb eines `UINavigationController` angezeigt werden. Dies ist sowohl für einige Plugins Voraussetzung als auch spätestens dann notwendig, wenn man mehr als ein Plugin einbinden möchte. 

```
UINavigationController *developerOverlay = [TBODeveloperOverlayViewController navigationControllerWithDeveloperOverlay];
[self presentViewController:developerOverlay animated:YES completion:nil];
```


(Hier einen Block über die Einbindung der Plugins einfügen)