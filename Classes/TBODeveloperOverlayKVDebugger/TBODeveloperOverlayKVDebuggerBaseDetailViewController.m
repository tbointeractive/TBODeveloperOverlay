//
//  TBODeveloperOverlayKVDebuggerBaseDetailViewController.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 08.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebuggerBaseDetailViewController.h"

@interface TBODeveloperOverlayKVDebuggerBaseDetailViewController ()


@property (strong, nonatomic, readwrite) id value;
@property (strong, nonatomic, readwrite) UIBarButtonItem *saveButton;
@property (strong, nonatomic, readwrite) NSString *titleString;

@end

@implementation TBODeveloperOverlayKVDebuggerBaseDetailViewController

@synthesize valueSaveBlock = _valueSaveBlock;
@synthesize descriptionString = _descriptionString;

- (instancetype _Nonnull)initWithValue:(id _Nonnull)value andTitle:(NSString *_Nonnull)title {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
    if (self) {
        self.value = value;
        self.titleString = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateView];
}

- (void)updateView {
    self.titleLabel.text = self.titleString;
    if (self.descriptionString) {
        self.descriptionLabel.text = self.descriptionString;
    } else {
        self.descriptionLabel.text = @"";
        self.descriptionLabel.hidden = YES;
    }
    if (self.valueSaveBlock) {
        self.navigationItem.rightBarButtonItem = self.saveButton;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (BOOL)isEditable {
    return self.valueSaveBlock != nil;
}

- (id)valueToSave {
    return self.value;
}

- (void)saveButtonTapped:(UIButton *)saveButton {
    if (self.valueSaveBlock) {
        self.valueSaveBlock([self valueToSave]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

+ (BOOL)supportsValue:(id _Nonnull)value {
    return NO;
}

#pragma mark setter / getter

- (void)setValueSaveBlock:(TBOValueSaveBlock)valueSaveBlock {
    _valueSaveBlock = valueSaveBlock;
    [self updateView];
}

- (void)setDescriptionString:(NSString *)descriptionString {
    _descriptionString = descriptionString;
    [self updateView];
}

#pragma mark lazy instantiation

- (UIBarButtonItem *)saveButton {
    if (!_saveButton) {
        _saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped:)];
    }
    return _saveButton;
}

@end
