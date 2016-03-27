//
//  AKCollectionViewPinterestLayout.h
//  AppKit
//
//  Created by Zijiao Liu on 1/10/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AKCollectionViewPinterestLayoutDelegate <NSObject>

- (CGFloat)collectionView:(nonnull UICollectionView *)collectionView heightForItemAtIndexPath:(nonnull NSIndexPath *)indexPath withWidth:(CGFloat)width;

- (CGFloat)collectionView:(nonnull UICollectionView *)collectionView heightForAnnotationAtIndexPath:(nonnull NSIndexPath *)indexPath withWidth:(CGFloat)width;

@end


@interface AKCollectionViewPinterestLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic) CGFloat itemHeight;

@end

@interface AKCollectionViewPinterestLayout : UICollectionViewLayout

@property (nonatomic, weak, nullable) id<AKCollectionViewPinterestLayoutDelegate> delegate;
@property (nonatomic) NSInteger numberOfColumns;

- (nonnull instancetype)initWithDelegate:(nonnull id<AKCollectionViewPinterestLayoutDelegate>)delegate;

@end
