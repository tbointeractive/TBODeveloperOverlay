//
//  TBODeveloperOverlayKVDebuggerDatasource.h
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#ifndef TBODeveloperOverlayKVDebuggerDatasource_h
#define TBODeveloperOverlayKVDebuggerDatasource_h

@protocol TBODeveloperOverlayKVDebuggerDatasource <NSObject>

- (NSString *)titleForSection:(NSInteger)section;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSString *)keyForIndexPath:(NSIndexPath *)indexPath;
- (id)valueForIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isEditableForIndexPath:(NSIndexPath *)indexPath;
- (void)didChangeValue:(id)value atIndexPath:(NSIndexPath *)indexPath;

@end

#endif /* TBODeveloperOverlayKVDebuggerDatasource_h */
