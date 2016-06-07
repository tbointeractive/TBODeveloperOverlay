# KVDebugger
The KVDebugger can be used to inspect system variables and, for some cases, modify them. 

## Usage
The `KVDebugger` needs a datasource to access the date to display. This datasource has to implement the `TBODeveloperOverlayKVDebuggerDatasourceProtocol` protocol. For further information please check the `TBODeveloperOverlayKVDebuggerDatasourceProtocol.h`. 

The `TBODeveloperOverlayNSUserDefaultsDatasource` is an already existing plugin to inspect but not edit the `NSUserDefaults`.

```
    TBODeveloperOverlayNSUserDefaultsDatasource *kvDatasource = [TBODeveloperOverlayNSUserDefaultsDatasource new];
    TBODeveloperOverlayKVDebugger *kvDebuggerViewController = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:kvDatasource];
```

### Editing
To enable editing values use the `-isEditableForIndexPath:` and `-didChangeValue:atIndexPath:` in the protocol. The `KVDebugger` currently supports editing of Bools, Numbers, and Strings.