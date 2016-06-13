//
//  NSString+RegexMatches.h
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 13.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegexMatches)

/**
 *
 *  @param regex A regex describing the searched substring
 *
 *  @return The substring that matches the regex
 */
- (NSString *_Nonnull)substringThatMatchesRegex:(NSRegularExpression *_Nonnull)regex;

/**
 *
 *  @param regexes A NSArray of NSRegularExpressions describing searched substrings
 *
 *  @return The substring that matches any of the regexes; If there are more than one match, all matches will be concatenated
 */
- (NSString *_Nonnull)substringThatMatchesAnyRegex:(NSArray <NSRegularExpression *> *_Nonnull)regexes;

@end
