//
//  TBODeveloperOverlayKVDebugger.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebugger.h"
#import "TBODeveloperOverlayKVDebuggerSimpleCell.h"

@interface TBODeveloperOverlayKVDebugger ()

@property (nonatomic, strong) id<TBODeveloperOverlayKVDebuggerDatasource> datasource;

@end

@implementation TBODeveloperOverlayKVDebugger

+ (void)load {
    // register at developer overlay if available
}

static Class datasourceClass = nil;

+ (void)registerDatasourceClass:(Class)class {
    datasourceClass = class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (datasourceClass) {
        self.datasource = [[datasourceClass alloc]init];
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"plainCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TBODeveloperOverlayKVDebuggerSimpleCell" bundle:nil ] forCellReuseIdentifier:@"simpleCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.datasource) {
        return [self.datasource numberOfSections];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.datasource) {
        return [self.datasource numberOfItemsInSection:section];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.datasource) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plainCell" forIndexPath:indexPath];
        cell.textLabel.text = @"no datasource provided";
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simpleCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.datasource keyForIndexPath:indexPath];
    id value = [self.datasource valueForIndexPath:indexPath];
    if ([value isKindOfClass:[NSString class]]) {
        cell.detailTextLabel.text = (NSString *)value;
    } else if ([NSStringFromClass([value class]) isEqualToString:@"__NSCFBoolean"]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", ((NSNumber *)value).boolValue ? @"YES" : @"NO"];
    } else if ([value isKindOfClass:[NSNumber class]]) {
        cell.detailTextLabel.text = ((NSNumber *)value).stringValue;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!self.datasource) {
        return nil;
    }
    return [self.datasource titleForSection:section];
}

@end
