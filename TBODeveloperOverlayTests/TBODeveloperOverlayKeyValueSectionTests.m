//
//  TBODeveloperOverlayKeyValueSectionTests.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 19.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBODeveloperOverlayKeyValueSection.h"
#import "TBODeveloperOverlayKeyValueItem.h"

@interface TBODeveloperOverlayKeyValueSectionTests : XCTestCase

@end

@implementation TBODeveloperOverlayKeyValueSectionTests

- (void)testInitialization {
    XCTAssertNotNil([[TBODeveloperOverlayKeyValueSection alloc] initWithTitle:nil andItems:@[]]);
    XCTAssertNotNil([[TBODeveloperOverlayKeyValueSection alloc] initWithTitle:@"title" andItems:@[]]);
    XCTAssertNotNil([[TBODeveloperOverlayKeyValueSection alloc] initWithTitle:@"title" andItems:@[[[TBODeveloperOverlayKeyValueItem alloc] initWithKey:@"key" value:@"value" description:nil andChangeBlock:nil]]]);
}

- (void)testProperties {
    TBODeveloperOverlayKeyValueItem *item1 = [[TBODeveloperOverlayKeyValueItem alloc] initWithKey:@"a key" value:@12 description:@"a description" andChangeBlock:^(id _Nullable newValue) {}];
    TBODeveloperOverlayKeyValueItem *item2 = [[TBODeveloperOverlayKeyValueItem alloc] initWithKey:@"a key" value:@12 description:@"a description" andChangeBlock:^(id _Nullable newValue) {}];
    TBODeveloperOverlayKeyValueSection *section = [[TBODeveloperOverlayKeyValueSection alloc] initWithTitle:@"title" andItems:@[item1, item2]];
    XCTAssertEqualObjects(section.title, @"title");
    XCTAssertEqual(section.itemCount, 2);
    XCTAssertEqual([section itemAtIndex:0], item1);
    XCTAssertEqual([section itemAtIndex:1], item2);
    XCTAssertNil([section itemAtIndex:2]);
}

@end
