//
//  HHAttachmentSheetButtonItemView.h
//  HHAttachmentSheetView
//
//  Created by Herui on 15/12/23.
//  Copyright © 2015年 hirain. All rights reserved.
//

#import "HHAttachmentSheetItemView.h"

@interface HHAttachmentSheetButtonItemView : HHAttachmentSheetItemView

- (instancetype)initWithTitle:(NSString *)title pressed:(void (^)())pressed;

@property (nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR; // default is nil. use 0x007ee5
@property (nonatomic, strong) UIColor *destructiveColor UI_APPEARANCE_SELECTOR; // default is nil. use 0x007ee5
@property (nonatomic, getter=isBold) BOOL bold; // default to be NO
@property (nonatomic, getter=isDestructive) BOOL destructive; // default to be NO



@end
