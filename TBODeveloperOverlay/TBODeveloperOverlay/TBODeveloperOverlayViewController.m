//
//  TBODeveloperOverlayViewController.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayViewController.h"

@implementation TBODeveloperOverlayViewController

static NSArray <NSDictionary *> *plugins = nil;

+ (UINavigationController *)navigationControllerWithDeveloperOverlay {
    TBODeveloperOverlayViewController *developerOverlay = [[TBODeveloperOverlayViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:developerOverlay];
    navigationController.navigationBar.topItem.title = @"Developer";
    return navigationController;
}

+ (void)registerPluginClass:(Class)pluginClass {
    NSMutableArray *tempPlugins = [self.class plugins].mutableCopy;
    NSString *title;
    if ([pluginClass respondsToSelector:@selector(title)]) {
        title = [pluginClass performSelector:@selector(title)];
    } else {
        title = NSStringFromClass(pluginClass);
    }
    [tempPlugins addObject:@{@"class": pluginClass, @"title": title}];
    plugins = tempPlugins.copy;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pluginCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return plugins.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pluginCell" forIndexPath:indexPath];
    cell.textLabel.text = plugins[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class pluginClass = plugins[indexPath.row][@"class"];
    UIViewController *pluginViewController = [[pluginClass alloc] init];
    [self.navigationController pushViewController:pluginViewController animated:YES];
}

+ (NSArray <NSDictionary *> *)plugins {
    static dispatch_once_t pluginsOnceToken;
    dispatch_once(&pluginsOnceToken, ^{
        plugins = [NSArray new];
    });
    return plugins;
}

@end
