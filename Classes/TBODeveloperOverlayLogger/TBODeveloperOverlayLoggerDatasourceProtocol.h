//
//  TBODeveloperOverlayLoggerDatasourceProtocol.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 03.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#ifndef TBODeveloperOverlayLoggerDatasourceProtocol_h
#define TBODeveloperOverlayLoggerDatasourceProtocol_h
/**
 * TBODeveloperOverlayLoggerDatasourceProtocol has to be implemented by every custom datasource to use with TBODeveloperOverlayLogger.
 */
@protocol TBODeveloperOverlayLoggerDatasourceProtocol <NSObject>

/**
 * This method has to be implemented to get the last log messages of a FileLogger.
 *
 *  @property maxCharacterCount The maximum number of last characters of the log messages.
 *
 *  @return Returns a NSString if any log messages are found; Returns nil if there is something wrong with the configuration of the datasource.
 */
- (NSString *_Nullable)lastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount;

@optional

/**
 * This method can be implemented to get the last log messages of a FileLogger.
 *
 *  @property maxCharacterCount The maximum number of last characters of the log messages.
 *
 *  @return Returns a NSAttributedString if any log messages are found; Returns nil if there is something wrong with the configuration of the datasource.
 */
- (NSAttributedString *_Nullable)attributedLastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount;


/**
 * Log Filters
 */

/**
 * If this method is implemented the logger-overlay will display a button for each log level
 *  so the user can enable or disable certain log levels.
 *
 * Per default all log levels are enabled.
 *
 *  @return The existing log levels to be displayed.
 */
- (NSOrderedSet <NSString *> *_Nullable)existingLogLevels;

/**
 * The Logger Overlay will call this method to enable or disable displaying certain log levels
 *  after enabling or disabling the overlay will call -lastLogMessagesLimitedToCharacterCount: to
 *  refresh the interface.
 *
 *  @param logLevel The log level to be set.
 *
 *  @param on A BOOL to activate (YES) / deactivate (NO) the given log level.
 */
- (void)setLogLevel:(NSString *_Nonnull)logLevel toOn:(BOOL)on;

/**
 * If implemented, the overlay will display a search field for the user to filter the log
 *  the filter should be applied after the log is filtered by log levels.
 *
 * After calling this method, the overlay will call the -lastLogMessagesLimitedToCharacterCount: method
 *  to refresh the content being displayed.
 *
 *  @param searchString The search string to filter the log.
 */
- (void)setSearchString:(NSString *_Nullable)searchString;

@end

#endif /* TBODeveloperOverlayLoggerDatasourceProtocol_h */
