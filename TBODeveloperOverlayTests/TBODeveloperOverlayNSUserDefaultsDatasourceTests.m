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

@property (nonatomic, strong) TBODeveloperOverlayNSUserDefaultsDatasource *userDefaultsDatasource;

@end

@implementation TBODeveloperOverlayNSUserDefaultsDatasourceTests

- (void)setUp {
    [super setUp];
    [[NSUserDefaults standardUserDefaults] setObject:@"some object" forKey:@"kvDebuggerTestSomeObject"];
    self.userDefaultsDatasource = [TBODeveloperOverlayNSUserDefaultsDatasource new];
}

- (void)testValidBehavior {
    NSDictionary *userDefaults = [NSUserDefaults standardUserDefaults].dictionaryRepresentation;
    XCTAssert([self.userDefaultsDatasource numberOfSections] == 1);
    XCTAssert([self.userDefaultsDatasource numberOfItemsInSection:0] == userDefaults.count);
    XCTAssertEqualObjects([self.userDefaultsDatasource titleForSection:0], @"NSUserDefaults");
    XCTAssertEqual([self.userDefaultsDatasource isEditableForIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]], NO);
}

- (void)testValueForInvalidIndexPath {
    NSIndexPath *indexPathTooLarge = [NSIndexPath indexPathForRow:42 inSection:1001];
    XCTAssertNil([self.userDefaultsDatasource valueForIndexPath:indexPathTooLarge]);
}

- (void)testValueForValidKeyPath {
    NSDictionary *userDefaults = [NSUserDefaults standardUserDefaults].dictionaryRepresentation;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    id value = [self.userDefaultsDatasource valueForIndexPath:indexPath];
    NSString *key = [userDefaults.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)][0];
    XCTAssertEqualObjects(value, [userDefaults valueForKey:key]);
}


@end
