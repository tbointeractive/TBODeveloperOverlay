//
//  TBODeveloperOverlayKVDebugger.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebugger.h"
#import "TBODeveloperOverlayKVDebuggerReadOnlyKVCell.h"
#import "TBODeveloperOverlayKVDebuggerBaseDetailViewController.h"

#import "TBODeveloperOverlayKVDebuggerNSStringDetailViewController.h"
#import "TBODeveloperOverlayKVDebuggerBoolDetailViewController.h"
#import "TBODeveloperOverlayKVDebuggerNSNumberDetailViewController.h"

@interface TBODeveloperOverlayKVDebugger ()

@property (nonatomic, strong) id<TBODeveloperOverlayKVDebuggerDatasourceProtocol> datasource;
@property (strong, nonatomic, readwrite) NSMutableArray <Class <TBODeveloperOverlayKVDebuggerDetailViewController> > *detailViewControllerClasses;

@end

@implementation TBODeveloperOverlayKVDebugger

static Class datasourceClass = nil;

- (instancetype)initWithDatasource:(id<TBODeveloperOverlayKVDebuggerDatasourceProtocol>)datasource {
    self = [self init];
    if (self) {
        self.datasource = datasource;
        self.title = @"Key-Value Inspector";
    }
    return self;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)registerDetailViewController:(Class <TBODeveloperOverlayKVDebuggerDetailViewController>)viewController {
    [self.detailViewControllerClasses insertObject:viewController atIndex:0];
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
        cell.textLabel.text = @"No Datasource provided. \n - Create a class that implements TBODeveloperOverlayKVDebuggerDatasourceProtocol protocol \n - Register this class in ApplicationDidFinishLaunching unsing TBODeveloperOverlayKVDebugger+registerDatasourceClass:";
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
    } else {
        cell.detailTextLabel.text = [value description];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id value = [self.datasource valueForIndexPath:indexPath];
    NSString *title = [self.datasource titleForSection:indexPath.section];
    Class detailViewControllerClass = [self detailViewControllerClassForValue:value];
    UIViewController <TBODeveloperOverlayKVDebuggerDetailViewController> *detailViewController = [[detailViewControllerClass alloc] initWithValue:value andTitle:title];
    if ([self.datasource respondsToSelector:@selector(descriptionForIndexPath:)]) {
        detailViewController.descriptionString = [self.datasource descriptionForIndexPath:indexPath];
    }
    if ([self.datasource isEditableForIndexPath:indexPath]) {
        detailViewController.valueSaveBlock = ^(id value) {
            [self.datasource didChangeValue:value atIndexPath:indexPath];
        };
    }
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!self.datasource || ![self.datasource respondsToSelector:@selector(titleForSection:)]) {
        return nil;
    }
    return [self.datasource titleForSection:section];
}

#pragma mark helper

- (Class)detailViewControllerClassForValue:(id)value {
    __block Class detailViewControllerClass = nil;
    [self.detailViewControllerClasses enumerateObjectsUsingBlock:^(Class < TBODeveloperOverlayKVDebuggerDetailViewController > _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj respondsToSelector:@selector(supportsValue:)]) {
            if ([obj supportsValue:value]) {
                *stop = YES;
                detailViewControllerClass = obj;
            }
        }
    }];
    return detailViewControllerClass;
}

#pragma mark lazy instantiation

- (NSMutableArray<Class <TBODeveloperOverlayKVDebuggerDetailViewController> > *)detailViewControllerClasses {
    if (!_detailViewControllerClasses) {
        _detailViewControllerClasses = [@[
                                          [TBODeveloperOverlayKVDebuggerNSStringDetailViewController class],
                                          [TBODeveloperOverlayKVDebuggerBoolDetailViewController class],
                                          [TBODeveloperOverlayKVDebuggerNSNumberDetailViewController class],
                                          ] mutableCopy];
    }
    return _detailViewControllerClasses;
}

@end
