#TBODeveloperOverlay
Das TBODeveloperOverlay ist ein Entwicklungs und Debugging Tool, dass verschiedene Plugins einbindet die bei der Entwicklung und der Fehlersuche helfen.

##Verwendung
Das Developer Overlay kann in der Development, Live und anderen Versionen einer App eingebunden werden.
Gerade in der Live Version soll der Zugriff auf das Overlay gut versteckt werden, z.B. sieben mal tappen einer View etc.

Das Developer Overlay wird innerhalb eines modalen `UINavigationController` angezeigt.

```
UINavigationController *developerOverlay = [TBODeveloperOverlayViewController navigationControllerWithDeveloperOverlay];
[self presentViewController:developerOverlay animated:YES completion:nil];
```


(Hier einen Block über die Einbindung der Plugins einfügen)