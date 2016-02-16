//
//  NSString+AKDrawing.m
//  AppKit
//
//  Created by Zijiao Liu on 12/29/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import "NSString+AKDrawing.h"

@implementation NSString (AKDrawing)

- (CGRect)ak_boundingRectWithFont:(UIFont *)font size:(CGSize)size {
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = @{ NSFontAttributeName : font };
    CGRect rect = [self boundingRectWithSize:size options:options attributes:attributes context:nil];
    return rect;
}

- (CGFloat)ak_HeightWithFont:(UIFont *)font fixedWidth:(CGFloat)fixedWidth {
    return CGRectGetHeight([self ak_boundingRectWithFont:font size:CGSizeMake(fixedWidth, MAXFLOAT)]);
}

- (CGFloat)ak_WidthWithFont:(UIFont *)font fixedHeight:(CGFloat)fixedHeight {
    return CGRectGetWidth([self ak_boundingRectWithFont:font size:CGSizeMake(MAXFLOAT, fixedHeight)]);
}

@end
