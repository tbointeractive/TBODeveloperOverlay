//
//  TBODeveloperOverlayKVDebuggerDatasource.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 19.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayKVDebuggerDatasource.h"
#import "TBODeveloperOverlayKeyValueSection.h"
#import "TBODeveloperOverlayKeyValueItem.h"

@interface TBODeveloperOverlayKVDebuggerDatasource ()

@property (strong, nonatomic, readwrite) NSArray <TBODeveloperOverlayKeyValueSection *> *sections;

@end

@implementation TBODeveloperOverlayKVDebuggerDatasource

+ (instancetype)withSections:(NSArray <TBODeveloperOverlayKeyValueSection *> *)sections {
    return [[self alloc] initWithSections:sections];
}

+ (instancetype)withSectionsFromDictionaries:(NSArray <NSDictionary *> *)sectionDictionaries {
    NSMutableArray *sections = [NSMutableArray new];
    for (NSDictionary *sectionDictionary in sectionDictionaries) {
        TBODeveloperOverlayKeyValueSection *section = [TBODeveloperOverlayKeyValueSection fromDictionary:sectionDictionary];
        if (section) {
            [sections addObject:section];
        }
    }
    return [[self alloc] initWithSections:sections];
}

- (instancetype)initWithSections:(NSArray <TBODeveloperOverlayKeyValueSection *> *)sections {
    self = [self init];
    if (self) {
        self.sections = sections;
    }
    return self;
}

#pragma mark TBODeveloperOverlayKVDebuggerDatasourceProtocol

- (NSString *)titleForSection:(NSInteger)section {
    return [self sectionAtIndex:section].title;
}

- (NSInteger)numberOfSections {
    return self.sections.count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return [self sectionAtIndex:section].itemCount;
}

- (NSString *)keyForIndexPath:(NSIndexPath *)indexPath {
    return [self itemAtIndexPath:indexPath].key;
}

- (id)valueForIndexPath:(NSIndexPath *)indexPath {
    return [self itemAtIndexPath:indexPath].value;
}

- (BOOL)isEditableForIndexPath:(NSIndexPath *)indexPath {
    return [self itemAtIndexPath:indexPath].isEditable;
}

- (void)didChangeValue:(id)value atIndexPath:(NSIndexPath *)indexPath {
    TBODeveloperOverlayKeyValueItem *item = [self itemAtIndexPath:indexPath];
    if (item.changeBlock) {
        item.changeBlock(value);
    }
}

- (NSString *)descriptionForIndexPath:(NSIndexPath *)indexPath {
    return [self itemAtIndexPath:indexPath].itemDescription;
}

#pragma mark helper

- (TBODeveloperOverlayKeyValueSection *)sectionAtIndex:(NSUInteger)index {
    if (index < self.sections.count) {
        return self.sections[index];
    }
    return nil;
}

- (TBODeveloperOverlayKeyValueItem *)itemAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndex:indexPath.section] itemAtIndex:indexPath.row];
}

@end
