//
//  TBODeveloperOverlayKVDebuggerBoolDetailViewController.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 08.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebuggerBoolDetailViewController.h"

@interface TBODeveloperOverlayKVDebuggerBoolDetailViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *valueSwitch;

@end

@implementation TBODeveloperOverlayKVDebuggerBoolDetailViewController

- (instancetype)initWithBool:(BOOL)boolean title:(NSString *)title description:(NSString *)description andEditingBlock:(void (^)(id))editingBlock {
    return [super initWithValue:@(boolean) title:title description:description andEditingBlock:editingBlock];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.valueSwitch setOn:((NSNumber *)self.value).boolValue];
    self.valueSwitch.enabled = [self isEditable];
}

- (id)currentValueFromInput {
    return @(self.valueSwitch.isOn);
}

@end
