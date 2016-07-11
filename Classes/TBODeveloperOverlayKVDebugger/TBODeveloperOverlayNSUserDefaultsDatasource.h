//
//  NSUserDefaultsOverlayDatasource.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 06.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBODeveloperOverlayKVDebugger.h"
/**
 * The TBODeveloperOverlayNSUserDefaultsDatasource is a preconfigured datasource to use with TBODeveloperOverlayKVDebugger. It displays the contents of NSUserDefaults.
 *
 * ## Note
 * This datasource does not allow for editing the values in NSUserDefaults. In cases this is intended, you can sublass this datasource and override `isEditableForIndexPath:` from TBODeveloperOverlayKVDebuggerDatasourceProtocol. The saving action is already implemented in this datasource.
 */

@interface TBODeveloperOverlayNSUserDefaultsDatasource : NSObject <TBODeveloperOverlayKVDebuggerDatasourceProtocol>

@end
