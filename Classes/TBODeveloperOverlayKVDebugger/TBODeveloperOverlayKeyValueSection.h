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

@property (copy, nonatomic, readonly) NSString *_Nullable title;
@property (readonly) NSUInteger itemCount;
- (TBODeveloperOverlayKeyValueItem *_Nullable)itemAtIndex:(NSUInteger)index;

+ (instancetype _Nullable)fromDictionary:(NSDictionary *_Nonnull)section;
- (instancetype _Nonnull)initWithTitle:(NSString *_Nullable)title andItems:(NSArray <TBODeveloperOverlayKeyValueItem *> *_Nonnull)items;

@end

extern NSString *_Nonnull kSectionTitle;
extern NSString *_Nonnull kSectionItems;