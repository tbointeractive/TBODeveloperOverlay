# TBODeveloperOverlay
Das TBODeveloperOverlay ist ein Entwicklungs- und Debugging-Tool, das verschiedene Plugins einbindet, die bei der Entwicklung und der Fehlersuche helfen.

## Hinweise
Das DeveloperOverlay kann in der Development-, Live- und anderen Versionen einer App eingebunden werden.
Gerade in der Live-Version soll der Zugriff auf das Overlay gut versteckt werden, z.B. mehrmaliges Tappen einer View etc.

## Verwendung
Das DeveloperOverlay sollte innerhalb eines `UINavigationController` angezeigt werden. Dies ist sowohl für einige Plugins Voraussetzung als auch spätestens dann notwendig, wenn man mehr als ein Plugin einbinden möchte. 
Ein `TBOModalNavigationController` liegt dem DeveloperOverlay bei. Dieser ist dafür gedacht, wenn das DeveloperOverlay modal angezeigt werden soll. Dann gibt es oben rechts immer einen Done-Button, der das Overlay wieder schließt. Der Buttons kann natürlich von einzelnen Plugins auch überschrieben werden, bspw. zum Speichern einer Änderung.

```
NSArray *plugins = @[kvDebuggerViewController, userDefaultsInspector, logger, fileInspector];
TBODeveloperOverlayPluginListViewController *listViewController = [[TBODeveloperOverlayPluginListViewController alloc] initWithPlugins:plugins];
    
TBOModalNavigationController *developerOverlay = [[TBOModalNavigationController alloc] initWithRootViewController:listViewController];
[self presentViewController:developerOverlay animated:YES completion:nil];
```


(Hier einen Block über die Einbindung der Plugins einfügen)