//
//  HHAttachmentSheetViewDefine.h
//  HHAttachmentSheetView
//
//  Created by Herui on 15/12/23.
//  Copyright © 2015年 hirain. All rights reserved.
//

#ifndef HHAttachmentSheetViewDefine_h
#define HHAttachmentSheetViewDefine_h

static CGFloat HHRetinaPixel = 0.5f;

NS_INLINE BOOL HHIsRetina() {
    static BOOL value = YES;
    static BOOL initialized = NO;
    if (!initialized) {
        value = [[UIScreen mainScreen] scale] > 1.5f;
        initialized = true;
        HHRetinaPixel = value ? 0.5f : 0.0f;
    }
    return value;
}

#define UIColorRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorRGBA(rgb,a) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) / 255.0f) alpha:a])


NS_INLINE int iosMajorVersion() {
    static BOOL initialized = YES;
    static int version = 7;
    if (!initialized)
    {
        switch ([[[UIDevice currentDevice] systemVersion] intValue])
        {
            case 4:
                version = 4;
                break;
            case 5:
                version = 5;
                break;
            case 6:
                version = 6;
                break;
            case 7:
                version = 7;
                break;
            case 8:
                version = 8;
                break;
            case 9:
                version = 9;
                break;
            default:
                version = 8;
                break;
        }
        
        initialized = YES;
    }
    return version;
}

NS_INLINE UIFont *HHSystemFontOfSize(CGFloat size) {
    static bool useSystem = false;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      useSystem = iosMajorVersion() >= 7;
                  });
    
    if (useSystem)
        return [UIFont systemFontOfSize:size];
    else
        return [UIFont fontWithName:@"HelveticaNeue" size:size];
}
NS_INLINE UIFont *HHMediumSystemFontOfSize(CGFloat size)
{
    static bool useSystem = false;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      useSystem = iosMajorVersion() >= 9;
                  });
    
    if (useSystem) {
        return [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
    } else {
        return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
    }
}


NS_INLINE UIFont *HHBoldSystemFontOfSize(CGFloat size) {
    static bool useSystem = false;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      useSystem = iosMajorVersion() >= 7;
                  });
    
    if (useSystem)
        return [UIFont boldSystemFontOfSize:size];
    else
        return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

NS_INLINE UIColor *HHAccentColor() {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      color = UIColorRGB(0x007ee5);
                  });
    
    return color;
}

NS_INLINE UIColor *HHDestructiveAccentColor() {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      color = UIColorRGB(0xff3b30);
                  });
    return color;
}

NS_INLINE UIColor *HHSelectionColor() {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
                          color = UIColorRGB(0xe4e4e4);
                      else
                          color = UIColorRGB(0xd9d9d9);
                  });
    return color;
}

NS_INLINE UIColor *HHSeparatorColor() {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      color = UIColorRGB(0xc8c7cc);
                  });
    return color;
}

#ifdef __LP64__
#   define CGFloor floor
#else
#   define CGFloor floorf
#endif

#ifdef __LP64__
#   define CGRound round
#   define CGCeil ceil
#   define CGPow pow
#   define CGSin sin
#   define CGCos cos
#   define CGSqrt sqrt
#else
#   define CGRound roundf
#   define CGCeil ceilf
#   define CGPow powf
#   define CGSin sinf
#   define CGCos cosf
#   define CGSqrt sqrtf
#endif

#define CGEven(x) ((((int)x) & 1) ? (x + 1) : x)
#define CGOdd(x) ((((int)x) & 1) ? x : (x + 1))


#endif /* HHAttachmentSheetViewDefine_h */
