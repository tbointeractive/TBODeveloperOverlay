//
//  TBODeveloperOverlayKVDebuggerDetailViewController.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 20.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebuggerDetailViewController.h"

@interface TBODeveloperOverlayKVDebuggerDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UISwitch *valueSwitch;
@property (weak, nonatomic) IBOutlet UITextView *valueTextView;

@property (strong, nonatomic, readwrite) UIBarButtonItem *saveButton;

@property (strong, nonatomic, readwrite) NSIndexPath *indexPath;
@property (nonatomic, strong) id<TBODeveloperOverlayKVDebuggerDatasource> datasource;

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
    if ([self.datasource isEditableForIndexPath:self.indexPath]) {
        self.navigationItem.rightBarButtonItem = self.saveButton;
    }
    
    self.titleLabel.text = [self.datasource keyForIndexPath:self.indexPath];
    
}

- (void)saveButtonTapped {
    
}

#pragma mark lazy instatiation

- (UIBarButtonItem *)saveButton {
    if (!_saveButton) {
        _saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped)];
    }
    return _saveButton;
}

@end
