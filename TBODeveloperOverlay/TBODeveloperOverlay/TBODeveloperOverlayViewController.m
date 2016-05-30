//
//  TBODeveloperOverlayViewController.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayViewController.h"
#import "TBOModalNavigationController.h"
#import "TBODeveloperOverlayTableViewController.h"

@interface TBODeveloperOverlayViewController ()

@property (nonatomic, strong) NSArray *plugins;

@end

@implementation TBODeveloperOverlayViewController

//static NSArray <Class> *pluginClasses = nil;

//+ (UINavigationController *)navigationControllerWithDeveloperOverlay {
//    UIViewController *containedViewController;
//    if (pluginClasses.count == 1) {
//        Class pluginClass = pluginClasses[0];
//        containedViewController = [[pluginClass alloc] init];
//    } else {
//        containedViewController = [[TBODeveloperOverlayViewController alloc] init];
//    }
//
//    TBOModalNavigationController *navigationController = [[TBOModalNavigationController alloc] initWithRootViewController:containedViewController];
//    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
//    return navigationController;
//}
//
//+ (void)registerPluginClass:(Class)pluginClass {
//    NSMutableArray *tempPluginClasses = [self.class pluginClasses].mutableCopy;
//    [tempPluginClasses addObject:pluginClass];
//    pluginClasses = tempPluginClasses.copy;
//}

- (instancetype)initWithPlugins:(NSArray *)plugins {
    self = [super init];
    if (self) {
        self.plugins = plugins;
        UIViewController *containedViewController;
        if (plugins.count == 1) {
            containedViewController = plugins[0];
        } else {
            containedViewController = [[TBODeveloperOverlayTableViewController alloc] init];
        }
        
        TBOModalNavigationController *navigationController = [[TBOModalNavigationController alloc] initWithRootViewController:containedViewController];
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self addChildViewController:navigationController];
        [self.view addSubview:navigationController.view];
        [navigationController didMoveToParentViewController:self];
    }
    return self;
}

- (void)registerPlugins:(NSArray *)plugins {
    self.plugins = plugins;
}



//+ (NSArray <Class> *)pluginClasses {
//    static dispatch_once_t pluginsOnceToken;
//    dispatch_once(&pluginsOnceToken, ^{
//        pluginClasses = [NSArray new];
//    });
//    return pluginClasses;
//}

@end
