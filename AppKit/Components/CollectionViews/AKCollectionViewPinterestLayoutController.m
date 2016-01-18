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

- (instancetype)init {
    self = [super init];
    if (self) {
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[AKCollectionViewPinterestLayout alloc] initWithDelegate:self]];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
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
