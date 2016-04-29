//
//  TBODeveloperOverlayKVDebugger.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebugger.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    
    return nil;
    
    
}

@end
