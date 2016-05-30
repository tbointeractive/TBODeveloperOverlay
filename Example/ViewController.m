//
//  ViewController.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "ViewController.h"
#import "TBODeveloperOverlayViewController.h"
#import "TBODeveloperOverlayKVDebugger.h"
#import "TBODebugDatasource.h"
#import "TBODeveloperOverlayNSUserdefaultInspectorViewController.h"
#import "TBODeveloperOverlayLogger.h"



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
    
    // init and present developer overlay
    TBODeveloperOverlayViewController *developerOverlay = [[TBODeveloperOverlayViewController alloc] initWithPlugins:@[kvDebuggerViewController, userDefaultsInspector, logger]];
    [self presentViewController:developerOverlay animated:YES completion:nil];
}

@end
