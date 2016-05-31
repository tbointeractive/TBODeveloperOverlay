//
//  TBODeveloperOverlayNSUserdefaultInspectorViewController.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 06.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayNSUserdefaultInspectorViewController.h"
#import "TBODeveloperOverlayNSUserDefaultsDatasource.h"

@interface TBODeveloperOverlayNSUserdefaultInspectorViewController ()

@property (nonatomic, strong) id<TBODeveloperOverlayKVDebuggerDatasource> datasource;

@end

@implementation TBODeveloperOverlayNSUserdefaultInspectorViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"NSUserDefaults Inspector";
    }
    return self;
}

- (id<TBODeveloperOverlayKVDebuggerDatasource>)datasource {
    if (!_datasource || ![_datasource isKindOfClass:[TBODeveloperOverlayNSUserDefaultsDatasource class]]) {
        _datasource = [TBODeveloperOverlayNSUserDefaultsDatasource new];
    }
    return _datasource;
}

@end
