//
//  TBOModalNavigationController.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 20.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBOModalNavigationController.h"

@interface TBOModalNavigationController ()

@property (strong, nonatomic, readwrite) UIBarButtonItem *doneButton;

@end

@implementation TBOModalNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    if (!viewController.navigationItem.rightBarButtonItem) {
        viewController.navigationItem.rightBarButtonItem = self.doneButton;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.topViewController.navigationItem.rightBarButtonItem = self.doneButton;
}

- (void)doneButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIBarButtonItem *)doneButton {
    if (!_doneButton) {
        _doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped)];
    }
    return _doneButton;
}

@end
