//
// Created by Thorsten Stark on 13.06.16.
// Copyright (c) 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TBODeveloperOverlayKVDebuggerDatasourceProtocol.h"

@interface StubDatasource : NSObject <TBODeveloperOverlayKVDebuggerDatasourceProtocol>

-(instancetype)initWithNumberOfSections:(NSInteger)numSections andItemsPerSection:(NSInteger)numItems;

@end