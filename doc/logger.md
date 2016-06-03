#Logger
The logger adds the possibility to display a log.

## Usage
The logger needs a datasource to access the data to display. The `TBODeveloperOverlayLogger` plugin offers an existing datasource for [CocoaLumberjack](https://github.com/CocoaLumberjack).

```
    // init logger
    TBODeveloperOverlayLoggerCocoaluberjackDatasource *loggerDatasource = [TBODeveloperOverlayLoggerCocoaluberjackDatasource new];
    TBODeveloperOverlayLogger *logger = [[TBODeveloperOverlayLogger alloc] initWithDatasource:loggerDatasource];
```

Per default only the last 50,000 characters are displayed in the log.

## Todos

* add the possibility to share the displayed log
* add a way to filter the log (either by matching substrings or by filtering the log level)