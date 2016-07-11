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

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.value isKindOfClass:[NSString class]]) {
        self.valueTextView.text = self.value;
    } else {
        self.valueTextView.text = [self.value description];
    }
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

+ (BOOL)isSupportingTypeOfValue:(id)value {
    if ([value isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    [self recalculateTextViewHeight];
}

@end
