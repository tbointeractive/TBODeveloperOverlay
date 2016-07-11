//
//  TBODeveloperOverlayKVDebuggerBoolDetailViewController.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 08.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebuggerBoolDetailViewController.h"

@interface TBODeveloperOverlayKVDebuggerBoolDetailViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *valueSwitch;

@end

@implementation TBODeveloperOverlayKVDebuggerBoolDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.valueSwitch setOn:((NSNumber *)self.value).boolValue];
    self.valueSwitch.enabled = [self isEditable];
}

- (id)currentValueFromInput {
    return @(self.valueSwitch.isOn);
}

+ (BOOL)isSupportingTypeOfValue:(id)value {
    if (value == (void *)kCFBooleanFalse || value == (void *)kCFBooleanTrue) {
        return YES;
    }
    return NO;
}

@end
