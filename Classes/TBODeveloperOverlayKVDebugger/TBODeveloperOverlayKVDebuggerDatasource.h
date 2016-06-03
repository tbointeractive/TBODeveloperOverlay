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
- (_Nonnull NSInteger)numberOfSections;

/**
 *  Returns the number of items in the given section
 *
 *  @param section
 *
 *  @return number of items in the given section
 */
- (_Nonnull NSInteger)numberOfItemsInSection:(_Nonnull NSInteger)section;

/**
 *  A title displayed in the header of the given section
 *
 *  @param section
 *
 *  @return string value to display in the header for the given section
 */
- (_Nonnull NSString *)titleForSection:(_Nonnull NSInteger)section;

/**
 *  The key/name for the value at the given indexpath
 *
 *  @param indexPath indexpath of the value
 *
 *  @return string value containing name or key for the corresponding value
 */
- (_Nonnull NSString *)keyForIndexPath:(_Nonnull NSIndexPath *)indexPath;

/**
 *  The value that should be displayed.
 *  That usually is a Bool, Number or String value
 *
 *  @param indexPath indexpath of the value
 *
 *  @return the vlaue that should be displayed
 */
- (_Nullable id)valueForIndexPath:(_Nonnull NSIndexPath *)indexPath;

@optional
/**
 *  An optional description that is shown in the detail view
 *
 *  @param indexPath indexpath of the value
 *
 *  @return string containting the description
 */
- (_Nonnull NSString *)descriptionForIndexPath:(_Nonnull NSIndexPath *)indexPath;

/**
 *  defines whether the value at this indexpath ist editable or not
 *
 *  @param indexPath indexpath of the value
 *
 *  @return Bool value (YES = isEditable, NO = is not editable)
 */
- (BOOL)isEditableForIndexPath:(_Nonnull NSIndexPath *)indexPath;

/**
 *  called when an editable value was changed
 *
 *  @param value     the new value
 *  @param indexPath indexpath of the value
 */
- (void)didChangeValue:(_Nullable id)value atIndexPath:(_Nonnull NSIndexPath *)indexPath;

@end

#endif /* TBODeveloperOverlayKVDebuggerDatasource_h */
