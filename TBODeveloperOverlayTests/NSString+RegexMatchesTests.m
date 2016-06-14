//
//  NSString+RegexMatchesTests.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 14.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSString+RegexMatches.h"

@interface NSString_RegexMatchesTests : XCTestCase

@end

@implementation NSString_RegexMatchesTests

NSString *testString = @"this is a string\nwhich includes a couple\nof newlines";

- (void)testMatchingSubstring {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"which includes" options:kNilOptions error:nil];
    NSString *subString = [testString substringThatMatchesRegex:regularExpression];
    XCTAssertEqualObjects(@"which includes a couple", subString);
}

- (void)testNotMatchingSubstring {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"not matching" options:kNilOptions error:nil];
    NSString *subString = [testString substringThatMatchesRegex:regularExpression];
    XCTAssertEqualObjects(@"", subString);
}

- (void)testNilRegex {
    NSString *subString = [testString substringThatMatchesRegex:nil];
    XCTAssertEqualObjects(@"this is a string\nwhich includes a couple\nof newlines", subString);
}

@end
