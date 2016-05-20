//
//  TBODebugDatasource.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODebugDatasource.h"


@interface TBODebugDatasource ()

@property (nonatomic, strong) NSArray <NSMutableArray *> *dataArray;

@end

@implementation TBODebugDatasource

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableArray *firstArray = [NSMutableArray arrayWithObjects:@"first String", nil];
        NSMutableArray *secondArray = [NSMutableArray arrayWithObjects:@"second String", @YES, nil];
        NSMutableArray *thirddArray = [NSMutableArray arrayWithObjects:@"third String", @YES, @42, nil];
        self.dataArray = @[firstArray, secondArray, thirddArray];
    }
    return self;
}

- (NSString *)titleForSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section: %ld", (long)section];
}

- (NSInteger)numberOfSections {
    return self.dataArray.count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return self.dataArray[section].count;
}

- (NSString *)keyForIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"Title %ld - %ld", (long)indexPath.section, (long)indexPath.row];
}

- (id)valueForIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray[indexPath.section][indexPath.row];
}

- (NSString *)descriptionForIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"Description for %@", indexPath ];
}

- (BOOL)isEditableForIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 2:
            return YES;
        default:
            return NO;
    }
}

- (void)didChangeValue:(id)value atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Did Change Value: %@ at %@", value, indexPath);
    self.dataArray[indexPath.section][indexPath.row] = value;
}

@end
