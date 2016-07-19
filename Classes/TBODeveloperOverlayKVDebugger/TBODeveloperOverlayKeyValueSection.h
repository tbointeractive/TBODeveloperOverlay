//
//  TBODeveloperOverlayKeyValueSection.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 19.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TBODeveloperOverlayKeyValueItem;

@interface TBODeveloperOverlayKeyValueSection : NSObject

@property (readonly) NSString *_Nullable title;
@property (readonly) NSUInteger itemCount;
- (TBODeveloperOverlayKeyValueItem *_Nullable)itemAtIndex:(NSUInteger)index;

+ (instancetype _Nonnull)withTitle:(NSString *_Nullable)title andItems:(NSArray <TBODeveloperOverlayKeyValueItem *> *_Nonnull)items;
- (instancetype _Nonnull)initWithTitle:(NSString *_Nullable)title andItems:(NSArray <TBODeveloperOverlayKeyValueItem *> *_Nonnull)items;

@end
