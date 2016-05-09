//
//  TBOLoggerSetupHelper.m
//  TBOSetupHelper
//
//  Created by Cornelius Horstmann on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE GmbH & Co. KG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBOLoggerSetupHelper.h"
#import "TBOLogFormatter.h"

@implementation TBOLoggerSetupHelper

+ (void)setup {
    [DDLog removeAllLoggers];
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    DDFileLogger *fileLogger = [self newFileLogger];
    [DDLog addLogger:fileLogger];
    
    TBOLogFormatter *logFormatter = [TBOLogFormatter new];
    [DDTTYLogger sharedInstance].logFormatter = logFormatter;
    [DDASLLogger sharedInstance].logFormatter = logFormatter;
    fileLogger.logFormatter = logFormatter;
}

#pragma mark public methods

+ (NSData *_Nullable)lastLogFileData {
    NSString *lastLogFilePath = [[self.fileLogger logFileManager] sortedLogFilePaths].firstObject;
    if (!lastLogFilePath) {
        return nil;
    }
    NSFileManager *fileManager = [NSFileManager new];
    return [fileManager contentsAtPath:lastLogFilePath];
}

+ (NSString *)lastLogMessagesWithLimitedCharacters:(NSInteger)maxSize {
    NSMutableString *logMessages = [NSMutableString string];
    NSFileManager *fileManager = [NSFileManager new];
    
    NSArray<NSString *> *sortedLogFilePaths = [[self.fileLogger logFileManager] sortedLogFilePaths];
    for (NSString *logFilePath in [sortedLogFilePaths reverseObjectEnumerator]) {
        NSData *logData = [fileManager contentsAtPath:logFilePath];
        if (logData.length > 0) {
            NSString *logString = [[NSString alloc] initWithBytes:logData.bytes length:logData.length encoding:NSUTF8StringEncoding];
            [logMessages insertString:logString atIndex:0];
        }
        if (logMessages.length >= maxSize) {
            break;
        }
    }
    
    if ([logMessages length] > maxSize) {
        logMessages = (NSMutableString *)[logMessages substringWithRange:NSMakeRange([logMessages length]-maxSize-1, maxSize)];
    }
    return logMessages;
}

#pragma mark helper

+ (DDFileLogger *)fileLogger {
    for (id <DDLogger> logger in [DDLog allLoggers]) {
        if ([logger isKindOfClass:[DDFileLogger class]]) {
            return logger;
        }
    }
    return nil;
}

+ (DDFileLogger *)newFileLogger {
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;     // 24 hours
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    fileLogger.maximumFileSize = 1024 * 1024 * 2;     // 2MB
    [fileLogger rollLogFileWithCompletionBlock:nil];     // so we get a clean logfile every start
    return fileLogger;
}

@end
