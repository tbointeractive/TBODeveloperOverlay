//
//  TBODeveloperOverlayTaglist.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 13.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * The delegate protocol for a TBODeveloperOverlayTaglist.
 */
@protocol TBODeveloperOverlayTaglistDelegate <NSObject>

@optional
/**
 * Is called when a button in the TBODeveloperOverlayTaglist is tapped.
 *
 * @param on Whether the button is enabled or not.
 * 
 * @param tag The tag (NSString) for the corresponding button.
 */
- (void)didEnable:(BOOL)on tagWithName:(NSString *)tag;

@end

/**
 * A UIView subclass that auto generates rows of buttons according to a given set of tag names.
 */
@interface TBODeveloperOverlayTaglist : UIView

/**
 * A set of NSStrings representing the tags to be displayed as buttons.
 */
@property (strong, nonatomic, readwrite) NSSet <NSString *> *tags;

/**
 * The delegate for the TBODeveloperOverlayTaglist instance.
 */
@property (weak, nonatomic, readwrite) id <TBODeveloperOverlayTaglistDelegate> delegate;

@end
