//
//  NSString+RegexMatches.h
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 13.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * A NSString category returning substrings for regular expressions.
 */
@interface NSString (RegexMatches)

- (BOOL)matchesRegex:(NSRegularExpression *)regex;
- (BOOL)matchesEveryRegex:(NSArray <NSRegularExpression *> *)regexes;

@end
