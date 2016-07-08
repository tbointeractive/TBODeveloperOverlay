//
//  TBODeveloperOverlayKVDebuggerNSStringDetailViewController.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 08.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebuggerNSStringDetailViewController.h"

@interface TBODeveloperOverlayKVDebuggerNSStringDetailViewController () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *valueTextView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;

@end

@implementation TBODeveloperOverlayKVDebuggerNSStringDetailViewController

- (instancetype)initWithString:(NSString *)string title:(NSString *)title description:(NSString *)description andEditingBlock:(void (^)(id))editingBlock {
    return [super initWithValue:string title:title description:description andEditingBlock:editingBlock];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.valueTextView.text = self.value;
    self.valueTextView.editable = [self isEditable];
}

- (void)recalculateTextViewHeight {
    CGSize size = [self.valueTextView sizeThatFits:CGSizeMake(self.valueTextView.frame.size.width, FLT_MAX)];
    self.textViewHeightConstraint.constant = size.height;
    [self.valueTextView layoutIfNeeded];
    [self.valueTextView scrollRangeToVisible:NSMakeRange(0, 1)];
}

- (id)currentValueFromInput {
    return self.valueTextView.text;
}

#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    [self recalculateTextViewHeight];
}

@end
