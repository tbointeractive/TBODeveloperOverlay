//
//  UIDeveloperOverlayTableViewController.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 30.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayPluginListViewController.h"

@interface TBODeveloperOverlayPluginListViewController ()

@property (nonatomic, strong) NSArray *plugins;

@end

@implementation TBODeveloperOverlayPluginListViewController

- (instancetype)initWithPlugins:(NSArray *)plugins {
    self = [super init];
    if (self) {
        self.plugins = plugins;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Developer";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pluginCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.plugins.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pluginCell" forIndexPath:indexPath];
    UIViewController *plugin = self.plugins[indexPath.row];
    if (plugin.title && plugin.title.length > 0) {
        cell.textLabel.text = plugin.title;
    } else {
        cell.textLabel.text = NSStringFromClass(plugin.class);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *pluginViewController = self.plugins[indexPath.row];
    if (self.navigationController) {
        [self.navigationController pushViewController:pluginViewController animated:YES];
    } else {
        [self presentViewController:pluginViewController animated:YES completion:nil];
    }
}

@end
