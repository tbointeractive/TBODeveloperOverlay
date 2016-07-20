//
//  TBODeveloperOverlayKVDebuggerBaseDetailViewController.h
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 08.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBODeveloperOverlayKVDebuggerDetailViewControllerProtocol.h"

@interface TBODeveloperOverlayKVDebuggerBaseDetailViewController : UIViewController <TBODeveloperOverlayKVDebuggerDetailViewController>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (strong, nonatomic, readonly) id value;

/**
 *  Override this method to use the save-button of this class.
 *
 *  @return the value that should be saved if the user tapps the save button
 */
- (id)valueToSave;

/**
 * @note: you don't need to override this method. It will return YES if a valueSaveBlock is set an NO otherwise
 *
 * @return A BOOL indicating if the value is editable.
 */
- (BOOL)isEditable;

@end
