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
@property (nonatomic) CGFloat groupBorderHPadding;
@property (nonatomic, nullable) UIColor *groupBorderColor;
@property (nonatomic, nullable) UIColor *groupOuterColor;
@property (nonatomic, nullable) UIColor *groupInnerColor;
@property (nonatomic, getter=isSeperatorEnabled) BOOL seperatorEnabled;

+ (CGFloat)groupBorderWidth;
+ (CGFloat)seperatorHeight;
+ (CGFloat)groupBorderCornerRadius;

+ (CGFloat)heightForItem:(nonnull id)item groupStyle:(AKTableViewCellGroupStyle)groupStyle seperatorEnabled:(BOOL)seperatorEnabled fixedWidth:(CGFloat)fixedWidth;

- (nullable UITableView *)tableView;

@end
