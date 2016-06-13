//
//  TBODeveloperOverlayTaglist.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 13.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBODeveloperOverlayTaglistDelegate <NSObject>

@optional

- (void)didEnable:(BOOL)on tagWithName:(NSString *)tag;

@end

@interface TBODeveloperOverlayTaglist : UIView

@property (strong, nonatomic, readwrite) NSSet <NSString *> *tags;
@property (weak, nonatomic, readwrite) id <TBODeveloperOverlayTaglistDelegate> delegate;

@end
