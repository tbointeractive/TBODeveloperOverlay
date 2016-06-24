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

@interface TBODeveloperOverlayKVDebuggerDetailViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UISwitch *valueSwitch;
@property (weak, nonatomic) IBOutlet UITextView *valueTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewToDescriptionLabelConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic, readwrite) UIBarButtonItem *saveButton;

@property (strong, nonatomic, readwrite) NSIndexPath *indexPath;
@property (nonatomic, strong) id<TBODeveloperOverlayKVDebuggerDatasourceProtocol> datasource;

@property ValueType valueType;
@end

@implementation TBODeveloperOverlayKVDebuggerDetailViewController

- (instancetype)initWithDatasource:(id<TBODeveloperOverlayKVDebuggerDatasourceProtocol>)datasource andIndexPath:(NSIndexPath *)indexPath {
    self = [super initWithNibName:@"TBODeveloperOverlayKVDebuggerDetailViewController" bundle:[NSBundle bundleForClass:self.class]];
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
    self.titleLabel.text = [self.datasource keyForIndexPath:self.indexPath];
    if ([self.datasource respondsToSelector:@selector(descriptionForIndexPath:)]) {
        self.descriptionLabel.text = [self.datasource descriptionForIndexPath:self.indexPath];
    }
    
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
        [self.scrollView removeConstraint:self.textViewToDescriptionLabelConstraint];
        self.valueType = ValueTypeBool;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        self.valueTextField.text = ((NSNumber *)value).stringValue;
        self.valueTextField.hidden = NO;
        self.valueTextField.enabled = isEditable;
        [self.scrollView removeConstraint:self.textViewToDescriptionLabelConstraint];
        self.valueType = ValueTypeNumber;
    } else {
        self.valueTextView.text = [value description];
        self.valueTextView.hidden = NO;
        self.valueTextView.editable = isEditable;
        self.valueType = ValueTypeUnknown;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self recalculateTextViewHeight];
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

- (void)recalculateTextViewHeight {
    CGSize size = [self.valueTextView sizeThatFits:CGSizeMake(self.valueTextView.frame.size.width, FLT_MAX)];
    self.textViewHeightConstraint.constant = size.height;
    [self.valueTextView layoutIfNeeded];
    [self.valueTextView scrollRangeToVisible:NSMakeRange(0, 1)];
}

#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    [self recalculateTextViewHeight];
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

- (void)setValueTextView:(UITextView *)valueTextView {
    _valueTextView = valueTextView;
    _valueTextView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    _valueTextView.layer.borderWidth = 0.5;
    _valueTextView.layer.cornerRadius = 6.0;
    
}

@end
