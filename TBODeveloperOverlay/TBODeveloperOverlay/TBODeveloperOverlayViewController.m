//
//  TBODeveloperOverlayViewController.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayViewController.h"
#import "TBOModalNavigationController.h"

@interface TBODeveloperOverlayViewController ()


@end

@implementation TBODeveloperOverlayViewController

static NSArray <Class> *pluginClasses = nil;

+ (UINavigationController *)navigationControllerWithDeveloperOverlay {
    UIViewController *containedViewController;
    if (pluginClasses.count == 1) {
        Class pluginClass = pluginClasses[0];
        containedViewController = [[pluginClass alloc] init];
    } else {
        containedViewController = [[TBODeveloperOverlayViewController alloc] init];
    }
    
    TBOModalNavigationController *navigationController = [[TBOModalNavigationController alloc] initWithRootViewController:containedViewController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    return navigationController;
}

+ (void)registerPluginClass:(Class)pluginClass {
    NSMutableArray *tempPluginClasses = [self.class pluginClasses].mutableCopy;
    [tempPluginClasses addObject:pluginClass];
    pluginClasses = tempPluginClasses.copy;
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
    return pluginClasses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pluginCell" forIndexPath:indexPath];
    Class pluginClass = pluginClasses[indexPath.row];
    if ([pluginClass respondsToSelector:@selector(title)]) {
        cell.textLabel.text = [pluginClass performSelector:@selector(title)];
    } else {
        cell.textLabel.text = NSStringFromClass(pluginClass);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class pluginClass = pluginClasses[indexPath.row];
    UIViewController *pluginViewController = [[pluginClass alloc] init];
    if (self.navigationController) {
        [self.navigationController pushViewController:pluginViewController animated:YES];
    } else {
        [self presentViewController:pluginViewController animated:YES completion:nil];
    }
}

+ (NSArray <Class> *)pluginClasses {
    static dispatch_once_t pluginsOnceToken;
    dispatch_once(&pluginsOnceToken, ^{
        pluginClasses = [NSArray new];
    });
    return pluginClasses;
}

@end
