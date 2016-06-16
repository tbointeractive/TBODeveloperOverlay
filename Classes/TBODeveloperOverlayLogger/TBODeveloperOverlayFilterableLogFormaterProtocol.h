//
//  TBODeveloperOverlayFilterableLogFormaterProtocol.h
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 16.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#ifndef TBODeveloperOverlayFilterableLogFormaterProtocol_h
#define TBODeveloperOverlayFilterableLogFormaterProtocol_h

@protocol TBODeveloperOverlayFilterableLogFormaterProtocol <NSObject>

/**
 *
 *  Returns the log levels for the FilterableLogFormatter
 *
 *  @return logLevels for the FilterableLogFormatter
 */

- (NSArray *_Nonnull)logLevels;


/**
 *
 *  Returns a regular expression that can be used to filter a log for lines of a certain log level.
 *
 *  @param logLevel The log level for that a regular expression is requested.
 *
 *  @return logLevels A regular expression describing a line of the given log level.
 */

- (NSRegularExpression *_Nonnull)regularExpressionForLogLevel:(NSString *_Nonnull)logLevel;

@end

#endif /* TBODeveloperOverlayFilterableLogFormaterProtocol_h */
