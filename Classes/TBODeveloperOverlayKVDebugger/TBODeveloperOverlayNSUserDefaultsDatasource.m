//
//  NSUserDefaultsOverlayDatasource.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 06.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayNSUserDefaultsDatasource.h"

@implementation TBODeveloperOverlayNSUserDefaultsDatasource

- (NSString *)titleForSection:(NSInteger)section {
    return @"NSUserDefaults";
}

- (NSInteger)numberOfSections {
    return 1;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return [NSUserDefaults standardUserDefaults].dictionaryRepresentation.allKeys.count;
}

- (NSString *)keyForIndexPath:(NSIndexPath *)indexPath {
    NSArray *allKeys = [[NSUserDefaults standardUserDefaults].dictionaryRepresentation.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    if (allKeys.count < indexPath.row) {
        return @"";
    }
    return allKeys[indexPath.row];
}

- (id)valueForIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self keyForIndexPath:indexPath];
    if (key && key.length > 0) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:key];
    }
    return nil;
}

- (BOOL)isEditableForIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)didChangeValue:(id)value atIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self keyForIndexPath:indexPath];
    if (key && key.length > 0 && value) {
        [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    }
}

- (NSString *)descriptionForIndexPath:(NSIndexPath *)indexPath {
    return @"";
}

@end
