//
//  TBODeveloperOverlayLoggerDatasourceProtocol.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 03.06.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#ifndef TBODeveloperOverlayLoggerDatasourceProtocol_h
#define TBODeveloperOverlayLoggerDatasourceProtocol_h

@protocol TBODeveloperOverlayLoggerDatasourceProtocol <NSObject>

- (NSString *_Nullable)lastLogMessagesLimitedToCharacterCount:(NSUInteger)maxCharacterCount;

@optional

@end

#endif /* TBODeveloperOverlayLoggerDatasourceProtocol_h */
