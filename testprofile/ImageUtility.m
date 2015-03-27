//
//  ImageUtility.m
//  testprofile
//
//  Created by 村上優孝 on 2015/03/27.
//  Copyright (c) 2015年 村上優孝. All rights reserved.
//

#import "ImageUtility.h"

@implementation ImageUtility

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
