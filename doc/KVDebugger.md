# KVDebugger
Das KVDebugger-Plugin ist Teil des TBODeveloperOverlay und dient zur Beobachtung und Manipulation von ausgewählten Werten in der App.
Diese Werte werden durch eine Datasource definiert.

## Installation (Cocoapods)
KVDebugger kann einzeln oder in Kombination mit dem TBODeveloperOverlay verwendet werden.
```ruby
pod 'TBODeveloperOverlay/Core' # optional für TBODeveloperOverlay
pod 'TBODeveloperOverlay/KVDebugger'
```

## Verwendung
Um KVDebugger verwenden zu können muss zunächst eine Datasource implementiert werden. Diese muss das `TBODeveloperOverlayKVDebuggerDatasource`Protokoll implementieren. 

```objc
// init Key-Value Debugger
    TBODebugDatasource *myKVDatasource = [TBODebugDatasource new];
    TBODeveloperOverlayKVDebugger *kvDebuggerViewController = [[TBODeveloperOverlayKVDebugger alloc] myKVDatasource];
    
    // init and present developer overlay
    TBODeveloperOverlayViewController *developerOverlay = [[TBODeveloperOverlayViewController alloc] initWithPlugins:@[kvDebuggerViewController]];
    [self presentViewController:developerOverlay animated:YES completion:nil];
```

## TBODeveloperOverlayKVDebuggerDatasource
Das Protokoll ist folgendermaßen definiert:
```objc
@protocol TBODeveloperOverlayKVDebuggerDatasource <NSObject>

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

- (NSString *)titleForSection:(NSInteger)section;

- (NSString *)keyForIndexPath:(NSIndexPath *)indexPath;
- (id)valueForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)descriptionForIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isEditableForIndexPath:(NSIndexPath *)indexPath;

- (void)didChangeValue:(id)value atIndexPath:(NSIndexPath *)indexPath;

@end
```	