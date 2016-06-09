//
//  HHAttachmentSheetView.m
//  HHAttachmentSheetView
//
//  Created by Herui on 15/12/23.
//  Copyright © 2015年 hirain. All rights reserved.
//

#import "HHAttachmentSheetView.h"
#import "HHAttachmentSheetWindow.h"
#import "HHAttachmentSheetViewDefine.h"

@interface HHAttachmentSheetView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic) CGFloat overscrollHeight;
@property (nonatomic) CGFloat swipeStart;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPanGestureRecognizer *swipeRecognizer;

/* use this window to contain a HHAttachmentSheetView */
@property (nonatomic, strong) HHAttachmentSheetWindow *attachmentSheetWindow; // use the 'strong' property to avoid this window release itself


@end

@implementation HHAttachmentSheetView
#pragma mark - Init
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSAssert(YES, @"never call this method directly, use initWithItems: instead");
    return [self initWithItems:nil];
}
- (instancetype)initWithFrame:(CGRect)frame {
    NSAssert(YES, @"never call this method directly, use initWithItems: instead");
    return [self initWithItems:nil];
}
- (instancetype)initWithItems:(NSArray<HHAttachmentSheetItemView *> *)items {
    self = [super initWithFrame:CGRectZero];
    if (!self) {
        return nil;
    }
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = UIColorRGBA(0x000000, 0.4f);
    [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerDidTapped:)]];
    [self addSubview:_backgroundView];
    
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_containerView];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delaysContentTouches = NO;
    [_containerView addSubview:_scrollView];
    
    _swipeRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerDidSwiped:)];
    _swipeRecognizer.maximumNumberOfTouches = 1;
    _swipeRecognizer.cancelsTouchesInView = YES;
    [self addGestureRecognizer:_swipeRecognizer];
    
    _overscrollHeight = 320.0f;
    
    _attachmentSheetWindow = [[HHAttachmentSheetWindow alloc] init];
    UIView *attachmentView = _attachmentSheetWindow.attachmentView;
    self.frame = attachmentView.frame;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self setItems:items];
    return self;
}
#pragma mark - Setter && Getter
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self updateLayout];
}

- (void)setItems:(NSArray *)items
{
    for (HHAttachmentSheetItemView *itemView in _items) {
        [itemView removeFromSuperview];
    }
    
    _items = items;
    
    for (HHAttachmentSheetItemView *itemView in items) {
        if (itemView.isHidden) {
            continue;
        }
        UIView *separatorView = [[UIView alloc] init];
        separatorView.backgroundColor = [UIColor blueColor];
        if (itemView == items.lastObject) {
            [itemView setShowsTopSeparator:true];
            [itemView setShowsBottomSeparator:true];
            itemView.backgroundColor = [UIColor whiteColor];
            [_containerView addSubview:itemView];
        } else {
            [itemView setShowsTopSeparator:false];
            [itemView setShowsBottomSeparator:true];
            [_scrollView addSubview:itemView];
        }
        
        if (itemView.autoHideWhenPressed) {
            
            __weak typeof (self) weakSelf = self;
            __block void (^ori)() = itemView.pressed;
            itemView.pressed = ^ {
                ori();
                [weakSelf moveOutWithVelocity:0 forInterchange:NO animate:YES completion:NULL];
            };
        }
    }
    
    [self updateLayout];
}
#pragma mark - Private Method
- (void)updateLayout
{
    _backgroundView.frame = self.bounds;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat minScreenHeight = MIN(screenSize.width, screenSize.height);
    CGFloat maxScreenSide = MAX(screenSize.width, screenSize.height);
    
    CGFloat maxHeight = self.frame.size.width < (maxScreenSide - FLT_EPSILON) ? (maxScreenSide - 20.0f - 44.0f + 4.0f) : (minScreenHeight - 20.0f - 32.0f + 4.0f);
    
    CGFloat separatorHeight = HHIsRetina() ? 0.5f : 1.0f;
    CGFloat containerHeight = 0.0f;
    for (HHAttachmentSheetItemView *itemView in _items)  {
        
        if (itemView.isHidden) {
            continue;
        }
        
        if (itemView == _items.lastObject)  {
            containerHeight -= separatorHeight;
            
            CGFloat resultingContainerHeight = MIN(maxHeight, containerHeight + [itemView preferredHeight]);
            itemView.frame = CGRectMake(0.0f, resultingContainerHeight - [itemView preferredHeight], self.frame.size.width, [itemView preferredHeight]);
        } else {
            itemView.frame = CGRectMake(0.0f, containerHeight, self.frame.size.width, [itemView preferredHeight]);
        }
        
        containerHeight += [itemView preferredHeight];
    }
    
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, containerHeight);
    
    _containerView.frame = CGRectMake(0.0f, self.frame.size.height - MIN(maxHeight, containerHeight), self.frame.size.width, MIN(maxHeight, containerHeight) + _overscrollHeight);
    _scrollView.frame = CGRectMake(0.0f, 0.0f, _containerView.frame.size.width, _containerView.frame.size.height - _overscrollHeight);
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, containerHeight);
    
    _swipeRecognizer.enabled = containerHeight <= maxHeight;
}

