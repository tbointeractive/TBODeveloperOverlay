//
//  DDFileLogger+SublogTests.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 14.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DDFileLogger+Sublog.h"

@interface DDFileLogger (Sublog)

- (NSString *)lastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount fromFilePaths:(NSArray<NSString *> *)sortedLogFilePaths;

@end

@interface DDFileLogger_SublogTests : XCTestCase

@property (strong, nonatomic, readwrite) DDFileLogger *fileLogger;
@property (strong, nonatomic, readwrite) NSMutableArray<NSString *> *filePaths;

@end

@implementation DDFileLogger_SublogTests

- (void)setUp {
    [super setUp];
    self.fileLogger = [DDFileLogger new];
    self.filePaths = [NSMutableArray new];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray <NSData *> *testLogs = @[[@"first log content" dataUsingEncoding:NSUTF8StringEncoding],
                                     [@"second log content" dataUsingEncoding:NSUTF8StringEncoding],
                                     [@"third log content" dataUsingEncoding:NSUTF8StringEncoding]];
    [testLogs enumerateObjectsUsingBlock:^(NSData *_Nonnull logData, NSUInteger idx, BOOL *_Nonnull stop) {
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingString:@(idx).stringValue];
        [self.filePaths addObject:filePath];
        [fileManager createFileAtPath:filePath contents:logData attributes:nil];
    }];
}

- (void)testGettingLogString {
    NSString *retrievedLogs = [self.fileLogger lastLogMessagesLimitedToCharacterCount:5000 fromFilePaths:self.filePaths];
    
}

@end
