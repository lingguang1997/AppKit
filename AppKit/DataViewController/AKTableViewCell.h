//
//  AKTableViewCell.h
//  AppKit
//
//  Created by Zijiao Liu on 1/14/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKCell.h"

typedef NS_ENUM(NSInteger, AKTableViewCellGroupStyle) {
    AKTableViewCellGroupStyleNone,
    AKTableViewCellGroupStyleTop,
    AKTableViewCellGroupStyleMiddle,
    AKTableViewCellGroupStyleBottom,
    AKTableViewCellGroupStyleTopAndBottom
};

@interface AKTableViewCell : UITableViewCell <AKCell>

@property (nonatomic) AKTableViewCellGroupStyle groupStyle;
@property (nonatomic, readonly, nullable) UIView *groupInnerView;
@property (nonatomic) CGFloat groupBorderWidth;
@property (nonatomic) CGFloat groupBorderHPadding;
@property (nonatomic, nullable) UIColor *groupBorderColor;
@property (nonatomic, nullable) UIColor *groupOuterColor;
@property (nonatomic, nullable) UIColor *groupInnerColor;

- (void)updateWithItem:(nonnull id)item;
+ (CGFloat)heightForItem:(nonnull id)item fixedWidth:(CGFloat)fixedWidth;
+ (CGFloat)groupInnerHeightForItem:(nonnull id)item fixedWidth:(CGFloat)fixedWidth;
+ (CGFloat)heightForItem:(nonnull id)item fixedWidth:(CGFloat)fixedWidth groupStyle:(AKTableViewCellGroupStyle)groupStyle groupBorderWidth:(CGFloat)groupBorderWidth;

@end
