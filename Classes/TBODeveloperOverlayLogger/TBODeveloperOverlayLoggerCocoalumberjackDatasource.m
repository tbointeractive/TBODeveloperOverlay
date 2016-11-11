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

#import "TBODeveloperOverlayFilterableLogFormatterProtocol.h"

@interface TBODeveloperOverlayLoggerCocoaLumberjackDatasource ()

@property (strong, nonatomic, readwrite) NSMutableSet<NSRegularExpression *> *logLevelRegexes;
@property (strong, nonatomic, readwrite) NSString *searchString;

@end

@implementation TBODeveloperOverlayLoggerCocoaLumberjackDatasource

- (NSString *)lastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount {
    if (!self.fileLogger) {
        return nil;
    }
    NSString *fullLog = [TBODeveloperOverlayLogFileReader lastLogMessagesLimitedToCharacterCount:maxCharacterCount inFilelogger:[self fileLogger]];
    return [self filteredLog:fullLog];
}

- (NSAttributedString *)attributedLastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount {
    if (!self.fileLogger) {
        return nil;
    }
    NSString *filteredLog = [self lastLogMessagesLimitedToCharacterCount:maxCharacterCount];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:filteredLog];
    if (self.searchString) {
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"%@", self.searchString] options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:nil];
        [attributedString addAttributes:@{NSBackgroundColorAttributeName:[UIColor colorWithRed:0.875 green:1.000 blue:0.886 alpha:1.000]} toMatchesOfRegex:regularExpression];
    }
    return attributedString;
}

#pragma mark logLevels

- (NSOrderedSet <NSString *> *_Nullable)existingLogLevels {
    if ([[[self fileLogger] logFormatter] respondsToSelector:@selector(logLevels)]) {
        return [[[self fileLogger] logFormatter] performSelector:@selector(logLevels)];
    }
    return nil;
}

- (void)setLogLevel:(NSString *_Nonnull)logLevel toOn:(BOOL)on {
    if (![[[self fileLogger] logFormatter] respondsToSelector:@selector(regularExpressionForLogLevel:)]) {
        NSLog(@"log formatter is not implemented to return regular expressions for log levels");
        return;
    }
    NSRegularExpression *regularExpression = [[[self fileLogger] logFormatter] performSelector:@selector(regularExpressionForLogLevel:) withObject:logLevel];
    if (!regularExpression) {
        NSLog(@"there is no regular expression for the requested log level");
        return;
    }
    if (on) {
        [self.logLevelRegexes addObject:regularExpression];
    } else {
        [self.logLevelRegexes removeObject:regularExpression];
    }
}

- (NSRegularExpression *)singleMessageRegularExpression {
    NSRegularExpression *singleMessageRegularExpression = nil;
    if ([[[self fileLogger] logFormatter] respondsToSelector:@selector(logMessageRegularExpression)]) {
        singleMessageRegularExpression = [[[self fileLogger] logFormatter] performSelector:@selector(logMessageRegularExpression)];
    }
    if (!singleMessageRegularExpression) {
        singleMessageRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"^.*$\n" options:NSRegularExpressionAnchorsMatchLines error:nil];
    }
    return singleMessageRegularExpression;
}

- (NSString *)filteredLog:(NSString *)logString {
    NSMutableArray *filteredMessages = [NSMutableArray new];
    NSRegularExpression *singleMessageRegularExpression = [self singleMessageRegularExpression];
    [singleMessageRegularExpression enumerateMatchesInString:[logString stringByAppendingString:@"\n"] options:kNilOptions range:NSMakeRange(0, logString.length) usingBlock:^(NSTextCheckingResult *_Nullable result, NSMatchingFlags flags, BOOL *_Nonnull stop) {
        NSString *match = [logString substringWithRange:result.range];
        BOOL matches = true;
        if (self.logLevelRegexes.count > 0) {
            matches &= [match matchesEveryRegex:self.logLevelRegexes.allObjects];
        }
        if (self.searchString.length > 0) {
            NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@".*%@.*", self.searchString] options:NSRegularExpressionCaseInsensitive error:nil];
            matches &= [match matchesRegex:regularExpression];
        }
        if (matches) {
            [filteredMessages addObject:match];
        }
    }];
    return [filteredMessages componentsJoinedByString:@"\n"];
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
