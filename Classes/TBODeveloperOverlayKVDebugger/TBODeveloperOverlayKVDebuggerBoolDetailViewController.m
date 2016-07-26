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

- (id)valueToSave {
    return @(self.valueSwitch.isOn);
}

+ (BOOL)supportsValue:(id)value {
    return (value == (void *)kCFBooleanFalse || value == (void *)kCFBooleanTrue);
}

@end
