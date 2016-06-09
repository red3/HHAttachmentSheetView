//
//  HHAttachmentSheetButtonItemView.m
//  HHAttachmentSheetView
//
//  Created by Herui on 15/12/23.
//  Copyright © 2015年 hirain. All rights reserved.
//

#import "HHAttachmentSheetButtonItemView.h"
#import "HHAttachmentSheetViewDefine.h"

#pragma mark - HHModernButton
@interface HHModernButton : UIButton
{
    BOOL _animateHighlight;
    UIColor *_titleColor;
    UIView *_highlightBackgroundView;
}

@property (nonatomic) BOOL modernHighlight;
@property (nonatomic, strong) UIColor *highlightBackgroundColor;
@property (nonatomic) UIEdgeInsets backgroundSelectionInsets;
@property (nonatomic) UIEdgeInsets extendedEdgeInsets;

- (void)setTitleColor:(UIColor *)color;

@end

@implementation HHModernButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    _modernHighlight = true;
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.alpha > FLT_EPSILON && !self.hidden) {
        CGRect bounds = self.bounds;
        bounds.origin.x -= _extendedEdgeInsets.left;
        bounds.size.width += _extendedEdgeInsets.left + _extendedEdgeInsets.right;
        bounds.origin.y -= _extendedEdgeInsets.top;
        bounds.size.height += _extendedEdgeInsets.top + _extendedEdgeInsets.bottom;
        if (CGRectContainsPoint(bounds, point))
            return self;
    }
    
    return [super hitTest:point withEvent:event];
}

- (void)setModernHighlight:(BOOL)modernHighlight
{
    _modernHighlight = modernHighlight;
    if (!_modernHighlight)
        self.alpha = 1.0f;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    _animateHighlight = true;
    [super touchesMoved:touches withEvent:event];
    _animateHighlight = false;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _animateHighlight = true;
    [super touchesCancelled:touches withEvent:event];
    _animateHighlight = false;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _animateHighlight = true;
    [super touchesEnded:touches withEvent:event];
    _animateHighlight = false;
}



- (void)setHighlightBackgroundColor:(UIColor *)highlightBackgroundColor
{
    _highlightBackgroundColor = highlightBackgroundColor;
    
    if (_highlightBackgroundColor != nil && _highlightBackgroundView == nil) {
        _highlightBackgroundView = [[UIView alloc] init];
        _highlightBackgroundView.alpha = 0.0f;
        [self insertSubview:_highlightBackgroundView atIndex:0];
    }
    
    _highlightBackgroundView.backgroundColor = _highlightBackgroundColor;
    CGRect frame = self.bounds;
    frame.origin.x -= _backgroundSelectionInsets.left;
    frame.origin.y -= _backgroundSelectionInsets.top;
    frame.size.width += _backgroundSelectionInsets.left + _backgroundSelectionInsets.right;
    frame.size.height += _backgroundSelectionInsets.top + _backgroundSelectionInsets.bottom;
    _highlightBackgroundView.frame = frame;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (_highlightBackgroundView != nil) {
        CGRect frame = self.bounds;
        frame.origin.x -= _backgroundSelectionInsets.left;
        frame.origin.y -= _backgroundSelectionInsets.top;
        frame.size.width += _backgroundSelectionInsets.left + _backgroundSelectionInsets.right;
        frame.size.height += _backgroundSelectionInsets.top + _backgroundSelectionInsets.bottom;
        _highlightBackgroundView.frame = frame;
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (_modernHighlight) {
        
        if (_highlightBackgroundColor != nil) {
            
            CGFloat alpha = (highlighted ? 1.0f : 0.0f);
            if (ABS(alpha - _highlightBackgroundView.alpha) > FLT_EPSILON) {
                if (_animateHighlight)  {
                    [UIView animateWithDuration:0.2 animations:^ {
                         _highlightBackgroundView.alpha = alpha;
                     }];
                } else {
                    _highlightBackgroundView.alpha = alpha;
                }
            }
        } else {
            
            CGFloat alpha = (highlighted ? 0.4f : 1.0f) * (self.enabled ? 1.0f : 0.5f);
            if (ABS(alpha - self.alpha) > FLT_EPSILON) {
                if (_animateHighlight) {
                    [UIView animateWithDuration:0.2 animations:^ {
                         self.alpha = alpha;
                     }];
                } else {
                    self.alpha = alpha;
                }
            }
        }
    }
}

- (void)setTitleColor:(UIColor *)color
{
    _titleColor = color;
    if (iosMajorVersion() >= 7) {
        [self setTintColor:color];
    } else {
        [self setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (_modernHighlight  && _highlightBackgroundColor == nil)  {
        CGFloat alpha = (self.highlighted ? 0.4f : 1.0f) * (self.enabled ? 1.0f : 0.5f);
        self.alpha = alpha;
    }
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if (_modernHighlight) {
        CGFloat alpha = (self.highlighted ? 0.4f : 1.0f) * (self.enabled ? 1.0f : 0.5f);
        self.alpha = alpha;
    }
}

- (void)tintColorDidChange
{
    [super tintColorDidChange];
    
    if (_modernHighlight ) {
        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    }
}

@end




#pragma mark - HHAttachmentSheetButtonItemView
@implementation HHAttachmentSheetButtonItemView
{
    HHModernButton *_button;
    UIImageView *_imageView;
}

- (instancetype)initWithTitle:(NSString *)title pressed:(void (^)())pressed
{
    self = [super initWithFrame:CGRectZero];
    if (!self) {
        return nil;
    }
    _button = [[HHModernButton alloc] init];
    _button.exclusiveTouch = true;
    [_button setTitle:title forState:UIControlStateNormal];
    _titleColor = HHAccentColor();
    _destructiveColor = HHDestructiveAccentColor();
    _button.modernHighlight = YES;
    [_button setTitleColor:_titleColor];
    [_button setTitleColor:_titleColor forState:UIControlStateNormal];
    _button.titleLabel.font = HHSystemFontOfSize(20.0f + HHRetinaPixel);
    [_button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat separatorHeight = HHIsRetina() ? 0.5f : 1.0f;
    _button.backgroundSelectionInsets = UIEdgeInsetsMake(1.0f + separatorHeight, 0.0f, 1.0f, 0.0f);
    _button.highlightBackgroundColor = self.selectionColor;
    _button.highlighted = false;
    
    [self addSubview:_button];
    
    self.pressed = [pressed copy];
    self.autoHideWhenPressed = YES;
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    [_button setTitle:title forState:UIControlStateNormal];
}

- (void)setBold:(BOOL)bold
{
    _button.titleLabel.font = bold ? HHMediumSystemFontOfSize(20.0f + HHRetinaPixel) : HHSystemFontOfSize(20.0f + HHRetinaPixel);
}

- (void)buttonDidClicked:(HHModernButton *)button
{
    if (self.pressed) {
        self.pressed();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_button setTitleColor:self.isDestructive ? self.destructiveColor : self.titleColor ];
    _button.frame = CGRectMake(0.0f, 1.0f, self.bounds.size.width, self.bounds.size.height - 2.0f);
    _imageView.frame = CGRectMake(self.frame.size.width - _button.frame.size.height - 5, 0, _button.frame.size.height, _button.frame.size.height);
}

@end
