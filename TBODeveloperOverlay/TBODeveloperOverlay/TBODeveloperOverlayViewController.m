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

- (instancetype)initWithPlugins:(NSArray *)plugins {
    self = [self init];
    if (self) {
        self.plugins = plugins;
        UIViewController *containedViewController;
        if (plugins.count == 1) {
            containedViewController = plugins[0];
        } else {
            containedViewController = [[TBODeveloperOverlayTableViewController alloc] initWithPlugins:plugins];
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

@end
