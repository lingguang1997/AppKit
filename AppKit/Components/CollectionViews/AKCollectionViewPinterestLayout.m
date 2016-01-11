//
//  AKCollectionViewPinterestLayout.m
//  AppKit
//
//  Created by Zijiao Liu on 1/10/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKCollectionViewPinterestLayout.h"

static NSInteger const kNumberOfColumns = 2;
static CGFloat const kCellPadding = 6;

@implementation AKCollectionViewPinterestLayoutAttributes

- (id)copyWithZone:(NSZone *)zone {
    AKCollectionViewPinterestLayoutAttributes *copy = [super copyWithZone:zone];
    copy.itemHeight = _itemHeight;
    return copy;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[AKCollectionViewPinterestLayoutAttributes class]]) {
        AKCollectionViewPinterestLayoutAttributes *attributes = (AKCollectionViewPinterestLayoutAttributes *)object;
        if (attributes.itemHeight == _itemHeight) {
            return [super isEqual:object];
        }
    }
    return false;
}

@end


@interface AKCollectionViewPinterestLayout ()

@property (nonatomic, nullable) NSMutableArray<AKCollectionViewPinterestLayoutAttributes *> *attributesCache;
@property (nonatomic) CGFloat contentHeight;
@property (nonatomic) CGFloat contentWidth;

@end

@implementation AKCollectionViewPinterestLayout

- (instancetype)initWithDelegate:(id<AKCollectionViewPinterestLayoutDelegate>)delegate {
    self = [self init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.attributesCache = [NSMutableArray array];
    }
    return self;
}


- (void)prepareLayout {
    if (!_attributesCache.count) {
        CGFloat columnWidth = self.contentWidth / self.numberOfColumns;
        CGFloat yOffset[self.numberOfColumns];
        for (NSInteger i = 0; i < self.numberOfColumns; i++) {
            yOffset[i] = 0;
        }
        for (NSInteger itemIndex = 0; itemIndex < [self.collectionView numberOfItemsInSection:0]; itemIndex++) {
            NSInteger column = itemIndex % self.numberOfColumns;
            CGFloat xOffset = columnWidth * column;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];
            CGFloat itemWidth = columnWidth - kCellPadding * 2;
            CGFloat itemHeight = [_delegate collectionView:self.collectionView heightForItemAtIndexPath:indexPath withWidth:itemWidth];
            CGFloat annotationHeight = [_delegate collectionView:self.collectionView heightForAnnotationAtIndexPath:indexPath withWidth:itemWidth];
            CGFloat totalHeight = kCellPadding + itemHeight + annotationHeight + kCellPadding;
            CGRect frame = CGRectMake(xOffset, yOffset[column], columnWidth, totalHeight);
            CGRect insetFrame = CGRectInset(frame, kCellPadding, kCellPadding);

            AKCollectionViewPinterestLayoutAttributes *attributes = [AKCollectionViewPinterestLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.itemHeight = itemHeight;
            attributes.frame = insetFrame;
            [_attributesCache addObject:attributes];

            _contentHeight = MAX(_contentHeight, CGRectGetMaxY(frame));
            yOffset[column] += totalHeight;
        }
    }
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.contentWidth, _contentHeight);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<AKCollectionViewPinterestLayoutAttributes *> *layoutAttributes = [NSMutableArray array];
    [_attributesCache enumerateObjectsUsingBlock:^(AKCollectionViewPinterestLayoutAttributes * _Nonnull attributes, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [layoutAttributes addObject:attributes];
        }
        [layoutAttributes addObject:attributes];
    }];
    return layoutAttributes;
}

- (NSInteger)numberOfColumns {
    if (!_numberOfColumns) {
        return kNumberOfColumns;
    }
    assert(self.contentWidth / _numberOfColumns - kCellPadding * 2 > 0);
    return _numberOfColumns;
}

- (CGFloat)contentWidth {
    UIEdgeInsets insets = self.collectionView.contentInset;
    return CGRectGetWidth(self.collectionView.bounds) - insets.left - insets.right;
}

@end
