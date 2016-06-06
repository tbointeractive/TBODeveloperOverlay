//
//  TBODeveloperOverlayLoggerCocoalumberjackDatasource.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 03.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBODeveloperOverlayLoggerDatasourceProtocol.h"

@class DDFileLogger;

@interface TBODeveloperOverlayLoggerCocoalumberjackDatasource : NSObject<TBODeveloperOverlayLoggerDatasourceProtocol>

/**
 *  If no file logger is given, the first DDFileLogger in
 *  [DDLog allLoggers] is used
 */
@property (weak, nonatomic, readwrite) DDFileLogger *_Nullable fileLogger;

@end
