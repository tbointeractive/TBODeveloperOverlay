//
//  TBODeveloperOverlayViewController.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayViewController.h"

@interface TBODeveloperOverlayViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TBODeveloperOverlayViewController

static NSArray <NSDictionary *> *plugins = nil;

+ (void)registerPluginClass:(Class)pluginClass withTitle:(NSString *)title {
    if (!plugins) {
        plugins = [NSArray new];
    }
    NSMutableArray *tempPlugins = plugins.mutableCopy;
    [tempPlugins addObject:@{@"class": pluginClass, @"title": title}];
    plugins = tempPlugins.copy;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return plugins.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = plugins[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:self.presentedViewController completion:nil];
    }
    Class pluginClass = plugins[indexPath.row][@"class"];
    UIViewController *pluginViewController = [[pluginClass alloc] init];
    [self presentViewController:pluginViewController animated:NO completion:nil];
}

@end
