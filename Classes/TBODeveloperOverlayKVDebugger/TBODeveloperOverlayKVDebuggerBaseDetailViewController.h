//
//  TBODeveloperOverlayKVDebuggerBaseDetailViewController.h
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 08.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBODeveloperOverlayKVDebuggerBaseDetailViewController : UIViewController

/**
 * Subclasses of TBODeveloperOverlayKVDebuggerBaseDetailViewController are used by the TBODeveloperOverlayKVDebugger to display the value data of one key-value pair in full length.
 * You have to subclass the BaseDetailViewController to implement specific UI and functionality for the desired type.
 * For the following types there are already DetailViewController implemented:
 *
 * * BOOL
 * * NSNumber *
 * * NSString *
 *
 * To implement a custom DetailViewController please subclass TBODeveloperOverlayKVDebuggerBaseDetailViewController and implement the methods marked with a comment. See the implementation of the DetailViewControllers mentioned above for an example implementation.
 *
 * ## Usage
 * Every subclass of TBODeveloperOverlayKVDebuggerBaseDetailViewController has to be initalized with a value. Title, description and an editing block are optional. If you provide an editing block the value will be editable and the editing block, with the changed value as the parameter will be called.
 *
 */

/**
 * The value to be displayed and optionaly edited.
 */
@property (strong, nonatomic, readonly) id _Nonnull value;

/**
 * Initalizes the subclasses of TBODeveloperOverlayKVDebuggerBaseDetailViewController with a value and optional title, description and editing block.
 *
 * @param value The value to be displayed and optionaly edited.
 *
 * @param title The title to be displayed.
 *
 * @param description The description to be displayed.
 *
 * @param editingBlock An editing block that will be called with the new value after tapping the safe button. Provide a nil value to leave the value immutable.
 *
 * @return An instance of a subclass of TBODeveloperOverlayKVDebuggerBaseDetailViewController.
 */
- (instancetype _Nonnull)initWithValue:(id _Nonnull)value title:(NSString *_Nullable)title description:(NSString *_Nullable)description andEditingBlock:(void (^_Nullable)(id _Nullable))editingBlock;

/**
 * Returns a BOOL indicating if the value is editable.
 *
 * @return A BOOL indicating if the value is editable.
 */
- (BOOL)isEditable;

/**
 * Returns a BOOL indicating if this subclass is supporting the given value.
 *
 * @param value The value the BaseDetailViewController subclass checks for conformity.
 *
 * @return A BOOL indicating if this subclass is supporting the given value.
 */
+ (BOOL)isSupportingTypeOfValue:(id _Nonnull)value;

@end
