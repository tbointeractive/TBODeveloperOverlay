//
//  TBODeveloperOverlayKVDebuggerDatasourceProtocol.h
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#ifndef TBODeveloperOverlayKVDebuggerDatasourceProtocol_h
#define TBODeveloperOverlayKVDebuggerDatasourceProtocol_h
/**
 * The TBODeveloperOverlayKVDebuggerDatasourceProtocol must be implemented by every custom datasource you will use with TBODeveloperOverlayKVDebugger.
 */

@protocol TBODeveloperOverlayKVDebuggerDatasourceProtocol <NSObject>

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
 *  The key/name for the value at the given indexpath
 *
 *  @param indexPath indexpath of the value
 *
 *  @return string value containing name or key for the corresponding value
 */
- (NSString *_Nonnull)keyForIndexPath:(NSIndexPath *_Nonnull)indexPath;

/**
 *  The value that should be displayed.
 *  That usually is a Bool, Number or String value
 *
 *  @param indexPath indexpath of the value
 *
 *  @return the vlaue that should be displayed
 */
- (_Nullable id)valueForIndexPath:(NSIndexPath *_Nonnull)indexPath;

@optional

/**
 *  A title displayed in the header of the given section
 *
 *  @param section
 *
 *  @return string value to display in the header for the given section
 */
- (NSString *_Nullable)titleForSection:(NSInteger)section;

/**
 *  An optional description that is shown in the detail view
 *
 *  @param indexPath indexpath of the value
 *
 *  @return string containting the description
 */
- (NSString *_Nullable)descriptionForIndexPath:(NSIndexPath *_Nonnull)indexPath;

/**
 *  defines whether the value at this indexpath ist editable or not
 *
 *  @param indexPath indexpath of the value
 *
 *  @return Bool value (YES = isEditable, NO = is not editable)
 */
- (BOOL)isEditableForIndexPath:(NSIndexPath *_Nonnull)indexPath;

/**
 *  called when an editable value was changed
 *
 *  @param value     the new value
 *  @param indexPath indexpath of the value
 */
- (void)didChangeValue:(_Nullable id)value atIndexPath:(NSIndexPath *_Nonnull)indexPath;

@end

#endif /* TBODeveloperOverlayKVDebuggerDatasourceProtocol_h */
