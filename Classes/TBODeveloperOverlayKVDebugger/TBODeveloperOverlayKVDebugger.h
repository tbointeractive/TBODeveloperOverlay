//
//  TBODeveloperOverlayKVDebugger.h
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBODeveloperOverlayKVDebuggerDatasourceProtocol.h"

/**
 * The KVDebugger can be used to inspect system variables and, for some cases, modify them.
 *
 * ## Usage
 * The TBODeveloperOverlayKVDebugger needs a datasource to access the data to display.
 * This datasource has to implement the TBODeveloperOverlayKVDebuggerDatasourceProtocol protocol. For further information please check the TBODeveloperOverlayKVDebuggerDatasourceProtocol.
 *
 * The `TBODeveloperOverlayNSUserDefaultsDatasource` is an already existing Datasource to inspect but not edit the `NSUserDefaults`.
 *
 *     TBODeveloperOverlayNSUserDefaultsDatasource *kvDatasource = [TBODeveloperOverlayNSUserDefaultsDatasource new];
 *     TBODeveloperOverlayKVDebugger *kvDebuggerViewController = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:kvDatasource];
 *
 * ## Editing
 * To enable editing values use the methods [TBODeveloperOverlayKVDebuggerDatasourceProtocol isEditableForIndexPath:] and [TBODeveloperOverlayKVDebuggerDatasourceProtocol didChangeValue:atIndexPath:].
 * The TBODeveloperOverlayKVDebugger currently supports editing of Bools, Numbers, and Strings.
 */
@interface TBODeveloperOverlayKVDebugger : UITableViewController

/**
 *  Creates a new KeyValue Debugger with a datasource
 *
 *  @param datasource A Datasource that implements the TBODeveloperOverlayKVDebuggerDatasourceProtocol
 *
 *  @return a TBODeveloperOverlayKVDebugger ViewController
 */
- (instancetype)initWithDatasource:(id<TBODeveloperOverlayKVDebuggerDatasourceProtocol>)datasource;

@end
