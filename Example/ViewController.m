//
//  ViewController.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "ViewController.h"
#import "TBODeveloperOverlayKVDebugger.h"
#import "TBODeveloperOverlayNSUserDefaultsDatasource.h"
#import "TBODebugDatasource.h"
#import "TBODeveloperOverlayLogger.h"
#import "TBODeveloperOverlayFileInspectorViewController.h"
#import "TBODeveloperOverlayPluginListViewController.h"
#import "TBOModalNavigationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // init Key-Value Debugger
    TBODebugDatasource *kvDatasource = [TBODebugDatasource new];
    TBODeveloperOverlayKVDebugger *kvDebuggerViewController = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:kvDatasource];
    
    // init User Defaults Inspector
    TBODeveloperOverlayNSUserDefaultsDatasource *userDefaultsDatasource = [TBODeveloperOverlayNSUserDefaultsDatasource new];
    TBODeveloperOverlayKVDebugger *userDefaultsInspector = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:userDefaultsDatasource];
    userDefaultsInspector.title = @"UserDefaults Inspector";

    // init logger
    TBODeveloperOverlayLogger *logger = [TBODeveloperOverlayLogger new];
    
    // init file inspector
    // set baseURL to nil to get application directory
    TBODeveloperOverlayFileInspectorViewController *fileInspector = [[TBODeveloperOverlayFileInspectorViewController alloc] initWithBaseUrl:nil];
    
    // init and present developer overlay
    NSArray *plugins = @[kvDebuggerViewController, userDefaultsInspector, logger, fileInspector];
    UIViewController *containedViewController;
    if (plugins.count == 1) {
        // When there is only one plugin to display it doesn't make sense to use the PluginListViewController.
        // Instead consider displying the plugin as rootViewController of the NavigationController
        containedViewController = plugins[0];
    } else {
        containedViewController = [[TBODeveloperOverlayPluginListViewController alloc] initWithPlugins:plugins];
    }
    
    TBOModalNavigationController *developerOverlay = [[TBOModalNavigationController alloc] initWithRootViewController:containedViewController];
    [self presentViewController:developerOverlay animated:YES completion:nil];
}

@end
