## HHAttachmentSheetView


[![Version](https://img.shields.io/cocoapods/v/HHAttachmentSheetView.svg?style=flat)](http://cocoapods.org/pods/HHAttachmentSheetView)
[![License](https://img.shields.io/cocoapods/l/HHAttachmentSheetView.svg?style=flat)](http://cocoapods.org/pods/HHAttachmentSheetView)
[![Platform](https://img.shields.io/cocoapods/p/HHAttachmentSheetView.svg?style=flat)](http://cocoapods.org/pods/HHAttachmentSheetView)

HHAttachmentSheetView is inspired by this repo: [Telegram Messenger for iOS](https://github.com/peter-iakovlev/Telegram).

![image](http://photo-coder.b0.upaiyun.com/img/HHAttachmentSheetView.gif)

for more details: [hirain](http://blog.hirain.win)

## Feature

* Swipe to dismiss.
* Support to using the `UI_APPEARANCE_SELECTOR` to customize the appearance. 
* Support both the iPhone and iPad, and also support both the portrait mode and landscape mode.

## Requirements

* Xcode7 or higher
* iOS 6.0 or higher
* ARC
* Objective-C

## Installation

### Cocoapods

```ruby
pod "HHAttachmentSheetView"
``` 

### Manual

Add `HHAttachmentSheetView` folder into your project.

## Demo

Open and run the Demo project in Xcode to see HHAttachmentSheetView in action

## Example usage 
```Objective-C

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

* Add more customized item sample like `HHAttachmentSheetButtonItemView `


## Update Logs

### 2015.12.29 (Tag: 1.0.0)
* Support for cocoapod

### 2015.12.23 

* first commit



## Support

* If you have any questions, please [Issues](https://github.com/red3/HHAttachmentSheetView/issues/new)  me, thank you. :) 
* Blog: [hirain](http://blog.hirain.win)
* Buy me a cup of coffee? 👇

<p align="left" >
<img src="http://photo-coder.b0.upaiyun.com/img/alipay.png" width="276" height="360"/>
</p>



## License
`HHAttachmentSheetView ` is available under the MIT license. See the [LICENSE](http://opensource.org/licenses/MIT) file for more info.

