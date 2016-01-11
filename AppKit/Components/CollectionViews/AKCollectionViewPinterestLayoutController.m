//
//  AKCollectionViewPinterestLayoutController.m
//  AppKit
//
//  Created by Zijiao Liu on 1/11/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKCollectionViewPinterestLayout.h"
#import "AKCollectionViewPinterestLayoutController.h"


@implementation AKCollectionViewPinterestLayoutController

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.collectionView.collectionViewLayout = [[AKCollectionViewPinterestLayout alloc] initWithDelegate:self];
    }
    return self;
}

# pragma mark - AKCollectionViewPinterestLayoutDelegate

- (CGFloat)collectionView:(nonnull UICollectionView *)collectionView heightForItemAtIndexPath:(nonnull NSIndexPath *)indexPath withWidth:(CGFloat)width {
    return 100;
}

- (CGFloat)collectionView:(nonnull UICollectionView *)collectionView heightForAnnotationAtIndexPath:(nonnull NSIndexPath *)indexPath withWidth:(CGFloat)width {
    return 50;
}


@end
