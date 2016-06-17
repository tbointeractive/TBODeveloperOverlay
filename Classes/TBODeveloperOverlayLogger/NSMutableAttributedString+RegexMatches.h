//
//  NSMutableAttributedString+RegexMatches.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 13.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (RegexMatches)

/**
 *
 *  Adding attributes to all substrings described by the given regular expression.
 *
 *  @param attributes The attributes dictionary containing atributes to be applied to the subtrings of this NSMutableAttributedString.
 *
 *  @param regularExpression Regular expression describing substrings
 */

- (void)addAttributes:(NSDictionary *)attributes toMatchesOfRegex:(NSRegularExpression *)regularExpression;

@end
