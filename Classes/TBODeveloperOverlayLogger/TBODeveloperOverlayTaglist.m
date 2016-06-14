//
//  TBODeveloperOverlayTaglist.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 13.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayTaglist.h"

@interface TBODeveloperOverlayTaglist ()

@property (strong, nonatomic, readwrite) NSLayoutConstraint *heightConstraint;

@end

@implementation TBODeveloperOverlayTaglist

- (void)setTags:(NSSet<NSString *> *)tags {
    _tags = tags;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // create all the subview
    [tags enumerateObjectsUsingBlock:^(NSString *_Nonnull tag, BOOL *_Nonnull stop) {
        UIButton *button = [self buttonWithTag:tag];
        [self addSubview:button];
    }];
    [self setNeedsLayout];
}

CGFloat horizontalButtonSpacing = 8.0;
CGFloat verticalButtonSpacing = 8.0;

- (void)layoutSubviews {
    [super layoutSubviews];
    
    __block CGFloat currentY = 0.0;
    __block CGFloat currentX = 0.0;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        CGFloat buttonInThisLineWouldEndAt = currentX + horizontalButtonSpacing + obj.frame.size.width;
        if (buttonInThisLineWouldEndAt > self.frame.size.width) {
            currentY += obj.frame.size.height + verticalButtonSpacing;
            currentX = 0.0;
            // put this button in a new line please!
        } else if (idx != 0) {
            currentX += horizontalButtonSpacing;
        }
        obj.frame = CGRectMake(currentX, currentY, obj.frame.size.width, obj.frame.size.height);
        currentX += obj.frame.size.width;
    }];
    if (self.subviews.count == 0) {
        self.heightConstraint.constant = 0.0;
    } else {
        UIView *lastButton = self.subviews.lastObject;
        self.heightConstraint.constant = lastButton.frame.origin.y + lastButton.frame.size.height;
    }
    if (!self.heightConstraint.active) {
        [self addConstraint:self.heightConstraint];
    }
}

- (UIButton *)buttonWithTag:(NSString *)tag {
    UIButton *loglevelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loglevelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [loglevelButton setTitle:tag forState:UIControlStateNormal];
    loglevelButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [loglevelButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    return loglevelButton;
}

- (void)didTapButton:(UIButton *)button {
    button.selected = !button.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didEnable:tagWithName:)]) {
        NSString *tag = button.titleLabel.text;
        [self.delegate didEnable:button.selected tagWithName:tag];
    }
}

#pragma mark lazy instantiation

- (NSLayoutConstraint *)heightConstraint {
    if (!_heightConstraint) {
        _heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.0];
    }
    return _heightConstraint;
}

@end
