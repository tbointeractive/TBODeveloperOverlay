# KVDebugger
Das KVDebugger-Plugin ist Teil des TBODeveloperOverlay und dient zur Beobachtung und Manipulation von ausgewählten Werten in der App. 
Diese Werte werden durch eine Datasource definiert. Diese Datasource muss dem `TBODeveloperOverlayKVDebuggerDatasource`-Protokoll entsprechen. Für jeden anzuzeigenden Wert kann dort definiert werden ob dieser Wert readwrite oder readonly ist. Per Default sind alle Werte readonly.
Zusätzlich kann man für jeden Wert noch eine Beschreibung hinzufügen, die dann in der Detailansicht angezeigt wird.

## Verwendung
Um KVDebugger verwenden zu können muss zunächst eine Datasource implementiert werden. Diese muss das `TBODeveloperOverlayKVDebuggerDatasource`Protokoll implementieren. 

```objc
// init Key-Value Debugger
MyKVDebugDatasource *myKVDatasource = [MyKVDebugDatasource new]; // conforms to TBODeveloperOverlayKVDebuggerDatasource protocol
TBODeveloperOverlayKVDebugger *kvDebuggerViewController = [[TBODeveloperOverlayKVDebugger alloc] myKVDatasource];

// init and present developer overlay
TBODeveloperOverlayPluginListViewController *listViewController = [[TBODeveloperOverlayPluginListViewController alloc] initWithPlugins:@[kvDebuggerViewController]];
TBOModalNavigationController *developerOverlay = [[TBOModalNavigationController alloc] initWithRootViewController:listViewController];
[self presentViewController:developerOverlay animated:YES completion:nil];
```

