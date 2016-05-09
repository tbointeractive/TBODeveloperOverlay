//
//  TBODeveloperOverlayLogger.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 09.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayLogger.h"
#import <CocoaLumberjack/CocoaLumberjack.h>


@interface TBODeveloperOverlayLogger ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end


@implementation TBODeveloperOverlayLogger

+ (void)load {
    if (NSClassFromString(@"TBODeveloperOverlayViewController")) {
        Class overlayClass = NSClassFromString(@"TBODeveloperOverlayViewController");
        SEL registerSelector = NSSelectorFromString(@"registerPluginClass:");
        if ([overlayClass respondsToSelector:registerSelector]) {
            [overlayClass performSelector:registerSelector withObject:self];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.textView.text = [self.class lastLogMessagesWithLimitedCharacters:500];
}

#pragma mark helper

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

+ (DDFileLogger *)fileLogger {
    for (id <DDLogger> logger in [DDLog allLoggers]) {
        if ([logger isKindOfClass:[DDFileLogger class]]) {
            return logger;
        }
    }
    return nil;
}

@end
