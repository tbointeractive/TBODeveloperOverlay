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
/**
 *  Returns the number of sections
 *
 *  @return number of sections
 */
- (NSInteger)numberOfSections;

/**
 *  Returns the number of items in the given section
 *
 *  @param section
 *
 *  @return number of items in the given section
 */
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

/**
 *  A title displayed in the header of the given section
 *
 *  @param section
 *
 *  @return string value to display in the header for the given section
 */
- (NSString *)titleForSection:(NSInteger)section;

/**
 *  The key/name for the value at the given indexpath
 *
 *  @param indexPath indexpath of the value
 *
 *  @return string value containing name or key for the corresponding value
 */
- (NSString *)keyForIndexPath:(NSIndexPath *)indexPath;

/**
 *  The value that should be displayed.
 *  That usually is a Bool, Number or String value
 *
 *  @param indexPath indexpath of the value
 *
 *  @return the vlaue that should be displayed
 */
- (id)valueForIndexPath:(NSIndexPath *)indexPath;

/**
 *  An optional description that is shown in the detail view
 *
 *  @param indexPath indexpath of the value
 *
 *  @return string containting the description
 */
- (NSString *)descriptionForIndexPath:(NSIndexPath *)indexPath;

/**
 *  defines whether the value at this indexpath ist editable or not
 *
 *  @param indexPath indexpath of the value
 *
 *  @return Bool value (YES = isEditable, NO = is not editable)
 */
- (BOOL)isEditableForIndexPath:(NSIndexPath *)indexPath;

/**
 *  called when an editable value was changed
 *
 *  @param value     the new value
 *  @param indexPath indexpath of the value
 */
- (void)didChangeValue:(id)value atIndexPath:(NSIndexPath *)indexPath;

@end

#endif /* TBODeveloperOverlayKVDebuggerDatasource_h */
