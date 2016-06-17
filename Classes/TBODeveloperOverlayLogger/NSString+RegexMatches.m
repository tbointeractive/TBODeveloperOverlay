//
//  NSString+RegexMatches.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 13.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "NSString+RegexMatches.h"

@implementation NSString (RegexMatches)

- (BOOL)matchesRegex:(NSRegularExpression *)regex {
    if (!regex) {
        return YES;
    }
    if (0 < [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)]) {
        return YES;
    }
    return NO;
}

- (BOOL)matchesAnyRegex:(NSArray <NSRegularExpression *> *)regexes {
    for (NSRegularExpression *regex in regexes) {
        if (![regex isKindOfClass:[NSRegularExpression class]]) {
            return NO;
        }
        if ([self matchesRegex:regex]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)substringThatMatchesRegex:(NSRegularExpression *)regex {
    NSMutableArray *lines = [NSMutableArray new];
    [self enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
        if ([line matchesRegex:regex]) {
            [lines addObject:line];
        }
    }];
    return [lines componentsJoinedByString:@"\n"];
}

- (NSString *)substringThatMatchesAnyRegex:(NSArray <NSRegularExpression *> *)regexes {
    NSMutableArray *lines = [NSMutableArray new];
    [self enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
        if ([line matchesAnyRegex:regexes]) {
            [lines addObject:line];
        }
    }];
    return [lines componentsJoinedByString:@"\n"];
}

@end
