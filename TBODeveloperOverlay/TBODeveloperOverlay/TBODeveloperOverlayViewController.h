//
//  TBODeveloperOverlayViewController.h
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBODeveloperOverlayViewController : UITableViewController

+ (UINavigationController *)navigationControllerWithDeveloperOverlay;
+ (void)registerPluginClass:(Class)pluginClass;

@end
