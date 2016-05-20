//
//  TBODeveloperOverlayKVDebuggerDetailViewController.h
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 20.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBODeveloperOverlayKVDebuggerDatasource.h"

@interface TBODeveloperOverlayKVDebuggerDetailViewController : UIViewController

- (instancetype)initWithDatasource:(id<TBODeveloperOverlayKVDebuggerDatasource>)datasource andIndexPath:(NSIndexPath *)indexPath;

@end
