//
//  ViewController.m
//  HHAttachmentSheetViewDemo
//
//  Created by Herui on 15/12/23.
//  Copyright © 2015年 hirain. All rights reserved.
//

#import "ViewController.h"
// #import "HHAttachmentSheetView.h"
#import <HHAttachmentSheet/HHAttachmentSheet.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)buttonDidClicked:(UIButton *)sender {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:5];
    
    [items addObject:[[HHAttachmentSheetButtonItemView alloc] initWithTitle:@"ChoosePhoto" pressed:^ {
        NSLog(@"choose photo");
        
    }]];
    [items addObject:[[HHAttachmentSheetButtonItemView alloc] initWithTitle:@"ChooseViedo" pressed:^ {
        NSLog(@"choose viedo");
        
    }]];
    [items addObject:[[HHAttachmentSheetButtonItemView alloc] initWithTitle:@"SearchPhoto" pressed:^ {
        NSLog(@"search photo");
        
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
