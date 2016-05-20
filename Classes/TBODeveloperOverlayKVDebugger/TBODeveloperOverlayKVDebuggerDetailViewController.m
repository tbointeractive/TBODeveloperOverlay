//
//  TBODeveloperOverlayKVDebuggerDetailViewController.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 20.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebuggerDetailViewController.h"

typedef enum {
    ValueTypeUnknown,
    ValueTypeString,
    ValueTypeNumber,
    ValueTypeBool
} ValueType;

@interface TBODeveloperOverlayKVDebuggerDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UISwitch *valueSwitch;
@property (weak, nonatomic) IBOutlet UITextView *valueTextView;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@property (strong, nonatomic, readwrite) UIBarButtonItem *saveButton;

@property (strong, nonatomic, readwrite) NSIndexPath *indexPath;
@property (nonatomic, strong) id<TBODeveloperOverlayKVDebuggerDatasource> datasource;

@property ValueType valueType;
@end

@implementation TBODeveloperOverlayKVDebuggerDetailViewController

- (instancetype)initWithDatasource:(id<TBODeveloperOverlayKVDebuggerDatasource>)datasource andIndexPath:(NSIndexPath *)indexPath {
    self = [super init];
    if (self) {
        self.indexPath = indexPath;
        self.datasource = datasource;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL isEditable = [self.datasource isEditableForIndexPath:self.indexPath];
    if (isEditable) {
        self.navigationItem.rightBarButtonItem = self.saveButton;
    }
    self.title = [self.datasource keyForIndexPath:self.indexPath];
    self.titleLabel.text = [self.datasource keyForIndexPath:self.indexPath];
    self.descriptionLabel.text = [self.datasource descriptionForIndexPath:self.indexPath] ? : @"no description available";
    
    id value = [self.datasource valueForIndexPath:self.indexPath];
    if ([value isKindOfClass:[NSString class]]) {
        self.valueTextView.text = (NSString *)value;
        self.valueTextView.hidden = NO;
        self.valueTextView.editable = isEditable;
        self.valueType = ValueTypeString;
    } else if (value == (void *)kCFBooleanFalse || value == (void *)kCFBooleanTrue) {
        [self.valueSwitch setOn:((NSNumber *)value).boolValue];
        self.valueSwitch.hidden = NO;
        self.valueSwitch.enabled = isEditable;
        self.valueType = ValueTypeBool;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        self.valueTextField.text = ((NSNumber *)value).stringValue;
        self.valueTextField.hidden = NO;
        self.valueTextField.enabled = isEditable;
        self.valueType = ValueTypeNumber;
    } else {
        self.valueTextView.text = [value description];
        self.valueTextView.hidden = NO;
        self.valueTextView.editable = isEditable;
        self.valueType = ValueTypeUnknown;
    }
}

- (void)saveButtonTapped {
    id newValue = [self currentValueFromInput];
    [self.datasource didChangeValue:newValue atIndexPath:self.indexPath];
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)currentValueFromInput {
    switch (self.valueType) {
        case ValueTypeBool:
            return @(self.valueSwitch.isOn);
        case ValueTypeNumber: {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
            return [numberFormatter numberFromString:self.valueTextField.text];
        }
        case ValueTypeString:
            return self.valueTextView.text;
        default:
            return self.valueTextView.text;
    }
}

#pragma mark TextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"];
    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:textField.text];
    
    BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
    return stringIsValid;
}

#pragma mark lazy instatiation

- (UIBarButtonItem *)saveButton {
    if (!_saveButton) {
        _saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped)];
    }
    return _saveButton;
}

@end
