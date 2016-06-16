//
//  UIDeveloperOverlayTableViewController.h
//  TBODeveloperOverlay
//
//  Created by Thorsten Stark on 30.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * The TBODeveloperOverlayPluginListViewController gives an overview of all plugins it is initiated with.
 *
 * ## Usage
 * TBODeveloperOverlayPluginListViewController has to be instantiated with an array of plugins. Then it can be set as the RootViewController of TBOModalNavigationController or another UINavigationController.
 *
 * `
 * NSArray *plugins = @[kvDebuggerViewController, userDefaultsInspector, logger, fileInspector];
 * TBODeveloperOverlayPluginListViewController* listViewController = [[TBODeveloperOverlayPluginListViewController alloc] initWithPlugins:plugins];
 * TBOModalNavigationController *developerOverlay = [[TBOModalNavigationController alloc] initWithRootViewController:listViewController];
 * `
 */

@interface TBODeveloperOverlayPluginListViewController : UITableViewController

/**
 * Instantiates the TBODeveloperOverlayPluginListViewController with an array of plugins.
 * @param plugins A NSArray containing the plugins to be displayed.
 * @return An instance of TBODeveloperOverlayPluginListViewController.
 */
- (instancetype)initWithPlugins:(NSArray *)plugins;

@end
