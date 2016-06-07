#FileInspector
The `FileInspector` displays a folder structure to inspect files that are locally saved.

## Usage
The `FileInspector` has to be inititalized with one ore more base urls. If the `-initWithBaseUrl:` method is used, the first screen displays already the content of that folder. If the `-initWithBaseUrls:` method is used, the first screen lists those folders. Tapping on them makes it possible to drill down.

```
    TBODeveloperOverlayFileInspectorViewController *fileInspector = [[TBODeveloperOverlayFileInspectorViewController alloc] initWithBaseUrl:[[NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]] URLByDeletingLastPathComponent]];
    fileInspector.title = @"File Inspector";
```

Per default the title is the last path component of the one baseurl. To use another title you can override the `title`-property.