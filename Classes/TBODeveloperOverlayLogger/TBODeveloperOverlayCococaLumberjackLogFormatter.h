//
//  TBODeveloperOverlayCococaLumberjackLogFormatter.h
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 16.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBODeveloperOverlayFilterableLogFormaterProtocol.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface TBODeveloperOverlayCococaLumberjackLogFormatter : NSObject <TBODeveloperOverlayFilterableLogFormaterProtocol, DDLogFormatter>

@end
