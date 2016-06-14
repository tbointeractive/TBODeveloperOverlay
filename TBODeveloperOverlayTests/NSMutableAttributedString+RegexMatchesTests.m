//
//  NSMutableAttributedString+RegexMatchesTests.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 14.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSMutableAttributedString+RegexMatches.h"

@interface NSMutableAttributedString_RegexMatchesTests : XCTestCase

@property (strong, nonatomic, readwrite) NSMutableAttributedString *testString;
@property (strong, nonatomic, readwrite) NSDictionary *attributes;

@end

@implementation NSMutableAttributedString_RegexMatchesTests

- (void)setUp {
    [super setUp];
    self.testString = [[NSMutableAttributedString alloc] initWithString:@"this is an attributed string"];
    self.attributes = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
}

- (void)testMatchingRegex {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"attributed string" options:kNilOptions error:nil];
    [self.testString addAttributes:self.attributes toMatchesOfRegex:regularExpression];
    NSDictionary *retrievedAttributes = [self.testString attributesAtIndex:11 effectiveRange:nil];
    XCTAssertEqualObjects(self.attributes, retrievedAttributes);
}

- (void)testNotMatchingRegex {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"not matching" options:kNilOptions error:nil];
    [self.testString addAttributes:self.attributes toMatchesOfRegex:regularExpression];
    NSDictionary *retrievedAttributes = [self.testString attributesAtIndex:11 effectiveRange:nil];
    XCTAssertNotEqualObjects(self.attributes, retrievedAttributes);
    XCTAssertNotEqualObjects(self.attributes, retrievedAttributes);
}

- (void)testSetAttributesOnEmptyString {
    NSMutableAttributedString *emptyString = [NSMutableAttributedString new];
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"not matching" options:kNilOptions error:nil];
    [emptyString addAttributes:self.attributes toMatchesOfRegex:regularExpression];
    NSDictionary *retrievedAttributes = [self.testString attributesAtIndex:0 effectiveRange:nil];
    XCTAssertEqual(retrievedAttributes.allKeys.count, 0);
    XCTAssertEqual(retrievedAttributes.allValues.count, 0);
}

@end
