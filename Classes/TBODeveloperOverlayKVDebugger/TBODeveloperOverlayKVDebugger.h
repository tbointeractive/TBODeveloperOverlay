//
//  TBODeveloperOverlayKVDebugger.h
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBODeveloperOverlayKVDebuggerDatasource <NSObject>

- (NSString *)titleForSection:(NSInteger)section;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSString *)keyForIndexPath:(NSIndexPath *)indexPath;
- (id)valueForIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isEditableForIndexPath:(NSIndexPath *)indexPath;
- (void)didChangeValue:(id)value atIndexPath:(NSIndexPath *)indexPath;

@end

@interface TBODeveloperOverlayKVDebugger : UITableViewController

/**
 *  Register the class of your datasource.
 *  The datasource has to implement the TBODeveloperOverlayKVDebuggerDatasource protocol.
 *
 *  @param class
 */
+ (void)registerDatasourceClass:(Class)class;

@end
