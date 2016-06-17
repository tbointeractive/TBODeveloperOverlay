//
//  DDFileLogger+SublogTests.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 14.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBODeveloperOverlayLogFileReader.h"

@interface TBODeveloperOverlayLogFileReader ()

+ (NSString *)lastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount fromFilePaths:(NSArray<NSString *> *)sortedLogFilePaths;

@end

@interface TBODeveloperOverlayLogFileReaderTests : XCTestCase

@property (strong, nonatomic, readwrite) NSMutableArray<NSString *> *filePaths;

@end

@implementation TBODeveloperOverlayLogFileReaderTests

- (void)setUp {
    [super setUp];
    self.filePaths = [NSMutableArray new];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray <NSData *> *testLogs = @[[@"third log content end" dataUsingEncoding:NSUTF8StringEncoding],
                                     [@"second log content" dataUsingEncoding:NSUTF8StringEncoding],
                                     [@"start first log content" dataUsingEncoding:NSUTF8StringEncoding]];
    [testLogs enumerateObjectsUsingBlock:^(NSData *_Nonnull logData, NSUInteger idx, BOOL *_Nonnull stop) {
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingString:@(idx).stringValue];
        [self.filePaths addObject:filePath];
        [fileManager createFileAtPath:filePath contents:logData attributes:nil];
    }];
}

- (void)testGettingCompleteLogString {
    NSString *retrievedLogs = [TBODeveloperOverlayLogFileReader lastLogMessagesLimitedToCharacterCount:5000 fromFilePaths:self.filePaths];
    XCTAssertEqualObjects(@"start first log contentsecond log contentthird log content end", retrievedLogs);
}

- (void)testGettinglLast10Chars {
    NSString *retrievedLogs = [TBODeveloperOverlayLogFileReader lastLogMessagesLimitedToCharacterCount:10 fromFilePaths:self.filePaths];
    XCTAssertEqualObjects(@"ontent end", retrievedLogs);
}

- (void)testGettinglLast0Chars {
    NSString *retrievedLogs = [TBODeveloperOverlayLogFileReader lastLogMessagesLimitedToCharacterCount:0 fromFilePaths:self.filePaths];
    XCTAssertEqualObjects(@"", retrievedLogs);
}

@end
