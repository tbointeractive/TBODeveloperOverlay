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

/**
 * Returns a substring if the given regular expression matches.
 *
 *  @param regex A regex describing the searched substring.
 *
 *  @return The substring that matches the regex.
 */
- (NSString *_Nonnull)substringThatMatchesRegex:(NSRegularExpression *_Nonnull)regex;

/**
 * Returns a substring if any of the given regular expressions matches.
 *
 *  @param regexes A NSArray of NSRegularExpressions to search for matching substrings.
 *
 *  @return The substring that matches any of the regexes; If there are more than one match, all matches will be concatenated with a newline.
 */
- (NSString *_Nonnull)substringThatMatchesAnyRegex:(NSArray <NSRegularExpression *> *_Nonnull)regexes;

@end
