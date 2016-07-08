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
@property (strong, nonatomic, readwrite) void (^editingBlock)(id);
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic, readwrite) NSString *titleString;
@property (strong, nonatomic, readwrite) NSString *descriptionString;

@end

@implementation TBODeveloperOverlayKVDebuggerBaseDetailViewController

- (instancetype)initWithValue:(id)value title:(NSString *)title description:(NSString *)description andEditingBlock:(void (^)(id))editingBlock {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.value = value;
        self.editingBlock = editingBlock;
        self.titleString = title;
        self.descriptionString = description;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.titleString;
    self.descriptionLabel.text = self.descriptionString;
    if (self.editingBlock) {
        self.navigationItem.rightBarButtonItem = self.saveButton;
    }
}

- (BOOL)isEditable {
    return self.editingBlock != nil;
}

- (void)saveButtonTapped {
    self.editingBlock([self currentValueFromInput]);
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)currentValueFromInput {
    // implement in subclass
    return self.value;
}

- (UIBarButtonItem *)saveButton {
    if (!_saveButton) {
        _saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped)];
    }
    return _saveButton;
}

@end
