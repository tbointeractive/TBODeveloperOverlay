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


+ (void)load {
    if (NSClassFromString(@"TBODeveloperOverlayViewController")) {
        Class overlayClass = NSClassFromString(@"TBODeveloperOverlayViewController");
        SEL registerSelector = NSSelectorFromString(@"registerPluginClass:");
        if ([overlayClass respondsToSelector:registerSelector]) {
            [overlayClass performSelector:registerSelector withObject:self];
        }
    }
}

- (id<TBODeveloperOverlayKVDebuggerDatasource>)datasource {
    if (!_datasource || ![_datasource isKindOfClass:[TBODeveloperOverlayNSUserDefaultsDatasource class]]) {
        _datasource = [TBODeveloperOverlayNSUserDefaultsDatasource new];
    }
    return _datasource;
}

+ (NSString *)title {
    return @"NSUserDefaults Inspector";
}

@end
