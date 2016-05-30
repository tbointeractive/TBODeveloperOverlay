//
//  ViewController.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "ViewController.h"
#import "TBODeveloperOverlayKVDebugger.h"
#import "TBODebugDatasource.h"
#import "TBODeveloperOverlayNSUserdefaultInspectorViewController.h"
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
    TBODebugDatasource *kvDetasource = [TBODebugDatasource new];
    TBODeveloperOverlayKVDebugger *kvDebuggerViewController = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:kvDetasource];
    
    // init User Defaults Inspector
    TBODeveloperOverlayNSUserdefaultInspectorViewController *userDefaultsInspector = [TBODeveloperOverlayNSUserdefaultInspectorViewController new];
    
    // init logger
    TBODeveloperOverlayLogger *logger = [TBODeveloperOverlayLogger new];
    
    // init file inspector
    // set baseURL to nil to get application directory
    TBODeveloperOverlayFileInspectorViewController *fileInspector = [[TBODeveloperOverlayFileInspectorViewController alloc] initWithBaseUrl:nil];
    
    NSArray *plugins = @[kvDebuggerViewController, userDefaultsInspector, logger, fileInspector];
    UIViewController *containedViewController;
    if (plugins.count == 1) {
        containedViewController = plugins[0];
    } else {
        containedViewController = [[TBODeveloperOverlayPluginListViewController alloc] initWithPlugins:plugins];
    }
    // init and present developer overlay
    TBOModalNavigationController *developerOverlay = [[TBOModalNavigationController alloc] initWithRootViewController:containedViewController];
    [self presentViewController:developerOverlay animated:YES completion:nil];
}

@end
