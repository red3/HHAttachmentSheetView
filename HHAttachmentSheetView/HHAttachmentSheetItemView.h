//
//  HHAttachmentSheetItemView.h
//  HHAttachmentSheetView
//
//  Created by Herui on 15/12/23.
//  Copyright © 2015年 hirain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHAttachmentSheetItemView : UIView

@property (nonatomic, strong) UIColor *separatorColor UI_APPEARANCE_SELECTOR; // default to be 0xc8c7cc
@property (nonatomic, strong) UIColor *selectionColor UI_APPEARANCE_SELECTOR; // default to be 0xd9d9d9 for iPhone

@property (nonatomic) BOOL showsTopSeparator;
@property (nonatomic) BOOL showsBottomSeparator;
/* default to be NO, set to  YES will hide the SheetView automatically when the userr pressed this item. */
@property (nonatomic) BOOL autoHideWhenPressed;
@property (nonatomic, copy) void (^pressed)();

// subclass should implement this method
// HHAttachmentSheetView use this to calculate it's containerView's height
- (CGFloat)preferredHeight;
- (BOOL)wantsFullSeparator;

@end
