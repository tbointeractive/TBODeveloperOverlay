//
//  TBODeveloperOverlayFilterableLogFormatterProtocol.h
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 16.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#ifndef TBODeveloperOverlayFilterableLogFormatterProtocol_h
#define TBODeveloperOverlayFilterableLogFormatterProtocol_h

/**
 * The TBODeveloperOverlayFilterableLogFormatterProtocol should be implemented by custom log formatters to be used in TBODeveloperOverlayLogger.
 */
@protocol TBODeveloperOverlayFilterableLogFormatterProtocol <NSObject>

/**
 *
 *  Returns the log levels for custom LogFormatter
 *
 *  @return An array of log levels for the LogFormatter
 */

- (NSArray<NSString *> *_Nullable)logLevels;


/**
 *
 *  Returns a regular expression that can be used to filter a log for lines of a certain log level.
 *
 *  @param logLevel The log level for that a regular expression is requested.
 *
 *  @return A NSRegularExpression describing the given log level.
 */

- (NSRegularExpression *_Nullable)regularExpressionForLogLevel:(NSString *_Nonnull)logLevel;

@end

#endif /* TBODeveloperOverlayFilterableLogFormatterProtocol_h */
