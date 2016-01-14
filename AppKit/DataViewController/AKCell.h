//
//  AKCell.h
//  AppKit
//
//  Created by Zijiao Liu on 12/28/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AKCellGroupStyle) {
    AKCellGroupStyleNone,
    AKCellGroupStyleTop,
    AKCellGroupStyleMiddle,
    AKCellGroupStyleBottom,
    AKCellGroupStyleTopAndBottom
};

@interface AKCell : UITableViewCell

@property (nonatomic) AKCellGroupStyle groupStyle;
@property (nonatomic, readonly, nullable) UIView *groupInnerView;
@property (nonatomic) CGFloat groupBorderWidth;
@property (nonatomic) CGFloat groupBorderHPadding;
@property (nonatomic, nullable) UIColor *groupBorderColor;
@property (nonatomic, nullable) UIColor *groupOuterColor;
@property (nonatomic, nullable) UIColor *groupInnerColor;

- (void)updateWithItem:(nonnull id)item;
+ (CGFloat)groupInnerHeightForItem:(nonnull id)item fixedWidth:(CGFloat)fixedWidth;
+ (CGFloat)heightForItem:(nonnull id)item fixedWidth:(CGFloat)fixedWidth;
+ (CGFloat)heightForItem:(nonnull id)item fixedWidth:(CGFloat)fixedWidth groupStyle:(AKCellGroupStyle)groupStyle groupBorderWidth:(CGFloat)groupBorderWidth;

@end
