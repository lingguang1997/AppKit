//
//  AKCollectionViewLineLayout.m
//  AppKit
//
//  Created by Zijiao Liu on 1/11/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKCollectionViewLineLayout.h"

static CGFloat const kZoomFactor = .3;
static CGFloat const kActiveDistance = 200;

@implementation AKCollectionViewLineLayout

- (instancetype)initWithDelegate:(id<AKCollectionViewLineLayoutDelegate>)delegate {
    self = [self init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _zoomAllowed = NO;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = self.collectionView.bounds.size;
}

- (CGFloat)zoomFactor {
    if (_zoomFactor < .1) {
        return kZoomFactor;
    }
    return _zoomFactor;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];

    if (_zoomAllowed) {
        CGRect visibleRect;
        visibleRect.origin = self.collectionView.contentOffset;
        visibleRect.size = self.collectionView.bounds.size;
        
        [layoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull attributes, NSUInteger idx, BOOL * _Nonnull stop) {
            if (CGRectIntersectsRect(attributes.frame, rect)) {
                CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
                CGFloat normalizedDistance = distance / kActiveDistance;
                
                if (ABS(distance) < kActiveDistance) {
                    CGFloat zoom = 1 + kZoomFactor * (1 - ABS(normalizedDistance));
                    attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1);
                    attributes.zIndex = 1;
                }
            }
        }];
    }

    return layoutAttributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    __block CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + CGRectGetWidth(self.collectionView.bounds) / 2;

    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:targetRect];

    [layoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *  _Nonnull attributes, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat itemHorizontalCenter = attributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }];

    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end
