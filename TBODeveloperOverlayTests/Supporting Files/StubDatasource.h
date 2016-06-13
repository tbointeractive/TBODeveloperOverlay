//
// Created by Thorsten Stark on 13.06.16.
// Copyright (c) 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TBODeveloperOverlayKVDebuggerDatasource.h"

@interface StubDatasource : NSObject <TBODeveloperOverlayKVDebuggerDatasource>

-(instancetype)initWithNumberOfSections:(NSInteger)numSections andItemsPerSection:(NSInteger)numItems;

@end