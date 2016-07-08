//
//  TBODeveloperOverlayKVDebuggerBaseDetailViewController.h
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 08.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBODeveloperOverlayKVDebuggerBaseDetailViewController : UIViewController

@property (strong, nonatomic, readonly) id value;

- (instancetype)initWithValue:(id)value title:(NSString *)title description:(NSString *)description andEditingBlock:(void (^)(id))editingBlock;
- (BOOL)isEditable;

@end
