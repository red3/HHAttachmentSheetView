## HHAttachmentSheetView

[![travis CI](https://img.shields.io/travis/red3/HHAttachmentSheetView/master.svg)](http://cocoapods.org/pods/HHAttachmentSheetView)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/red3/HHAttachmentSheetView)
[![Version](https://img.shields.io/cocoapods/v/HHAttachmentSheetView.svg?style=flat)](http://cocoapods.org/pods/HHAttachmentSheetView)
[![License](https://img.shields.io/cocoapods/l/HHAttachmentSheetView.svg?style=flat)](http://cocoapods.org/pods/HHAttachmentSheetView)
[![Platform](https://img.shields.io/cocoapods/p/HHAttachmentSheetView.svg?style=flat)](http://cocoapods.org/pods/HHAttachmentSheetView)

HHAttachmentSheetView is inspired by this repo: [Telegram Messenger for iOS](https://github.com/peter-iakovlev/Telegram).

![image](http://photo-coder.b0.upaiyun.com/img/HHAttachmentSheetView.gif)

For more details: [blog.coderhr.com](http://blog.coderhr.com)

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

### CocoaPods

```ruby
pod "HHAttachmentSheetView"
``` 
### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager for Cocoa application. To install the carthage tool, you can use [Homebrew](http://brew.sh).

``` bash
$ brew update
$ brew install carthage
```

To integrate HHAttachmentSheetView into your Xcode project using Carthage, specify it in your `Cartfile`:

``` ogdl
github "red3/HHAttachmentSheetView" ~> 1.4.0
```

Then, run the following command to build the HHAttachmentSheetView framework:

``` bash
$ carthage update

```

At last, you need to set up your Xcode project manually to add the HHAttachmentSheetView framework.

On your application targets’ “General” settings tab, in the “Linked Frameworks and Libraries” section, drag and drop each framework you want to use from the Carthage/Build folder on disk.

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following content:

``` 
/usr/local/bin/carthage copy-frameworks
```

and add the paths to the frameworks you want to use under “Input Files”:

``` 
$(SRCROOT)/Carthage/Build/iOS/HHAttachmentSheet.framework
```

For more information about how to use Carthage, please see its [project page](https://github.com/Carthage/Carthage).

### Manual

Add `HHAttachmentSheetView` folder into your project.

## Demo

Open and run the `HHAttachmentSheetViewDemo.xcodeproj` in Xcode to see HHAttachmentSheetView in action

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

### 2016.06.09 (Tag: 1.4.0)

* Support for `reloadItems`method to update the items with animation.

### 2016.05.06 (Tag: 1.2.0)

* Add new `HHAttachmentSheet.h` file to support for Manual install.

### 2016.03.21 (Tag: 1.1.0)
* Support for Carthage

### 2015.12.29 (Tag: 1.0.0)
* Support for CocoaPods

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

