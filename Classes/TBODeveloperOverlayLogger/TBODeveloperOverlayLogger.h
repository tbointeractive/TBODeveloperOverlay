//
//  TBODeveloperOverlayLogger.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 09.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBODeveloperOverlayLoggerDatasourceProtocol.h"

/**
 *  The logger adds the possibility to display a log.
 *
 * ## Usage
 * The logger needs a datasource to access the data to display. The TBODeveloperOverlayLogger plugin offers an existing datasource for [CocoaLumberjack](https://github.com/CocoaLumberjack)
 *
 * ```
 * // init logger
 * TBODeveloperOverlayLoggerCocoaLumberjackDatasource *loggerDatasource = [TBODeveloperOverlayLoggerCocoaLumberjackDatasource new];
 * TBODeveloperOverlayLogger *logger = [[TBODeveloperOverlayLogger alloc] initWithDatasource:loggerDatasource];
 * ```
 *
 * ## TODOs
 *
 * * add the possibility to share the displayed log
 * * add a way to filter the log (either by matching substrings or by filtering the log level)
 */
@interface TBODeveloperOverlayLogger : UIViewController

/**
 *  Defines the maximum amount of displayed characters.
 *  The default is 50000 characters
 */
@property (nonatomic, readwrite) NSUInteger maxDisplayedCharacters;

/**
 * Initializes a TBODeveloperOverlayLogger with a given datasource.
 *
 * @param datasource A datasource that provides logging data. It must conform to TBODeveloperOverlayLoggerDatasourceProtocol.
 *
 * @return An instance of TBODeveloperOverlayLogger.
 */
- (instancetype _Nullable)initWithDatasource:(_Nullable id <TBODeveloperOverlayLoggerDatasourceProtocol>)datasource;

@end
