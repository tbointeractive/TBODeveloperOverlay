//
//  DDFileLogger+Sublog.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 13.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "DDFileLogger+Sublog.h"

@implementation DDFileLogger (Sublog)

- (NSString *)lastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount {
    NSMutableString *logMessages = [NSMutableString string];
    NSFileManager *fileManager = [NSFileManager new];
    NSArray<NSString *> *sortedLogFilePaths = [[self logFileManager] sortedLogFilePaths];
    for (NSString *logFilePath in [sortedLogFilePaths reverseObjectEnumerator]) {
        NSData *logData = [fileManager contentsAtPath:logFilePath];
        if (logData.length > 0) {
            NSString *logString = [[NSString alloc] initWithBytes:logData.bytes length:logData.length encoding:NSUTF8StringEncoding];
            [logMessages insertString:logString atIndex:0];
        }
        if (logMessages.length >= maxCharacterCount) {
            break;
        }
    }
    if ([logMessages length] > maxCharacterCount) {
        logMessages = (NSMutableString *)[logMessages substringWithRange:NSMakeRange([logMessages length]-maxCharacterCount-1, maxCharacterCount)];
    }
    return logMessages;
}

@end
