//
//  TBODeveloperOverlayKVDebuggerDetailViewController.h
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 20.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBODeveloperOverlayKVDebuggerDatasourceProtocol.h"
/**
 * The TBODeveloperOverlayKVDebuggerDetailViewController is used by the TBODeveloperOverlayKVDebugger to display the value data of one key-value pair in full length.
 *
 * ## Editing Values
 * If configured in the corresponding datasource this DetailViewController allows editing the displayed value. Currently the following data types are supported:
 *
 * * BOOL
 * * NSNumber
 * * NSString
 *
 * ## Usage
 * The TBODeveloperOverlayKVDebuggerDetailViewController has to be initalized with a datasource conforming to TBODeveloperOverlayKVDebuggerDatasourceProtocol. By default this is done by TBODeveloperOverlayKVDebugger autmaotically.
 */

@interface TBODeveloperOverlayKVDebuggerDetailViewController : UIViewController

/**
 * Initilaizes the DetailViewController with an appropriate datasource.
 * @param datasource A datasource containing the data that should be displayed.
 * @param indexPath The IndexPath of the key-value pair to be displayed.
 * @return an instance of TBODeveloperOverlayKVDebuggerDetailViewController
 */
- (instancetype)initWithDatasource:(id<TBODeveloperOverlayKVDebuggerDatasourceProtocol>)datasource andIndexPath:(NSIndexPath *)indexPath;

@end
