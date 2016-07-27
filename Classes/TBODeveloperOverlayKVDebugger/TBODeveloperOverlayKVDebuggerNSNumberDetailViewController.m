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

- (id)valueToSave {
    return self.valueTextField.text;
}

+ (BOOL)supportsValue:(id)value {
    return [value isKindOfClass:[NSNumber class]];
}

#pragma mark TextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"];
    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:string];
    
    BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
    return stringIsValid;
}

@end
