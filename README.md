## Description
The TBODeveloperTools is a toolset to integrate a suit of plugins to your application for debugging and development purposes. It can be integrated in any version of your app. Even in your live version. Just make sure that your users won't find it. (think tapping a view seven times to bring it up, etc.)

## Plugins
Plugins are what gives the TBODeveloperTools its functionality. With the overlay comes a range of plugins that can be individualy added and configured for your needs.
Some plugins require you to implement a datasource to adjust it to your application.
You can find more information on the plugins in their documentation in the respective folders.

Available Plugins are:

* TBODeveloperOverlayKVDebugger - inspect system variables and, for some cases, modify them
* TBODeveloperOverlayLogger - display in your logfiles
* TBODeveloperOverlayFileInspector - displays a folder structure to inspect files that are locally saved

## Installation
The installation via CocoaPods is recommended.
Add `git@git.tbointeractive.com:tbopodspecs/tbopodspecs.git` as additional source in your Podfile. 
Install TBODeveloperOverlay with all Plugins:

```
pod 'TBODeveloperOverlay'
```
For only selected Plugins install the Core pod and add the desired Plugins. For example:

```
pod 'TBODeveloperOverlay/Core'
pod 'TBODeveloperOverlay/KVDebugger'
```

## Usage
You can initialize a plugin and present it in a `TBOModalNavigationController` just like that:

```
TBODeveloperOverlayLogger *loggerPlugin = [TBODeveloperOverlayLogger new];
TBOModalNavigationController *developerOverlay = [[TBOModalNavigationController alloc] 
initWithRootViewController:loggerPlugin];
[self presentViewController:developerOverlay animated:YES completion:nil];
```

If you want to integrate more than one plugin you can initialize a `TBODeveloperOverlayPluginListViewController` with an array of plugins this way:

```
TBODeveloperOverlayLogger *loggerPlugin = [TBODeveloperOverlayLogger new];
TBODeveloperOverlayFileInspectorViewController *fileInspectorPlugin = [[TBODeveloperOverlayFileInspectorViewController alloc] initWithBaseUrl:nil];
NSArray *plugins = @[loggerPlugin, fileInspectorPlugin];
TBODeveloperOverlayPluginListViewController pluginListViewController = [[TBODeveloperOverlayPluginListViewController alloc] initWithPlugins:plugins];
TBOModalNavigationController *modalDeveloperOverlay = [[TBOModalNavigationController alloc] initWithRootViewController:containedViewController];
[self presentViewController:modalDeveloperOverlay animated:YES completion:nil];
```

