//
//  NSString+AKDrawing.h
//  AppKit
//
//  Created by Zijiao Liu on 12/29/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (AKDrawing)

- (CGRect)ak_boundingRectWithFont:(UIFont *)font size:(CGSize)size;
- (CGFloat)ak_HeightWithFont:(UIFont *)font fixedWidth:(CGFloat)fixedWidth;
- (CGFloat)ak_WidthWithFont:(UIFont *)font fixedHeight:(CGFloat)fixedHeight;

@end
