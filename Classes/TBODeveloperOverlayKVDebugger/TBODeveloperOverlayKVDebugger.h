//
//  TBODeveloperOverlayKVDebugger.h
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBODeveloperOverlayKVDebuggerDatasource.h"

@interface TBODeveloperOverlayKVDebugger : UITableViewController

/**
 *  Register the class of your datasource.
 *  The datasource has to implement the TBODeveloperOverlayKVDebuggerDatasource protocol.
 *
 *  @param class
 */
+ (void)registerDatasourceClass:(Class<TBODeveloperOverlayKVDebuggerDatasource>)class;
+ (NSString *)title;

@end
