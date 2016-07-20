//
//  TBODeveloperOverlayKeyValueItem.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 19.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBODeveloperOverlayKeyValueItem : NSObject

@property (copy, nonatomic, readonly) NSString *_Nonnull key;
@property (copy, nonatomic, readonly) id _Nullable value;
@property (copy, nonatomic, readonly) NSString *_Nullable itemDescription;

@property (readonly, getter = isEditable) BOOL editable;
@property (nonatomic, copy, readonly) void (^_Nullable changeBlock)(id _Nullable newValue);

+ (instancetype _Nonnull)withKey:(NSString *_Nullable)key value:(id _Nullable)value;
+ (instancetype _Nonnull)withKey:(NSString *_Nullable)key value:(id _Nullable)value description:(NSString *_Nullable)description;
+ (instancetype _Nonnull)withKey:(NSString *_Nullable)key value:(id _Nullable)value description:(NSString *_Nullable)description andChangeBlock:(void (^_Nullable)(id _Nullable newValue))changeBlock;

- (instancetype _Nonnull)initWithKey:(NSString *_Nullable)key value:(id _Nullable)value description:(NSString *_Nullable)description;
- (instancetype _Nonnull)initWithKey:(NSString *_Nullable)key value:(id _Nullable)value;
- (instancetype _Nonnull)initWithKey:(NSString *_Nullable)key value:(id _Nullable)value description:(NSString *_Nullable)description andChangeBlock:(void (^_Nullable)(id _Nullable newValue))changeBlock;

@end
