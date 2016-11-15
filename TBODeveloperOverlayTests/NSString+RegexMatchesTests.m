//
//  NSString+RegexMatchesTests.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 11.11.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+RegexMatches.h"

@interface NSString_RegexMatchesTests : XCTestCase

@end

@implementation NSString_RegexMatchesTests

NSString *testString = @"this is a string\nwhich includes a couple\nof newlines";

- (void)testMatchesRegex {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[\\sa-zA-Z]+" options:kNilOptions error:nil];
    XCTAssertTrue([@"This is a test string" matchesRegex:regularExpression]);
    XCTAssertTrue([@"923875928374928374 Test for substring matching" matchesRegex:regularExpression]);
    XCTAssertFalse([@"9879" matchesRegex:regularExpression]);
}

- (void)testMatchesEveryRegex {
    NSRegularExpression *firstRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"a.*" options:kNilOptions error:nil];
    NSRegularExpression *secondRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"b.*" options:kNilOptions error:nil];
    NSArray *expressions = @[firstRegularExpression, secondRegularExpression];
    XCTAssertTrue([@"abcde" matchesEveryRegex:expressions]);
    XCTAssertFalse([@"acde" matchesEveryRegex:expressions]);
}

@end
