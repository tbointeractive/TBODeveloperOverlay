//
//  TBODeveloperOverlayKVDebugger.h
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBODeveloperOverlayKVDebuggerDatasourceProtocol.h"

@interface TBODeveloperOverlayKVDebugger : UITableViewController

- (instancetype)initWithDatasource:(id<TBODeveloperOverlayKVDebuggerDatasourceProtocol>)datasource;


@end
