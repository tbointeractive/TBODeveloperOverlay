//
//  TBODeveloperOverlayKeyValueItemTests.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 19.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBODeveloperOverlayKeyValueItem.h"

@interface TBODeveloperOverlayKeyValueItemTests : XCTestCase

@end

@implementation TBODeveloperOverlayKeyValueItemTests

- (void)testInitialization {
    XCTAssertNil([[TBODeveloperOverlayKeyValueItem alloc] initWithKey:nil value:nil description:nil andChangeBlock:nil]);
    XCTAssertNil([[TBODeveloperOverlayKeyValueItem alloc] initWithKey:@"key" value:nil description:nil andChangeBlock:nil]);
    XCTAssertNotNil([[TBODeveloperOverlayKeyValueItem alloc] initWithKey:@"key" value:@1 description:nil andChangeBlock:nil]);
    XCTAssertNil([[TBODeveloperOverlayKeyValueItem alloc] initWithKey:nil value:nil description:nil andChangeBlock:nil]);
}

- (void)testProperties {
    __block BOOL didPerformChangeBlock = NO;
    TBODeveloperOverlayKeyValueItem *item = [[TBODeveloperOverlayKeyValueItem alloc] initWithKey:@"a key" value:@12 description:@"a description" andChangeBlock:^(id _Nullable newValue) {
        didPerformChangeBlock = YES;
    }];
    XCTAssertEqualObjects(item.key, @"a key");
    XCTAssertEqualObjects(item.value, @12);
    XCTAssertEqualObjects(item.itemDescription, @"a description");
    XCTAssertTrue(item.isEditable);
    XCTAssertFalse(didPerformChangeBlock);
    item.changeBlock(@13);
    XCTAssertTrue(didPerformChangeBlock);
}

@end
