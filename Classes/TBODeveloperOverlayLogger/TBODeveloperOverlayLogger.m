//
//  TBODeveloperOverlayLogger.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 09.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayLogger.h"

@interface TBODeveloperOverlayLogger ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic, readwrite) id<TBODeveloperOverlayLoggerDatasourceProtocol> datasource;

@end

@implementation TBODeveloperOverlayLogger

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maxDisplayedCharacters = 50000;
    }
    return self;
}

- (instancetype)initWithDatasource:(id<TBODeveloperOverlayLoggerDatasourceProtocol>)datasource {
    self = [self init];
    if (self) {
        self.datasource = datasource;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.textView.text = [self logString];
}

- (NSString *)logString {
    if (!self.datasource) {
        return @"No Datasource given";
    }
    if (![self.datasource respondsToSelector:@selector(lastLogMessagesLimitedToCharacterCount:)]) {
        return @"Datasource doesn't implement the lastLogMessagesLimitedToCharacterCount: method";
    }
    NSString *log = [self.datasource lastLogMessagesLimitedToCharacterCount:self.maxDisplayedCharacters];
    if (!log) {
        return @"";
    }
    if (![log isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"Datasource should return NSString, but actual return type is %@", NSStringFromClass(log.class)];
    }
    return log;
}

@end
