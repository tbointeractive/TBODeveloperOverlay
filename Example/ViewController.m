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
#import "TBODeveloperOverlayKVDebuggerNSStringDetailViewController.h"
#import "TBODeveloperOverlayKVDebuggerBoolDetailViewController.h"
#import "TBODeveloperOverlayKVDebuggerNSNumberDetailViewController.h"
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
    
    NSArray *plugins = @[[self simpleKeyValueDebuggerWithoutCustomDatasouce], [self keyValueDebuggerWithCustomDatasource], [self nsuserdefaultsKeyValueDebugger], [self editableNsuserdefaultsKeyValueDebugger], [self loggerOverlay], [self fileInspector]];
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

- (TBODeveloperOverlayKVDebugger *)simpleKeyValueDebuggerWithoutCustomDatasouce {
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
    
    return [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:defaultDatasource];
}

- (TBODeveloperOverlayKVDebugger *)keyValueDebuggerWithCustomDatasource {
    TBODebugDatasource *customDatasource = [TBODebugDatasource new];
    return [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:customDatasource];
}

- (TBODeveloperOverlayKVDebugger *)nsuserdefaultsKeyValueDebugger {
    TBODeveloperOverlayNSUserDefaultsDatasource *userDefaultsDatasource = [TBODeveloperOverlayNSUserDefaultsDatasource new];
    TBODeveloperOverlayKVDebugger *userDefaultsInspector = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:userDefaultsDatasource];
    userDefaultsInspector.title = @"UserDefaults Inspector";
    return userDefaultsInspector;
}

- (TBODeveloperOverlayKVDebugger *)editableNsuserdefaultsKeyValueDebugger {
    TBOUserDefaultsDebugDatasource *subclassedUserDefaultsDatasource = [TBOUserDefaultsDebugDatasource new];
    TBODeveloperOverlayKVDebugger *editableUserDefaultsInspector = [[TBODeveloperOverlayKVDebugger alloc] initWithDatasource:subclassedUserDefaultsDatasource];
    editableUserDefaultsInspector.title = @"UserDefaults Inspector Editable";
    return editableUserDefaultsInspector;
}

- (TBODeveloperOverlayLogger *)loggerOverlay {
    TBODeveloperOverlayLoggerCocoaLumberjackDatasource *loggerDatasource = [TBODeveloperOverlayLoggerCocoaLumberjackDatasource new];
    return [[TBODeveloperOverlayLogger alloc] initWithDatasource:loggerDatasource];
}

- (TBODeveloperOverlayFileInspectorViewController *)fileInspector {
    TBODeveloperOverlayFileInspectorViewController *fileInspector = [[TBODeveloperOverlayFileInspectorViewController alloc] initWithBaseUrl:[[NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]] URLByDeletingLastPathComponent]];
    fileInspector.title = @"File Inspector";
    return fileInspector;
}

@end
