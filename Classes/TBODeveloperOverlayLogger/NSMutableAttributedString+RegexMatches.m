//
//  NSMutableAttributedString+RegexMatches.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 13.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableAttributedString+RegexMatches.h"

@implementation NSMutableAttributedString (RegexMatches)

- (void)addAttributes:(NSDictionary *)attributes toMatchesOfRegex:(NSRegularExpression *)regularExpression {
    __weak typeof(self) weakself = self;
    [regularExpression enumerateMatchesInString:self.string options:kNilOptions range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        [weakself addAttributes:attributes range:subStringRange];
    }];
}

@end
