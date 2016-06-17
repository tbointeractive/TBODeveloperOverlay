//
//  TBODeveloperOverlayLoggerCocoaLumberjackDatasource.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 03.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayLoggerCocoaLumberjackDatasource.h"

#import <UIKit/UIKit.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

#import "TBODeveloperOverlayLogFileReader.h"
#import "NSString+RegexMatches.h"
#import "NSMutableAttributedString+RegexMatches.h"

@interface TBODeveloperOverlayLoggerCocoaLumberjackDatasource ()

@property (strong, nonatomic, readwrite) NSMutableSet<NSRegularExpression *> *logLevelRegexes;
@property (strong, nonatomic, readwrite) NSString *searchString;

@end

@implementation TBODeveloperOverlayLoggerCocoaLumberjackDatasource

- (NSString *)lastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount {
    NSString *fullLog = [TBODeveloperOverlayLogFileReader lastLogMessagesLimitedToCharacterCount:maxCharacterCount inFilelogger:[self fileLogger]];
    return [self filteredLog:fullLog];
}

- (NSAttributedString *)attributedLastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount {
    NSString *filteredLog = [self lastLogMessagesLimitedToCharacterCount:maxCharacterCount];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:filteredLog];
    if (self.searchString) {
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"%@", self.searchString] options:NSRegularExpressionDotMatchesLineSeparators error:nil];
        [attributedString addAttributes:@{NSBackgroundColorAttributeName:[UIColor colorWithRed:0.875 green:1.000 blue:0.886 alpha:1.000]} toMatchesOfRegex:regularExpression];
    }
    return attributedString;
}

#pragma mark filter

- (NSDictionary *)logLevels {
    return @{
             @"Error": [NSRegularExpression regularExpressionWithPattern:@".*\\[E\\].*" options:kNilOptions error:nil],
             @"Warning": [NSRegularExpression regularExpressionWithPattern:@".*\\[W\\].*" options:kNilOptions error:nil],
             @"Verbose": [NSRegularExpression regularExpressionWithPattern:@".*\\[V\\].*" options:kNilOptions error:nil],
             @"Debug": [NSRegularExpression regularExpressionWithPattern:@".*\\[D\\].*" options:kNilOptions error:nil],
             };
}

- (NSArray <NSString *> *_Nullable)existingLogLevels {
    return [self logLevels].allKeys;
}

- (void)setLogLevel:(NSString *_Nonnull)logLevel toOn:(BOOL)on {
    NSRegularExpression *regularExpression = [[self logLevels] objectForKey:logLevel];
    if (!regularExpression) {
        return;
    }
    if (on) {
        [self.logLevelRegexes addObject:regularExpression];
    } else {
        [self.logLevelRegexes removeObject:regularExpression];
    }
}

- (NSString *)filteredLog:(NSString *)logString {
    NSString *filteredString = logString;
    if (self.logLevelRegexes.count > 0) {
        filteredString = [logString substringThatMatchesAnyRegex:self.logLevelRegexes.allObjects];
    }
    if (self.searchString.length > 0) {
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@".*%@.*", self.searchString] options:kNilOptions error:nil];
        filteredString = [filteredString substringThatMatchesRegex:regularExpression];
    }
    return filteredString;
}

#pragma mark helper

- (DDFileLogger *)fileLogger {
    if (_fileLogger) {
        return _fileLogger;
    }
    for (id <DDLogger> logger in [DDLog allLoggers]) {
        if ([logger isKindOfClass:[DDFileLogger class]]) {
            return logger;
        }
    }
    return nil;
}

#pragma mark lazy instantiation

- (NSMutableSet<NSRegularExpression *> *)logLevelRegexes {
    if (!_logLevelRegexes) {
        _logLevelRegexes = [NSMutableSet new];
    }
    return _logLevelRegexes;
}

@end
