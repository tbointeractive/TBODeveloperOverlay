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

+ (NSArray <TBODeveloperOverlayKeyValueItem *> *_Nonnull)itemsFromDictionaries:(NSArray <NSDictionary *> *_Nonnull)itemDictionaries {
    NSMutableArray <TBODeveloperOverlayKeyValueItem *> *items = [NSMutableArray new];
    for (NSDictionary *itemDictionary in itemDictionaries) {
        TBODeveloperOverlayKeyValueItem *item = [TBODeveloperOverlayKeyValueItem fromDictionary:itemDictionary];
        if (item) {
            [items addObject:item];
        }
    }
    return items;
}

+ (instancetype _Nullable)fromDictionary:(NSDictionary *)itemDictionary {
    return [self withKey:itemDictionary[kItemKey] value:itemDictionary[kItemValue] description:itemDictionary[kItemDescription] andChangeBlock:itemDictionary[kItemChangeBlock]];
}

+ (instancetype _Nullable)withKey:(NSString *_Nullable)key value:(id _Nullable)value description:(NSString *_Nullable)description andChangeBlock:(void (^_Nullable)(id _Nullable newValue))changeBlock {
    return [[self alloc] initWithKey:key value:value description:description andChangeBlock:changeBlock];
}

- (instancetype _Nullable)initWithKey:(NSString *)key value:(id)value description:(NSString *)description andChangeBlock:(void (^)(id newValue))changeBlock {
    if (!key || !value) {
        return nil;
    }
    self = [self init];
    if (self) {
        self.key = key;
        self.value = value;
        self.itemDescription = description;
        self.changeBlock = changeBlock;
    }
    return self;
}

- (BOOL)isEditable {
    return self.changeBlock != nil;
}

@end

NSString *kItemKey = @"key";
NSString *kItemValue = @"value";
NSString *kItemDescription = @"description";
NSString *kItemChangeBlock = @"changeBlock";