//
//  DDFileLogger+Sublog.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 13.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>

@interface DDFileLogger (Sublog)

- (NSString *)lastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount;

@end
