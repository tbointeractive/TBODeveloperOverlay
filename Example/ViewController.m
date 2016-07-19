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
#import "TBODeveloperOverlayLoggerCocoaLumberjackDatasource.h"
#import "TBOUserDefaultsDebugDatasource.h"
#import "TBODeveloperOverlayKVDebuggerDatasource.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    // init Key-Value Debugger
    TBODeveloperOverlayKeyValueItem *item1 = [TBODeveloperOverlayKeyValueItem withKey:@"Title 0" value:@"first String"];
    TBODeveloperOverlayKeyValueItem *item2 = [TBODeveloperOverlayKeyValueItem withKey:@"Title 1" value:@YES];
    TBODeveloperOverlayKeyValueItem *item3 = [TBODeveloperOverlayKeyValueItem withKey:@"Title 2" value:@42 description:@"42 is the Answer to the Ultimate Question of Life, the Universe, and Everything" andChangeBlock:^(id _Nullable newValue) {
        NSLog(@"42 is not really changeable.");
    }];
    TBODeveloperOverlayKVDebuggerDatasource *defaultDatasource = [TBODeveloperOverlayKVDebuggerDatasource withSections:@[
                                                                                                                         [TBODeveloperOverlayKeyValueSection
                                                                                                                          withTitle:@"Section 0" andItems:@[item1]],
                                                                                                                         [TBODeveloperOverlayKeyValueSection
                                                                                                                          withTitle:@"Section 1" andItems:@[item1, item2]],
                                                                                                                         [TBODeveloperOverlayKeyValueSection
                                                                                                                          withTitle:@"Section 2" andItems:@[item1, item2, item3]]
                                                                                                                         ]];
    
    TBODeveloperOverlayKVDebugger *defaultDebuggerViewController = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:defaultDatasource];
    
    // init Key-Value Debugger
    TBODebugDatasource *customDatasource = [TBODebugDatasource new];
    TBODeveloperOverlayKVDebugger *customDebuggerViewController = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:customDatasource];
    
    // init User Defaults Inspector
    TBODeveloperOverlayNSUserDefaultsDatasource *userDefaultsDatasource = [TBODeveloperOverlayNSUserDefaultsDatasource new];
    TBODeveloperOverlayKVDebugger *userDefaultsInspector = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:userDefaultsDatasource];
    userDefaultsInspector.title = @"UserDefaults Inspector";
    
    // init User Defaults Inspector
    TBOUserDefaultsDebugDatasource *subclassedUserDefaultsDatasource = [TBOUserDefaultsDebugDatasource new];
    TBODeveloperOverlayKVDebugger *editableUserDefaultsInspector = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:subclassedUserDefaultsDatasource];
    editableUserDefaultsInspector.title = @"UserDefaults Inspector Editable";
    
    
    // init logger
    TBODeveloperOverlayLoggerCocoaLumberjackDatasource *loggerDatasource = [TBODeveloperOverlayLoggerCocoaLumberjackDatasource new];
    TBODeveloperOverlayLogger *logger = [[TBODeveloperOverlayLogger alloc] initWithDatasource:loggerDatasource];
    
    // init file inspector
    TBODeveloperOverlayFileInspectorViewController *fileInspector = [[TBODeveloperOverlayFileInspectorViewController alloc] initWithBaseUrl:[[NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]] URLByDeletingLastPathComponent]];
    fileInspector.title = @"File Inspector";
    
    // init and present developer overlay
    NSArray *plugins = @[defaultDebuggerViewController, customDebuggerViewController, userDefaultsInspector, editableUserDefaultsInspector, logger, fileInspector];
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
