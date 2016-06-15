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

- (void)testRegexMatchingSubstring {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"which includes" options:kNilOptions error:nil];
    NSString *subString = [testString substringThatMatchesRegex:regularExpression];
    XCTAssertEqualObjects(@"which includes a couple", subString);
}

- (void)testRegexNotMatchingSubstring {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"not matching" options:kNilOptions error:nil];
    NSString *subString = [testString substringThatMatchesRegex:regularExpression];
    XCTAssertEqualObjects(@"", subString);
}

- (void)testAnyRegexMatchingSubstring {
    NSRegularExpression *regularExpression1 = [NSRegularExpression regularExpressionWithPattern:@"this is" options:kNilOptions error:nil];
    NSRegularExpression *regularExpression2 = [NSRegularExpression regularExpressionWithPattern:@"which includes" options:kNilOptions error:nil];
    NSString *subString = [testString substringThatMatchesAnyRegex:@[regularExpression1, regularExpression2]];
    XCTAssertEqualObjects(@"this is a string\nwhich includes a couple", subString);
}

- (void)testNotAnyRegexMatchingSubstring {
    NSRegularExpression *regularExpression1 = [NSRegularExpression regularExpressionWithPattern:@"not matching" options:kNilOptions error:nil];
    NSRegularExpression *regularExpression2 = [NSRegularExpression regularExpressionWithPattern:@"not matching as well" options:kNilOptions error:nil];
    NSString *subString = [testString substringThatMatchesAnyRegex:@[regularExpression1, regularExpression2]];
    XCTAssertEqualObjects(@"", subString);
}

- (void)testAnyRegexMatchingWithFalseTypes {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"which includes" options:kNilOptions error:nil];
    NSString *subString = [testString substringThatMatchesAnyRegex:@[regularExpression, @1]];
    XCTAssertEqualObjects(@"which includes a couple", subString);
}

- (void)testRegexWithNewline {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"string\nwhich" options:kNilOptions error:nil];
    NSString *subString = [testString substringThatMatchesRegex:regularExpression];
    XCTAssertEqualObjects(@"", subString);
}

- (void)testLongRegexDescribingTargetStringTwice {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"this is a string\nwhich includes a couple\nof newlinesthis is a string\nwhich includes a couple\nof newlines" options:kNilOptions error:nil];
    NSString *subString = [testString substringThatMatchesRegex:regularExpression];
    XCTAssertEqualObjects(@"", subString);
}

- (void)testNilRegex {
    NSString *subString = [testString substringThatMatchesRegex:nil];
    XCTAssertEqualObjects(@"this is a string\nwhich includes a couple\nof newlines", subString);
}

@end
