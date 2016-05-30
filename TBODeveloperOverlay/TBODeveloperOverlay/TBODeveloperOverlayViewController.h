//
//  TBODeveloperOverlayViewController.h
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBODeveloperOverlayViewController : UIViewController
//
//+ (UINavigationController *)navigationControllerWithDeveloperOverlay;
//+ (void)registerPluginClass:(Class)pluginClass;
- (instancetype)initWithPlugins:(NSArray *)plugins;

@end
