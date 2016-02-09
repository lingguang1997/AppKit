//
//  NSString+AKContent.m
//  AppKit
//
//  Created by Zijiao Liu on 2/8/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "NSString+AKContent.h"

@implementation NSString (AKContent)

- (BOOL)isNumber {
    return self.length && [self rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound;
}

@end