- (CGFloat)swipeOffsetForOffset:(CGFloat)offset
{
    if (offset < 0.0f) {
        CGFloat c = 0.2f;
        CGFloat d = 320.0f;
        return (CGFloat)((1.0f - (1.0f / ((offset * c / d) + 1.0))) * d);
    }
    
    return offset;
}

- (void)animateToDefaultPosition:(CGFloat)__unused velocity
{
    if (iosMajorVersion() >= 7) {
        [UIView animateWithDuration:0.45 delay:0.0 usingSpringWithDamping:0.48f initialSpringVelocity:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^
         {
             _containerView.frame = CGRectMake(0.0f, self.frame.size.height - _containerView.frame.size.height + _overscrollHeight, _containerView.frame.size.width, _containerView.frame.size.height);
         } completion:nil];
    } else {
        [UIView animateWithDuration:0.2 animations:^
         {
             _containerView.frame = CGRectMake(0.0f, self.frame.size.height - _containerView.frame.size.height + _overscrollHeight, _containerView.frame.size.width, _containerView.frame.size.height);
         }];
    }
}
- (void)moveOutWithVelocity:(CGFloat)velocity forInterchange:(BOOL)interchange animate:(BOOL)animate completion:(void (^)())completion
{
    const CGFloat minVelocity = 400.0f;
    if (ABS(velocity) < minVelocity)
        velocity = (velocity < 0.0f ? -1.0f : 1.0f) * minVelocity;
    CGFloat distance = (velocity < FLT_EPSILON ? -1.0f : 1.0f) * (self.frame.size.height - _containerView.frame.origin.y);
    NSTimeInterval duration = MIN(0.3, (CGFloat)(fabs(distance)) / velocity);
    
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^ {
         _containerView.frame = CGRectMake(0.0f, self.frame.size.height, self.frame.size.width, _containerView.frame.size.height);
         if (!interchange)
             _backgroundView.alpha = 0.0f;
     } completion:^(__unused BOOL finished) {
         
         if (completion) {
             completion();
         }
         HHAttachmentSheetWindow *window = self.attachmentSheetWindow;
         window.hidden = true;
         
         // need to break the retain Cycle
         [self removeFromSuperview];
         // then the attachWindow will release
     }];
}

