//
//  TBODeveloperOverlayKVDebuggerNSNumberDetailViewController.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 11.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebuggerNSNumberDetailViewController.h"

@interface TBODeveloperOverlayKVDebuggerNSNumberDetailViewController () <UITextFieldDelegate>

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

#pragma mark TextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"];
    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:string];
    
    BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
    return stringIsValid;
}

@end
