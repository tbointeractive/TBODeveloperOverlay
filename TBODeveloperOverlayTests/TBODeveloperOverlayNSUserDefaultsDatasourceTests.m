//
//  TBODeveloperOverlayNSUserDefaultsDatasourceTests.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 13.06.16.
//  Copyright (c) 2016 TBO INTERACTIVE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBODeveloperOverlayKVDebugger.h"
#import "TBODeveloperOverlayNSUserDefaultsDatasource.h"

@interface TBODeveloperOverlayNSUserDefaultsDatasource ()

@property (nonatomic, strong) id <TBODeveloperOverlayKVDebuggerDatasourceProtocol> datasource;

@end

@interface TBODeveloperOverlayNSUserDefaultsDatasourceTests : XCTestCase

@end

@implementation TBODeveloperOverlayNSUserDefaultsDatasourceTests

- (void)testUserDefaultsDatasource {
    [[NSUserDefaults standardUserDefaults] setObject:@"some object" forKey:@"kvDebuggerTestSomeObject"]; // to make sure we have at minimum one item in user dafaults
    NSDictionary *userDefaults = [NSUserDefaults standardUserDefaults].dictionaryRepresentation;
    TBODeveloperOverlayNSUserDefaultsDatasource *userDefaultsDatasource = [TBODeveloperOverlayNSUserDefaultsDatasource new];
    XCTAssert([userDefaultsDatasource numberOfSections] == 1);
    XCTAssert([userDefaultsDatasource numberOfItemsInSection:0] == userDefaults.count);
    XCTAssertEqualObjects([userDefaultsDatasource titleForSection:0], @"NSUserDefaults");
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    id value = [userDefaultsDatasource valueForIndexPath:indexPath];
    NSString *key = [userDefaults.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)][0];
    XCTAssertEqualObjects(value, [userDefaults valueForKey:key]);
    NSIndexPath *indexPathTooLarge = [NSIndexPath indexPathForRow:42 inSection:1001];
    XCTAssertNil([userDefaultsDatasource valueForIndexPath:indexPathTooLarge]);
}

@end
