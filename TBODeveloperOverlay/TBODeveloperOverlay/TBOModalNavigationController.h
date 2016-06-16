//
//  TBOModalNavigationController.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 20.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * The TBOModalNavigationController is a preconfigured UINavigationController for modal presentation style.
 * Therefore it has a Done-Button which dismisses the ViewController when you're done. This Button can be temporarily replaced with other functions by the used plugins.
 *
 * ## Usage
 * TBOModalNavigationController can be handled like a normal UINavigationController:
 *
 * ```
 * TBOModalNavigationController *developerOverlay = [[TBOModalNavigationController alloc] initWithRootViewController:aRootViewController];
 * [self presentViewController:developerOverlay animated:YES completion:nil];
 * ```
 */

@interface TBOModalNavigationController : UINavigationController

@end
