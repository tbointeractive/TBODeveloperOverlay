//
//  DDFileLogger+Sublog.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 13.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>

@interface DDFileLogger (Sublog)

/**
 *
 *  @param maxCharacterCount Maximum number of characters the returned string contains.
 *
 *  @return A NSString containing the last given number of characters from the DDFileLogger.
 */

- (NSString *)lastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount;

@end
