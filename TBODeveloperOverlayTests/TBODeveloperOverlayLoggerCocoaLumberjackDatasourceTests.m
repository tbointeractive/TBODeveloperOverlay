//
//  TBODeveloperOverlayLoggerCocoaLumberjackDatasourceTests.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 17.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBODeveloperOverlayLoggerCocoaLumberjackDatasource.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface TBODeveloperOverlayLoggerCocoaLumberjackDatasourceForTests : TBODeveloperOverlayLoggerCocoaLumberjackDatasource

@property (nonatomic) BOOL forceNilFileLogger;

@end

@implementation TBODeveloperOverlayLoggerCocoaLumberjackDatasourceForTests

- (DDFileLogger *)fileLogger {
    if (self.forceNilFileLogger) {
        return nil;
    }
    return [[DDFileLogger alloc] init];
}

@end

@interface TBODeveloperOverlayLoggerCocoaLumberjackDatasourceTests : XCTestCase

@end

@implementation TBODeveloperOverlayLoggerCocoaLumberjackDatasourceTests

- (void)testAttributedLastLogMessagesWithNoFileLogger {
    TBODeveloperOverlayLoggerCocoaLumberjackDatasourceForTests *loggerDatasource = [TBODeveloperOverlayLoggerCocoaLumberjackDatasourceForTests new];
    loggerDatasource.forceNilFileLogger = YES;
    XCTAssertNil([loggerDatasource attributedLastLogMessagesLimitedToCharacterCount:500]);
}

- (void)testLastLogMessagesWithNoFileLogger {
    TBODeveloperOverlayLoggerCocoaLumberjackDatasourceForTests *loggerDatasource = [TBODeveloperOverlayLoggerCocoaLumberjackDatasourceForTests new];
    loggerDatasource.forceNilFileLogger = YES;
    XCTAssertNil([loggerDatasource lastLogMessagesLimitedToCharacterCount:500]);
}

- (void)testLastLogMessagesLimitedRespectCharacterCount {
    TBODeveloperOverlayLoggerCocoaLumberjackDatasourceForTests *loggerDatasource = [TBODeveloperOverlayLoggerCocoaLumberjackDatasourceForTests new];
    XCTAssert([loggerDatasource lastLogMessagesLimitedToCharacterCount:500].length <= 500);
}

- (void)testAttributedLastLogMessagesLimitedRespectCharacterCount {
    TBODeveloperOverlayLoggerCocoaLumberjackDatasourceForTests *loggerDatasource = [TBODeveloperOverlayLoggerCocoaLumberjackDatasourceForTests new];
    XCTAssert([loggerDatasource attributedLastLogMessagesLimitedToCharacterCount:500].length <= 500);
}

@end
