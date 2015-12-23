//
//  HHAttachmentSheetView.h
//  HHAttachmentSheetView
//
//  Created by hirain on 15/12/23.
//  GitHub: http://github.com/red3
//  Please Issues me if you have any questions, thank u. :)
//

#import <UIKit/UIKit.h>
#import "HHAttachmentSheetItemView.h"
#import "HHAttachmentSheetButtonItemView.h"


@interface HHAttachmentSheetView : UIView

@property (nonatomic, strong) NSArray<HHAttachmentSheetItemView *> *items;

- (instancetype)initWithItems:(NSArray<HHAttachmentSheetItemView *> *)items NS_DESIGNATED_INITIALIZER;

- (void)showWithAnimate:(BOOL)animate completion:(void (^)())completion;
- (void)hideWithAnimate:(BOOL)animate completion:(void (^)())completion;

@end
