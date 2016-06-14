//
//  NSMutableAttributedString+RegexMatches.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 13.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (RegexMatches)

- (void)addAttributes:(NSDictionary *)attributes toMatchesOfRegex:(NSRegularExpression *)regularExpression;

@end
