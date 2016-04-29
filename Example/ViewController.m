//
//  ViewController.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "ViewController.h"
#import "TBODeveloperOverlayKVDebugger.h"

#import "TBODeveloperOverlayViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[TBODeveloperOverlayViewController registerPluginClass:[TBODeveloperOverlayKVDebugger class]];
    UINavigationController *developerOverlay = [TBODeveloperOverlayViewController navigationControllerWithDeveloperOverlay];
    [self addChildViewController:developerOverlay];
    [self.view addSubview:developerOverlay.view];
}

@end
