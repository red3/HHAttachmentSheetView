## HHAttachmentSheetView

HHAttachmentSheetView is inspired by this repo: [Telegram Messenger for iOS](https://github.com/peter-iakovlev/Telegram).

![image](http://photo-coder.b0.upaiyun.com/img/HHAttachmentSheetView.gif)

for more details: [hirain](blog.hirain.win)

## Feature

## How To Use 
```

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
    
```


## TODO

* support for Cocoapod



## 2015.12.23 Update Logs (Tag: 1.0.0)

* first commit


## Tips

* 



## Support

* if you have any questions, please [Issues](https://github.com/red3/HHAttachmentSheetView/issues/new)  me, thank you. :) 
* Blog: [hirain](blog.hirain.win)
* buy me a cup of coffee? 👇

![Alipay](http://photo-coder.b0.upaiyun.com/img/alipay.png)



## License

[MIT license](http://opensource.org/licenses/MIT)
