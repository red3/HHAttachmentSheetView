//
//  HHAttachmentSheetItemView.m
//  HHAttachmentSheetView
//
//  Created by Herui on 15/12/23.
//  Copyright © 2015年 hirain. All rights reserved.
//

#import "HHAttachmentSheetItemView.h"
#import "HHAttachmentSheetViewDefine.h"

@implementation HHAttachmentSheetItemView
{
    UIView *_topSeparatorView;
    UIView *_bottomSeparatorView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    _topSeparatorView = [[UIView alloc] init];
    _separatorColor = HHSeparatorColor();
    _selectionColor = HHSelectionColor();
    _topSeparatorView.backgroundColor = _separatorColor;
    
    [self addSubview:_topSeparatorView];
    
    _bottomSeparatorView = [[UIView alloc] init];
    _bottomSeparatorView.backgroundColor = _separatorColor;
    
    [self addSubview:_bottomSeparatorView];
    return self;
}

- (CGFloat)preferredHeight
{
    return 50.0f;
}

- (BOOL)wantsFullSeparator
{
    return NO;
}


- (void)setShowsTopSeparator:(BOOL)showsTopSeparator
{
    _showsTopSeparator = showsTopSeparator;
    _topSeparatorView.hidden = !showsTopSeparator;
}

- (void)setShowsBottomSeparator:(BOOL)showsBottomSeparator
{
    _showsBottomSeparator = showsBottomSeparator;
    _bottomSeparatorView.hidden = !showsBottomSeparator;
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated {
    void (^changeBlock)(void) = ^ {
        self.alpha = hidden ? 0.0f : 1.0f;
    };
    
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        if (finished) {
            self.userInteractionEnabled = !hidden;
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:0.18 animations:changeBlock completion:completionBlock];
    } else {
        changeBlock();
        completionBlock(true);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat separatorHeight = HHIsRetina() ? 0.5f : 1.0f;
    CGFloat separatorInset = [self wantsFullSeparator] ? 0.0f : 15.0f;
    _topSeparatorView.frame = CGRectMake(separatorInset, 0.0f, self.frame.size.width - separatorInset, separatorHeight);
    _bottomSeparatorView.frame = CGRectMake(separatorInset, self.frame.size.height - separatorHeight, self.frame.size.width - separatorInset, separatorHeight);
    _topSeparatorView.backgroundColor = self.separatorColor;
    _bottomSeparatorView.backgroundColor = self.separatorColor;
}


@end
