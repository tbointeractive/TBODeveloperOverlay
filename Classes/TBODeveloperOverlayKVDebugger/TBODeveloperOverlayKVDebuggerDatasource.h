//
//  TBODeveloperOverlayKVDebuggerDatasource.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 19.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBODeveloperOverlayKVDebugger.h"

#import "TBODeveloperOverlayKeyValueSection.h"
#import "TBODeveloperOverlayKeyValueItem.h"

@interface TBODeveloperOverlayKVDebuggerDatasource : NSObject <TBODeveloperOverlayKVDebuggerDatasourceProtocol>

+ (instancetype)withSections:(NSArray <TBODeveloperOverlayKeyValueSection *> *)sections;
- (instancetype)initWithSections:(NSArray <TBODeveloperOverlayKeyValueSection *> *)sections;

@end
