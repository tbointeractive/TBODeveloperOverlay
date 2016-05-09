//
//  TBOLoggerSetupHelper.h
//  TBOSetupHelper
//
//  Created by Cornelius Horstmann on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE GmbH & Co. KG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

// The DDLog macros create oclint warnings
// Define DISABLE_LOGGING in your build script
// before performing oclint checks to disable them
#if defined(DISABLE_LOGGING)
#undef DDLogError
#undef DDLogWarn
#undef DDLogInfo
#undef DDLogDebug
#undef DDLogVerbose
#define DDLogError(frmt, ...)
#define DDLogWarn(frmt, ...)
#define DDLogInfo(frmt, ...)
#define DDLogDebug(frmt, ...)
#define DDLogVerbose(frmt, ...)
#endif


#if defined(DEBUG)
static const DDLogLevel ddLogLevel = DDLogLevelVerbose; // everything
#elif defined(RELEASE)
static const DDLogLevel ddLogLevel = DDLogLevelInfo; // errors, warnings, infos
#else
static const DDLogLevel ddLogLevel = DDLogLevelInfo;
#endif


/**
 *  TBOLoggerSetupHelper is a class that helps coping with CocoaLumberjack.
 *  Just call the `+setup` Method in your AppDelegate and you are good to go.
 */
@interface TBOLoggerSetupHelper : NSObject

/**
 *  Performes setup tasks such as
 *  * setting the log formatter
 *  * creating a file logger
 */
+ (void)setup;

/**
 *  Searches for the latest logfile and returns its data
 *  You might want to use this method to attach the last logfile
 *    to an E-Mail or such
 *
 *  @return NSData of last log file if any, otherwise nil
 */
+ (NSData *_Nullable)lastLogFileData;

/**
 *  Returns the last X characters that were logged
 *  You might want to use this method to show it in a debug overlay or such
 *
 *  @param maxCharacters maximum number of characters returned
 *
 *  @return last `maxCharacters` logged or an empty string if nothig was logged before
 */
+ (NSString *_Nonnull)lastLogMessagesWithLimitedCharacters:(NSInteger)maxCharacters;

@end