- (void)moveInWithInitial:(BOOL)initial animate:(BOOL)animate completion:(void (^)())completion
{
    self.attachmentSheetWindow.hidden = NO;
    UIView *attachmentView = _attachmentSheetWindow.attachmentView;
    [attachmentView addSubview:self];
    [self layoutIfNeeded];
    
    if (!animate) {
        if (completion) {
            completion();
        }
        return;
    }
    
    _containerView.frame = CGRectMake(0.0f, self.frame.size.height, self.frame.size.width, _containerView.frame.size.height);
    
    if (initial) {
        _backgroundView.alpha = 0.0f;
    }
    
    if (iosMajorVersion() >= 7) {
        [UIView animateWithDuration:0.12 delay:0.0 options:(7 << 16) | UIViewAnimationOptionAllowUserInteraction animations:^ {
             _containerView.frame = CGRectMake(0.0f, self.frame.size.height - _containerView.frame.size.height + _overscrollHeight, self.frame.size.width, _containerView.frame.size.height);
             _backgroundView.alpha = 1.0f;
         } completion:^(__unused BOOL finished) {
             if (completion) {
                 completion();
             }
             
         }];
    } else {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^
         {
             _containerView.frame = CGRectMake(0.0f, self.frame.size.height - _containerView.frame.size.height + _overscrollHeight, self.frame.size.width, _containerView.frame.size.height);
             _backgroundView.alpha = 1.0f;
         } completion:^(__unused BOOL finished) {
             if (completion) {
                 completion();
             }
         }];
    }
}

#pragma mark - Event 
- (void)gestureRecognizerDidTapped:(UITapGestureRecognizer *)gesture
{
    [self moveOutWithVelocity:0 forInterchange:NO animate:YES completion:NULL];
}
- (void)gestureRecognizerDidSwiped:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (_containerView.layer.presentationLayer != nil) {
            _containerView.layer.position = ((CALayer *)_containerView.layer.presentationLayer).position;
        }
        _swipeStart = [recognizer locationInView:self].y;
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat offset = [recognizer locationInView:self].y - _swipeStart;
        CGFloat bandOffset = [self swipeOffsetForOffset:offset];
        _containerView.frame = CGRectMake(0.0f, self.frame.size.height - _containerView.frame.size.height + _overscrollHeight + bandOffset, _containerView.frame.size.width, _containerView.frame.size.height);
    } else if (recognizer.state == UIGestureRecognizerStateRecognized) {
        CGFloat velocity = [recognizer velocityInView:self].y;
        CGFloat offset = [recognizer locationInView:self].y - _swipeStart;
        if (offset > (_containerView.frame.size.height - _overscrollHeight) / 3.0f || velocity > 200.0f) {
            [self moveOutWithVelocity:MAX(0.0f, velocity) forInterchange:NO animate:YES completion:NULL];
        } else {
            [self animateToDefaultPosition:[recognizer velocityInView:self].y];
        }
    } else if (recognizer.state == UIGestureRecognizerStateCancelled) {
        [self animateToDefaultPosition:[recognizer velocityInView:self].y];
    }
}



#pragma mark - Public Method

- (void)showWithAnimate:(BOOL)animate completion:(void (^)())completion {
    [self moveInWithInitial:YES animate:animate completion:completion];
    
}
- (void)hideWithAnimate:(BOOL)animate completion:(void (^)())completion {
    [self moveOutWithVelocity:0 forInterchange:NO animate:animate completion:completion];
}

- (void)reloadItemsWithAnimate:(BOOL)animate
                       updates:(void (^)(void))updates
                    completion:(void (^)(void))completion {
    
    [self reloadItemsWithAnimate:animate stickToBottom:NO updates:updates completion:completion];
    
}

- (void)reloadItemsWithAnimate:(BOOL)animate
                 stickToBottom:(BOOL)stickToBottom
                       updates:(void (^)(void))updates
                    completion:(void (^)(void))completion {
    
    void (^updatesBlock)(void) = ^ {
        if (updates != nil) {
            updates();
        }
        [self updateLayout];
        
        if (stickToBottom) {
            _scrollView.contentOffset = CGPointMake(0, _scrollView.contentSize.height - _scrollView.bounds.size.height);
        }
    };
    
    if (animate) {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:(7 << 16) | UIViewAnimationOptionLayoutSubviews animations:updatesBlock
                         completion:^(__unused BOOL finished) {
                             if (completion != nil)
                                 completion();
                         }];
    } else {
        updatesBlock();
        
        if (completion != nil)
            completion();
    }
}

@end
