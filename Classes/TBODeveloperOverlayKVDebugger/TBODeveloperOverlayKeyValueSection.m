//
//  TBODeveloperOverlayKeyValueSection.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 19.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKeyValueSection.h"

@interface TBODeveloperOverlayKeyValueSection ()

@property (copy, nonatomic, readwrite) NSString *title;
@property (strong, nonatomic, readwrite) NSArray <TBODeveloperOverlayKeyValueItem *> *items;

@end

@implementation TBODeveloperOverlayKeyValueSection

+ (instancetype _Nonnull)withTitle:(NSString *_Nullable)title andItems:(NSArray <TBODeveloperOverlayKeyValueItem *> *_Nonnull)items {
    return [[self alloc] initWithTitle:title andItems:items];
}

- (instancetype _Nonnull)initWithTitle:(NSString *_Nullable)title andItems:(NSArray <TBODeveloperOverlayKeyValueItem *> *_Nonnull)items {
    self = [self init];
    if (self) {
        self.title = title;
        self.items = items;
    }
    return self;
}

- (NSUInteger)itemCount {
    return self.items.count;
}

- (TBODeveloperOverlayKeyValueItem *)itemAtIndex:(NSUInteger)index {
    if (index < self.items.count) {
        return self.items[index];
    }
    return nil;
}

@end
