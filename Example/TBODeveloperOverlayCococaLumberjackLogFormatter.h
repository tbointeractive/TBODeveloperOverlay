//
//  TBODeveloperOverlayCococaLumberjackLogFormatter.h
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 16.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBODeveloperOverlayFilterableLogFormatterProtocol.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
/**
 * TBODeveloperOverlayCococaLumberjackLogFormatter is a predefined LogFormatter for CocoaLumberjack to conform to TBODeveloperOverlayFilterableLogFormatterProtocol.
 *
 * ## Usage
 *
 * ```
 * TBODeveloperOverlayCococaLumberjackLogFormatter *logFormatter = [TBODeveloperOverlayCococaLumberjackLogFormatter new];
 * aFileLogger.logFormatter = logFormatter;
 * ```
 */

@interface TBODeveloperOverlayCococaLumberjackLogFormatter : NSObject <TBODeveloperOverlayFilterableLogFormatterProtocol, DDLogFormatter>

@end
