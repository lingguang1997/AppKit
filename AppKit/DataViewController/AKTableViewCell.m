//
//  AKTableViewCell.m
//  AppKit
//
//  Created by Zijiao Liu on 1/14/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKTableViewCell.h"

static CGFloat const kGroupBorderWidth = 1;
static CGFloat const kGroupBorderCornerRadius = 5;
static CGFloat const kGroupBorderHPadding = 30;

@interface AKTableViewCell ()

@property (nonatomic, nonnull) CAShapeLayer *groupBorderLayer;
@property (nonatomic) CGFloat groupBorderCornerRadius;

@end

@implementation AKTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _groupBorderLayer = [CAShapeLayer new];
        _groupBorderCornerRadius = kGroupBorderCornerRadius;
        _groupBorderHPadding = kGroupBorderHPadding;
        self.groupBorderWidth = kGroupBorderWidth;
        self.groupBorderColor = [UIColor colorWithRed:216.0 / 255 green:217.0 / 255 blue:218.0 / 255 alpha:1];
        self.groupOuterColor = [UIColor colorWithRed:245.0 / 255 green:246.0 / 255 blue:247.0 / 255 alpha:1];
        self.groupInnerColor = [UIColor whiteColor];

        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [backgroundView.layer addSublayer:_groupBorderLayer];
        self.backgroundView = backgroundView;

        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setGroupStyle:(AKCellGroupStyle)groupStyle {
    if (_groupStyle != groupStyle) {
        _groupStyle = groupStyle;
        [self setNeedsLayout];
    }
}

- (void)setGroupBorderWidth:(CGFloat)groupBorderWidth {
    if (_groupBorderWidth != groupBorderWidth) {
        _groupBorderWidth = groupBorderWidth;
        _groupBorderLayer.lineWidth = _groupBorderWidth;
        [self setNeedsLayout];
    }
}

- (void)setGroupBorderHPadding:(CGFloat)groupBorderHPadding {
    if (_groupBorderHPadding != groupBorderHPadding) {
        _groupBorderHPadding = groupBorderHPadding;
        [self setNeedsLayout];
    }
}

- (void)setGroupBorderColor:(UIColor *)groupBorderColor {
    if (!CGColorEqualToColor(_groupBorderColor.CGColor, groupBorderColor.CGColor)) {
        _groupBorderColor = groupBorderColor;
        _groupBorderLayer.strokeColor = _groupBorderColor.CGColor;
    }
}

- (void)setGroupOuterColor:(UIColor *)groupOuterColor {
    if (!CGColorEqualToColor(_groupOuterColor.CGColor, groupOuterColor.CGColor)) {
        _groupOuterColor = groupOuterColor;
        self.backgroundView.backgroundColor = _groupOuterColor;
    }
}

- (void)setGroupInnerColor:(UIColor *)groupInnerColor {
    if (!CGColorEqualToColor(_groupInnerColor.CGColor, groupInnerColor.CGColor)) {
        _groupInnerColor = groupInnerColor;
        _groupBorderLayer.fillColor = _groupInnerColor.CGColor;
    }
}

- (void)updateWithItem:(id)item {
    // should be overridden by subclasses
}

+ (CGFloat)groupInnerHeightForItem:(id)item fixedWidth:(CGFloat)fixedWidth {
    // should be overrident by subclasses
    return 44;
}

+ (CGFloat)heightForItem:(id)item fixedWidth:(CGFloat)fixedWidth {
    return [AKTableViewCell heightForItem:item fixedWidth:fixedWidth groupStyle:AKCellGroupStyleNone groupBorderWidth:0];
}

+ (CGFloat)heightForItem:(id)item fixedWidth:(CGFloat)fixedWidth groupStyle:(AKCellGroupStyle)groupStyle groupBorderWidth:(CGFloat)groupBorderWidth {
    CGFloat innerHeight = [AKTableViewCell groupInnerHeightForItem:item fixedWidth:fixedWidth];
    if (groupBorderWidth == 0) {
        groupBorderWidth = kGroupBorderWidth;
    }
    switch (groupStyle) {
        case AKCellGroupStyleTop:
        case AKCellGroupStyleBottom:
            return innerHeight + groupBorderWidth;
        case AKCellGroupStyleTopAndBottom:
            return innerHeight + groupBorderWidth + groupBorderWidth;
        default:
            return innerHeight;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _groupBorderLayer.hidden = (_groupStyle == AKCellGroupStyleNone);

    if (!_groupBorderLayer.hidden) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGRect adjustedRect = CGRectInset(self.bounds, _groupBorderHPadding, 0);
        CGRect contentViewFrame = CGRectInset(self.bounds, _groupBorderHPadding - _groupBorderWidth / 2, 0);
        contentViewFrame.size.width = CGRectGetWidth(self.bounds) - _groupBorderHPadding - _groupBorderHPadding;
        switch (_groupStyle) {
            case AKCellGroupStyleTop:
                adjustedRect.origin.y += _groupBorderWidth / 2;
                adjustedRect.size.height += (_groupBorderWidth + _groupBorderCornerRadius);
                CGPathAddRoundedRect(path, NULL, adjustedRect, _groupBorderCornerRadius, _groupBorderCornerRadius);
                contentViewFrame.origin.y = _groupBorderWidth;
                break;
            case AKCellGroupStyleMiddle:
                adjustedRect.origin.y -= _groupBorderWidth / 2;
                adjustedRect.size.height += _groupBorderWidth;
                CGPathAddRect(path, NULL, adjustedRect);
                break;
            case AKCellGroupStyleBottom:
                adjustedRect.origin.y -= (_groupBorderWidth / 2 + _groupBorderCornerRadius);
                adjustedRect.size.height += _groupBorderCornerRadius;
                CGPathAddRoundedRect(path, NULL, adjustedRect, _groupBorderCornerRadius, _groupBorderCornerRadius);
                contentViewFrame.size.height -= _groupBorderWidth;
                break;
            case AKCellGroupStyleTopAndBottom:
                adjustedRect.origin.y += _groupBorderWidth / 2;
                adjustedRect.size.height -= _groupBorderWidth;
                CGPathAddRoundedRect(path, NULL, adjustedRect, _groupBorderCornerRadius, _groupBorderCornerRadius);
                contentViewFrame.origin.y += _groupBorderWidth;
                contentViewFrame.size.height -= (_groupBorderWidth + _groupBorderWidth);
                break;
            default:
                assert(0);
                break;
        }
        self.contentView.frame = contentViewFrame;
        _groupBorderLayer.path = path;
        CGPathRelease(path);
    }
}

- (void)prepareForReuse {
    _groupBorderLayer.hidden = YES;
    _groupBorderLayer.path = nil;
}

@end
