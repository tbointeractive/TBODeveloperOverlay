//
//  TBODeveloperOverlayKVDebugger.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebugger.h"
#import "TBODeveloperOverlayKVDebuggerReadOnlyKVCell.h"

@interface TBODeveloperOverlayKVDebugger ()

@property (nonatomic, strong) id<TBODeveloperOverlayKVDebuggerDatasource> datasource;

@end

@implementation TBODeveloperOverlayKVDebugger

static Class datasourceClass = nil;

+ (void)registerDatasourceClass:(Class<TBODeveloperOverlayKVDebuggerDatasource>)class {
    datasourceClass = class;
    if (NSClassFromString(@"TBODeveloperOverlayViewController")) {
        Class overlayClass = NSClassFromString(@"TBODeveloperOverlayViewController");
        SEL registerSelector = NSSelectorFromString(@"registerPluginClass:");
        if ([overlayClass respondsToSelector:registerSelector]) {
            [overlayClass performSelector:registerSelector withObject:self];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (datasourceClass) {
        self.datasource = [[datasourceClass alloc]init];
    }
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60.0;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SetupExplanationCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TBODeveloperOverlayKVDebuggerReadOnlyKVCell" bundle:[NSBundle bundleForClass:self.class]] forCellReuseIdentifier:@"TBODeveloperOverlayKVDebuggerReadOnlyKVCell"];
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetupExplanationCell" forIndexPath:indexPath];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = @"No Datasource provided. \n - Create a class that implements TBODeveloperOverlayKVDebuggerDatasource protocol \n - Register this class in ApplicationDidFinishLaunching unsing TBODeveloperOverlayKVDebugger+registerDatasourceClass:";
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TBODeveloperOverlayKVDebuggerReadOnlyKVCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.datasource keyForIndexPath:indexPath];
    id value = [self.datasource valueForIndexPath:indexPath];
    if ([value isKindOfClass:[NSString class]]) {
        cell.detailTextLabel.text = (NSString *)value;
    } else if (value == (void *)kCFBooleanFalse || value == (void *)kCFBooleanTrue) {
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

+ (NSString *)title {
    return @"Key-Value Inspector";
}

@end
