//
//  AKCell.h
//  AppKit
//
//  Created by Zijiao Liu on 12/28/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AKCell <NSObject>

- (void)updateWithItem:(nonnull id)item;
+ (CGFloat)heightForItem:(nonnull id)item fixedWidth:(CGFloat)fixedWidth;

@end
