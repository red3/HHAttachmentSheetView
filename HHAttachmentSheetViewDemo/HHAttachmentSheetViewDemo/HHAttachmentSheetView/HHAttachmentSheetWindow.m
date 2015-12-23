//
//  HHAttachmentSheetWindow.m
//  HHAttachmentSheetView
//
//  Created by Herui on 15/12/23.
//  Copyright © 2015年 hirain. All rights reserved.
//

#import "HHAttachmentSheetWindow.h"

@interface HHAttachmentSheetController : UIViewController

@end

@implementation HHAttachmentSheetController

@end

@implementation HHAttachmentSheetWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (!self) {
        return nil;
    }
    self.windowLevel = UIWindowLevelStatusBar - 0.003f;
    HHAttachmentSheetController *controller = [[HHAttachmentSheetController alloc] init];
    self.rootViewController = controller;
    
    return self;
}
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (UIView *)attachmentView
{
    return self.rootViewController.view;
}





@end
