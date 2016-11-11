# Changelog

## not released

* **feature** Overriding `TBODeveloperOverlayNSUserDefaultsDatasource` and `isEditableForIndexPath:` enables editable NSUserDefaults
* **feature** added with TBODeveloperOverlayKeyValueItem and TBODeveloperOverlayKeyValueItem an easier way to configure a TBODeveloperOverlayKVDebugger

## 1.3.1 (28.06.2016)

* **bugfix**: loading the xibs embedded in the Pod now works properly: TBODeveloperOverlayLogger and KeyValueDebuggerDetailViewController did not load the xib
* **fix**: TBODeveloperOverlayKVDebuggerDatasourceProtocol -titleForSection: now really is optional