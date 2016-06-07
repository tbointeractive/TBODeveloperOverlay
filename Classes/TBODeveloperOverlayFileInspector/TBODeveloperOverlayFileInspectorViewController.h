//
//  TBODeveloperOverlayFileInspectorViewController.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 09.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBODeveloperOverlayFileInspectorViewController : UITableViewController

/**
 * Use this method to have just one root folder
 *  the first screen displays already the content of that folder
 *
 * @param baseUrl should be a local readable url
 */
- (instancetype)initWithBaseUrl:(NSURL * _Nonnull)baseUrl;

/**
 * Use this method if you want to inspect multiple folders
 *  the first screen lists those folders. Tapping on them makes it possible to drill down.
 *
 * @param baseUrls should be an array of local readable urls
 */
- (instancetype)initWithBaseUrls:(NSArray<NSURL *> * _Nonnull)baseUrls;

@end
