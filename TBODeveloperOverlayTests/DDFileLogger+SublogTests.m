//
//  DDFileLogger+SublogTests.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 14.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DDFileLogger+Sublog.h"

@interface DDFileLogger_SublogTests : XCTestCase

@property (strong, nonatomic, readwrite) DDFileLogger *fileLogger;

@end

@implementation DDFileLogger_SublogTests

- (void)setUp {
    [super setUp];
    for (id <DDLogger> logger in [DDLog allLoggers]) {
        if ([logger isKindOfClass:[DDFileLogger class]]) {
            self.fileLogger = logger;
        }
    }
    //    DDLogFileInfo *logInfo = [DDLogFileInfo alloc] ini
    //    [self.fileLogger reset];
    //    self.fileLogger = [[DDFileLogger alloc] init];
    //    DDLogInfo(@"TEST INFO");
    
}

- (void)testGettingLogString {
    
}

@end
