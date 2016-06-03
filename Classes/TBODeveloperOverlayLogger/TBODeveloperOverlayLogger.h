//
//  TBODeveloperOverlayLogger.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 09.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBODeveloperOverlayLoggerDatasourceProtocol.h"

@interface TBODeveloperOverlayLogger : UIViewController

/**
 *  Defines the maximum amount of displayed characters
 *  The default is 50000 characters
 */
@property (nonatomic, readwrite) NSUInteger maxDisplayedCharacters;

- (instancetype _Nullable)initWithDatasource:(_Nullable id <TBODeveloperOverlayLoggerDatasourceProtocol>)datasource;

@end
