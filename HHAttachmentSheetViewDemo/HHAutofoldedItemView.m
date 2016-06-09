//
//  HHAutofoldedItemView.m
//  HHAttachmentSheetViewDemo
//
//  Created by Herui on 6/9/16.
//  Copyright © 2016 hirain. All rights reserved.
//

#import "HHAutofoldedItemView.h"

@implementation HHAutofoldedItemView

//- (instancetype)init {
//    self = [super initWithFrame:CGRectZero];
//    if (!self) {
//        return nil;
//    }
//    self.showsBottomSeparator = YES;
//    self.backgroundColor = [UIColor whiteColor];
//    return self;
//}

- (void)setFolded:(BOOL)folded
{
    _folded = folded;
}

- (CGFloat)preferredHeight
{
    if (self.folded) {
        return 100.0f;
    } else {
        return 50;
    }
    
}


@end
