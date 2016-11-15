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
 * Checks if the string matches the regex
 *
 *  @param regex A regex describing the searched substring.
 *
 *  @return true if the string (or a substring) matches the regex
 */
- (BOOL)matchesRegex:(NSRegularExpression *)regex;

/**
 * Checks if the string matches every regex
 *
 *  @param regex An array of regular expressions describing the searched substring.
 *
 *  @return true if the string (or a substring) matches every regex
 */
- (BOOL)matchesEveryRegex:(NSArray <NSRegularExpression *> *)regexes;

@end
