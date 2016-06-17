//
//  TBODeveloperOverlayCococaLumberjackLogFormatter.m
//  TBODeveloperOverlay
//
//  Created by Bernhard Eiling on 16.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayCococaLumberjackLogFormatter.h"

@implementation TBODeveloperOverlayCococaLumberjackLogFormatter

#pragma mark TBODeveloperOverlayFilterableLogFormaterProtocol

- (NSArray<NSString *> *_Nullable)logLevels {
    return [self logLevelDictionary].allKeys;
}

- (NSRegularExpression *_Nullable)regularExpressionForLogLevel:(NSString *_Nonnull)logLevel {
    return [[self logLevelDictionary] objectForKey:logLevel];
}

#pragma mark DDLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    if (!logMessage) {
        return nil;
    }
    return [NSString stringWithFormat:
            @"%@ [%@] %@:%li %@",
            logMessage.timestamp,
            [self shortStringFromFlag:logMessage.flag],
            logMessage.fileName,
            logMessage.line,
            logMessage.message];
}

- (NSString *)shortStringFromFlag:(DDLogFlag)logFlag {
    switch (logFlag) {
        case DDLogFlagError: return @"E";
        case DDLogFlagWarning: return @"W";
        case DDLogFlagInfo: return @"I";
        case DDLogFlagDebug: return @"D";
        case DDLogFlagVerbose: return @"V";
        default: return @"";
    }
    return @"";
}

- (NSDictionary *)logLevelDictionary {
    return @{
             @"Error": [NSRegularExpression regularExpressionWithPattern:@".*\\[E\\].*" options:kNilOptions error:nil],
             @"Warning": [NSRegularExpression regularExpressionWithPattern:@".*\\[W\\].*" options:kNilOptions error:nil],
             @"Verbose": [NSRegularExpression regularExpressionWithPattern:@".*\\[V\\].*" options:kNilOptions error:nil],
             @"Debug": [NSRegularExpression regularExpressionWithPattern:@".*\\[D\\].*" options:kNilOptions error:nil],
             @"Info": [NSRegularExpression regularExpressionWithPattern:@".*\\[I\\].*" options:kNilOptions error:nil],
             };
}

@end
