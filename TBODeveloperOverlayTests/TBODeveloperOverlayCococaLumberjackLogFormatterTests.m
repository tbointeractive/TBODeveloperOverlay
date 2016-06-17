//
//  TBODeveloperOverlayCococaLumberjackLogFormatterTests.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 17.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBODeveloperOverlayCococaLumberjackLogFormatter.h"

@interface TBODeveloperOverlayCococaLumberjackLogFormatterTests : XCTestCase

@property (strong, nonatomic, readwrite) TBODeveloperOverlayCococaLumberjackLogFormatter *logFormatter;

@end

@implementation TBODeveloperOverlayCococaLumberjackLogFormatterTests

- (void)setUp {
    [super setUp];
    self.logFormatter = [TBODeveloperOverlayCococaLumberjackLogFormatter new];
}

- (void)testFormatLogString {
    NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:123456];
    DDLogMessage *logMessage = [[DDLogMessage alloc] initWithMessage:@"message to be logged" level:DDLogLevelError flag:DDLogFlagError context:0 file:@"FileName" function:nil line:42 tag:nil options:DDLogMessageCopyFile timestamp:timestamp];
    NSString *formattedLogMessage = [self.logFormatter formatLogMessage:logMessage];
    XCTAssertEqualObjects(@"1970-01-02 10:17:36 +0000 [E] FileName:42 message to be logged", formattedLogMessage);
}

- (void)testNilFormatLogString {
    NSString *formattedLogMessage = [self.logFormatter formatLogMessage:nil];
    XCTAssertNil(formattedLogMessage);
}

- (void)testLogMessages {
    NSOrderedSet *logLevels = [self.logFormatter logLevels];
    NSOrderedSet *expectedlogLevels = [NSOrderedSet orderedSetWithArray:@[@"Error", @"Warning", @"Info", @"Debug", @"Verbose"]];
    XCTAssertEqualObjects(expectedlogLevels, logLevels);
}

- (void)testRegexForLogLevel {
    NSRegularExpression *regex = [self.logFormatter regularExpressionForLogLevel:@"Warning"];
    NSRegularExpression *expectedRegex = [NSRegularExpression regularExpressionWithPattern:@".*\\[W\\].*" options:kNilOptions error:nil];
    XCTAssertEqualObjects(regex, expectedRegex);
}

- (void)testRegexForInvalidLogLevel {
    NSRegularExpression *regex = [self.logFormatter regularExpressionForLogLevel:@"invalid log level"];
    XCTAssertNil(regex);
}

- (void)testRegexForNilLogLevel {
    NSRegularExpression *regex = [self.logFormatter regularExpressionForLogLevel:nil];
    XCTAssertNil(regex);
}

@end
