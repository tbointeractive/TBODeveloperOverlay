//
//  WCOMLogFormatter.m
//  TBOSetupHelper
//
//  Created by Cornelius Horstmann on 29.04.16.
//  Copyright © 2016 TBO INTERACTIVE GmbH & Co. KG. All rights reserved.
//

#import "TBOLogFormatter.h"

@implementation TBOLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    return [NSString stringWithFormat:
            @"%@ [%@] %@:%li %@",
            logMessage.timestamp,
            [self shortStringFromFlag:logMessage.flag],
            logMessage.fileName,
            logMessage.line,
            logMessage.message];
}

#pragma mark - getter

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

@end
