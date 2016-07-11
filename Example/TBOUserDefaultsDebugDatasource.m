//
//  TBOUserDefaultsDebugDatasource.m
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 07.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBOUserDefaultsDebugDatasource.h"

@implementation TBOUserDefaultsDebugDatasource

- (BOOL)isEditableForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return YES;
    }
    return NO;
}

@end
