//
//  TBODeveloperOverlayKVDebugger.h
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBODeveloperOverlayKVDebuggerDatasource <NSObject>

-(NSString*)titleForSection:(NSInteger)section;
-(NSInteger)numberOfsections;
-(NSInteger)numberOfItemsInSection:(NSInteger)section;
-(id)keyForIndexPath:(NSIndexPath*)indexPath;
-(id)valueForIndexPath:(NSIndexPath*)indexPath;
-(BOOL)isEditableForIndexPath:(NSIndexPath*)indexPath;
-(void)didChangeValue:(id)value atIndexPath:(NSIndexPath*)indexPath;

@end

@interface TBODeveloperOverlayKVDebugger : UITableViewController

@end
