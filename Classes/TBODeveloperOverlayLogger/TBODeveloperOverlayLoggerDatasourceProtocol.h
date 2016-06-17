//
//  TBODeveloperOverlayLoggerDatasourceProtocol.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 03.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#ifndef TBODeveloperOverlayLoggerDatasourceProtocol_h
#define TBODeveloperOverlayLoggerDatasourceProtocol_h

@protocol TBODeveloperOverlayLoggerDatasourceProtocol <NSObject>

- (NSString *_Nullable)lastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount;

@optional

/**
 * This method can be implemented to show certain search results and such or
 *    to display some lines of text in a certain way (errors red, ...)
 *
 *  @property maxCharacterCount
 *
 *  @return Returns a non-null String if any log messages are found; Returns a nil string if there is something wrong with the configuration of the datasource
 */
- (NSAttributedString *_Nullable)attributedLastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount;


/**
 * Log Filters
 */

/**
 * If this method is implemented the logger-overlay will display a button for each log level
 *  so the user can enable or disable certain log levels
 *
 * Per default all log levels are enabled
 *
 *  @return The existing log levels to be displayed
 */
- (NSOrderedSet <NSString *> *_Nullable)existingLogLevels;

/**
 * The Logger Overlay will call this method to enable or disable displaying certain log levels
 *  after enabling or disabling the overlay will call -lastLogMessagesLimitedToCharacterCount: to
 *  refresh the interface
 *
 *  @param logLevel The log level to be set
 *
 *  @param on Bool to activate / decctivate the given log level.
 */
- (void)setLogLevel:(NSString *_Nonnull)logLevel toOn:(BOOL)on;

/**
 * If implemented, the overlay will display a search field for the user to filter the log
 *  the filter should be applied after the log is filtered by logLevels
 *
 * After calling this method, the overlay will call the -lastLogMessagesLimitedToCharacterCount: method
 *  to refresh the content being displayed
 *
 *  @param searchString The search string to filter the log.
 */
- (void)setSearchString:(NSString *_Nullable)searchString;

@end

#endif /* TBODeveloperOverlayLoggerDatasourceProtocol_h */
