//
//  TBODeveloperOverlayKeyValueItem.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 19.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKeyValueItem.h"

@interface TBODeveloperOverlayKeyValueItem ()

@property (copy, nonatomic, readwrite) NSString *_Nonnull key;
@property (copy, nonatomic, readwrite) id _Nullable value;
@property (copy, nonatomic, readwrite) NSString *_Nullable itemDescription;

@property (nonatomic, copy, readwrite) void (^_Nullable changeBlock)(id _Nullable newValue);

@end

@implementation TBODeveloperOverlayKeyValueItem


+ (instancetype _Nonnull)withKey:(NSString *_Nullable)key value:(id _Nullable)value {
    return [self withKey:key value:value description:nil andChangeBlock:nil];
}

+ (instancetype _Nonnull)withKey:(NSString *_Nullable)key value:(id _Nullable)value description:(NSString *_Nullable)description {
    return [self withKey:key value:value description:description andChangeBlock:nil];
}

+ (instancetype _Nonnull)withKey:(NSString *_Nullable)key value:(id _Nullable)value description:(NSString *_Nullable)description andChangeBlock:(void (^_Nullable)(id _Nullable newValue))changeBlock {
    return [[self alloc] initWithKey:key value:value description:description andChangeBlock:changeBlock];
}

- (instancetype)initWithKey:(NSString *)key value:(id)value description:(NSString *)description andChangeBlock:(void (^)(id newValue))changeBlock {
    self = [self init];
    if (self) {
        self.key = key;
        self.value = value;
        self.itemDescription = description;
        self.changeBlock = changeBlock;
    }
    return self;
}

- (instancetype _Nonnull)initWithKey:(NSString *_Nullable)key value:(id _Nullable)value description:(NSString *_Nullable)description {
    return [self initWithKey:key value:value description:description andChangeBlock:nil];
}

- (instancetype _Nonnull)initWithKey:(NSString *_Nullable)key value:(id _Nullable)value {
    return [self initWithKey:key value:value description:nil andChangeBlock:nil];
}

- (BOOL)isEditable {
    return self.changeBlock != nil;
}

@end
