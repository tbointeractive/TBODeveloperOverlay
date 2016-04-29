//
//  ViewController.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "ViewController.h"

#import "TBODeveloperOverlayViewController.h"
#import "TBODummyPlugin1ViewController.h"
#import "TBODummyPlugin2ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [TBODeveloperOverlayViewController registerPluginClass:[TBODummyPlugin1ViewController class]];
    [TBODeveloperOverlayViewController registerPluginClass:[TBODummyPlugin2ViewController class]];
//    UINavigationController *developerOverlay = [TBODeveloperOverlayViewController navigationControllerWithDeveloperOverlay];
    TBODeveloperOverlayViewController *developerOverlay = [TBODeveloperOverlayViewController new];
    [self addChildViewController:developerOverlay];
    [self.view addSubview:developerOverlay.view];
}

@end
