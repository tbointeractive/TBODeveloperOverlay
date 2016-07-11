//
//  TBODeveloperOverlayKVDebuggerNSNumberDetailViewController.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 11.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebuggerNSNumberDetailViewController.h"

@interface TBODeveloperOverlayKVDebuggerNSNumberDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@end

@implementation TBODeveloperOverlayKVDebuggerNSNumberDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.valueTextField.text = ((NSNumber *)self.value).stringValue;
    self.valueTextField.enabled = [self isEditable];
}

- (id)currentValueFromInput {
    return self.valueTextField.text;
}

+ (BOOL)isSupportingTypeOfValue:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        return YES;
    }
    return NO;
}

@end
