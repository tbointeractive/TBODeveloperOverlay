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


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    TBODeveloperOverlayKVDebugger *kvDebuggerViewController = [[TBODeveloperOverlayKVDebugger alloc] init];
    TBODeveloperOverlayViewController *developerOverlay = [[TBODeveloperOverlayViewController alloc] initWithPlugins:@[kvDebuggerViewController]];
    [self presentViewController:developerOverlay animated:YES completion:nil];
}

@end
