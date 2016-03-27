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
static CGFloat const kGroupBorderHPadding = 15;
static CGFloat const kSeperatorHeight = 1;
static CGFloat const kSeperatorHPadding = kGroupBorderHPadding + kGroupBorderHPadding;

@interface AKTableViewCell ()

@property (nonatomic, nonnull) CAShapeLayer *groupBorderLayer;
@property (nonatomic) CGFloat groupBorderCornerRadius;

@property (nonatomic, nonnull) CALayer *seperatorLayer;

@end

@implementation AKTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _groupBorderLayer = [CAShapeLayer new];
        _groupBorderCornerRadius = kGroupBorderCornerRadius;
        _groupBorderHPadding = kGroupBorderHPadding;
        self.groupBorderColor = [UIColor colorWithRed:216.0 / 255 green:217.0 / 255 blue:218.0 / 255 alpha:1];
        self.groupOuterColor = [UIColor colorWithRed:245.0 / 255 green:246.0 / 255 blue:247.0 / 255 alpha:1];
        self.groupInnerColor = [UIColor whiteColor];
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [backgroundView.layer addSublayer:_groupBorderLayer];
        self.backgroundView = backgroundView;

        _seperatorLayer = [CALayer new];
        _seperatorLayer.backgroundColor = self.groupBorderColor.CGColor;
        _seperatorEnabled = YES;
        [self.contentView.layer addSublayer:_seperatorLayer];

        self.backgroundColor = [UIColor colorWithRed:245.0 / 255 green:246.0 / 255 blue:247.0 / 255 alpha:1];

        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setGroupStyle:(AKTableViewCellGroupStyle)groupStyle {
    if (_groupStyle != groupStyle) {
        _groupStyle = groupStyle;
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

+ (CGFloat)heightForItem:(id)item fixedWidth:(CGFloat)fixedWidth {
    // should be overridden by subclasses
    return 44;
}

+ (CGFloat)groupBorderWidth {
    return kGroupBorderWidth;
}

+ (CGFloat)seperatorHeight {
    return kSeperatorHeight;
}

+ (CGFloat)heightForItem:(id)item groupStyle:(AKTableViewCellGroupStyle)groupStyle seperatorEnabled:(BOOL)seperatorEnabled fixedWidth:(CGFloat)fixedWidth {
    CGFloat innerHeight = [self heightForItem:item fixedWidth:fixedWidth];
    CGFloat groupBorderWidth = [self groupBorderWidth];
    CGFloat seperatorHeight = [self seperatorHeight];
    switch (groupStyle) {
        case AKTableViewCellGroupStyleTop:
            return innerHeight + groupBorderWidth + ((seperatorEnabled) ? seperatorHeight : 0);
        case AKTableViewCellGroupStyleMiddle:
        case AKTableViewCellGroupStyleNone:
            return innerHeight + ((seperatorEnabled) ? seperatorHeight : 0);
        case AKTableViewCellGroupStyleBottom:
            return innerHeight + groupBorderWidth;
        case AKTableViewCellGroupStyleTopAndBottom:
            return innerHeight + groupBorderWidth + groupBorderWidth;
        default:
            assert(0);
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _groupBorderLayer.hidden = (_groupStyle == AKTableViewCellGroupStyleNone);
    _seperatorLayer.hidden = !(_seperatorEnabled && (_groupStyle == AKTableViewCellGroupStyleTop || _groupStyle == AKTableViewCellGroupStyleMiddle || _groupStyle == AKTableViewCellGroupStyleNone));

    if (!_groupBorderLayer.hidden) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGRect adjustedRect = CGRectInset(self.bounds, _groupBorderHPadding, 0);
        CGFloat groupBorderWidth = [[self class] groupBorderWidth];
        CGRect contentViewFrame = CGRectInset(self.bounds, _groupBorderHPadding - groupBorderWidth / 2, 0);
        contentViewFrame.size.width = CGRectGetWidth(self.bounds) - _groupBorderHPadding - _groupBorderHPadding;
        switch (_groupStyle) {
            case AKTableViewCellGroupStyleTop:
                adjustedRect.origin.y += groupBorderWidth / 2;
                adjustedRect.size.height += (groupBorderWidth + _groupBorderCornerRadius);
                CGPathAddRoundedRect(path, NULL, adjustedRect, _groupBorderCornerRadius, _groupBorderCornerRadius);
                contentViewFrame.origin.y = groupBorderWidth;
                break;
            case AKTableViewCellGroupStyleMiddle:
                adjustedRect.origin.y -= groupBorderWidth / 2;
                adjustedRect.size.height += groupBorderWidth;
                CGPathAddRect(path, NULL, adjustedRect);
                break;
            case AKTableViewCellGroupStyleBottom:
                adjustedRect.origin.y -= (groupBorderWidth / 2 + _groupBorderCornerRadius);
                adjustedRect.size.height += _groupBorderCornerRadius;
                CGPathAddRoundedRect(path, NULL, adjustedRect, _groupBorderCornerRadius, _groupBorderCornerRadius);
                contentViewFrame.size.height -= groupBorderWidth;
                break;
            case AKTableViewCellGroupStyleTopAndBottom:
                adjustedRect.origin.y += groupBorderWidth / 2;
                adjustedRect.size.height -= groupBorderWidth;
                CGPathAddRoundedRect(path, NULL, adjustedRect, _groupBorderCornerRadius, _groupBorderCornerRadius);
                contentViewFrame.origin.y += groupBorderWidth;
                contentViewFrame.size.height -= (groupBorderWidth + groupBorderWidth);
                break;
            default:
                assert(0);
                break;
        }
        self.contentView.frame = contentViewFrame;
        _groupBorderLayer.path = path;
        CGPathRelease(path);
        CGFloat seperatorHeight = [[self class] seperatorHeight];
        _seperatorLayer.frame = CGRectMake(kSeperatorHPadding, CGRectGetHeight(contentViewFrame) - seperatorHeight, CGRectGetWidth(self.bounds) - kSeperatorHPadding - kSeperatorHPadding, seperatorHeight);
    } else if (!_seperatorLayer.hidden) {
        CGRect contentViewFrame = CGRectInset(self.bounds, kSeperatorHPadding, 0);
        CGFloat seperatorHeight = [[self class] seperatorHeight];
        _seperatorLayer.frame = CGRectMake(kSeperatorHPadding, CGRectGetHeight(contentViewFrame) - seperatorHeight, CGRectGetWidth(self.bounds) - kSeperatorHPadding - kSeperatorHPadding, seperatorHeight);
    }
}

- (void)prepareForReuse {
    _groupBorderLayer.hidden = YES;
    _seperatorLayer.hidden = YES;
    _groupBorderLayer.path = nil;
}

- (UITableView *)tableView {
    for (UIView *view = [self superview]; view != nil; view = [view superview]) {
        if ([view isKindOfClass:[UITableView class]]) {
            return (UITableView *)view;
        }
    }
    return nil;
}

@end
