//
//  TBODeveloperOverlayKVDebuggerTests.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 09.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBODeveloperOverlayKVDebugger.h"
#import "TBODebugDatasource.h"
#import "TBODeveloperOverlayNSUserDefaultsDatasource.h"

@interface TBODeveloperOverlayKVDebugger ()

@property (nonatomic, strong) id<TBODeveloperOverlayKVDebuggerDatasource> datasource;

@end

@interface TBODeveloperOverlayKVDebuggerTests : XCTestCase

@end

@implementation TBODeveloperOverlayKVDebuggerTests


- (void)testInitWithNilDatasource {
    TBODeveloperOverlayKVDebugger *kvdebugger = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:nil];
    XCTAssert([kvdebugger numberOfSectionsInTableView:nil] == 1);
    XCTAssert([kvdebugger tableView:nil numberOfRowsInSection:0] == 1);
    XCTAssert([kvdebugger tableView:nil titleForHeaderInSection:0] == nil);
}

- (void)testInitWithDebugDatasource{
    TBODebugDatasource *kvDatasource = [TBODebugDatasource new];
    TBODeveloperOverlayKVDebugger *kvdebugger = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:kvDatasource];
    XCTAssert([kvdebugger numberOfSectionsInTableView:nil] == 3);
    XCTAssert([kvdebugger tableView:nil numberOfRowsInSection:2] == 3);
    XCTAssertEqualObjects([kvdebugger tableView:nil titleForHeaderInSection:1], @"Section: 1");
}

- (void)testUserDefaultsDatasource{
    NSDictionary *userdefaults = [NSUserDefaults standardUserDefaults].dictionaryRepresentation;
    TBODeveloperOverlayNSUserDefaultsDatasource *userDefaultsDatasource = [TBODeveloperOverlayNSUserDefaultsDatasource new];
    TBODeveloperOverlayKVDebugger *kvdebugger = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:userDefaultsDatasource];
    XCTAssert([kvdebugger numberOfSectionsInTableView:nil] == 1);
    XCTAssert([kvdebugger tableView:nil numberOfRowsInSection:0] == userdefaults.count);
    XCTAssertEqualObjects([kvdebugger tableView:nil titleForHeaderInSection:1], @"NSUserDefaults");
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0    inSection:0];
    id value = [kvdebugger.datasource valueForIndexPath:indexPath];
    NSString *key = [userdefaults.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)][0];
    XCTAssertEqualObjects(value, [userdefaults valueForKey:key]);
}

@end
