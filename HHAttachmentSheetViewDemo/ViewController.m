//
//  ViewController.m
//  HHAttachmentSheetViewDemo
//
//  Created by Herui on 15/12/23.
//  Copyright © 2015年 hirain. All rights reserved.
//

#import "ViewController.h"
#import <HHAttachmentSheet/HHAttachmentSheet.h>
#import "HHAutofoldedItemView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)buttonDidClicked:(UIButton *)sender {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:5];
    
    HHAutofoldedItemView *autofoldedItem = [[HHAutofoldedItemView alloc] initWithTitle:@"Autofolded" pressed:nil];
    
    autofoldedItem.autoHideWhenPressed = NO;
    [items addObject:autofoldedItem];
    
    [items addObject:[[HHAttachmentSheetButtonItemView alloc] initWithTitle:@"ChoosePhoto" pressed:^ {
        NSLog(@"choose photo");
        
    }]];
    [items addObject:[[HHAttachmentSheetButtonItemView alloc] initWithTitle:@"ChooseViedo" pressed:^ {
        NSLog(@"choose viedo");
        
    }]];
   
    HHAttachmentSheetButtonItemView *deleteItem = [[HHAttachmentSheetButtonItemView alloc] initWithTitle:@"DeletePhoto" pressed:^{
        NSLog(@"delete photo");
    }];
    deleteItem.destructive = YES;
    [items addObject:deleteItem];
    
    HHAttachmentSheetButtonItemView *cancelItem = [[HHAttachmentSheetButtonItemView alloc] initWithTitle:@"Cancel" pressed:^{
        NSLog(@"cancel");
    }];
    cancelItem.bold = YES;
    [items addObject:cancelItem];
    
    HHAttachmentSheetView *sheetView = [[HHAttachmentSheetView alloc] initWithItems:items];
    [sheetView showWithAnimate:YES completion:^{
        NSLog(@"show complete");
    }];
    
    __weak HHAutofoldedItemView *weakAutofoldedItem = autofoldedItem;
    __weak HHAttachmentSheetView *weakSheetView = sheetView;


    
   
    autofoldedItem.pressed = ^ {
        
        __strong HHAttachmentSheetView *strongSheetView = weakSheetView;
        __strong HHAutofoldedItemView *strongAutofoldedItem = weakAutofoldedItem;
        strongAutofoldedItem.folded = !strongAutofoldedItem.folded;
        
        for (HHAttachmentSheetItemView *itemView in strongSheetView.items) {
            if (itemView != strongAutofoldedItem && itemView != strongSheetView.items.lastObject) {
                itemView.hidden = strongAutofoldedItem.folded;
            }
        }
        [strongSheetView reloadItemsWithAnimate:YES updates:nil completion:nil];
        
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
