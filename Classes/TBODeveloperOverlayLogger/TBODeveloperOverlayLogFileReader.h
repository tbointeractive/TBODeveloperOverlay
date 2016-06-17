//
//  TBODeveloperOverlayLogFileReader.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 16.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DDFileLogger;

/**
 * The TBODeveloperOverlayLogFileReader is used by TBODeveloperOverlayLoggerCocoaLumberjackDatasource to retrieve the last log messages.
 */
@interface TBODeveloperOverlayLogFileReader : NSObject

/**
 *
 *  Returns the last log messages up to a given character count.
 *
 *  @param maxCharacterCount Maximum number of characters the returned string contains.
 *
 *  @return A NSString containing the last given number of characters from the DDFileLogger.
 */

+ (NSString *)lastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount inFilelogger:(DDFileLogger *)fileLogger;

@end
