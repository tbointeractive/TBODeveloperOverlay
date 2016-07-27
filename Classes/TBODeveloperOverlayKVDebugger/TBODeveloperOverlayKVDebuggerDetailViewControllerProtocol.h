//
//  TBODeveloperOverlayKVDebuggerDetailViewControllerProtocol.h
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 20.07.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#ifndef TBODeveloperOverlayKVDebuggerDetailViewControllerProtocol_h
#define TBODeveloperOverlayKVDebuggerDetailViewControllerProtocol_h

typedef void (^TBOValueSaveBlock)(id _Nullable value);

@protocol TBODeveloperOverlayKVDebuggerDetailViewController <NSObject>

@property (copy, nonatomic, readwrite) NSString *_Nullable descriptionString;

/**
 *  When setting the saveBlock the value is expected to be editable
 */
@property (nonatomic, copy, readwrite) TBOValueSaveBlock _Nullable valueSaveBlock;

+ (BOOL)supportsValue:(id _Nonnull)value;
- (instancetype _Nonnull)initWithValue:(id _Nonnull)value andTitle:(NSString *_Nonnull)title;

@end

#endif /* TBODeveloperOverlayKVDebuggerDetailViewControllerProtocol_h */
