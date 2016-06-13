//
//  TBODeveloperOverlayKVDebuggerTests.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 09.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBODeveloperOverlayKVDebugger.h"
#import "StubDatasource.h"

@interface TBODeveloperOverlayKVDebugger ()

@property (nonatomic, strong) UITableView *tableView;

@end

@interface TBODeveloperOverlayKVDebuggerTests : XCTestCase

@end

@implementation TBODeveloperOverlayKVDebuggerTests

- (void)testInitWithNilDatasource {
    TBODeveloperOverlayKVDebugger *kvDebugger = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:nil];
    XCTAssert([kvDebugger numberOfSectionsInTableView:nil] == 1);
    XCTAssert([kvDebugger tableView:nil numberOfRowsInSection:0] == 1);
    XCTAssert([kvDebugger tableView:nil titleForHeaderInSection:0] == nil);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *instructionCell = [kvDebugger tableView:kvDebugger.tableView cellForRowAtIndexPath:indexPath];
    XCTAssertEqualObjects(instructionCell.reuseIdentifier, @"SetupExplanationCell");
}

- (void)testInitWithDebugDatasource {
    StubDatasource *kvDatasource = [[StubDatasource alloc] initWithNumberOfSections:3 andItemsPerSection:5];
    TBODeveloperOverlayKVDebugger *kvDebugger = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:kvDatasource];
    UITableView *tableView = kvDebugger.tableView;
    XCTAssert(tableView.numberOfSections == 3);
    XCTAssert([tableView numberOfRowsInSection:2] == 5);
    XCTAssert([tableView numberOfRowsInSection:0] == 5);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *instructionCell = [kvDebugger tableView:kvDebugger.tableView cellForRowAtIndexPath:indexPath];
    XCTAssertEqualObjects(instructionCell.reuseIdentifier, @"TBODeveloperOverlayKVDebuggerReadOnlyKVCell");
}

@end
