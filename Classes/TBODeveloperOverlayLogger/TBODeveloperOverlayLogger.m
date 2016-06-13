//
//  TBODeveloperOverlayLogger.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 09.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayLogger.h"
#import "TBODeveloperOverlayTaglist.h"

@interface TBODeveloperOverlayLogger () <UITextViewDelegate, TBODeveloperOverlayTaglistDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomConstraint;

@property (strong, nonatomic, readwrite) id<TBODeveloperOverlayLoggerDatasourceProtocol> datasource;

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet TBODeveloperOverlayTaglist *logLevelTagList;

@end

@implementation TBODeveloperOverlayLogger

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maxDisplayedCharacters = 50000;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.datasource respondsToSelector:@selector(existingLogLevels)]) {
        self.logLevelTagList.tags = [self.datasource existingLogLevels];
        self.logLevelTagList.delegate = self;
    }
    self.searchField.enabled = [self.datasource respondsToSelector:@selector(setSearchString:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshText];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length-1, 1)];
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

- (void)refreshText {
    if ([self.datasource respondsToSelector:@selector(attributedLastLogMessagesLimitedToCharacterCount:)]) {
        self.textView.attributedText = [self.datasource attributedLastLogMessagesLimitedToCharacterCount:self.maxDisplayedCharacters];
    } else {
        self.textView.text = [self logString];
    }
}

#pragma mark TBODeveloperOverlayLoggerDatasourceProtocol

- (void)didEnable:(BOOL)on tagWithName:(NSString *)tag {
    [self.datasource setLogLevel:tag toOn:on];
    [self refreshText];
}

#pragma mark text field + keyboard

- (void)keyboardDidShow:(NSNotification *)notification {
    NSValue *kbFrame = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.textViewBottomConstraint.constant = keyboardFrame.size.height;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.textViewBottomConstraint.constant = 0;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark search

- (IBAction)searchFieldDidChange:(UITextField *)textField {
    if ([self.datasource respondsToSelector:@selector(setSearchString:)]) {
        NSString *filter = textField.text;
        [self.datasource setSearchString:filter];
        [self refreshText];
    }
}

@end
